From: Xavier Maillard <zedek@gnu.org>
Subject: [PATCH 7/7] Remove byte-compiler warnings
Date: Sat, 03 Mar 2007 11:20:46 +0100
Message-ID: <15326.1172917246@localhost>
Cc: julliard@winehq.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 11:23:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNROv-0005Jp-6r
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 11:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXCCKXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 05:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXCCKXi
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 05:23:38 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:48048 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbXCCKXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 05:23:37 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp5-g19.free.fr (Postfix) with ESMTP id BB6E771E5;
	Sat,  3 Mar 2007 11:23:36 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l23AKk0J015327;
	Sat, 3 Mar 2007 11:20:46 +0100
X-Mailer: MH-E 8.0.3; nmh 1.2; GNU Emacs 23.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41285>


* emacs/git-blame.el: Do not load cl at run-time. Added several defvar
  to silent byte-compiler.
  Interactive form in git-reblame was not correct, fixed that.

Signed-off-by: Xavier Maillard <zedek@gnu.org>
---
 contrib/emacs/git-blame.el |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 64ad50b..ce029ad 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -77,7 +77,8 @@
 ;;
 ;;; Code:
 
-(require 'cl)			      ; to use `push', `pop'
+(eval-when-compile 
+  (require 'cl))			      ; to use `push', `pop'
 
 (defun color-scale (l)
   (let* ((colors ())
@@ -127,11 +128,22 @@
 
 (defvar git-blame-mode nil)
 (make-variable-buffer-local 'git-blame-mode)
+
+(defvar git-blame-current nil)
+(make-variable-buffer-local 'git-blame-current)
+
+(defvar git-blame-file nil)
+(make-variable-buffer-local 'git-blame-file)
+
+(defvar git-blame-colors nil)
+(make-variable-buffer-local 'git-blame-colors)
+
 (unless (assq 'git-blame-mode minor-mode-alist)
   (setq minor-mode-alist
 	(cons (list 'git-blame-mode " blame")
 	      minor-mode-alist)))
 
+
 ;;;###autoload
 (defun git-blame-mode (&optional arg)
   "Minor mode for displaying Git blame"
@@ -157,9 +169,9 @@
 ;;;###autoload
 (defun git-reblame ()
   "Recalculate all blame information in the current buffer"
+  (interactive)
   (unless git-blame-mode
     (error "git-blame is not active"))
-  (interactive)
   (git-blame-cleanup)
   (git-blame-run))
 
-- 
1.5.0
