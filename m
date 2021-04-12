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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974CDC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEB66135C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbhDLVJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbhDLVIv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2631BC06138E
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y204so6192408wmg.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xOPUNFGXkgQBSC36MohDBVpe4Y/fE1xOn5Zg727kSss=;
        b=IyKjaH/sw3WVd3l2I4fKZBsWh2RMJEzGGxaeAXj5BaJPrvDGj96CDuWHkZRe8led2q
         xhhQ007fnwLd7ZB1hGIQPIOy3APIqblWIcnCF2O+NbgoT8yjfgNgEgtqOBFPnOPNyk7F
         3egB1MTmUcNT+Jviims8m70sF3wzK0xmFpdbrPJC6hHgLS6t2HdjOGdzYj8LFXypjI/+
         c6XrGUmwz/YOLUqr871SD8AH+Qx/e6aOo0fk+KRLLLPK6Y/GI4zijk/MnB6qRTOJ7c+H
         QffX59UHdAv8w0LyEpfx2+3wfpyb/f1ZiPIVqq2G2SXPtuO2yXhAUvXkyIKng3tWc6Dt
         snIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xOPUNFGXkgQBSC36MohDBVpe4Y/fE1xOn5Zg727kSss=;
        b=cIbZX+buOU7gIKHykdaEPSOXQmYq/+06e2yOixCOnSDtoxB/0v/zWLzOOVj3Nlxd7a
         L/0wzh7MMc+hXMDb9XB5fqcUznQGDG9NpEeGeVC6K7TNoNC9j+cXRTZ5QXSNOdKFZCFN
         i0FEdAhOigIPvMmGY7gHdLbWMI1tWg40pyBZku1XU15XbmprSjC9EszGLrwK37dJh+Pe
         eT1/mBaC5wv7TJHbVYF8MqLTJRNV7lKTLURaOtXR8HHSZ/ExSfKnppS1hvfnsUpv7CVK
         tj9OOBjK5UuR+QeJb9ApmA9hoC8bJNNZtdBVEjelh2CmVzy8UtI464/iFnYpEC9NGFNB
         97ig==
X-Gm-Message-State: AOAM5315eaXg+cnD6LOEHEKEhYRpYg2qI9WjYSeU1uIVEc5jhzIhIiHl
        7zlGtYeK83qOQpXpTndYnhC3H1IkNtA=
X-Google-Smtp-Source: ABdhPJxB/ALf2MqPhrsQXLGvWrju7Gs4W6oUBlGt3U3IiVQt0Ra9SE+r/encs77iZjZINDKUHhCvkg==
X-Received: by 2002:a1c:658a:: with SMTP id z132mr846118wmb.39.1618261711989;
        Mon, 12 Apr 2021 14:08:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x14sm17574120wrw.13.2021.04.12.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:31 -0700 (PDT)
Message-Id: <4d3f6de29a6393e46923bbaece69ed7e21a03101.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:11 +0000
Subject: [PATCH v3 20/26] pathspec: ensure full index
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

