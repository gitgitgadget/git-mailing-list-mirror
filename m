Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761CBC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5438C61007
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhDISLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhDISLU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB2FC061764
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:07 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id l19so1572357ilk.13
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E1ukGpQl2b4/B9Wy3ah+SELJbNqBJxQ0kTbWxrKWFkE=;
        b=1QNRaYPuDGBpCFZProWKsQCumvBWxsfgXn4Lx/FxBI/xW444VPms6VYl+fh+2oseGE
         x0hYMdqmJJh+d2urSbo7kqPiTPudoojEKVWlFGSyv/GRximC80+ED9EzwY67D3G3yt06
         jbQIOgJ2LRxzziV6KSeefLtZIrDMhl0Ygy/ILjpNn5NRltDUzEAKaBVgXvYnav4lwikw
         6P1ACmYxJ2p1FG0KxFwsdRVA+7hj5eSTPXh2Fy4YeESd9C04rUWx24hfj2fxWNakChxH
         5xDtwZo0pmctSsm5w2gegRgNY6WeZDhZme7QsVNCDr1wOkj8l72vrEm521vSlbHzyf1W
         GIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1ukGpQl2b4/B9Wy3ah+SELJbNqBJxQ0kTbWxrKWFkE=;
        b=TocFz4eptNbK8ZiNJwrrL87P685rfwP4YQiGGJYp+nQXSiOF5kNnohOlTFDYPwxFzN
         25QSabWJXv+0ct8KO51q8M/u/2gjwYc6uUSdU/IDqN36ERXpC/QMVhwKyZy1h4sDJr58
         NOaqyCbMRsCsJqERDRi8XQ5Z34tagQND+9PF8GOOQ++aAAs0qgrSUzxza9l1/LrN8s4G
         Dj1r3OVAFsXMu7dKMayzZ5OoUyNAedd5BJDwAwQbdmuHSCPdN1lrRDqVXhtBPhCrBuRD
         aMbZyBJEYTgCdwj4JkFvRzcdnQ6sLsTE30LuAacHSwRk04mrGhkuDYkJOaCnRIgD0Re1
         QwIQ==
X-Gm-Message-State: AOAM532s8eMXl6QX9alAECOQ233MPmUM0A2ndG2kilNx6Kr3Eb1yZPD2
        MSlzdU2ITyTHHS91W7vLSuop6JHv+4rR7qgR
X-Google-Smtp-Source: ABdhPJwBGF/3vtRhRiIfFZqkYKLZYyvsGS1uMu5t/+pnzWLOvkKqPKcerrP2jL2+QxvYxzxEhjlF4g==
X-Received: by 2002:a05:6e02:501:: with SMTP id d1mr5483542ils.76.1617991866236;
        Fri, 09 Apr 2021 11:11:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id k17sm1591556ioa.44.2021.04.09.11.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:05 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 05/22] Documentation: describe MIDX-based bitmaps
Message-ID: <0d4822a64e3b70cc315ff572145e5d5e95b958d9.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
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
 Documentation/technical/bitmap-format.txt    | 72 ++++++++++++++++----
 Documentation/technical/multi-pack-index.txt | 10 +--
 2 files changed, 61 insertions(+), 21 deletions(-)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index f8c18a0f7a..25221c7ec8 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -1,6 +1,45 @@
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
+	The ordering between packs is done lexicographically by the pack name,
+	with the exception of the preferred pack, which sorts ahead of all other
+	packs.
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
@@ -14,17 +53,19 @@ GIT bitmap v1 format
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
@@ -33,7 +74,8 @@ GIT bitmap v1 format
 
 		20-byte checksum
 
-			The SHA1 checksum of the pack this bitmap index belongs to.
+			The SHA1 checksum of the pack/MIDX this bitmap index
+			belongs to.
 
 	- 4 EWAH bitmaps that act as type indexes
 
@@ -50,7 +92,7 @@ GIT bitmap v1 format
 			- Tags
 
 		In each bitmap, the `n`th bit is set to true if the `n`th object
-		in the packfile is of that type.
+		in the packfile or multi-pack index is of that type.
 
 		The obvious consequence is that the OR of all 4 bitmaps will result
 		in a full set (all bits set), and the AND of all 4 bitmaps will
@@ -62,8 +104,9 @@ GIT bitmap v1 format
 		Each entry contains the following:
 
 		- 4-byte object position (network byte order)
-			The position **in the index for the packfile** where the
-			bitmap for this commit is found.
+			The position **in the index for the packfile or
+			multi-pack index** where the bitmap for this commit is
+			found.
 
 		- 1-byte XOR-offset
 			The xor offset used to compress this bitmap. For an entry
@@ -146,10 +189,11 @@ Name-hash cache
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

