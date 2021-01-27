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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF33C433DB
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38878207D0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 15:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhA0Pez (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 10:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhA0PFP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 10:05:15 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD599C061221
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:17 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h9so2227351wrr.9
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 07:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/31wU3H+Rpd5f02JkLU2apACd46gCGYTclTqM21pbrU=;
        b=RGKngy0xof48CDrWck0RiLoH8QLRTj9BkrR+HiH5rVb2jNbbsoQL2Y/nWKlpG2/uV3
         aa03OoOfRql3W9pecV9qxd3z5uq4P1xb4/MLSbgmNNSSi4pvgnG327Feb1ruzR3WBa3b
         Kp+e8LEdvSy6wqyEEP3x4q8x/+lV5FbuXurGgLUr7KDmkaxot10KrB8kIaHkbZymboDP
         gXc8rwi9anrGFnTlPn9X0Mp2JrU6PeTN0jjN7N8mi+4I5qizXdg3EVBQrBSTG2XuO8RP
         VcUOo7wHX7kWImtYwhqJvLARwKkcLSPa2imaAWy7pObR5uyoEgttSx5q1SZUDaZDFF7E
         EsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/31wU3H+Rpd5f02JkLU2apACd46gCGYTclTqM21pbrU=;
        b=QajttKdzFceHo3h9Ggozh5bxqNn/ZT+V+e6aRvqwNbicvyVQfO1u+WyET6sLIBN9xM
         spIbTJzdirnoiqV56/y0qgUzUWxtgoYef4c/eQoevVHI4eOsHPDwuycOIqNCGzfp93z5
         7AVGXo0sF1x45dL3U/iiQ8IbR+9X9iHNsvOFTGyljesfLJDCtFZwwxaKZv4NI9CjwjNE
         iflhEw51coEpFXekMbpJfeeN1s/8HtwQQnjqLKs/pqD3V6NHVC7/PqEk3BiNnZtzxDPY
         5r69LmjbHGDUcjds5b68+WRwId+L5/sXKnhKQWFfcOieMCVBOUfQ6Afea1EhURksS2BB
         yEAA==
X-Gm-Message-State: AOAM530I2GK0g9g7+aUWxvTE9tPzHMh4DutHDL7rEvP83+s8Sti220zo
        tK7u5C+nnOcpFeksHXpVfqcJuG1l7MU=
X-Google-Smtp-Source: ABdhPJzPc7tCV6IT0sOPcvzSru6jbSJyf4D1j2miJSIxLSqD0hnUfgdap6h+kmoNBVLUdg/hUxPifw==
X-Received: by 2002:a5d:6092:: with SMTP id w18mr11529833wrt.75.1611759736310;
        Wed, 27 Jan 2021 07:02:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c20sm2646925wmb.38.2021.01.27.07.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:02:15 -0800 (PST)
Message-Id: <8f3985ab5df3e4abc6de6db7f71f1adcbc16b4a8.1611759716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
        <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 15:01:56 +0000
Subject: [PATCH v2 17/17] chunk-format: add technical docs
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
 Documentation/technical/chunk-format.txt      | 54 +++++++++++++++++++
 .../technical/commit-graph-format.txt         |  3 ++
 Documentation/technical/pack-format.txt       |  3 ++
 3 files changed, 60 insertions(+)
 create mode 100644 Documentation/technical/chunk-format.txt

diff --git a/Documentation/technical/chunk-format.txt b/Documentation/technical/chunk-format.txt
new file mode 100644
index 00000000000..3db3792dea2
--- /dev/null
+++ b/Documentation/technical/chunk-format.txt
@@ -0,0 +1,54 @@
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
+developers when creating new file formats, including:
+
+ 1. Writing and reading the table of contents.
+
+ 2. Verifying that the data written in a chunk matches the expected size
+    that was recorded in the table of contents.
+
+ 3. Checking that a table of contents describes offsets properly within
+    the file boundaries.
diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index b6658eff188..87971c27dd7 100644
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
index f96b2e605f3..2fb1e60d29e 100644
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
