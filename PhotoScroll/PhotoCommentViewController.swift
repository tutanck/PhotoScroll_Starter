import UIKit

class PhotoCommentViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTextField: UITextField!
  
  var photoName: String?
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let photoName = photoName {
      self.imageView.image = UIImage(named: photoName)
    }
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(PhotoCommentViewController.keyboardWillShow(_:)),
      name: Notification.Name.UIKeyboardWillShow,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(PhotoCommentViewController.keyboardWillHide(_:)),
      name: Notification.Name.UIKeyboardWillHide,
      object: nil
    )
    
  }
  
  func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
    let userInfo = notification.userInfo ?? [:]
    let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : -1)
    print(scrollView.contentInset)
    print(scrollView.contentInset.bottom)
    scrollView.contentInset.bottom += adjustmentHeight
    scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
  }
  
  @objc func keyboardWillShow(_ notification: Notification) {
    adjustInsetForKeyboardShow(true, notification: notification)
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    adjustInsetForKeyboardShow(false, notification: notification)
  }
  
  
  @IBAction func hideKeyboard(_ sender: AnyObject) {
    nameTextField.endEditing(true)
  }
  
}
