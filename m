Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE6C433E6
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AFA64F9F
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhBEWYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhBEO0c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:26:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C41C0617AB
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:04:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id w4so6429675wmi.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KXPAB9q+fGgT3wZ6Ax8vxxMhYx8Zk4iTFycG5IttMms=;
        b=ZoYmN+WLQb3rGDPHiD/BNsyEoW7OT9w5vsPVtGlKARSi9pteJDRR7f2vNZ+CKNm8Om
         sDlzO3vXgv178paYdBWcshGau6Qwzqfg7oS1yoy5GJad6+31HJ1kHZDeXB1M4Ii4bTQ/
         mQr502q/qD0GK7UbW8nTEWKdMq78NjStgb3snwEd0R3W5mPIr+WUJe2oYmxIrt2FlaEt
         GzY5FPlxBrZdu1bCIAHCAWBo7fOocPmZAJ7mdY4jSgn71aeY6LTFpVn+zuCbbfwJWKX5
         7e60S1HgSVTigXsE6RKiMgzdmwGHHD3rtItrylJPpUq2ZczE+yHTJjKaKGYX4KBSSIYJ
         RaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KXPAB9q+fGgT3wZ6Ax8vxxMhYx8Zk4iTFycG5IttMms=;
        b=ucN6lt6yxkPYa3uqZLDWSFeTbNwB6WbT3w2dk9h4dve8YQKpj0NUapYxnLInLqbLTh
         jGgNpx8kyXiqyCydU0rEQD67gCPriAqZOkdQnew10lJWp0UOcAzdp1RbGxZHEYeDIXwW
         DHKfqJIRKwql/D0dqEH7zZrbvYNo1fcCqwD+cPvAmrvvRScU/WaD3LLzO0GhlRCcUJsk
         FxVCcSqJFjWn2mQrTHjCpvE1zmXCymlcEh9ciMiE3vMehXRvgWv1hFl8Sy8lJVi7Ql8t
         lROoVyA1jXcWcVkG+1l3fJAmfwxYflsedN1gE7fGwcJYvpu/pg+H2t1FavC2YldGA/3E
         djFA==
X-Gm-Message-State: AOAM5327p7/9nQaiUOgoM2U++wX9EJX8DOddCZw8DIz3nr0mbq+KXPlG
        avGMrPye/P0EwYFCUF/Go70x62CF3k8=
X-Google-Smtp-Source: ABdhPJy1DGeOUcLxTtAY7HuSNTFRbkjJdy+mQ7BUvbcDHjvkEf5GVrXmg7y+l0k56Ng512/ygFVV+Q==
X-Received: by 2002:a1c:9cd8:: with SMTP id f207mr3930450wme.155.1612535466758;
        Fri, 05 Feb 2021 06:31:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm13359065wra.80.2021.02.05.06.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:06 -0800 (PST)
Message-Id: <366eb2afee839feccdfd2244b231d2ad718c76d4.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:47 +0000
Subject: [PATCH v3 12/17] chunk-format: create read chunk API
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

Add the capability to read the table of contents, then pair the chunks
with necessary logic using read_chunk_fn pointers. Callers will be added
in future changes, but the typical outline will be:

 1. initialize a 'struct chunkfile' with init_chunkfile(NULL).
 2. call read_table_of_contents().
 3. for each chunk to parse,
    a. call pair_chunk() to assign a pointer with the chunk position, or
    b. call read_chunk() to run a callback on the chunk start and size.
 4. call free_chunkfile() to clear the 'struct chunkfile' data.

We are re-using the anonymous 'struct chunkfile' data, as it is internal
to the chunk-format API. This gives it essentially two modes: write and
read. If the same struct instance was used for both reads and writes,
then there would be failures.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 chunk-format.h | 46 +++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)

diff --git a/chunk-format.c b/chunk-format.c
index 6e0f1900213e..bc9d4caf7276 100644
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
@@ -89,3 +91,81 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 
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
+static int pair_chunk_fn(const unsigned char *chunk_start,
+			 size_t chunk_size,
+			 void *data)
+{
+	const unsigned char **p = data;
+	*p = chunk_start;
+	return 0;
+}
+
+int pair_chunk(struct chunkfile *cf,
+	       uint32_t chunk_id,
+	       const unsigned char **p)
+{
+	return read_chunk(cf, chunk_id, pair_chunk_fn, p);
+}
+
+int read_chunk(struct chunkfile *cf,
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
index 9a1d770accec..0edcc57db4e7 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -6,6 +6,19 @@
 struct hashfile;
 struct chunkfile;
 
+/*
+ * Initialize a 'struct chunkfile' for writing _or_ reading a file
+ * with the chunk format.
+ *
+ * If writing a file, supply a non-NULL 'struct hashfile *' that will
+ * be used to write.
+ *
+ * If reading a file, then supply the memory-mapped data to the
+ * pair_chunk() or read_chunk() methods, as appropriate.
+ *
+ * DO NOT MIX THESE MODES. Use different 'struct chunkfile' instances
+ * for reading and writing.
+ */
 struct chunkfile *init_chunkfile(struct hashfile *f);
 void free_chunkfile(struct chunkfile *cf);
 int get_num_chunks(struct chunkfile *cf);
@@ -16,4 +29,37 @@ void add_chunk(struct chunkfile *cf,
 	       chunk_write_fn fn);
 int write_chunkfile(struct chunkfile *cf, void *data);
 
+int read_table_of_contents(struct chunkfile *cf,
+			   const unsigned char *mfile,
+			   size_t mfile_size,
+			   uint64_t toc_offset,
+			   int toc_length);
+
+#define CHUNK_NOT_FOUND (-2)
+
+/*
+ * Find 'chunk_id' in the given chunkfile and assign the
+ * given pointer to the position in the mmap'd file where
+ * that chunk begins.
+ *
+ * Returns CHUNK_NOT_FOUND if the chunk does not exist.
+ */
+int pair_chunk(struct chunkfile *cf,
+	       uint32_t chunk_id,
+	       const unsigned char **p);
+
+typedef int (*chunk_read_fn)(const unsigned char *chunk_start,
+			     size_t chunk_size, void *data);
+/*
+ * Find 'chunk_id' in the given chunkfile and call the
+ * given chunk_read_fn method with the information for
+ * that chunk.
+ *
+ * Returns CHUNK_NOT_FOUND if the chunk does not exist.
+ */
+int read_chunk(struct chunkfile *cf,
+	       uint32_t chunk_id,
+	       chunk_read_fn fn,
+	       void *data);
+
 #endif
-- 
gitgitgadget

