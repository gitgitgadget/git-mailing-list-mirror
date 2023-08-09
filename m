Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF74FC001E0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjHIRPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHIRPe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:34 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C151FF7
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 905F824267;
        Wed,  9 Aug 2023 13:15:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmR-lDO-00; Wed, 09 Aug 2023 19:15:31 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9001: fix/unify indentation regarding pipes somewhat
Date:   Wed,  9 Aug 2023 19:15:31 +0200
Message-Id: <20230809171531.2564769-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Always indent the continuation of a pipe, and do not indent the
continuation of a compound statement (involving a pipe). This better
reflects the precedence (and is thus potentially less misleading about
the actual structure of the compound command) and better follows most
existing precedents.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
There are also many cases of weirdly wrapped commands with the pipe in
the middle of the line; I did not touch these.

Cc: Junio C Hamano <gitster@pobox.com>
---
 t/t9001-send-email.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 48bf0af2ee..c459311a60 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -61,8 +61,8 @@ test_no_confirm () {
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$@ \
 		$patches >stdout &&
-		! grep "Send this email" stdout &&
-		>no_confirm_okay
+	! grep "Send this email" stdout &&
+	>no_confirm_okay
 }
 
 # Exit immediately to prevent hang if a no-confirm test fails
@@ -342,8 +342,8 @@ test_expect_success $PREREQ 'Prompting works' '
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches \
 		2>errors &&
-		grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
-		grep "^To: to@example.com\$" msgtxt1
+	grep "^From: A U Thor <author@example.com>\$" msgtxt1 &&
+	grep "^To: to@example.com\$" msgtxt1
 '
 
 test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
@@ -1197,7 +1197,7 @@ test_expect_success $PREREQ 'utf8 Cc is rfc2047 encoded' '
 	--smtp-server="$(pwd)/fake.sendmail" \
 	outdir/*.patch &&
 	grep "^	" msgtxt1 |
-	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
+		grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
 '
 
 test_expect_success $PREREQ '--compose adds MIME for utf8 body' '
@@ -1599,7 +1599,7 @@ test_expect_success $PREREQ 'setup expect' '
 test_expect_success $PREREQ 'ASCII subject is not RFC2047 quoted' '
 	clean_fake_sendmail &&
 	echo bogus |
-	git send-email --from=author@example.com --to=nobody@example.com \
+		git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
@@ -1618,7 +1618,7 @@ test_expect_success $PREREQ 'setup expect' '
 test_expect_success $PREREQ 'asks about and fixes 8bit encodings' '
 	clean_fake_sendmail &&
 	echo |
-	git send-email --from=author@example.com --to=nobody@example.com \
+		git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
 	grep "do not declare a Content-Transfer-Encoding" stdout &&
@@ -1632,7 +1632,7 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding works' '
 	clean_fake_sendmail &&
 	git config sendemail.assume8bitEncoding UTF-8 &&
 	echo bogus |
-	git send-email --from=author@example.com --to=nobody@example.com \
+		git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
 	grep -E "Content|MIME" msgtxt1 >actual &&
@@ -1646,19 +1646,19 @@ test_expect_success $PREREQ 'sendemail.8bitEncoding in .git/config overrides --g
 	mkdir home &&
 	git config -f home/.gitconfig sendemail.assume8bitEncoding "bogus too" &&
 	echo bogus |
-	env HOME="$(pwd)/home" DEBUG=1 \
-	git send-email --from=author@example.com --to=nobody@example.com \
+		env HOME="$(pwd)/home" DEBUG=1 \
+		git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			email-using-8bit >stdout &&
 	grep -E "Content|MIME" msgtxt1 >actual &&
 	test_cmp content-type-decl actual
 '
 
 test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 	clean_fake_sendmail &&
 	git config sendemail.assume8bitEncoding "bogus too" &&
 	echo bogus |
-	git send-email --from=author@example.com --to=nobody@example.com \
+		git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
@@ -1687,7 +1687,7 @@ test_expect_success $PREREQ 'setup expect' '
 test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 	clean_fake_sendmail &&
 	echo bogus |
-	git send-email --from=author@example.com --to=nobody@example.com \
+		git send-email --from=author@example.com --to=nobody@example.com \
 			--smtp-server="$(pwd)/fake.sendmail" \
 			--8bit-encoding=UTF-8 \
 			email-using-8bit >stdout &&
-- 
2.40.0.152.g15d061e6df

