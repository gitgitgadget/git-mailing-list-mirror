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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1167AC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B7F60F51
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 15:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhGZOiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbhGZOiW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 10:38:22 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3077C061764
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:50 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a05600c4f54b029024e75a15716so233760wmq.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 08:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZuvaER8Jpu1eePGIIP6OxC71SlC/J0HLvbS0opCYx5U=;
        b=l00/pF834aP1Jv9ph62yUbDag/GyXek/43rDKsXTSuVjnc5AB9t6FuGbm4VHMF48gA
         +tH+XjpzNrVpy0czg11ezVeNgrtb26IHS3+bYMqYCQP8Qfu1ZMAmqcqD+F42p9gjC7T7
         XOOdN56vyZXlW0Hi4ItJz+IkMxsjLbe051d4Qbwb7lpOceIm33Cc+HXuLK98bo2ugXrG
         9KfspZwpQK2IgCbkiYnTbQpcWEertaCUcG6VxM2Nzszi8+rch+58kgXkXYnQmdFoSUBD
         tRQb/JJ7qEexW3efg/o/jhAL3Q9tujv1qb/cGsU7GuLkAjudHbFcAICnZxIXi4v1eQS2
         lZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZuvaER8Jpu1eePGIIP6OxC71SlC/J0HLvbS0opCYx5U=;
        b=Y0kdd0GZ+FnUVPpz1qGo6ROSWtT03BrFpapq02PCvYduXluOQOz8XQZJ6RO3nFkQW/
         hrD1EU0XkjDZuA9PXp/J7J1boX7eWPL3AnWqRQSzEzDe8DDIlzjreE8MRgg68FD49zAN
         JMOVVR82eEx+iO5Fm599aXnjBSyj8FLlVLMQ83M7ngYn/rXzrvc+cG9Kz6IvJ5s7yb1q
         U4ZoSA3JZIti5iCsH2Me12Hrt3IKuiE2Eo3o1TH1NWinUy9P5UEY6CtwR2j1UhRSugx9
         3JQd9D9FhrNluRW/MdXhBZgr7b1fYTFQfZPBcOuYH9s+wszp4QgrdXCOt+RpFiFKV0KM
         WisQ==
X-Gm-Message-State: AOAM531Hh307foFETYEyjovTk7uu/SehD3VntZJv/idQ4igTOotCEEBE
        ju1etlvRJgiT0HQPtrk9Vd6sKGhk3JY=
X-Google-Smtp-Source: ABdhPJwLKOw5KKgk8C4LZRruu+iYw2iR7oroVzVEIuo555S9VISos759+Px6IvxODESRpRHTShE6gA==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr14164257wmp.73.1627312729597;
        Mon, 26 Jul 2021 08:18:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm80245wre.66.2021.07.26.08.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:18:49 -0700 (PDT)
Message-Id: <8f2fd9370fe078923256381ddd6ff4534d736ec7.1627312727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
References: <pull.999.git.1626901619.gitgitgadget@gmail.com>
        <pull.999.v2.git.1627312727.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Jul 2021 15:18:43 +0000
Subject: [PATCH v2 1/5] t1092: test merge conflicts outside cone
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 91e30d6ec22..47f8e5e54e3 100755
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
@@ -482,6 +492,34 @@ test_expect_success 'merge' '
 	test_all_match git rev-parse HEAD^{tree}
 '
 
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

