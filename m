Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD2C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 519CC60F4C
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 16:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhHXQQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhHXQQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 12:16:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA14C0617A8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:09 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b7so27064991iob.4
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 09:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ujhAxRiA3uR6dx4f9FN/eiaLsee3JfsYFqVjz5Ahhtc=;
        b=KkoVR0Ja92i+6UbBvbgd9fP470bLd+oSxpT8hXcZBzgwt3ziTyC2RVLRswzBTUpSv+
         QXi/y72ZSS1pLWcY8drvZ7bNlDQ6VFaV3cbKdbP4WwlhX0Az+ae7AA5vI5BFw/Zgu1MY
         mhQ6UVU5cWD5t/nWAPFMJRqLMw/ynTfJVeEhFOtQsU9O/c5n6BCcstxzqHLCq8svdy9+
         6zjykoCveSpp+f7hKD56fhyZfP4T1zARitliFWSFTg3+LR7z45EQUiZ5RsiacUpwyHIw
         0b/owSl2J3TyhCk1A9jyku6Rxy5GJ7iFzrRIfVga7YUG3FZPZE+Qq715Tp4dVG6PtLOJ
         6prQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ujhAxRiA3uR6dx4f9FN/eiaLsee3JfsYFqVjz5Ahhtc=;
        b=couFXQ9RBYLRAa8sPjE23ZbKpuB01rfoA4NouGAfGDOaVOBtmnTsrMTafm/ikeQGfQ
         HSMuyH2IvR0XrSnumgZQScDXfovEuXtgdFODb/p5xQqQpGVOPE9H7UrOqUmp6tYBKuKQ
         Ztcfl77JGN7MScDLxV4KT1G63C6s5VhB9bC16552F2PD5SZnsXDSxTowx05Qn3r/TSnC
         j/3wuDeuSwJfn1lglqV9GBy00NE09GJyF3+BKZCp2Ljnmdd1tPvZeG4+OB/z3jIOzmhN
         wq+pZ/86dEM1RWzlocyq+1QuNxjEJEA+UqYJ1BD7cU9C5vqkkC7WFEpJR/fz21jOqKjW
         GAMA==
X-Gm-Message-State: AOAM533ECFyDfdMf4DGVp0K3I0mirWiRu9FqYb7uAtkrj9fm63Nb4kKX
        03Yk31On0hojM1ZUu5d1N/32ynFO9gH69mOS
X-Google-Smtp-Source: ABdhPJyvQGTq/CUE8ogVu7JinTu3z0iIfRwM86ovT8d+Da6fuFXw2HM0AYTJnHWOQmpFUJCqqmh9Bg==
X-Received: by 2002:a02:1cc5:: with SMTP id c188mr35617959jac.46.1629821768316;
        Tue, 24 Aug 2021 09:16:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s7sm10263867ioc.42.2021.08.24.09.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:16:07 -0700 (PDT)
Date:   Tue, 24 Aug 2021 12:16:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v4 07/25] midx: infer preferred pack when not given one
Message-ID: <31f4517de0bc188a7b0d53e6092dde82c4b2855a.1629821743.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1629821743.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1629821743.git.me@ttaylorr.com>
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
index 551e5c2ee5..e5b17483af 100644
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

