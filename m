From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 16/26] update-ref --stdin: Harmonize error messages
Date: Mon, 10 Mar 2014 13:46:33 +0100
Message-ID: <1394455603-2968-17-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:48:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzcr-0008ML-H2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbaCJMrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:23 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:57338 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753348AbaCJMrV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:21 -0400
X-AuditID: 1207440f-f79326d000003c9f-34-531db458edf9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id A0.FA.15519.854BD135; Mon, 10 Mar 2014 08:47:20 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwe025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:19 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixO6iqBuxRTbYYNZdY4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd0bThfdsBY98Kg79fs/awHjTtouRk0NCwETiU0cD
	M4QtJnHh3nq2LkYuDiGBy4wSu05NYoVwTjBJ3N9xgRWkik1AV2JRTzMTiC0ioCYxse0QC0gR
	s8AVRonPX3+xgySEBZwlWq7uBitiEVCVuNV7igXE5hVwkVi9bjkbxDo5iSm/F4DVcwLFp195
	AGYLAfW+3NPMOoGRdwEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkODj
	38HYtV7mEKMAB6MSD++BtzLBQqyJZcWVuYcYJTmYlER5J66VDRbiS8pPqcxILM6ILyrNSS0+
	xCjBwawkwpu5GCjHm5JYWZValA+TkuZgURLnVV+i7ickkJ5YkpqdmlqQWgSTleHgUJLgPbwZ
	qFGwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFB3xxcD4AEnxAO3dBtLOW1yQmAsU
	hWg9xajL8Xrt30+MQix5+XmpUuK8c0CKBECKMkrz4FbAUs0rRnGgj4V5W0GqeIBpCm7SK6Al
	TEBLmo9LgSwpSURISTUwGoXfLn0ZwnukfOftlwuvvp6mfOm4su2SC6tOMi3N/eLEG6Y/jSdX
	fu7tpR/dljQuf6HyZcv+vbuPLq1J3yd/Lp37avet3vsfnZq5vh5/qHGQxcIvQ7L3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243747>

Make (most of) the error messages for invalid input have the same
format [1]:

    $COMMAND [SP $REFNAME]: $MESSAGE

Update the tests accordingly.

[1] A few error messages still have their old form, because $COMMAND
and $REFNAME aren't passed all the way down the call stack.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Making more error messages conform to the new pattern is an exercise
left to the reader (or maybe the writer if I find time to get back to
it).

 builtin/update-ref.c  | 24 ++++++++++++------------
 t/t1400-update-ref.sh | 32 ++++++++++++++++----------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0a81a11..ac41635 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -180,17 +180,17 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("update line missing <ref>");
+		die("update: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->new_sha1,
 			    "update", update->ref_name, 0))
-		die("update %s missing <newvalue>", update->ref_name);
+		die("update %s: missing <newvalue>", update->ref_name);
 
 	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
 					    "update", update->ref_name, 1);
 
 	if (*next != line_termination)
-		die("update %s has extra input: %s", update->ref_name, next);
+		die("update %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
@@ -203,17 +203,17 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("create line missing <ref>");
+		die("create: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->new_sha1,
 			    "create", update->ref_name, 0))
-		die("create %s missing <newvalue>", update->ref_name);
+		die("create %s: missing <newvalue>", update->ref_name);
 
 	if (is_null_sha1(update->new_sha1))
-		die("create %s given zero <newvalue>", update->ref_name);
+		die("create %s: zero <newvalue>", update->ref_name);
 
 	if (*next != line_termination)
-		die("create %s has extra input: %s", update->ref_name, next);
+		die("create %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
@@ -226,19 +226,19 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("delete line missing <ref>");
+		die("delete: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->old_sha1,
 			    "delete", update->ref_name, 1)) {
 		update->have_old = 0;
 	} else {
 		if (is_null_sha1(update->old_sha1))
-			die("delete %s given zero <oldvalue>", update->ref_name);
+			die("delete %s: zero <oldvalue>", update->ref_name);
 		update->have_old = 1;
 	}
 
 	if (*next != line_termination)
-		die("delete %s has extra input: %s", update->ref_name, next);
+		die("delete %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
@@ -251,7 +251,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("verify line missing <ref>");
+		die("verify: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->old_sha1,
 			    "verify", update->ref_name, 1)) {
@@ -262,7 +262,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	}
 
 	if (*next != line_termination)
