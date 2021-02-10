Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F26C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C3E60238
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 23:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbhBJXEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhBJXDz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 18:03:55 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EEAC061756
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:03:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id w20so2907283qta.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 15:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GO+/MaJhqNMc6Vq2gvQI6+qn9o0YJhq46OdH2wbWPzM=;
        b=IVGJh102SXWA3RpaD5ondhVo0/l6LgSPtTu9uLCB9byWukcTu4B+C9En178oSkXV11
         td+e8ogo6EuTLGF7Q5GO/9sVwXV7BHv04tTm0J1/yGqZ+HGpVgQWUfvNkaPEDKWp+nq/
         AGroSaMFh1UHY0hGRlPX8tDLk5TtMHUxNo34/AdMNJyqf1/eSQjaY2QseMzTNgoxooo5
         ZGP7ts2lSNOjpjGDde2D4jQ0k2GcrzzcvZ8s8ae1KPzeh31non0CXAZkBYl3z4+nYJiH
         PO5qE0N/xaOsB4PkJiOPZVbJkKPH3K59s6pnPtIMdupuSZLsHekDBxMw1KJFOSrOHbEw
         iG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GO+/MaJhqNMc6Vq2gvQI6+qn9o0YJhq46OdH2wbWPzM=;
        b=hvJ5AfcOhg/g/eTCcdN9g6DtyRruc1PVreX6xvDC8d+rykugykbTj/sM+kvkX1BX4H
         ifYg9XZPilRB0j002D4SwK5b0nU0PwTdKl3ZP2xpnDWSF05Kjtdt2NnDi0x869JJxsrb
         g/Rpx00anYHcMNy6g2oVUszJW6oSIlUl8XlWPvNcxM8WBGCruFvqCgyyOW+JfmVmpgyg
         oN01nKss88KMAplOatQdfHA3I5cZikOqHtUehO6QOUszufFG95gerMjWsG+lpba62Lga
         k8OhrlJP+aRYqOpgXjZJFgN1Ihbq7Ba6OoY3xvvpFaMIKIW16mdMUql+2nem8+D7rq3J
         abIw==
X-Gm-Message-State: AOAM532ypvgDF7kAfRd5DqeMgb969zkW+3qtBDVhwFuSGD4wm90hJpjJ
        V/IgklOsJsGKbFNtfXMCOBE6d6DwL2g1ijhY
X-Google-Smtp-Source: ABdhPJzsChOtVD1iyjmHdD3+9xK+JgKGKPhS5tmrwvPtrVOZtF1x9Kh5Qz89f80BYrUcTe8iFL4Jpg==
X-Received: by 2002:a05:622a:42:: with SMTP id y2mr4909937qtw.186.1612998194025;
        Wed, 10 Feb 2021 15:03:14 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:2c3d:3179:bfad:c65])
        by smtp.gmail.com with ESMTPSA id w38sm2308855qth.79.2021.02.10.15.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 15:03:13 -0800 (PST)
Date:   Wed, 10 Feb 2021 18:03:11 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 6/9] Documentation/technical: describe multi-pack reverse
 indexes
Message-ID: <e64504bad6e181522946a8f234e12f569bede89e.1612998106.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
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
index 8833b71c8b..a14722f119 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -376,3 +376,86 @@ CHUNK DATA:
 TRAILER:
 
 	Index checksum of the above contents.
+
+== multi-pack-index reverse indexes
+
+Similar to the pack-based reverse index, the multi-pack index can also
+be used to generate a reverse index.
+
+Instead of mapping between offset, pack-, and index position, this
+reverse index maps between an object's position within the midx, and
+that object's position within a pseudo-pack that the midx describes.
+Crucially, the objects' positions within this pseudo-pack are the same
+as their bit positions in a multi-pack reachability bitmap.
+
+As a motivating example, consider the multi-pack reachability bitmap
+(which does not yet exist, but is what we are building towards here). We
+need each bit to correspond to an object covered by the midx, and we
+need to be able to convert bit positions back to index positions (from
+which we can get the oid, etc).
+
+One solution is to let each bit position in the index correspond to
+the same position in the oid-sorted index stored by the midx. But
+because oids are effectively random, there resulting reachability
+bitmaps would have no locality, and thus compress poorly. (This is the
+reason that single-pack bitmaps use the pack ordering, and not the .idx
+ordering, for the same purpose.)
+
+So we'd like to define an ordering for the whole midx based around
+pack ordering. We can think of it as a pseudo-pack created by the
+concatenation of all of the packs in the midx. E.g., if we had a midx
+with three packs (a, b, c), with 10, 15, and 20 objects respectively, we
+can imagine an ordering of the objects like:
+
+    |a,0|a,1|...|a,9|b,0|b,1|...|b,14|c,0|c,1|...|c,19|
+
+where the ordering of the packs is defined by the midx's pack list,
+and then the ordering of objects within each pack is the same as the
+order in the actual packfile.
+
+Given the list of packs and their counts of objects, you can
+na&iuml;vely reconstruct that pseudo-pack ordering (e.g., the object at
+position 27 must be (c,1) because packs "a" and "b" consumed 25 of the
+slots). But there's a catch. Objects may be duplicated between packs, in
+which case the midx only stores one pointer to the object (and thus we'd
+want only one slot in the bitmap).
+
+Callers could handle duplicates themselves by reading objects in order
+of their bit-position, but that's linear in the number of objects, and
+much too expensive for ordinary bitmap lookups. Building a reverse index
+solves this, since it is the logical inverse of the index, and that
+index has already removed duplicates. But, building a reverse index on
+the fly can be expensive. Since we already have an on-disk format for
+pack-based reverse indexes, let's reuse it for the midx's pseudo-pack,
+too.
+
+Objects from the midx are ordered as follows to string together the
+pseudo-pack. Let _pack(o)_ return the pack from which _o_ was selected
+by the midx, and define an ordering of packs based on their numeric ID
+(as stored by the midx). Let _offset(o)_ return the object offset of _o_
+within _pack(o)_. Then, compare _o~1~_ and _o~2~_ as follows:
+
+  - If one of _pack(o~1~)_ and _pack(o~2~)_ is preferred and the other
+    is not, then the preferred one sorts first.
++
+(This is a detail that allows the midx bitmap to determine which
+pack should be used by the pack-reuse mechanism, since it can ask
+the midx for the pack containing the object at bit position 0).
+
+  - If _pack(o~1~) &ne; pack(o~2~)_, then sort the two objects in
+    descending order based on the pack ID.
+
+  - Otherwise, _pack(o~1~) &equals; pack(o~2~)_, and the objects are
+    sorted in pack-order (i.e., _o~1~_ sorts ahead of _o~2~_ exactly
+    when _offset(o~1~) &lt; offset(o~2~)_).
+
+In short, a midx's pseudo-pack is the de-duplicated concatenation of
+objects in packs stored by the midx, laid out in pack order, and the
+packs arranged in midx order (with the preferred pack coming first).
+
+Finally, note that the midx's reverse index is not stored as a chunk in
+the multi-pack-index itself. This is done because the reverse index
+includes the checksum of the pack or midx to which it belongs, which
+makes it impossible to write in the midx. To avoid races when rewriting
+the midx, a midx reverse index includes the midx's checksum in its
+filename (e.g., `multi-pack-index-xyz.rev`).
-- 
2.30.0.667.g81c0cbc6fd

