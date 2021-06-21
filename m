Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCD0C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53976124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhFUW11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhFUW10 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:26 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0093BC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:11 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id q9so3065279ilj.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E1ukGpQl2b4/B9Wy3ah+SELJbNqBJxQ0kTbWxrKWFkE=;
        b=BJ3/rxdQaez2UNq2O7XtQy6sgWnHDZ/8/oGANoO3MenxGpF9cVUPXrJsAs6jdEJcG/
         lsFQIxvUf5zTYtXsPU0fKfFZ5YP9EAsBjB4Do+jByMKGaXrzfXdn4PShmiOVDrjTEr/o
         eQzCTqf2nujKiCRa3wmNxGDB8j3YYgOPXm+YnfniyAcX+blulaP50F02G1twDad+e+FQ
         cCrKu7vjv0Ckw9bBKo5gjudd8VxR+hN9m1kQkIaDAqF3afP662532Dh+brXTLPVik0Nq
         PwNNV6N5v76qPlL2KsDRdiWmrDNnI7kbz6IsXOEGhTH4sp3YQpuoi94XALYj1KIw1gY8
         xaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E1ukGpQl2b4/B9Wy3ah+SELJbNqBJxQ0kTbWxrKWFkE=;
        b=aTTs3AVkCuRIln6hACR/ItGpTZgFqot36vbISRTjKG0/1Qn23KTzo2eRc668UxF/OY
         R2tF+aObgTCXhV+RqD1GyuI/EnfReslmOLLXtgLqjFm+bYR0poGMEyN1ev1YnsTlTmj3
         hwXVAYHUBPwWVLMKK0gd2X6NrWmqp7V0i+kIZLNzO75d2O0rrVrkZFZheEuSerwa/DIc
         5VppZFOgdlL3VAxwVmJUFAj6TlviZ4yrXtzg5JGQlqffD8F2nKBfvgOkRUPARPU62FVh
         yOnUEBN1LsLZZy/MfcrU4EqeRUXwtvkawa53j7vCL1SQ+wzQfhtl2cm9V2qp8D2d4Ewh
         T7Dg==
X-Gm-Message-State: AOAM5327koaICtzdXU/jZPj26NbYnAi+l5jx/Nm4ypVgkdybWJjoUJor
        TFCBw7iEf9queR7SmGTNltbAUgXWhw36rown
X-Google-Smtp-Source: ABdhPJyYpDJOmUDT3zEWTLWIoW7raypTf5YHW5WTl6UYwfyaHKSQzXHQaPAKkbxrn4nPA9tphtlghw==
X-Received: by 2002:a92:bd03:: with SMTP id c3mr328446ile.83.1624314311136;
        Mon, 21 Jun 2021 15:25:11 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id a18sm6845218ilc.31.2021.06.21.15.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:10 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 05/24] Documentation: describe MIDX-based bitmaps
Message-ID: <64a260e0c6a116b7c6fa6fea2b9fd96bf416cb18.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
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

