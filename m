From: Tom Russello <tom.russello@grenoble-inp.org>
Subject: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Tue,  7 Jun 2016 16:01:43 +0200
Message-ID: <20160607140148.23242-2-tom.russello@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Cc: erwan.mathoniere@grenoble-inp.org, samuel.groot@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	e@80x24.org, aaron@schrab.com, gitster@pobox.com,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 16:02:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAHaV-0005VW-0K
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 16:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbcFGOCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 10:02:22 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:51999 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbcFGOCU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 10:02:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 30A4620B2;
	Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8h-aaW0oc0yP; Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 18B7020AF;
	Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 158B02066;
	Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zm6QZMNlgNEl; Tue,  7 Jun 2016 16:02:18 +0200 (CEST)
Received: from ux-305.grenet.fr (eduroam-033003.grenet.fr [130.190.33.3])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id E39702064;
	Tue,  7 Jun 2016 16:02:17 +0200 (CEST)
X-Mailer: git-send-email 2.9.0.rc0.40.g1232aeb.dirty
In-Reply-To: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296681>

Tests might fail if lines compared in text files don't have the same order.

Signed-off-by: Samuel GROOT <samuel.groot@grenoble-inp.org>
Signed-off-by: Tom RUSSELLO <tom.russello@grenoble-inp.org>
Signed-off-by: Matthieu MOY <matthieu.moy@grenoble-inp.fr>
---
 t/t9001-send-email.sh | 61 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b3355d2..4558e0f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -54,6 +54,13 @@ test_no_confirm () {
 		>no_confirm_okay
 }
 
