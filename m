Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D880DC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 14:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKUOQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 09:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiKUOP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 09:15:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C6633C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:15:55 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x102so16495744ede.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9V1oXG29SbAP1ZDuLLwZWgkJpf3jDua4+4DeWKSVE4=;
        b=p9D1fpj6Yj53ZxkvaBJydO5XVP+0a7HU9Ph7ef49n5EB9E/k/+RQIYaKhZryFwsagF
         Jb/8EiVYn04IOy/fFdB0M2U5qG199aA9M6bOdfZKHIpCG8osU8RHmOmbazJOvL1s9tSb
         0KT5+MBXqxvod/PbuugIduKKlO+zsZavUH3JvyAaxFqmzfNhv7PRdeAlTZL7wNmGXHtD
         Yeo8wVpKkMneYdT4zDJIkbogNNeK1bBe3w4MYPwY13U8HTb4bSOvEXKFW6mmVh22BPzo
         IAL6TK1qPmt9QfDvCGsTn6CgnnFGQGuPWd7M27PJynVtG+cj40SjkS4zaFUh2rtP64XD
         5MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9V1oXG29SbAP1ZDuLLwZWgkJpf3jDua4+4DeWKSVE4=;
        b=OXqTE35R96Dso+4ChLtGn9VFg9rtnp1tPAWMOY2f5u+G+JG6Pd9xHgDWoprxpjxWp/
         JIoVnvlR3ad4BKpRpcdOL0Plx/w/93JQTwFHUVb63NpeGtXR13+vs1ZQAiGMYmBobmL9
         d6b6SCLLCt04jU0NKCg8MmSHl5n7zivwk+5PqYrMt0FlnlvJ0HtgoRjinr6SW1W2eBkP
         ZbvMRw93SZ9WmlMsh1mjdHO+PpdX62d8ErYmSguwI2mij43WsO90Q81vEKG216M7ODv8
         qzlBpBnzWG6qijzhppo08z1lPy/iqQr0bmQew51DwiRa5UhMHPB1YxyNGj2dTJ45afAU
         2nCQ==
X-Gm-Message-State: ANoB5plspxPhpDSHKF3i8tT9lb21Urn82vRWeO/91NzVsuMSQVGApdQR
        C/xXI46ayfFwDuE/LOZKSh1qc68Z8EU=
X-Google-Smtp-Source: AA0mqf6lrjsFwLAJJdNMnsxzfmiDLCcu4p4yzoNPdCJcPp4nbfQwlW3b/Evz5OFinh+DFbDampMN/Q==
X-Received: by 2002:a50:f602:0:b0:469:4e4f:4827 with SMTP id c2-20020a50f602000000b004694e4f4827mr8448544edn.214.1669040153291;
        Mon, 21 Nov 2022 06:15:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906314b00b0078b83968ad4sm5014920eje.24.2022.11.21.06.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:15:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] docs: de-indent first paragraph of gitformat-* to flow the text
Date:   Mon, 21 Nov 2022 15:15:50 +0100
Message-Id: <patch-1.1-1c1434bba31-20221121T141411Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1524.gdb7bac9ecc9
In-Reply-To: <221109.86bkpgriso.gmgdl@evledraar.gmail.com>
References: <221109.86bkpgriso.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix formatting issues with the documentation added to the new
gitformat-* namespace in c0f6dd49f19 (Merge branch
'ab/tech-docs-to-help', 2022-08-14).

As this documentation didn't have a wide audience before that, some of
these formatting issues pre-dated that change. See [1] for details.

But the end result of having some paragraphs use "<p>" in the HTML
output, and to have others wrapped in "<pre><code>" doesn't look
nice. The most minimal way to fix this is to de-indent the opening
line of paragraphs that don't start with another formatting
element (e.g. "*" or "-" would already format them as text). Let's do
that.

1. https://lore.kernel.org/git/221109.86bkpgriso.gmgdl@evledraar.gmail.com/

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

There's a lot more to fix in these gitformat-* docs (as their
formatting was funny before), but this is a minimal change to fix the
most major issues.

 Documentation/gitformat-commit-graph.txt | 10 ++--
 Documentation/gitformat-index.txt        | 74 ++++++++++++------------
 Documentation/gitformat-pack.txt         |  4 +-
 3 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 31cad585e23..219265a0c7a 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -67,17 +67,17 @@ All multi-byte numbers are in network byte order.
 
 === CHUNK LOOKUP:
 
