From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 04/10] test-lib: Replace uses of $(expr ...) by POSIX shell features.
Date: Wed, 18 Mar 2009 22:27:06 +0100
Message-ID: <680eb7fed78dc2ae0268f9b3adcd5978aed3ebcf.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 22:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3Kq-000574-7Z
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 22:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754971AbZCRV1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbZCRV1f
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:27:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46785 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011AbZCRV1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:27:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 21306CDF8C;
	Wed, 18 Mar 2009 22:27:18 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A2A5560E6F;
	Wed, 18 Mar 2009 22:27:17 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113678>

In particular:

- Test case counting can be achieved by arithmetic expansion.

- The name of the test, e.g. t1234, can be computed with ${0%%} and ${0##}.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4013-diff-various.sh      |    2 +-
 t/t5515-fetch-merge-logic.sh |    2 +-
 t/test-lib.sh                |   23 +++++++++++------------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 9cd5a6e..9c30b29 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -101,7 +101,7 @@ do
 	'' | '#'*) continue ;;
 	esac
 	test=`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
-	cnt=`expr $test_count + 1`
+	cnt=$(($test_count+1))
 	pfx=`printf "%04d" $cnt`
 	expect="$TEST_DIRECTORY/t4013/diff.$test"
 	actual="$pfx-diff.$test"
diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 1f4608d..0b39503 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -129,7 +129,7 @@ do
 	'' | '#'*) continue ;;
 	esac
 	test=`echo "$cmd" | sed -e 's|[/ ][/ ]*|_|g'`
-	cnt=`expr $test_count + 1`
+	cnt=$(($test_count+1))
 	pfx=`printf "%04d" $cnt`
 	expect_f="$TEST_DIRECTORY/t5515/fetch.$test"
 	actual_f="$pfx-fetch.$test"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1e01a91..bd8cba1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -242,14 +242,14 @@ test_merge () {
 # the text_expect_* functions instead.
 
 test_ok_ () {
-	test_count=$(expr "$test_count" + 1)
-	test_success=$(expr "$test_success" + 1)
+	test_count=$(($test_count + 1))
+	test_success=$(($test_success + 1))
 	say_color "" "  ok $test_count: $@"
 }
 
 test_failure_ () {
-	test_count=$(expr "$test_count" + 1)
-	test_failure=$(expr "$test_failure" + 1);
+	test_count=$(($test_count + 1))
+	test_failure=$(($test_failure + 1))
 	say_color error "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
@@ -257,13 +257,13 @@ test_failure_ () {
 }
 
 test_known_broken_ok_ () {
-	test_count=$(expr "$test_count" + 1)
+	test_count=$(($test_count+1))
 	test_fixed=$(($test_fixed+1))
 	say_color "" "  FIXED $test_count: $@"
 }
 
 test_known_broken_failure_ () {
-	test_count=$(expr "$test_count" + 1)
+	test_count=$(($test_count+1))
 	test_broken=$(($test_broken+1))
 	say_color skip "  still broken $test_count: $@"
 }
@@ -279,12 +279,10 @@ test_run_ () {
 }
 
 test_skip () {
-	this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
-	this_test="$this_test.$(expr "$test_count" + 1)"
 	to_skip=
 	for skp in $GIT_SKIP_TESTS
 	do
-		case "$this_test" in
+		case $this_test.$(($test_count+1)) in
 		$skp)
 			to_skip=t
 		esac
@@ -292,7 +290,7 @@ test_skip () {
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-		test_count=$(expr "$test_count" + 1)
+		test_count=$(($test_count+1))
 		say_color skip "skip $test_count: $1"
 		: true
 		;;
@@ -370,7 +368,7 @@ test_external () {
 	then
 		# Announce the script to reduce confusion about the
 		# test output that follows.
-		say_color "" " run $(expr "$test_count" + 1): $descr ($*)"
+		say_color "" " run $(($test_count+1)): $descr ($*)"
 		# Run command; redirect its stderr to &4 as in
 		# test_run_, but keep its stdout on our stdout even in
 		# non-verbose mode.
@@ -613,7 +611,8 @@ test_create_repo "$test"
 # in subprocesses like git equals our $PWD (for pathname comparisons).
 cd -P "$test" || exit 1
 
-this_test=$(expr "./$0" : '.*/\(t[0-9]*\)-[^/]*$')
+this_test=${0##*/}
+this_test=${this_test%%-*}
 for skp in $GIT_SKIP_TESTS
 do
 	to_skip=
-- 
1.6.2.1.224.g2225f
