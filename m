Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E4EC433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE99020707
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 11:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVeJExgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgFOLxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbgFOLxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 07:53:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5FC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:53:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c14so15316821qka.11
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lajCn4uG6rl5Mi+5kVFHuwGJDx55TbGLCDnZMzYgDBw=;
        b=qVeJExgAuM5MMm508h6mMYSmk8uczrwcEQftRzLMpwgj3i4nV4Z6bjtXLzJW3GeH9F
         1Pj58SHb5AcAhMJj3zyzigA32coAJfmdpGq39oFaP97ndupLxFODYChiihCaCm6mcBgr
         9G4j10s1FJtjiVrqqPeHRq0uxxxDpPzxriIjpKLYQ6AVB+q8+zHGu7id7bcF8S9WGVQO
         xDXQH7mFdlyOZISZjSU/6Wd8B7Fr2mXfrBpHoPxaY04YS5327X1IT6yK+fSyYVWoz354
         z0SOXxPPLGLdfxw2c42RAFwuHlsq9a7ySi89cBqLiFX3vdSE+QrQlIQoGqWIXzLRy+1J
         Gi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lajCn4uG6rl5Mi+5kVFHuwGJDx55TbGLCDnZMzYgDBw=;
        b=LX2/lmd12qLK7K864LDcXrdiYa6tLFPVWqaEgE45rcGrgWOhYNqu751Nlslhi/Ie92
         xvoOYhgwuQdfikhXt11AzOrVGPsvT6lW8lIIsnZpEwHWBOaudWP0P85aEWr0g1OkEfaA
         BGBfm41NeZGAoZHAvGv0rUXzkJaqK6OhNCaib/auM2dMsbpXnryJGfEBBQSyl6P7248u
         e+gJmM3e+zlI0xm7q4ZISjfp23am9XSZe0/BN1UFbPJlocJW3auWx0BitLjPpre8cN/e
         j3gCNd/UnGzmv6jFiy9q4MrLBRnW6kqymzFPajyA5Rrjuh5pReyP3mgcGA7F9pZNA5/P
         FsJA==
X-Gm-Message-State: AOAM531Nnws0vcuMe0SDdfuPjwplKavQywgB5lUwpXJAD9kkjN58aZFW
        6hme0pEf4ua9DCgz11nDya53V5+aaZw=
X-Google-Smtp-Source: ABdhPJxFWSUE/KlToc5H8x4gFemh6MP7Jiw0Eb1lwSWWU89fnK0BQUZqomfaljGlB1gQ5ker8FNnZA==
X-Received: by 2002:a37:486:: with SMTP id 128mr14105484qke.489.1592222009740;
        Mon, 15 Jun 2020 04:53:29 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f43sm12543781qte.58.2020.06.15.04.53.28
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:53:29 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] t3200: test for specific errors
Date:   Mon, 15 Jun 2020 07:53:19 -0400
Message-Id: <e787b581c3a86b9de51dc21dc90bd1685309313e.1592221875.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592221875.git.liu.denton@gmail.com>
References: <cover.1592221875.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the "--set-upstream-to" and "--unset-upstream" tests, specific error
conditions are being tested. However, there is no way of ensuring that a
test case is failing because of some specific error.

Check stderr of failing commands to ensure that they are failing in the
expected way.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3200-branch.sh | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index da3659c3d3..1fd03cae80 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -835,32 +835,42 @@ test_expect_success 'branch from tag w/--track causes failure' '
 '
 
 test_expect_success '--set-upstream-to fails on multiple branches' '
-	test_must_fail git branch --set-upstream-to master a b c
+	echo "fatal: too many arguments to set new upstream" >expect &&
+	test_must_fail git branch --set-upstream-to master a b c 2>err &&
+	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on detached HEAD' '
 	git checkout HEAD^{} &&
