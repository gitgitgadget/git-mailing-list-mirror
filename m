From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH 1/3] git-gui/Makefile: Replace libdir with gitgui_libdir
Date: Thu, 6 Sep 2007 03:21:53 +0400
Message-ID: <20070905232153.GA331@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 01:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT4eX-00033R-Px
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 01:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbXIEXvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 19:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbXIEXvP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 19:51:15 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:47151 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106AbXIEXvM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 19:51:12 -0400
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id EC2771B5801C;
	Thu,  6 Sep 2007 03:21:40 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id E5D4D170DB; Thu,  6 Sep 2007 03:21:53 +0400 (MSD)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57778>

On GNU/Linux, libdir is used to mean "/usr/lib or /usr/lib64"
depending on architecture.  Different libdir meaning breaks
idiomatic expressions like rpm specfile "make libdir=%_libdir".

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 git-gui/Makefile |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 1bac6fe..f143b2c 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -76,8 +76,8 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 TCL_PATH_SQ = $(subst ','\'',$(TCL_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
-libdir   ?= $(sharedir)/git-gui/lib
-libdir_SQ = $(subst ','\'',$(libdir))
+gitgui_libdir   ?= $(sharedir)/git-gui/lib
+gitgui_libdir_SQ = $(subst ','\'',$(gitgui_libdir))
 
 exedir    = $(dir $(gitexecdir))share/git-gui/lib
 exedir_SQ = $(subst ','\'',$(exedir))
@@ -85,7 +85,7 @@ exedir_SQ = $(subst ','\'',$(exedir))
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	$(QUIET_GEN)rm -f $@ $@+ && \
 	GITGUI_RELATIVE= && \
-	if test '$(exedir_SQ)' = '$(libdir_SQ)'; then \
+	if test '$(exedir_SQ)' = '$(gitgui_libdir_SQ)'; then \
 		if test "$(uname_O)" = Cygwin; \
 		then GITGUI_RELATIVE= ; \
 		else GITGUI_RELATIVE=1; \
@@ -95,7 +95,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 		-e 's|^ exec wish "$$0"| exec $(subst |,'\|',$(TCLTK_PATH_SQ)) "$$0"|' \
 		-e 's/@@GITGUI_VERSION@@/$(GITGUI_VERSION)/g' \
 		-e 's|@@GITGUI_RELATIVE@@|'$$GITGUI_RELATIVE'|' \
-		-e $$GITGUI_RELATIVE's|@@GITGUI_LIBDIR@@|$(libdir_SQ)|' \
+		-e $$GITGUI_RELATIVE's|@@GITGUI_LIBDIR@@|$(gitgui_libdir_SQ)|' \
 		$@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
@@ -126,7 +126,7 @@ TRACK_VARS = \
 	$(subst ','\'',TCL_PATH='$(TCL_PATH_SQ)') \
 	$(subst ','\'',TCLTK_PATH='$(TCLTK_PATH_SQ)') \
 	$(subst ','\'',gitexecdir='$(gitexecdir_SQ)') \
-	$(subst ','\'',libdir='$(libdir_SQ)') \
+	$(subst ','\'',gitgui_libdir='$(gitgui_libdir_SQ)') \
 #end TRACK_VARS
 
 GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
@@ -142,9 +142,9 @@ install: all
 	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitexecdir_SQ)' $(INSTALL_D1)
 	$(QUIET)$(INSTALL_X0)git-gui $(INSTALL_X1) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS), $(INSTALL_L0)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L1)'$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' $(INSTALL_L2)'$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' $(INSTALL_L3) &&) true
-	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(libdir_SQ)' $(INSTALL_D1)
-	$(QUIET)$(INSTALL_R0)lib/tclIndex $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(libdir_SQ)' &&) true
+	$(QUIET)$(INSTALL_D0)'$(DESTDIR_SQ)$(gitgui_libdir_SQ)' $(INSTALL_D1)
+	$(QUIET)$(INSTALL_R0)lib/tclIndex $(INSTALL_R1) '$(DESTDIR_SQ)$(gitgui_libdir_SQ)'
+	$(QUIET)$(foreach p,$(ALL_LIBFILES), $(INSTALL_R0)$p $(INSTALL_R1) '$(DESTDIR_SQ)$(gitgui_libdir_SQ)' &&) true
 
 dist-version:
 	@mkdir -p $(TARDIR)
-- 
ldv
