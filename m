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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B22C11F65
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4F961CE4
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 02:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhF2CPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 22:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhF2CPj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 22:15:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633E7C061760
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:11 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u8so10438885wrq.8
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 19:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lX+phGtUUNbbXIoUjtKs9N0xtQbw6A/3yCrL+FgxfnM=;
        b=AWwslph0JnXtOD852oLlfRuJSw4QT5cUuGptsrGQNHtW7YIDoJuT95GWbmfAJaquMH
         1+qI1x6XFT4TVUHdhl2fbtol2adh97YAJHpjSFj84zC3TyVnWIogvEGVlsq0rLTKy3Zz
         NpG52j2MKAtUVTsKpHQpMGclQ77vsVO5TN0mnd1kuMWuAZUZDT0CsPMiB5xlf47xS/W1
         OWzkOy3VSuMJQovnTAARZMCPjjx9ab0FaYrhHu9P9eGN9Psh3dzr4UaALegVEkEo2Bw4
         sIwKpwBUClS2xDmn/YFExoJG5zMt9WKfu6PCP/9Cg/1YbY/3bZFwZZOC9vRpmMrvE0BM
         MK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lX+phGtUUNbbXIoUjtKs9N0xtQbw6A/3yCrL+FgxfnM=;
        b=ECuMvkufyg+HqjkQJDWNn0A1y8JyLT9eKWLy7l76vROjXW6N0VdBhxodHrbL0blFBE
         o90mk0GSZDxuHZLxQTi+wxKtgzQCKYzWp1lvvxaIEVMJibZ8Ka+YzRXnaP4B2q04aYXz
         JAMKNgeEwOBPSvi/Xt+vpnhJoYS8RKtCgAL/VrQP1QEG5x3uJ1BLLMr9GNAuXanPrxGy
         Xlq715CFdH+mOTFTJl++WZOngdN5mNcBasIWj/kdCdn2XFjaa6OD80kHVNVj1rK59KxR
         gfz5r87m1WzMciMllcZadVsZAXkXVlNUfui5cMKcm5U3BAZDzpjiFtmwvnymZQ+EEG4Z
         FvCg==
X-Gm-Message-State: AOAM533Idbw1pFET8Ykovu3oWQhY6Y3GkPGxP6WuS0HQrktZwC8qfYZJ
        j/MuZIwyP15M8qD16DlOSKSBz0vOYYw=
X-Google-Smtp-Source: ABdhPJzl57MH4kVyqmEgSUXIbI/fKkaYEt80nBDaP+MNqwa9YTAMhM5lI2Oco7Es3f75p8+ZkiDbQQ==
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr30223818wrr.374.1624932790065;
        Mon, 28 Jun 2021 19:13:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7sm8448712wrp.97.2021.06.28.19.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 19:13:09 -0700 (PDT)
Message-Id: <ffe8473caab5189961ec29464629e13abbe310ed.1624932787.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.973.git.1624932786.gitgitgadget@gmail.com>
References: <pull.973.git.1624932786.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Jun 2021 02:13:05 +0000
Subject: [PATCH 4/5] sparse-index: recompute cache-tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When some commands run with command_requires_full_index=1, then the
index can get in a state where the in-memory cache tree is actually
equal to the sparse index's cache tree instead of the full one.

This results in incorrect entry_count values. By clearing the cache
tree before converting to sparse, we avoid this issue.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 sparse-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index 53c8f711ccc..c6b4feec413 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -170,6 +170,8 @@ int convert_to_sparse(struct index_state *istate)
 	if (index_has_unmerged_entries(istate))
 		return 0;
 
+	/* Clear and recompute the cache-tree */
+	cache_tree_free(&istate->cache_tree);
 	if (cache_tree_update(istate, 0)) {
 		warning(_("unable to update cache-tree, staying full"));
 		return -1;
-- 
gitgitgadget

