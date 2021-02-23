Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F495C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9A164E41
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhBWC0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhBWC0X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 21:26:23 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA85C061793
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:23 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id v206so14876760qkb.3
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c5LrHyS6VOi9YEihFiTzV6206Yy2BvjhlxUxDUojloM=;
        b=mTh0EttW7cbQEnXQFVtCovtPCaDIGD4qiz8m0Y6a37XQBe84Sw2L35LKBUKsu6ahvk
         /bcgj4VLAxdW5qInlOeNWMXhpJvFq4M2NEuiy/HfYk3fMAxUs+8wdGa6mMUxTQw5utVy
         CT8GO3kJOCSPK+CJDeKnHHeJ64W8eXn79Rrb1LcOjanp/KQqlP7TiAmTbV1iaOZFR1pt
         l5E3rDMCYqSNhcMV11DX4O5/9hQKX1SwxFFGO29LZnsr1CRApRLEFs7Qowee/1Lja82i
         wppKhQbuZ+YgKMQnyGAvO5LU6lyU3sg5M/mqVtIW5evasNEaJ5WhzEfxguoURczaeB36
         GYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c5LrHyS6VOi9YEihFiTzV6206Yy2BvjhlxUxDUojloM=;
        b=TGPuukXkg9oNw80pT3T9AtkA+IRw8zaHtpfUt+mdfh0qX8EVUt8birAjKYy9+lb8s5
         Px873x9Jv7kpNb7Gc3WHLSVk6G3FSeIHCR6zeZfk9U9xPJ/1XI76d628CwmYr6UjVudW
         QqyCom+NRLd4YKnldnimnaurM6kFXUbLcGLAoXU2ppRJUkis2BmlddpsijasSscWBqWY
         7jOk2dGNMBvyrsaVSvPfoT3GwnbV+yER+cMoWdDjI5+vfwixKALLaEV8zSYtw+BrNIz7
         viwSKBy6KuIy6p/gfwzisom6Z+bzBOJmVFIyYlQ36ORb76zxFs5oNDho83WLgNIVyQ5b
         u28g==
X-Gm-Message-State: AOAM531+y0DlDcd8ea7VgPJZ36D/Tx2MmBPeXKbOxOCc6z0SXhF2h9Fn
        wPwGqbkSORlDYrj7qxKjeJAGS5k08zFOP3rd
X-Google-Smtp-Source: ABdhPJz0kiNykpMCP8alIHaoS7IKemIzrJQvPfRK2wQ/yHUBZI9+zDlEXXeMnfbhU+ZJWVco7M9/MQ==
X-Received: by 2002:ae9:f812:: with SMTP id x18mr22570922qkh.377.1614047122289;
        Mon, 22 Feb 2021 18:25:22 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id b20sm12470587qto.45.2021.02.22.18.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:25:21 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:25:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v4 6/8] builtin/pack-objects.c: rewrite honor-pack-keep logic
Message-ID: <a116587fb2b7f6484b9206de68ff66d10bb2a2a2.1614047097.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614047097.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Now that we have find_kept_pack_entry(), we don't have to manually keep
hunting through every pack to find a possible "kept" duplicate of the
object. This should be faster, assuming only a portion of your total
packs are actually kept.

Note that we have to re-order the logic a bit here; we can deal with the
disqualifying situations first (e.g., finding the object in a non-local
pack with --local), then "kept" situation(s), and then just fall back to
other "--local" conditions.

Here are the results from p5303 (measurements again taken on the
kernel):

  Test                                        HEAD^                   HEAD
  -----------------------------------------------------------------------------------------------
  5303.5: repack (1)                          57.26(54.59+10.84)      57.34(54.66+10.88) +0.1%
  5303.6: repack with kept (1)                57.33(54.80+10.51)      57.38(54.83+10.49) +0.1%
  5303.11: repack (50)                        71.54(88.57+4.84)       71.70(88.99+4.74) +0.2%
  5303.12: repack with kept (50)              85.12(102.05+4.94)      72.58(89.61+4.78) -14.7%
  5303.17: repack (1000)                      216.87(490.79+14.57)    217.19(491.72+14.25) +0.1%
  5303.18: repack with kept (1000)            665.63(938.87+15.76)    246.12(520.07+14.93) -63.0%

and the --stdin-packs timings:

  5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)         0.00(0.00+0.00) -100.0%
  5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)        3.43(11.75+0.24) -2.8%
  5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)     130.50(307.15+7.66) -33.4%

So our repack with an empty .keep pack is roughly as fast as one without
a .keep pack up to 50 packs. But the --stdin-packs case scales a little
better, too.

Notably, it is faster than a repack of the same size and a kept pack. It
looks at fewer objects, of course, but the penalty for looking at many
packs isn't as costly.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 131 ++++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 53 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6ee8e40665..8cb32763b7 100644
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
@@ -1204,27 +1205,82 @@ static int want_found_object(int exclude, struct packed_git *p)
 	 * make sure no copy of this object appears in _any_ pack that makes us
 	 * to omit the object, so we need to check all the packs.
 	 *
-	 * We can however first check whether these options can possible matter;
+	 * We can however first check whether these options can possibly matter;
 	 * if they do not matter we know we want the object in generated pack.
 	 * Otherwise, we signal "-1" at the end to tell the caller that we do
 	 * not know either way, and it needs to check more packs.
 	 */
-	if (!ignore_packed_keep_on_disk &&
-	    !ignore_packed_keep_in_core &&
-	    (!local || !have_non_local_packs))
-		return 1;
 
+	/*
+	 * Objects in packs borrowed from elsewhere are discarded regardless of
+	 * if they appear in other packs that weren't borrowed.
+	 */
 	if (local && !p->pack_local)
 		return 0;
-	if (p->pack_local &&
-	    ((ignore_packed_keep_on_disk && p->pack_keep) ||
-	     (ignore_packed_keep_in_core && p->pack_keep_in_core)))
-		return 0;
+
+	/*
+	 * Then handle .keep first, as we have a fast(er) path there.
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
+	if (!local || !have_non_local_packs)
+		return 1;
 
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
@@ -1252,7 +1308,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	 * are present we will determine the answer right now.
 	 */
 	if (*found_pack) {
-		want = want_found_object(exclude, *found_pack);
+		want = want_found_object(oid, exclude, *found_pack);
 		if (want != -1)
 			return want;
 	}
@@ -1260,53 +1316,22 @@ static int want_object_in_pack(const struct object_id *oid,
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
2.30.0.667.g81c0cbc6fd

