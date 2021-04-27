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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D047C43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B1C611ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhD0Kj6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbhD0KjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E9C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e5so30287246wrg.7
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WBFMjAzMsm6q7GZVJmwx/+ybMpJoFJktW8A5rzbiCy0=;
        b=SzWV3QvqCYo3Ju+/FPlWPOaN4aX3dzKAeFc7H9KpS6H+toPETufJL+WW9cl0PxsV8Q
         ZQGvLeEJ2RTehbVx+gf4BqeP/EGEHQzVR41S2ka2xp5bFxs/uFOfxbFZV4eeHUIpCT/D
         HPdZQKDiefQvxzCOprABkDr23JNDUk1cnU+ISxHyQ8IFP65eWU2G5xDz9TZ4byZNCFVI
         rhP7NO//ZjKPfDc8WG52NUaOsY3nVraZPv2ufMNumh9rlLuNyln/1AF/h3Ex6RjUAdGo
         n59mAm/3fyFmG9tCsO6+fzBlYqc6L+TsjKB3YSPVhO0FQHScYZy7wa+8YUOJMI4oOMpW
         jIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WBFMjAzMsm6q7GZVJmwx/+ybMpJoFJktW8A5rzbiCy0=;
        b=IWmgsZDQppHR4uuu6SYNFWyjz41MiV3EJcysv2+clIXv1EnNoeADfqMojDwjZTRGfK
         EBuc9nAvjXTDB2hcj32Uh3hf17GajgvJQEfCVwCKdN7CyjLFWKgkcaMUY2tpeb4Xjf04
         88ftVXpAKSqLwzmuKnCx8C06y4K02zhOpbXUhUAWyGB2MCLyt6epp7OluOPyMG59pA8e
         hNvv8VRUMGX5yCGRNeBSzieNcj3YyxILn9su2Nl8EkNRhg7nBIW4w5aVC6Kf//t6UlyQ
         tOb9P2cW9w2kkzUUWd6c/9wQCzGhWiY8vjeVq5AOT2+CKyhtSOvv8Z+tXePZSIw+9pYM
         eTFQ==
X-Gm-Message-State: AOAM533Gt9GfVrNc6aiBkjIiU1Jd70cA1GQgho/M5Ei7iKrgzw55ie/c
        OaX7iYidombAZsXt1F/HucFRjJf+vuo=
X-Google-Smtp-Source: ABdhPJyXex++3IVqdmbQMCmCYrsmQWXPvzSemcNOvOU1TGNmnhhkWKCxfJsP0W14Qs4o/xRKsp6ZEA==
X-Received: by 2002:a5d:4d0b:: with SMTP id z11mr29413521wrt.164.1619519914257;
        Tue, 27 Apr 2021 03:38:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm3544710wrs.25.2021.04.27.03.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:34 -0700 (PDT)
Message-Id: <ff3b67c84c412dafaa506355e83427a731b47623.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:19 +0000
Subject: [PATCH v2 18/21] t7900: mark pack-refs tests as REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Reftable automatically compacts tables on writes. The functionality of
incremental compaction is unittested in reftable/stack_test.c
(test_reftable_stack_auto_compaction)

In addition, pack-refs triggers a full compaction of the entire stack. This is
exercised in t0031-reftable.sh.

Given that git-maintenance simply calls out git-pack-refs, it seems superfluous
to test this further for reftable.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7900-maintenance.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 2412d8c5c006..6f2f55a6c51d 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -343,7 +343,7 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	test_subcommand git multi-pack-index write --no-progress <trace-B
 '
 
-test_expect_success 'pack-refs task' '
+test_expect_success REFFILES 'pack-refs task' '
 	for n in $(test_seq 1 5)
 	do
 		git branch -f to-pack/$n HEAD || return 1
-- 
gitgitgadget

