Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D4CC54E8F
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48AA120752
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlO/0xMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgEKTqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731522AbgEKTqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC86C05BD09
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u16so20716501wmc.5
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ATXlbrriEKZOS7SRscSn/QLwHDaAKXRuAB2u/DzoFA0=;
        b=VlO/0xMxiLRM8laP/JTr4YTIoaX+lBuTkasLUvt8lRrxKcrnYTZbSbLP6aaLlT3FiR
         FnezY97pNtl4mPnkkogk2H3L8zlfMQuTavvsP2e37J4MhUOxYDv73qx26s+azSVewe9V
         YH2B6oYlZ3MDXWug8t7kd/ELQoLFdwGhnAKnOFg5uJzrDwSCylobS+GmPakB4MEmG5Nu
         ht3lpGmNQyyMQhPybd4EGzuprJXOffzCXRWn9Tkzx8zhrIzHyIvcYhTt1IL0skE4mdsQ
         EBJvqET4bjvfr7eniqcJnYJtRauyZtYnJ5cFPGkjniOmX/kMdOTl2WeEVZhP8oxK168p
         Ew2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ATXlbrriEKZOS7SRscSn/QLwHDaAKXRuAB2u/DzoFA0=;
        b=h+k3pG7wT8yO7P93F57mlzm03jTAUfWwIKmAF5w5Gc40lrPnGOXl3HbWTp6YTWSWLx
         Y7NYWDyvA7yVFIfuTomCsy6MxzjgImOPpc/pmHZR3B+bslhP0nYjQpbDhcoN6Ds0eMWu
         YAsxbtGoR/S06uBxdypaplPLij1MnK38ysupd1zo8BBmBJe1kZVmJ8Qr/fzpxkeu5Sy2
         uFkrSYU8ah3I8kdELNdB9PJT2q+2sxZFPXxxVZO+4rM3X94t6egGCQJOcLRSsyQ7QXYG
         UBvgXFCPS/aN6U9uR2ZfIeQh83zpBSgORv/blb0dM/H4GPTQqS3gS9qR/dKVQbHsTqLr
         gThg==
X-Gm-Message-State: AGi0Pubjwq/sv1ve1SGc4n4i2Xg1lEoH0A+pDM+sek+3QkFIarZeCwKt
        I0OVRHwPdARlYxzQ+pS22efm1L5F
X-Google-Smtp-Source: APiQypKiqG9iuDeSJei/2Ry1iAOG2H8W2Ot6SzXQc5hxiQ9w5Y31JDGxdGmvqJ/OpaQ9wCZhBDm4mA==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr31133722wmj.12.1589226396059;
        Mon, 11 May 2020 12:46:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 81sm11211115wme.16.2020.05.11.12.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:35 -0700 (PDT)
Message-Id: <1e3c8f2d3e8c6c6db8460f29115d2fe898f85012.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:21 +0000
Subject: [PATCH v13 06/13] reftable: define version 2 of the spec to
 accomodate SHA256
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Version appends a hash ID to the file header, making it slightly larger.

This commit also changes "SHA-1" into "object ID" in many places.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 79 ++++++++++++++++------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 6223538d64e..1464c4e7437 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -29,7 +29,7 @@ Objectives
 
 * Near constant time lookup for any single reference, even when the
 repository is cold and not in process or kernel cache.
-* Near constant time verification if a SHA-1 is referred to by at least
+* Near constant time verification if an object ID is referred to by at least
 one reference (for allow-tip-sha1-in-want).
 * Efficient lookup of an entire namespace, such as `refs/tags/`.
 * Support atomic push with `O(size_of_update)` operations.
@@ -193,8 +193,8 @@ and non-aligned files.
 Very small files (e.g. a single ref block) may omit `padding` and the ref
 index to reduce total file size.
 
-Header
-^^^^^^
+Header (version 1)
+^^^^^^^^^^^^^^^^^^
 
 A 24-byte header appears at the beginning of the file:
 
@@ -215,6 +215,27 @@ used in a stack for link:#Update-transactions[transactions], these
 fields can order the files such that the prior file’s
 `max_update_index + 1` is the next file’s `min_update_index`.
 
+Header (version 2)
+^^^^^^^^^^^^^^^^^^
+
+A 28-byte header appears at the beginning of the file:
+
+....
+'REFT'
+uint8( version_number = 2 )
+uint24( block_size )
+uint64( min_update_index )
+uint64( max_update_index )
+uint32( hash_id )
+....
+
+The header is identical to `version_number=1`, with the 4-byte hash ID
+("sha1" for SHA1 and "s256" for SHA-256) append to the header.
+
+For maximum backward compatibility, it is recommended to use version 1 when
+writing SHA1 reftables.
+
+
 First ref block
 ^^^^^^^^^^^^^^^
 
@@ -302,8 +323,8 @@ The `value` follows. Its format is determined by `value_type`, one of
 the following:
 
 * `0x0`: deletion; no value data (see transactions, below)
-* `0x1`: one 20-byte object id; value of the ref
-* `0x2`: two 20-byte object ids; value of the ref, peeled target
+* `0x1`: one object id; value of the ref
+* `0x2`: two object ids; value of the ref, peeled target
 * `0x3`: symbolic reference: `varint( target_len ) target`
 
 Symbolic references use `0x3`, followed by the complete name of the