-		die("verify %s has extra input: %s", update->ref_name, next);
+		die("verify %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index e9a0103..3cc5c66 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -371,7 +371,7 @@ test_expect_success 'stdin fails on junk after quoted argument' '
 test_expect_success 'stdin fails create with no ref' '
 	echo "create " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create line missing <ref>" err
+	grep "fatal: create: missing <ref>" err
 '
 
 test_expect_success 'stdin fails create with bad ref name' '
@@ -383,19 +383,19 @@ test_expect_success 'stdin fails create with bad ref name' '
 test_expect_success 'stdin fails create with no new value' '
 	echo "create $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $a missing <newvalue>" err
+	grep "fatal: create $a: missing <newvalue>" err
 '
 
 test_expect_success 'stdin fails create with too many arguments' '
 	echo "create $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $a has extra input:  $m" err
+	grep "fatal: create $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails update with no ref' '
 	echo "update " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update line missing <ref>" err
+	grep "fatal: update: missing <ref>" err
 '
 
 test_expect_success 'stdin fails update with bad ref name' '
@@ -407,19 +407,19 @@ test_expect_success 'stdin fails update with bad ref name' '
 test_expect_success 'stdin fails update with no new value' '
 	echo "update $a" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $a missing <newvalue>" err
+	grep "fatal: update $a: missing <newvalue>" err
 '
 
 test_expect_success 'stdin fails update with too many arguments' '
 	echo "update $a $m $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: update $a has extra input:  $m" err
+	grep "fatal: update $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails delete with no ref' '
 	echo "delete " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete line missing <ref>" err
+	grep "fatal: delete: missing <ref>" err
 '
 
 test_expect_success 'stdin fails delete with bad ref name' '
@@ -431,13 +431,13 @@ test_expect_success 'stdin fails delete with bad ref name' '
 test_expect_success 'stdin fails delete with too many arguments' '
 	echo "delete $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a has extra input:  $m" err
+	grep "fatal: delete $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails verify with too many arguments' '
 	echo "verify $a $m $m" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: verify $a has extra input:  $m" err
+	grep "fatal: verify $a: extra input:  $m" err
 '
 
 test_expect_success 'stdin fails option with unknown name' '
@@ -532,7 +532,7 @@ test_expect_success 'stdin create ref fails with bad new value' '
 test_expect_success 'stdin create ref fails with zero new value' '
 	echo "create $c " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: create $c given zero <newvalue>" err &&
+	grep "fatal: create $c: zero <newvalue>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -556,7 +556,7 @@ test_expect_success 'stdin delete ref fails with wrong old value' '
 test_expect_success 'stdin delete ref fails with zero old value' '
 	echo "delete $a " >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: delete $a given zero <oldvalue>" err &&
+	grep "fatal: delete $a: zero <oldvalue>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
@@ -697,7 +697,7 @@ test_expect_success 'stdin -z fails on unknown command' '
 test_expect_success 'stdin -z fails create with no ref' '
 	printf $F "create " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create line missing <ref>" err
+	grep "fatal: create: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails create with bad ref name' '
@@ -721,7 +721,7 @@ test_expect_success 'stdin -z fails create with too many arguments' '
 test_expect_success 'stdin -z fails update with no ref' '
 	printf $F "update " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: update line missing <ref>" err
+	grep "fatal: update: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails update with bad ref name' '
@@ -751,7 +751,7 @@ test_expect_success 'stdin -z fails update with too many arguments' '
 test_expect_success 'stdin -z fails delete with no ref' '
 	printf $F "delete " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete line missing <ref>" err
+	grep "fatal: delete: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails delete with bad ref name' '
@@ -854,7 +854,7 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 test_expect_success 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c missing <newvalue>" err &&
+	grep "fatal: create $c: missing <newvalue>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -878,7 +878,7 @@ test_expect_success 'stdin -z delete ref fails with wrong old value' '
 test_expect_success 'stdin -z delete ref fails with zero old value' '
 	printf $F "delete $a" "$Z" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete $a given zero <oldvalue>" err &&
+	grep "fatal: delete $a: zero <oldvalue>" err &&
 	git rev-parse $m >expect &&
 	git rev-parse $a >actual &&
 	test_cmp expect actual
-- 
1.9.0
