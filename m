Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671BCC433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3692310C
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 23:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbhASX0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 18:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbhASXZV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 18:25:21 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F5FC061793
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:24 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id f26so23712790qka.0
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 15:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aPDrjFjNEwfv2F37kqrg1fAr9zjOV3xwkzP+vCH7HBo=;
        b=EQKctxDZRDbIkvh1WiXZdZgn8dskO+eARDk3H8FL8GIrhzDMsINOB37kCWsqleT+Sv
         axsB3NDLxogLQkpbv3JUca8k+tH/xnWbN/JptVCW4ZTcStlLCnDxHv8xmoghVvSLLXBV
         Z4SC4NtnNH6IqFBvCG4potWSOPCVNmU7WnEIPQtA4eERQFNnczh4yuak7AT79JpcpSxo
         TiAFjW3Y1GNlvjBwUIbdyu8wKLIeORcQtz4T9NggF08yFTb1OvdsfAQw0f0sv07pzDJa
         qSmK1H/lLTNcdpLDSeLXpstFfXUuyI82KZPBcwj8zFWLO/E0rjan51/zFbvfrUckMeio
         OX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aPDrjFjNEwfv2F37kqrg1fAr9zjOV3xwkzP+vCH7HBo=;
        b=fdMWd9ee40DFsLF5uijnqC7OiXmhPiWN1Q6fXaEcWjZNAR/SnsJ0X32jcK128D+EWA
         wXoPMuDIorgvzQiB4l4ZoQiXIvXCGlijel/R4sz01lPmQPzbXl0IrsyLXA4hrfPDcw4C
         pm/W2eQfLh/YX5ltkeIWsr9bv+n3onzCjk2Lc0x9g1UheFL1i9KcN8xtOm9nHGTtI2o3
         CO7B5CSF22NjbsQhX2BoirzvLzshCl0A/lRtSOe+Z1uR66bC8GdwynzmG6cOgx501ShN
         68KHxezO2s2iYnUxZhoYPHxiZ8giKcsvnpkmh69FGiJF8kOdoG9m/LPSidDsOBzu9m6t
         aN2w==
X-Gm-Message-State: AOAM531CEG7vKDpaiU6hnseoTcrouC/J6FZxg+vc6PshZ4FjNu256Tnz
        /Et1T/uHi7rf97Onb1E4XCofmpmb7n2xZQ==
X-Google-Smtp-Source: ABdhPJxYmTnSjOgkRSAXKykPCiP6ZSTzs+iPOWEdFFz73fAn7Xg1XFlT7BSSi3qyhwSEGM965PGtBw==
X-Received: by 2002:a05:620a:788:: with SMTP id 8mr6892850qka.224.1611098663778;
        Tue, 19 Jan 2021 15:24:23 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:ed38:94a5:e78e:2d58])
        by smtp.gmail.com with ESMTPSA id w42sm115717qtw.22.2021.01.19.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 15:24:23 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:24:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 06/10] pack-objects: rewrite honor-pack-keep logic
Message-ID: <4dd5076fcc94fca906b1e5471f08288b4d225cab.1611098616.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1611098616.git.me@ttaylorr.com>
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

Here are the results from p5303 (measurements taken on git.git):

  Test                               HEAD^                  HEAD
  ------------------------------------------------------------------------------------
  5303.5: repack (1)                 57.29(54.88+10.39)     56.87(54.63+10.48) -0.7%
  5303.6: repack with keep (1)       1.25(1.19+0.05)        1.26(1.19+0.06) +0.8%
  5303.10: repack (50)               89.71(132.78+6.14)     89.35(132.42+6.25) -0.4%
  5303.11: repack with keep (50)     6.92(26.93+0.58)       6.73(26.61+0.59) -2.7%
  5303.15: repack (1000)             217.14(493.76+15.29)   217.25(494.38+15.24) +0.1%
  5303.16: repack with keep (1000)   209.46(387.83+8.42)    133.12(311.80+8.44) -36.4%

So our case with many packs and a .keep is finally now faster than the
non-keep case (because it gets the speed benefit of looking at fewer
objects, but not as big a penalty for looking at many packs).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 125 ++++++++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 52 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a5dcd66f52..c84642df98 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1178,7 +1178,8 @@ static int have_duplicate_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int want_found_object(int exclude, struct packed_git *p)
+static int want_found_object(const struct object_id *oid, int exclude,
+			     struct packed_git *p)
 {
 	if (exclude)
 		return 1;
@@ -1199,22 +1200,73 @@ static int want_found_object(int exclude, struct packed_git *p)
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
@@ -1242,7 +1294,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	 * are present we will determine the answer right now.
 	 */
 	if (*found_pack) {
-		want = want_found_object(exclude, *found_pack);
+		want = want_found_object(oid, exclude, *found_pack);
 		if (want != -1)
 			return want;
 	}
@@ -1250,53 +1302,22 @@ static int want_object_in_pack(const struct object_id *oid,
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
2.30.0.138.g6d7191ea01

