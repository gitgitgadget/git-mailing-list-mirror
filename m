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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFD3C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0F22229C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404579AbhAZQCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404477AbhAZQC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E785C061D7F
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f16so2881388wmq.5
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DVeZznH2fU1xeM9jKJdLFnNSw1D+YZp6mUDWZr+uTgA=;
        b=XLJyWmyCeayUpDX/A134m0k27Uh3HMV3pmeWy3DDaWL2rTz1YWGeTIl+WLhjwJFJlE
         L9C+qQ2AFH+GuDfiEPMXgkd1UH3suiTKTFicHnAadMpXJBVh36H1JViJZmOph5LUf3Wq
         TR/S/oOlGWwheBDKPPe/XsOK10Gc1KOYgJemNROeWolg38uWBKSzOreTCgXG8E0F58i5
         UnqwLu/JwC2Uvn0UYkigS6689evby+Vvh9HS2r8wEXrzKP4Uz50IeCFpf/N2X6c9Z3y/
         fabnDxnYZIQsTQPG9sWGoaHHVaPGYrmbQGeN3hl0+xq+6aMkmPwCbIe+fFAmXECIFAJX
         fbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DVeZznH2fU1xeM9jKJdLFnNSw1D+YZp6mUDWZr+uTgA=;
        b=ScRzIeCxKdUEgnJTQ3HaSTHDK9fsiI/P88FTdzfWkGIxLpmJGtaUEAjpSS+j+K8rko
         W1xQtSs/VUKaZXqMWQpRQtS7oUa0a6KsIkP/NRPZttF7ycLqzTD6k3i8/aO6yjQbMg/j
         drkW1xvC9W1Bnm8zycdyQa/HqVMGVEZnuRmFAevJkQKUXGkyQQ58LwPfJdG96fzOMzZg
         RLM3ydYM3A1V3f/u2x1rsJd1Wu1Iz5VRhWUl2WVmcPmWz5GxreaTKcJghZYKd6ILCSeF
         NUmEtf5h5+AEJT+goZYNj0pl0POgwb30KCYHlgKHxuLF9DsWQn/xE6Hzb0BlBW0SlmCj
         A7kg==
X-Gm-Message-State: AOAM530U7t+lhDZ54JFi82zeitzpI6OdEsbSbB3/NJ3OANMFk5lEkesT
        5/iGrGEAEp6YQ1kngHt5Ttj5EOdPOuE=
X-Google-Smtp-Source: ABdhPJxKb3hMCss6ta64D8c+3Xtswl9bnHLQR6nPYE8RkahG8C6UvHdgx4HB/beuxQfeQDWYLdVDiQ==
X-Received: by 2002:a7b:cde1:: with SMTP id p1mr353095wmj.111.1611676892880;
        Tue, 26 Jan 2021 08:01:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm9284738wrx.2.2021.01.26.08.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:32 -0800 (PST)
Message-Id: <14a0246b98257cf0eb00de88b1a04409fc60138f.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:14 +0000
Subject: [PATCH 05/17] midx: use context in write_midx_pack_names()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In an effort to align the write_midx_internal() to use the chunk-format
API, start converting chunk writing methods to match chunk_write_fn. The
first case is to convert write_midx_pack_names() to take "void *data".
We already have the necessary data in "struct write_midx_context", so
this conversion is rather mechanical.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/midx.c b/midx.c
index dfc1a289246..f348a70e018 100644
--- a/midx.c
+++ b/midx.c
@@ -643,27 +643,26 @@ static struct pack_midx_entry *get_sorted_entries(struct multi_pack_index *m,
 	return deduplicated_entries;
 }
 
-static size_t write_midx_pack_names(struct hashfile *f,
-				    struct pack_info *info,
-				    uint32_t num_packs)
+static size_t write_midx_pack_names(struct hashfile *f, void *data)
 {
+	struct write_midx_context *ctx = (struct write_midx_context *)data;
 	uint32_t i;
 	unsigned char padding[MIDX_CHUNK_ALIGNMENT];
 	size_t written = 0;
 
-	for (i = 0; i < num_packs; i++) {
+	for (i = 0; i < ctx->nr; i++) {
 		size_t writelen;
 
-		if (info[i].expired)
+		if (ctx->info[i].expired)
 			continue;
 
-		if (i && strcmp(info[i].pack_name, info[i - 1].pack_name) <= 0)
+		if (i && strcmp(ctx->info[i].pack_name, ctx->info[i - 1].pack_name) <= 0)
 			BUG("incorrect pack-file order: %s before %s",
-			    info[i - 1].pack_name,
-			    info[i].pack_name);
+			    ctx->info[i - 1].pack_name,
+			    ctx->info[i].pack_name);
 
-		writelen = strlen(info[i].pack_name) + 1;
-		hashwrite(f, info[i].pack_name, writelen);
+		writelen = strlen(ctx->info[i].pack_name) + 1;
+		hashwrite(f, ctx->info[i].pack_name, writelen);
 		written += writelen;
 	}
 
@@ -990,7 +989,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 		switch (chunk_ids[i]) {
 			case MIDX_CHUNKID_PACKNAMES:
-				written += write_midx_pack_names(f, ctx.info, ctx.nr);
+				written += write_midx_pack_names(f, &ctx);
 				break;
 
 			case MIDX_CHUNKID_OIDFANOUT:
-- 
gitgitgadget

