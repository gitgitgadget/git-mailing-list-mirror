Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82700C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiGRNaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiGRN3y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:29:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453AB11164
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h127-20020a1c2185000000b003a2fa488efdso8669wmh.4
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNSex2qLcisqUD2iVmyRTAMbAgkkdlD0RQNjyhftM6w=;
        b=kFYrTnzswhn8bWrlVhia11iMsnMvcuVZ5jC2SqfOgG4jCQpM1ynTf2EWBj0+rZNOn6
         XOxiBR/ohu2oXcdaAJoU+UwKlBXZwLUhmLhbcS83BnWaC08k9iTAfGG3T9EEF5ABU4gQ
         2k3ygCVMruaVAvnQ6JLtcgTh4EybNETj/0LR0Hf9V+omTEYSGya9ZOzyTlfEUz5h1vQ+
         NuM+bz2mfbslG3mvFtMiPvX8A3sJRWItgWYYYC6SEUirxcRGnS2twl4TbU8J/EyId7xw
         i6+xgQu+n7pGrVeEZbeql3rtuuTaU+3BipQnk1CtjrErqSSxC8g5NCbE1pNuHiz4XKnK
         4ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNSex2qLcisqUD2iVmyRTAMbAgkkdlD0RQNjyhftM6w=;
        b=3gZCGMg4pvcikl4IV/+75OOpDvbIYNYMO6tPZq0csc570xSZHlAeNYIz5A7KZmoVbv
         1s+s0NCgx0Rgqoh8Fe1ZSR9HzjkSm5wIIJjXHakJm5ll+kFEZQyLWOimrer/TukOw40I
         paet4KryTUv341tRuOrJACAzItc5kTL++vrPoG2QuYOsKLhzgD6p7pRlIxWWsK1YwAPT
         +fVVJPEhi//JrRiYfCz4iFP6twRjnOmkrAxivP0e9Vs4WbpaIFLbqnMFElMaRPvXr5ZE
         dW+FgetN8ZCt+2Rzyf7SYX3b9QTZzno/+K9W4zrLEMCfEak5h2JpOVRXF4Nrhbm7HEg0
         T8Cg==
X-Gm-Message-State: AJIora8IjnPLH60xpuadG5nu/THcz4BA6HBbFPzPpwV8LRHmWseeKpbE
        KF3+ERmPqUAwKVe1YivLv5VggXLQJJj1gg==
