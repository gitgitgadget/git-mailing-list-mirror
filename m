From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 1/3] Makefile: remove tracking of TCLTK_PATH
Date: Tue, 18 Dec 2012 20:00:06 +0100
Message-ID: <20121218190009.29910.84101.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:01:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl2Pg-0002uO-Fq
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 20:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab2LRTAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 14:00:54 -0500
Received: from mail-3d.bbox.fr ([194.158.122.58]:42656 "EHLO mail-3d.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab2LRTAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 14:00:54 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3d.bbox.fr (Postfix) with ESMTP id 344955E;
	Tue, 18 Dec 2012 20:00:53 +0100 (CET)
X-git-sha1: b69a2b4c343c38a062aa7015943c3d1f1ca641db 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211773>

It looks like we are tracking the value of TCLTK_PATH in the main
Makefile for no good reason.

This patch removes the useless code used to do this tracking.

Maybe this code should have been moved to gitk-git/Makefile by
62ba514 (Move gitk to its own subdirectory, 2007-11-17).
A patch to do that has just been sent to Paul Mackerras, the gitk
maintainer.

While at it, this patch removes /gitk-git/gitk-wish from
.gitignore as it should be in /gitk-git/.gitignore and the patch
sent to Paul put it there.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 .gitignore |  2 --
 Makefile   | 14 +-------------
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/.gitignore b/.gitignore
index f702415..64a454b 100644
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
@@ -171,7 +170,6 @@
 /git-whatchanged
 /git-write-tree
 /git-core-*/?*
-/gitk-git/gitk-wish
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
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