-  (C + 1) * 12 bytes listing the table of contents for the chunks:
+(C + 1) * 12 bytes listing the table of contents for the chunks:
       First 4 bytes describe the chunk id. Value 0 is a terminating label.
       Other 8 bytes provide the byte-offset in current file for chunk to
       start. (Chunks are ordered contiguously in the file, so you can infer
       the length using the next chunk position if necessary.) Each chunk
       ID appears at most once.
 
-  The CHUNK LOOKUP matches the table of contents from
+The CHUNK LOOKUP matches the table of contents from
   the chunk-based file format, see linkgit:gitformat-chunk[5]
 
-  The remaining data in the body is described one chunk at a time, and
+The remaining data in the body is described one chunk at a time, and
   these chunks may be given in any order. Chunks are required unless
   otherwise specified.
 
@@ -126,7 +126,7 @@ All multi-byte numbers are in network byte order.
       be stored within 31 bits.
 
 ==== Extra Edge List (ID: {'E', 'D', 'G', 'E'}) [Optional]
-      This list of 4-byte values store the second through nth parents for
+This list of 4-byte values store the second through nth parents for
       all octopus merges. The second parent value in the commit data stores
       an array position within this list along with the most-significant bit
       on. Starting at that array position, iterate through this list of commit
@@ -161,7 +161,7 @@ All multi-byte numbers are in network byte order.
     * The BDAT chunk is present if and only if BIDX is present.
 
 ==== Base Graphs List (ID: {'B', 'A', 'S', 'E'}) [Optional]
-      This list of H-byte hashes describe a set of B commit-graph files that
+This list of H-byte hashes describe a set of B commit-graph files that
       form a commit-graph chain. The graph position for the ith commit in this
       file's OID Lookup chunk is equal to i plus the number of commits in all
       base graphs.  If B is non-zero, this chunk must exist.
diff --git a/Documentation/gitformat-index.txt b/Documentation/gitformat-index.txt
index 015cb21bdc0..bbc188b9e65 100644
--- a/Documentation/gitformat-index.txt
+++ b/Documentation/gitformat-index.txt
@@ -17,7 +17,7 @@ Git index format
 
 == The Git index file has the following format
 
-  All binary numbers are in network byte order.
+All binary numbers are in network byte order.
   In a repository using the traditional SHA-1, checksums and object IDs
   (object names) mentioned below are all computed using SHA-1.  Similarly,
   in SHA-256 repositories, these values are computed using SHA-256.
@@ -51,12 +51,12 @@ Git index format
 
 == Index entry
 
-  Index entries are sorted in ascending order on the name field,
+Index entries are sorted in ascending order on the name field,
   interpreted as a string of unsigned bytes (i.e. memcmp() order, no
   localization, no special casing of directory separator '/'). Entries
   with the same name are sorted by their stage field.
 
-  An index entry typically represents a file. However, if sparse-checkout
+An index entry typically represents a file. However, if sparse-checkout
   is enabled in cone mode (`core.sparseCheckoutCone` is enabled) and the
   `extensions.sparseIndex` extension is enabled, then the index may
   contain entries for directories outside of the sparse-checkout definition.
@@ -103,7 +103,7 @@ Git index format
 
   Object name for the represented object
 
-  A 16-bit 'flags' field split into (high to low bits)
+A 16-bit 'flags' field split into (high to low bits)
 
     1-bit assume-valid flag
 
@@ -114,7 +114,7 @@ Git index format
     12-bit name length if the length is less than 0xFFF; otherwise 0xFFF
     is stored in this field.
 
-  (Version 3 or later) A 16-bit field, only applicable if the
+(Version 3 or later) A 16-bit field, only applicable if the
   "extended flag" above is 1, split into (high to low bits).
 
     1-bit reserved for future
@@ -125,16 +125,16 @@ Git index format
 
     13-bit unused, must be zero
 
-  Entry path name (variable length) relative to top level directory
+Entry path name (variable length) relative to top level directory
     (without leading slash). '/' is used as path separator. The special
     path components ".", ".." and ".git" (without quotes) are disallowed.
     Trailing slash is also disallowed.
 
