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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2146C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A9B60238
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbhDLVJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243496AbhDLVIx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4CDC061342
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h4so5292449wrt.12
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5ujY+w6SXlDeI30iu//cxteaQB/3nSsRybSiz0GS0fM=;
        b=ThkE5qKrUX7062q6R4WCLsurlCmrqjRl/At9Ni+lrV/+N7U/hIW7eFu+jE6T+kms0j
         rMSpyOaTj3PMp6Pyslg+xptB7uvteHhpNhDxOi8PotvUJxxh+Ep0Xlk4LliuIco8HHvP
         R2B49akYRhf6t8R7G6I1qHExY8/sbIxONY5EsKwMMPq1Zx4lNGEit5z62jdzSgS3Yuzn
         IVTrcj/7ozXsOXDaEA6UQKyWfs40NOzsyVEEnJa0B31j40Fw43PEY/HhAYiT16zpbwrl
         h/G6vaKHeb6390Y4yey987qs4H8RQa/qSwKRVDGmiqXMttfWdNp7lDkoxU9vTERcHgax
         z7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5ujY+w6SXlDeI30iu//cxteaQB/3nSsRybSiz0GS0fM=;
        b=LG3eHESQA2Kh0XIbZ/Ke6oxJLtw9WVGaXdTH9Ah8DV1o6D6BU8kQR87YOksSog65Gi
         +nNJ9QlUPHyCRvjpj0rFRdP3PBGQrRZBrwkuBiK1eLk/K6MMZOqxxk/zcqfzrIirS4Ds
         /eGvkV9v9ya/nxgucIjake48S2R68VlrgehBwCAI5/oE0kYzxNiL2RDj1Qv0bbUmU98F
         PPWlUyXYHJAMYGvmLFTcqXgndjcVOLSDhBc3t0dHN5hlYv/8ND1z1UyFXE3rUJF2U2Bd
         9kP3WT4OT0LSVocy9Si90LXO7Drpq2/OwlaJsDpcRlBRfBx17VtwipkjvMc0OmvzQ50E
         lJ6w==
X-Gm-Message-State: AOAM533D9bMM4UFnUHm8lBXLopH3zFA9M6Lu2ylZIO9JRYR+p5SataR6
        2aWld69bScBdjsg2s9HxAsgoiXSOJB8=
X-Google-Smtp-Source: ABdhPJzSvo1KU9CQbyJFUxIL6YWY/Jw4Xxe7dcoqSryIqcNuDAmOW/vFwF8DTm0F2tEh/gaUeEfmxA==
X-Received: by 2002:a5d:6a11:: with SMTP id m17mr34404667wru.361.1618261713194;
        Mon, 12 Apr 2021 14:08:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm5988031wro.1.2021.04.12.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:32 -0700 (PDT)
Message-Id: <38f295a41ec1bcbf0a67b0b1e12bd2590877f576.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:13 +0000
Subject: [PATCH v3 22/26] resolve-undo: ensure full index
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
 resolve-undo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/resolve-undo.c b/resolve-undo.c
index 236320f179cb..ee36ca58b135 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -172,6 +172,8 @@ void unmerge_marked_index(struct index_state *istate)
 	if (!istate->resolve_undo)
 		return;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (ce->ce_flags & CE_MATCHED)
@@ -186,6 +188,8 @@ void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
 	if (!istate->resolve_undo)
 		return;
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
 		if (!ce_path_match(istate, ce, pathspec, NULL))
-- 
gitgitgadget

