From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 3/3] git.el: Added a function to diff against the other heads in a merge.
Date: Sun, 19 Mar 2006 10:06:10 +0100
Message-ID: <87slpeby7x.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 19 10:06:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKtrh-0006pk-8x
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 10:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWCSJGS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 04:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWCSJGR
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 04:06:17 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:50117 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751443AbWCSJGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Mar 2006 04:06:16 -0500
Received: from adsl-84-226-35-143.adslplus.ch ([84.226.35.143] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FKtrZ-0005Dw-2D
	for git@vger.kernel.org; Sun, 19 Mar 2006 03:06:15 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id CD27B4F657; Sun, 19 Mar 2006 10:06:10 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.226.35.143
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17711>

git-diff-file-merge-head generates a diff against the first merge
head, or with a prefix argument against the nth head. Bound to `d h'
by default.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

92478446cf5718ee76acaced75ff41416329a509
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 5496a1b..ebd00ef 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -767,6 +767,16 @@ The default is to fall back to the git r
     (git-setup-diff-buffer
      (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" "-M" "HEAD" "--" (git-get-filenames files)))))
 
+(defun git-diff-file-merge-head (arg)
+  "Diff the marked file(s) against the first merge head (or the nth one with a numeric prefix)."
+  (interactive "p")
+  (let ((files (git-marked-files))
+        (merge-heads (git-get-merge-heads)))
+    (unless merge-heads (error "No merge in progress"))
+    (git-setup-diff-buffer
+     (apply #'git-run-command-buffer "*git-diff*" "diff-index" "-p" "-M"
+            (or (nth (1- arg) merge-heads) "HEAD") "--" (git-get-filenames files)))))
+
 (defun git-diff-unmerged-file (stage)
   "Diff the marked unmerged file(s) against the specified stage."
   (let ((files (git-marked-files)))
@@ -959,6 +969,7 @@ The default is to fall back to the git r
     (define-key diff-map "=" 'git-diff-file)
     (define-key diff-map "e" 'git-diff-file-idiff)
     (define-key diff-map "E" 'git-find-file-imerge)
+    (define-key diff-map "h" 'git-diff-file-merge-head)
     (define-key diff-map "m" 'git-diff-file-mine)
     (define-key diff-map "o" 'git-diff-file-other)
     (setq git-status-mode-map map)))
-- 
1.2.4.g9c5a7

-- 
Alexandre Julliard
julliard@winehq.org
