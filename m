From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 03/10] t4209: factor out helper function test_log_icase()
Date: Sat, 22 Mar 2014 18:15:53 +0100
Message-ID: <1395508560-19893-4-git-send-email-l.s.r@web.de>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 18:16:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRPXR-00025U-OA
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 18:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbaCVRQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 13:16:51 -0400
Received: from mout.web.de ([212.227.15.3]:55477 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbaCVRQb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 13:16:31 -0400
Received: from debian.fritz.box ([79.253.149.120]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LgpIE-1WvZTj2Z9C-00oC43; Sat, 22 Mar 2014 18:16:17
 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1395508560-19893-1-git-send-email-l.s.r@web.de>
X-Provags-ID: V03:K0:DojtEU9ctYY2AnR9wmsLQawUXOUiI8xz8IpdpD7wQle44yPxJzz
 IYaF5+FnVQgadJHTETmyVWsw30C+Zaz2YRcrtCByPNKSsZ6y2e8vlFn/aMQ1ObMIkBwRWsE
 IfCrneVFLvAZ/RzI/SlJHQBM6FVSasKGX78uK/PusjtD7tqsn3Dyq8ol+VrtKBdOBxoIAHb
 v9tmSDtWXsxQvzrLoJoTw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244778>

Reduce code duplication by introducing test_log_icase() that runs the
same test with both --regexp-ignore-case and -i.  The specification of
the four basic test scenarios (matching/nomatching combined with case
sensitive/insensitive) becomes easier to read and write.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t4209-log-pickaxe.sh | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 9f3bb40..dd911c2 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -25,6 +25,11 @@ test_log() {
 	"
 }
 
+test_log_icase() {
+	test_log $@ --regexp-ignore-case
+	test_log $@ -i
+}
+
 test_expect_success setup '
 	>expect_nomatch &&
 
@@ -66,12 +71,10 @@ test_expect_success 'log --author -i' '
 	test_cmp expect_second actual
 '
 
-test_log expect_nomatch -G picked
-test_log expect_second  -G Picked
-test_log expect_nomatch -G pickle --regexp-ignore-case
-test_log expect_nomatch -G pickle -i
-test_log expect_second  -G picked --regexp-ignore-case
-test_log expect_second  -G picked -i
+test_log	expect_nomatch	-G picked
+test_log	expect_second	-G Picked
+test_log_icase	expect_nomatch	-G pickle
+test_log_icase	expect_second	-G picked
 
 test_expect_success 'log -G --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
@@ -86,12 +89,10 @@ test_expect_success 'log -G --no-textconv (missing textconv tool)' '
 	rm .gitattributes
 '
 
-test_log expect_nomatch -S picked
-test_log expect_second  -S Picked
-test_log expect_second  -S picked --regexp-ignore-case
-test_log expect_second  -S picked -i
-test_log expect_nomatch -S pickle --regexp-ignore-case
-test_log expect_nomatch -S pickle -i
+test_log	expect_nomatch	-S picked
+test_log	expect_second	-S Picked
+test_log_icase	expect_second	-S picked
+test_log_icase	expect_nomatch	-S pickle
 
 test_expect_success 'log -S --textconv (missing textconv tool)' '
 	echo "* diff=test" >.gitattributes &&
-- 
1.9.1
