Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A5C0018C
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF121233F6
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgLQBH5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731292AbgLQBH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:07:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0813DC0617B0
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d13so6664414wrc.13
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iYSibgb8dt6FGiFQDH1NBfzA5DS8VRrp7uoVXpuqbP4=;
        b=tRYnMbcYscmuKMUxKkUgGFkuq4A3uIX2xEKHYKiWEFL62ak9S8yxWDtOMpVhrOXYu6
         cCrU5B2q0kbzOmwGHFPIVkMZ8lM3FjM5ykIQUZOgAS8gmT+ER7KO2hG9V+aEVBj/DQZ8
         x1aOoZnBKCqNAWilewCVOn6rP7ubcFuhqfJdX0WPRElsWpS6u2ObKwQxDORNDxnZU1wB
         oNIo/SjSYISKr8KIiiBtlR/iT55kJxhvsPhlo70pVf9VGRjU8I3dFm7Rmv42oiYiCY9f
         ASqt+0G650Vtl5AJfrUzCp0HKNjVZ2c3UdoFtmz3J/Rr4PHnT6Tfa7auX1bDKWG3uX/Q
         SiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iYSibgb8dt6FGiFQDH1NBfzA5DS8VRrp7uoVXpuqbP4=;
        b=dEv1vm1A/Zy2PshOOm2VrgWDKAo00bDFZssBfg0n7omkIiKSZzs3U/PBVEKfrMsxwH
         Lj4VoQEsmyqeVgpoPyNGwOyOZiHw0DJF6TdLBqLi91plbIFcy1qZPNoEsmJxWrf4gqZR
         7NFAJMXpkmrnQs9N6lC0reINI+u63bGVCsFayJ3R9dtcHSucdJdU6MiEe279XFneIKrR
         52kfo6YiVuDtrWjwLl2hkwOPOx5mE2J+eNt+IvPktGKOnXgOULF8Sjx6MIK9gkSYiShM
         xpL/THhg9qkX0uS+xYTeOrEYy+/ABbdcDPBaF1KyOZg/J8KGwnRju+AtEI7ZedJPtdAS
         K5Ug==
X-Gm-Message-State: AOAM532oK9kkn9t1W1yR+CxJnls7UONhSC/Bh3zNzCDHWSBZaDm174aN
        nAzP9YzAgBFY00xJWtv7b91l5dXnU4Q=
X-Google-Smtp-Source: ABdhPJy3qMj1YofUTVdEqvM3NC+TAFEN68V62biz7hID3k4/wXYtXGTnrWM65hVUQXs2meP+AooLSw==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr41489798wrt.246.1608167234465;
        Wed, 16 Dec 2020 17:07:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8sm5779473wrs.34.2020.12.16.17.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:14 -0800 (PST)
