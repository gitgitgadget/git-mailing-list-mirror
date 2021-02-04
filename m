Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB1FC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB38A64DA5
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhBDEB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 23:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhBDEAa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 23:00:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022C4C06178B
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:59:21 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e15so1497877qte.9
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kltz0CfZM+ZPDVqad9MFV27j48nFy4kC61jUEBQm07Y=;
        b=UODXQdrn/+PI+kK2U4QGIhoEPUHGqu5Kmbs9L01QqaFByAqc80GxG3IMkdQ1pgtSm3
         a5kEldzm5aB5ovDjrCOPybH9UNh+FdgAWsmh2kPrf46x8qqJkPpT1YwkTX+P/6a7JZJG
         Tydk1BdBjqrbwdfJAOUcAFYo64tU0Vtq+Tz9qLGOZkShHzVZpI1GWlBgCWzEPEviCKzw
         pPkwJeCh6Ka+5kx5j91qgN7R800p8M2Mugj7X7a7IvSaIlTZsmZoyvEe+7/l7P8hLRmr
         Ci60k44OIgfsLZ/RlOO/E7SrAZrhjoYsh0da6/8LJ4LeAQ/Yt2Tt/xXEvP0oXNIaHSc3
         uA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kltz0CfZM+ZPDVqad9MFV27j48nFy4kC61jUEBQm07Y=;
        b=RFt9aaLhm+iaazApGNX9FEPzlBG7/wDgM76EhY0b0PHKlYHVQ1R9EK17sLtFWedu/Y
         jNdmkvqWAT8yAyw5MGDJWHIsdOQPDML7Xj4O6JZQGvBKg4iZ9OnZ7HKKEmIqw2migTvE
         0W+BExMGVa3gW+8crHMCYEJ9ybs1EtyjoS5F33Gs0M9KM+Og/3mP12sFjTiXLrXn+1J7
         S5QtM/7fCtZgJb/hvmfyhfHPxBTPuNOLWnobrVVY//NwdO9FL9BLdDBRwIgQ+cjoVEjW
         HN4HQ+JEGLtXvulgSGSKgVYrPp+y4GpKzd02ip9+4I9Q86Qts8oNpn90xg59T3upbGzQ
         /sFg==
X-Gm-Message-State: AOAM530WnQkwbtkxTlcbg+5A688r3XEhxbiWESRFkjHFS+UtxD5k7dMV
        zyXs/qb/RaIt5pIpmeSrShL5sBkxzpLGPQ==
X-Google-Smtp-Source: ABdhPJy6LcSfVdNLJaKUUCAZqGAwlKr7lobZeWosBGhsIE/BAmgvpsqGuwO+E0xo8H36JXxWAMQuXA==
X-Received: by 2002:ac8:598e:: with SMTP id e14mr5753857qte.346.1612411159945;
        Wed, 03 Feb 2021 19:59:19 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id m64sm4063119qkb.90.2021.02.03.19.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:59:19 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:59:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 6/8] builtin/pack-objects.c: rewrite honor-pack-keep logic
Message-ID: <c3868c7df92484f0527ce500ad1156275be334e8.1612411124.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612411123.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Now that we have find_kept_pack_entry(), we don't have to manually keep
hunting through every pack to find a possible "kept" duplicate of the
object. This should be faster, assuming only a portion of your total
packs are actually kept.

Note that we have to re-order the logic a bit here; we can deal with the
"kept" situation completely, and then just fall back to the "--local"
question. It might be worth having a similar optimized function to look
at only local packs.

Here are the results from p5303 (measurements again taken on the
kernel):

  Test                                        HEAD^                    HEAD
  -----------------------------------------------------------------------------------------------
  5303.5: repack (1)                          57.42(54.88+10.64)       57.44(54.71+10.78) +0.0%
  5303.6: repack with --stdin-packs (1)       0.01(0.01+0.00)          0.01(0.00+0.01) +0.0%
  5303.10: repack (50)                        71.26(88.24+4.96)        71.32(88.38+4.90) +0.1%
  5303.11: repack with --stdin-packs (50)     3.49(11.82+0.28)         3.43(11.81+0.22) -1.7%
  5303.15: repack (1000)                      215.64(491.33+14.80)     215.59(493.75+14.62) -0.0%
  5303.16: repack with --stdin-packs (1000)   198.79(380.51+7.97)      131.44(314.24+8.11) -33.9%

