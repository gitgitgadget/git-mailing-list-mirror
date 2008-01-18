From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 20:58:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801182055340.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <47908CAF.90101@viscovery.net> <alpine.LSU.1.00.0801181948060.5731@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 18 21:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFyIU-0002wg-Gp
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 21:58:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758983AbYARU6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 15:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761173AbYARU6M
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 15:58:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:51163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757617AbYARU6L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 15:58:11 -0500
Received: (qmail invoked by alias); 18 Jan 2008 20:58:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 18 Jan 2008 21:58:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QarB49LxQgj5ctGblcJVC+cj+IomK/JNX3USbla
	DDgxuHw4Tr8A7F
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0801181948060.5731@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71063>

Hi,

On Fri, 18 Jan 2008, Johannes Schindelin wrote:

> - d6596ed(gitk: Disable msgfmt on MinGW) and
>   004fb4b(Fix renaming .gitk-new to .gitk on Windows if there is already a 
> 	  .gitk)
>   are gitk patches.
> 
>   Further, I think that d6596ed would be better done as an automatic 
>   detection of msgfmt's presence; on my Eee PC, there is no msgfmt 
>   either...

IOW I think something like this:

-- snipsnap --
[PATCH] Fall back to po2msg when msgfmt is unavailable

At least on my Eee PC I do not have msgfmt.

This should be split into two patches, one for git-gui and one for gitk.
---
 git-gui/Makefile  |    6 ++++--
 gitk-git/Makefile |    7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index c109eab..c7921e7 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -193,8 +193,9 @@ $(GITGUI_MAIN): git-gui.sh GIT-VERSION-FILE GIT-GUI-VARS
 	mv $@+ $@
 
 XGETTEXT   ?= xgettext
+PO2MSG = $(TCL_PATH) po/po2msg.sh
 ifdef NO_MSGFMT
-	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
+	MSGFMT ?= $(PO2MSG)
 else
 	MSGFMT ?= msgfmt
 endif
@@ -210,7 +211,8 @@ $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
 update-po:: $(PO_TEMPLATE)
 	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
 $(ALL_MSGFILES): %.msg : %.po
-	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
+	$(QUIET_MSGFMT0)$(MSGFMT) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1) || \
+	$(QUIET_MSGFMT0)$(PO2MSG) --statistics --tcl -l $(basename $(notdir $<)) -d $(dir $@) $< $(QUIET_MSGFMT1)
 
 lib/tclIndex: $(ALL_LIBFILES) GIT-GUI-VARS
 	$(QUIET_INDEX)if echo \
diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index ae2b80b..669ab0e 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -8,6 +8,7 @@ gitk_libdir   ?= $(sharedir)/gitk/lib
 msgsdir    ?= $(gitk_libdir)/msgs
 msgsdir_SQ  = $(subst ','\'',$(msgsdir))
 
+TCL_PATH ?= tclsh
 TCLTK_PATH ?= wish
 INSTALL ?= install
 RM ?= rm -f
@@ -18,8 +19,9 @@ TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 ## po-file creation rules
 XGETTEXT   ?= xgettext
+PO2MSG = $(TCL_PATH) po/po2msg.sh
 ifdef NO_MSGFMT
-	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
+	MSGFMT ?= $(PO2MSG)
 else
 	MSGFMT ?= msgfmt
 endif
@@ -59,5 +61,6 @@ update-po:: $(PO_TEMPLATE)
 	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
 $(ALL_MSGFILES): %.msg : %.po
 	@echo Generating catalog $@
-	$(MSGFMT) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
+	$(MSGFMT) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@) || \
+	$(PO2MSG) --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
 
-- 
1.5.4.rc3.30.g1de144
