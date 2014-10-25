require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:steven)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    patch user_path(@user), user: { username: '',
                                    email: 'foo@invalid',
                                    password: 'foo'}
    assert_template 'users/edit'
  end

  test "successful edit" do
    get edit_user_path(@user)
    name  = "foobar"
    email = "foo@bar.com"
    patch user_path(@user), user: { username: username,
                                    email: email,
                                    password: "" }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name,  name
    assert_equal @user.email, email
  end
end
