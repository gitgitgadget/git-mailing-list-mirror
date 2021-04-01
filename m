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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20E8C4361B
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCBB610A2
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhDABui (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhDABuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:50:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2B9C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x16so191934wrn.4
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bdB5os8ysADiA9ihl7DyMq1Tj0074xySPTMD9uYQI04=;
        b=M/FqdlHbw8nUMck5A6jUqhBTUq7h/YU4BGZ7EGklRsnU31ZXKVhQMrBsfbne5ZqMvF
         TGFR5Lg9bapvzC4Bh8Bgbbp59P76LI0oTA2nGnMn4Pc+eI1TqGc4gUDlnEFbJNeaPMcr
         gpZQ1uvnPeqxpUTRYrXtGCTSStC54h0BaUIatQ1kKUt/92yLdR+eRFeGbQstzu/lRPs8
         NgJiERtB5j+KLm8d5UXil9+MKFmqh+L8cSgsBa/os05kGyU2PIuD6105O6dekya4iiYk
         ghuEWL+l5rmISWXlCJEvuroonQquLw4ZiZZeULqpojQKRk7dNDHR0lCaLJuUdu9c9f85
         wF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bdB5os8ysADiA9ihl7DyMq1Tj0074xySPTMD9uYQI04=;
        b=j2U2gjhVRoM7sZxTE9diDh6fsD3PO1CrGf1wbxpo7vQRH0uMAYOfKtlXD7H/Bv+Y3k
         7b4wdxjIGRLnxqLmpYJULpWzvTJh0BudMXgA8qsTrGXQrOMhQVlP7/7U5f70nvWHtuEi
         c6yHW7HA3YJvTvtG9pB546UdmBlKzMgbsz4UqaHsRbFmow6oWmHTs73M3T6hhn03aFC9
         BesMJKT7NPz72rkEFsutgH3KvFXpFLB+M7LNua0m3uhlEzlI//9Hz9lKCuhKOooJcOz8
         VZToDLZgnoIFs67LZLLFhcG51xi94ZZcL5EyWcnOClGniWgRVK4uhuHnU6AyzgImNLo4
         hJ6Q==
X-Gm-Message-State: AOAM532/wW7g6Z2nqrMbOe+o4Ts816HzYsr18OfX6OPaTffJVaB/7OJO
        C2jmtBUhre63alf2zBjelelvfnwtXQU=
X-Google-Smtp-Source: ABdhPJwtimp+9KpoKqaTvVW7VAqtkFQU/k9zj3dIjFPicHr3sURUKKiZoIeOq4UK38fxCyQO/2K4rA==
X-Received: by 2002:adf:e481:: with SMTP id i1mr6903284wrm.63.1617241812355;
        Wed, 31 Mar 2021 18:50:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 64sm6046656wmz.7.2021.03.31.18.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:50:12 -0700 (PDT)
Message-Id: <6ea81a49c6b51e98f223b59df6e8e73eac894bbe.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
        <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 01:49:51 +0000
Subject: [PATCH v2 14/25] rm: ensure full index
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
 builtin/rm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/rm.c b/builtin/rm.c
index 4858631e0f02..5559a0b453a3 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -293,6 +293,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 	seen = xcalloc(pathspec.nr, 1);
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(&the_index);
 	for (i = 0; i < active_nr; i++) {
 		const struct cache_entry *ce = active_cache[i];
 		if (!ce_path_match(&the_index, ce, &pathspec, seen))
-- 
gitgitgadget

