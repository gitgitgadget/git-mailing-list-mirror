Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D33C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiG1QrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiG1QrG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:47:06 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B552E5C
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:47:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i8so2950314wro.11
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dV6+muxQubCMj8rKxOA/6lbfVszXEtZB8AHo7sDq7YA=;
        b=DBG+YUhhYzHy8gVGnH6lqdLcSA7l+AQSdlITZub9gLMZkKoNHPLMSNnEkd1KoI6VbA
         w2xXt/wVsSwMDv8gacrBhuWdIgI2HZ+yaC6RKaNXoeh/289DuJD8jLm+grQJOwc6nS+V
         JIb9NHLUW0+6Y5nGanDugOaTkADp+EWFQkmvQVfdKHBHY1l5/uS624HVwCfUFY7hw1RY
         7QW1MjTnkrSUgoI6eB/5rxDwYgXuscnmUykYCV2zbdKZSmGZ/Gg7oeQjoZTnu5pU/ZFg
         yoR6EOFswWtXOycXlbp59634nwtOkJZjXhJznxSp/8hNlx1rxLeI2+6KZyh0dgWckz/T
         imSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dV6+muxQubCMj8rKxOA/6lbfVszXEtZB8AHo7sDq7YA=;
        b=5XcbNp2U9eMYnPdLzxveqilu6+utf2RZK+nCN7XLvJD+8MiosgqexemmiDlF1WN3Rx
         0kW6yqbQesLMraRLKmma1eJsBfVEZj6Loj0ayivD0HRKL2Rysf0Nw//bMX5XcRjAl7NT
         QQiXy+wshh3JhLnRCaEqg9aKDoMdwprbRkz9erKXbqOfdZaOOfQImInUjdr7XGHgdMRR
         8xHhCaXIA6oNOQCHGLHnwGOJi4Tp3ms1H6b+9SYZXCfR9c3cYbdoHp2/z32gi7B/Fr6U
         oFeY8nYa4ci3519w0a8jgazIAt4Pwe+4dK89QOCb10KwfFTu18qdxSlG8LqtbtiOPIEe
         FBuQ==
X-Gm-Message-State: AJIora9iLNvGShpHGUjIZJuDu81ft+V+UjSmPh4Oa+8S01VGXotSHoy3
        H7b/gJRlKUEZAOPMsPWsdHEhffrHgbzNpw==
