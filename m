From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] t0000: quote TAP snippets in test code
Date: Thu, 13 Jan 2011 12:30:23 +0100
Message-ID: <7f14b9991e1c2fe20257c4102ec6b54be6e720c8.1294918219.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 13 12:30:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdLNw-0002Nw-G4
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 12:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab1AMLa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 06:30:27 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:39981 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576Ab1AMLa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 06:30:26 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 13 Jan
 2011 12:30:17 +0100
Received: from localhost.localdomain (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 13 Jan
 2011 12:30:24 +0100
X-Mailer: git-send-email 1.7.4.rc1.309.g58aa0
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165048>

t0000 contains two snippets of actual test output.  This causes
problems when passing -v to the test[*]: the test infrastructure
echoes the tests before running them, and the TAP parser then sees
this test output and concludes that two tests failed and that the TAP
output was badly formatted.

Guard against this by quoting the output in the source.

[*] either by running 'make smoke' with GIT_TEST_OPTS=-v, or with
prove ./t0000-basic.sh :: -v

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t0000-basic.sh |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2f7002a..8deec75 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -80,11 +80,11 @@ EOF
     chmod +x passing-todo.sh &&
     ./passing-todo.sh >out 2>err &&
     ! test -s err &&
-cat >expect <<EOF &&
-ok 1 - pretend we have fixed a known breakage # TODO known breakage
-# fixed 1 known breakage(s)
-# passed all 1 test(s)
-1..1
+sed -e 's/^> //' >expect <<EOF &&
+> ok 1 - pretend we have fixed a known breakage # TODO known breakage
+> # fixed 1 known breakage(s)
+> # passed all 1 test(s)
+> 1..1
 EOF
     test_cmp expect out)
 "
@@ -164,19 +164,19 @@ EOF
     test_must_fail ./failing-cleanup.sh >out 2>err &&
     ! test -s err &&
     ! test -f \"trash directory.failing-cleanup/clean-after-failure\" &&
-sed -e 's/Z$//' >expect <<\EOF &&
-not ok - 1 tests clean up even after a failure
-#	Z
-#	    touch clean-after-failure &&
-#	    test_when_finished rm clean-after-failure &&
-#	    (exit 1)
-#	Z
-not ok - 2 failure to clean up causes the test to fail
-#	Z
-#	    test_when_finished \"(exit 2)\"
-#	Z
-# failed 2 among 2 test(s)
-1..2
+sed -e 's/Z$//' -e 's/^> //' >expect <<\EOF &&
+> not ok - 1 tests clean up even after a failure
+> #	Z
+> #	    touch clean-after-failure &&
+> #	    test_when_finished rm clean-after-failure &&
+> #	    (exit 1)
+> #	Z
+> not ok - 2 failure to clean up causes the test to fail
+> #	Z
+> #	    test_when_finished \"(exit 2)\"
+> #	Z
+> # failed 2 among 2 test(s)
+> 1..2
 EOF
     test_cmp expect out)
 "
-- 
1.7.4.rc1.309.g58aa0
