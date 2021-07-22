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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E9C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745A960E8F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhGVUsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbhGVUsS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05830C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l11-20020a7bc34b0000b029021f84fcaf75so2364892wmj.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vysnlRXYw/aOCYJK3a3w3iXK3uaa7j22KJHUUCfJpig=;
        b=NtsSzau1dZxj4UEJuRM2iOTs+KCIOsr6P6yHuNFJgxXpg1SxdEa3U13UlDm2RUkaDq
         pBXI8lLRbaR3fviw5IRydAV1+ug5Cp+1233Mu9MpMbKkFcd946PoeGv0ph9VkUNHhJXr
         DGt60Sq2dxRG0fmnwYWaUHcHB1sVos0U8Zxun2dtQb3JVmo55z5nzM7synGkbCR2nRvz
         8CG6xWNdDboXZP/Vw+uzwVKUPfZgMAw/eAXfssPsBZkekMs8PC1gjFuWBcgjUroFhDY3
         JbTynEKiiEj9Fk351mnlJ4SmMenXfIReApgezQlee9ofbtv8w1+Cc3qlrHHQFDf8EVYV
         q12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vysnlRXYw/aOCYJK3a3w3iXK3uaa7j22KJHUUCfJpig=;
        b=KpmpckMAe1zjWCosgwffoD8B0jA3B1J7A2E2vfaGlhL8dUqUepoCfU3bx7uq/AD5W0
         kuqe+hp0kNMcFhWu0qGkiN8YSfc/8pFDXMEGaD7QtW8mSUbS0MJ+Jo3R4xRze/9Rsg5c
         SSgeMpEX6Z5AW/B7FXKpEEz/0I+DpGipoptK2Y3MXbawbA7wzb6kYLf9oTGDDOk78UDK
         Te/GEqUtKatZf7gBOMFYkZKCo201Ex3sluuf/GwsFY4BF2KulfwIHkxPDHsToALJU6Co
         oTPbTvr3VwtMTjjuKR5j21c/K29tE99iQx94gFkjWZtxZ4LM39Q7ZHJ9gVPvdeu9nl/8
         3xwQ==
X-Gm-Message-State: AOAM530pQn5g7Tw7c77621QaCb5S9iSoZfkWGJ1aiwiLYY9TyaRl4Ijz
        AshvpPZQ1R80Z9QszyJpjQFiKgFwW1Y=
X-Google-Smtp-Source: ABdhPJyLwKOdaD5X9ndPaf7AiVVXNFsqswO8HDbPODXVprqYJ4ovg16jr0mPmb7Cx/dtEG8uDB5X7A==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr11278653wmd.46.1626989331516;
        Thu, 22 Jul 2021 14:28:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g138sm31185212wmg.32.2021.07.22.14.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:51 -0700 (PDT)
Message-Id: <0047266de6bc2f7f198cbc73cbb1e8adf2581535.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:41 +0000
Subject: [PATCH v2 05/11] t2402: use ref-store test helper to create broken
 symlink
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
 t/t2402-worktree-list.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index fedcefe8de3..4012bd67b04 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -230,7 +230,7 @@ test_expect_success 'broken main worktree still at the top' '
 		EOF
 		cd linked &&
 		echo "worktree $(pwd)" >expected &&
-		echo "ref: .broken" >../.git/HEAD &&
+		(cd ../ && test-tool ref-store main create-symref HEAD .broken ) &&
 		git worktree list --porcelain >out &&
 		head -n 3 out >actual &&
 		test_cmp ../expected actual &&
-- 
gitgitgadget

