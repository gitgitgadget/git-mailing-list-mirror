Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70161F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeB0LEa (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:04:30 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:48503 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeB0LE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:04:26 -0500
Received: from lindisfarne.localdomain ([89.242.176.20])
        by smtp.talktalk.net with SMTP
        id qd3QeQ4WdoNnDqd3YeXd0f; Tue, 27 Feb 2018 11:04:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519729465;
        bh=V6IqWuYCpKl4Y5cVKOinehKrNvmZ8Z4va68j0MGmoV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=YvGRSJHSVDGPF35sW7CxpMt61et6RlOUWgwqhFYVNwi4Pr9O3Zq4UUPhIMk0W9o0k
         Q4QOlWR5cFmDXa4EIjF1aO08IIQGRrv+QSKqTlLD25hDhE9jWwC25kUTgZsYqmEFHI
         QDsNM95mjY6QBSiwfmD9I1Ok6NnUmWP8rJSwvfEA=
X-Originating-IP: [89.242.176.20]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=BZXIa/HMvEOrkAULb1ciZg==:117
 a=BZXIa/HMvEOrkAULb1ciZg==:17 a=evINK-nbAAAA:8 a=ZreZE-04bYjqTV0VtXMA:9
 a=JKJlppc6-rsBzady:21 a=EXMGWyDDmFWXYRiX:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 3/9] t3701: use test_write_lines and write_script
Date:   Tue, 27 Feb 2018 11:03:58 +0000
Message-Id: <20180227110404.16816-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180227110404.16816-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHceZpoVR87XFaQFJU1QPQeeOHFad2MgKYg0DofbkAaX9pTcc6eZTxsQn3kMpWN8R/5AwwLRc7IV43m8e0Mv7JtsACsutKLdeUkdu0Fl0jTa46OVpntO
 gfrPKZEb1IKOenFpoKqJBV/1gRwa6raWA2RCfCDlN6ygO2ZV8PpIV6ER98nemP1Yj417wXRYKYI80POOQRuL6DhYv6eoTlAgWyePv4HlvdCt0/cXjkadS13n
 NSHXbgXWLx26yUqCnLn15gsh3K0ViFZIjkhCuWoTeVeA6OHd0dIb0qopvzViGZERwi/hmIT/X/uA5PZYlzYOG+C9qYhMsoryQ97efmQj3i4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Simplify things slightly by using the above helpers.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v2
     - fixed use of test_set_editor to match what was in pu

 t/t3701-add-interactive.sh | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 861ea2e08c..bdd1f292a9 100755
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
@@ -110,12 +105,10 @@ test_expect_success 'setup patch' '
 '
 
 test_expect_success 'setup fake editor' '
-	echo "#!$SHELL_PATH" >fake_editor.sh &&
-	cat >>fake_editor.sh <<-\EOF &&
+	write_script "fake_editor.sh" <<-\EOF &&
 	mv -f "$1" oldpatch &&
 	mv -f patch "$1"
 	EOF
-	chmod a+x fake_editor.sh &&
 	test_set_editor "$(pwd)/fake_editor.sh"
 '
 
@@ -302,18 +295,12 @@ test_expect_success 'deleting an empty file' '
 
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
@@ -334,17 +321,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
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

