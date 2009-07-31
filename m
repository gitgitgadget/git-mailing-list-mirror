From: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH] git.el: Clarify documentation of git-commit-tree
Date: Fri, 31 Jul 2009 09:23:09 +0200
Message-ID: <1249024989-27826-1-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?David=20K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Jul 31 09:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWmyR-0005vE-A3
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 09:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbZGaH4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 03:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbZGaH4L
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 03:56:11 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:38106 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZGaH4K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 03:56:10 -0400
X-Greylist: delayed 1966 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2009 03:56:09 EDT
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id DE95940011;
	Fri, 31 Jul 2009 09:22:49 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id D23304001D; Fri, 31 Jul 2009 09:22:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id ADC6540011;
	Fri, 31 Jul 2009 09:22:49 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 671E0DC302; Fri, 31 Jul 2009 09:23:22 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc3.21.g3b9e
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124509>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---
 contrib/emacs/git.el |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index face333..3a0bda3 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -436,16 +436,19 @@ Each entry is a cons of (SHORT-NAME . FULL-NAME).=
"
     (git-get-string-sha1
      (git-call-process-string-display-error "write-tree"))))
=20
-(defun git-commit-tree (buffer tree head)
-  "Call git-commit-tree with buffer as input and return the resulting =
commit SHA1."
+(defun git-commit-tree (buffer tree parent)
+  "Create a commit and possibly update HEAD.
+Create a commit with the message in BUFFER using the tree with hash TR=
EE.
+Use PARENT as the parent of the new commit. If PARENT is the current \=
"HEAD\",
+update the \"HEAD\" reference to the new commit."
   (let ((author-name (git-get-committer-name))
         (author-email (git-get-committer-email))
         (subject "commit (initial): ")
         author-date log-start log-end args coding-system-for-write)
-    (when head
+    (when parent
       (setq subject "commit: ")
       (push "-p" args)
-      (push head args))
+      (push parent args))
     (with-current-buffer buffer
       (goto-char (point-min))
       (if
@@ -481,7 +484,7 @@ Each entry is a cons of (SHORT-NAME . FULL-NAME)."
               (apply #'git-run-command-region
                      buffer log-start log-end env
                      "commit-tree" tree (nreverse args))))))
-      (when commit (git-update-ref "HEAD" commit head subject))
+      (when commit (git-update-ref "HEAD" commit parent subject))
       commit)))
=20
 (defun git-empty-db-p ()
--=20
1.6.4.rc3.21.g3b9e
