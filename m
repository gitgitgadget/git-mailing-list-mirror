From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Link git-gui into the master Makefile.
Date: Mon, 12 Feb 2007 18:20:34 -0500
Message-ID: <20070212232034.GA31152@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 00:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGkTU-0004LB-2R
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 00:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbXBLXUk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 18:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbXBLXUk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 18:20:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45043 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030472AbXBLXUj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 18:20:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGkTD-0005wo-IQ; Mon, 12 Feb 2007 18:20:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 148D020FBAE; Mon, 12 Feb 2007 18:20:34 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39453>

I'm exporting gitexecdir because git-gui wants to know where
it should install git-gui and git-citool.  These belong under
gitexecdir, just like git-diff, as the git wrapper is able to
invoke these commands for the end-user.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This change assumes gitgui-0.6.0 or later is merged.  I would
 suggest merging it first, then applying this patch.

 Makefile |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5d31e6d..40bdcff 100644
--- a/Makefile
+++ b/Makefile
@@ -602,7 +602,7 @@ LIB_OBJS += $(COMPAT_OBJS)
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
-export prefix TAR INSTALL DESTDIR SHELL_PATH template_dir
+export prefix gitexecdir TAR INSTALL DESTDIR SHELL_PATH template_dir
 
 
 ### Build rules
@@ -613,6 +613,7 @@ ifneq (,$X)
 endif
 
 all::
+	$(MAKE) -C git-gui all
 	$(MAKE) -C perl PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(MAKE) -C templates
 
@@ -843,6 +844,7 @@ install: all
 	$(INSTALL) git$X gitk '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' install
+	$(MAKE) -C git-gui install
 	if test 'z$(bindir_SQ)' != 'z$(gitexecdir_SQ)'; \
 	then \
 		ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' \
@@ -876,8 +878,11 @@ dist: git.spec git-archive
 	@mkdir -p $(GIT_TARNAME)
 	@cp git.spec $(GIT_TARNAME)
 	@echo $(GIT_VERSION) > $(GIT_TARNAME)/version
+	@$(MAKE) -C git-gui TARDIR=../$(GIT_TARNAME)/git-gui dist-version
 	$(TAR) rf $(GIT_TARNAME).tar \
-		$(GIT_TARNAME)/git.spec $(GIT_TARNAME)/version
+		$(GIT_TARNAME)/git.spec \
+		$(GIT_TARNAME)/version \
+		$(GIT_TARNAME)/git-gui/version
 	@rm -rf $(GIT_TARNAME)
 	gzip -f -9 $(GIT_TARNAME).tar
 
@@ -918,6 +923,7 @@ clean:
 	rm -f gitweb/gitweb.cgi
 	$(MAKE) -C Documentation/ clean
 	$(MAKE) -C perl clean
+	$(MAKE) -C git-gui clean
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 	rm -f GIT-VERSION-FILE GIT-CFLAGS
-- 
1.5.0.rc4.26.gcc46a