X-Google-Smtp-Source: AGRyM1vcA8Q+/miHX094uFepaPtcpybFdzJfquKs/2rHWZhRbdjjCz5GD26oLsZvp67ZetH5E/v8MA==
X-Received: by 2002:a05:6000:1f8d:b0:21e:e714:3c87 with SMTP id bw13-20020a0560001f8d00b0021ee7143c87mr4074042wrb.166.1659026823343;
        Thu, 28 Jul 2022 09:47:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d6043000000b0021efc75914esm1495403wrt.79.2022.07.28.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:47:00 -0700 (PDT)
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
Subject: [PATCH v6 7/9] docs: move pack format docs to man section 5
Date:   Thu, 28 Jul 2022 18:46:46 +0200
Message-Id: <patch-v6-7.9-92be18b95d9-20220728T164243Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com> <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the move of existing Documentation/technical/* protocol and
file-format documentation into our main documentation space by moving
the various documentation pertaining to the *.pack format and related
files, and updating things that refer to it to link to the new
location.

By moving these we can properly link from the newly created
gitformat-commit-graph do to a gitformat-chunk-format manpage we build
by default.

Creating a "gitformat-pack-bitmap" from
"Documentation/technical/bitmap-format" might logically be part of
this change, but it's left out for now due to a conflict with the
in-flight ac/bitmap-lookup-table series.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  9 ++---
 Documentation/config/pack.txt                 |  2 +-
 Documentation/git-bundle.txt                  |  3 +-
 Documentation/git-multi-pack-index.txt        |  4 +--
 .../chunk-format.txt => gitformat-chunk.txt}  | 25 +++++++++++---
 Documentation/gitformat-commit-graph.txt      |  2 +-
 .../index-format.txt => gitformat-index.txt}  | 22 ++++++++++--
 ...uft-packs.txt => gitformat-pack-cruft.txt} | 22 ++++++++++--
 .../pack-format.txt => gitformat-pack.txt}    | 34 +++++++++++++++++--
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++++++--
 Documentation/gitprotocol-pack.txt            |  2 +-
 .../howto/recover-corrupted-object-harder.txt |  2 +-
 .../technical/hash-function-transition.txt    |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 cache.h                                       |  3 +-
 command-list.txt                              |  5 +++
 pack-revindex.h                               |  2 +-
 17 files changed, 131 insertions(+), 31 deletions(-)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (91%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/cruft-packs.txt => gitformat-pack-cruft.txt} (96%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (95%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b53f3c12843..cd09ccd8c13 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -25,7 +25,12 @@ MAN1_TXT += gitweb.txt
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += gitformat-bundle.txt
+MAN5_TXT += gitformat-chunk.txt
 MAN5_TXT += gitformat-commit-graph.txt
+MAN5_TXT += gitformat-index.txt
+MAN5_TXT += gitformat-pack-cruft.txt
+MAN5_TXT += gitformat-pack.txt
+MAN5_TXT += gitformat-signature.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
@@ -101,13 +106,10 @@ TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
-TECH_DOCS += technical/cruft-packs
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
-TECH_DOCS += technical/index-format
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
-TECH_DOCS += technical/pack-format
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
@@ -115,7 +117,6 @@ TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
-TECH_DOCS += technical/signature-format
 TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index ad7f73a1ead..3e581eab84a 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -166,7 +166,7 @@ permuted into their appropriate location when writing a new bitmap.
 
 pack.writeReverseIndex::
 	When true, git will write a corresponding .rev file (see:
-	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
+	linkgit:gitformat-pack[5])
 	for each new packfile that it writes in all places except for
 	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
 	Defaults to false.
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index f0b1282b918..6da61722431 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -57,8 +57,7 @@ size. That they're "thin" under the hood is merely noted here as a
 curiosity, and as a reference to other documentation.
 
 See linkgit:gitformat-bundle[5] for more details and the discussion of
-"thin pack" in link:technical/pack-format.html[the pack format
-documentation] for further details.
+"thin pack" in linkgit:gitformat-pack[5] for further details.
 
 OPTIONS
 -------
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index c588fb91af1..a48c3d5ea63 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -128,8 +128,8 @@ $ git multi-pack-index verify
 SEE ALSO
 --------
 See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
-Document] and link:technical/pack-format.html[The Multi-Pack-Index
-Format] for more information on the multi-pack-index feature.
+Document] and linkgit:gitformat-pack[5] for more information on the
+multi-pack-index feature and its file format.
 
 
 GIT
diff --git a/Documentation/technical/chunk-format.txt b/Documentation/gitformat-chunk.txt
similarity index 91%
rename from Documentation/technical/chunk-format.txt
rename to Documentation/gitformat-chunk.txt
index f36ce42f37c..57202ede273 100644
--- a/Documentation/technical/chunk-format.txt
+++ b/Documentation/gitformat-chunk.txt
@@ -1,11 +1,24 @@
-Chunk-based file formats
-========================
+gitformat-chunk(5)
+==================
+
+NAME
+----
+gitformat-chunk - Chunk-based file formats
+
+SYNOPSIS
+--------
+
+Used by linkgit:gitformat-commit-graph[5] and the "MIDX" format (see
+the pack format documentation in linkgit:gitformat-pack[5]).
+
+DESCRIPTION
+-----------
 
 Some file formats in Git use a common concept of "chunks" to describe
 sections of the file. This allows structured access to a large file by
 scanning a small "table of contents" for the remaining data. This common
 format is used by the `commit-graph` and `multi-pack-index` files. See
-link:technical/pack-format.html[the `multi-pack-index` format] and
+the `multi-pack-index` format in linkgit:gitformat-pack[5] and
 the `commit-graph` format in linkgit:gitformat-commit-graph[5] for
 how they use the chunks to describe structured data.
 
@@ -113,4 +126,8 @@ for future formats:
 * *multi-pack-index:* see `write_midx_internal()` and `load_multi_pack_index()`
   in `midx.c` for how the chunk-format API is used to write and
   parse the multi-pack-index file format documented in
-  link:technical/pack-format.html[the multi-pack-index file format].
+  the multi-pack-index file format section of linkgit:gitformat-pack[5].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 108dc2295c0..7324665716d 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -75,7 +75,7 @@ All multi-byte numbers are in network byte order.
       ID appears at most once.
 
   The CHUNK LOOKUP matches the table of contents from
-  link:technical/chunk-format.html[the chunk-based file format].
+  the chunk-based file format, see linkgit:gitformat-chunk[5]
 
   The remaining data in the body is described one chunk at a time, and
   these chunks may be given in any order. Chunks are required unless
diff --git a/Documentation/technical/index-format.txt b/Documentation/gitformat-index.txt
similarity index 98%
rename from Documentation/technical/index-format.txt
rename to Documentation/gitformat-index.txt
index f691c20ab0a..015cb21bdc0 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/gitformat-index.txt
@@ -1,5 +1,19 @@
+gitformat-index(5)
+==================
+
+NAME
+----
+gitformat-index - Git index format
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/index
+
+DESCRIPTION
+-----------
+
 Git index format
-================
 
 == The Git index file has the following format
 
@@ -125,7 +139,7 @@ Git index format
     entry is encoded as if the path name for the previous entry is an
     empty string).  At the beginning of an entry, an integer N in the
     variable width encoding (the same encoding as the offset is encoded
-    for OFS_DELTA pack entries; see pack-format.txt) is stored, followed
+    for OFS_DELTA pack entries; see linkgit:gitformat-pack[5]) is stored, followed
     by a NUL-terminated string S.  Removing N bytes from the end of the
     path name for the previous entry, and replacing it with the string S
     yields the path name for this entry.
@@ -402,3 +416,7 @@ The remaining data of each directory block is grouped by type:
   with signature { 's', 'd', 'i', 'r' }. Like the split-index extension,
   tools should avoid interacting with a sparse index unless they understand
   this extension.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/cruft-packs.txt b/Documentation/gitformat-pack-cruft.txt
similarity index 96%
rename from Documentation/technical/cruft-packs.txt
rename to Documentation/gitformat-pack-cruft.txt
index d81f3a8982f..908f752bd84 100644
--- a/Documentation/technical/cruft-packs.txt
+++ b/Documentation/gitformat-pack-cruft.txt
@@ -1,4 +1,17 @@
-= Cruft packs
+gitformat-pack-cruft(5)
+=======================
+
+NAME
+----
+gitformat-pack-cruft - The cruft pack file format
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/objects/pack/pack-*.mtimes
+
+DESCRIPTION
+-----------
 
 The cruft packs feature offer an alternative to Git's traditional mechanism of
 removing unreachable objects. This document provides an overview of Git's
@@ -10,10 +23,11 @@ same.
 To remove unreachable objects from your repository, Git offers `git repack -Ad`
 (see linkgit:git-repack[1]). Quoting from the documentation:
 
-[quote]
+----
 [...] unreachable objects in a previous pack become loose, unpacked objects,
 instead of being left in the old pack. [...] loose unreachable objects will be
 pruned according to normal expiry rules with the next 'git gc' invocation.
+----
 
 Unreachable objects aren't removed immediately, since doing so could race with
 an incoming push which may reference an object which is about to be deleted.
@@ -121,3 +135,7 @@ which aren't already stored in an earlier cruft pack) is significantly more
 complicated to construct, and so aren't pursued here. The obvious drawback to
 the current implementation is that the entire cruft pack must be re-written from
 scratch.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/pack-format.txt b/Documentation/gitformat-pack.txt
similarity index 95%
rename from Documentation/technical/pack-format.txt
rename to Documentation/gitformat-pack.txt
index b520aa9c45b..546c99f8871 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/gitformat-pack.txt
@@ -1,5 +1,29 @@
-Git pack format
-===============
+gitformat-pack(5)
+=================
+
+NAME
+----
+gitformat-pack - Git pack format
+
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/objects/pack/pack-*.{pack,idx}
+$GIT_DIR/objects/pack/pack-*.rev
+$GIT_DIR/objects/pack/multi-pack-index
+
+DESCRIPTION
+-----------
+
+The Git pack format is now Git stores most of its primary repository
+data. Over the lietime af a repository loose objects (if any) and
+smaller packs are consolidated into larger pack(s). See
+linkgit:git-gc[1] and linkgit:git-pack-objects[1].
+
+The pack format is also used over-the-wire, see
+e.g. linkgit:gitprotocol-v2[5], as well as being a part of
+other container formats in the case of linkgit:gitformat-bundle[5].
 
 == Checksums and object IDs
 
@@ -356,7 +380,7 @@ CHUNK LOOKUP:
 	    using the next chunk position if necessary.)
 
 	The CHUNK LOOKUP matches the table of contents from
-	link:technical/chunk-format.html[the chunk-based file format].
+	the chunk-based file format, see linkgit:gitformat-chunk[5].
 
 	The remaining data in the body is described one chunk at a time, and
 	these chunks may be given in any order. Chunks are required unless
@@ -482,3 +506,7 @@ packs arranged in MIDX order (with the preferred pack coming first).
 
 The MIDX's reverse index is stored in the optional 'RIDX' chunk within
 the MIDX itself.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/signature-format.txt b/Documentation/gitformat-signature.txt
similarity index 96%
rename from Documentation/technical/signature-format.txt
rename to Documentation/gitformat-signature.txt
index 166721be6f6..a249869fafa 100644
--- a/Documentation/technical/signature-format.txt
+++ b/Documentation/gitformat-signature.txt
@@ -1,7 +1,18 @@
-Git signature format
-====================
+gitformat-signature(5)
+======================
 
-== Overview
+NAME
+----
+gitformat-signature - Git cryptographic signature formats
+
+SYNOPSIS
+--------
+[verse]
+<[tag|commit] object header(s)>
+<over-the-wire protocol>
+
+DESCRIPTION
+-----------
 
 Git uses cryptographic signatures in various places, currently objects (tags,
 commits, mergetags) and transactions (pushes). In every case, the command which
@@ -200,3 +211,7 @@ Date:   Wed Jun 15 09:13:29 2016 +0000
     # gpg:          There is no indication that the signature belongs to the owner.
     # Primary key fingerprint: D4BE 2231 1AD3 131E 5EDA  29A4 6109 2E85 B722 7189
 ----
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitprotocol-pack.txt b/Documentation/gitprotocol-pack.txt
index 8a4de6decd0..93b30b88450 100644
--- a/Documentation/gitprotocol-pack.txt
+++ b/Documentation/gitprotocol-pack.txt
@@ -467,7 +467,7 @@ Now that the client and server have finished negotiation about what
 the minimal amount of data that needs to be sent to the client is, the server
 will construct and send the required data in packfile format.
 
-See pack-format.txt for what the packfile itself actually looks like.
+See linkgit:gitformat-pack[5] for what the packfile itself actually looks like.
 
 If 'side-band' or 'side-band-64k' capabilities have been specified by
 the client, the server will send the packfile data multiplexed.
diff --git a/Documentation/howto/recover-corrupted-object-harder.txt b/Documentation/howto/recover-corrupted-object-harder.txt
index 8994e2559ea..5efb4fe81ff 100644
--- a/Documentation/howto/recover-corrupted-object-harder.txt
+++ b/Documentation/howto/recover-corrupted-object-harder.txt
@@ -68,7 +68,7 @@ Note that the "object" file isn't fit for feeding straight to zlib; it
 has the git packed object header, which is variable-length. We want to
 strip that off so we can start playing with the zlib data directly. You
 can either work your way through it manually (the format is described in
-link:../technical/pack-format.html[Documentation/technical/pack-format.txt]),
+linkgit:gitformat-pack[5]),
 or you can walk through it in a debugger. I did the latter, creating a
 valid pack like:
 
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 260224b0331..e2ac36dd210 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -205,7 +205,7 @@ SHA-1 content.
 Object storage
 ~~~~~~~~~~~~~~
 Loose objects use zlib compression and packed objects use the packed
-format described in Documentation/technical/pack-format.txt, just like
+format described in linkgit:gitformat-pack[5], just like
 today. The content that is compressed and stored uses SHA-256 content
 instead of SHA-1 content.
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 865074bed4e..ca9decdd952 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3133,7 +3133,7 @@ those "loose" objects.
 You can save space and make Git faster by moving these loose objects in
 to a "pack file", which stores a group of objects in an efficient
 compressed format; the details of how pack files are formatted can be
-found in link:technical/pack-format.html[pack format].
+found in link:gitformat-pack[5].
 
 To put the loose objects into a pack, just run git repack:
 
diff --git a/cache.h b/cache.h
index ac5ab4ef9d3..82755c7c0aa 100644
--- a/cache.h
+++ b/cache.h
@@ -475,8 +475,7 @@ extern struct index_state the_index;
 
 /*
  * Values in this enum (except those outside the 3 bit range) are part
- * of pack file format. See Documentation/technical/pack-format.txt
- * for more information.
+ * of pack file format. See gitformat-pack(5) for more information.
  */
 enum object_type {
 	OBJ_BAD = -1,
diff --git a/command-list.txt b/command-list.txt
index ed859fdd798..4f30a6c30c8 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -210,7 +210,12 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        developerinterfaces
+gitformat-chunk                         developerinterfaces
 gitformat-commit-graph                  developerinterfaces
+gitformat-index                         developerinterfaces
+gitformat-pack                          developerinterfaces
+gitformat-pack-cruft                    developerinterfaces
+gitformat-signature                     developerinterfaces
 gitglossary                             guide
 githooks                                userinterfaces
 gitignore                               userinterfaces
diff --git a/pack-revindex.h b/pack-revindex.h
index 74f4eae668d..4974e75eb4d 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -22,7 +22,7 @@
  *
  *   - pack position refers to an object's position within a non-existent pack
  *     described by the MIDX. The pack structure is described in
- *     Documentation/technical/pack-format.txt.
+ *     gitformat-pack(5).
  *
  *     It is effectively a concatanation of all packs in the MIDX (ordered by
  *     their numeric ID within the MIDX) in their original order within each
-- 
2.37.1.1197.g7ed548b7807

