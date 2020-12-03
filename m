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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57AEC4167B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8480C207AC
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgLCQRl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgLCQRk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:17:40 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743FC061A53
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:00 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k14so2467843wrn.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IiAJ5xlfj99x+csrAVzw+pba+/C2uo7MRvgOolgqv98=;
        b=d112AYOBRcRPqAXwfRPz3aBZhIgUwy9e1wxSEDMNXLKUqgAziP/3wdByMwkqjneQVF
         xm/4KiSi0xmeT2vBt5DhUCjM9ndJe/TFtxl0SdF5PKOIc0ntCJHawgtQwCSckIDR8PRq
         ZilP2SLv7d1oTP6hIFXVaw1IBvMn1t4MeyclkfHTN1+BOjGwnEhgUat5ZXVXllKiN03k
         z/cFoA+hPdiWtM0rFBczHa0SNNFpZyQLGr2WCqH13gAUkQL2kdwFSowL1d+WIw8Pqb0d
         8jM1x6OtnG3u+jrZzcIw2UGQSI2rfXRMPsMPkJoX94XtbjkYbIw+p+fq12q9BLOK9wsE
         ibOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IiAJ5xlfj99x+csrAVzw+pba+/C2uo7MRvgOolgqv98=;
        b=KxVo7DzlDN8l03GV3ESXZYK8jmGP3dliPGmwOHifs70RGUAl2gYMubZ0Gd8fXF6bGm
         wCbG6ml2t46nhmSUczvASYT+2MmK1xWWyB9gGwYTgLF4QE9UAQQ46i2jRM/bAnKpQJlC
         1Mr77kus292o3OUvRltEGa9jHj6wTPcvL4joZGS0mddO/LyqLJbaVHZqCMkWtUvPdI/e
         1Qb+NQBJ/FZbILHi1qaJqRrW9DzerQoXZsqnKKFaoj6CnPTyu0OM73z36QoxoKB6IQ5m
         +WVC1xC6FAmlCHQBT7IBSu26SjeMj4+53RV+W41Wp1W2MSRoDFdgbuJ5LAvYkAN81GEe
         g+Sg==
X-Gm-Message-State: AOAM532rmYWtyH2S3rsyMYJapng9pi3oVXy6Uz7bP/JT5OHB+SaBzOqW
        AUAkHgxmyoAq6/9Ox2fAE9vnjYQRQ7s=
X-Google-Smtp-Source: ABdhPJxY/KksidXlIPbOf8lMe8D9lcpKHFJztZ8+RXPE3b7HwQuuNqoyT+AYDLz8UQ4tB7KTzNXCjg==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr4604047wrv.112.1607012218606;
        Thu, 03 Dec 2020 08:16:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm1932159wmi.33.2020.12.03.08.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:16:58 -0800 (PST)
Message-Id: <da7933cc59928c7995821dcc72ceae0c690ebaca.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:41 +0000
Subject: [PATCH 02/15] chunk-format: add API for writing table of contents
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

The commit-graph and multi-pack-index formats share a concept of
"chunks" that are described by a table of contents near the beginning of
the file.

The table of contents consists of rows of 12 bytes. Each row starts with
a 4-byte ID that signals the type of data stored in the chunk. The row
then continues with an 8-byte offset describing the position in the file
where that data starts. The table of contents lists the chunks in
position order so the length of a chunk can be determined by subtracting
its start position from the start position of the next chunk.

The table of contents always ends with ID 0x0000 to assist finding the
end of the last "real" chunk. Typically, this points to the trailing
hash of a file.

Convert the chunk-writing loop in commit-graph.c to use the new
write_table_of_contents() method in chunk-format.c.

The most subtle part of this conversion is the use of 'cur_offset' to
allow the caller to specify how many bytes were written in the file's
header before the table of contents. This may differ between formats.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Makefile       |  1 +
 chunk-format.c | 26 ++++++++++++++++++++++++++
 chunk-format.h | 36 ++++++++++++++++++++++++++++++++++++
 commit-graph.c | 23 ++---------------------
 4 files changed, 65 insertions(+), 21 deletions(-)
 create mode 100644 chunk-format.c
 create mode 100644 chunk-format.h

