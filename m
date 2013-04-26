From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] t/Makefile: remove smoke test targets
Date: Fri, 26 Apr 2013 18:58:24 +0100
Message-ID: <dd20490a6d7911e0e0814fbe2eee0cfea1faa4e5.1366999104.git.john@keeping.me.uk>
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 19:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVmv4-0007Rk-Vw
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 19:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770Ab3DZR6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 13:58:46 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:43080 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457Ab3DZR6p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 13:58:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 050A460650C;
	Fri, 26 Apr 2013 18:58:44 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NMmsaIDfOIxD; Fri, 26 Apr 2013 18:58:42 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id BB3E7198005;
	Fri, 26 Apr 2013 18:58:36 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.715.gb260f47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222546>

Commit d24fbca (Remove Git's support for smoke testing - 2011-12-23)
removed the smoke test support from the test suite but it was re-added
by commit 342e9ef (Introduce a performance testing framework -
2012-02-17).  This appears to be the result of a mis-merge, since
re-adding the smoke testing infrastructure does not relate to the
subject of that commit.

The current 'smoke' target is broken since the 'harness' script it
uses no longer exists, so just reapply this section of commit d24fbca
and remove all of the smoke testing section in the makefile.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/Makefile | 38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 1923cc1..44ca7d3 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -83,42 +83,4 @@ valgrind:
 perf:
 	$(MAKE) -C perf/ all
 
-# Smoke testing targets
--include ../GIT-VERSION-FILE
-uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo unknown')
-uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo unknown')
-
-test-results:
-	mkdir -p test-results
-
-test-results/git-smoke.tar.gz: test-results
-	'$(PERL_PATH_SQ)' ./harness \
-		--archive="test-results/git-smoke.tar.gz" \
-		$(T)
-
-smoke: test-results/git-smoke.tar.gz
-
-SMOKE_UPLOAD_FLAGS =
-ifdef SMOKE_USERNAME
-	SMOKE_UPLOAD_FLAGS += -F username="$(SMOKE_USERNAME)" -F password="$(SMOKE_PASSWORD)"
-endif
-ifdef SMOKE_COMMENT
-	SMOKE_UPLOAD_FLAGS += -F comments="$(SMOKE_COMMENT)"
-endif
-ifdef SMOKE_TAGS
-	SMOKE_UPLOAD_FLAGS += -F tags="$(SMOKE_TAGS)"
-endif
-
-smoke_report: smoke
-	curl \
-		-H "Expect: " \
-		-F project=Git \
-		-F architecture="$(uname_M)" \
-		-F platform="$(uname_S)" \
-		-F revision="$(GIT_VERSION)" \
-		-F report_file=@test-results/git-smoke.tar.gz \
-		$(SMOKE_UPLOAD_FLAGS) \
-		http://smoke.git.nix.is/app/projects/process_add_report/1 \
-	| grep -v ^Redirecting
-
 .PHONY: pre-clean $(T) aggregate-results clean valgrind perf
-- 
1.8.2.1.715.gb260f47
