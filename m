Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F93C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 12:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiHBM6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiHBM6I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 08:58:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17F012616
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 05:58:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso221222wma.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 05:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=m4KKQWfNYzNH8mujpFsFBo2PP/tjf0m9MzNBSqePNWk=;
        b=VzS5nuf1qaYj9sqcUMx9bndgghmeAIIcHKkvM3LNhQUW3uI3YcRf1jhELYxnYjlFZ7
         AyEFxwvRPWjFKqSDUKqpQZYk9e3frxTJdJ6DOWXvClAUpZwtOuyWDhF5Jg2iRKmtJyNl
         8hWFfLM2MOgdcx26acoVWPJfyrIx3y+icdKt9vDTP9w8mgcOcyEQp05l8NdTNG91sJqN
         iQhf/JAxuEInlHI+usKQJ3L6JuaPKJ95iZikwI8HBYv9zDeLChzd1D/An4YVnRMq3Hqx
         Y2xpgZpwO2MOuRez/BSBAlPSsRyUQtLQUOeh/W0f7zrKOaOXGXkAPIDWpHvGx5wJD17Q
         Df3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=m4KKQWfNYzNH8mujpFsFBo2PP/tjf0m9MzNBSqePNWk=;
        b=jXTGNW8QiLCOBabC8O9f20zdNTUqbILUpeT0p36Fgchk7BrZcrkwOa7QRefjso6wbX
         OaW1RJK9RnqRZ4hLeF+1KLbMmLIGpcssx3YmxMIP9GBz/8L+PJHusYsKsAeLt+VIJq3U
         xYS9BYzSM6eurPVtXkfzF6XNYLcjEi7P2mjAclzcvomz0rJgPaRWFKMcaI2UbD7udVlK
         DZNysbwB+J4A6OyjP6V4oy6wq8LhxbMYP+DJNxzeduDL/B0jjA+1nzFsRqnmvm1FX855
         xo3lDRmUFE2lZ0dcbdNv6VoeyU5PPbywMvEawT8kITl0D9FzLvbMkP+SeKKWgrni15Z8
         uS2w==
X-Gm-Message-State: AJIora+oQQpSpKVmE8FhdHEf5NwCFKrJNb1V5vh/fOyY9mwVZxRjxpKf
        dXyTobOCawaYd+z3/Q8UCCNKX/GfACyZjw==
X-Google-Smtp-Source: AGRyM1ulXq9rYgHhgsXsvJIZAPYS9OJjuRQpGnyb5txFIR1M6QUFe7kqiGd5qxqpVaUXwpj0WQQ9nQ==
X-Received: by 2002:a05:600c:35c6:b0:3a3:4217:f06e with SMTP id r6-20020a05600c35c600b003a34217f06emr13633307wmq.95.1659445084915;
        Tue, 02 Aug 2022 05:58:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t4-20020adfeb84000000b0021e45afa7b0sm15056145wrn.109.2022.08.02.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 05:58:04 -0700 (PDT)
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
Subject: [PATCH v7 06/10] docs: move commit-graph format docs to man section 5
Date:   Tue,  2 Aug 2022 14:56:55 +0200
Message-Id: <patch-v7-06.10-5adabbb3a26-20220802T125258Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1232.gc0cde427aa7
In-Reply-To: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the move of existing Documentation/technical/* protocol and
file-format documentation into our main documentation space.

By moving the documentation for the commit-graph format into man
section 5 and the new "developerinterfaces" category. This change is
split from subsequent commits due to the relatively large amount of
ASCIIDOC formatting changes that are required.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  1 +
 Documentation/git-commit-graph.txt            |  5 ++
 ...-format.txt => gitformat-commit-graph.txt} | 47 +++++++++++++------
 Documentation/technical/chunk-format.txt      |  4 +-
 command-list.txt                              |  2 +
 5 files changed, 42 insertions(+), 17 deletions(-)
 rename Documentation/{technical/commit-graph-format.txt => gitformat-commit-graph.txt} (88%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1a4a545f44a..e7bd72bb84e 100644
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
index 1950c4ccd9c..44e244a76f6 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -210,6 +210,8 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        developerinterfaces
+gitformat-bundle                        developerinterfaces
+gitformat-commit-graph                  developerinterfaces
 gitglossary                             guide
 githooks                                userinterfaces
 gitignore                               userinterfaces
-- 
2.37.1.1232.gc0cde427aa7

