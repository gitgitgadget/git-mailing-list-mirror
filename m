From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] Makefile: apply dependencies consistently to sparse/asm
 targets
Date: Tue, 19 Jun 2012 15:52:55 -0400
Message-ID: <20120619195255.GA14714@sigill.intra.peff.net>
References: <20120619195229.GA14692@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jun 19 21:53:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh4U0-0006SO-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 21:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab2FSTw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 15:52:58 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:32948
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650Ab2FSTw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 15:52:57 -0400
Received: (qmail 12723 invoked by uid 107); 19 Jun 2012 19:52:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 15:52:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 15:52:55 -0400
Content-Disposition: inline
In-Reply-To: <20120619195229.GA14692@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200233>

When a C file includes a header file or depends on a
command-line "-D" macro, we note it in the Makefile like:

  git.o: common-cmds.h

However, other targets built from the C file should also
know about this dependency (in particular, .sp and .s files
that are not part of the usual build process). We sometimes
noted these and sometimes not; let's make sure they are
always included.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 62de0b4..537d2ea 100644
--- a/Makefile
+++ b/Makefile
@@ -1972,7 +1972,7 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
-git.o: common-cmds.h
+git.sp git.s git.o: common-cmds.h
 git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
@@ -1982,9 +1982,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.sp help.o: common-cmds.h
+help.sp help.s help.o: common-cmds.h
 
-builtin/help.sp builtin/help.o: common-cmds.h
+builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
-- 
1.7.11.rc3.5.g201460b
