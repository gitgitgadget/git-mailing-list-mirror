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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A89EC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 16:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BAD64E93
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 16:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhBEOxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 09:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbhBEOqq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:46:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111E2C061786
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:24:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f1so10706568lfu.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VY70YxpMWWO9iYCYRFM9nL7VSofDIl8bmBKvouWjznc=;
        b=BboFbZoqaVlMV3pgrGxs7zsiFQVgk8pRkScgJUIi0u5dhesok22k7ys16eZR8v6qOI
         FEUgeYyyErk2V8x8+NJA/reHoHAhXq0Y/eANyBrZoB4ygE9E88U+VaJM+nfdFpPrtdw2
         hRmcYQp9hLlAhGprnqzM12KjrgFAxRhOdPgGo5W/3lzHI+NYZGXg5NM3Np+/+SIzKlom
         pv0RHorOOo0/EM2SwqdiBQpp0Sgm7bwmA+IsOFZ0Nw/hA+1zU2avu3MFNoFRxjSYzw8V
         aTRVLDWbhNn9qdk+7vL9t+L40MhLBa38aGyZzgZxPfvL9vlASbmyz1D6XTRBG5QY3Fl6
         UFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VY70YxpMWWO9iYCYRFM9nL7VSofDIl8bmBKvouWjznc=;
        b=mcD8pCXavSLfjHXLPdLa3NXodl/dWw+EE4Xljgo1dS7cMbc1R8DeBMcMOViAcBuCK2
         x5QH3Yz/Jvfe7Sz1VICLnY8xeZlkOTVUD6MwLYF9jAvyYtcsHi/YxvCfJFOmBrxBTNIB
         /XbrIgTKp0AxpXU1yxu7C0/6RCT1M+kKJC0ZrPeRyI7GMEBZir86NS6LKjmHtA2dEVQ2
         6WZ86qH3jbpPNLBrv3V2dIzy6oq9txIeNRC6epgpL1R7uzoURpONy/f8TsAzprQ21b0d
         qwbLfVZnywmjPSpQ3yyCtbDLBsLQkw3SLSYFCPuPtFS3LNIMnhaD7DqL05F02idU2ANy
         HlYg==
X-Gm-Message-State: AOAM532Vm71o6IihO1q6ZeVTI7n3UK+4sa1sXUvZ1BaZtTPpQa3EUa73
        YEzv5WNPFc3W7K0s8c66QzLAO3MAJTE=
X-Google-Smtp-Source: ABdhPJwjKz5FAC1DiVv94/jzrSe9s7jCgI6DiD/OJ8x6U8Zv2DwJ8+ODCf7o/gXDzex+nUBhPs7rPg==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr5234772wrw.379.1612535472209;
        Fri, 05 Feb 2021 06:31:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm12219440wrx.18.2021.02.05.06.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:31:11 -0800 (PST)
Message-Id: <4c7d751f1e39df30fe9ba3b3e9e0829ddead0340.1612535453.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
        <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:30:52 +0000
Subject: [PATCH v3 17/17] chunk-format: add technical docs
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

The chunk-based file format is now an API in the code, but we should
also take time to document it as a file format. Specifically, it matches
the CHUNK LOOKUP sections of the commit-graph and multi-pack-index
files, but there are some commonalities that should be grouped in this
document.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/chunk-format.txt      | 116 ++++++++++++++++++
 .../technical/commit-graph-format.txt         |   3 +
 Documentation/technical/pack-format.txt       |   3 +
 3 files changed, 122 insertions(+)
 create mode 100644 Documentation/technical/chunk-format.txt