X-Google-Smtp-Source: AGRyM1sDZzPFjWWCo6g0LjmEGFe64Yw92N6NtUCWJBImkB8Up2WDEkr+uEjsYD5fhmeaWR4ao8o3Vw==
X-Received: by 2002:a05:600c:3845:b0:3a3:19e8:829e with SMTP id s5-20020a05600c384500b003a319e8829emr5397183wmr.11.1658150987110;
        Mon, 18 Jul 2022 06:29:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a30572072esm14277296wmi.6.2022.07.18.06.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:29:46 -0700 (PDT)
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
Subject: [PATCH v4 6/8] docs: move pack format docs to man section 5
Date:   Mon, 18 Jul 2022 15:29:32 +0200
Message-Id: <patch-v4-6.8-858ce9c6999-20220718T132911Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
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
 .../chunk-format.txt => gitformat-chunk.txt}  | 27 ++++++++++++---
 Documentation/gitformat-commit-graph.txt      |  2 +-
 .../index-format.txt => gitformat-index.txt}  | 22 ++++++++++--
 ...uft-packs.txt => gitformat-pack-cruft.txt} | 22 ++++++++++--
 Documentation/gitformat-pack-protocol.txt     |  2 +-
 .../pack-format.txt => gitformat-pack.txt}    | 34 +++++++++++++++++--
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++++++--
 .../howto/recover-corrupted-object-harder.txt |  2 +-
 .../technical/hash-function-transition.txt    |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 cache.h                                       |  3 +-
 command-list.txt                              |  5 +++
 pack-revindex.h                               |  2 +-
 17 files changed, 132 insertions(+), 32 deletions(-)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (90%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/cruft-packs.txt => gitformat-pack-cruft.txt} (96%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (95%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index adc1404d380..b4d2361dfc7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -25,11 +25,16 @@ MAN1_TXT += gitweb.txt
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += gitformat-bundle.txt
+MAN5_TXT += gitformat-chunk.txt
 MAN5_TXT += gitformat-commit-graph.txt
+MAN5_TXT += gitformat-index.txt
+MAN5_TXT += gitformat-pack-cruft.txt
 MAN5_TXT += gitformat-pack-protocol.txt
+MAN5_TXT += gitformat-pack.txt
 MAN5_TXT += gitformat-protocol-capabilities.txt
 MAN5_TXT += gitformat-protocol-common.txt
 MAN5_TXT += gitformat-protocol-v2.txt
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
index 1aeae09f082..4c6c41e1a09 100644
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
similarity index 90%
rename from Documentation/technical/chunk-format.txt
rename to Documentation/gitformat-chunk.txt
index f36ce42f37c..784c5d987de 100644
--- a/Documentation/technical/chunk-format.txt
+++ b/Documentation/gitformat-chunk.txt
@@ -1,12 +1,25 @@
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
-the `commit-graph` format in linkgit:gitformat-commit-graph[5] for
+the `multi-pack-index` format in linkgit:gitformat-pack[5] and
+link:technical/commit-graph-format.html[the `commit-graph` format] for
 how they use the chunks to describe structured data.
 
 A chunk-based file format begins with some header information custom to
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
index 65da0daaa56..5f3ed10d2db 100644
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
 
@@ -127,7 +141,7 @@ Git index format
     entry is encoded as if the path name for the previous entry is an
     empty string).  At the beginning of an entry, an integer N in the
     variable width encoding (the same encoding as the offset is encoded
-    for OFS_DELTA pack entries; see pack-format.txt) is stored, followed
+    for OFS_DELTA pack entries; see linkgit:gitformat-pack[5]) is stored, followed
     by a NUL-terminated string S.  Removing N bytes from the end of the
     path name for the previous entry, and replacing it with the string S
     yields the path name for this entry.
@@ -404,3 +418,7 @@ The remaining data of each directory block is grouped by type:
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
diff --git a/Documentation/gitformat-pack-protocol.txt b/Documentation/gitformat-pack-protocol.txt
index b665af5b690..f1bfd6705d9 100644
--- a/Documentation/gitformat-pack-protocol.txt
+++ b/Documentation/gitformat-pack-protocol.txt
@@ -467,7 +467,7 @@ Now that the client and server have finished negotiation about what
 the minimal amount of data that needs to be sent to the client is, the server
 will construct and send the required data in packfile format.
 
-See pack-format.txt for what the packfile itself actually looks like.
+See linkgit:gitformat-pack[5] for what the packfile itself actually looks like.
 
 If 'side-band' or 'side-band-64k' capabilities have been specified by
 the client, the server will send the packfile data multiplexed.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/gitformat-pack.txt
similarity index 95%
rename from Documentation/technical/pack-format.txt
rename to Documentation/gitformat-pack.txt
index b520aa9c45b..5b21d0f2521 100644
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
+e.g. linkgit:gitformat-protocol-v2[5], as well as being a part of
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
index bec0fa690aa..c364557fe09 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -209,11 +209,16 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        gitformats
+gitformat-chunk                         gitformats
 gitformat-commit-graph                  gitformats
+gitformat-index                         gitformats
+gitformat-pack                          gitformats
+gitformat-pack-cruft                    gitformats
 gitformat-pack-protocol                 gitformats
 gitformat-protocol-capabilities         gitformats
 gitformat-protocol-common               gitformats
 gitformat-protocol-v2                   gitformats
+gitformat-signature                     gitformats
 gitglossary                             guide
 githooks                                userformats
 gitignore                               userformats
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
2.37.1.1032.gb00b5447790

