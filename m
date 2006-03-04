From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 1/5] git.el: Portability fixes for XEmacs and Emacs CVS.
Date: Sat, 04 Mar 2006 17:37:42 +0100
Message-ID: <87k6bakvxl.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 04 17:38:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFZlQ-0007cg-Cy
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 17:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWCDQht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 11:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWCDQht
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 11:37:49 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:9420 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S932105AbWCDQhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 11:37:48 -0500
Received: from adsl-84-227-8-187.adslplus.ch ([84.227.8.187] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FFZlJ-0000im-5e
	for git@vger.kernel.org; Sat, 04 Mar 2006 10:37:47 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id B2A344F90E; Sat,  4 Mar 2006 17:37:42 +0100 (CET)
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
X-SA-Exim-Connect-IP: 84.227.8.187
X-SA-Exim-Mail-From: julliard@winehq.org
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on mail
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	SPF_HELO_SOFTFAIL autolearn=no version=3.0.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.codeweavers.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17184>

Fixed octal constants for XEmacs.
Added highlighting support in log-edit buffer for Emacs CVS.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>

---

 contrib/emacs/git.el |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

7c95060616dd2f596d2f0bc0d707c584002913db
diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 8f23477..5828d4c 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -388,9 +388,9 @@ If not set, fall back to `add-log-mailin
   (propertize
    (if (or (not old-perm)
            (not new-perm)
-           (eq 0 (logand #O111 (logxor old-perm new-perm))))
+           (eq 0 (logand ?\111 (logxor old-perm new-perm))))
        "  "
-     (if (eq 0 (logand #O111 old-perm)) "+x" "-x"))
+     (if (eq 0 (logand ?\111 old-perm)) "+x" "-x"))
   'face 'git-permission-face))
 
 (defun git-fileinfo-prettyprint (info)
@@ -806,7 +806,13 @@ If not set, fall back to `add-log-mailin
          "\n")
         (when (and merge-heads (file-readable-p ".git/MERGE_MSG"))
           (insert-file-contents ".git/MERGE_MSG"))))
-      (log-edit #'git-do-commit nil #'git-log-edit-files buffer)))
+    (let ((log-edit-font-lock-keywords
+           `(("^\\(Author:\\|Date:\\|Parent:\\)\\(.*\\)"
+              (1 font-lock-keyword-face)
+              (2 font-lock-function-name-face))
+             (,(concat "^\\(" (regexp-quote git-log-msg-separator) "\\)$")
+              (1 font-lock-comment-face)))))
+      (log-edit #'git-do-commit nil #'git-log-edit-files buffer))))
 
 (defun git-find-file ()
   "Visit the current file in its own buffer."
@@ -891,7 +897,7 @@ If not set, fall back to `add-log-mailin
     (define-key map "d"    diff-map)
     (define-key map "="   'git-diff-file)
     (define-key map "f"   'git-find-file)
-    (define-key map [RET] 'git-find-file)
+    (define-key map "\r"  'git-find-file)
     (define-key map "g"   'git-refresh-status)
     (define-key map "i"   'git-ignore-file)
     (define-key map "l"   'git-log-file)
-- 
1.2.4.g0040-dirty

-- 
Alexandre Julliard
julliard@winehq.org
