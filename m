From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH resend] Only run aggregate-results over actual counts
Date: Fri, 16 Jul 2010 11:37:44 +0200
Message-ID: <3ce03e702e005a978d3229fa74860d6529296921.1279272868.git.trast@student.ethz.ch>
References: <AANLkTil4HfoMPD4ds0uXRPruYrz4CtpAy-4TfEk0E_yT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 11:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZhQV-0007Gn-H2
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 11:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793Ab0GPJhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jul 2010 05:37:46 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:43296 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936126Ab0GPJhq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jul 2010 05:37:46 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 16 Jul
 2010 11:37:44 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 16 Jul
 2010 11:37:44 +0200
X-Mailer: git-send-email 1.7.2.rc3.259.g43154
In-Reply-To: <AANLkTil4HfoMPD4ds0uXRPruYrz4CtpAy-4TfEk0E_yT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151137>

The current make target 'aggregate-results' scanned all files matching
test-results/t*-*.  Normally these are only the test counts (and the
exit values, which are ignored), but with --tee the suite also dumps
all output.  Furthermore, with --verbose t1450 contains several lines
starting with "broken link from ..." which matches the criteria used
by aggregate-results.sh.

Rename the counts output files to *.counts, and only scan those.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Acked-by: Sverre Rabbelier <srabbelier@gmail.com>
---
 t/Makefile    |    2 +-
 t/test-lib.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index f9de24b..cf5f9e2 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -36,7 +36,7 @@ aggregate-results-and-cleanup: $(T)
 	$(MAKE) clean
 
 aggregate-results:
-	for f in test-results/t*-*; do \
+	for f in test-results/t*-*.counts; do \
 		echo "$$f"; \
 	done | '$(SHELL_PATH_SQ)' ./aggregate-results.sh
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac496aa..83a5a84 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -635,7 +635,7 @@ test_done () {
 	GIT_EXIT_OK=t
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
-	test_results_path="$test_results_dir/${0%.sh}-$$"
+	test_results_path="$test_results_dir/${0%.sh}-$$.counts"
 
 	echo "total $test_count" >> $test_results_path
 	echo "success $test_success" >> $test_results_path
-- 
1.7.2.rc3.259.g43154
