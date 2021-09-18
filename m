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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0DFC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840BA60F9D
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 23:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbhIRXQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 19:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbhIRXQx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 19:16:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30457C06175F
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g16so21525372wrb.3
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 16:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SYquEVrbmwckyhynTdj/XoNgNvOdK5s/HwKoK92MltQ=;
        b=h/C3GX9fppZkVoCkDqysPZJHDsid3HYpMpzcNMHd6Whoj3s30IwZJEjXjeuGvsq00a
         iZYRUwswpsL4ODkvEYmT3Dsy8N63vcxgCfsNWjmUCrsOk1aFeMgMsv87W2R5B3NUmQXW
         5M7locvKLQphlZHnTTB/epntQTWogPXETto6da+pKCMJAPMayrqKWo+ndW1HD+gCIEdf
         unXtPJy5imQDDs6lauO96OQX+VnaWX2dA09OxfNxwg5gRFzyWQ9w5ce+YbSKAYSHdod9
         SxxIsREaSjYbPRrcM8Y3wpZeVumael7N5fGMfmFEMeyqMNqTAGQeJjGNf3x5BD65L84W
         ccIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SYquEVrbmwckyhynTdj/XoNgNvOdK5s/HwKoK92MltQ=;
        b=LRpYdv1jq+EbJ4aHo68m3jmr4q3x/57fsj6HlxtPltZ+u/K4H0wQyRbKkzf3XwawYI
         JbDoanZGKxyz7dRupO4XA8nvv7i2dRywIF5ddKSkyaTKo2Oqi1qASMqu2ZaACCfoqt7S
         QWMM0AvNrxLasMyKAPEtXq3pHIfRiXS7XePw0HOHdySaujL1JlgAMSREXkAfc3tkLYwx
         HkImnacX1L9fNYziPOxaYR6syiLAUTLJmr/HJ35eTGumgJnYFvFH2JtBoBA/Rj0Aagnr
         YmtJdGGf28uH+oYppr3WoMaLCzE2mfGGgNd7m3in8A6KXblbs82WHloiLniJJf4vp7h4
         exwQ==
X-Gm-Message-State: AOAM530b+1z0s3wcHZ16+2L1igKjSXz/IX16F1alQoMQMXq2e6YX3rTD
        HmA5hq479JhHKOnKn2QK4dQFbEHPirQ=
X-Google-Smtp-Source: ABdhPJzE2+EeR230PvepC6h72jI+CgORSgyPofeMZqbX0ZibeoOHQeajGPs+Lm87nmvgyMDUfJkgJg==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr20291945wrv.405.1632006927886;
        Sat, 18 Sep 2021 16:15:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z12sm10877623wro.75.2021.09.18.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 16:15:27 -0700 (PDT)
Message-Id: <01bf850bb0f0796564e9363d7faeb792a594f684.1632006924.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Sep 2021 23:15:21 +0000
Subject: [PATCH 4/6] unpack-trees: avoid nuking untracked dir in way of
 locally deleted file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t2500-untracked-overwriting.sh | 2 +-
 unpack-trees.c                   | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t2500-untracked-overwriting.sh b/t/t2500-untracked-overwriting.sh
index 017946a494f..d4d9dc928aa 100755
--- a/t/t2500-untracked-overwriting.sh
+++ b/t/t2500-untracked-overwriting.sh
@@ -218,7 +218,7 @@ test_expect_success 'git am --abort and untracked dir vs. unmerged file' '
 	)
 '
 
-test_expect_failure 'git am --skip and untracked dir vs deleted file' '
+test_expect_success 'git am --skip and untracked dir vs deleted file' '
 	test_setup_sequencing am_skip_and_untracked &&
 	(
 		cd sequencing_am_skip_and_untracked &&
diff --git a/unpack-trees.c b/unpack-trees.c
index 3b3d1c0ff40..858595a13f1 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2395,7 +2395,11 @@ static int deleted_entry(const struct cache_entry *ce,
 		if (verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
 			return -1;
 		return 0;
+	} else {
+		if (verify_absent_if_directory(ce, ERROR_WOULD_LOSE_UNTRACKED_REMOVED, o))
+			return -1;
 	}
+
 	if (!(old->ce_flags & CE_CONFLICTED) && verify_uptodate(old, o))
 		return -1;
 	add_entry(o, ce, CE_REMOVE, 0);
-- 
gitgitgadget