Message-Id: <4360881016dd204c63288ee04588db1a469a6752.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:02 +0000
Subject: [PATCH 03/11] t3201: finalize transitioning to using the branch name
 `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 66713e84e71 (tests: prepare aligned mentions of the default branch
name, 2020-10-23), we started that transition, trying to prepare for a
time when `git init` would use that name for the initial branch.

Even if that time has not arrived, we can complete the transition by
making the test script independent of the default branch name. This also
allows us to drop the `PREPARE_FOR_MAIN_BRANCH` prereq from one test
case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3201-branch-contains.sh | 83 +++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 41 deletions(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 3733cd0091e..6c1ab69ca6d 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -10,51 +10,52 @@ test_expect_success setup '
 	git add file &&
 	test_tick &&
 	git commit -m initial &&
+	git branch -M main &&
 	git branch side &&
 
 	echo 1 >file &&
 	test_tick &&
-	git commit -a -m "second on master" &&
+	git commit -a -m "second on main" &&
 
 	git checkout side &&
 	echo 1 >file &&
 	test_tick &&
 	git commit -a -m "second on side" &&
 
-	git merge master
+	git merge main
 
 '
 
-test_expect_success 'branch --contains=master' '
+test_expect_success 'branch --contains=main' '
 
-	git branch --contains=master >actual &&
+	git branch --contains=main >actual &&
 	{
-		echo "  master" && echo "* side"
+		echo "  main" && echo "* side"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'branch --contains master' '
+test_expect_success 'branch --contains main' '
 
-	git branch --contains master >actual &&
+	git branch --contains main >actual &&
 	{
-		echo "  master" && echo "* side"
+		echo "  main" && echo "* side"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'branch --no-contains=master' '
+test_expect_success 'branch --no-contains=main' '
 
-	git branch --no-contains=master >actual &&
+	git branch --no-contains=main >actual &&
 	test_must_be_empty actual
 
 '
 
-test_expect_success 'branch --no-contains master' '
+test_expect_success 'branch --no-contains main' '
 
-	git branch --no-contains master >actual &&
+	git branch --no-contains main >actual &&
 	test_must_be_empty actual
 
 '
@@ -73,7 +74,7 @@ test_expect_success 'branch --no-contains=side' '
 
 	git branch --no-contains=side >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -81,9 +82,9 @@ test_expect_success 'branch --no-contains=side' '
 
 test_expect_success 'branch --contains with pattern implies --list' '
 
-	git branch --contains=master master >actual &&
+	git branch --contains=main main >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -91,7 +92,7 @@ test_expect_success 'branch --contains with pattern implies --list' '
 
 test_expect_success 'branch --no-contains with pattern implies --list' '
 
-	git branch --no-contains=master master >actual &&
+	git branch --no-contains=main main >actual &&
 	test_must_be_empty actual
 
 '
@@ -100,7 +101,7 @@ test_expect_success 'side: branch --merged' '
 
 	git branch --merged >actual &&
 	{
-		echo "  master" &&
+		echo "  main" &&
 		echo "* side"
 	} >expect &&
 	test_cmp expect actual
@@ -109,9 +110,9 @@ test_expect_success 'side: branch --merged' '
 
 test_expect_success 'branch --merged with pattern implies --list' '
 
-	git branch --merged=side master >actual &&
+	git branch --merged=side main >actual &&
 	{
-		echo "  master"
+		echo "  main"
 	} >expect &&
 	test_cmp expect actual
 
@@ -124,18 +125,18 @@ test_expect_success 'side: branch --no-merged' '
 
 '
 
-test_expect_success 'master: branch --merged' '
+test_expect_success 'main: branch --merged' '
 
-	git checkout master &&
+	git checkout main &&
 	git branch --merged >actual &&
 	{
-		echo "* master"
+		echo "* main"
 	} >expect &&
 	test_cmp expect actual
 
 '
 
-test_expect_success 'master: branch --no-merged' '
+test_expect_success 'main: branch --no-merged' '
 
 	git branch --no-merged >actual &&
 	{
@@ -147,22 +148,22 @@ test_expect_success 'master: branch --no-merged' '
 
 test_expect_success 'branch --no-merged with pattern implies --list' '
 
-	git branch --no-merged=master master >actual &&
+	git branch --no-merged=main main >actual &&
 	test_must_be_empty actual
 
 '
 
 test_expect_success 'implicit --list conflicts with modification options' '
 
-	test_must_fail git branch --contains=master -d &&
-	test_must_fail git branch --contains=master -m foo &&
-	test_must_fail git branch --no-contains=master -d &&
-	test_must_fail git branch --no-contains=master -m foo
+	test_must_fail git branch --contains=main -d &&
+	test_must_fail git branch --contains=main -m foo &&
+	test_must_fail git branch --no-contains=main -d &&
+	test_must_fail git branch --no-contains=main -m foo
 
 '
 
 test_expect_success 'Assert that --contains only works on commits, not trees & blobs' '
-	test_must_fail git branch --contains master^{tree} &&
+	test_must_fail git branch --contains main^{tree} &&
 	blob=$(git hash-object -w --stdin <<-\EOF
 	Some blob
 	EOF
@@ -172,11 +173,11 @@ test_expect_success 'Assert that --contains only works on commits, not trees & b
 '
 
 test_expect_success 'multiple branch --contains' '
-	git checkout -b side2 master &&
+	git checkout -b side2 main &&
 	>feature &&
 	git add feature &&
 	git commit -m "add feature" &&
-	git checkout -b next master &&
+	git checkout -b next main &&
 	git merge side &&
 	git branch --contains side --contains side2 >actual &&
 	cat >expect <<-\EOF &&
@@ -188,9 +189,9 @@ test_expect_success 'multiple branch --contains' '
 '
 
 test_expect_success 'multiple branch --merged' '
-	git branch --merged next --merged master >actual &&
+	git branch --merged next --merged main >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	* next
 	  side
 	EOF
@@ -200,13 +201,13 @@ test_expect_success 'multiple branch --merged' '
 test_expect_success 'multiple branch --no-contains' '
 	git branch --no-contains side --no-contains side2 >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	EOF
 	test_cmp expect actual
 '
 
 test_expect_success 'multiple branch --no-merged' '
-	git branch --no-merged next --no-merged master >actual &&
+	git branch --no-merged next --no-merged main >actual &&
 	cat >expect <<-\EOF &&
 	  side2
 	EOF
@@ -214,7 +215,7 @@ test_expect_success 'multiple branch --no-merged' '
 '
 
 test_expect_success 'branch --contains combined with --no-contains' '
-	git checkout -b seen master &&
+	git checkout -b seen main &&
 	git merge side &&
 	git merge side2 &&
 	git branch --contains side --no-contains side2 >actual &&
@@ -239,17 +240,17 @@ test_expect_success 'branch --merged combined with --no-merged' '
 # that the latter walk does not mess up our flag to see if it was
 # merged).
 #
-# Here "topic" tracks "master" with one extra commit, and "zzz" points to the
-# same tip as master The name "zzz" must come alphabetically after "topic"
+# Here "topic" tracks "main" with one extra commit, and "zzz" points to the
+# same tip as main The name "zzz" must come alphabetically after "topic"
 # as we process them in that order.
-test_expect_success PREPARE_FOR_MAIN_BRANCH 'branch --merged with --verbose' '
-	git branch --track topic master &&
+test_expect_success 'branch --merged with --verbose' '
+	git branch --track topic main &&
 	git branch zzz topic &&
 	git checkout topic &&
 	test_commit foo &&
 	git branch --merged topic >actual &&
 	cat >expect <<-\EOF &&
-	  master
+	  main
 	* topic
 	  zzz
 	EOF
-- 
gitgitgadget

