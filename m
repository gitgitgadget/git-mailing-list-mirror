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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA381C43333
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A1964EB1
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhBRQoW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbhBROI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:08:29 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE354C061794
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id n4so3156552wrx.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kGVHM52oWgqXnIlb4yOoAhhJoKcEoCuXj3Nru4t5efI=;
        b=fMyNDODKs+OFEeRBiqcGXEz83qEsrbV5S/IBSy5Iakb0uwIWC7ediSyBHMBTzAIZRu
         UqKoBtiRrUV3Wa6bR5yqmcnCZ5zi5IxM9JUNnp53SUERj0mAg5M8qukc58nM/mLrGfYb
         7yKwLpmLn2ktU6C2d4L1dSLmWoirH2gkndLXYAnOZ/FyZSGF6IGz+vWjMv1boDbRj/Ro
         sNNvsHywt2h4PnKnSucLmqIgoCClyH8/rBqA1zWYuBUEvK26GqVh4RQRaLX1M475CnFT
         VzNliDmtgS+2D/FyAP31uDb8pduUhQHVdHR9OcTYrRfSSoj7oTkg7NIjXsWW35woLZ30
         G5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kGVHM52oWgqXnIlb4yOoAhhJoKcEoCuXj3Nru4t5efI=;
        b=YbnGWsF9rXYmJohhr2otydgihEoMAZy+G1wlxz0QznmilNraOrOy9jfnNn+OGif6Fc
         Pd3QQ3wyh1PUKxJDWl7zR3g4rGG7eXPoFgV8o7I7Hgf2G2r/c90Y7KJDi6z4nZt/EEvq
         SwR5Qf+rjvP1WDUtj6KxT1OP0VNpkwRModZFpy0FLRDJ7Z+7WIcDVraq1Od37IVzxcAw
         R2e+OxmM+wItXufutBP36SFulLE0hm0+9dd/85nVVguRyDWxzH4Wm/ZME+aaGj7i6KR9
         IBWZpK871BUSG31wi4YY6dzLcl0li+9I1KsdUKtkqTzV0KzIBZfoZnG90IRZRb+/FGsB
         iF7A==
X-Gm-Message-State: AOAM530jMAm4XPWRoQw5F0IegLbiFPVbKVMIpXF9BMpfFeX3PjkL8rg+
        1C3x9ukBszz8PKu9LAhgM9ThSpktft8=
X-Google-Smtp-Source: ABdhPJyR0cjaAAv4+pWar8Js7uqpT8U/YSdHIuEYuACw/8gDbjF5A0GFa62KVFZYRvYT0GQRVOtNEQ==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr4363542wrw.415.1613657266541;
        Thu, 18 Feb 2021 06:07:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l22sm2486598wrb.4.2021.02.18.06.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:46 -0800 (PST)
Message-Id: <c18f3738f5d4cb164dfba3a04c0f54bb1b44e013.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:27 +0000
Subject: [PATCH v4 05/17] midx: use context in write_midx_pack_names()
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
index 561f65a63a5b..88452b044337 100644
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

