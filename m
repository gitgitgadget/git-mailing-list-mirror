Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD11C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhLLTvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:51:03 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:46626 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhLLTuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 14:50:51 -0500
Received: by mail-wm1-f44.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso10323624wmr.5
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnikHMgbC622Jp7DdsRo/68x5JfU9/xYCKKO4RO/ip4=;
        b=GyJVqy+K+eZIcKUdgJcpgVaPz5fYc0mX5dmqQE3+LSpuYaoCfoXRCbywiiKyP8/5Lu
         7WLNqNXu5hfYjSXK5RaVzzHAuYkRl/7RCCuTjvzHq7Jj8kHkgDStLVJPujeBOZ/Merpc
         LjmqK6QMeKgGoDpdPCIr43EmoLtkjf0k85RCl9gre19n0U3i+8grUgkcig6UzBoTvkjF
         uG0PHMX3Lwl9ap7+/YfHACiU+AcIVanohThiX+9kiI1dorhp9N5BQvIax76xRAIsIles
         2aQBWPxL3gLPpVAZuIaY/jHYrDM9w8NZzwGBbk70kiKbMJ7LGxIrmg0J5oNrPm0QpzAA
         xR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnikHMgbC622Jp7DdsRo/68x5JfU9/xYCKKO4RO/ip4=;
        b=keJZw9VLbpwYXytBpeRXIV/X0ywcuTC6YOA2ceMpMmwbqzQ3lLnAUCAJcN7bkE0LIF
         celTazL1Me5bDzXNVOU7fJ3j3WdujG389vw0lBASF53/VGBkcXpIqVTpyVm0YhIjA1XP
         sUVfbbKznbZORE7MR/IsDizn88IuS61kpftmN+HyDyI0SyfbSB0c7mChYSKkX8F+d85K
         3itTTGla608xL6cR1T3ub2F1pZ2UbitEA9+xuShUJflxx3LC7BTUIbTv7I7zl4nLcqis
         UuUkZ30Ej1DWA1OFqmGk6mxyYWgO/c97j1wIYRRbisTZ9H03ZDF30Yz8XGF1PZyzMGi9
         7qcA==
X-Gm-Message-State: AOAM531rbpTdadwMwT7Hzyan1UVugvmn0Yeba+y4pc58/2ueitX+8+22
        RvFO2bz5DvQyikwXCcs7RonlweZWWz7fSA==
X-Google-Smtp-Source: ABdhPJy7ctQJ0EoHL+PWjUmTHoHVs/Cu79UJ87GLmjvVwRMkLj66m7+hYBLtqNAHn7G7pc3zWfDwIw==
X-Received: by 2002:a7b:cb55:: with SMTP id v21mr10184390wmj.45.1639338588959;
        Sun, 12 Dec 2021 11:49:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g4sm8293822wro.12.2021.12.12.11.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:49:48 -0800 (PST)
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
Subject: [PATCH v2 5/5] docs: move {index,signature,bitmap,chunk}-format docs to man section 5
Date:   Sun, 12 Dec 2021 20:49:40 +0100
Message-Id: <patch-v2-5.5-5cb41bb0dcb-20211212T194047Z-avarab@gmail.com>
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

