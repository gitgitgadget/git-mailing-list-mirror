From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Include the objects needed for the builtin functions
 into libgit.a
Date: Sun, 2 Dec 2007 02:54:47 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712020254370.27959@racer.site>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
 <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src>
 <7v8x4jb295.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
 <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
 <alpine.LFD.0.99999.0711290905510.9605@xanadu.home> <7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
 <DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
 <Pine.LNX.4.64.0711301207020.27959@racer.site> <7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712010959180.27959@racer.site> <7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712012300440.27959@racer.site> <Pine.LNX.4.64.0712012314190.27959@racer.site>
 <Pine.LNX.4.64.0712020146240.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 03:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyezX-0007Vo-70
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 03:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbXLBCzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 21:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbXLBCzJ
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 21:55:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:41508 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753732AbXLBCzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 21:55:07 -0500
Received: (qmail invoked by alias); 02 Dec 2007 02:55:05 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp020) with SMTP; 02 Dec 2007 03:55:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lb64jvFplyzid7fb6VpgK1vFAHwQqJdzz11ihil
	u0H1AAUUj3Dods
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712020146240.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66750>


For the upcoming change in execv_git_cmd() to call builtin functions
directly, it is necessary to be able to access the builtins, so
move the corresponding objects into libgit.a.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index f000a5e..f9a62eb 100644
--- a/Makefile
+++ b/Makefile
@@ -314,7 +314,8 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o \
-	transport.o bundle.o walker.o parse-options.o
+	transport.o bundle.o walker.o parse-options.o \
+	$(BUILTIN_OBJS)
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -785,12 +786,12 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
 git.o: git.c common-cmds.h GIT-CFLAGS
-	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
+	$(QUIET_CC)$(CC) \
 		$(ALL_CFLAGS) -c $(filter %.c,$^)
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
-		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
+		$(ALL_LDFLAGS) $(LIBS)
 
 help.o: common-cmds.h
 
@@ -894,7 +895,10 @@ git.o git.spec \
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
+		-DGIT_EXEC_PATH='"$(gitexecdir_SQ)"' \
+		-DGIT_VERSION='"$(GIT_VERSION)"' \
+		$<
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
 
@@ -920,7 +924,7 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-$(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
+$(LIB_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 builtin-revert.o builtin-runstatus.o wt-status.o: wt-status.h
 
-- 
1.5.3.6.2112.ge2263
