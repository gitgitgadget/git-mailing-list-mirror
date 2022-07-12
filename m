Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8242C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 20:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiGLUHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiGLUHS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 16:07:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8662B31E4
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:07:16 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r10so6523609wrv.4
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 13:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ObeE/Wdd9ePpjZA+K+Q8md0or7ezhxyNA4L2ghRnJ7M=;
        b=XwFFYYB3zv1m2aHIQI2H0tCyJvDX6DC6XqwJm/vUbA+806krbCPasxcOEyi77/WCYv
         zjRmyNKgBAzn7QbIcI2KRuSVnnbP49F6gIJhNf4F1iD64yejAKF0Wbx8fVymXt5D2vwX
         m1xIgvClDLw0O0xCVacexVU72IKXYB3owYi1UOKnim710qzEtTY8+rdml9RBlG6DHXOS
         nfGKgARRoGqqXclFj/x+WMuIl6XiscRhL19iNNBCnBlScRTpgoHUlg+1Uj1AUFA10g6Z
         LmBFjkgqwhlrJYl1xcr1FIE0YOd0cFjlb8U7psQEUjbkOKitbxybWU9kT3aDc4phFPdP
         s1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ObeE/Wdd9ePpjZA+K+Q8md0or7ezhxyNA4L2ghRnJ7M=;
        b=fCcBiI58DKL3SJWiwM//tQktLoVZjoAxudzeDvW+7yT3RZGL7GRSeyszPZL9smKscg
         I/9XPLgaTR7Yg2TOCh366FaPzOjfNHUHC3YypdP6AQVMXOxLrFQDxPSwjKq6BKNzRv2D
         58+akIOlJLznhUwNAEWo3FCg0wgPyDh2G87cdLdDhuQNFE7X9sQNLUa/okyxkS1LPxnZ
         7mvu5sAod68aNbxAiuBgzbjPwLV91ZM/buP5ENR77oN38T3mJF2dHyRf4vKjaJrKg4Xc
         Fy8QDRooyhT09HPcte14tAX3UEeqxynZeiUmbrq3UQ4b1bo1Uvgny42+QV1L2uOxRfEn
         cyqQ==
X-Gm-Message-State: AJIora8DJDEHU3ontvRb3TbdOBL0Jk9aCaUbbAcU0QvDhr8VYJdo2s5q
        5vqwYhuO+0Pj5GnIOGVsZwa40Y5yX8J6UQ==
X-Google-Smtp-Source: AGRyM1toN+bw0dtdzeK3/yOKJymdyZkMdOUBPhDrWeK22Xh+lPz+Vyer6BHtUkDhYwUfgG211jzISA==
X-Received: by 2002:adf:e503:0:b0:21d:6d98:a92a with SMTP id j3-20020adfe503000000b0021d6d98a92amr23488863wrm.62.1657656434878;
        Tue, 12 Jul 2022 13:07:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b5-20020adfe305000000b0021d8c8c79dbsm8929448wrj.65.2022.07.12.13.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:07:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/7] docs: move commit-graph format docs to man section 5
Date:   Tue, 12 Jul 2022 22:06:58 +0200
Message-Id: <patch-v3-3.7-d548c6aaba7-20220712T195419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211212T194047Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com>
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
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (88%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 404139274e7..cc6870cce41 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -25,6 +25,7 @@ MAN1_TXT += gitweb.txt
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
similarity index 88%
rename from Documentation/technical/commit-graph-format.txt
rename to Documentation/gitformat-commit-graph.txt
index 484b185ba98..108dc2295c0 100644
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
 
-  Generation Data (ID: {'G', 'D', 'A', '2' }) (N * 4 bytes) [Optional]
+==== Generation Data (ID: {'G', 'D', 'A', '2' }) (N * 4 bytes) [Optional]
     * This list of 4-byte values store corrected commit date offsets for the
       commits, arranged in the same order as commit data chunk.
     * If the corrected commit date offset cannot be stored within 31 bits,
@@ -104,7 +117,7 @@ CHUNK DATA:
       by compatible versions of Git and in case of split commit-graph chains,
       the topmost layer also has Generation Data chunk.
 
-  Generation Data Overflow (ID: {'G', 'D', 'O', '2' }) [Optional]
+==== Generation Data Overflow (ID: {'G', 'D', 'O', '2' }) [Optional]
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
@@ -147,13 +160,13 @@ CHUNK DATA:
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
 
@@ -164,3 +177,7 @@ the number '2' in their chunk IDs because a previous version of Git wrote
 possibly erroneous data in these chunks with the IDs "GDAT" and "GDOV". By
 changing the IDs, newer versions of Git will silently ignore those older
 chunks and write the new information without trusting the incorrect data.
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
index 1794a7279bc..66e6a0ba217 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -209,6 +209,7 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        gitformats
+gitformat-commit-graph                  gitformats
 gitglossary                             guide
 githooks                                userformats
 gitignore                               userformats
-- 
2.37.0.932.g7b7031e73bc

