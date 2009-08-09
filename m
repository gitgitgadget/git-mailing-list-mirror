From: Martin Nordholts <enselic@gmail.com>
Subject: [PATCH] git-blame.el: Add `git-blame-show-full-message'
Date: Sun, 09 Aug 2009 16:27:36 +0200
Message-ID: <1249828056.11623.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma9KQ-0003e7-8o
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 16:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013AbZHIOYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 10:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbZHIOYq
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 10:24:46 -0400
Received: from proxy3.bredband.net ([195.54.101.73]:52451 "EHLO
	proxy3.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZHIOYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 10:24:45 -0400
Received: from iph2.telenor.se (195.54.127.133) by proxy3.bredband.net (7.3.140.3)
        id 49F597CD026D035A for git@vger.kernel.org; Sun, 9 Aug 2009 16:24:45 +0200
X-SMTPAUTH-B2: 
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArE3AGh4fkrVcXKrPGdsb2JhbAAImjgBAQEBN6EFkAWEGAWCJw
X-IronPort-AV: E=Sophos;i="4.43,349,1246831200"; 
   d="scan'208";a="34195498"
Received: from c-ab7271d5.017-113-6c756e10.cust.bredbandsbolaget.se (HELO [192.168.1.2]) ([213.113.114.171])
  by iph2.telenor.se with ESMTP; 09 Aug 2009 16:24:45 +0200
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125346>

Add an interactively callable function `git-blame-show-full-message'
that shows the full commit message with --pretty=full in the echo
area.

The purpose of the function is to allow a user of git-blame.el to
browse around in a file until an interesting commit oneliner is shown,
at which point the user can invoke `git-blame-show-full-message' to
get more verbose information.

Signed-off-by: Martin Nordholts <martinn@src.gnome.org>
---
 contrib/emacs/git-blame.el |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 4fa70c5..443ebce 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -40,7 +40,8 @@
 ;; turn it on while viewing a file, the editor buffer will be updated by
 ;; setting the background of individual lines to a color that reflects
 ;; which commit it comes from.  And when you move around the buffer, a
-;; one-line summary will be shown in the echo area.
+;; one-line summary will be shown in the echo area.  To get the complete
+;; commit message, invoke `git-blame-show-full-message'.
 
 ;;; Installation:
 ;;
@@ -340,7 +341,7 @@ See also function `git-blame-mode'."
 			 (git-blame-random-pop git-blame-colors)
 		       git-blame-ancient-color)))
           (setq info (list hash src-line res-line num-lines
-                           (git-describe-commit hash)
+                           (git-describe-commit hash git-blame-log-oneline-format)
                            (cons 'color color))))
         (puthash hash info git-blame-cache))
       (goto-line res-line)
@@ -375,11 +376,11 @@ See also function `git-blame-mode'."
         (car info)
       (error "No commit info"))))
 
-(defun git-describe-commit (hash)
+(defun git-describe-commit (hash pretty-format)
   (with-temp-buffer
     (call-process "git" nil t nil
                   "log" "-1"
-		  (concat "--pretty=" git-blame-log-oneline-format)
+		  (concat "--pretty=" pretty-format)
                   hash)
     (buffer-substring (point-min) (point-max))))
 
@@ -392,6 +393,11 @@ See also function `git-blame-mode'."
       (message "%s" (nth 4 info))
       (setq git-blame-last-identification info))))
 
+(defun git-blame-show-full-message  ()
+  "Show full log message about current commit"
+  (interactive)
+  (message (git-describe-commit (git-blame-current-commit) "full")))
+
 ;; (defun git-blame-after-save ()
 ;;   (when git-blame-mode
 ;;     (git-blame-cleanup)
-- 
1.6.2.5
