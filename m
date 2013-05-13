From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/4] coverage: split build target into compile and test
Date: Mon, 13 May 2013 23:27:25 +0200
Message-ID: <74a63334c1b7cd4c5bb43050dce256e125ca8c8b.1368479988.git.trast@inf.ethz.ch>
References: <cover.1368479988.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 23:27:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0HS-0004k6-8P
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900Ab3EMV1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:27:34 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:26569 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab3EMV1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:27:31 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:28 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:29 +0200
X-Mailer: git-send-email 1.8.3.rc1.400.g07d6e4a
In-Reply-To: <cover.1368479988.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224206>

Confusingly, the coverage-build target in fact builds with gcov
support _and runs tests_.

Split it into two targets that actually are named after what they do.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 Makefile | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0f931a2..f98296b 100644
--- a/Makefile
+++ b/Makefile
@@ -2524,10 +2524,10 @@ check-builtins::
 
 ### Test suite coverage testing
 #
-.PHONY: coverage coverage-clean coverage-build coverage-report
+.PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
 
 coverage:
-	$(MAKE) coverage-build
+	$(MAKE) coverage-test
 	$(MAKE) coverage-report
 
 object_dirs := $(sort $(dir $(OBJECTS)))
@@ -2543,8 +2543,10 @@ COVERAGE_CFLAGS = $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
 COVERAGE_LDFLAGS = $(CFLAGS)  -O0 -lgcov
 GCOVFLAGS = --preserve-paths --branch-probabilities --all-blocks
 
-coverage-build: coverage-clean
+coverage-compile:
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" all
+
+coverage-test: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
 		-j1 test
 
-- 
1.8.3.rc1.400.g07d6e4a
