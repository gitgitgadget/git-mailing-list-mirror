From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Only run aggregate-results over actual counts
Date: Tue, 15 Jun 2010 23:36:15 +0200
Message-ID: <e10dd00b7a2064c71c9a509e2a7e82c935a60441.1276637243.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 23:37:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOdoz-00087w-59
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 23:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab0FOVga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 17:36:30 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:7416 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503Ab0FOVg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 17:36:29 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 15 Jun
 2010 23:36:27 +0200
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 15 Jun
 2010 23:36:15 +0200
X-Mailer: git-send-email 1.7.1.608.g80d39f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149227>

The current make target 'aggregate-results' scanned all files matching
test-results/t*-*.  Normally these are only the test counts (and the
exit values, which are ignored), but with --tee the suite also dumps
all output.  Furthermore, with --verbose t1450 contains several lines
starting with "broken link from ..." which matches the criteria used
by aggregate-results.sh.

Rename the counts output files to *.counts, and only scan those.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Did this ever work?  Or was just nobody crazy enough to run all tests
with --tee --valgrind?

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
index 37987d7..7e2cd7d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -547,7 +547,7 @@ test_done () {
 	GIT_EXIT_OK=t
 	test_results_dir="$TEST_DIRECTORY/test-results"
 	mkdir -p "$test_results_dir"
-	test_results_path="$test_results_dir/${0%.sh}-$$"
+	test_results_path="$test_results_dir/${0%.sh}-$$.counts"
 
 	echo "total $test_count" >> $test_results_path
 	echo "success $test_success" >> $test_results_path
-- 
1.7.1.608.g80d39f
