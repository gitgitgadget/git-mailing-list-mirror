Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC8AC12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5318961248
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356034AbhGSRbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380070AbhGSR1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:27:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79981C061767
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:52:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f17so23146166wrt.6
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h6uXKl0tUCfl08p2NwWTeTQTNvBkftMiBGuKvpgJW90=;
        b=g8oBwZfS6JSZvpqQoAW479p73aD32tSrKnDOcs4ohdM+928iMxqxde56IIUHLAICaF
         sTlo2ruQGz7pxT+1oZgU3szA5HkQamNsvDEgUZ4D+W4cJIBEZ5jVt7r9Nv0DL4Te+f+R
         wEfn8hbwtfaNjf5L3np814I5iwpthYbxFrxL6nHSu9cAEVcV2ePcBtZ6WBSLRPB/MWj8
         pp6sc7Zvi+w7ooW70xF8sB+Q30YycNWDhUm6W4Pf76F5QgeRTHbKFdH5pXsgwhZppYgC
         fTYz5fZ/rd/MQONcn6S+7K2GhZWkL8fKsuMFl6y7TmbCywv3mNDzkicWo3tr9JCwjEuh
         yzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h6uXKl0tUCfl08p2NwWTeTQTNvBkftMiBGuKvpgJW90=;
        b=jr50VE1/NuvrIMhjhYXJ6a4DXNAh9mfBevTVSiuI7Ex1Sd2JPzFbWTI9/Tj02eBbhI
         1hpA6AR0syog4nXm2bZVeXUzznYyeGUNDhGRv1iw9GYaj/pNWQiJ2K8rslieb7TgbABa
         hsBPH6uQQ8EBCx5uILsccZ9yZWThAeCfqKQbC8TMqQaMzY5jHDKU4EzvqjL8A+BEcIdE
         eqpsL/5eYb5/6NkylGv3a6ZrLQCXTgG+0Y+CYaSngOJ+TrkhaneoorZpa08Uz8HMf2fU
         ZSrdTqVRa/vCSaYznyVedkpI/NMrnJqqXRScuj0VsDb7ZrE/NXnUkQ4h6fLS9BSWW7MU
         e9hQ==
X-Gm-Message-State: AOAM530CxRYeAwPMZT5zeuU7CnItOCeD3rVJYhnT3+9JM6VKxaiXfpxh
        VtJ2D4Q8inY/o6WcIFVZE4kiVmv1XNw=
X-Google-Smtp-Source: ABdhPJzbmaS158GxmSqagaGb1Roxw/QPLcxe6eheeyQVGmxRNshCAEycGYh778h0Ik4CV9j70K7rfQ==
X-Received: by 2002:a05:6000:1375:: with SMTP id q21mr31466568wrz.147.1626718054561;
        Mon, 19 Jul 2021 11:07:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm7695538wrw.9.2021.07.19.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:07:34 -0700 (PDT)
Message-Id: <cc400e9131dfc9a3df1b56401ab964eb5f1eb31d.1626718050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 18:07:29 +0000
Subject: [PATCH 5/6] t3320: use git-symbolic-ref rather than filesystem access
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t3320-notes-merge-worktrees.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 052516e6c6a..6b2d507f3e7 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -46,8 +46,9 @@ test_expect_success 'create some new worktrees' '
 test_expect_success 'merge z into y fails and sets NOTES_MERGE_REF' '
 	git config core.notesRef refs/notes/y &&
 	test_must_fail git notes merge z &&
-	echo "ref: refs/notes/y" >expect &&
-	test_cmp expect .git/NOTES_MERGE_REF
+	echo "refs/notes/y" >expect &&
+	git symbolic-ref NOTES_MERGE_REF >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'merge z into y while mid-merge in another workdir fails' '
@@ -57,7 +58,7 @@ test_expect_success 'merge z into y while mid-merge in another workdir fails' '
 		test_must_fail git notes merge z 2>err &&
 		test_i18ngrep "a notes merge into refs/notes/y is already in-progress at" err
 	) &&
-	test_path_is_missing .git/worktrees/worktree/NOTES_MERGE_REF
+	test_must_fail git -C worktree symbolic-ref NOTES_MERGE_REF
 '
 
 test_expect_success 'merge z into x while mid-merge on y succeeds' '
@@ -68,8 +69,9 @@ test_expect_success 'merge z into x while mid-merge on y succeeds' '
 		test_i18ngrep "Automatic notes merge failed" out &&
 		grep -v "A notes merge into refs/notes/x is already in-progress in" out
 	) &&
-	echo "ref: refs/notes/x" >expect &&
-	test_cmp expect .git/worktrees/worktree2/NOTES_MERGE_REF
+	echo "refs/notes/x" >expect &&
+	git -C worktree2 symbolic-ref NOTES_MERGE_REF >actual &&
+	test_cmp expect actual
 '
 
 test_done
-- 
gitgitgadget

