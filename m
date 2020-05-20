Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE0C433E1
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E661E207D3
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT6ZJaoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgETRgX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgETRgV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:36:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03500C05BD43
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n18so3770886wmj.5
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=T+DOMIMWyxpFh60lf0vf+1Q+dkqmy7Q8+uCykSeVBuI=;
        b=PT6ZJaoU7Jl+LsvA0mrGKFGZ9jD7UjH/ikCP6OlqoG/HGQY4qmzsJDYORKcZinkYT8
         dfzo//j5q8FGl6RLg2+w/sX4ilkhQVfIhOf/OK8CG5IwunvQw+oq33/YnxlsvsPTbKIN
         aq5vZRNwE9YYrNYU/thXNvR2Nb12x+XlvfkVC07fB5lRzoi1L4bH+O904OJClJ97+vhE
         Y+8Z/e7eIMJGJHcOY2A034bvI4MNoDkZ89jYSe+JYFuQNoCScVm7COfUo9bZ8jAtRvCM
         +svfSurSYjBSBjdBjb3GcKY0KsRnPk/LNizneSYmxGR5/dJNsfBcSzLw+DlQeneDe5+T
         2yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=T+DOMIMWyxpFh60lf0vf+1Q+dkqmy7Q8+uCykSeVBuI=;
        b=KN5Wx+PPmYwniVpCAkLmoy29fH379eClie0LHsGFJJS7CFJTmsshbir7a8T51JOBWH
         sRNicdOEk0Cgknhk+4Z80proNpxZn0QZDoucGQKPFgBfmrN2cy7V3LJDSUaICrNHkwwG
         lPQBiqzSsfPj1BwVyVDREBeOQo/QEwQDFz+h1cCoUzdqZqz/dJF1BUYekLtTWhQ95p8L
         zDMfOXoiyZzfLsHwaHkxqyvOVx0BYULDznjvjQO5rZXYBET/Wcceu98D/wPo0lwXQB53
         Q/7f9rcruqpySGcoW6v/FfqXzS8+INwyR/BGmG3AYkaPDPQeo8/osBgLNbfuFvASXGYX
         /Sfw==
X-Gm-Message-State: AOAM533aO+l4fJLwCXNLGgXamwOVAi9bBPdLsVlUCN1BpnblD4AKsfFo
        WjhO4Q7cb9+9xgBH7T4ILsMDWoRO
X-Google-Smtp-Source: ABdhPJyIT8OQe06z2flSKJC3vAlvP1RGdvUffeIXI/2CZ8Kws0VD0k3R49qEUh9okFdlSTJlVg6roQ==
X-Received: by 2002:a05:600c:2146:: with SMTP id v6mr5753680wml.142.1589996179224;
        Wed, 20 May 2020 10:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 40sm2172714wrc.15.2020.05.20.10.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:36:18 -0700 (PDT)
Message-Id: <6aaac800b1624eeece0c7eb53a26e648eecd862e.1589996173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.638.git.1589996173.gitgitgadget@gmail.com>
References: <pull.638.git.1589996173.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 May 2020 17:36:12 +0000
Subject: [PATCH 6/6] reftable: define version 2 of the spec to accomodate
 SHA256
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/reftable.txt | 82 +++++++++++++++-------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index e53823c9bfb..201e46a9dd6 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -30,7 +30,7 @@ Objectives
 
 * Near constant time lookup for any single reference, even when the
 repository is cold and not in process or kernel cache.
-* Near constant time verification if a SHA-1 is referred to by at least
+* Near constant time verification if an object name is referred to by at least
 one reference (for allow-tip-sha1-in-want).
 * Efficient enumeration of an entire namespace, such as `refs/tags/`.
 * Support atomic push with `O(size_of_update)` operations.
@@ -210,8 +210,8 @@ and non-aligned files.
 Very small files (e.g. a single ref block) may omit `padding` and the ref
 index to reduce total file size.
 
-Header
-^^^^^^
+Header (version 1)
+^^^^^^^^^^^^^^^^^^
 
 A 24-byte header appears at the beginning of the file:
 
@@ -232,6 +232,26 @@ used in a stack for link:#Update-transactions[transactions], these
 fields can order the files such that the prior file's
 `max_update_index + 1` is the next file's `min_update_index`.
 
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
 First ref block
 ^^^^^^^^^^^^^^^
 
