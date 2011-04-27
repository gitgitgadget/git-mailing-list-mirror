From: Mathias Lafeldt <misfire@debugon.org>
Subject: [PATCH] t/test-lib.sh: minor readability improvements
Date: Wed, 27 Apr 2011 14:49:37 +0200
Message-ID: <4DB810E1.3080102@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 14:49:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF4Bg-0002bF-Ky
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758316Ab1D0Mtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 08:49:43 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:56249 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756992Ab1D0Mtm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 08:49:42 -0400
Received: from [192.168.2.111] (pD955464F.dip.t-dialin.net [217.85.70.79])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0M4HbP-1PyV8b2NhD-00rn2Q; Wed, 27 Apr 2011 14:49:38 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
X-Provags-ID: V02:K0:cY5yMq+9bh6skwKTu3KfnKefNhquIEi1m8qF3+iXmMd
 LkVi0SMeq4Xv33SVyE970Xm0euW8MtSaHPbQzJ7GQ4PZQqIEHx
 K1//mk8XCCIGEpQ1+/Mf+UOZLlt4DELGoR3jBG70Ut3Qk+sM1B
 vfX5DgIjfOZq5fL/M1U2phvw/toGA8ANS2Etm88K3yZTOQXL/a
 uE+A142qILE1o8Y8kragzobtn0pTbgytVyMAy9Z2lw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172233>

Tweak/apply parameter expansion. Also use here document to save
test results instead of appending each line with ">>".

Signed-off-by: Mathias Lafeldt <misfire@debugon.org>
---
 t/test-lib.sh |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index abc47f3..b30725f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -24,7 +24,7 @@ done,*)
 *' --tee '*|*' --va'*)
 	mkdir -p test-results
 	BASE=test-results/$(basename "$0" .sh)
-	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
+	(GIT_TEST_TEE_STARTED=done ${SHELL-"sh"} "$0" "$@" 2>&1;
 	 echo $? > $BASE.exit) | tee $BASE.out
 	test "$(cat $BASE.exit)" = 0
 	exit
@@ -575,7 +575,7 @@ test_external () {
 test_external_without_stderr () {
 	# The temporary file has no (and must have no) security
 	# implications.
-	tmp="$TMPDIR"; if [ -z "$tmp" ]; then tmp=/tmp; fi
+	tmp=${TMPDIR:-"/tmp"}
 	stderr="$tmp/git-external-stderr.$$.tmp"
 	test_external "$@" 4> "$stderr"
 	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
@@ -801,12 +801,14 @@ test_done () {
 		mkdir -p "$test_results_dir"
 		test_results_path="$test_results_dir/${0%.sh}-$$.counts"
 
-		echo "total $test_count" >> $test_results_path
-		echo "success $test_success" >> $test_results_path
-		echo "fixed $test_fixed" >> $test_results_path
-		echo "broken $test_broken" >> $test_results_path
-		echo "failed $test_failure" >> $test_results_path
-		echo "" >> $test_results_path
+		cat >> "$test_results_path" <<EOF
+total $test_count
+success $test_success
+fixed $test_fixed
+broken $test_broken
+failed $test_failure
+
+EOF
 	fi
 
 	if test "$test_fixed" != 0
-- 
1.7.5
