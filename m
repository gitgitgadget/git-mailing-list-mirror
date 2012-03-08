From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] perf: load test-lib-functions from the correct directory
Date: Thu, 8 Mar 2012 09:54:54 +0100
Message-ID: <14709b4345420da36a9152904bef4cc4503f78e4.1331196679.git.trast@student.ethz.ch>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 09:55:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Z7o-0007rZ-Pb
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 09:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab2CHIy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 03:54:58 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:12506 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754986Ab2CHIy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 03:54:58 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 09:54:56 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 09:54:56 +0100
X-Mailer: git-send-email 1.7.9.3.556.g7eb2d
In-Reply-To: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192537>

Loading it in the subshells still referred to $TEST_DIRECTORY/..,
which was only correct in preliminary versions of perf-lib.sh

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This and the next one fix two small bugs in the perf test suite.  They
don't affect anyone so far, which is why they went unnoticed.

 t/perf/p0000-perf-lib-sanity.sh |    5 +++++
 t/perf/perf-lib.sh              |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/perf/p0000-perf-lib-sanity.sh b/t/perf/p0000-perf-lib-sanity.sh
index 2ca4aac..f8dd536 100755
--- a/t/perf/p0000-perf-lib-sanity.sh
+++ b/t/perf/p0000-perf-lib-sanity.sh
@@ -38,4 +38,9 @@ test_expect_success 'test_export works with weird vars' '
 	test "$bar" = "weird # variable"
 '
 
+test_perf 'test-lib-functions correctly loaded in subshells' '
+	: >a &&
+	test_path_is_file a
+'
+
 test_done
diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 2a5e1f3..bcc0131 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -119,7 +119,7 @@ test_run_perf_ () {
 	test_export_="test_cleanup"
 	export test_cleanup test_export_
 	/usr/bin/time -f "%E %U %S" -o test_time.$i "$SHELL" -c '
-. '"$TEST_DIRECTORY"/../test-lib-functions.sh'
+. '"$TEST_DIRECTORY"/test-lib-functions.sh'
 test_export () {
 	[ $# != 0 ] || return 0
 	test_export_="$test_export_\\|$1"
-- 
1.7.9.3.556.g7eb2d