-    The exact encoding is undefined, but the '.' and '/' characters
+The exact encoding is undefined, but the '.' and '/' characters
     are encoded in 7-bit ASCII and the encoding cannot contain a NUL
     byte (iow, this is a UNIX pathname).
 
-  (Version 4) In version 4, the entry path name is prefix-compressed
+(Version 4) In version 4, the entry path name is prefix-compressed
     relative to the path name for the previous entry (the very first
     entry is encoded as if the path name for the previous entry is an
     empty string).  At the beginning of an entry, an integer N in the
@@ -144,20 +144,20 @@ Git index format
     path name for the previous entry, and replacing it with the string S
     yields the path name for this entry.
 
-  1-8 nul bytes as necessary to pad the entry to a multiple of eight bytes
+1-8 nul bytes as necessary to pad the entry to a multiple of eight bytes
   while keeping the name NUL-terminated.
 
-  (Version 4) In version 4, the padding after the pathname does not
+(Version 4) In version 4, the padding after the pathname does not
   exist.
 
-  Interpretation of index entries in split index mode is completely
+Interpretation of index entries in split index mode is completely
   different. See below for details.
 
 == Extensions
 
 === Cache tree
 
-  Since the index does not record entries for directories, the cache
+Since the index does not record entries for directories, the cache
   entries cannot describe tree objects that already exist in the object
   database for regions of the index that are unchanged from an existing
   commit. The cache tree extension stores a recursive tree structure that
@@ -168,26 +168,26 @@ Git index format
   as `HEAD^{tree}`, since sections of the index can be skipped when a tree
   comparison demonstrates equality.
 
-  The recursive tree structure uses nodes that store a number of cache
+The recursive tree structure uses nodes that store a number of cache
   entries, a list of subnodes, and an object ID (OID). The OID references
   the existing tree for that node, if it is known to exist. The subnodes
   correspond to subdirectories that themselves have cache tree nodes. The
   number of cache entries corresponds to the number of cache entries in
   the index that describe paths within that tree's directory.
 
-  The extension tracks the full directory structure in the cache tree
+The extension tracks the full directory structure in the cache tree
   extension, but this is generally smaller than the full cache entry list.
 
-  When a path is updated in index, Git invalidates all nodes of the
+When a path is updated in index, Git invalidates all nodes of the
   recursive cache tree corresponding to the parent directories of that
   path. We store these tree nodes as being "invalid" by using "-1" as the
   number of cache entries. Invalid nodes still store a span of index
   entries, allowing Git to focus its efforts when reconstructing a full
   cache tree.
 
-  The signature for this extension is { 'T', 'R', 'E', 'E' }.
+The signature for this extension is { 'T', 'R', 'E', 'E' }.
 
-  A series of entries fill the entire extension; each of which
+A series of entries fill the entire extension; each of which
   consists of:
 
   - NUL-terminated path component (relative to its parent directory);
@@ -205,12 +205,12 @@ Git index format
   - Object name for the object that would result from writing this span
     of index as a tree.
 
-  An entry can be in an invalidated state and is represented by having
+An entry can be in an invalidated state and is represented by having
   a negative number in the entry_count field. In this case, there is no
   object name and the next entry starts immediately after the newline.
   When writing an invalid entry, -1 should always be used as entry_count.
 