@@ -404,9 +425,9 @@ Obj block format
 ^^^^^^^^^^^^^^^^
 
 Object blocks are optional. Writers may choose to omit object blocks,
-especially if readers will not use the SHA-1 to ref mapping.
+especially if readers will not use the object ID to ref mapping.
 
-Object blocks use unique, abbreviated 2-20 byte SHA-1 keys, mapping to
+Object blocks use unique, abbreviated 2-32 byte object ID keys, mapping to
 ref blocks containing references pointing to that object directly, or as
 the peeled value of an annotated tag. Like ref blocks, object blocks use
 the file’s standard block size. The abbrevation length is available in
@@ -415,7 +436,7 @@ the footer as `obj_id_len`.
 To save space in small files, object blocks may be omitted if the ref
 index is not present, as brute force search will only need to read a few
 ref blocks. When missing, readers should brute force a linear search of
-all references to lookup by SHA-1.
+all references to lookup by object ID.
 
 An object block is written as:
 
@@ -434,7 +455,7 @@ works the same as in reference blocks.
 
 Because object identifiers are abbreviated by writers to the shortest
 unique abbreviation within the reftable, obj key lengths are variable
-between 2 and 20 bytes. Readers must compare only for common prefix
+between 2 and 32 bytes. Readers must compare only for common prefix
 match within an obj block or obj index.
 
 obj record
@@ -487,9 +508,9 @@ for (j = 1; j < position_count; j++) {
 ....
 
 With a position in hand, a reader must linearly scan the ref block,
-starting from the first `ref_record`, testing each reference’s SHA-1s
+starting from the first `ref_record`, testing each reference’s object IDs
 (for `value_type = 0x1` or `0x2`) for full equality. Faster searching by
-SHA-1 within a single ref block is not supported by the reftable format.
+object ID within a single ref block is not supported by the reftable format.
 Smaller block sizes reduce the number of candidates this step must
 consider.
 
@@ -604,7 +625,7 @@ reflogs must treat this as a deletion.
 For `log_type = 0x1`, the `log_data` section follows
 linkgit:git-update-ref[1] logging and includes:
 
-* two 20-byte SHA-1s (old id, new id)
+* two object IDs (old id, new id)
 * varint string of committer’s name
 * varint string of committer’s email
 * varint time in seconds since epoch (Jan 1, 1970)
@@ -671,14 +692,8 @@ Footer
 After the last block of the file, a file footer is written. It begins
 like the file header, but is extended with additional data.
 
-A 68-byte footer appears at the end:
-
 ....
-    'REFT'
-    uint8( version_number = 1 )
-    uint24( block_size )
-    uint64( min_update_index )
-    uint64( max_update_index )
+    HEADER
 
     uint64( ref_index_position )
     uint64( (obj_position << 5) | obj_id_len )
@@ -701,12 +716,16 @@ obj blocks.
 * `obj_index_position`: byte position for the start of the obj index.
 * `log_index_position`: byte position for the start of the log index.
 
+The size of the footer is 68 bytes for version 1, and 72 bytes for
+version 2.
+
 Reading the footer
 ++++++++++++++++++
 
-Readers must seek to `file_length - 68` to access the footer. A trusted
-external source (such as `stat(2)`) is necessary to obtain
-`file_length`. When reading the footer, readers must verify:
+Readers must first read the file start to determine the version
+number. Then they seek to `file_length - FOOTER_LENGTH` to access the
+footer. A trusted external source (such as `stat(2)`) is necessary to
+obtain `file_length`. When reading the footer, readers must verify:
 
 * 4-byte magic is correct
 * 1-byte version number is recognized
@@ -779,11 +798,11 @@ Lightweight refs dominate
 ^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The reftable format assumes the vast majority of references are single
-SHA-1 valued with common prefixes, such as Gerrit Code Review’s
+object IDs valued with common prefixes, such as Gerrit Code Review’s
 `refs/changes/` namespace, GitHub’s `refs/pulls/` namespace, or many
 lightweight tags in the `refs/tags/` namespace.
 
-Annotated tags storing the peeled object cost an additional 20 bytes per
+Annotated tags storing the peeled object cost an additional object ID per
 reference.
 
 Low overhead
@@ -816,7 +835,7 @@ Scans and lookups dominate
 
 Scanning all references and lookup by name (or namespace such as
 `refs/heads/`) are the most common activities performed on repositories.
-SHA-1s are stored directly with references to optimize this use case.
+Object IDs are stored directly with references to optimize this use case.
 
 Logs are infrequently read
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -1062,13 +1081,3 @@ impossible.
 
 A common format that can be supported by all major Git implementations
 (git-core, JGit, libgit2) is strongly preferred.
-
-Future
-~~~~~~
-
-Longer hashes
-^^^^^^^^^^^^^
-
-Version will bump (e.g. 2) to indicate `value` uses a different object
-id length other than 20. The length could be stored in an expanded file
-header, or hardcoded as part of the version.
-- 
gitgitgadget

