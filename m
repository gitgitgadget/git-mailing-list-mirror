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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5269FC41602
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E779610A6
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhDABuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhDABuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A23C061761
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:16 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j20-20020a05600c1914b029010f31e15a7fso2034724wmq.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xOPUNFGXkgQBSC36MohDBVpe4Y/fE1xOn5Zg727kSss=;
        b=Tp3bjBNEdl4AFXDb+nzhbi4PDdC99yvaD8ZC70RsviWBMBQeu9N1jQg1IPFEf2vneU
         1HUTkCiM/HXhCmtKs2VCjsPomzF9IMIOtXTKulpzG0GqWzQKxfV60Eo/aTrS05TCZH65
         So3eavzkB6s56to7aBAdB+JPqJIdXKN1WDzmMgrf9ByJfTdgV0m3AU7rXF+7kEAOH5qY
         qY5MZ74KfHkKICIaYGC+das7ggmIT4CnvbZ1qGB/BHnqA7SI/kxKI9TGGEDRVhncFj1w
         LLEFS8QVTB3FLW0lvZYHjdaTLOtBTtXWBgyiiFV2uHwR0hkt+h/FldSH0Jm/N5W3f4NB
         n47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xOPUNFGXkgQBSC36MohDBVpe4Y/fE1xOn5Zg727kSss=;
        b=rODgpc37IelcAd+U2X8Rdl6sEs/UdGfP82PzAqQjRF6ekjD72D1+KmmHRnTGRKrqcj
         yqXBJnhf/mhM493ll5qChcIEDfzuMbrd/RG44QGmE7Cmim7qZLU1cH3AI0GqPij5WmVu
         /80/NZIHbwzyDYx/N3gOip7tNPDfgcAX+90zcQK30XYUik4Gm6bkfLq/vDjgSTCRa3Ap
         RnCvQzHlU+SyuZkOKMdHyDzRkQpEh6/M2Oq5h4HUN2mpuMbOUoqvYRV1n/JUzs6SYgxW
         3llYvvbEjmgLf7J1VbhLhziWyqCBYCfnsJX6FyYHlbCOuxV2NTzxcL2DC+gb4HqbXTBq
         eVAg==
X-Gm-Message-State: AOAM530d9pg1VLS0vg+IK7z0u/07nkWOVO2A07ox2j2M4hkXrgqm7X3U
        0HPcve786esRCgZX2AngbeKQod1YZis=
X-Google-Smtp-Source: ABdhPJwRBrVVfQf2VFeBGMCbq9AQv51iVTpzPUH7WZ63obdzQHozRTvmmT6Swr94xbM77yeTnxFfow==
X-Received: by 2002:a1c:7e16:: with SMTP id z22mr5542475wmc.74.1617241815577;
        Wed, 31 Mar 2021 18:50:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v7sm6439081wme.47.2021.03.31.18.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:15 -0700 (PDT)
Message-Id: <e62a597a972582828356d2d270554bec52e8ff96.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:57 +0000
Subject: [PATCH v2 20/25] pathspec: ensure full index
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
expanded to a full index to avoid unexpected behavior.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 pathspec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index b6e333965cb4..d67688bab74b 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -36,6 +36,8 @@ void add_pathspec_matches_against_index(const struct pathspec *pathspec,
 			num_unmatched++;
 	if (!num_unmatched)
 		return;
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		ce_path_match(istate, ce, pathspec, seen);
-- 
gitgitgadget

