Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2E2C4320A
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66BEF6023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhG0VVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbhG0VVP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:15 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88BAC061A0A
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:42 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id u15so366437iol.13
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DgaZjkwZH1lpNVEvPcjoUrU31Lkf2j2H8M8ezDSIAqk=;
        b=kU02ZH1HqUDlXAbfUtMwRObilbcg9iNMSoccskTWs5HmUUuqyjXpSaFuWqoWa+BwVu
         PNxEZFHQb3VgM1gIh4mpePlWBIid0ZQTuTB4Zvv4FyuBtvewrr0ohlxlIIGfuz0E+NWc
         aJxUCIHLiMH1UBtBhGgsb46twSc/5Knkb5IPBxo/jVmfIoW0L6Vjv6ZnKLagENG98VcG
         bycIg837AXaznHEAhtjLE8y5ZKPmkrQ8Fd/49wS2oIB4BS8l8zAsAgfyMOeOnoeKCont
         p8TTDaKWuRYoSasuFYWpfvTuj/BeNGVxiVvsaOOo5cMkWP2I823wrX7xKMKMzRQPu0H8
         I5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DgaZjkwZH1lpNVEvPcjoUrU31Lkf2j2H8M8ezDSIAqk=;
        b=FyuMf5ICE6aK7cf5JJQ1ekfuRxkOlCIF0NVW+3rDUr6KoJzg2LT78CmGAFSP0y1oKY
         puSjUgTEwSfkpBaQzhXsZlradRhaRTJeh0yML5sUaBvR7Y002oAuuqzT/g5DvS+EsDUx
         D4h616ycXdpjeWhfK4LIvuMz7K/Bb32cnT174l+tZbq3qozyhwAOKhdS0/eCc8zIRiug
         U/ulaw+8FnP64uHF0O3aherNZQY6yxqM+hDzNY9++xPdN349S6AJyL5d7BELjFV5X2e6
         h6hqYLWBJYpEd4A4RFogTWE93dLeZWj7nsdRCjwE0iUDMKykGc7a8Uj5QCApGR3l1OvZ
         w6lw==
X-Gm-Message-State: AOAM533RRV5WEmYn4o/vg4556dBaS7bwxjJ7XG46O/1qNJY/6qO4dJg+
        ube82CBZQ/p2WFG04/8uJ90iHVPMZdTqf+dv
X-Google-Smtp-Source: ABdhPJwSYKH/khZJiPI3bfL62Tfr035CSQEqBmav89l0EgSKfGaaXK0kk01GoalCuPWRRomFDFOLiw==
X-Received: by 2002:a02:bb12:: with SMTP id y18mr22768306jan.66.1627420782101;
        Tue, 27 Jul 2021 14:19:42 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id h6sm2632120ilo.0.2021.07.27.14.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:41 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 07/25] midx: infer preferred pack when not given one
Message-ID: <53ef0a6d67469078f237e2719052ab05f642cf2a.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 9218c6a40c (midx: allow marking a pack as preferred, 2021-03-30), the
multi-pack index code learned how to select a pack which all duplicate
objects are selected from. That is, if an object appears in multiple
packs, select the copy in the preferred pack before breaking ties
according to the other rules like pack mtime and readdir() order.

Not specifying a preferred pack can cause serious problems with
multi-pack reachability bitmaps, because these bitmaps rely on having at
least one pack from which all duplicates are selected. Not having such a
pack causes problems with the code in pack-objects to reuse packs
verbatim (e.g., that code assumes that a delta object in a chunk of pack
sent verbatim will have its base object sent from the same pack).

So why does not marking a pack preferred cause problems here? The reason
is roughly as follows:

  - Ties are broken (when handling duplicate objects) by sorting
    according to midx_oid_compare(), which sorts objects by OID,
    preferred-ness, pack mtime, and finally pack ID (more on that
    later).

  - The psuedo pack-order (described in
    Documentation/technical/pack-format.txt under the section
    "multi-pack-index reverse indexes") is computed by
    midx_pack_order(), and sorts by pack ID and pack offset, with
    preferred packs sorting first.

  - But! Pack IDs come from incrementing the pack count in
    add_pack_to_midx(), which is a callback to
    for_each_file_in_pack_dir(), meaning that pack IDs are assigned in
    readdir() order.

