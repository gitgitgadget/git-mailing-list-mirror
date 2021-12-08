Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E3CC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbhLHVx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhLHVxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5CC0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o29so2817081wms.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sz2gS9C3a6Ypo/mE/oVriGH4YMP1EwjLNkuHgyL7+Sw=;
        b=qbF/WlXRvD8gQ784cEAdY2AKxTEWYDhVL1S9LRl9NU1lFs3TnFHi412fmwD0m6a7gJ
         r5FAauOBP4QO0D+ug+td9TAxl48WcXLlU768QMKf0FqRQI8fXcdYIz6hRKRSYLnQMraK
         PXj9r99O8Mrxm+ADZ288cro6v1MuO1g2JJGuTT/4UcZhM6BQZ54XiYQNqeMtjS9kVRW1
         bXsiQubaDM89y34qc0NOa4F7jrd2ZcUvryKOAx/HBXXiyN5aHFOONgYi1iCfeKn/2L8e
         aysnOpdpGhZRLsOQHXRmx9lOjRsOzy5S1FtlJ+jtAQJ/GZLvhnHLpYmmtID8H4ep1Zqs
         PDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sz2gS9C3a6Ypo/mE/oVriGH4YMP1EwjLNkuHgyL7+Sw=;
        b=qVk6kuAisOcsslwIuqy9owF+mOP/RWMw0qmEWcglYhUKFBzKfJEK62UqScarhlGt5e
         lWfzNZvcPKjb1e2IwCxvWlUf0+MGXoDKkLRohnldxtUnPFu0qDl7/XVw4TuHHki88m7S
         oYFdYLAsXVZiww5eM2PJRfxr8OimfPIhylk8M4blzq3Q5YNR3N8ZSp23eqw44qVSGCil
         KdNP9GHIvoTBNu9U2czIW+a5MkQl+xpsZOW8PePzv+JiHTS6x/gZkh4OZ6t4HiDTYuuA
         Cdw3KnAa/bfMmWiiH4a5Kuc5iDbn/RNV18zbzn/sD6jJCQasFWy0CULcfZLPd2zKOfhS
         +pvg==
X-Gm-Message-State: AOAM530er7ZNs5N+umaPycA34t/ie3yQ8YkNq/Z8UTF+ZNcDwzu43pDK
        /8dwecjMpAcUxzqWdYvU/06C474Tms0=
X-Google-Smtp-Source: ABdhPJzT4yR0i5hhgX3Ehq6HrVdubWVkJ/ATn9shKxzI9x+R9/JAnqEMMA/PHDaU77oIxp8uFtd7cw==
X-Received: by 2002:a05:600c:3486:: with SMTP id a6mr1685820wmq.32.1639000189665;
        Wed, 08 Dec 2021 13:49:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm7798059wmq.34.2021.12.08.13.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:49 -0800 (PST)
Message-Id: <1ddcfe61ebc2c4ccb5fa82380ac00a62bf3aebdf.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:37 +0000
Subject: [PATCH v2 02/11] reftable: fix resource leak in error path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would be triggered by corrupt files, so it doesn't have test coverage. This
was discovered by a Coverity scan.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/block.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 855e3f5c947..79b6f3aac72 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -188,13 +188,16 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	uint32_t full_block_size = table_block_size;
 	uint8_t typ = block->data[header_off];
 	uint32_t sz = get_be24(block->data + header_off + 1);
-
+	int err = 0;
 	uint16_t restart_count = 0;
 	uint32_t restart_start = 0;
 	uint8_t *restart_bytes = NULL;
+	uint8_t *uncompressed = NULL;
 
-	if (!reftable_is_block_type(typ))
-		return REFTABLE_FORMAT_ERROR;
+	if (!reftable_is_block_type(typ)) {
+		err =  REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
 
 	if (typ == BLOCK_TYPE_LOG) {
 		int block_header_skip = 4 + header_off;
@@ -203,7 +206,7 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		uLongf src_len = block->len - block_header_skip;
 		/* Log blocks specify the *uncompressed* size in their header.
 		 */
-		uint8_t *uncompressed = reftable_malloc(sz);
+		uncompressed = reftable_malloc(sz);
 
 		/* Copy over the block header verbatim. It's not compressed. */
 		memcpy(uncompressed, block->data, block_header_skip);
@@ -213,15 +216,19 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		    uncompress2(uncompressed + block_header_skip, &dst_len,
 				block->data + block_header_skip, &src_len)) {
 			reftable_free(uncompressed);
-			return REFTABLE_ZLIB_ERROR;
+			err = REFTABLE_ZLIB_ERROR;
+			goto done;
 		}
 
-		if (dst_len + block_header_skip != sz)
-			return REFTABLE_FORMAT_ERROR;
+		if (dst_len + block_header_skip != sz) {
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
+		}
 
 		/* We're done with the input data. */
 		reftable_block_done(block);
 		block->data = uncompressed;
+		uncompressed = NULL;
 		block->len = sz;
 		block->source = malloc_block_source();
 		full_block_size = src_len + block_header_skip;
@@ -251,7 +258,11 @@ int block_reader_init(struct block_reader *br, struct reftable_block *block,
 	br->restart_count = restart_count;
 	br->restart_bytes = restart_bytes;
 
-	return 0;
+done:
+	if (uncompressed) {
+		reftable_free(uncompressed);
+	}
+	return err;
 }
 
 static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
-- 
gitgitgadget

