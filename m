Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D601FAE2
	for <e@80x24.org>; Mon,  5 Mar 2018 10:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934472AbeCEK4z (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:56:55 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:17574 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934414AbeCEK4o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:44 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnOesOzb; Mon, 05 Mar 2018 10:56:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247402;
        bh=eWEezGsWMFBQ75MlvUPFnQGY559LpAaF5klzk3ZtGuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=ekfVOBvyYuMaE/Q6lZjjV6zueM3lOVX40ekDyQWueVlZ7qiclD6GSQytdDbP5fF47
         MTNceA17gvSvZqgfjhV3hhQVXRubN0eDzOTkNCXJ9muxNG0twUCqBouzOZVvbUPGdP
         njilOD4CcoUhgOri+Uxsu/J+1w/2j7V0IbD2iqrU=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=ZreZE-04bYjqTV0VtXMA:9
 a=XRLYVlECg_07thms:21 a=EXMGWyDDmFWXYRiX:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 3/9] t3701: use test_write_lines and write_script
Date:   Mon,  5 Mar 2018 10:56:24 +0000
Message-Id: <20180305105630.14407-4-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPm22772MvS1amKT3DV/4k7jYGSgUeaMX4vK8u38tKZksikag9rBFGic8ylxgBu6zSYn7DMpF2Y8GWvLtwF4VTOm3krH+5pFpLxhtd8GyrD2M/uQmd+w
 /ZFmjkhwth6rCW9UGXDyM7WtUDps4uV9Hn2FLFsjNkhDSoPYyQPZOTOMZs73tSt8iQ3FwkV3PJm427mZnQaJWM1YNQWSto0hIXScUwA/pgtKl2F1fT+wE66b
 2WYEOfAfaPMfS860ymQf1uXvN9pKiI+aCeuQ7pDpDC366nbWvCk1k61jkK/dLg9jA/Vs4IXqNo5Uy0xxEu268bIFatfzWwB6TB4PJBe1kf0=
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
index 3130dafcf0..836ce346ed 100755
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
2.16.2

