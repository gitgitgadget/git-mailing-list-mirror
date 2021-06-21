Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F6C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 553B860FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhFUW1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhFUW1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB483C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:22 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v3so11906085ioq.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+CjsrtEcOwfai2FUxrt0cxDisW48GdkbzD4CCPCcdoU=;
        b=our3WhcTjI//SSoFojhht0o3/r2kzb/hc0g6YDwTNFcY+zt4xb/OT9zbk9rE+FcsMF
         ejXBC/nloxOTU9ox9QH0ZvDMXLH5FQ5V3BL8j7TaLMLM6ARhdtf6Wuj4nokSMPyGJ2TH
         AfCJO1r0VIwJBF0PT5wBtUlHu5l+73iyNnPrcOe2l2UrXBhGVJypPHc/cfKV1fvPGIfr
         FLiiPvRqc41p1jXeWfJWSo2c6lSNHC8lXJPMNN8cFNqh1V7gLn1b+1wC/7WMq0HgCWLW
         /ZN3uwoeMR176JtmCeq9H4Oj6LV7CnF5aQ3yJsPN1ZN/XmhqrmXV2CvDWrNLSsqHU6kq
         UjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+CjsrtEcOwfai2FUxrt0cxDisW48GdkbzD4CCPCcdoU=;
        b=HQdsgCscYZossIicUmunA5GQCafNjZB+jlRI0gAg5z+RLXz0Xn8KtPYpIlYcVIpD4o
         yBBKVR/A8JcvhCTw/wIWGwzGr0FMBweqlcl96+ZZzIUVjM3x54A2HcDWTbO2b7J7K2DO
         BprwdU5v/tq5ecEJdGY0G5s6s92OEZipoLfZ+aOPQQlD2lexhQZcc8YCuQeywQ/y1daS
         hki3y3bS1rf0QdK5SkTUVU0ad1EtInvWVv+WB35tnNcuZ+2vSKKnq1z9XkeNaTinwNhl
         Zj0VQmU7rfbH1JpfEJ8LOZubg43i4V3FwvnKn5PXjl8UVtB9OhZhIrUg4qUDq2MAEo38
         iVog==
X-Gm-Message-State: AOAM530S4g1Nxngqgke65/oCJ42aTccRWibZAzLHL5V7i4cRYqOZzxBd
        5MhEmBNmJSZHHaShXE9siOGqXAcNI8SiZq4o
X-Google-Smtp-Source: ABdhPJz2JvUcsYiOAJ3EJS/bdEBYcp5oXNc1fbFgoFTxz3jve6WEetuk2/1tsjpIHSx1e2lZSqPTGg==
X-Received: by 2002:a05:6638:379d:: with SMTP id w29mr685636jal.2.1624314322133;
        Mon, 21 Jun 2021 15:25:22 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id b23sm10681457ior.4.2021.06.21.15.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:21 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 09/24] midx: infer preferred pack when not given one
Message-ID: <9495f6869d792264c4366c9914fcf93d544caa6a.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
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
pack causes problems with the pack reuse code (e.g., like assuming that
a base object was sent from that pack via reuse when in fact the base
was selected from a different pack).

So why does not marking a pack preferred cause problems here? The reason
is roughly as follows:

  - Ties are broken (when handling duplicate objects) by sorting
    according to midx_oid_compare(), which sorts objects by OID,
    preferred-ness, pack mtime, and finally pack ID (more on that
    later).

  - The psuedo pack-order (described in
    Documentation/technical/bitmap-format.txt) is computed by
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

The fix is simple: pick a (semi-arbitrary) preferred pack when none was
specified. This forces that pack to have duplicates resolved in its
favor, and (critically) to sort first in pseudo-pack order.
Unfortunately, testing this behavior portably isn't possible, since it
depends on readdir() order which isn't guaranteed by POSIX.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/midx.c b/midx.c
index 759007d5a8..752d36c57f 100644
--- a/midx.c
+++ b/midx.c
@@ -950,15 +950,46 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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
+		time_t oldest = ctx.info[0].p->mtime;
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
+			time_t mtime = ctx.info[i].p->mtime;
+			if (mtime < oldest) {
+				oldest = mtime;
+				ctx.preferred_pack_idx = i;
+			}
+		}
+	} else {
+		/*
+		 * otherwise don't mark any pack as preferred to avoid
+		 * interfering with expiration logic below
+		 */
+		ctx.preferred_pack_idx = -1;
 	}
 
 	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
@@ -1029,11 +1060,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
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

