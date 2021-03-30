Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B20AC433E2
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0009C619D9
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhC3PEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbhC3PE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D42C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:26 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id v70so16147085qkb.8
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DVLp9viqHo1IVfT/JBQyS6Zq8DFqJrl3YTkPfOwX8sY=;
        b=e0/UuIq88+XmXg1Q7zQmRO6ar+KxFkNXNNy5mTpJWRdOh4X0QxDYxj4WaL6mXo5F5s
         idM5TDTvetNzK3NVDYEWJUKVKgjUdtSjUQOq8E9HZusNN176fcUc01C99KO+vBhmw2pi
         qFA2/BufZTMvPkp+fQJjbaQL8ldCKSf8mcTJP1b6J/3k1ShUnifVSTEh9pyRlYSk6kPj
         LxxWDN+90B3Pt+9UIussawcdCWyfW3mFWh1xJ2JdrjDIziwVX7GpTUhT6v+dIdcF/3PA
         2Ao6L4Z0t4pgdZrHvW2hXY9jeUr4m6vRt0/NHk/wotLyaLpGQf6X9q7voFFkUEKdPUST
         kKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DVLp9viqHo1IVfT/JBQyS6Zq8DFqJrl3YTkPfOwX8sY=;
        b=AfKbR7r9CW7v1bninNOd/MRrC9fDPNNIVIianzlQtKnA2FLd0cx+ipO9fN+bP53MqF
         TGvdVmcjjV6q5hVeIip8TccGGSrlnllt6eJ69dFs9fWQEzCvJyo2iCDGvRc8kYAeLiJo
         OdwFrY7graQwvoznciV57aAggOayZleiUtAwZn9EWinm0f8TRbo6Zv/AKTpQ+3AFJnxC
         8K/SZGcS67jeFy/aGn4pyCyOrSk4cFjl2qDxdodMGTuoj1iNfmz9kJWs8I5I1tM4AClo
         HpckZqDLlr2K23Q9W9tx89pcn9SsEbTk+qNCD8Tdk/RAwPov3AqKEq8TSFTevETHI2P8
         r0ng==
X-Gm-Message-State: AOAM532K26zmK2J4CLPZG9zZcpU6pFr/3QAYv4CDJ9iVqrL0kBd8tOCq
        w6gxbCJzyEaPDW9m3ftjmSDYJsIwS7DotA==
X-Google-Smtp-Source: ABdhPJx7HsrFbN3eCbhRijSjOJCo8gDkine8Zq32TgT1LSjCd5JfwxQvxZKegNvVVUUtfbBlzT6new==
X-Received: by 2002:a37:d2c1:: with SMTP id f184mr30286777qkj.107.1617116665175;
        Tue, 30 Mar 2021 08:04:25 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id 7sm16056886qkm.64.2021.03.30.08.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:24 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 12/16] Documentation/technical: describe multi-pack
 reverse indexes
Message-ID: <8bb3dd24a7caaef36d041108c5a0503f6f84e410.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a prerequisite to implementing multi-pack bitmaps, motivate and
describe the format and ordering of the multi-pack reverse index.

The subsequent patch will implement reading this format, and the patch
after that will implement writing it while producing a multi-pack index.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/technical/pack-format.txt | 83 +++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 1faa949bf6..8d2f42f29e 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -379,3 +379,86 @@ CHUNK DATA:
 TRAILER:
 
 	Index checksum of the above contents.
+
+== multi-pack-index reverse indexes
+
+Similar to the pack-based reverse index, the multi-pack index can also
+be used to generate a reverse index.
+
+Instead of mapping between offset, pack-, and index position, this
+reverse index maps between an object's position within the MIDX, and
+that object's position within a pseudo-pack that the MIDX describes
+(i.e., the ith entry of the multi-pack reverse index holds the MIDX
+position of ith object in pseudo-pack order).
+
+To clarify the difference between these orderings, consider a multi-pack
+reachability bitmap (which does not yet exist, but is what we are
+building towards here). Each bit needs to correspond to an object in the
+MIDX, and so we need an efficient mapping from bit position to MIDX
+position.
+
+One solution is to let bits occupy the same position in the oid-sorted
+index stored by the MIDX. But because oids are effectively random, their
+resulting reachability bitmaps would have no locality, and thus compress
+poorly. (This is the reason that single-pack bitmaps use the pack
+ordering, and not the .idx ordering, for the same purpose.)
+
+So we'd like to define an ordering for the whole MIDX based around
+pack ordering, which has far better locality (and thus compresses more
+efficiently). We can think of a pseudo-pack created by the concatenation
+of all of the packs in the MIDX. E.g., if we had a MIDX with three packs
+(a, b, c), with 10, 15, and 20 objects respectively, we can imagine an
+ordering of the objects like:
+
+    |a,0|a,1|...|a,9|b,0|b,1|...|b,14|c,0|c,1|...|c,19|
+
+where the ordering of the packs is defined by the MIDX's pack list,
+and then the ordering of objects within each pack is the same as the
+order in the actual packfile.
+
+Given the list of packs and their counts of objects, you can
+naïvely reconstruct that pseudo-pack ordering (e.g., the object at
+position 27 must be (c,1) because packs "a" and "b" consumed 25 of the
+slots). But there's a catch. Objects may be duplicated between packs, in
+which case the MIDX only stores one pointer to the object (and thus we'd
+want only one slot in the bitmap).
+
+Callers could handle duplicates themselves by reading objects in order
+of their bit-position, but that's linear in the number of objects, and
+much too expensive for ordinary bitmap lookups. Building a reverse index
+solves this, since it is the logical inverse of the index, and that
+index has already removed duplicates. But, building a reverse index on
+the fly can be expensive. Since we already have an on-disk format for
+pack-based reverse indexes, let's reuse it for the MIDX's pseudo-pack,
+too.
+
+Objects from the MIDX are ordered as follows to string together the
+pseudo-pack. Let `pack(o)` return the pack from which `o` was selected
+by the MIDX, and define an ordering of packs based on their numeric ID
+(as stored by the MIDX). Let `offset(o)` return the object offset of `o`
+within `pack(o)`. Then, compare `o1` and `o2` as follows:
+
+  - If one of `pack(o1)` and `pack(o2)` is preferred and the other
+    is not, then the preferred one sorts first.
++
+(This is a detail that allows the MIDX bitmap to determine which
+pack should be used by the pack-reuse mechanism, since it can ask
+the MIDX for the pack containing the object at bit position 0).
+
+  - If `pack(o1) ≠ pack(o2)`, then sort the two objects in descending
+    order based on the pack ID.
+
+  - Otherwise, `pack(o1) = pack(o2)`, and the objects are sorted in
+    pack-order (i.e., `o1` sorts ahead of `o2` exactly when `offset(o1)
+    < offset(o2)`).
+
+In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
+objects in packs stored by the MIDX, laid out in pack order, and the
+packs arranged in MIDX order (with the preferred pack coming first).
+
+Finally, note that the MIDX's reverse index is not stored as a chunk in
+the multi-pack-index itself. This is done because the reverse index
+includes the checksum of the pack or MIDX to which it belongs, which
+makes it impossible to write in the MIDX. To avoid races when rewriting
+the MIDX, a MIDX reverse index includes the MIDX's checksum in its
+filename (e.g., `multi-pack-index-xyz.rev`).
-- 
2.30.0.667.g81c0cbc6fd

