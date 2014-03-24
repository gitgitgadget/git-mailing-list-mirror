From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/27] update-ref --stdin: Harmonize error messages
Date: Mon, 24 Mar 2014 18:56:51 +0100
Message-ID: <1395683820-17304-19-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS998-0002Oo-7v
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbaCXR5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:51 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54325 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753818AbaCXR5q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:46 -0400
X-AuditID: 12074413-f79076d000002d17-c8-533072191be4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 24.F5.11543.91270335; Mon, 24 Mar 2014 13:57:45 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xo028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:43 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqCtZZBBscHajvMXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO+PO/QOMBXd9Ko7MCmtgPGfbxcjBISFgIrHzokQX
	IyeQKSZx4d56ti5GLg4hgcuMEtNm7mGHcE4wSUz6cZAVpIpNQFdiUU8zE4gtIqAmMbHtEAtI
	EbPAFUaJKx+3s4AkhAXcJOb+WwnWwCKgKvFqySM2EJtXwFWicVkbO8Q6OYkpvxeA2ZxA8a3t
	h5lBbCEBF4kdH3uZJjDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokR
	EnjCOxh3nZQ7xCjAwajEw7vB1CBYiDWxrLgy9xCjJAeTkigvWy5QiC8pP6UyI7E4I76oNCe1
	+BCjBAezkgivZThQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwZtV
	ANQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qM+GJgbICkeID2OhSC7C0uSMwF
	ikK0nmLU5bi1fGMjkxBLXn5eqpQ47zWQHQIgRRmleXArYGnmFaM40MfCvGogo3iAKQpu0iug
	JUxAS8Kb9ECWlCQipKQaGD2fZeqUri+sYD9wZfsvhjc8m/6F3G9p+pY/7emEqfnrbWU3PTXe
	/y5bza3AwEJL8uX7jh0ed2ae/LXjnZRGtXtcbcjldLuGH0IT7zjNuuEiPnEViy+3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244844>

Make (most of) the error messages for invalid input have the same
format [1]:

    $COMMAND [SP $REFNAME]: $MESSAGE

Update the tests accordingly.

[1] A few error messages are left with their old form, because
    $COMMAND and $REFNAME aren't passed all the way down the call
    stack.  Maybe those sites should be changed some day, too.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 24 ++++++++++++------------
 t/t1400-update-ref.sh | 32 ++++++++++++++++----------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index b49a5b0..bbc04b2 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -202,19 +202,19 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("update line missing <ref>");
+		die("update: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->new_sha1,
 			    "update", update->ref_name,
 			    PARSE_SHA1_ALLOW_EMPTY))
-		die("update %s missing <newvalue>", update->ref_name);
+		die("update %s: missing <newvalue>", update->ref_name);
 
 	update->have_old = !parse_next_sha1(input, &next, update->old_sha1,
 					    "update", update->ref_name,
 					    PARSE_SHA1_OLD);
 
 	if (*next != line_termination)
-		die("update %s has extra input: %s", update->ref_name, next);
+		die("update %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
@@ -227,17 +227,17 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 
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
@@ -250,19 +250,19 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("delete line missing <ref>");
+		die("delete: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->old_sha1,
 			    "delete", update->ref_name, PARSE_SHA1_OLD)) {
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
@@ -275,7 +275,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 
 	update->ref_name = parse_refname(input, &next);
 	if (!update->ref_name)
-		die("verify line missing <ref>");
+		die("verify: missing <ref>");
 
 	if (parse_next_sha1(input, &next, update->old_sha1,
 			    "verify", update->ref_name, PARSE_SHA1_OLD)) {
@@ -286,7 +286,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	}
 
 	if (*next != line_termination)
-		die("verify %s has extra input: %s", update->ref_name, next);
+		die("verify %s: extra input: %s", update->ref_name, next);
 
 	return next;
 }
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1db0689..48ccc4d 100755
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
 
 test_expect_success 'stdin -z fails update with too few args' '
@@ -765,7 +765,7 @@ test_expect_success 'stdin -z fails update with too many arguments' '
 test_expect_success 'stdin -z fails delete with no ref' '
 	printf $F "delete " >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: delete line missing <ref>" err
+	grep "fatal: delete: missing <ref>" err
 '
 
 test_expect_success 'stdin -z fails delete with bad ref name' '
@@ -868,7 +868,7 @@ test_expect_success 'stdin -z create ref fails with bad new value' '
 test_expect_success 'stdin -z create ref fails with empty new value' '
 	printf $F "create $c" "" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: create $c missing <newvalue>" err &&
+	grep "fatal: create $c: missing <newvalue>" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -892,7 +892,7 @@ test_expect_success 'stdin -z delete ref fails with wrong old value' '
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
