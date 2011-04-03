From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH v2] contrib/emacs/git.el: Add user functions for push, pull, fetch
Date: Sun, 03 Apr 2011 19:13:22 +0300
Organization: Private
Message-ID: <87tyef9uu5.fsf@picasso.cante.net>
References: <1300800651-12502-1-git-send-email-jari.aalto@cante.net>
	<d40ef57d7e6d75c41a4d1f8e51bdd892351f3aee.1300804459.git.jari.aalto@cante.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:13:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Pvv-0000pi-7w
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab1DCQNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 12:13:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:50037 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321Ab1DCQNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:13:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q6Pvl-0000mD-Kh
	for git@vger.kernel.org; Sun, 03 Apr 2011 18:13:37 +0200
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 18:13:37 +0200
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 18:13:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:dn9jyfV1CX1Y0RL+CZn0hfxLfX0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170700>

From: Jari Aalto <jari.aalto@cante.net>

Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 contrib/emacs/git.el |   75 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 74 insertions(+), 1 deletions(-)

  [2011-03-22 original message]
  [2011-04-03 This is a ping ...]

  ** This fixes the pull message. The only change is last line:
  ** (message "Pulled from remote: %s" remote)))

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 214930a..1999f0c 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1,6 +1,7 @@
 ;;; git.el --- A user interface for git
 
 ;; Copyright (C) 2005, 2006, 2007, 2008, 2009 Alexandre Julliard <julliard@winehq.org>
+;; Copyright (C) 2010 Jari Aalto <jari.aalto@cante.net>
 
 ;; Version: 1.0
 
@@ -33,11 +34,14 @@
 ;;
 ;; To start: `M-x git-status'
 ;;
+;; RUDIMENTARY
+;; - fetch/pull. Be sure to start gpg-agent, ssh-agent prior emacs
+;;   to access ssh Git remotes.
+;;
 ;; TODO
 ;;  - diff against other branch
 ;;  - renaming files from the status buffer
 ;;  - creating tags
-;;  - fetch/pull
 ;;  - revlist browser
 ;;  - git-show-branch browser
 ;;
@@ -1520,6 +1524,7 @@ amended version of it."
 
 (unless git-status-mode-map
   (let ((map (make-keymap))
+        (remote-map (make-sparse-keymap))
         (commit-map (make-sparse-keymap))
         (diff-map (make-sparse-keymap))
         (toggle-map (make-sparse-keymap)))
@@ -1547,6 +1552,7 @@ amended version of it."
     (define-key map "P"   'git-prev-unmerged-file)
     (define-key map "q"   'git-status-quit)
     (define-key map "r"   'git-remove-file)
+    (define-key map "R"   remote-map)
     (define-key map "t"    toggle-map)
     (define-key map "T"   'git-toggle-all-marks)
     (define-key map "u"   'git-unmark-file)
@@ -1555,6 +1561,13 @@ amended version of it."
     (define-key map "x"   'git-remove-handled)
     (define-key map "\C-?" 'git-unmark-file-up)
     (define-key map "\M-\C-?" 'git-unmark-all)
+    ; remotes
+    (define-key remote-map "\C-a" 'git-push)
+    (define-key remote-map "R" 'git-pull)  ; retrieve "RR"
+    (define-key remote-map "r" 'git-pull)  ; retrieve "Rr" (synonym)
+    (define-key remote-map "p" 'git-push)
+    (define-key remote-map "f" 'git-fetch)
+    (define-key remote-map "\C-a" 'git-fetch)
     ; the commit submap
     (define-key commit-map "\C-a" 'git-amend-commit)
     (define-key commit-map "\C-b" 'git-branch)
@@ -1607,6 +1620,10 @@ amended version of it."
       ["Interactive Diff File" git-diff-file-idiff t]
       ["Log" git-log-file t]
       "--------"
+      ["Push" git-push t]
+      ["Pull" git-pull t]
+      ["Fetch" git-fetch t]
+      "--------"
       ["Mark" git-mark-file t]
       ["Mark All" git-mark-all t]
       ["Unmark" git-unmark-file t]
@@ -1689,6 +1706,62 @@ Meant to be used in `after-save-hook'."
             (git-call-process nil "add" "--refresh" "--" filename)
             (git-update-status-files (list filename))))))))
 
+(defun git-ask-remote (message)
+  "Return remote."
+  (let ((ret
+	 (completing-read
+	  "Push to remote: "
+	  '(("origin" 1))		;FIXME read all remotes
+	  (not 'predicate)
+	  (not 'match)
+	  "origin")))
+    (if (not (string-match "[^ \t]" ret))
+	"origin"
+      ret)))
+
+(defun git-push (&optional remote)
+  "Pull to REMOTE. Use \\[current-prefix-arg] to interactively set REMOTE."
+  (interactive
+   (list (or (and current-prefix-arg
+		  (git-ask-remote "Push to remote: "))
+	     "origin")))
+  ;; FIXME: could colled some status data for display
+  (git-call-process-display-error "push" remote)
+  (git-update-status-files)
+  (message "Pushed to remote: %s" remote))
+
+(defun git-fetch (&optional remote)
+  "Fetch from REMOTE. Use \\[current-prefix-arg] to interactively set REMOTE."
+  (interactive
+   (list (or (and current-prefix-arg
+		  (git-ask-remote "Fetch from remote: "))
+	     "origin")))
+  ;; FIXME: could colled some status data for display
+  (git-call-process-display-error "fetch" remote)
+  (git-update-status-files)
+  (message "Fetched from remote: %s" remote))
+
+(defun git-pull (&optional remote)
+  "Pull from REMOTE. Use \\[current-prefix-arg] to interactively set REMOTE."
+  (interactive
+   (list (or (and current-prefix-arg
+		  (git-ask-remote "Pull from remote: "))
+	     "origin")))
+  (let ((not-clean
+	 (ewoc-collect git-status (lambda (info &optional state)
+				    (setq state (git-fileinfo->state info))
+				    (or (eq state 'modified)
+					(eq state 'added)
+					(eq state 'deleted)
+					(eq state 'unmerged))))))
+    (if not-clean
+	(error "Error: Can't pull while in unclean state (commit all first)."))
+    (unless git-status (error "Not in git-status buffer."))
+    ;; FIXME: could colled some status data for display
+    (git-call-process-display-error "pull" remote)
+    (git-update-status-files)
+    (message "Pulled from remote: %s" remote)))
+
 (defun git-help ()
   "Display help for Git mode."
   (interactive)
