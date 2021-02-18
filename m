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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1F1C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4489A64EAD
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhBRQwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhBROJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:09:57 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BABBC06121C
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:55 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v1so3124680wrd.6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L7txn7xvbO69aI6sRhsV1+Kb5QylibPZGK1hohssVBA=;
        b=PE/rKbXroSCE4qp2rZ/mBozrWr7zTetWF1l4uT1jAuLgQ6SRkVWzgS4s1x1g7ItOxb
         9Nj8pC4cM3rF8i9CbX9qjuM60oPd5aj0DWbKbIE3oFCAGpOWzEONzWkSaJXRIgKg4J/l
         OdDwt/dSLl1zgdEO0XS/JGX6wAOUTieTcBsrHJYRNYtLR4JvLSjLn6Y9xBv9ZJjHVenW
         ctt0ywzHlHQnlK8wsPQvG97Cy6WhzkFcSy16t4blgLd0rACl1B9N/sLhkCdYiSj6BzDa
         Ol133xwSU33PWpJTeFSaxo7EcEEq9kN62LmagVrslQa0U0SaOogB101R5HDgtoM4EA2c
         qvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L7txn7xvbO69aI6sRhsV1+Kb5QylibPZGK1hohssVBA=;
        b=Uhy8fZDfvIDvuEwKLhM4FGsAcSkluNT3sXbUNxua3sofTSvdkAWkfoeYLmy+k9NBRs
         amzSQBZ4CyUMc43ENOgIhV4ob2P+/0rdWJxQx+fPXxrJcDuO2sg1y34NkRufqJYZDriZ
         hAvWw+86xz6F+fF+7q5U2fVu0Z+AfYJoil2y+71mKzXY7vikh4H87DjCirLffyGwsrA3
         c/hilDWB+bSpfckFwTtFu7FKJkv6zKdx0vS+kFIEguM7YIvq0PczZrrvn6/co2UmbWBb
         4M2Yau22yBAjp4MKaB3JfOWqqcOD3ppUpz7kxn8SdedU1D14d22l715Zw+wqhlYBOPDZ
         AOuQ==
X-Gm-Message-State: AOAM5320AktSGz2/xne7+MAAJx5Xn+uhzY3t8vlOxR6LhJfqRgbsVEgx
        E58w5CwgwPD1JJg07XOuWVikqnm+iuw=
X-Google-Smtp-Source: ABdhPJz09O/DUqAARdUa+HkWuMdOQ6/iNb+CKieWfLoP46dfswqRP4memvTOyIWXISLiApFdyI9scA==
X-Received: by 2002:a5d:4582:: with SMTP id p2mr4536074wrq.126.1613657274042;
        Thu, 18 Feb 2021 06:07:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm7461715wmf.46.2021.02.18.06.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:07:53 -0800 (PST)
Message-Id: <3e0dbc45ce7ff5f1bda63ae8b8b45343b790417b.1613657259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
References: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
        <pull.848.v4.git.1613657259.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Feb 2021 14:07:34 +0000
Subject: [PATCH v4 12/17] chunk-format: create read chunk API
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
 chunk-format.h | 47 +++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/chunk-format.c b/chunk-format.c
index 6c9b52b70c10..2c1fecf1c3e5 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -11,6 +11,8 @@ struct chunk_info {
 	uint32_t id;
 	uint64_t size;
 	chunk_write_fn write_fn;
+
+	const void *start;
 };
 
 struct chunkfile {
@@ -88,3 +90,81 @@ int write_chunkfile(struct chunkfile *cf, void *data)
 
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
+		table_of_contents += CHUNK_TOC_ENTRY_SIZE;
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
index ce598b66d9f8..9ccbe0037792 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -8,6 +8,20 @@ struct chunkfile;
 
 #define CHUNK_TOC_ENTRY_SIZE (sizeof(uint32_t) + sizeof(uint64_t))
 
+/*
+ * Initialize a 'struct chunkfile' for writing _or_ reading a file
+ * with the chunk format.
+ *
+ * If writing a file, supply a non-NULL 'struct hashfile *' that will
+ * be used to write.
+ *
+ * If reading a file, use a NULL 'struct hashfile *' and then call
+ * read_table_of_contents(). Supply the memory-mapped data to the
+ * pair_chunk() or read_chunk() methods, as appropriate.
+ *
+ * DO NOT MIX THESE MODES. Use different 'struct chunkfile' instances
+ * for reading and writing.
+ */
 struct chunkfile *init_chunkfile(struct hashfile *f);
 void free_chunkfile(struct chunkfile *cf);
 int get_num_chunks(struct chunkfile *cf);
@@ -18,4 +32,37 @@ void add_chunk(struct chunkfile *cf,
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

