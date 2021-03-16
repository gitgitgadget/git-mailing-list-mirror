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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3F8C4361A
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FAC64FAE
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbhCPVSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbhCPVRe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:34 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FE2C0613D8
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so4483240wmq.1
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9VXqIdq+Sb0A+QKYOzZ+nfEqPsMqEM+6C2lTnqiptME=;
        b=K5WAIS1N8AmEvDQY9IRcSm18tpHKSI7RlZIJ0eGC0hQ14iKmtk4CFvcFJbpkn9b2cO
         U+H5yXjoxAPOInspEKjxBhTl0lYOR1onBIBWr0u2SU1ohVmlPzZeRk+eFj+c+jMEwvJC
         lybqy8AFArryGqKiNP5d+ZBS9kjlU+WQz5rDNj+C7OwOz3r2mnXxaqO58473j6M+o2sc
         UuLBIJWJ76rLDSCu9QEpEDNdmtSvx34YFjA7sLUJD+okgevu21nT+4xM96WAdSVmOKYm
         PF4DfZtS+up/16wB0CaBtg6pDRvKD3Riua7uEG54YVMXlcOOMUyBJ+wBblx5Ui032WB2
         M8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9VXqIdq+Sb0A+QKYOzZ+nfEqPsMqEM+6C2lTnqiptME=;
        b=ihLkWNlX0o7otvRcbEcxBtH3fGHKS/3wxO2c5QdYwOm13zzzYg5MeppMkwQtYTJe5a
         nsvF0/YWI5xDt1pPYK65fd7L8RvZ/lkQuKc2M+kGLcLSXr/XYKafHZmAGDadMo0Qcu6v
         U0mCjnJO77uUdttj3vFAcqrkMt5gOS/59CQxo/PuZCbE5pCmbxVRUZzfqgA6AJtzf3+i
         IPJL67r8pa6Z8IEu7YeUDMigCb1kWO3I3ZHFTs6BNtI55SGYQEH1axWmTF/cQNZwFiak
         zMd6RZLRzR8FfNPONl9S0UQObbE+stzuvKYu+JLgn1Y7aK0QviyGqZTWzOfenQegN/95
         SPfg==
X-Gm-Message-State: AOAM532y3Z2T2LsptvB0dA00robvxdYLoY09wSy3EtKVtcB/TZJw0Uwc
        1Nr+Gk+nh4C6JhiQa5PDojoh33SkpEM=
X-Google-Smtp-Source: ABdhPJxB9mS3s7nNE+ruGogLcMo752nVrzAnPaSlA0LZmlHk3OZKmYc59T46RhV0cf6GXrJ2a/rBhw==
X-Received: by 2002:a1c:8041:: with SMTP id b62mr725050wmd.0.1615929452272;
        Tue, 16 Mar 2021 14:17:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 91sm24466708wrl.20.2021.03.16.14.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:31 -0700 (PDT)
Message-Id: <81519782d4b233790ddf773b088db1e2cd260c4d.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.git.1615929435.gitgitgadget@gmail.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:17:11 +0000
Subject: [PATCH 23/27] read-cache: ensure full index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
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
 read-cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/read-cache.c b/read-cache.c
index b143277ed106..7449f31381cf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1576,6 +1576,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	 */
 	preload_index(istate, pathspec, 0);
 	trace2_region_enter("index", "refresh", NULL);
+	ensure_full_index(istate);
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new_entry;
 		int cache_errno = 0;
@@ -2493,6 +2494,7 @@ int repo_index_has_changes(struct repository *repo,
 		diff_flush(&opt);
 		return opt.flags.has_changes != 0;
 	} else {
+		ensure_full_index(istate);
 		for (i = 0; sb && i < istate->cache_nr; i++) {
 			if (i)
 				strbuf_addch(sb, ' ');
-- 
gitgitgadget