-	test_must_fail git branch --set-upstream-to master &&
-	git checkout -
+	test_when_finished git checkout - &&
+	echo "fatal: could not set upstream of HEAD to master when it does not point to any branch." >expect &&
+	test_must_fail git branch --set-upstream-to master 2>err &&
+	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing dst branch' '
-	test_must_fail git branch --set-upstream-to master does-not-exist
+	echo "fatal: branch '"'"'does-not-exist'"'"' does not exist" >expect &&
+	test_must_fail git branch --set-upstream-to master does-not-exist 2>err &&
+	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on a missing src branch' '
-	test_must_fail git branch --set-upstream-to does-not-exist master
+	test_must_fail git branch --set-upstream-to does-not-exist master 2>err &&
+	test_i18ngrep "the requested upstream branch '"'"'does-not-exist'"'"' does not exist" err
 '
 
 test_expect_success '--set-upstream-to fails on a non-ref' '
-	test_must_fail git branch --set-upstream-to HEAD^{}
+	echo "fatal: Cannot setup tracking information; starting point '"'"'HEAD^{}'"'"' is not a branch." >expect &&
+	test_must_fail git branch --set-upstream-to HEAD^{} 2>err &&
+	test_i18ncmp expect err
 '
 
 test_expect_success '--set-upstream-to fails on locked config' '
 	test_when_finished "rm -f .git/config.lock" &&
 	>.git/config.lock &&
 	git branch locked &&
-	test_must_fail git branch --set-upstream-to locked
+	test_must_fail git branch --set-upstream-to locked 2>err &&
+	test_i18ngrep "could not lock config file .git/config: File exists" err
 '
 
 test_expect_success 'use --set-upstream-to modify HEAD' '
@@ -881,14 +891,17 @@ test_expect_success 'use --set-upstream-to modify a particular branch' '
 '
 
 test_expect_success '--unset-upstream should fail if given a non-existent branch' '
-	test_must_fail git branch --unset-upstream i-dont-exist
+	echo "fatal: Branch '"'"'i-dont-exist'"'"' has no upstream information" >expect &&
+	test_must_fail git branch --unset-upstream i-dont-exist 2>err &&
+	test_i18ncmp expect err
 '
 
 test_expect_success '--unset-upstream should fail if config is locked' '
 	test_when_finished "rm -f .git/config.lock" &&
 	git branch --set-upstream-to locked &&
 	>.git/config.lock &&
-	test_must_fail git branch --unset-upstream
+	test_must_fail git branch --unset-upstream 2>err &&
+	test_i18ngrep "could not lock config file .git/config: File exists" err
 '
 
 test_expect_success 'test --unset-upstream on HEAD' '
@@ -900,17 +913,23 @@ test_expect_success 'test --unset-upstream on HEAD' '
 	test_must_fail git config branch.master.remote &&
 	test_must_fail git config branch.master.merge &&
 	# fail for a branch without upstream set
-	test_must_fail git branch --unset-upstream
+	echo "fatal: Branch '"'"'master'"'"' has no upstream information" >expect &&
+	test_must_fail git branch --unset-upstream 2>err &&
+	test_i18ncmp expect err
 '
 
 test_expect_success '--unset-upstream should fail on multiple branches' '
-	test_must_fail git branch --unset-upstream a b c
+	echo "fatal: too many arguments to unset upstream" >expect &&
+	test_must_fail git branch --unset-upstream a b c 2>err &&
+	test_i18ncmp expect err
 '
 
 test_expect_success '--unset-upstream should fail on detached HEAD' '
 	git checkout HEAD^{} &&
-	test_must_fail git branch --unset-upstream &&
-	git checkout -
+	test_when_finished git checkout - &&
+	echo "fatal: could not unset upstream of HEAD when it does not point to any branch." >expect &&
+	test_must_fail git branch --unset-upstream 2>err &&
+	test_i18ncmp expect err
 '
 
 test_expect_success 'test --unset-upstream on a particular branch' '
-- 
2.27.0.132.g321788e831