@@ -319,8 +339,8 @@ The `value` follows. Its format is determined by `value_type`, one of
 the following:
 
 * `0x0`: deletion; no value data (see transactions, below)
-* `0x1`: one 20-byte object name; value of the ref
-* `0x2`: two 20-byte object names; value of the ref, peeled target
+* `0x1`: one object name; value of the ref
+* `0x2`: two object names; value of the ref, peeled target
 * `0x3`: symbolic reference: `varint( target_len ) target`
 
 Symbolic references use `0x3`, followed by the complete name of the
@@ -421,9 +441,9 @@ Obj block format
 ^^^^^^^^^^^^^^^^
 
 Object blocks are optional. Writers may choose to omit object blocks,
-especially if readers will not use the SHA-1 to ref mapping.
+especially if readers will not use the object name to ref mapping.
 
-Object blocks use unique, abbreviated 2-20 byte SHA-1 keys, mapping to
+Object blocks use unique, abbreviated 2-32 object name keys, mapping to
 ref blocks containing references pointing to that object directly, or as
 the peeled value of an annotated tag. Like ref blocks, object blocks use
 the file's standard block size. The abbrevation length is available in
@@ -432,7 +452,7 @@ the footer as `obj_id_len`.
 To save space in small files, object blocks may be omitted if the ref
 index is not present, as brute force search will only need to read a few
 ref blocks. When missing, readers should brute force a linear search of
-all references to lookup by SHA-1.
+all references to lookup by object name.
 
 An object block is written as:
 
@@ -449,9 +469,9 @@ padding?
 Fields are identical to ref block. Binary search using the restart table
 works the same as in reference blocks.
 
-Because object names are abbreviated by writers to the shortest
-unique abbreviation within the reftable, obj key lengths are variable
-between 2 and 20 bytes. Readers must compare only for common prefix
+Because object names are abbreviated by writers to the shortest unique
+abbreviation within the reftable, obj key lengths have a variable length. Their
+length must be at least 2 bytes. Readers must compare only for common prefix
 match within an obj block or obj index.
 
 obj record
@@ -504,9 +524,9 @@ for (j = 1; j < position_count; j++) {
 ....
 
 With a position in hand, a reader must linearly scan the ref block,
-starting from the first `ref_record`, testing each reference's SHA-1s
+starting from the first `ref_record`, testing each reference's object names
 (for `value_type = 0x1` or `0x2`) for full equality. Faster searching by
-SHA-1 within a single ref block is not supported by the reftable format.
+object name within a single ref block is not supported by the reftable format.
 Smaller block sizes reduce the number of candidates this step must
 consider.
 
@@ -621,7 +641,7 @@ reflogs must treat this as a deletion.
 For `log_type = 0x1`, the `log_data` section follows
 linkgit:git-update-ref[1] logging and includes:
 
-* two 20-byte SHA-1s (old id, new id)
+* two object names (old id, new id)
 * varint string of committer's name
 * varint string of committer's email
 * varint time in seconds since epoch (Jan 1, 1970)
@@ -689,14 +709,8 @@ Footer
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
@@ -719,12 +733,16 @@ obj blocks.
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
@@ -780,11 +798,11 @@ Lightweight refs dominate
 ^^^^^^^^^^^^^^^^^^^^^^^^^
 
 The reftable format assumes the vast majority of references are single
-SHA-1 valued with common prefixes, such as Gerrit Code Review's
+object names valued with common prefixes, such as Gerrit Code Review's
 `refs/changes/` namespace, GitHub's `refs/pulls/` namespace, or many
 lightweight tags in the `refs/tags/` namespace.
 
-Annotated tags storing the peeled object cost an additional 20 bytes per
+Annotated tags storing the peeled object cost an additional object name per
 reference.
 
 Low overhead
@@ -817,7 +835,7 @@ Scans and lookups dominate
 
 Scanning all references and lookup by name (or namespace such as
 `refs/heads/`) are the most common activities performed on repositories.
-SHA-1s are stored directly with references to optimize this use case.
+Object names are stored directly with references to optimize this use case.
 
 Logs are infrequently read
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -1063,13 +1081,3 @@ impossible.
 
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
-name length other than 20. The length could be stored in an expanded file
-heaer, or hardcoded as part of the version.
-- 
gitgitgadget
