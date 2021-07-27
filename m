Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F8C4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24FC6023D
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhG0VVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbhG0VVD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:03 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CF4C0619E1
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:34 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id d10so643221ils.7
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7gb+p1qp8OyprN79ta1umhEzfyQPao0o7L6jiWESP8o=;
        b=Qmg7lOlRmlyNVEKBpAdJqfXlZXhZyYwj8qb48tGsa6hnODv670WqtsRyfInfcxOCc2
         EA+lXIYC1iX7NxhYlHoLSsQWyl3Qm9c00OObxQ4bLBouaGetjb4prp3bsj7ob/wPG3wu
         WaBjCu9z1hk1yAFx63kyHrkcRzrW09G5R+dsiABP7NZ1/XT6BRjFkXXZA2d78vBKlk0T
         2RHNTuj3gvjBNMEBfindlnoH1X80UuQI6EeJI3Nc92ADxaHqnw2OSTaUoy7F4uGLz0OH
         PcqIR9qRCS5YdXec+A4c0lpLMohbZ4iHO5K65mrWT1nK9Y6W++m+cvytKVv6ssOSJUjf
         5tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gb+p1qp8OyprN79ta1umhEzfyQPao0o7L6jiWESP8o=;
        b=PvWX2+Z3nbJW7cMaVtdMDPUwsdM0qL9ffXG/m0OsvZFfqzZL0Q+9lTtSKzYk0dWiwV
         Nuio9qTzZjOdyxpdyNDyvpY9LydWZb+pO9OSab2EmdmO84iLKV44WjPdAC4KFHNhtmqC
         qjWEJw0dpEReYthSutM07C1aom0iUp6QAcUbfMbJIEm/ikM1rJp4+t27asjCbB8Pt+Mt
         OumX46YK76Kbw9EIIiaCgg69VXSHa20FDHX6uR95ylVj7RplJHAKKdVuM0Hxr3l3k9Vy
         BUPnHVNQACRF25UzKeo1Ab2hKVMzuTApfrw8V5W4rSHkBkQlYYSfKuGJ+xnLWGvdm1Pd
         PnTA==
X-Gm-Message-State: AOAM530EAt9HueH+J90MS7EdkHnS6zhaa2JzKS6A1gWY2b6dNkMcmYYj
        jlSGQ2DjdekdCzadN7KPHUodeIQb5GysID3V
X-Google-Smtp-Source: ABdhPJwVvGr55FygnJkJ5UpuXdsDej8TW5goGW24sZl0IzFvxWd6kvrVi4JlGKoZdlRRo0p/k1KSWg==
X-Received: by 2002:a92:b74d:: with SMTP id c13mr18090888ilm.176.1627420773557;
        Tue, 27 Jul 2021 14:19:33 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id f16sm2619514ilc.53.2021.07.27.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:33 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 04/25] Documentation: describe MIDX-based bitmaps
Message-ID: <8da5de7c24d274e697e0f5ae0c65720ff9e5fa4c.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the technical documentation to describe the multi-pack bitmap
format. This patch merely introduces the new format, and describes its
high-level ideas. Git does not yet know how to read nor write these
multi-pack variants, and so the subsequent patches will:

  - Introduce code to interpret multi-pack bitmaps, according to this
    document.

  - Then, introduce code to write multi-pack bitmaps from the 'git
    multi-pack-index write' sub-command.

Finally, the implementation will gain tests in subsequent patches (as
opposed to inline with the patch teaching Git how to write multi-pack
bitmaps) to avoid a cyclic dependency.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/bitmap-format.txt    | 71 ++++++++++++++++----
 Documentation/technical/multi-pack-index.txt | 10 +--
 2 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index f8c18a0f7a..04b3ec2178 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -1,6 +1,44 @@
 GIT bitmap v1 format
 ====================
 
+== Pack and multi-pack bitmaps
+
+Bitmaps store reachability information about the set of objects in a packfile,
+or a multi-pack index (MIDX). The former is defined obviously, and the latter is
+defined as the union of objects in packs contained in the MIDX.
+
+A bitmap may belong to either one pack, or the repository's multi-pack index (if
+it exists). A repository may have at most one bitmap.
+
+An object is uniquely described by its bit position within a bitmap:
+
+	- If the bitmap belongs to a packfile, the __n__th bit corresponds to
+	the __n__th object in pack order. For a function `offset` which maps
+	objects to their byte offset within a pack, pack order is defined as
+	follows:
+
+		o1 <= o2 <==> offset(o1) <= offset(o2)
+
+	- If the bitmap belongs to a MIDX, the __n__th bit corresponds to the
+	__n__th object in MIDX order. With an additional function `pack` which
+	maps objects to the pack they were selected from by the MIDX, MIDX order
+	is defined as follows:
+
+		o1 <= o2 <==> pack(o1) <= pack(o2) /\ offset(o1) <= offset(o2)
+
+	The ordering between packs is done according to the MIDX's .rev file.
+	Notably, the preferred pack sorts ahead of all other packs.
+
+The on-disk representation (described below) of a bitmap is the same regardless
+of whether or not that bitmap belongs to a packfile or a MIDX. The only
+difference is the interpretation of the bits, which is described above.
+
+Certain bitmap extensions are supported (see: Appendix B). No extensions are
+required for bitmaps corresponding to packfiles. For bitmaps that correspond to
+MIDXs, both the bit-cache and rev-cache extensions are required.
+
+== On-disk format
+
 	- A header appears at the beginning:
 
 		4-byte signature: {'B', 'I', 'T', 'M'}
