Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBCCC433E9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAAF264FF9
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhCKRFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 12:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhCKRF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 12:05:29 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AD4C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:29 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y20so4361470iot.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G/wg4ROlEWl9gs4TbtB1/b/GUqHGdO2QzRK4YRW/sMs=;
        b=KEUpTeUZIbrL3CPpXFN7bKsYvLEtkNeS+2+aJvkr4RoKxfpLcDWOO7FlMEyUzs0nDF
         jCHsmmWAAE4D1YpjwacNla4GCWJqU9pwAF5iJ53r65dKmilQ01W70vpo1mU7/1g/xFYm
         BDWwCNUxAGXMHq9y8dXnLDM8Gjj52LqfeBQjs0yuzz38eZzewsPVgWbBx00fIrU2hKJF
         4+9VD6ES6FuqmCiHsa62/Y8lpYPmHQ36kTq2WxuS+J67tkcRR8v62XeCtdtFYMSLDU1y
         gA0rTnHA9PFnbHf2i8NhWadPfm1AR6HCmmmsehwaq9dNrJ5YK0fexOSEZPMISLW7Ykc+
         Vj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G/wg4ROlEWl9gs4TbtB1/b/GUqHGdO2QzRK4YRW/sMs=;
        b=D9jt42UVdP6dAbm7g0k9j3MhKQ/4YnJMCit72bfE5Ta+ajj7icq2ddN52kJv+UcFwn
         ZSCtws/R4Vs7TzRVFCwowpE7sV6shnuAraPTRGDa//XGRF7xK+qEb6iXT1Oc51KrPLiy
         vM8XwzZvSc0otRlR8gN44BUg/qQzJnIjt7telFK6uC0uig3dYOpAUz+vyU2AhmuNkZzk
         iMhku87weW2C5PTNjbxWd0vlS5bjNNmJs3XltxJK2jRHx1L/maxMN/gwbjSLq5em6oUc
         gPa6roWtcnEW2iUnSWRn7XAR00XONqErtkvqu74dbyHzlVTqE9G8IfuwvgCCOC9ENs8i
         seFQ==
X-Gm-Message-State: AOAM533UqxQVxnwMZMXCUae+tfwFV8mcIPs6Oul4aoWWqcq0tEWEy1B0
        BG94SOU53owqrxUCx+zQPcExL1VqW5oHzI6M
X-Google-Smtp-Source: ABdhPJwVggTGd+1eH6JVFmJdiGafkVyyhSW1I+U9AWXsMGnUSLHBMOaXQwCC9wOfhr661awScuTNrQ==
X-Received: by 2002:a02:7086:: with SMTP id f128mr4578993jac.104.1615482328065;
        Thu, 11 Mar 2021 09:05:28 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f947:1686:6ada:db5b])
        by smtp.gmail.com with ESMTPSA id w9sm1724537iox.20.2021.03.11.09.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:05:27 -0800 (PST)
Date:   Thu, 11 Mar 2021 12:05:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com, peff@peff.net
Subject: [PATCH v3 12/16] Documentation/technical: describe multi-pack
 reverse indexes
Message-ID: <4745bb8590f5cdc24445618dd63ba6bd541227b4.1615482270.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1615482270.git.me@ttaylorr.com>
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
index 1faa949bf6..4bbbb188a4 100644
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
+index stored by the MIDX. But because oids are effectively random, there
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
+na&iuml;vely reconstruct that pseudo-pack ordering (e.g., the object at
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
+pseudo-pack. Let _pack(o)_ return the pack from which _o_ was selected
+by the MIDX, and define an ordering of packs based on their numeric ID
+(as stored by the MIDX). Let _offset(o)_ return the object offset of _o_
+within _pack(o)_. Then, compare _o~1~_ and _o~2~_ as follows:
+
+  - If one of _pack(o~1~)_ and _pack(o~2~)_ is preferred and the other
+    is not, then the preferred one sorts first.
++
+(This is a detail that allows the MIDX bitmap to determine which
+pack should be used by the pack-reuse mechanism, since it can ask
+the MIDX for the pack containing the object at bit position 0).
+
+  - If _pack(o~1~) &ne; pack(o~2~)_, then sort the two objects in
+    descending order based on the pack ID.
+
+  - Otherwise, _pack(o~1~) &equals; pack(o~2~)_, and the objects are
+    sorted in pack-order (i.e., _o~1~_ sorts ahead of _o~2~_ exactly
+    when _offset(o~1~) &lt; offset(o~2~)_).
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

