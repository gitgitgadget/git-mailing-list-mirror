From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH] stgit.el: Show running commands
Date: Mon, 24 Nov 2008 13:01:36 +0100
Message-ID: <20081124120136.9163.70947.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: kha@treskal.com, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 24 13:03:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4a9o-0007gY-JU
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 13:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbYKXMBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 07:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbYKXMBj
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 07:01:39 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:44908 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbYKXMBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 07:01:38 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 9802B40015;
	Mon, 24 Nov 2008 13:01:33 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 8BA6A40042; Mon, 24 Nov 2008 13:01:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from krank (unknown [87.96.142.81])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 27C3D40015;
	Mon, 24 Nov 2008 13:01:33 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id 974B8DC0AB;
	Mon, 24 Nov 2008 13:01:36 +0100 (CET)
User-Agent: StGIT/0.14.3.278.g6f7d
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101603>


---
 contrib/stgit.el |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/contrib/stgit.el b/contrib/stgit.el
index 65af068..ec08a5b 100644
--- a/contrib/stgit.el
+++ b/contrib/stgit.el
@@ -68,9 +68,15 @@ Argument DIR is the repository path."
            (display-buffer output-buf t)))))
 (put 'stgit-capture-output 'lisp-indent-function 1)
 
-(defun stgit-run (&rest args)
+(defun stgit-run-silent (&rest args)
   (apply 'call-process "stg" nil standard-output nil args))
 
+(defun stgit-run (&rest args)
+  (let ((msgcmd (mapconcat #'identity args " ")))
+    (message "Running stg %s..." msgcmd)
+    (apply 'call-process "stg" nil standard-output nil args)
+    (message "Running stg %s...done" msgcmd)))
+
 (defun stgit-reload ()
   "Update the contents of the stgit buffer"
   (interactive)
@@ -79,8 +85,8 @@ Argument DIR is the repository path."
         (curpatch (stgit-patch-at-point)))
     (erase-buffer)
     (insert "Branch: ")
-    (stgit-run "branch")
-    (stgit-run "series" "--description")
+    (stgit-run-silent "branch")
+    (stgit-run-silent "series" "--description")
     (stgit-rescan)
     (if curpatch
         (stgit-goto-patch curpatch)
@@ -338,7 +344,7 @@ With numeric prefix argument, pop that many patches."
     (set (make-local-variable 'stgit-edit-patch) patch)
     (setq default-directory dir)
     (let ((standard-output edit-buf))
-      (stgit-run "edit" "--save-template=-" patch))))
+      (stgit-run-silent "edit" "--save-template=-" patch))))
 
 (defun stgit-confirm-edit ()
   (interactive)
@@ -402,7 +408,7 @@ With numeric prefix argument, pop that many patches."
     (set (make-local-variable 'stgit-patches) patch-names)
     (setq default-directory dir)
     (let ((standard-output edit-buf))
-      (apply 'stgit-run "coalesce" "--save-template=-" patch-names))))
+      (apply 'stgit-run-silent "coalesce" "--save-template=-" patch-names))))
 
 (defun stgit-confirm-coalesce ()
   (interactive)
