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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E346C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEFB207D0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhA0PgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbhA0PD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:03:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EB1C06121F
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:12 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c128so1954065wme.2
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ryEQU73ySFs9i5qWnwYa2tmiNxlV09ruJyI3FKs6Bew=;
        b=oln+4TEg04MmPKi5DE+YIgN814TUPXYwPG9XG6bovGCH++7i9f/rktbseYH8sSCTIk
         VceC6UShTGp7df8omSj8bYUMXCVPcTz90dnNJivyFBNq9qUYNw0XTv5xgXa3iuu4Lv/u
         OawHUuKdB1tIGW2AfZ9OoCqSFCB2n5Ig5CbswztI05EYUvuivXTF/fnavBef9BIq3eus
         eRRZe6T44/1/tE2IrzBnnUdx+H4bTdSApBDkdGVvXCqUc1HTgNnw85Lz3iYbXa4XAM7u
         n+4BU9bl4pGRTeFqUVgC3p3888GoKPCQsuWkUH6Uquc2F0HSmuM0R9tNsutuF/hXGrvt
         oddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ryEQU73ySFs9i5qWnwYa2tmiNxlV09ruJyI3FKs6Bew=;
        b=MghuBPd7DNaKSIeiKRH5/6pG4nrTn6a7qYKRYrTxL3Luqx/SmyOQgAfc9jojg2KDGN
         hRCH6jS2gdEWRgJw1yHS46YfUH/1scgIIIaihCh4T0Mm8XGIQDeWexvBd731L0p0mZql
         8FNDoBwRdvgPc9fhgLdeV6FdDwYev4oIC8L7u4rjeUAQL7ttdLTEs/k2C6gNL5I5O5NJ
         ALSSCylms5+qBDzG6p8ZDPdaiKSTuJJ8O/rlF8bxOSzb9Q5MUz9gflBPCalggzvFefRq
         I6On+vnZ3S63VtOC7+24OhBeyiNBaw2U793hfkT18TEmubL0jTjF8Bnosr26EmAbw+XC
         fxHQ==
X-Gm-Message-State: AOAM533PYx1iew9pKg59eE24yzeX3Z0gNzlYMJBcGVDpdKZ6pSkWUCMF
        ZgN/OHpeyZ/VHY8jY8cLTC4J0ZjkaZ0=
X-Google-Smtp-Source: ABdhPJxopWWJAXlZyuVjEWJvEpGFMfvhmeIHL3VvQhtRtHSrwjuIoJhwNl8H+7DCFybxZnq275Bk9Q==
X-Received: by 2002:a1c:bd8b:: with SMTP id n133mr4726798wmf.9.1611759731069;
        Wed, 27 Jan 2021 07:02:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s25sm2712891wmj.24.2021.01.27.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:10 -0800 (PST)
Message-Id: <d8d8e9e2aa3faf0fdda5dc688fb92e924fec423a.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:51 +0000
Subject: [PATCH v2 12/17] chunk-format: create read chunk API
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

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 chunk-format.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
 chunk-format.h | 33 +++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/chunk-format.c b/chunk-format.c
index ab914c55856..74501084cf8 100644
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
+int pair_chunk(struct chunkfile *cf,
+	       uint32_t chunk_id,
+	       const unsigned char **p)
+{
+	int i;
+
+	for (i = 0; i < cf->chunks_nr; i++) {
+		if (cf->chunks[i].id == chunk_id) {
+			*p = cf->chunks[i].start;
+			return 0;
+		}
+	}
+
+	return CHUNK_NOT_FOUND;
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
index bfaed672813..b62c9bf8ba1 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -17,4 +17,37 @@ void add_chunk(struct chunkfile *cf,
 	       size_t size);
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

