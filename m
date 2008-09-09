From: vanicat@debian.org (=?utf-8?Q?R=C3=A9mi?= Vanicat)
Subject: Re: [PATCH] git.el: Add "git grep" functionality in a grep-style compilation buffer
Date: Tue, 09 Sep 2008 16:51:47 +0200
Message-ID: <87d4jdcqyk.dlv@maison.homelinux.org>
References: <1220122523-68561-1-git-send-email-david@endpoint.com>
	<871vzt8ydp.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, julliard@winehq.org,
	David Christensen <david@endpoint.com>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Sep 09 17:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd4q6-0007XM-J2
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 17:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbYIIPHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Sep 2008 11:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbYIIPHu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 11:07:50 -0400
Received: from fb2.tech.numericable.fr ([82.216.111.50]:52965 "EHLO
	fb2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYIIPHt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Sep 2008 11:07:49 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Sep 2008 11:07:48 EDT
Received: from smtp2.tech.numericable.fr (smtp2.nc.sdv.fr [10.0.0.36])
	by fb2.tech.numericable.fr (Postfix) with ESMTP id AD1F61B944C
	for <git@vger.kernel.org>; Tue,  9 Sep 2008 16:54:17 +0200 (CEST)
Received: from maison.homelinux.org (ip-210.net-89-3-222.rev.numericable.fr [89.3.222.210])
	by smtp2.tech.numericable.fr (Postfix) with ESMTP id 2F71218D804;
	Tue,  9 Sep 2008 16:52:38 +0200 (CEST)
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <vanicat.remi@neuf.fr>)
	id 1Kd4ZH-0003AV-NR; Tue, 09 Sep 2008 16:51:48 +0200
In-Reply-To: <871vzt8ydp.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of "Tue\, 09 Sep 2008 11\:25\:06 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: vanicat.remi@neuf.fr
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,NO_RELAYS
	autolearn=ham version=3.2.5
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95395>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>
Subject: [PATCH] [PATCH] git.el: Add a git-grep command

This allows easy access to git grep from Emacs.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Tested-by: R=C3=A9mi Vanicat <vanicat@debian.org>
---
David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> David Christensen <david@endpoint.com> writes:
>
>> Signed-off-by: David Christensen <david@endpoint.com>
>
> I posted a longer version of git-grep that built on the grep commands
> in Emacs 22 a while ago. It gives you a better was to navigate to the
> hits etc. I'll dig it up again.

Was it this one ?

--=20
R=C3=A9mi Vanicat
 contrib/emacs/git.el |   52 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index c1cf1cb..57351a5 100644
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
+       (list (read-from-minibuffer "Run: " "git grep "
+                                   nil nil 'git-grep-history)
+             nil))
+       (t (let* ((regexp (grep-read-regexp))
+                (files (grep-read-files regexp))
+                (dir (read-directory-name "Base directory: "
+                                          nil default-directory t)))
+           (list regexp files dir)))))
+    (when (and (stringp regexp) (> (length regexp) 0))
+      (if (null files)
+         (if (not (string=3D regexp grep-find-command))
+             (compilation-start regexp 'grep-mode))
+         (setq dir (file-name-as-directory (expand-file-name dir)))
+         (let ((command (concat
+                         "git grep -n "
+                         "-e " (shell-quote-argument regexp)
+                         (if (string=3D files "*")
+                             ""
+                             (concat " -- " (shell-quote-argument file=
s))))))
+           (when command
+             (if current-prefix-arg
+                 (setq command
+                       (read-from-minibuffer "Confirm: "
+                                             command nil nil 'git-grep=
-history))
+                 (add-to-history 'git-grep-history command))
+             (let ((default-directory dir))
+               (compilation-start (concat "PAGER=3D " command) 'grep-m=
ode))
+             ;; Set default-directory if we started rgrep in the *grep=
* buffer.
+             (if (eq next-error-last-buffer (current-buffer))
+                 (setq default-directory dir))))))))
+
 (provide 'git)
 ;;; git.el ends here
--=20
1.6.0.1.183.gb8d57
