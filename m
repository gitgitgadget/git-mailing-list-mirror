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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C0C4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E539207AA
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501894AbgLCQSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501889AbgLCQSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:18:20 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D52C08E864
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:17:13 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id f190so4531219wme.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qapLRmq+trRfHn8fUtX5V+BBJGktSVTO8UPHI/yN5eE=;
        b=n/T6DEJ4a4lLfY/ZyglBNu2vEH9gke0TC+uvcnsdmfsbFmVdLZ+rLhJhgQw1jY/9du
         fr2Uk8rXkAEq5I7yaBuCQNR0hb4tMgJX6pMFGizXkCaosWOpWl2zB+ZZO7pcWmM5zq2w
         NlZEw2VyV90tUOXAo8nhep/ZG9OwKR5BaDteuy1TngvEjVsKbqZEBlNrpwQ7LHfxtFYF
         woqy8GiLcjFdI2dcgMtG5kLRhTX5s1gFAOUpYOc3URA42E3dp/e140Iy55Q6jziUt8TK
         fNtHiU6dA5+7oNHg2i2TqhUULNooa9Iup04GYG5jeJlMQR4IGLBdLXZ+ofbULXfXDwv5
         fqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qapLRmq+trRfHn8fUtX5V+BBJGktSVTO8UPHI/yN5eE=;
        b=F7KhZMbmXNHsjIMV/i3uKiT0N3w6XKTV+jYqLa8y2mn5+CZN85krqZXb7f1jkzk2Li
         Gq33z5H071qUJfpYd1OvwCe4WY8FEVtCNixWe9rvIqwalCFAYAKtgI3jXhfD5VQP7f/I
         nMFmI/oajSyOCmxPwYQCWt8iY2GP8mGbjWu/UPjqcWLr15pJexXr5VN3E+VNheQmh38p
         uSat8C6S500z9l4ji+mHp/5BKVw3cjC8DBtXWDGxf6XPvHRMQGtHl7slLREeEzgnaBKl
         A5VYX9IXbSsDk3Dt8ngIoOAszZRmyDw9lbp4kqSA9NXWOYNDCGn6BJfRH+bS8wWXSGTY
         aNwQ==
X-Gm-Message-State: AOAM532AcAEsZ9D6XE1TNXwK61c863ydATu6xZ8RDO9WuHv25ItWFC4M
        8bSN0YEYpbJK4Hm76GdW+/+XlmkjXRE=
X-Google-Smtp-Source: ABdhPJwb0lrrzaD9naDDshdrtL9NSacf0JlCGnHNDYTqBAwTEr1ZgZaPQBONkJD2UPyejwVnaZ9Krw==
X-Received: by 2002:a1c:a706:: with SMTP id q6mr4223556wme.7.1607012231693;
        Thu, 03 Dec 2020 08:17:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o15sm2322277wrp.74.2020.12.03.08.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:17:11 -0800 (PST)
Message-Id: <2ce1c2a54261494df31808660792fef800dc9665.1607012215.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.804.git.1607012215.gitgitgadget@gmail.com>
References: <pull.804.git.1607012215.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Dec 2020 16:16:54 +0000
Subject: [PATCH 15/15] chunk-format: add technical docs
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
index 0000000000..3db3792dea
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
index b3b58880b9..b92442780e 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -65,6 +65,9 @@ CHUNK LOOKUP:
       the length using the next chunk position if necessary.) Each chunk
       ID appears at most once.
 
+  The CHUNK LOOKUP matches the table of contents from
+  link:technical/chunk-format.html[the chunk-based file format].
+
   The remaining data in the body is described one chunk at a time, and
   these chunks may be given in any order. Chunks are required unless
   otherwise specified.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index f96b2e605f..2fb1e60d29 100644
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
