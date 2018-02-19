Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD5A1F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeBSL3o (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:29:44 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:44979 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeBSL3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:29:23 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njdCe9qQuoNnDnjdJeU699; Mon, 19 Feb 2018 11:29:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519039761;
        bh=uu1Q8mWQbfW5rFG9Plxx6qKqyuh5kO8iOno1U36rniY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=Gt23+Pw8z14XYzoz62mCLF3/t5FuHRNue6RH7c79ul/Kic6IRCC0iKWA467ICCNUo
         qztRaobmfZnMUpeA0zwwGajswbfkAQv/JyayDZuiuoRXo8OC7rrKrsP1F6XGbjdpDa
         zKI56xZK+oD0a05bb/8xP/xhzHZud67lg8j+8owA=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=ZreZE-04bYjqTV0VtXMA:9
 a=Khl-9cQEyIo3Sa9j:21 a=bR2X5UEAJ39G5hJe:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 3/9] t3701: use test_write_lines and write_script
Date:   Mon, 19 Feb 2018 11:29:04 +0000
Message-Id: <20180219112910.24471-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219112910.24471-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180219112910.24471-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfN6vtXpXV1RQCVqFVLQXW57ndRjguPt5j4AKRCi8SUEP2SUHkmgJX5qWxY6W4jsO8QGuqNuOgLqIKrE8yMFC72gXDnkh4OvuNoYzuzF0nYUjztXqke+y
 5/so/8TbxYfjv5TFD/KLZtlfaFfBgaGcnXqvhnq9ZFmn4MSctO+dCOpQKLxOGgpKG9xYV+GrM67L0wOk4rMeAb3oiyBCrPPb5BuOJuBaf8F0sMN+84u7mzJD
 SgvE4BZiX+FlXjA9fRY1oPQ05/3mKPmwQh47xgeEYtNwO7huZ1z3dqP5E2s5hvtb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Simplify things slightly by using the above helpers.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3701-add-interactive.sh | 36 +++++++-----------------------------
 1 file changed, 7 insertions(+), 29 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 861ea2e08cce750515f59fc424b3f8336fd9b1a9..b73a9598ab3eaed074735e99f3dcbc8f88d86f4c 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -87,13 +87,8 @@ test_expect_success 'setup expected' '
 	EOF
 '
 
-test_expect_success 'setup fake editor' '
-	>fake_editor.sh &&
-	chmod a+x fake_editor.sh &&
-	test_set_editor "$(pwd)/fake_editor.sh"
-'
-
 test_expect_success 'dummy edit works' '
+	test_set_editor : &&
 	(echo e; echo a) | git add -p &&
 	git diff > diff &&
 	test_cmp expected diff
@@ -110,13 +105,12 @@ test_expect_success 'setup patch' '
 '
 
 test_expect_success 'setup fake editor' '
-	echo "#!$SHELL_PATH" >fake_editor.sh &&
-	cat >>fake_editor.sh <<-\EOF &&
+	FAKE_EDITOR="$(pwd)/fake-editor.sh" &&
+	write_script "$FAKE_EDITOR" <<-\EOF &&
 	mv -f "$1" oldpatch &&
 	mv -f patch "$1"
 	EOF
-	chmod a+x fake_editor.sh &&
-	test_set_editor "$(pwd)/fake_editor.sh"
+	test_set_editor "$FAKE_EDITOR"
 '
 
 test_expect_success 'bad edit rejected' '
@@ -302,18 +296,12 @@ test_expect_success 'deleting an empty file' '
 
 test_expect_success 'split hunk setup' '
 	git reset --hard &&
-	for i in 10 20 30 40 50 60
-	do
-		echo $i
-	done >test &&
+	test_write_lines 10 20 30 40 50 60 >test &&
 	git add test &&
 	test_tick &&
 	git commit -m test &&
 
-	for i in 10 15 20 21 22 23 24 30 40 50 60
-	do
-		echo $i
-	done >test
+	test_write_lines 10 15 20 21 22 23 24 30 40 50 60 >test
 '
 
 test_expect_success 'split hunk "add -p (edit)"' '
@@ -334,17 +322,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 '
 
 test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
-	cat >test <<-\EOF &&
-	5
-	10
-	20
-	21
-	30
-	31
-	40
-	50
-	60
-	EOF
+	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
 	git reset &&
 	# test sequence is s(plit), n(o), y(es), e(dit)
 	# q n q q is there to make sure we exit at the end.
-- 
2.16.1

