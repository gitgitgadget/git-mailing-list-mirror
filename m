From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v6 1/7] tests: test number comes first in 'not ok $count - $message'
Date: Sun, 16 Dec 2012 18:28:09 +0000
Message-ID: <1355682495-22382-2-git-send-email-git@adamspiers.org>
References: <1355682495-22382-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:39:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJ7j-0007bF-A7
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab2LPSjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:39:08 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:41201 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386Ab2LPSi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:38:57 -0500
Received: from localhost (4.8.9.4.4.5.7.d.4.0.6.a.a.2.0.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:b02a:a604:d754:4984])
	by coral.adamspiers.org (Postfix) with ESMTPSA id A85972E5E3
	for <git@vger.kernel.org>; Sun, 16 Dec 2012 18:28:17 +0000 (GMT)
X-Mailer: git-send-email 1.7.12.1.396.g53b3ea9
In-Reply-To: <1355682495-22382-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211600>

The old output to say "not ok - 1 messsage" was working by accident
only because the test numbers are optional in TAP.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 t/t0000-basic.sh | 4 ++--
 t/test-lib.sh    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 562cf41..46ccda3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -189,13 +189,13 @@ test_expect_success 'tests clean up even on failures' "
 	! test -s err &&
 	! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
 	sed -e 's/Z$//' -e 's/^> //' >expect <<-\\EOF &&
-	> not ok - 1 tests clean up even after a failure
+	> not ok 1 - tests clean up even after a failure
 	> #	Z
 	> #	touch clean-after-failure &&
 	> #	test_when_finished rm clean-after-failure &&
 	> #	(exit 1)
 	> #	Z
-	> not ok - 2 failure to clean up causes the test to fail
+	> not ok 2 - failure to clean up causes the test to fail
 	> #	Z
 	> #	test_when_finished \"(exit 2)\"
 	> #	Z
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f50f834..d0b236f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -298,7 +298,7 @@ test_ok_ () {
 
 test_failure_ () {
 	test_failure=$(($test_failure + 1))
-	say_color error "not ok - $test_count $1"
+	say_color error "not ok $test_count - $1"
 	shift
 	echo "$@" | sed -e 's/^/#	/'
 	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
-- 
1.7.12.1.396.g53b3ea9