So our --stdin-packs case with many packs is now finally faster than the
non-keep case (because it gets the speed benefit of looking at fewer
objects, but not as big a penalty for looking at many packs).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 125 ++++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 52 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d19eb000a..fbd7b54d70 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1188,7 +1188,8 @@ static int have_duplicate_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int want_found_object(int exclude, struct packed_git *p)
+static int want_found_object(const struct object_id *oid, int exclude,
+			     struct packed_git *p)
 {
 	if (exclude)
 		return 1;
@@ -1209,22 +1210,73 @@ static int want_found_object(int exclude, struct packed_git *p)
 	 * Otherwise, we signal "-1" at the end to tell the caller that we do
 	 * not know either way, and it needs to check more packs.
 	 */
-	if (!ignore_packed_keep_on_disk &&
-	    !ignore_packed_keep_in_core &&
-	    (!local || !have_non_local_packs))
+
+	/*
+	 * Handle .keep first, as we have a fast(er) path there.
+	 */
+	if (ignore_packed_keep_on_disk || ignore_packed_keep_in_core) {
+		/*
+		 * Set the flags for the kept-pack cache to be the ones we want
+		 * to ignore.
+		 *
+		 * That is, if we are ignoring objects in on-disk keep packs,
+		 * then we want to search through the on-disk keep and ignore
+		 * the in-core ones.
+		 */
+		unsigned flags = 0;
+		if (ignore_packed_keep_on_disk)
+			flags |= ON_DISK_KEEP_PACKS;
+		if (ignore_packed_keep_in_core)
+			flags |= IN_CORE_KEEP_PACKS;
+
+		if (ignore_packed_keep_on_disk && p->pack_keep)
+			return 0;
+		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
+			return 0;
+		if (has_object_kept_pack(oid, flags))
+			return 0;
+	}
+
+	/*
+	 * At this point we know definitively that either we don't care about
+	 * keep-packs, or the object is not in one. Keep checking other
+	 * conditions...
+	 */
+
+	if (!local || !have_non_local_packs)
 		return 1;
-
 	if (local && !p->pack_local)
 		return 0;
-	if (p->pack_local &&
-	    ((ignore_packed_keep_on_disk && p->pack_keep) ||
-	     (ignore_packed_keep_in_core && p->pack_keep_in_core)))
-		return 0;
 
 	/* we don't know yet; keep looking for more packs */
 	return -1;
 }
 
+static int want_object_in_pack_one(struct packed_git *p,
+				   const struct object_id *oid,
+				   int exclude,
+				   struct packed_git **found_pack,
+				   off_t *found_offset)
+{
+	off_t offset;
+
+	if (p == *found_pack)
+		offset = *found_offset;
+	else
+		offset = find_pack_entry_one(oid->hash, p);
+
+	if (offset) {
+		if (!*found_pack) {
+			if (!is_pack_valid(p))
+				return -1;
+			*found_offset = offset;
+			*found_pack = p;
+		}
+		return want_found_object(oid, exclude, p);
+	}
+	return -1;
+}
+
 /*
  * Check whether we want the object in the pack (e.g., we do not want
  * objects found in non-local stores if the "--local" option was used).
@@ -1252,7 +1304,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	 * are present we will determine the answer right now.
 	 */
 	if (*found_pack) {
-		want = want_found_object(exclude, *found_pack);
+		want = want_found_object(oid, exclude, *found_pack);
 		if (want != -1)
 			return want;
 	}
@@ -1260,53 +1312,22 @@ static int want_object_in_pack(const struct object_id *oid,
 	for (m = get_multi_pack_index(the_repository); m; m = m->next) {
 		struct pack_entry e;
 		if (fill_midx_entry(the_repository, oid, &e, m)) {
-			struct packed_git *p = e.p;
-			off_t offset;
-
-			if (p == *found_pack)
-				offset = *found_offset;
-			else
-				offset = find_pack_entry_one(oid->hash, p);
-
-			if (offset) {
-				if (!*found_pack) {
-					if (!is_pack_valid(p))
-						continue;
-					*found_offset = offset;
-					*found_pack = p;
-				}
-				want = want_found_object(exclude, p);
-				if (want != -1)
-					return want;
-			}
-		}
-	}
-
-	list_for_each(pos, get_packed_git_mru(the_repository)) {
-		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		off_t offset;
-
-		if (p == *found_pack)
-			offset = *found_offset;
-		else
-			offset = find_pack_entry_one(oid->hash, p);
-
-		if (offset) {
-			if (!*found_pack) {
-				if (!is_pack_valid(p))
-					continue;
-				*found_offset = offset;
-				*found_pack = p;
-			}
-			want = want_found_object(exclude, p);
-			if (!exclude && want > 0)
-				list_move(&p->mru,
-					  get_packed_git_mru(the_repository));
+			want = want_object_in_pack_one(e.p, oid, exclude, found_pack, found_offset);
 			if (want != -1)
 				return want;
 		}
 	}
 
+	list_for_each(pos, get_packed_git_mru(the_repository)) {
+		struct packed_git *p = list_entry(pos, struct packed_git, mru);
+		want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset);
+		if (!exclude && want > 0)
+			list_move(&p->mru,
+				  get_packed_git_mru(the_repository));
+		if (want != -1)
+			return want;
+	}
+
 	if (uri_protocols.nr) {
 		struct configured_exclusion *ex =
 			oidmap_get(&configured_exclusions, oid);
-- 
2.30.0.533.g2f8b6b552f.dirty

