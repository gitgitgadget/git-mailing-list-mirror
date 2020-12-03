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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F2C18E57
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FCE20658
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501869AbgLCQRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501864AbgLCQRp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:17:45 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16557C08E85E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:05 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a6so3270913wmc.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=khL0G4eY6t8w7kMYcfsyX62mlwnP0T1t9GT8lr2yxe0=;
        b=J1a+WrW+9puV3Guj4Cg4S3Q/cNZYxWPs98EeJLPtJUx0+S5VqedYkZBF8pbbvogCY3
         qSkqr88DWPTN2YAJ4gU8v7QTWexA/aFMJQVVxqEvl7J6OjSK6g+Bu6e+vQQokOAEWfhB
         R2PJRoqA9LBY15P6EeWzjVzbvBfpZVAyz1wPGbmNTPLjS8Y68MbAk5tjXZMmFk2EwgpM
         2Cu3dYPhbiYdFn9mtOFUUArNQ4OelH0vSesMXTkH6RzwRXsKMQ5me81w9DMjxjleHda1
         Xkab64JWNYIu+mL7QqtEjBKDkhIxvSlwtUKECOQfHJs4gzH+Xl8RVJobpOb0wvuWIPfN
         68lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=khL0G4eY6t8w7kMYcfsyX62mlwnP0T1t9GT8lr2yxe0=;
        b=V0ZbuwE5CkbqKco3P7ev6GFS5xBgPjvl6f65AluH9V40/tEF8mfn5dAJV3Uflrwydl
         1W8hJ6LaPz7R4V46bDgsxEL/fG2g2v87aTSP1a4CGA1v0vRWXZJ0WPIEiKM1onv0LNyo
         vlpGw47rwlgcN+dH9q5c/gxiVKKWl7UBJUnIE+XluR4Wh4XLaUoakYweRk5lB0dba3Mo
         ofFeQPEIT7E09ByuWa2qYLZG6+K6wPX7awZ1VCrzFqvnZ8WsJzfdeJ5q/AaTjIVJsAzP
         F02eevBssD5E/8aqjsWTgS15fz6T6D92tZOVLlWAxo5dUJamajCR7HPpyBS95IJy756M
         ddPw==
X-Gm-Message-State: AOAM530gN/h41BunKrcRt4w0zD4P0zxIRjv3ago5X1qC3snskB+WTD+D
        qaHxMt+FgWUMh5MncfmUzHoEmIG7E7s=
X-Google-Smtp-Source: ABdhPJy4ZWZdUSSv5HW9Ri6bdo8TcUTgJ6Lc5PgCxleQjE64GQubki0lBDvabxVXEmpShEmSIT5uaw==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr4158588wmc.126.1607012223609;
        Thu, 03 Dec 2020 08:17:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b74sm2262840wme.27.2020.12.03.08.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:03 -0800 (PST)
Message-Id: <84f7bc46f93a756da2148ebbc175f0cb02ef3c1a.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:46 +0000
Subject: [PATCH 07/15] midx: add num_large_offsets to write_midx_context
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In an effort to align write_midx_internal() with the chunk-format API,
continue to group necessary data into "struct write_midx_context". This
change collects the "uint32_t num_large_offsets" into the context. With
this new data, write_midx_large_offsets() now matches the
chunk_write_fn type.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/midx.c b/midx.c
index f7c3a54a33..d7da358a3f 100644
--- a/midx.c
+++ b/midx.c
@@ -464,6 +464,7 @@ struct write_midx_context {
 
 	uint32_t *pack_perm;
 	unsigned large_offsets_needed:1;
+	uint32_t num_large_offsets;
 };
 
 static void add_pack_to_midx(const char *full_path, size_t full_path_len,
@@ -772,11 +773,14 @@ static size_t write_midx_object_offsets(struct hashfile *f,
 	return written;
 }
 
-static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_offset,
-				       struct pack_midx_entry *objects, uint32_t nr_objects)
+static size_t write_midx_large_offsets(struct hashfile *f,
+				       void *data)
 {
-	struct pack_midx_entry *list = objects, *end = objects + nr_objects;
+	struct write_midx_context *ctx = (struct write_midx_context *)data;
+	struct pack_midx_entry *list = ctx->entries;
+	struct pack_midx_entry *end = ctx->entries + ctx->entries_nr;
 	size_t written = 0;
+	uint32_t nr_large_offset = ctx->num_large_offsets;
 
 	while (nr_large_offset) {
 		struct pack_midx_entry *obj;
@@ -811,7 +815,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint64_t written = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
-	uint32_t num_large_offsets = 0;
 	struct progress *progress = NULL;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
@@ -861,7 +864,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	ctx.large_offsets_needed = 0;
 	for (i = 0; i < ctx.entries_nr; i++) {
 		if (ctx.entries[i].offset > 0x7fffffff)
-			num_large_offsets++;
+			ctx.num_large_offsets++;
 		if (ctx.entries[i].offset > 0xffffffff)
 			ctx.large_offsets_needed = 1;
 	}
@@ -961,7 +964,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 		cur_chunk++;
 		chunk_offsets[cur_chunk] = chunk_offsets[cur_chunk - 1] +
-					   num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
+					   ctx.num_large_offsets * MIDX_CHUNK_LARGE_OFFSET_WIDTH;
 	}
 
 	chunk_ids[cur_chunk] = 0;
@@ -1010,7 +1013,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				break;
 
 			case MIDX_CHUNKID_LARGEOFFSETS:
-				written += write_midx_large_offsets(f, num_large_offsets, ctx.entries, ctx.entries_nr);
+				written += write_midx_large_offsets(f, &ctx);
 				break;
 
 			default:
-- 
gitgitgadget

