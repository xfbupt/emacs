;;package
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

(server-start)

;;theme
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/ample-theme-20140917.637")
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/monokai-theme-20140814.556")
(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/solarized-theme-20140923.459")
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/zenburn-theme-20140811.754")
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-sanityinc-solarized-20141205.143")
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-sanityinc-tomorrow-20141205.141")
(require 'color-theme-sanityinc-tomorrow)
(require 'color-theme-sanityinc-solarized)

;;新开一行
(defun my-previous-new-line ()
  (interactive)
 ;; (previous-line)
  (move-end-of-line 0)
  (reindent-then-newline-and-indent))
(defun my-next-new-line ()
  (interactive)
  (move-end-of-line 1)
  (reindent-then-newline-and-indent))
(global-set-key (kbd "C-O") 'my-previous-new-line)
(global-set-key (kbd "C-o") 'my-next-new-line)


(defun jsp-mode () (interactive)
  (multi-mode 1
	      'html-mode
	      '("<%--" indented-text-mode)
	      '("<%@" indented-text-mode)
	      '("<%=" html-mode)
	      '("<%" java-mode)
	      '("%>" html-mode)))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))

;;recent file list
(require 'recentf)

;; save the .recentf file to .emacs.d/
(setq recentf-save-file (concat user-emacs-directory ".recentf"))

;; enable recent files mode.
(recentf-mode t)


;; 50 files ought to be enough.
(setq recentf-max-saved-items 50)

;; 备份功能
(setq backup-directory-alist (quote (("." . "~/Backup/Emacs"))))
(setq version-control t)
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/Backup/Emacs")))
(setq backup-by-copying t)
;;emacs中，改变文件时，默认都会产生备份文件（以~结尾的文件）。可以完全去掉
;;（并不可取），也可以制定备份的方式。这里采用的是，把所有的文件备份都放在一个
;;固定的地方。对于每个备份文件，保留最原始的两个版本和最新的五个版本。
;;并且备份的时候，备份文件是复件，而不是原件。

;;save place in opened files
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory ".save-places"))
(require 'saveplace)

;;half scroll
(require 'view)
(global-set-key (kbd "C-v") 'View-scroll-half-page-forward)
(global-set-key (kbd "M-v") 'View-scroll-half-page-backward)

;;支持emacs和外部程序的粘贴
(setq x-select-enable-clipboard t)

;;以y/n代替yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; 显示列号
(setq column-number-mode t)
(setq line-number-mode t)

;; 显示图片
(auto-image-file-mode t)

;; 光标不闪烁
(blink-cursor-mode 0)

;; org文件默认以indent模式打开
(setq org-startup-indented t)

;; 打开压缩文件时自动解压缩
;; 必须放在session前面
(auto-compression-mode 1)

;; 用一个很大的kill ring. 这样防止我不小心删掉重要的东西
(setq kill-ring-max 200)

; display line number  
(require 'linum)  
(global-linum-mode 1)  

;;外观设置
;;去掉工具栏
(tool-bar-mode 0)
;;去掉菜单栏
;;(menu-bar-mode 0)

(setq scroll-margin 3
      scroll-conservatively 10000)

;;使用C-k删掉指针到改行末的所有东西
(setq-default kill-whole-line t)

;;改变emacs标题栏的标题,显示buffer的名字
(setq frame-title-format "emacs-snapshot@%b")

;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

;;待办事项关闭时增加时间标签
;;(setq org-log-done 'time)
;;待办时间关闭时增加note
(setq org-log-done 'note)

;;打开buffer列表并自动切换到列表窗口
(defun my-list-buffer ()
  (interactive)
  (list-buffers)
  (other-window 1))
;;(global-set-key (kbd "C-x C-b") 'my-list-buffer)  
;;(global-set-key (kbd "C-x C-b") 'ibuffer)  
(global-set-key (kbd "RET") 'reindent-then-newline-and-indent)  

;;重新绑定按键
(global-set-key (kbd "C-x c") 'kill-buffer-and-window)  
(global-set-key (kbd "C-1") 'delete-other-windows)
(defun switch-and-delete-other-windows ()
  (interactive)
  (other-window 1)
  (delete-other-windows))
(global-set-key (kbd "C-2") 'switch-and-delete-other-windows)
(global-set-key (kbd "C-3") 'other-window)

;;书签设定 
(global-set-key [f2] 'list-bookmarks)
(global-set-key [C-f2] 'bookmark-set)

;;(load-file "~/.emacs.d/calendar.el")
(setq diary-file "~/emacs/data/diary")
(setq calendar-remove-frame-by-deleting t)
(setq calendar-week-start-day 1)              ; 每周第一天是周一
(setq mark-diary-entries-in-calendar t)       ; 标记有记录的日子
(setq mark-holidays-in-calendar nil)          ; 标记节假日
(setq view-calendar-holidays-initially nil)   ; 不显示节日列表
(global-set-key (kbd "<f11>") 'calendar)

(global-set-key [f1] 'manual-entry)
(global-set-key [C-f1] 'info )
;;tabbar
;;(load-file "~/.emacs.d/tabbar.el")
(add-to-list 'load-path "~/.emacs.d/elpa/tabbar-20141109.143")
(require 'tabbar)
(tabbar-mode)
;;(global-set-key (kbd "C-x t b") 'tabbar-backward)  
(global-set-key [(meta right)] 'tabbar-forward)  
(global-set-key [(meta left)] 'tabbar-backward)  
;;(global-set-key (kbd "") 'tabbar-backward-group)
;;(global-set-key (kbd "") 'tabbar-forward-group)
(global-set-key (kbd "C-z") 'set-mark-command)  
(global-set-key [(meta g)] 'kill-buffer-and-window)  

;;helm-config
(add-to-list 'load-path "~/.emacs.d/elpa/helm-20150115.2342")
(require 'helm-config)
(setq helm-quick-update                     t ; do not display invisible candidates
      helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-buffers-fuzzy-matching           t ; fuzzy matching buffer names when non--nil
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
(helm-mode 1)
(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)

;;ace-jump-mode
(add-to-list 'load-path "~/.emacs.d/elpa/ace-jump-mode-20140616.115")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-'") 'ace-jump-mode)

;;; Setup undo-tree
(add-to-list 'load-path "~/.emacs.d/elpa/undo-tree-20140509.522")
(require 'undo-tree) 
(global-undo-tree-mode) 
(setq undo-tree-auto-save-history t) 
(setq undo-tree-history-directory-alist `(("." . ,(concat user-emacs-directory "undo")))) 
;;(defadvice undo-tree-make-history-save-file-name 
;;    (after undo-tree activate) 
;;  (setq ad-return-value (concat ad-return-value ".gz")))

(global-set-key (kbd "C-c a") 'org-agenda)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#657b83" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#fdf6e3"))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes (quote ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" default)))
 '(fci-rule-color "#eee8d5")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#cb4b16") (60 . "#b58900") (80 . "#859900") (100 . "#2aa198") (120 . "#268bd2") (140 . "#d33682") (160 . "#6c71c4") (180 . "#dc322f") (200 . "#cb4b16") (220 . "#b58900") (240 . "#859900") (260 . "#2aa198") (280 . "#268bd2") (300 . "#d33682") (320 . "#6c71c4") (340 . "#dc322f") (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
