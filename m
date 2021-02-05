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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB9BC43381
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEB264F92
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhBEWGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbhBEOwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:52:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD60C0611C2
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:29:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u14so8376644wri.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kGVHM52oWgqXnIlb4yOoAhhJoKcEoCuXj3Nru4t5efI=;
        b=DRQxkmGrYtgIk7zO9oRTdAeuBxlUo4sQ8/+hUkzQEIidLef7MlxGFmFOriJ5SkzWhx
         f9v/JMHliU4S1SAEWrXGiX9hc/sbGkK73wLq+Id34vXxyR6Zqess+1htgMyVULLIsi+J
         i1kmbLE2zxkkp+TY8Kr7S7Q6oPTm5CLEKhfCFEj7g5gTcGFDV4ecQGB9XiXGGSAUzNmB
         74dy1pE8Gp/Kq3yJzsym/RQhQj2AGQgClr3/X3LN5XR1QdnpavMAZB/Pb5G/SnTuUtOx
         8SxyFB4x1UmRgQWSrYO3y5hBLmheHEU90mL/hYQEzsmBepDLCGj8MQvaFKINltSMI8nw
         bGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kGVHM52oWgqXnIlb4yOoAhhJoKcEoCuXj3Nru4t5efI=;
        b=qy/bfFz12YYULnS/BWIp3iSRHszZpUddDM2ugMi5AEuKkGGKIFg4HkIoN4jR83VRkp
         BT82D7qXj88uBW8yar+D2LfC2MtMUsr9eKDasnK4BEBgADo+GbLDtzyCLMstnOlEBIJJ
         9uplBkSquRtdxjzcCSk6wtc/zCgMfQBxUhYkemJ4gFKO5BjFWaxl0yRd54zNUzDJrUwc
         +yMxTZN4QTYVcrq7uc1N0yVEin0htQ7PVnbEWyY7b4jPe/iOW/ALQpjKgQwJobzZHlF5
         WlSHDWuXCpk6HHHgBZ4qxnmFmwUHLu43Z2ESkDnrTbtG773ki/n+muqYveHUGe+0jrNg
         nr6g==
X-Gm-Message-State: AOAM531KGpFGMsN0x6O6VX0coQY2gIPlgAqWhVBDmCo/0u1O6XOwqpu/
        NzNW6D+9Wm8ktu62yP5fjs/4vKmZbGY=
X-Google-Smtp-Source: ABdhPJwqR6uXSP7kLq7w1B8X+4M6Any9mfoEE8FyRL27DG+AoL4IkWysmoSAc7f/NKRQltfE/NatBQ==
X-Received: by 2002:a5d:4492:: with SMTP id j18mr5239798wrq.403.1612535459602;
        Fri, 05 Feb 2021 06:30:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20sm8587743wmq.7.2021.02.05.06.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:30:59 -0800 (PST)
Message-Id: <1d7484c0cffa1a316a1f6bdbcd986e98b0fe2b53.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:40 +0000
Subject: [PATCH v3 05/17] midx: use context in write_midx_pack_names()
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

