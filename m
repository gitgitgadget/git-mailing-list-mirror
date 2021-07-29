Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69519C4320A
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43EF560EBC
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhG2OwS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhG2OwP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:52:15 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116EDC0613C1
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so7026356wmh.3
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m3Z0ant7md1f9wJf0Q9VKxSUWOMpn0V3rnRB1ujIDL0=;
        b=tKfoOlPtSQLVc3GHej+ZTFayP6L8qVb5qWMtdKjBraxmSL1EdIoik43FrKsmIKtBAT
         XLDLRsZGZJYI2K3k9+ZC6fw81rzASUYGwjhkITU3J0rg78E5IwBl7JR8GXoJwSUZuSpn
         gGpp2IobtAKOWKdLz5OatAvMT/9f++hX84cGDOcfnZCqVlztz5zV+RWZpPe/tzjyDE7r
         0H6oCY7FqJPOxcZrAHrQCyJCZSZMr/Ogj67yR/JuEpqDyLLhNm6RQTGef5SBeBJ2wWVK
         CZu32/t4NKwbZQXp96uQ/ZboDEimNMnXmMPMtMPsMrvuuXspMx9hFauPXE9ymiFDU4O9
         VASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m3Z0ant7md1f9wJf0Q9VKxSUWOMpn0V3rnRB1ujIDL0=;
        b=oK6b0gU2U6DYWTMjg2DRhI+IfMCiY/ZrfsjG8Cy3Lt/Bn5gIt4OXlE1uJ2R8LPW94q
         WG7860EQPOveXLZNTM6ZEyZitwcn1Wf+C3dAGMU9ABT0PCAdLxeUn+XLx1KSHtcHEGlI
         3K4/gW9HTVm/+t+M4FOtVl44hl1HSM5j+xsDwTg5epwFsoFO6GA4oNuff6zAv6jTrw2L
         8iewrlqL9DCxnMhN7dcYTJxCSujpUGbquOMUiSFZ+uwl6PFm6RWrx9hm8NEITi9jPGPG
         yyblJpAVl9kHzub9UcnWuJL6xJvFkeQ/8WGGwU6ckdRQw4w1RXYlAmQLmyQbS+or7AGX
         z6SA==
X-Gm-Message-State: AOAM5335SfIdDp5bVSq9Hy7T5UXhxQJ4ZzS0kGjeXAJ4B7nRb0SzepKy
        av1J/p8O/gPqWM+CssT5OtQ4JRbqVeo=
X-Google-Smtp-Source: ABdhPJwRTAhh41XW176IEbMnoMM4FSRVBqtV7dg5+GFpmngFBYJmVY6cwq7zDAbI3KQgJftuCjaFBQ==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr15153354wmi.137.1627570329701;
        Thu, 29 Jul 2021 07:52:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm9645925wmj.34.2021.07.29.07.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 07:52:09 -0700 (PDT)
Message-Id: <5e96df4df582744a89b10ce55887a2c2aacc7e70.1627570327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
References: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
        <pull.999.v3.git.1627570327.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Jul 2021 14:52:03 +0000
Subject: [PATCH v3 1/5] t1092: test merge conflicts outside cone
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Conflicts can occur outside of the sparse-checkout definition, and in
that case users might try to resolve the conflicts in several ways.
Document a few of these ways in a test. Make it clear that this behavior
is not necessarily the optimal flow, since users can become confused
when Git deletes these files from the worktree in later commands.

Reviewed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 43 ++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 91e30d6ec22..4c3bcb34999 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -114,6 +114,16 @@ test_expect_success 'setup' '
 		git add . &&
 		git commit -m "file to dir" &&
 
+		for side in left right
+		do
+			git checkout -b merge-$side base &&
+			echo $side >>deep/deeper2/a &&
+			echo $side >>folder1/a &&
+			echo $side >>folder2/a &&
+			git add . &&
+			git commit -m "$side" || return 1
+		done &&
+
 		git checkout -b deepest base &&
 		echo "updated deepest" >deep/deeper1/deepest/a &&
 		git commit -a -m "update deepest" &&
@@ -482,6 +492,39 @@ test_expect_success 'merge' '
 	test_all_match git rev-parse HEAD^{tree}
 '
 
+# NEEDSWORK: This test is documenting current behavior, but that
+# behavior can be confusing to users so there is desire to change it.
+# Right now, users might be using this flow to work through conflicts,
+# so any solution should present advice to users who try this sequence
+# of commands to follow whatever new method we create.
+test_expect_success 'merge with conflict outside cone' '
+	init_repos &&
+
+	test_all_match git checkout -b merge-tip merge-left &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match test_must_fail git merge -m merge merge-right &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Resolve the conflict in different ways:
+	# 1. Revert to the base
+	test_all_match git checkout base -- deep/deeper2/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# 2. Add the file with conflict markers
+	test_all_match git add folder1/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	# 3. Rename the file to another sparse filename and
+	#    accept conflict markers as resolved content.
+	run_on_all mv folder2/a folder2/z &&
+	test_all_match git add folder2 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git merge --continue &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD^{tree}
+'
+
 test_expect_success 'merge with outside renames' '
 	init_repos &&
 
-- 
gitgitgadget