diff --git a/Makefile b/Makefile
index d3a531d3c6..cdbcadac14 100644
--- a/Makefile
+++ b/Makefile
@@ -854,6 +854,7 @@ LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += chdir-notify.o
 LIB_OBJS += checkout.o
+LIB_OBJS += chunk-format.o
 LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
diff --git a/chunk-format.c b/chunk-format.c
new file mode 100644
index 0000000000..771b6d98d0
--- /dev/null
+++ b/chunk-format.c
@@ -0,0 +1,26 @@
+#include "git-compat-util.h"
+#include "chunk-format.h"
+#include "csum-file.h"
+#define CHUNK_LOOKUP_WIDTH 12
+
+void write_table_of_contents(struct hashfile *f,
+			     uint64_t cur_offset,
+			     struct chunk_info *chunks,
+			     int nr)
+{
+	int i;
+
+	/* Add the table of contents to the current offset */
+	cur_offset += (nr + 1) * CHUNK_LOOKUP_WIDTH;
+
+	for (i = 0; i < nr; i++) {
+		hashwrite_be32(f, chunks[i].id);
+		hashwrite_be64(f, cur_offset);
+
+		cur_offset += chunks[i].size;
+	}
+
+	/* Trailing entry marks the end of the chunks */
+	hashwrite_be32(f, 0);
+	hashwrite_be64(f, cur_offset);
+}
diff --git a/chunk-format.h b/chunk-format.h
new file mode 100644
index 0000000000..4b9cbeb372
--- /dev/null
+++ b/chunk-format.h
@@ -0,0 +1,36 @@
+#ifndef CHUNK_FORMAT_H
+#define CHUNK_FORMAT_H
+
+#include "git-compat-util.h"
+
+struct hashfile;
+
+typedef int (*chunk_write_fn)(struct hashfile *f,
+			      void *data);
+
+/*
+ * When writing a chunk-based file format, collect the chunks in
+ * an array of chunk_info structs. The size stores the _expected_
+ * amount of data that will be written by write_fn.
+ */
+struct chunk_info {
+	uint32_t id;
+	uint64_t size;
+	chunk_write_fn write_fn;
+};
+
+/*
+ * Write the chunk data into the supplied hashfile.
+ *
+ * * 'cur_offset' indicates the number of bytes written to the hashfile
+ *   before the table of contents starts.
+ *
+ * * 'nr' is the number of chunks with non-zero IDs, so 'nr + 1'
+ *   chunks are written in total.
+ */
+void write_table_of_contents(struct hashfile *f,
+			     uint64_t cur_offset,
+			     struct chunk_info *chunks,
+			     int nr);
+
+#endif
diff --git a/commit-graph.c b/commit-graph.c
index 6b5bb8b6b8..5494fda1d3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -19,6 +19,7 @@
 #include "shallow.h"
 #include "json-writer.h"
 #include "trace2.h"
+#include "chunk-format.h"
 
 void git_test_write_commit_graph_or_die(void)
 {
@@ -1696,15 +1697,6 @@ static int write_graph_chunk_base(struct hashfile *f,
 	return 0;
 }
 
-typedef int (*chunk_write_fn)(struct hashfile *f,
-			      void *data);
-
-struct chunk_info {
-	uint32_t id;
-	uint64_t size;
-	chunk_write_fn write_fn;
-};
-
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
@@ -1715,7 +1707,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
 	int num_chunks = 3;
-	uint64_t chunk_offset;
 	struct object_id file_hash;
 
 	if (ctx->split) {
@@ -1805,17 +1796,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, ctx->num_commit_graphs_after - 1);
 
-	chunk_offset = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
-	for (i = 0; i <= num_chunks; i++) {
-		uint32_t chunk_write[3];
-
-		chunk_write[0] = htonl(chunks[i].id);
-		chunk_write[1] = htonl(chunk_offset >> 32);
-		chunk_write[2] = htonl(chunk_offset & 0xffffffff);
-		hashwrite(f, chunk_write, 12);
-
-		chunk_offset += chunks[i].size;
-	}
+	write_table_of_contents(f, /* cur_offset */ 8, chunks, num_chunks);
 
 	if (ctx->report_progress) {
 		strbuf_addf(&progress_title,
-- 
gitgitgadget

