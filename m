Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C10C433ED
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5567861182
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhEEMPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhEEMO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:14:59 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFC9C061357
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:12:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a4so1587716wrr.2
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dHB+wtgwB93aSQ80a01wIjVm2/qqan07KrGDgiL56MA=;
        b=My4uwvhSLL0/bLMx9zr2p2fanqFet2jb3NywEOUJ0wy1bgRUr1U0OCxCHTEh4TzIR3
         scZ9kmZu9A6s5Hkyxc7MLb7FdwuX7BvIzLrrr6Ei4HN4QaXPxMegh7Gygxvj/zathLyU
         J1G3GxP95Z0cypd/niIPhMHhjKlcLliJGmHFd6uMZrO7DcByhAHGrtTO7obWyKtgkENE
         l9sFwQWGF8MoxojCjoYdvJ6ynhjbjE7RxSnHncXPTKHBKi8PyoCKLeVVSFWSSByfRb74
         oxVdn0iWv486DxS0X7fh4AflIB4Pzt9hOguEa4jHmJINjOmu8yfRwEdjpRnh/BoRlztw
         l36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dHB+wtgwB93aSQ80a01wIjVm2/qqan07KrGDgiL56MA=;
        b=hsv2VAkMy7nOl44waGaOAVeC+9xZOATFcHjGMKzh9qqIHFJdjS64fTKh2hfJYhloCE
         17A/MBvyybNamTqgwoaMOkx6L0y+ArCe5h4pvf/PxoN2DxD0Gew8U9Bwqzi/zQdzdWHX
         Af34uK0C0ZwemNB1Ia0jtIBYWbgkiy7STlz90qW+r/bu1YvQVy4kX132QW2LUxWqqX7Z
         TZ0ywysdS2ozduf2Y884s1NQw86tMKFMDvP2h6rGFaUUNCl4YYKCu/5DIN9bxwALzz6W
         TdQZItXzmKkMXdkUMBBSNM70G2KwvcYsWy9CXzXYq54pRpltdanSjsqrFRfM0EEHDrXL
         nP7Q==
X-Gm-Message-State: AOAM531AYbYvAnMBH9uU8ejwlvGplHBnnCAAiqbxCiDXV9gX/l3LcuHl
        iCmwEj6GbYHJ0Hs6yXD9PlcFUNQkHxb5fA==
X-Google-Smtp-Source: ABdhPJybJgqqI/+MDWvzn/8CG+MUq+FlG+AwFGdNi+9W08yxNkZFRIA/00dlhcc+t6BS9woQRPQqyQ==
X-Received: by 2002:a5d:6904:: with SMTP id t4mr37989138wru.394.1620216722392;
        Wed, 05 May 2021 05:12:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d3sm11144626wri.75.2021.05.05.05.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:12:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] sparse-index.c: remove set_index_sparse_config()
Date:   Wed,  5 May 2021 14:11:58 +0200
Message-Id: <patch-1.2-6872fd6a59b-20210505T121028Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
In-Reply-To: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210505T121028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the set_index_sparse_config() function by folding it into
set_sparse_index_config(), which was its only user.

Since 122ba1f7b52 (sparse-checkout: toggle sparse index from builtin,
2021-03-30) the flow of this code hasn't made much sense, we'd get
"enabled" in set_sparse_index_config(), proceed to call
set_index_sparse_config() with it.

There we'd call prepare_repo_settings() and set
"repo->settings.sparse_index = 1", only to needlessly call
prepare_repo_settings() again in set_sparse_index_config() (where it
would early abort), and finally setting "repo->settings.sparse_index =
enabled".

Instead we can just call prepare_repo_settings() once, and set the
variable to "enabled" in the first place.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sparse-index.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 6f21397e2ee..b0d5dc5f081 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -102,7 +102,7 @@ static int convert_to_sparse_rec(struct index_state *istate,
 	return num_converted - start_converted;
 }
 
-static int set_index_sparse_config(struct repository *repo, int enable)
+int set_sparse_index_config(struct repository *repo, int enable)
 {
 	int res;
 	char *config_path = repo_git_path(repo, "config.worktree");
@@ -111,15 +111,6 @@ static int set_index_sparse_config(struct repository *repo, int enable)
 					    enable ? "true" : NULL);
 	free(config_path);
 
-	prepare_repo_settings(repo);
-	repo->settings.sparse_index = 1;
-	return res;
-}
-
-int set_sparse_index_config(struct repository *repo, int enable)
-{
-	int res = set_index_sparse_config(repo, enable);
-
 	prepare_repo_settings(repo);
 	repo->settings.sparse_index = enable;
 	return res;
-- 
2.31.1.838.g7ac6e98bb53

