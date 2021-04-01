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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9659C43618
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E9E6023F
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhDABug (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhDABuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:12 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71BDC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z2so189830wrl.5
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AqzgF3ydQhx2SGKGBO9a/JEpTg8x4sKJCQWGxp4c3hY=;
        b=fN88q7UJGQffTF18jUED8/zfp2PAl6MCduHfnLKQbBZWRLr4SLa82m85UHfXWfH0SF
         OULuBmQFJQustz1ouY08t7SsDwyu9A6Qc62xcqQFA7Io57hRjmNB+1DVV1XRImwfLBh/
         Y6dNLOV2LkVe3yfcCsJmYObHYsx0U8I4M4uR3lYoi7RCiBxmN3z6COAg9QuujZYUZxZQ
         hsLIfTzTrMVNLDKOD450RMBuOGh6vyKipjncLN8N+uzjozpcVTkQXHx2D3Xf1g9mOyvi
         /8I83dMK1pNPgZ62tcThYmyk04TDqHy6W83O25gnykuznPdNdN+5eyITYcJ9A2FiC4if
         7WQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AqzgF3ydQhx2SGKGBO9a/JEpTg8x4sKJCQWGxp4c3hY=;
        b=pEm5g0PuVJ5hABhrUQUV/MwnP3d/LHLvWOZec8IsHvGwZPPa0PTnryNVr9VAvW1DJK
         T7LXSjSmGSKZRh9c9zq/WAtqr5LuPQEFEqlc9o4FJlGFzyocdIgPb47XL5N89krws3TN
         zfwLkj0aZCrOyWbU6XUyJFrSfU6WjepEmVK5rqh2jTRTjIaz5FFC76fRkoo6iK1Y5HH1
         HWZj5xasXY1L0enAGy4dhDISXV+MDgI9fl4BswQab2ioaQMntiNN2pSmaBB1pkCL8tKZ
         17BxbsvkbpRV24UYAUuP2aIlhMCddZn4DWf+XltEUJ7NoCWTqktgUBdEEe1MGZowZEqu
         oZPw==
X-Gm-Message-State: AOAM532Xmkz5WK9LlMRYiIFNM291dwvcGlCD11LqeNSDEvK3zuWz9hGX
        3U+68Raj/wNLQlLWprVwGhjq7cWPbPs=
X-Google-Smtp-Source: ABdhPJxFNRHbzB6qtwp9fo9zTg3sAROqaWTERr7kEWB48WGShcRcK1zqXfrvZOIEWkXu2ydAowdzgA==
X-Received: by 2002:a5d:410b:: with SMTP id l11mr6727379wrp.16.1617241810791;
        Wed, 31 Mar 2021 18:50:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm7362554wrt.1.2021.03.31.18.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:10 -0700 (PDT)
Message-Id: <8c0d377054fa126f6b7426f8d87cd9bd57f5328c.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:48 +0000
Subject: [PATCH v2 11/25] grep: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Before iterating over all cache entries, ensure that a sparse index is
expanded to a full one so we do not miss blobs to scan. Later, this can
integrate more carefully with sparse indexes with proper testing.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/grep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 4e91a253ac3b..c2d40414e975 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -504,6 +504,8 @@ static int grep_cache(struct grep_opt *opt,
 	if (repo_read_index(repo) < 0)
 		die(_("index file corrupt"));
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(repo->index);
 	for (nr = 0; nr < repo->index->cache_nr; nr++) {
 		const struct cache_entry *ce = repo->index->cache[nr];
 
-- 
gitgitgadget

