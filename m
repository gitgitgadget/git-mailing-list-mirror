Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BCA91F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbeKPVQH (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 16:16:07 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:4700 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeKPVQH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 16:16:07 -0500
Received: from lindisfarne.localdomain ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id NbuxgXotudJAeNbv4gYs20; Fri, 16 Nov 2018 11:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542366254;
        bh=v4VOunfTLikFtF3lKeuaG8j1meNFiuVbF67pG1bgWGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=NSt7gdgMkU21YC2makzJ3btzKrgaqt3s42eg3DNp57Aoz8+gVmpd37rGhwxXfBFqm
         bn1ZeGGFxAIB9Um4Ed2KguWjGUUCi8Pz+McYNNBTh7U1DBt3g/qeHNA0b0lsohxgYX
         Zlj5NHIQdndRer3qOXszCoV6HWJeh+all9TlBOoM=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=evINK-nbAAAA:8 a=jXCYYOxaiYF5wbv4ZvcA:9
 a=s1rkbyRdG-LNbfjc:21 a=rbZOPNKEenb8vpLT:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 4/9] diff --color-moved-ws: demonstrate false positives
Date:   Fri, 16 Nov 2018 11:03:51 +0000
Message-Id: <20181116110356.12311-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116110356.12311-1-phillip.wood@talktalk.net>
References: <20180924100604.32208-1-phillip.wood@talktalk.net>
 <20181116110356.12311-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfL7V19BxUQEBYag32sT2sGWRZKebsYdbnJXvS/cr8UoW3Swculn5o6u/gJA0q/seu5fIGW2Q7yfxiCwk+XWKfG+g3eiyB2dR8zA5iYlPOaMbz1JPuU2+
 pves/nf+v3Efjt5lmBQ/lv823Bh58uB/LFj1Xz66VkZxTQo04dgRsMsZNooLwGe2LdQy6V+PMb9nT9eyct+MnXaQkmXAuy1LwvSLjZLil9p6lYqOx60sPjU3
 TEFLjXWZtEnCpNqTeZe2xA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

'diff --color-moved-ws=allow-indentation-change' can highlight lines
that have internal whitespace changes rather than indentation
changes. For example in commit 1a07e59c3e ("Update messages in
preparation for i18n", 2018-07-21) the lines

-               die (_("must end with a color"));
+               die(_("must end with a color"));

are highlighted as moved when they should not be. Modify an existing
test to show the problem that will be fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t4015-diff-whitespace.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index a9fb226c5a..eee81a1987 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1809,7 +1809,7 @@ test_expect_success 'only move detection ignores white spaces' '
 	test_cmp expected actual
 '
 
-test_expect_success 'compare whitespace delta across moved blocks' '
+test_expect_failure 'compare whitespace delta across moved blocks' '
 
 	git reset --hard &&
 	q_to_tab <<-\EOF >text.txt &&
@@ -1827,6 +1827,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 	QQQthat has similar lines
 	QQQto previous blocks, but with different indent
 	QQQYetQAnotherQoutlierQ
+	QLine with internal w h i t e s p a c e change
 	EOF
 
 	git add text.txt &&
@@ -1847,6 +1848,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 	QQthat has similar lines
 	QQto previous blocks, but with different indent
 	QQYetQAnotherQoutlier
+	QLine with internal whitespace change
 	EOF
 
 	git diff --color --color-moved --color-moved-ws=allow-indentation-change >actual.raw &&
@@ -1856,7 +1858,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 		<BOLD>diff --git a/text.txt b/text.txt<RESET>
 		<BOLD>--- a/text.txt<RESET>
 		<BOLD>+++ b/text.txt<RESET>
-		<CYAN>@@ -1,14 +1,14 @@<RESET>
+		<CYAN>@@ -1,15 +1,15 @@<RESET>
 		<BOLD;MAGENTA>-QIndented<RESET>
 		<BOLD;MAGENTA>-QText across<RESET>
 		<BOLD;MAGENTA>-Qsome lines<RESET>
@@ -1871,6 +1873,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 		<BOLD;MAGENTA>-QQQthat has similar lines<RESET>
 		<BOLD;MAGENTA>-QQQto previous blocks, but with different indent<RESET>
 		<RED>-QQQYetQAnotherQoutlierQ<RESET>
+		<RED>-QLine with internal w h i t e s p a c e change<RESET>
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Indented<RESET>
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>Text across<RESET>
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>some lines<RESET>
@@ -1885,6 +1888,7 @@ test_expect_success 'compare whitespace delta across moved blocks' '
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>that has similar lines<RESET>
 		<BOLD;CYAN>+<RESET>QQ<BOLD;CYAN>to previous blocks, but with different indent<RESET>
 		<GREEN>+<RESET>QQ<GREEN>YetQAnotherQoutlier<RESET>
+		<GREEN>+<RESET>Q<GREEN>Line with internal whitespace change<RESET>
 	EOF
 
 	test_cmp expected actual
-- 
2.19.1

