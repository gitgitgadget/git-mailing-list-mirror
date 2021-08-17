Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0285BC432BE
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E44D26102A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhHQRJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhHQRJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:09:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73EBC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2666323wma.0
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7uWZFU2odf9jKIn2gJNnia4alxezRzTcFj0oEShO97A=;
        b=ay+odKkwMH+njSbhd/BJk42R/XOagf3gfCrSs0Q30pCalS91ml60vE/Yv8hqzaay2G
         4uBMG6adaqu2836C9O9LMpldEBI+Aqt81mpvBC4X5EqQ/7jvHBJQYrG6PAVgmeDUafh1
         is6ZO1K/Z20IicQJ1E5CErHRpEXTo3oxLE4m5A+Ad0HGnJMWeTIgxZrnyXYcuc802ERQ
         1l9nbTw3HBbX+kKkR1uZu6oivH5T//F4Qgs6Tr9q638IsfYRRjpQxKQdotcEWi0JuT9y
         bYkRvFwixtSVJKOMk3F2UJZ2dyASscXFIwszcYZzK1CHSrL+u27w2OJ4K2RrZbPDe3kX
         gMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7uWZFU2odf9jKIn2gJNnia4alxezRzTcFj0oEShO97A=;
        b=kjLxisdai4ZuY1ned1H0cTAKmSAjEefjP9qfrEpRJF0UzdGfaMmvif33zJKvYDLKC6
         +8J9EgyzyKSaJAMbHGLaWefgoVZ4+XW0deldVNqlPbU3eDiwjD19Lk/+z5Yp8mMZ0/D0
         zY2/avL+cdCIjZfbzqETftRM4OdSbvoi+dfXZcoRUIsYH3d4W7lLJR2ITT7tnxq9sgZS
         tTDvp3fMzNpwyAk2Jafmv7hHSa45WTvtx3ZO+UP097B6siqDoRuebzqfrahsIHT2u+sK
         qneuW9aCPZAz+6DBmN5AFEAbBHXpIrncjyAC01w3UIEZ6CndTd+tbvYvILgV+pwnetVm
         JJuA==
X-Gm-Message-State: AOAM531k+sKKrqQNxkvUpxmd3RUnHk0acvnjKwTh65etmdqG95HpR/jO
        r4uT47+XJoW01V9kaCwQ3yPpNV6oFjA=
X-Google-Smtp-Source: ABdhPJwSJQOzsEA1ZWvDGzveHZfBdD8WY9ViHBYNY/jW5RvOWwyLSswzAvY1k+A+9FKxhePXLUXdFg==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr4392180wmc.15.1629220128641;
        Tue, 17 Aug 2021 10:08:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l38sm2508495wmp.15.2021.08.17.10.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:08:48 -0700 (PDT)
Message-Id: <ca23bf38bd9a88c6ab8461e703165c550cf7b955.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 17:08:43 +0000
Subject: [PATCH 5/6] t1092: add cherry-pick, rebase tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Add tests to check that cherry-pick and rebase behave the same in the
sparse-index case as in the full index cases.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index a0ed2bec574..a52d2edda54 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -486,14 +486,17 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
 	test_sparse_match git reset update-folder2
 '
 
-test_expect_success 'merge' '
+test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-	test_all_match git checkout -b merge update-deep &&
-	test_all_match git merge -m "folder1" update-folder1 &&
-	test_all_match git rev-parse HEAD^{tree} &&
-	test_all_match git merge -m "folder2" update-folder2 &&
-	test_all_match git rev-parse HEAD^{tree}
+	for OPERATION in "merge -s ort -m merge" cherry-pick rebase
+	do
+		test_all_match git checkout -B temp update-deep &&
+		test_all_match git $OPERATION update-folder1 &&
+		test_all_match git rev-parse HEAD^{tree} &&
+		test_all_match git $OPERATION update-folder2 &&
+		test_all_match git rev-parse HEAD^{tree} || return 1
+	done
 '
 
 # NEEDSWORK: This test is documenting current behavior, but that
-- 
gitgitgadget

