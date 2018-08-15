;; mac keyboard
(setq mac-command-key-is-meta nil
            mac-command-modifier nil)
(setq mac-option-key-is-meta t
            mac-option-modifier 'meta
                  mac-right-option-modifier nil)
(define-key key-translation-map (kbd "M-ñ") (kbd "~"))
(define-key key-translation-map (kbd "M-º") (kbd "\\"))
(define-key key-translation-map (kbd "M-2") (kbd "@"))
(defun tilde () (interactive) (insert "~"))
;(global-set-key "\M-\C-!" 'tilde)   ;; you choose the combo

;; Programming Stuff

;; sml
;; *** set this path to the directory containing "sml-mode-color.el"
(setq sml-mode-dir "~/.emacs.d/elpa/sml-mode-6.8")

;; *** set this path to the sml executable (sml.bat on Windows)
(setq sml-prog-name "/usr/bin/sml")

(add-to-list 'load-path sml-mode-dir)
(setq load-path (cons "~/.emacs.d/elpa/sml-mode-6.8" load-path))
(load "sml-mode-autoloads")
(setenv "PATH" (concat "/usr/bin/sml" (getenv "PATH")))
(setq exec-path (cons "/usr/bin/sml"  exec-path))
(autoload 'sml-mode "sml-mode" "Major mode for editing SML." t)
(autoload 'run-sml "sml-proc" "Run an inferior SML process." t)

;; Make sml-mode conform to CS312 style standards.

(setq sml-indent-level       2)
(setq sml-pipe-indent        -2)
(setq sml-case-indent        t)
(setq sml-nested-if-indent   t)
(setq sml-type-of-indent     nil)       ; JHR style
(setq sml-electric-semi-mode nil)

;;(add-hook 'sml-mode-hook
;;             (lambda ()
;;                    (setq indent-tabs-mode nil)
;;                         (setq sml-indent-args 2)
;;                              (local-set-key (kbd "M-SPC") 'just-one-space)))

(defun my-sml-mode-hook () "Local defaults for SML mode"
      (setq sml-indent-level 2)        ; conserve on horizontal space
             (setq words-include-escape t)    ; \ loses word break status
                    (setq indent-tabs-mode nil))     ; never ever indent with tabs
(add-hook 'sml-mode-hook 'my-sml-mode-hook)

;; turn-off indetation conventions
(defun my-sml-mode-hook ()
      (local-set-key "\t" 'tab-to-tab-stop))
(add-hook 'sml-mode-hook 'my-sml-mode-hook)

;; Packages
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
            `(("gnu"   . "https://elpa.gnu.org/packages/")
                      ("melpa" . "https://melpa.org/packages/")))
(add-to-list 'package-archives
                          '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;; Scheme

;; (set-variable (quote scheme-program-name) "stk")

(setq scheme-program-name  "/usr/bin/scheme")
(require 'xscheme)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(load-theme 'monokai t)
;(load-theme 'gruvbox t)
(require 'solarized)
(provide 'solarized-theme)

(load-theme 'solarized-light t)

;; Verify secure connections
(require 'gnutls)
(require 'tls)
;(if (fboundp 'gnutls-available-p)
;      (fmakunbound 'gnutls-available-p))
(setq gnutls-verify-error t
            tls-checktrust t)
(setq network-security-level 'high)
;; ssl/tsl network manager connection
(setq tls-checktrust t)
(setq gnutls-verify-error t)

(let ((trustfile
               (replace-regexp-in-string
                         "\\\\" "/"
                                 (replace-regexp-in-string
                                            "\n" ""
                                                     (shell-command-to-string "python -m certifi")))))
    (setq tls-program
                  (list
                             (format "gnutls-cli%s --x509cafile %s -p %%p %%h"
                                                      (if (eq window-system 'w32) ".exe" "") trustfile))))
;; Make sure https
`(("gnu" . "https://elpa.gnu.org/packages/")
  ("melpa" . "https://melpa.org/packages/"))
;; Turn on TLS Trust Checking
;;There’s another custom variable in Emacs, tls-checktrust, which checks trust on TLS connections. Go ahead and turn that on, again, via M-x customize-variable tls-checktrust.

;; GUI

;; Font

(set-default-font "Monospace 16" nil t)

;; Line Number
;; on every buffer

(global-linum-mode t)


;; Environment

;; Package Management

;; Start-up Options

;; Splash Screen

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Scroll bar, Tool bar, Menu bar

(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Marking text
;;(delete-selection-mode t)
;;(transient-mark-mode t)
;;(setq x-select-enable-clipboard t)

;; Display Settings

;;I have some modifications to the default display. First, a minor tweak to the frame title. It's also nice to be able to see when a file actually ends. This will put empty line markers into the left hand side.

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Backup files

(setq make-backup-files nil)


;; Ido
;;Ido mode provides a nice way to navigate the filesystem. This is mostly just turning it on. 
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

;; autopair-mode

;; This makes sure that brace structures (), [], {}, etc. are closed as soon as the opening character is typed. 

;(require 'autopair)

;; auto-complete
;; Turn on auto complete. 

;(require 'auto-complete-config)
;(ac-config-default)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(if window-system
;    (load-theme 'solarized-light t)
;  (load-theme 'wombat t))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("cd4d1a0656fee24dc062b997f54d6f9b7da8f6dc8053ac858f15820f9a04a679" default)))
 '(package-selected-packages
   (quote
    (sml-mode spacemacs-theme gruvbox-theme monokai-theme solarized-theme zenburn-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; MIT Scheme
(setq scheme-program-name   "/usr/bin/scheme")

(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; Width and height


(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              ;;(tool-bar-lines . 0)
              (width . 120) ; chars
              ;;(height . 60) ; lines
              ;;(background-color . "honeydew")
              (left . 50)
              (top . 50)))
      (setq default-frame-alist
            '(
              ;;(tool-bar-lines . 0)
              (width . 120)
              ;;(height . 60)
              ;;(background-color . "honeydew")
              (left . 50)
              (top . 50)))))
  ;;(progn
    ;;(setq initial-frame-alist '( (tool-bar-lines . 0)))
    ;;(setq default-frame-alist '( (tool-bar-lines . 0)))))