By moving these we can properly link from the newly created
gitformat-commit-graph do to a gitformat-chunk-format manpage we build
by default. Let's also move the rest over for consistency.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  6 ++-
 ...bitmap-format.txt => gitformat-bitmap.txt} | 38 +++++++++++++++----
 .../chunk-format.txt => gitformat-chunk.txt}  | 21 +++++++++-
 Documentation/gitformat-commit-graph.txt      |  2 +-
 .../index-format.txt => gitformat-index.txt}  | 20 +++++++++-
 ...ure-format.txt => gitformat-signature.txt} | 21 ++++++++--
 Documentation/technical/pack-format.txt       |  2 +-
 command-list.txt                              |  4 ++
 8 files changed, 97 insertions(+), 17 deletions(-)
 rename Documentation/{technical/bitmap-format.txt => gitformat-bitmap.txt} (91%)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (94%)
 rename Documentation/{technical/index-format.txt => gitformat-index.txt} (98%)
 rename Documentation/{technical/signature-format.txt => gitformat-signature.txt} (96%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index ba587b75a51..f8a84173667 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -21,12 +21,16 @@ MAN1_TXT += gitweb.txt
 
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
+MAN5_TXT += gitformat-bitmap.txt
 MAN5_TXT += gitformat-bundle.txt
+MAN5_TXT += gitformat-chunk.txt
 MAN5_TXT += gitformat-commit-graph.txt
+MAN5_TXT += gitformat-index.txt
 MAN5_TXT += gitformat-pack-protocol.txt
 MAN5_TXT += gitformat-protocol-capabilities.txt
 MAN5_TXT += gitformat-protocol-common.txt
 MAN5_TXT += gitformat-protocol-v2.txt
+MAN5_TXT += gitformat-signature.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
@@ -98,7 +102,6 @@ TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
-TECH_DOCS += technical/index-format
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
 TECH_DOCS += technical/pack-format
@@ -109,7 +112,6 @@ TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/reftable
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
-TECH_DOCS += technical/signature-format
 TECH_DOCS += technical/trivial-merge
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/gitformat-bitmap.txt
similarity index 91%
rename from Documentation/technical/bitmap-format.txt
rename to Documentation/gitformat-bitmap.txt
index 04b3ec21785..b239dc5cbe1 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/gitformat-bitmap.txt
@@ -1,7 +1,25 @@
-GIT bitmap v1 format
-====================
+gitformat-bitmap(5)
+===================
 
-== Pack and multi-pack bitmaps
+NAME
+----
+gitformat-bitmap - The bitmap file format
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/objects/pack/*.bitmap
+
+DESCRIPTION
+-----------
+
+Bitmaps are a file format associated with .pack files. See
+link:technical/pack-format.html[the pack format documentation] and
+linkgit:git-pack-objects[1].
+
+== GIT bitmap v1 format
+
+=== Pack and multi-pack bitmaps
 
 Bitmaps store reachability information about the set of objects in a packfile,
 or a multi-pack index (MIDX). The former is defined obviously, and the latter is
@@ -37,7 +55,7 @@ Certain bitmap extensions are supported (see: Appendix B). No extensions are
 required for bitmaps corresponding to packfiles. For bitmaps that correspond to
 MIDXs, both the bit-cache and rev-cache extensions are required.
 
-== On-disk format
+=== On-disk format
 
 	- A header appears at the beginning:
 
@@ -131,7 +149,8 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 		- The compressed bitmap itself, see Appendix A.
 
-== Appendix A: Serialization format for an EWAH bitmap
+Appendix A - Serialization format for an EWAH bitmap
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Ewah bitmaps are serialized in the same protocol as the JAVAEWAH
 library, making them backwards compatible with the JGit
@@ -179,13 +198,14 @@ chunk.  For efficient appending to the bitstream, the EWAH stores a
 pointer to the last RLW in the stream.
 
 
-== Appendix B: Optional Bitmap Sections
+Appendix B - Optional Bitmap Sections
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 These sections may or may not be present in the `.bitmap` file; their
 presence is indicated by the header flags section described above.
 
 Name-hash cache
----------------
+~~~~~~~~~~~~~~~
 
 If the BITMAP_OPT_HASH_CACHE flag is set, the end of the bitmap contains
 a cache of 32-bit values, one per object in the pack/MIDX. The value at
@@ -205,3 +225,7 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
 If implementations want to choose a different hashing scheme, they are
 free to do so, but MUST allocate a new header flag (because comparing
 hashes made under two different schemes would be pointless).
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/chunk-format.txt b/Documentation/gitformat-chunk.txt
similarity index 94%
rename from Documentation/technical/chunk-format.txt
rename to Documentation/gitformat-chunk.txt
index f36ce42f37c..8ddf21e3277 100644
--- a/Documentation/technical/chunk-format.txt
+++ b/Documentation/gitformat-chunk.txt
@@ -1,5 +1,18 @@
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
+link:technical/pack-format.html[the pack format documentation]).
+
+DESCRIPTION
+-----------
 
 Some file formats in Git use a common concept of "chunks" to describe
 sections of the file. This allows structured access to a large file by
@@ -114,3 +127,7 @@ for future formats:
   in `midx.c` for how the chunk-format API is used to write and
   parse the multi-pack-index file format documented in
   link:technical/pack-format.html[the multi-pack-index file format].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 25eb131dcd2..5f839eda058 100644
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
index 65da0daaa56..41491d2a075 100644
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
 
@@ -404,3 +418,7 @@ The remaining data of each directory block is grouped by type:
   with signature { 's', 'd', 'i', 'r' }. Like the split-index extension,
   tools should avoid interacting with a sparse index unless they understand
   this extension.
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
diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 8d2f42f29e5..79cc83aead0 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -337,7 +337,7 @@ CHUNK LOOKUP:
 	    using the next chunk position if necessary.)
 
 	The CHUNK LOOKUP matches the table of contents from
-	link:technical/chunk-format.html[the chunk-based file format].
+	the chunk-based file format, see linkgit:gitformat-chunk[5].
 
 	The remaining data in the body is described one chunk at a time, and
 	these chunks may be given in any order. Chunks are required unless
diff --git a/command-list.txt b/command-list.txt
index f4d1f9c31b1..42093fd5a07 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -207,12 +207,16 @@ gitcvs-migration                        guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
+gitformat-bitmap                        gitformats
 gitformat-bundle                        gitformats
+gitformat-chunk                         gitformats
 gitformat-commit-graph                  gitformats
+gitformat-index                         gitformats
 gitformat-pack-protocol                 gitformats
 gitformat-protocol-capabilities         gitformats
 gitformat-protocol-common               gitformats
 gitformat-protocol-v2                   gitformats
+gitformat-signature                     gitformats
 gitglossary                             guide
 githooks                                userformats
 gitignore                               userformats
-- 
2.34.1.929.ge922d848c7a

