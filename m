Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF2EC433F5
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 19:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhLLTvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:51:00 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:41619 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLLTus (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 14:50:48 -0500
Received: by mail-wm1-f42.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so10364022wmb.0
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTrnlDA0gTMyo1tgvBkWvSsxavjvq5ZecF1TxUL0uZw=;
        b=fqC6iPDWyphkE2UTfmpCQEwNWgfKM+YGqWMu/LxQySdeVHKKtABs4mJON3HCH7pMiA
         CGK3dCq3t+Zb2bG0+JsQbc/z9xVWVXV80q0+k/IXDi4LNUTTrhES/5d+fmXxpfNEg7s1
         qMDF3nQO+90wVqpSwGJ4JpA4Gt++Tvlah1H4M4nQEanPCc5Wyddg6y9k+NzvsxD24Axf
         gJ6BKOlRw+r3D+MFTzkYG+5R4Rqr+jGKD0oLAQB30L+YT2fWmuvEF0VmnB2la3ZDIb95
         oxcn9+dPy0ZcV4/n08rdQOp2zud/ZFopmEA/kYrTfSkcwHLLmlYjgKiv5LiqhxQcgZrY
         oaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTrnlDA0gTMyo1tgvBkWvSsxavjvq5ZecF1TxUL0uZw=;
        b=4lMvnb5VBEpJ9vM8j7bxFxXG8sft6Thw8diL2cn1878OK2gfXzd1IF7oF/rqrEeVYp
         akRipBaJWJPqAwitwooElzZafOwXMTi508MBKeos1DyaiLI5DT3CinhvdLm7rs62d9sP
         A4jXeT9+evE/uUAXzAnA2+hsqwnynE0CH1rSm6WaLF4IcTluz1I9lhlPtcaT2I/SCQPe
         90CCEzPsOv6vU+IsR+RVwFzpCIAw1sMIj1M2Uzf48alNj2Aklmy4aeaHsgGE9EqbDNU9
         9xJ5XD3+1kD+drqRvIx3LcMfdM/0cgWDF32brgulnlRaXhXkervO/pFbWcB5LSkrG97I
         Ag6w==
X-Gm-Message-State: AOAM531y6jf/eNq+7TyDvG/gdL3WYFaiipehQScxM3dYwVKzQbHYSNjX
        gOrYeEcZ+fqPP3hQoLxFhYHUIGCbUqBYNA==
X-Google-Smtp-Source: ABdhPJw0HTbssXtcHBa4FU2vLLYiStOxfIqc5jyaCWcNfWlgcVQmlxM8Ownef1tv/js38iwxWJ/vHQ==
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr31589528wmj.156.1639338587375;
        Sun, 12 Dec 2021 11:49:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g4sm8293822wro.12.2021.12.12.11.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:49:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>, Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] docs: move commit-graph format docs to man section 5
