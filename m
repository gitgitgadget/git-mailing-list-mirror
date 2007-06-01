From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make the installation target of git-gui a little less chatty
Date: Sat, 2 Jun 2007 01:09:56 +0200
Message-ID: <20070601230956.GB6360@steel.home>
References: <20070531222527.GB12204@steel.home> <20070601030257.GX7044@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 01:10:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuGGH-00023U-Tt
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 01:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbXFAXKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 19:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbXFAXJ7
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 19:09:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:56559 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbXFAXJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 19:09:58 -0400
Received: from tigra.home (Fa970.f.strato-dslnet.de [195.4.169.112])
	by post.webmailer.de (mrclete mo30) (RZmta 6.8)
	with ESMTP id 9014a0j51Mcu3V ; Sat, 2 Jun 2007 01:09:56 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D9E5E277BD;
	Sat,  2 Jun 2007 01:09:56 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D2840BE86; Sat,  2 Jun 2007 01:09:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070601030257.GX7044@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcNmRtBQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48897>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-gui/Makefile |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index 3de0de1..404bff0 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -2,6 +2,12 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+QUIET =
+QUIET_MSG = :
+ifndef V
+    QUIET = @
+    QUIET_MSG = echo '   '
+endif
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -109,12 +115,14 @@ GIT-GUI-VARS: .FORCE-GIT-GUI-VARS
 all:: $(ALL_PROGRAMS) lib/tclIndex
 
 install: all
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(foreach p,$(GITGUI_BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
-	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(INSTALL) -m644 lib/tclIndex '$(DESTDIR_SQ)$(libdir_SQ)'
-	$(foreach p,$(ALL_LIBFILES), $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(QUIET_MSG)INSTALL git-gui; $(INSTALL) git-gui '$(DESTDIR_SQ)$(gitexecdir_SQ)'
+	$(QUIET)$(foreach p,$(GITGUI_BUILT_INS),$(QUIET_MSG)INSTALL $p;\
+	    rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && \
+	    ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git-gui' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
+	$(QUIET)$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(libdir_SQ)'
+	$(QUIET)$(foreach p,lib/tclIndex $(ALL_LIBFILES), $(QUIET_MSG)INSTALL $p;\
+	    $(INSTALL) -m644 $p '$(DESTDIR_SQ)$(libdir_SQ)' ;)
 
 dist-version:
 	@mkdir -p $(TARDIR)
-- 
1.5.2.162.g8fc0