@@ -14,17 +52,19 @@ GIT bitmap v1 format
 			The following flags are supported:
 
 			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
-			This flag must always be present. It implies that the bitmap
-			index has been generated for a packfile with full closure
-			(i.e. where every single object in the packfile can find
-			 its parent links inside the same packfile). This is a
-			requirement for the bitmap index format, also present in JGit,
-			that greatly reduces the complexity of the implementation.
+			This flag must always be present. It implies that the
+			bitmap index has been generated for a packfile or
+			multi-pack index (MIDX) with full closure (i.e. where
+			every single object in the packfile/MIDX can find its
+			parent links inside the same packfile/MIDX). This is a
+			requirement for the bitmap index format, also present in
+			JGit, that greatly reduces the complexity of the
+			implementation.
 
 			- BITMAP_OPT_HASH_CACHE (0x4)
 			If present, the end of the bitmap file contains
 			`N` 32-bit name-hash values, one per object in the
-			pack. The format and meaning of the name-hash is
+			pack/MIDX. The format and meaning of the name-hash is
 			described below.
 
 		4-byte entry count (network byte order)
@@ -33,7 +73,8 @@ GIT bitmap v1 format
 
 		20-byte checksum
 
-			The SHA1 checksum of the pack this bitmap index belongs to.
+			The SHA1 checksum of the pack/MIDX this bitmap index
+			belongs to.
 
 	- 4 EWAH bitmaps that act as type indexes
 
@@ -50,7 +91,7 @@ GIT bitmap v1 format
 			- Tags
 
 		In each bitmap, the `n`th bit is set to true if the `n`th object
-		in the packfile is of that type.
+		in the packfile or multi-pack index is of that type.
 
 		The obvious consequence is that the OR of all 4 bitmaps will result
 		in a full set (all bits set), and the AND of all 4 bitmaps will
@@ -62,8 +103,9 @@ GIT bitmap v1 format
 		Each entry contains the following:
 
 		- 4-byte object position (network byte order)
-			The position **in the index for the packfile** where the
-			bitmap for this commit is found.
+			The position **in the index for the packfile or
+			multi-pack index** where the bitmap for this commit is
+			found.
 
 		- 1-byte XOR-offset
 			The xor offset used to compress this bitmap. For an entry
@@ -146,10 +188,11 @@ Name-hash cache
 ---------------
 
 If the BITMAP_OPT_HASH_CACHE flag is set, the end of the bitmap contains
-a cache of 32-bit values, one per object in the pack. The value at
+a cache of 32-bit values, one per object in the pack/MIDX. The value at
 position `i` is the hash of the pathname at which the `i`th object
-(counting in index order) in the pack can be found.  This can be fed
-into the delta heuristics to compare objects with similar pathnames.
+(counting in index or multi-pack index order) in the pack/MIDX can be found.
+This can be fed into the delta heuristics to compare objects with similar
+pathnames.
 
 The hash algorithm used is:
 
diff --git a/Documentation/technical/multi-pack-index.txt b/Documentation/technical/multi-pack-index.txt
index fb688976c4..1a73c3ee20 100644
--- a/Documentation/technical/multi-pack-index.txt
+++ b/Documentation/technical/multi-pack-index.txt
@@ -71,14 +71,10 @@ Future Work
   still reducing the number of binary searches required for object
   lookups.
 
-- The reachability bitmap is currently paired directly with a single
-  packfile, using the pack-order as the object order to hopefully
-  compress the bitmaps well using run-length encoding. This could be
-  extended to pair a reachability bitmap with a multi-pack-index. If
-  the multi-pack-index is extended to store a "stable object order"
+- If the multi-pack-index is extended to store a "stable object order"
   (a function Order(hash) = integer that is constant for a given hash,
-  even as the multi-pack-index is updated) then a reachability bitmap
-  could point to a multi-pack-index and be updated independently.
+  even as the multi-pack-index is updated) then MIDX bitmaps could be
+  updated independently of the MIDX.
 
 - Packfiles can be marked as "special" using empty files that share
   the initial name but replace ".pack" with ".keep" or ".promisor".
-- 
2.31.1.163.ga65ce7f831

