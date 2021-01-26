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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B8EC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85C12082D
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbhAZQGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404633AbhAZQC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D624CC0698C6
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so17030706wrz.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IVzb1Uw8OscK/sUGg6fnMfB7FooZ5hvv1wQJ6LJPxtc=;
        b=E/bnB1tABI+6hzYIT3mOfJbaiqWTVa6bSJE4vg3MxIEEh0c3yMDOtAjP+lqprmfy3K
         mkOnHC9P7X22DkKlQLQz/358o+SFwj6oOKoJeOPcCTmVIVRZ/sEm9jjkOsO26nsfXPDz
         zPXkL4zT5ann1AqYKXT0jDZBt1SI6Ppqk32hT5zC+mwgsg4phLh+B3qmZPgN/S6t5YL6
         zoaY5Q56wTyJHkR5tIh8qce/QHwHw7zkLqRN2WbjkTRHrU96pNqoW9ivup7iYSIGuwHe
         5hhcXWOZi5ssd7VDXI+I+YLlebHajiq4iPWOoMZe5BVB4yfmASI3cBVBgmfy6W+78As+
         7mmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IVzb1Uw8OscK/sUGg6fnMfB7FooZ5hvv1wQJ6LJPxtc=;
        b=OpdrjBAaDa4dTX5RargIZQ9YcpuA6tdBwWa38mun0q0667MJ/9TvA+sZWVwH7/cszr
         bQ7YmK7xIWG/rZd+YbRKAfi4mZtBA75ZVzSSbO1j3/cVLtp/aHw/kunbVimUPXhPs0Hk
         FojQFg0RGNgOoPJRzlj+IDnY3ogPkjQWfSh30icMRT4/Sl26u/KQEM9Gw2/TQ0RCH2Xg
         qPV9qXR2ClUS2bTL26XnnGkOvdSh8t6I7YSOKBqFR4SLSxwZN7X3boQq8IXg+TEUqSVi
         2GpywKILofHX//IOZ2kVaXYb+e/kmPC3yPXmxjKr9mFZ8HDTCHrn7gw93kyq7buWDnJB
         Y39Q==
X-Gm-Message-State: AOAM530c2xAxnAwUAL8TaZKhC+jmpbFMU6epXaozL0phnFS3igDaMHXY
        Q5Otul9vxzpl3I4lurzZZsXOfnHi9PM=
X-Google-Smtp-Source: ABdhPJwtWWc57xHBhOlce1m/GovXvyMHlLMWqlOAC+HRsQjbkX16hZd/pRe7pYVOdyY83vOja4B8Xw==
X-Received: by 2002:adf:d1cb:: with SMTP id b11mr6984727wrd.118.1611676899395;
        Tue, 26 Jan 2021 08:01:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm3136289wmc.42.2021.01.26.08.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:38 -0800 (PST)
Message-Id: <e3475633e1d2e397c5095f34c23a19fccb2c8428.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:21 +0000
Subject: [PATCH 12/17] chunk-format: create read chunk API
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

Add the capability to read the table of contents, then pair the chunks
with necessary logic using read_chunk_fn pointers. Callers will be added
in future changes, but the typical outline will be:

 1. initialize a 'struct chunkfile' with init_chunkfile(NULL).
 2. call read_table_of_contents().
 3. for each chunk to parse, call pair_chunk() with appropriate pointers.
 4. call free_chunkfile() to clear the 'struct chunkfile' data.

We are re-using the anonymous 'struct chunkfile' data, as it is internal
to the chunk-format API. This gives it essentially two modes: write and
read. If the same struct instance was used for both reads and writes,
then there would be failures.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 chunk-format.h | 21 +++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/chunk-format.c b/chunk-format.c
index 2ce37ecc6bb..674d31d5e58 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -12,6 +12,8 @@ struct chunk_info {
 	uint32_t id;
 	uint64_t size;
 	chunk_write_fn write_fn;
+
+	const void *start;
 };
 
 struct chunkfile {
@@ -89,3 +91,65 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 
 	return 0;
 }
+
+int read_table_of_contents(struct chunkfile *cf,
+			   const unsigned char *mfile,
+			   size_t mfile_size,
+			   uint64_t toc_offset,
+			   int toc_length)
+{
+	uint32_t chunk_id;
+	const unsigned char *table_of_contents = mfile + toc_offset;
+
+	ALLOC_GROW(cf->chunks, toc_length, cf->chunks_alloc);
+
+	while (toc_length--) {
+		uint64_t chunk_offset, next_chunk_offset;
+
+		chunk_id = get_be32(table_of_contents);
+		chunk_offset = get_be64(table_of_contents + 4);
+
+		if (!chunk_id) {
+			error(_("terminating chunk id appears earlier than expected"));
+			return 1;
+		}
+
+		table_of_contents += CHUNK_LOOKUP_WIDTH;
+		next_chunk_offset = get_be64(table_of_contents + 4);
+
+		if (next_chunk_offset < chunk_offset ||
+		    next_chunk_offset > mfile_size - the_hash_algo->rawsz) {
+			error(_("improper chunk offset(s) %"PRIx64" and %"PRIx64""),
+			      chunk_offset, next_chunk_offset);
+			return -1;
+		}
+
+		cf->chunks[cf->chunks_nr].id = chunk_id;
+		cf->chunks[cf->chunks_nr].start = mfile + chunk_offset;
+		cf->chunks[cf->chunks_nr].size = next_chunk_offset - chunk_offset;
+		cf->chunks_nr++;
+	}
+
+	chunk_id = get_be32(table_of_contents);
+	if (chunk_id) {
+		error(_("final chunk has non-zero id %"PRIx32""), chunk_id);
+		return -1;
+	}
+
+	return 0;
+}
+
+int pair_chunk(struct chunkfile *cf,
+	       uint32_t chunk_id,
+	       chunk_read_fn fn,
+	       void *data)
+{
+	int i;
+
+	for (i = 0; i < cf->chunks_nr; i++) {
+		if (cf->chunks[i].id == chunk_id)
+			return fn(cf->chunks[i].start, cf->chunks[i].size, data);
+	}
+
+	return CHUNK_NOT_FOUND;
+}
diff --git a/chunk-format.h b/chunk-format.h
index bfaed672813..250e08b8e6a 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -17,4 +17,25 @@ void add_chunk(struct chunkfile *cf,
 	       size_t size);
 int write_chunkfile(struct chunkfile *cf, void *data);
 
+int read_table_of_contents(struct chunkfile *cf,
+			   const unsigned char *mfile,
+			   size_t mfile_size,
+			   uint64_t toc_offset,
+			   int toc_length);
+
+/*
+ * When reading a table of contents, we find the chunk with matching 'id'
+ * then call its read_fn to populate the necessary 'data' based on the
+ * chunk start and size.
+ */
+typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
+			     size_t chunk_size, void *data);
+
+
+#define CHUNK_NOT_FOUND (-2)
+int pair_chunk(struct chunkfile *cf,
+	       uint32_t chunk_id,
+	       chunk_read_fn fn,
+	       void *data);
+
 #endif
-- 
gitgitgadget