When specifying a preferred pack, all of that works fine, because
duplicate objects are correctly resolved in favor of the copy in the
preferred pack, and the preferred pack sorts first in the object order.

"Sorting first" is critical, because the bitmap code relies on finding
out which pack holds the first object in the MIDX's pseudo pack-order to
determine which pack is preferred.

But if we didn't specify a preferred pack, and the pack which comes
first in readdir() order does not also have the lowest timestamp, then
it's possible that that pack (the one that sorts first in pseudo-pack
order, which the bitmap code will treat as the preferred one) did *not*
have all duplicate objects resolved in its favor, resulting in breakage.

The fix is simple: pick a (semi-arbitrary, non-empty) preferred pack
when none was specified. This forces that pack to have duplicates
resolved in its favor, and (critically) to sort first in pseudo-pack
order.  Unfortunately, testing this behavior portably isn't possible,
since it depends on readdir() order which isn't guaranteed by POSIX.

(Note that multi-pack reachability bitmaps have yet to be implemented;
so in that sense this patch is fixing a bug which does not yet exist.
But by having this patch beforehand, we can prevent the bug from ever
materializing.)

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/midx.c b/midx.c
index 092dbf45b6..8956492b9c 100644
--- a/midx.c
+++ b/midx.c
@@ -969,15 +969,57 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
 		goto cleanup;
 
-	ctx.preferred_pack_idx = -1;
 	if (preferred_pack_name) {
+		int found = 0;
 		for (i = 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
 						  ctx.info[i].pack_name)) {
 				ctx.preferred_pack_idx = i;
+				found = 1;
 				break;
 			}
 		}
+
+		if (!found)
+			warning(_("unknown preferred pack: '%s'"),
+				preferred_pack_name);
+	} else if (ctx.nr && (flags & MIDX_WRITE_REV_INDEX)) {
+		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
+		ctx.preferred_pack_idx = 0;
+
+		if (packs_to_drop && packs_to_drop->nr)
+			BUG("cannot write a MIDX bitmap during expiration");
+
+		/*
+		 * set a preferred pack when writing a bitmap to ensure that
+		 * the pack from which the first object is selected in pseudo
+		 * pack-order has all of its objects selected from that pack
+		 * (and not another pack containing a duplicate)
+		 */
+		for (i = 1; i < ctx.nr; i++) {
+			struct packed_git *p = ctx.info[i].p;
+
+			if (!oldest->num_objects || p->mtime < oldest->mtime) {
+				oldest = p;
+				ctx.preferred_pack_idx = i;
+			}
+		}
+
+		if (!oldest->num_objects) {
+			/*
+			 * If all packs are empty; unset the preferred index.
+			 * This is acceptable since there will be no duplicate
+			 * objects to resolve, so the preferred value doesn't
+			 * matter.
+			 */
+			ctx.preferred_pack_idx = -1;
+		}
+	} else {
+		/*
+		 * otherwise don't mark any pack as preferred to avoid
+		 * interfering with expiration logic below
+		 */
+		ctx.preferred_pack_idx = -1;
 	}
 
 	if (ctx.preferred_pack_idx > -1) {
@@ -1058,11 +1100,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 						      ctx.info, ctx.nr,
 						      sizeof(*ctx.info),
 						      idx_or_pack_name_cmp);
-
-		if (!preferred)
-			warning(_("unknown preferred pack: '%s'"),
-				preferred_pack_name);
-		else {
+		if (preferred) {
 			uint32_t perm = ctx.pack_perm[preferred->orig_pack_int_id];
 			if (perm == PACK_EXPIRED)
 				warning(_("preferred pack '%s' is expired"),
-- 
2.31.1.163.ga65ce7f831

