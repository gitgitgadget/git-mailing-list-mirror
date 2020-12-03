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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE9C193FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB2E20658
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501876AbgLCQRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501870AbgLCQRv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:17:51 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9FC08E85F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:07 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id e25so4514762wme.0
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ub/FJSWvT5iakCd0l8s0RS+TgWpD6nKTyMFwTV4pXAc=;
        b=dJbIXUXDiEPnOe2A1HRUgR4gNEdQmA0/+/Cp4QdBLdue1WrUeVINIZS+Vy1IaJjRe7
         geCB6Hrm7IFfsP4hXZlIZpeaNIhSvJphgzgP5c8+DjlZ0A1Ojv8CeHsDERl26HzgigOS
         LMprGhTtqMBdWmDOAdpSkoyubkjRoJfBprLrNQY/n4RmENiTK6ftkcTekSMf/X86naNm
         pBpViw9SKQ6jEnG0FKbIEV9kWxaj84msYxRw3KbWecSOYRm4d8GvnyNJYTVoWItIHght
         kcVSJqJ1yoR+uPzHb/mrZl7VAX+qFxA1BwyNVDuz0CNGpeK42tFDlJBMCR2v3iNJX2Qm
         6dCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ub/FJSWvT5iakCd0l8s0RS+TgWpD6nKTyMFwTV4pXAc=;
        b=bb1twuNKDO2oaOvgDBWoqh3pdhCU1hWG7yJgpFElGegwTR6UXLxqZU+usZQe+GeKcm
         zPayFLsTO/LRxKLF9L3/zxJAAub6cLa72LiS/bR4FUMTwShCyHeJHIpNz9NKLQqVdqW7
         tbeFGa3pqTK3G88q0+qZGjW37LdZR2jEKF5Uv+Ool8ruTV00pxsfeikOAqsctZzMp3T9
         KJFkcuFsz6fxGuQlyYcwbKG9QK0aOTe+g11+Cdf7ItjKaJrtyAzzca5hu71ALTgRY1J4
         Mtc62Q14SQUVVndBV6zqbN1gFVshBlBS6IZJTqosW3ecagLLVkn15mZlzxRgx5jGke6F
         ZXuQ==
X-Gm-Message-State: AOAM533o1Ihg1yI7DKeTogOPWvlUlzvia0EMOQwT2CbkJ+pEW1owKGAW
        a6x2zXT0wnTbVCgHvutSZDrNdQ9TNi0=
X-Google-Smtp-Source: ABdhPJxnZjrY8wKiPzaMPgL2xwssvq8bHwLmfid7xfyqdiCcZMAuqCmR/3FVOXSGHUWOnjubsI/5aA==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr4160356wmj.76.1607012225638;
        Thu, 03 Dec 2020 08:17:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b83sm2081201wmd.48.2020.12.03.08.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:05 -0800 (PST)
Message-Id: <dd85922eadd1c6eb4b08c9a3241afba8e7faecd9.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:48 +0000
Subject: [PATCH 09/15] midx: drop chunk progress during write
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

Most expensive operations in write_midx_internal() use the context
struct's progress member, and these indicate the process of the
expensive operations within the chunk writing methods. However, there is
a competing progress struct that counts the progress over all chunks.
This is not very helpful compared to the others, so drop it.

This also reduces our barriers to combining the chunk writing code with
chunk-format.c.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/midx.c b/midx.c
index 5eb1b01946..ce6d4339bd 100644
--- a/midx.c
+++ b/midx.c
@@ -808,7 +808,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	uint64_t header_size = 0;
 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
-	struct progress *progress = NULL;
 	int pack_name_concat_len = 0;
 	int dropped_packs = 0;
 	int result = 0;
@@ -976,9 +975,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		hashwrite_be64(f, chunk_offsets[i]);
 	}
 
-	if (flags & MIDX_PROGRESS)
-		progress = start_delayed_progress(_("Writing chunks to multi-pack-index"),
-					  num_chunks);
 	for (i = 0; i < num_chunks; i++) {
 		if (f->total + f->offset != chunk_offsets[i])
 			BUG("incorrect chunk offset (%"PRIu64" != %"PRIu64") for chunk id %"PRIx32,
@@ -1011,10 +1007,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 				BUG("trying to write unknown chunk id %"PRIx32,
 				    chunk_ids[i]);
 		}
-
-		display_progress(progress, i + 1);
 	}
-	stop_progress(&progress);
 
 	if (f->total + f->offset != chunk_offsets[num_chunks])
 		BUG("incorrect final offset %"PRIu64" != %"PRIu64,
-- 
gitgitgadget