-  The entries are written out in the top-down, depth-first order.  The
+The entries are written out in the top-down, depth-first order.  The
   first entry represents the root level of the repository, followed by the
   first subtree--let's call this A--of the root level (with its name
   relative to the root level), followed by the first subtree of A (with
@@ -219,19 +219,19 @@ Git index format
 
 === Resolve undo
 
-  A conflict is represented in the index as a set of higher stage entries.
+A conflict is represented in the index as a set of higher stage entries.
   When a conflict is resolved (e.g. with "git add path"), these higher
   stage entries will be removed and a stage-0 entry with proper resolution
   is added.
 
-  When these higher stage entries are removed, they are saved in the
+When these higher stage entries are removed, they are saved in the
   resolve undo extension, so that conflicts can be recreated (e.g. with
   "git checkout -m"), in case users want to redo a conflict resolution
   from scratch.
 
-  The signature for this extension is { 'R', 'E', 'U', 'C' }.
+The signature for this extension is { 'R', 'E', 'U', 'C' }.
 
-  A series of entries fill the entire extension; each of which
+A series of entries fill the entire extension; each of which
   consists of:
 
   - NUL-terminated pathname the entry describes (relative to the root of
@@ -246,13 +246,13 @@ Git index format
 
 === Split index
 
-  In split index mode, the majority of index entries could be stored
+In split index mode, the majority of index entries could be stored
   in a separate file. This extension records the changes to be made on
   top of that to produce the final index.
 
-  The signature for this extension is { 'l', 'i', 'n', 'k' }.
+The signature for this extension is { 'l', 'i', 'n', 'k' }.
 
-  The extension consists of:
+The extension consists of:
 
   - Hash of the shared index file. The shared index file path
     is $GIT_DIR/sharedindex.<hash>. If all bits are zero, the
@@ -273,17 +273,17 @@ Git index format
     first index entry, the second "1" bit to the second entry and so
     on. Replaced entries may have empty path names to save space.
 
-  The remaining index entries after replaced ones will be added to the
+The remaining index entries after replaced ones will be added to the
   final index. These added entries are also sorted by entry name then
   stage.
 
 == Untracked cache
 
-  Untracked cache saves the untracked file list and necessary data to
+Untracked cache saves the untracked file list and necessary data to
   verify the cache. The signature for this extension is { 'U', 'N',
   'T', 'R' }.
 
-  The extension starts with
+The extension starts with
 
   - A sequence of NUL-terminated strings, preceded by the size of the
     sequence in variable width encoding. Each string describes the
@@ -341,11 +341,11 @@ The remaining data of each directory block is grouped by type:
 
 == File System Monitor cache
 
-  The file system monitor cache tracks files for which the core.fsmonitor
+The file system monitor cache tracks files for which the core.fsmonitor
   hook has told us about changes.  The signature for this extension is
   { 'F', 'S', 'M', 'N' }.
 
-  The extension starts with
+The extension starts with
 
   - 32-bit version number: the current supported versions are 1 and 2.
 
@@ -366,16 +366,16 @@ The remaining data of each directory block is grouped by type:
 
 == End of Index Entry
 
-  The End of Index Entry (EOIE) is used to locate the end of the variable
+The End of Index Entry (EOIE) is used to locate the end of the variable
   length index entries and the beginning of the extensions. Code can take
   advantage of this to quickly locate the index extensions without having
   to parse through all of the index entries.
 
-  Because it must be able to be loaded before the variable length cache
+Because it must be able to be loaded before the variable length cache
   entries and other index extensions, this extension must be written last.
   The signature for this extension is { 'E', 'O', 'I', 'E' }.
 
-  The extension consists of:
+The extension consists of:
 
   - 32-bit offset to the end of the index entries
 
@@ -389,12 +389,12 @@ The remaining data of each directory block is grouped by type:
 
 == Index Entry Offset Table
 
-  The Index Entry Offset Table (IEOT) is used to help address the CPU
+The Index Entry Offset Table (IEOT) is used to help address the CPU
   cost of loading the index by enabling multi-threading the process of
   converting cache entries from the on-disk format to the in-memory format.
   The signature for this extension is { 'I', 'E', 'O', 'T' }.
 
-  The extension consists of:
+The extension consists of:
 
   - 32-bit version (currently 1)
 
@@ -407,7 +407,7 @@ The remaining data of each directory block is grouped by type:
 
 == Sparse Directory Entries
 
-  When using sparse-checkout in cone mode, some entire directories within
+When using sparse-checkout in cone mode, some entire directories within
   the index can be summarized by pointing to a tree object instead of the
   entire expanded list of paths within that tree. An index containing such
   entries is a "sparse index". Index format versions 4 and less were not
diff --git a/Documentation/gitformat-pack.txt b/Documentation/gitformat-pack.txt
index e06af02f211..8a0e8dd160d 100644
--- a/Documentation/gitformat-pack.txt
+++ b/Documentation/gitformat-pack.txt
@@ -294,10 +294,10 @@ Pack file entry: <+
 
   - The same trailer as a v1 pack file:
 
-    A copy of the pack checksum at the end of
+A copy of the pack checksum at the end of
     corresponding packfile.
 
-    Index checksum of all of the above.
+Index checksum of all of the above.
 
 == pack-*.rev files have the format:
 
-- 
2.38.0.1524.gdb7bac9ecc9

