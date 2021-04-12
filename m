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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8C5C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0660F60238
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbhDLVJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243433AbhDLVIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB340C06138F
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y204so6192421wmg.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gXHTyk/0rr+wbe8rzhDt1uZ1A0ElBNbmaZcI4hkvDxk=;
        b=n92g8NPj336nQRolmUvTur7HdaM2qpUSWromvq6dqRFgCn7auvt0K1jSbUvEPcO7fE
         wui03EiGOkVvmcJqQdlgZ9NvyxxUNqG/frYwzmWpYXoZHAAc5W2VzbfBoBoG9Pd/AC9j
         fkEtcnEXYNAaBC31AHZ0cBKDhiLi6Jp4z4NXbNeHlR68rdNU6FWaRf5c2xuO3I9mdRq3
         VHicq4uwP8EryOR6QfgN5UlLS1VeS8SFISVI7BUocUbz9S8/9XevPqK0/ANcagpTzweu
         JYwm8U1qgLPk3QG8eRyQXXUaH+8kMtnc1CIRz9jRgB2TvP2wI3b9GDxYdOTy2FgZ8BKi
         XkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gXHTyk/0rr+wbe8rzhDt1uZ1A0ElBNbmaZcI4hkvDxk=;
        b=Tv6nBZfrnJKqciDUMzdTpuWRRjEyMztWPvQfunUmonB2xxFKr+/Ts+lzqDrVcdshIL
         dd+b+FtzPnst0cyqP/akiD3ATcuxakQwIL0OYWEc8zfYAS5X9E+ZN1rPbVtBbERpiLcv
         I366o5/3OJG7V6ZhpdEwK4WIxq8FfJ/exrrQOPEyWFz5WaT/KxJuRBlpo/B1UVnfYbdR
         HiCVQwoq8rB4tNTWqM4clS3lAAvk5mqjJG82+30+yGk9VCOKlQc8fB+xuElL2OGnbd41
         Det1VLiXF6sABumHTPU51FyRvA5PvO+ZPjoCAd+uOt2quYjtWcwmZI9oUO0B1JPwwcVQ
         n9+A==
X-Gm-Message-State: AOAM532tjatYlJsX01okFxN49EpkgBLB2BcJtwj3HEa9N6FJ6y7g5ejH
        V6vDaRfPteErUV/rfPoKp2bm4okmK7g=
X-Google-Smtp-Source: ABdhPJzwVir/NrkxpQkGW5HIhOm6YJkV39/jBSYZuHlircGdziATVZ9/5e4E5CzrRAFubwPqnN5+qA==
X-Received: by 2002:a1c:c2c2:: with SMTP id s185mr866459wmf.33.1618261712650;
        Mon, 12 Apr 2021 14:08:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t63sm478292wma.20.2021.04.12.14.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:32 -0700 (PDT)
Message-Id: <bda9cab159663cad9170527a826e204a88f91ac2.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:12 +0000
Subject: [PATCH v3 21/26] read-cache: ensure full index
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
 read-cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index 3698bc7bf77d..a9dcf0ab4f78 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1577,6 +1577,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 */
 	preload_index(istate, pathspec, 0);
 	trace2_region_enter("index", "refresh", NULL);
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
@@ -2498,6 +2500,8 @@ int repo_index_has_changes(struct repository *repo,
 		diff_flush(&opt);
 		return opt.flags.has_changes != 0;
 	} else {
+		/* TODO: audit for interaction with sparse-index. */
+		ensure_full_index(istate);
 		for (i = 0; sb && i < istate->cache_nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
-- 
gitgitgadget

