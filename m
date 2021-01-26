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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E777C433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE882245C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404310AbhAZQDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404570AbhAZQCu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:50 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91573C0698CB
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:45 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 6so17019896wri.3
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/31wU3H+Rpd5f02JkLU2apACd46gCGYTclTqM21pbrU=;
        b=WH1gy189bG8syuAuMMA8X5of+0Qp3VhR7nIfFuXmQHgMJXW+Xidwca+Obgzhx2C+f+
         5nB76y3MODoeRmZtKTIvJzlAebEzB8BP5PhyPOcpY527MHmiEqtuKn4WH7qmL1X2bLpN
         RsoH2WAF0OQIPCdip1GS49MXJ3AVDPzBP+Mu4zd0Uqo2Itn6FGLwtpARubn4weIRXMeN
         99D1jWX7lm+iLbsZBjvAOJEMRCYIF6bCLl1nAce5yX1rU18b13ZFEBFms9bHgWatFjkz
         iOW96gMNqfIhZPWGUe1AT7YbO//cW7r6ZzGRv0V3g0IJdnC6zganhTMuaS1TsQMDWb64
         4vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/31wU3H+Rpd5f02JkLU2apACd46gCGYTclTqM21pbrU=;
        b=qAMMLyQCu65WlR0uiXQyiswtHNe9x3hzEAfHSLhvrVbYLFSt6tkVaWvu0MZvXkEasg
         JNJHHwHnuEymgOVUtV4n9RD9l7DHB7CB1Fq0kOM8F9e6XCAPIsIy+R5qj08r6DMIZgNP
         k/sl+OBmt0EwWxkDcE4Yp50ydHBXPne9UeixwROq9bE6k0H+YuuYYzFNpQEv48zHsBJm
         PpzxXDFRKX3q6tTOcjimNicyI7J/7UPAiFkaKVi0R1YdepA4hPxfE3r8ARAEXGzC/HD7
         OgUnbIpC4sEXvCt8kauUtUFd5KcaHmo4HehcINPa6qCKSI6eVRvtEzC/EDhl6PozIkMm
         jSTQ==
X-Gm-Message-State: AOAM53352ZPvpgq9shwEdSeKH4VjV8jjkc1nR8PifzzQ+dlvJhtq3Ve9
        ExXD98TkDOtyJMM+yV9QO3aUpa+n2QU=
X-Google-Smtp-Source: ABdhPJwAZHOMvDFOmAqpszmk6mDC4AyHbP7tRBFDrBw7r+k+wYUaKSlQ2ZRHsbuhrJ2j/jfFWzyoCA==
X-Received: by 2002:adf:f909:: with SMTP id b9mr7028152wrr.111.1611676904149;
        Tue, 26 Jan 2021 08:01:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm3670237wmc.13.2021.01.26.08.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:43 -0800 (PST)
Message-Id: <05cbd0a8d93a3e54d868a549fe76e16cb75ba6d6.1611676886.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.848.git.1611676886.gitgitgadget@gmail.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:26 +0000
Subject: [PATCH 17/17] chunk-format: add technical docs
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