Date:   Sun, 12 Dec 2021 20:49:38 +0100
Message-Id: <patch-v2-3.5-5abd59b807f-20211212T194047Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.929.ge922d848c7a
In-Reply-To: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the move of existing Documentation/technical/* protocol and
file-format documentation into our main documentation space.

By moving the documentation for the commit-graph format into man
section 5 and the new "gitformats" category. This change is split from
subsequent commits due to the relatively large amount of ASCIIDOC
formatting changes that are required.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  1 +
 Documentation/git-commit-graph.txt            |  5 ++
 ...-format.txt => gitformat-commit-graph.txt} | 47 +++++++++++++------
 Documentation/technical/chunk-format.txt      |  4 +-
 command-list.txt                              |  1 +
 5 files changed, 41 insertions(+), 17 deletions(-)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (87%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index fe8e1c56c7d..9483bde3420 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -22,6 +22,7 @@ MAN1_TXT += gitweb.txt
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += gitformat-bundle.txt
+MAN5_TXT += gitformat-commit-graph.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index e1f48c95b3c..047decdb65b 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -143,6 +143,11 @@ $ git rev-parse HEAD | git commit-graph write --stdin-commits --append
 ------------------------------------------------
 
 
+FILE FORMAT
+-----------
+
+see linkgit:gitformat-commit-graph[5].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/gitformat-commit-graph.txt
similarity index 87%
rename from Documentation/technical/commit-graph-format.txt
rename to Documentation/gitformat-commit-graph.txt
index 87971c27dd7..25eb131dcd2 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -1,5 +1,18 @@
-Git commit graph format
-=======================
+gitformat-commit-graph(5)
+=========================
+
+NAME
+----
+gitformat-commit-graph - Git commit graph format
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/objects/info/commit-graph
+$GIT_DIR/objects/info/commit-graphs/*
+
+DESCRIPTION
+-----------
 
 The Git commit graph stores a list of commit OIDs and some associated
 metadata, including:
@@ -30,7 +43,7 @@ and hash type.
 
 All multi-byte numbers are in network byte order.
 
-HEADER:
+=== HEADER:
 
   4-byte signature:
       The signature is: {'C', 'G', 'P', 'H'}
@@ -52,7 +65,7 @@ HEADER:
       We infer the length (H*B) of the Base Graphs chunk
       from this value.
 
-CHUNK LOOKUP:
+=== CHUNK LOOKUP:
 
   (C + 1) * 12 bytes listing the table of contents for the chunks:
       First 4 bytes describe the chunk id. Value 0 is a terminating label.
@@ -68,17 +81,17 @@ CHUNK LOOKUP:
   these chunks may be given in any order. Chunks are required unless
   otherwise specified.
 
-CHUNK DATA:
+=== CHUNK DATA:
 
-  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
+==== OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
       The ith entry, F[i], stores the number of OIDs with first
       byte at most i. Thus F[255] stores the total
       number of commits (N).
 
-  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
+====  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
       The OIDs for all commits in the graph, sorted in ascending order.
 
-  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
+====  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)
     * The first H bytes are for the OID of the root tree.
     * The next 8 bytes are for the positions of the first two parents
       of the ith commit. Stores value 0x70000000 if no parent in that
@@ -93,7 +106,7 @@ CHUNK DATA:
       2 bits of the lowest byte, storing the 33rd and 34th bit of the
       commit time.
 
-  Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
+==== Generation Data (ID: {'G', 'D', 'A', 'T' }) (N * 4 bytes) [Optional]
     * This list of 4-byte values store corrected commit date offsets for the
       commits, arranged in the same order as commit data chunk.
     * If the corrected commit date offset cannot be stored within 31 bits,
@@ -104,7 +117,7 @@ CHUNK DATA:
       by compatible versions of Git and in case of split commit-graph chains,
       the topmost layer also has Generation Data chunk.
 
-  Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
+==== Generation Data Overflow (ID: {'G', 'D', 'O', 'V' }) [Optional]
     * This list of 8-byte values stores the corrected commit date offsets
       for commits with corrected commit date offsets that cannot be
       stored within 31 bits.
@@ -112,7 +125,7 @@ CHUNK DATA:
       chunk is present and atleast one corrected commit date offset cannot
       be stored within 31 bits.
 
-  Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
+==== Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
       This list of 4-byte values store the second through nth parents for
       all octopus merges. The second parent value in the commit data stores
       an array position within this list along with the most-significant bit
@@ -120,14 +133,14 @@ CHUNK DATA:
       positions for the parents until reaching a value with the most-significant
       bit on. The other bits correspond to the position of the last parent.
 
-  Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
+==== Bloom Filter Index (ID: {'B', 'I', 'D', 'X'}) (N * 4 bytes) [Optional]
     * The ith entry, BIDX[i], stores the number of bytes in all Bloom filters
       from commit 0 to commit i (inclusive) in lexicographic order. The Bloom
       filter for the i-th commit spans from BIDX[i-1] to BIDX[i] (plus header
       length), where BIDX[-1] is 0.
     * The BIDX chunk is ignored if the BDAT chunk is not present.
 
-  Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
+==== Bloom Filter Data (ID: {'B', 'D', 'A', 'T'}) [Optional]
     * It starts with header consisting of three unsigned 32-bit integers:
       - Version of the hash algorithm being used. We currently only support
 	value 1 which corresponds to the 32-bit version of the murmur3 hash
@@ -147,12 +160,16 @@ CHUNK DATA:
       of length one, with either all bits set to zero or one respectively.
     * The BDAT chunk is present if and only if BIDX is present.
 
-  Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
+==== Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
       This list of H-byte hashes describe a set of B commit-graph files that
       form a commit-graph chain. The graph position for the ith commit in this
       file's OID Lookup chunk is equal to i plus the number of commits in all
       base graphs.  If B is non-zero, this chunk must exist.
 
-TRAILER:
+=== TRAILER:
 
 	H-byte HASH-checksum of all of the above.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/chunk-format.txt b/Documentation/technical/chunk-format.txt
index 593614fceda..f36ce42f37c 100644
--- a/Documentation/technical/chunk-format.txt
+++ b/Documentation/technical/chunk-format.txt
@@ -6,7 +6,7 @@ sections of the file. This allows structured access to a large file by
 scanning a small "table of contents" for the remaining data. This common
 format is used by the `commit-graph` and `multi-pack-index` files. See
 link:technical/pack-format.html[the `multi-pack-index` format] and
-link:technical/commit-graph-format.html[the `commit-graph` format] for
+the `commit-graph` format in linkgit:gitformat-commit-graph[5] for
 how they use the chunks to describe structured data.
 
 A chunk-based file format begins with some header information custom to
@@ -108,7 +108,7 @@ for future formats:
 * *commit-graph:* see `write_commit_graph_file()` and `parse_commit_graph()`
   in `commit-graph.c` for how the chunk-format API is used to write and
   parse the commit-graph file format documented in
-  link:technical/commit-graph-format.html[the commit-graph file format].
+  the commit-graph file format in linkgit:gitformat-commit-graph[5].
 
 * *multi-pack-index:* see `write_midx_internal()` and `load_multi_pack_index()`
   in `midx.c` for how the chunk-format API is used to write and
diff --git a/command-list.txt b/command-list.txt
index 40d27371228..f7dcc795e1e 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -208,6 +208,7 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        gitformats
+gitformat-commit-graph                  gitformats
 gitglossary                             guide
 githooks                                userformats
 gitignore                               userformats
-- 
2.34.1.929.ge922d848c7a

