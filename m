From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/4] Makefile: remove tracking of TCLTK_PATH
Date: Mon, 17 Dec 2012 08:17:12 +0100
Message-ID: <20121217071716.26209.18070.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:20:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkV02-0004N7-Ok
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 08:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094Ab2LQHUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 02:20:10 -0500
Received: from [194.158.122.56] ([194.158.122.56]:44313 "EHLO mail-1d.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750966Ab2LQHUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 02:20:08 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1d.bbox.fr (Postfix) with ESMTP id 9721ED1;
	Mon, 17 Dec 2012 08:19:46 +0100 (CET)
X-git-sha1: e73d31abf712a6d71e1beae9f370516cb6278671 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211642>

It looks like we are tracking the value of TCLTK_PATH in the main
Makefile for no good reason, as this is done in git-gui too and the
GIT-GUI-VARS is not used in the Makefile.

This patch removes the useless code used to do this tracking.

Maybe this code should have been moved to gitk-git/Makefile by
62ba514 (Move gitk to its own subdirectory, 2007-11-17).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore |  1 -
 Makefile   | 14 +-------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/.gitignore b/.gitignore
index f702415..6d69ae1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,7 +1,6 @@
 /GIT-BUILD-OPTIONS
 /GIT-CFLAGS
 /GIT-LDFLAGS
-/GIT-GUI-VARS
 /GIT-PREFIX
 /GIT-SCRIPT-DEFINES
 /GIT-USER-AGENT
diff --git a/Makefile b/Makefile
index 4ad6fbd..585b2eb 100644
--- a/Makefile
+++ b/Makefile
@@ -2624,18 +2624,6 @@ ifdef GIT_PERF_MAKE_OPTS
 	@echo GIT_PERF_MAKE_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_PERF_MAKE_OPTS)))'\' >>$@
 endif
 
-### Detect Tck/Tk interpreter path changes
-ifndef NO_TCLTK
-TRACK_VARS = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')
-
-GIT-GUI-VARS: FORCE
-	@VARS='$(TRACK_VARS)'; \
-	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo 1>&2 "    * new Tcl/Tk interpreter location"; \
-		echo "$$VARS" >$@; \
-            fi
-endif
-
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
@@ -2910,7 +2898,7 @@ ifndef NO_TCLTK
 	$(MAKE) -C gitk-git clean
 	$(MAKE) -C git-gui clean
 endif
-	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
+	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-BUILD-OPTIONS
 	$(RM) GIT-USER-AGENT GIT-PREFIX GIT-SCRIPT-DEFINES
 
 .PHONY: all install profile-clean clean strip
-- 
1.8.1.rc1.2.g8740035
