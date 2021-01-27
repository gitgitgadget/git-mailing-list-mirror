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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B04DC433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4818C2074D
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbhA0PGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbhA0PCz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:02:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4356BC0613ED
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so2265450wrz.0
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xBEf4iQ2asSfr1nhf3N8+WaJ6o77jtBdSEhmotRLPtI=;
        b=qeP312DuVvDr+jT8P9wn9hMBOleXTgzGoCQ6PF7d1mi48NrKOSZvrfITD9pjkHyU4x
         7RwKfUjmkuViqhuMGeWJiI/aSkHXHVREacs83FPB+qqDsH/vSvSqVFHHCMs5q8qClT1b
         UL0qND3L+SyOrWi8pwLRV7mr5d2Egh+BNbRA2xmnuFqHR6U0YNqSQUTDEma8u7uCI2kv
         ATXfCawA18MTrx9PJYQKviZ0WWtU7zNyEiy2yHcZTzIzJmqYo9lZSa49ap+5DELCbJWb
         Z4hOH+bN5wRna8sU6hoDD5hnC5KjZBO3yTpYrGPHpSMuZtYUGVOtoA9n/HGc0XEn0ElR
         gGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xBEf4iQ2asSfr1nhf3N8+WaJ6o77jtBdSEhmotRLPtI=;
        b=JXmKiTWlcY0ejAEo8En8XuaVD2EqYgGf7TUOuUHNsY4sZJpKx15t+odAb2GE0n6KlF
         7xedOf1YTtBEUmSwEXoS+WTU0U0m9FTf46ngXauz1MVOV8GHPtbPIsVjNux3LOQAWHLj
         J/rgC453C4ou34fuuhO66n+j3/K9goSt3DM5zRRPzqmF76brvOkr22133/Nkb/8aRz2e
         YHN/xGRB9dYqJNBWGT5zx5ZtKSOtTa8QnzwbphWbxA+AcwcUI/PVuKJ+FW7PztFVdt3w
         PWjKRWJSRhR36fEbxW3zMNMwIOYtR+CHOs/BsaEgwea2FlbIvqAjw2TFXX9ETgyj7UoX
         rSmA==
X-Gm-Message-State: AOAM5301059faWQmQieB7bcp7B33dSaUU3uYARLGiTlw4EaBwkonYVmK
        6p85ZItCwhg4F2x8f3hDR9QGVdfDBWU=
X-Google-Smtp-Source: ABdhPJy+/Ig04OSm8w2SAhWbP2/rma5j6yOSCApDpWT05rYQ2SE6IoG6Uo5uJjyDEXfG0Ru4+j4RXg==
X-Received: by 2002:adf:e348:: with SMTP id n8mr11938519wrj.148.1611759723813;
        Wed, 27 Jan 2021 07:02:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h125sm2901258wmh.16.2021.01.27.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:03 -0800 (PST)
Message-Id: <4a4e90b129aefd6a186561d5e814dc7695bae7cb.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:44 +0000
Subject: [PATCH v2 05/17] midx: use context in write_midx_pack_names()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
index 561f65a63a5..88452b04433 100644
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
+	struct write_midx_context *ctx = data;
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

