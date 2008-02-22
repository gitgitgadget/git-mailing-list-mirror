From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Fri, 22 Feb 2008 12:11:21 +0100
Message-ID: <87d4qpgs9y.dlv@maison.homelinux.org>
References: <87odaa4tcl.fsf@lysator.liu.se>
	<m3myptcqji.fsf@localhost.localdomain> <87tzk19wn5.fsf@lysator.liu.se>
	<200802221121.35706.jnareb@gmail.com> <87ir0h9soh.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Git Mailing List <git@vger.kernel.org>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 22 12:12:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSVpO-00027h-RU
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 12:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552AbYBVLLb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 06:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761920AbYBVLLb
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 06:11:31 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:55471
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753274AbYBVLL3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 06:11:29 -0500
Received: from neuf-infra-smtp-out-sp604012av.neufgp.fr ([84.96.92.115])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id sY891Y0012VLLWC070aK00; Fri, 22 Feb 2008 12:11:26 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604012av.neufgp.fr with neuf telecom
	id sbBR1Y00M20lBGc0C00000; Fri, 22 Feb 2008 12:11:26 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JSVoJ-0001Ik-47; Fri, 22 Feb 2008 12:11:25 +0100
In-Reply-To: <87ir0h9soh.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of "Fri\, 22 Feb 2008 11\:44\:30 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74717>

Here is a modification with inclusion of git-grep only when the grep
library is available.=20

To put it in another file might be a good idea to, but in this case,
may be we could break this huge 1786 file in several smaller file.

=46rom 403143a61bf8f77d042893765b19cf7cc7062e59 Mon Sep 17 00:00:00 200=
1
=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>
Date: Fri, 22 Feb 2008 11:57:25 +0100
Subject: [PATCH] git.el: Add a git-grep command
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

This allows easy access to git grep from Emacs.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
---
 contrib/emacs/git.el |   52 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index f69b697..afaf187 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -49,6 +49,7 @@
 (require 'ewoc)
 (require 'log-edit)
 (require 'easymenu)
+(require 'grep () t)
=20
=20
 ;;;; Customizations
@@ -1496,6 +1497,7 @@ amended version of it."
       ["Diff File" git-diff-file t]
       ["Interactive Diff File" git-diff-file-idiff t]
       ["Log" git-log-file t]
+      ,@(if (featurep 'grep) (list ["Grep" git-grep t]) ())
       "--------"
       ["Mark" git-mark-file t]
       ["Mark All" git-mark-all t]
@@ -1584,5 +1586,55 @@ Meant to be used in `after-save-hook'."
   (interactive)
   (describe-function 'git-status-mode))
=20
+(when (featurep 'grep)
+  (defvar git-grep-history nil)
+
+  (defun git-grep (regexp &optional files dir)
+    "Recursively grep for REGEXP in FILES in directory tree rooted at =
DIR.
+The search is limited to file names matching shell pattern FILES.
+FILES may use abbreviations defined in `grep-files-aliases', e.g.
+entering `ch' is equivalent to `*.[ch]'.
+
+With \\[universal-argument] prefix, you can edit the constructed shell=
 command line
+before it is executed.
+With two \\[universal-argument] prefixes, directly edit and run `git-g=
rep-find-command'.
+
+Collect output in a buffer.  While find runs asynchronously, you
+can use \\[next-error] (M-x next-error), or \\<grep-mode-map>\\[compil=
e-goto-error]
+in the grep output buffer, to go to the lines where grep found matches=
=2E"
+    (interactive
+     (cond
+       ((equal current-prefix-arg '(16))
+	(list (read-from-minibuffer "Run: " "git grep "
+				    nil nil 'git-grep-history)
+	      nil))
+       (t (let* ((regexp (grep-read-regexp))
+		 (files (grep-read-files regexp))
+		 (dir (read-directory-name "Base directory: "
+					   nil default-directory t)))
+	    (list regexp files dir)))))
+    (when (and (stringp regexp) (> (length regexp) 0))
+      (if (null files)
+	  (if (not (string=3D regexp grep-find-command))
+	      (compilation-start regexp 'grep-mode))
+	  (setq dir (file-name-as-directory (expand-file-name dir)))
+	  (let ((command (concat
+			  "git grep -n "
+			  "-e " (shell-quote-argument regexp)
+			  (if (string=3D files "*")
+			      ""
+			      (concat " -- " (shell-quote-argument files))))))
+	    (when command
+	      (if current-prefix-arg
+		  (setq command
+			(read-from-minibuffer "Confirm: "
+					      command nil nil 'git-grep-history))
+		  (add-to-history 'git-grep-history command))
+	      (let ((default-directory dir))
+		(compilation-start (concat "PAGER=3D " command) 'grep-mode))
+	      ;; Set default-directory if we started rgrep in the *grep* buff=
er.
+	      (if (eq next-error-last-buffer (current-buffer))
+		  (setq default-directory dir))))))))
+
 (provide 'git)
 ;;; git.el ends here
--=20
1.5.4.2.191.g7b407



--=20
R=C3=A9mi Vanicat
