From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 3/4] coverage: set DEFAULT_TEST_TARGET to avoid using prove
Date: Mon, 13 May 2013 23:27:27 +0200
Message-ID: <f27a438797cf249ccc3621a580653ea1827033f6.1368479988.git.trast@inf.ethz.ch>
References: <cover.1368479988.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 23:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0Hi-0004uF-Ct
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754479Ab3EMV1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:27:43 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:26569 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753090Ab3EMV1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:27:33 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:29 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224209>

If the user sets DEFAULT_TEST_TARGET=prove in his config.mak, that
carries over into the coverage tests.  Which is really bad if he also
sets GIT_PROVE_OPTS=-j<..> as that completely breaks the coverage
runs.

Instead of attempting to mess with the GIT_PROVE_OPTS, just force the
test target to 'test' so that we run under make, like we intended all
along.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 99e4d09..153d24d 100644
--- a/Makefile
+++ b/Makefile
@@ -2551,7 +2551,7 @@ coverage-compile:
 
 coverage-test: coverage-clean-results coverage-compile
 	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
-		-j1 test
+		DEFAULT_TEST_TARGET=test -j1 test
 
 coverage-report:
 	$(QUIET_GCOV)for dir in $(object_dirs); do \
-- 
1.8.3.rc1.400.g07d6e4a
