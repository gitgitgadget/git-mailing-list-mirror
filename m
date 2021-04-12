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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12D3C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52B161369
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244767AbhDLVJJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242802AbhDLVIt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F29C061756
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id s7so14202785wru.6
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7qKugyqjTL3Qic3WcAPItv5DSYivY5GEtPPJAkAOQqc=;
        b=KBpP6PA0nQJAOrRyKPergIr8Czl6FrT7L+fmPBQy3NFJYRbYrq1ZVRfm+3+JvQdvcR
         kxXJ3S8cT8fGbjx4RmMRwlJCQgscpUnrJgP6iSxYhYrIbhfeNMERvbg/iIbq4CKT0jk4
         qfWYuyMJwmBLVBV56HKzFC1z2m9DE0PbeTbLc0MQ2jA6ifpAw5x3YqqPGyXbZrdBdQM3
         lDZ4M14W6t2iHlJZnXzSzgZ1I+oHRF6vpb7sPbyuLAZLgFSsBdl4UzvE8RWYD2EQ1jY/
         2tGMnoJaFgQUz3JKSnnuEtQXaWAu8vY29DyczjKfpL8wIBRRk9AAqPIcTzg5hTqhaqGR
         GANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7qKugyqjTL3Qic3WcAPItv5DSYivY5GEtPPJAkAOQqc=;
        b=cgqFYlm4jSSN5XMr+deyKJNsG47JSnWqCPeSCDBkUG8QeAmP5VKyo1CD0z2WdiPWcs
         1XpFztvmebR0ExjwMW4tWqK5m3knh//Uef5L70NjgpMxyjidBjVX/+4z1N3UuF7OXEKc
         dWWhfVbjIeDnJq1uYe74KJ2B+JFg8Ib+yRxBRkGpRucUX6d90fZeZ0U/HNWx8kxa/YKn
         DwPiygW/nVfPHgmCrWvbdor9NY/QoeBFRYrb1NA9+vxbH8xrNG/x0CXIoGCRFWAnfpv8
         nlZ0LapzAIgrvElHuSAIskDUE5Sdl1WQefI3IuRHZpbrg4lvx9z8Pcjoo4i8JTt7BajN
         gDqw==
X-Gm-Message-State: AOAM532AlKvca3UkSQgbXgnl+zMZwHEBL12FGdkWI0QKE77cTErAJ4H6
        i2UrvyztGpvqfgbLZ7tADz6x4m5J3vE=
X-Google-Smtp-Source: ABdhPJzwS1C8Lp3ESJqkZoMe8kS/XvrPvULdoJgKT41gxBepyprFovfgWHF6jPHz7eLRZ5bZ5h3StQ==
X-Received: by 2002:adf:de08:: with SMTP id b8mr6709755wrm.279.1618261710120;
        Mon, 12 Apr 2021 14:08:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12sm8940316wru.47.2021.04.12.14.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:29 -0700 (PDT)
Message-Id: <08a62c23c8f77c9ea033bf4f7b8e164bdff8b7de.1618261698.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
        <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:08:08 +0000
Subject: [PATCH v3 17/26] dir: ensure full index
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
 dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dir.c b/dir.c
index 5b00dfb5b144..166238e79f52 100644
--- a/dir.c
+++ b/dir.c
@@ -3533,6 +3533,8 @@ static void connect_wt_gitdir_in_nested(const char *sub_worktree,
 	if (repo_read_index(&subrepo) < 0)
 		die(_("index file corrupt in repo %s"), subrepo.gitdir);
 
+	/* TODO: audit for interaction with sparse-index. */
+	ensure_full_index(subrepo.index);
 	for (i = 0; i < subrepo.index->cache_nr; i++) {
 		const struct cache_entry *ce = subrepo.index->cache[i];
 
-- 
gitgitgadget

