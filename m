From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [PATCH 2/7] git-blame: Change installation instructions
Date: Fri, 09 Feb 2007 09:19:59 +0100
Message-ID: <87zm7npwsw.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 09:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFRIn-0003TM-8O
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 09:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946168AbXBIIkN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Feb 2007 03:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946221AbXBIIkN
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 03:40:13 -0500
Received: from main.gmane.org ([80.91.229.2]:58057 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946168AbXBIIkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 03:40:11 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HFRIY-00086F-Fs
	for git@vger.kernel.org; Fri, 09 Feb 2007 09:40:02 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:40:02 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 09:40:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:qaP3+wDREprv3mGJXBSC+M71JyM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39163>

=46rom: Jakub Narebski <jnareb@gmail.com>

Change installation instructions to using either "(require 'git-blame)"
or appropriate autoload instruction in GNU Emacs init file, .emacs
This required adding "(provide 'git-blame)" at the end of git-blame.el
and adding [preliminary] docstring to `git-blame-mode' function for
consistency (to mark function as interactive in `autoload' we have to
provide docstring as DOCSTRING is third arg, and INTERACTIVE fourth,
and both are optional).  `git-blame-mode' is marked to autoload.

While at it ensure that we add `git-blame-mode' to `minor-mode-alist'
only once (in a way that does not depend on `cl' package).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 contrib/emacs/git-blame.el |   23 +++++++++++++++++++----
 1 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index ba9d8a6..56a548b 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -44,9 +44,20 @@
=20
 ;;; Installation:
 ;;
-;;  1) Load into emacs: M-x load-file RET git-blame.el RET
-;;  2) Open a git-controlled file
-;;  3) Blame: M-x git-blame-mode
+;; To use this package, put it somewhere in `load-path' (or add
+;; directory with git-blame.el to `load-path'), and add the following
+;; line to your .emacs:
+;;
+;;    (require 'git-blame)
+;;
+;; If you do not want to load this package before it is necessary, you
+;; can make use of the `autoload' feature, e.g. by adding to your .ema=
cs
+;; the following lines
+;;
+;;    (autoload 'git-blame-mode "git-blame"
+;;              "Minor mode for incremental blame for Git." t)
+;;
+;; Then first use of `M-x git-blame-mode' would load the package.
=20
 ;;; Compatibility:
 ;;
@@ -102,8 +113,12 @@
=20
 (defvar git-blame-mode nil)
 (make-variable-buffer-local 'git-blame-mode)
-(push (list 'git-blame-mode " blame") minor-mode-alist)
+(unless (assq 'git-blame-mode minor-mode-alist)
+  (setq minor-mode-alist
+	(cons (list 'git-blame-mode " blame")
+	      minor-mode-alist)))
=20
+;;;###autoload
 (defun git-blame-mode (&optional arg)
   (interactive "P")
   (if arg
--=20
1.5.0.rc3.204.g93c76


--=20
David K=C3=A5gedal
