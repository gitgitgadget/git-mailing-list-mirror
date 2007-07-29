From: David Kastrup <dak@gnu.org>
Subject: [PATCH] Makefile: create an install-symlinks target
Date: Sun, 29 Jul 2007 23:26:08 +0200
Organization: Organization?!?
Message-ID: <85lkcyvr4f.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 23:26:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFGHk-00039V-NF
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 23:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935906AbXG2V0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 17:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935872AbXG2V0m
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 17:26:42 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:57022 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935777AbXG2V0l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 17:26:41 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 95C271E57BB
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 23:26:39 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 75C18212FB6
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 23:26:39 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 454A98C466
	for <git@vger.kernel.org>; Sun, 29 Jul 2007 23:26:39 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 801411C39595; Sun, 29 Jul 2007 23:26:08 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3808/Sun Jul 29 22:05:04 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54138>

[commit text mostly pinched from INSTALL]

An alternative global installation method making it much easier to
uninstall is to use a package-specific prefix like /opt/git, then
create symlinks from /usr/local into that hierarchy.  Uninstalling can
then be achieved by

	# rm -rf /opt/git; find /usr/local -xtype l -delete

You can create a setup like that after having used one of the above
install recipes with prefix=/opt/git by writing

	# make prefix=/opt/git symlinkprefix=/usr/local install-symlinks

This works by copying the directory hierarchy of $prefix to
$symlinkprefix (not copying or descending to any directories of the
name git* matched case-insensitively), then linking all the rest.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 INSTALL  |   12 ++++++++++++
 Makefile |   10 +++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/INSTALL b/INSTALL
index 79e71b6..22df145 100644
--- a/INSTALL
+++ b/INSTALL
@@ -21,6 +21,18 @@ set up install paths (via config.mak.autogen), so you can write instead
 	$ make all doc ;# as yourself
 	# make install install-doc ;# as root
 
+An alternative global installation method making it much easier to
+uninstall is to use a package-specific prefix like /opt/git, then
+create symlinks from /usr/local into that hierarchy.  Uninstalling can
+then be achieved by
+
+	# rm -rf /opt/git; find /usr/local -xtype l -delete
+
+You can create a setup like that after having used one of the above
+install recipes with prefix=/opt/git by writing
+
+	# make prefix=/opt/git symlinkprefix=/usr/local install-symlinks
+
 
 Issues of note:
 
diff --git a/Makefile b/Makefile
index 73b487f..87b317f 100644
--- a/Makefile
+++ b/Makefile
@@ -142,6 +142,7 @@ ALL_LDFLAGS = $(LDFLAGS)
 STRIP ?= strip
 
 prefix = $(HOME)
+symlinkprefix = /usr/local
 bindir = $(prefix)/bin
 gitexecdir = $(bindir)
 sharedir = $(prefix)/share
@@ -692,6 +693,7 @@ bindir_SQ = $(subst ','\'',$(bindir))
 gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
 template_dir_SQ = $(subst ','\'',$(template_dir))
 prefix_SQ = $(subst ','\'',$(prefix))
+symlinkprefix_SQ = $(subst ','\'',$(symlinkprefix))
 
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
@@ -996,7 +998,13 @@ install-doc:
 quick-install-doc:
 	$(MAKE) -C Documentation quick-install
 
-
+# The somewhat strange looking lines start with an ignored $(MAKE) in
+# order to be executed also in make -n calls.
+install-symlinks:
+	@: $(MAKE) && echo cd '$(prefix_SQ)' && cd '$(prefix_SQ)' && find . -type d ! \( -iname 'git*' -prune \) -exec echo $(INSTALL) -m 755 -d '$(symlinkprefix_SQ)/{}' \;
+	@cd '$(prefix_SQ)' && find . -type d ! \( -iname 'git*' -prune \) -exec $(INSTALL) -m 755 -d '$(symlinkprefix_SQ)/{}' \;
+	@: $(MAKE) && echo cd '$(prefix_SQ)' && cd '$(prefix_SQ)' && find . \( -type d -iname 'git*' -prune -o ! -type d \) -exec echo $(RM) -r '$(symlinkprefix_SQ)/{}' \; -exec echo ln -s '$(prefix_SQ)/{}' '$(symlinkprefix_SQ)/{}' \;
+	@cd '$(prefix_SQ)' && find . \( -type d -iname 'git*' -prune -o ! -type d \) -exec $(RM) -r '$(symlinkprefix_SQ)/{}' \; -exec ln -s '$(prefix_SQ)/{}' '$(symlinkprefix_SQ)/{}' \;
 
 ### Maintainer's dist rules
 
-- 
1.5.3.rc2.84.g6497