diff --git a/Documentation/technical/chunk-format.txt b/Documentation/technical/chunk-format.txt
new file mode 100644
index 000000000000..593614fcedab
--- /dev/null
+++ b/Documentation/technical/chunk-format.txt
@@ -0,0 +1,116 @@
+Chunk-based file formats
+========================
+
+Some file formats in Git use a common concept of "chunks" to describe
+sections of the file. This allows structured access to a large file by
+scanning a small "table of contents" for the remaining data. This common
+format is used by the `commit-graph` and `multi-pack-index` files. See
+link:technical/pack-format.html[the `multi-pack-index` format] and
+link:technical/commit-graph-format.html[the `commit-graph` format] for
+how they use the chunks to describe structured data.
+
+A chunk-based file format begins with some header information custom to
+that format. That header should include enough information to identify
+the file type, format version, and number of chunks in the file. From this
+information, that file can determine the start of the chunk-based region.
+
+The chunk-based region starts with a table of contents describing where
+each chunk starts and ends. This consists of (C+1) rows of 12 bytes each,
+where C is the number of chunks. Consider the following table:
+
+  | Chunk ID (4 bytes) | Chunk Offset (8 bytes) |
+  |--------------------|------------------------|
+  | ID[0]              | OFFSET[0]              |
+  | ...                | ...                    |
+  | ID[C]              | OFFSET[C]              |
+  | 0x0000             | OFFSET[C+1]            |
+
+Each row consists of a 4-byte chunk identifier (ID) and an 8-byte offset.
+Each integer is stored in network-byte order.
+
+The chunk identifier `ID[i]` is a label for the data stored within this
+fill from `OFFSET[i]` (inclusive) to `OFFSET[i+1]` (exclusive). Thus, the
+size of the `i`th chunk is equal to the difference between `OFFSET[i+1]`
+and `OFFSET[i]`. This requires that the chunk data appears contiguously
+in the same order as the table of contents.
+
+The final entry in the table of contents must be four zero bytes. This
+confirms that the table of contents is ending and provides the offset for
+the end of the chunk-based data.
+
+Note: The chunk-based format expects that the file contains _at least_ a
+trailing hash after `OFFSET[C+1]`.
+
+Functions for working with chunk-based file formats are declared in
+`chunk-format.h`. Using these methods provide extra checks that assist
+developers when creating new file formats.
+
+Writing chunk-based file formats
+--------------------------------
+
+To write a chunk-based file format, create a `struct chunkfile` by
+calling `init_chunkfile()` and pass a `struct hashfile` pointer. The
+caller is responsible for opening the `hashfile` and writing header
+information so the file format is identifiable before the chunk-based
+format begins.
+
+Then, call `add_chunk()` for each chunk that is intended for write. This
+populates the `chunkfile` with information about the order and size of
+each chunk to write. Provide a `chunk_write_fn` function pointer to
+perform the write of the chunk data upon request.
+
+Call `write_chunkfile()` to write the table of contents to the `hashfile`
+followed by each of the chunks. This will verify that each chunk wrote
+the expected amount of data so the table of contents is correct.
+
+Finally, call `free_chunkfile()` to clear the `struct chunkfile` data. The
+caller is responsible for finalizing the `hashfile` by writing the trailing
+hash and closing the file.
+
+Reading chunk-based file formats
+--------------------------------
+
+To read a chunk-based file format, the file must be opened as a
+memory-mapped region. The chunk-format API expects that the entire file
+is mapped as a contiguous memory region.
+
+Initialize a `struct chunkfile` pointer with `init_chunkfile(NULL)`.
+
+After reading the header information from the beginning of the file,
+including the chunk count, call `read_table_of_contents()` to populate
+the `struct chunkfile` with the list of chunks, their offsets, and their
+sizes.
+
+Extract the data information for each chunk using `pair_chunk()` or
+`read_chunk()`:
+
+* `pair_chunk()` assigns a given pointer with the location inside the
+  memory-mapped file corresponding to that chunk's offset. If the chunk
+  does not exist, then the pointer is not modified.
+
+* `read_chunk()` takes a `chunk_read_fn` function pointer and calls it
+  with the appropriate initial pointer and size information. The function
+  is not called if the chunk does not exist. Use this method to read chunks
+  if you need to perform immediate parsing or if you need to execute logic
+  based on the size of the chunk.
+
+After calling these methods, call `free_chunkfile()` to clear the
+`struct chunkfile` data. This will not close the memory-mapped region.
+Callers are expected to own that data for the timeframe the pointers into
+the region are needed.
+
+Examples
+--------
+
+These file formats use the chunk-format API, and can be used as examples
+for future formats:
+
+* *commit-graph:* see `write_commit_graph_file()` and `parse_commit_graph()`
+  in `commit-graph.c` for how the chunk-format API is used to write and
+  parse the commit-graph file format documented in
+  link:technical/commit-graph-format.html[the commit-graph file format].
+
+* *multi-pack-index:* see `write_midx_internal()` and `load_multi_pack_index()`
+  in `midx.c` for how the chunk-format API is used to write and
+  parse the multi-pack-index file format documented in
+  link:technical/pack-format.html[the multi-pack-index file format].
diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index b6658eff1882..87971c27dd73 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -61,6 +61,9 @@ CHUNK LOOKUP:
       the length using the next chunk position if necessary.) Each chunk
       ID appears at most once.
 
+  The CHUNK LOOKUP matches the table of contents from
+  link:technical/chunk-format.html[the chunk-based file format].
+
   The remaining data in the body is described one chunk at a time, and
   these chunks may be given in any order. Chunks are required unless
   otherwise specified.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index f96b2e605f34..2fb1e60d29ec 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -301,6 +301,9 @@ CHUNK LOOKUP:
 	    (Chunks are provided in file-order, so you can infer the length
 	    using the next chunk position if necessary.)
 
+	The CHUNK LOOKUP matches the table of contents from
+	link:technical/chunk-format.html[the chunk-based file format].
+
 	The remaining data in the body is described one chunk at a time, and
 	these chunks may be given in any order. Chunks are required unless
 	otherwise specified.
-- 
gitgitgadget