+# Check if two files have the same content, non-order sensitive
+test_cmp_noorder () {
+	sort $1 >$1;
+	sort $2 >$2;
+	return $(test_cmp $1 $2)
+}
+
 # Exit immediately to prevent hang if a no-confirm test fails
 check_no_confirm () {
 	if ! test -f no_confirm_okay
@@ -97,7 +104,7 @@ test_expect_success $PREREQ 'setup expect' '
 '
 
 test_expect_success $PREREQ 'Verify commandline' '
-	test_cmp expected commandline1
+	test_cmp_noorder expected commandline1
 '
 
 test_expect_success $PREREQ 'Send patches with --envelope-sender' '
@@ -117,7 +124,7 @@ test_expect_success $PREREQ 'setup expect' '
 '
 
 test_expect_success $PREREQ 'Verify commandline' '
-	test_cmp expected commandline1
+	test_cmp_noorder expected commandline1
 '
 
 test_expect_success $PREREQ 'Send patches with --envelope-sender=auto' '
@@ -137,7 +144,7 @@ test_expect_success $PREREQ 'setup expect' '
 '
 
 test_expect_success $PREREQ 'Verify commandline' '
-	test_cmp expected commandline1
+	test_cmp_noorder expected commandline1
 '
 
 test_expect_success $PREREQ 'setup expect' "
@@ -196,7 +203,7 @@ test_suppress_self () {
 	>"expected-no-cc-$3" &&
 
 	(grep '^Cc:' msghdr1-$3 >"actual-no-cc-$3";
-	 test_cmp expected-no-cc-$3 actual-no-cc-$3)
+	 test_cmp_noorder expected-no-cc-$3 actual-no-cc-$3)
 }
 
 test_suppress_self_unquoted () {
@@ -269,7 +276,7 @@ test_expect_success $PREREQ 'Show all headers' '
 		-e "s/^\(Message-Id:\).*/\1 MESSAGE-ID-STRING/" \
 		-e "s/^\(X-Mailer:\).*/\1 X-MAILER-STRING/" \
 		>actual-show-all-headers &&
-	test_cmp expected-show-all-headers actual-show-all-headers
+	test_cmp_noorder expected-show-all-headers actual-show-all-headers
 '
 
 test_expect_success $PREREQ 'Prompting works' '
@@ -436,13 +443,13 @@ test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
 		2>errors &&
 	# The first message is a reply to --in-reply-to
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
-	test_cmp expect actual &&
+	test_cmp_noorder expect actual &&
 	# Second and subsequent messages are replies to the first one
 	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
-	test_cmp expect actual &&
+	test_cmp_noorder expect actual &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
-	test_cmp expect actual
+	test_cmp_noorder expect actual
 '
 
 test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
@@ -457,13 +464,13 @@ test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
 		$patches $patches $patches \
 		2>errors &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
-	test_cmp expect actual &&
+	test_cmp_noorder expect actual &&
 	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
-	test_cmp expect actual &&
+	test_cmp_noorder expect actual &&
 	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt2 >expect &&
 	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
-	test_cmp expect actual
+	test_cmp_noorder expect actual
 '
 
 test_expect_success $PREREQ 'setup fake editor' '
@@ -537,7 +544,7 @@ test_suppression () {
 		--smtp-server relay.example.com \
 		$patches | replace_variable_fields \
 		>actual-suppress-$1${2+"-$2"} &&
-	test_cmp expected-suppress-$1${2+"-$2"} actual-suppress-$1${2+"-$2"}
+	test_cmp_noorder expected-suppress-$1${2+"-$2"} actual-suppress-$1${2+"-$2"}
 }
 
 test_expect_success $PREREQ 'sendemail.cc set' '
@@ -1213,7 +1220,7 @@ test_expect_success $PREREQ 'ASCII subject is not RFC2047 quoted' '
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
 	grep "Subject" msgtxt1 >actual &&
-	test_cmp expected actual
+	test_cmp_noorder expected actual
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -1234,7 +1241,7 @@ test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	grep email-using-8bit stdout &&
 	grep "Which 8bit encoding" stdout &&
 	egrep "Content|MIME" msgtxt1 >actual &&
-	test_cmp actual content-type-decl
+	test_cmp_noorder actual content-type-decl
 '
 
 test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
@@ -1245,7 +1252,7 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
 	egrep "Content|MIME" msgtxt1 >actual &&
-	test_cmp actual content-type-decl
+	test_cmp_noorder actual content-type-decl
 '
 
 test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
@@ -1257,7 +1264,7 @@ test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
 	egrep "Content|MIME" msgtxt1 >actual &&
-	test_cmp actual content-type-decl
+	test_cmp_noorder actual content-type-decl
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -1286,7 +1293,7 @@ test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
 	grep "Subject" msgtxt1 >actual &&
-	test_cmp expected actual
+	test_cmp_noorder expected actual
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -1335,7 +1342,7 @@ test_expect_success $PREREQ 'sendemail.transferencoding=8bit' '
 		2>errors >out &&
 	sed '1,/^$/d' msgtxt1 >actual &&
 	sed '1,/^$/d' email-using-8bit >expected &&
-	test_cmp expected actual
+	test_cmp_noorder expected actual
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -1352,7 +1359,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=quoted-printab
 		email-using-8bit \
 		2>errors >out &&
 	sed '1,/^$/d' msgtxt1 >actual &&
-	test_cmp expected actual
+	test_cmp_noorder expected actual
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -1369,7 +1376,7 @@ test_expect_success $PREREQ '8-bit and sendemail.transferencoding=base64' '
 		email-using-8bit \
 		2>errors >out &&
 	sed '1,/^$/d' msgtxt1 >actual &&
-	test_cmp expected actual
+	test_cmp_noorder expected actual
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -1395,7 +1402,7 @@ test_expect_success $PREREQ 'convert from quoted-printable to base64' '
 		email-using-qp \
 		2>errors >out &&
 	sed '1,/^$/d' msgtxt1 >actual &&
-	test_cmp expected actual
+	test_cmp_noorder expected actual
 '
 
 test_expect_success $PREREQ 'setup expect' "
@@ -1425,7 +1432,7 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=quoted-printabl
 		email-using-crlf \
 		2>errors >out &&
 	sed '1,/^$/d' msgtxt1 >actual &&
-	test_cmp expected actual
+	test_cmp_noorder expected actual
 '
 
 test_expect_success $PREREQ 'setup expect' '
@@ -1442,7 +1449,7 @@ test_expect_success $PREREQ 'CRLF and sendemail.transferencoding=base64' '
 		email-using-crlf \
 		2>errors >out &&
 	sed '1,/^$/d' msgtxt1 >actual &&
-	test_cmp expected actual
+	test_cmp_noorder expected actual
 '
 
 
@@ -1582,7 +1589,7 @@ test_dump_aliases () {
 			"$(pwd)/.tmp-email-aliases" &&
 		git config sendemail.aliasfiletype "$filetype" &&
 		git send-email --dump-aliases 2>errors >actual &&
-		test_cmp expect actual
+		test_cmp_noorder expect actual
 	'
 }
 
@@ -1842,7 +1849,7 @@ test_expect_success $PREREQ 'use email list in --cc --to and --bcc' '
 	--bcc="bcc1@example.com, bcc2@example.com" \
 	0001-add-master.patch | replace_variable_fields \
 	>actual-list &&
-	test_cmp expected-list actual-list
+	test_cmp_noorder expected-list actual-list
 '
 
 test_expect_success $PREREQ 'aliases work with email list' '
@@ -1858,7 +1865,7 @@ test_expect_success $PREREQ 'aliases work with email list' '
 	--bcc="bcc1@example.com, bcc2@example.com" \
 	0001-add-master.patch | replace_variable_fields \
 	>actual-list &&
-	test_cmp expected-list actual-list
+	test_cmp_noorder expected-list actual-list
 '
 
 test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
@@ -1882,7 +1889,7 @@ test_expect_success $PREREQ 'leading and trailing whitespaces are removed' '
 	--bcc="bcc2@example.com" \
 	0001-add-master.patch | replace_variable_fields \
 	>actual-list &&
-	test_cmp expected-list actual-list
+	test_cmp_noorder expected-list actual-list
 '
 
 test_done
-- 
2.8.3
