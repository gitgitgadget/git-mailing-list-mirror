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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002D0C4363E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E231B61078
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhDABuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhDABuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8220CC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:14 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x7so172515wrw.10
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P9rJd368hm+Jl6xbpIBIuWVC2ZyfP3m2Ah742l9tbUc=;
        b=Q/EqsvSsnlXuwRai6R10KSwGYW525vJRpCfL3gc/ytAF9Pv6uVJ26cM8nS4y6tdrx1
         eAs/vloywkMhRZ2BqsJ4T1nm5gxoLyUzKKLfaLwmxoLS+CZcHwrfum3nXlkaZd3nzlqL
         YlkK6Nbqypr0H4dDY3+QJu1r5hiwyuS/fgCrt7O2gX5qhISYMV2CF7eJMaA+1uFjUFq8
         +eV5PcTQuprVEJV1g5LhBkaEMQUcd1dd64ECNOGA82jHbNsERN0EcEywQ3swOMECcabd
         UcQSiINl//8SDX8AlXVpGJlgH+N4LsDclWZ7799Y/b1OMl1545sniHUPRPKd5VHov+Yn
         ESLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P9rJd368hm+Jl6xbpIBIuWVC2ZyfP3m2Ah742l9tbUc=;
        b=LPnAgqn1oegGJeTD3bsGDTLAk+kUeZX1t/Kl/FeZfOJBKelMwWjAs6G+O3GL1Oitgt
         kG9QKzdVi56tDVd7KTirzwFVSnT2rqM9dGhdkLPIZxaiAr8pdpa4CT8Yixd20euq2FQa
         /IyLKcojaXttsRYZnhZ4sTRrx683CGeQ22L/RpvEsorH/4/FjEUnjTCtBYzSN+n+3gjf
         TqftXVRQi2SzyMnkb3yUJTZUPFe2leoLCouf52JlOHxMpHKokcM4jTlciXqnbbQxTlMK
         lW/hKvgzzduqU80smair/zZhtGlSSVjvHWrGe57y+Ft4aOg+S/FeKmFREYgfHYImuUQb
         6cmg==
X-Gm-Message-State: AOAM533rCQ/liNYuIrWLrPf/IVLmY9PTdCsMLVv6/P0ZetNPijlpEDmc
        8VjeJgM58U2ALRMPck7GGoqdREhPyHU=
X-Google-Smtp-Source: ABdhPJwl/xMLPZCG7Mmz75zlQnH+AcWBHpbHNUNdqCX8Ktg/9dIae3OqF/dk4B7Wxd3VY61UkcEbGA==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr6343023wrr.319.1617241813391;
        Wed, 31 Mar 2021 18:50:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b131sm6129013wmb.34.2021.03.31.18.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:13 -0700 (PDT)
Message-Id: <9c4bb187c15da527f2a1692cafce7ec844a94ae1.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:53 +0000
Subject: [PATCH v2 16/25] update-index: ensure full index
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
 builtin/update-index.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 79087bccea4b..f1f16f2de526 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -745,6 +745,8 @@ static int do_reupdate(int ac, const char **av,
 		 */
 		has_head = 0;
  redo:
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (pos = 0; pos < active_nr; pos++) {
 		const struct cache_entry *ce = active_cache[pos];
 		struct cache_entry *old = NULL;
-- 
gitgitgadget

