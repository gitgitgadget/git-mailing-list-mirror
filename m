Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E4EC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0C6146D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBRDPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhBRDPj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:15:39 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE6C06178B
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:36 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 2so345660qvd.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J5a4ml0WAk4pr9Z82hPYk8r78Ylqi8uXBMPpVDXCN4w=;
        b=Xrd75j6XOgGg+Db1ZaeOtAD9Pks6kNbGgxe3ce6juEogeXbc8jrgITtpnO01t+ASoI
         RMIdbSYCd7aYRzeXSUmJUEkwan+PX2sXzF/zHxg5tkV5zNoUPQIV3hG2gCev5zkY2apL
         nY3HkAplRXLTpEHAypX3l3fR+mo961ET1RIsLFrYOmR4oOE4ubJoJtShh1MmfWQqWYf6
         K1sFbE8PAEhOGnszjAqrJnlr4OV/O0d39qFa6Z7MT6LmXGwoDfLXz0wyw18kazxOlcpa
         mxuocUpLH/qmM6S1ki1N262iw8sj7MDPbSIGBmwasMG306+HxGmpFmHEoKjM0Us6Lusy
         lomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J5a4ml0WAk4pr9Z82hPYk8r78Ylqi8uXBMPpVDXCN4w=;
        b=ntfXSCVy3AxOVnurQMMb9pnRxC1NjznFqZ/1fhXXBbMROG/+zFdOmWT9GhN9lc8WYL
         OEtka1u57fOP92Sh+WFPXXWJsIpDL8cWVDs+87dzYaIT+2D9ENxhu2ivBXU5Cw0eGAPY
         OO5ar70yIwgoPmvAT6uwfCvCXwqqpX45mGprx1RLPFKJjGEz49EZd0xpmogFi1Pya1Kc
         hmQd6D+Q0Ht/Z19n1K4/8Q3bY5Vomnn725mlfZPUeg7f2P3C9YdAK2C6etcDEpuCMLSm
         /El3RlTdbHm6gPwNT2QCenPyrGQKP4V3AemGMBseflbyI6DHLtgNK7oC60LsSnlYsFqr
         d1gQ==
X-Gm-Message-State: AOAM531hGgHmMFoRZZrw5ajET7x6txt+p37B8Mc/FrIE0X8Hr1wpgOLa
        EEzg+K9kJ3o8aRsa1f4mD2WOPr3T8yq29fj/
X-Google-Smtp-Source: ABdhPJxw9qA204yl169h2oYBJNR6C5nsWiln2kpOFOjakhVnEwpifdUwPgnWv/YzoI0CuAADSbRfIw==
X-Received: by 2002:a0c:a241:: with SMTP id f59mr2380008qva.33.1613618075602;
        Wed, 17 Feb 2021 19:14:35 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1f29:6ff9:b466:8c60])
        by smtp.gmail.com with ESMTPSA id c7sm2573412qtc.82.2021.02.17.19.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:14:35 -0800 (PST)
Date:   Wed, 17 Feb 2021 22:14:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v3 6/8] builtin/pack-objects.c: rewrite honor-pack-keep logic
Message-ID: <67af143fd1f3bcece0a8b27894cbdcdc5ae60ae8.1613618042.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613618042.git.me@ttaylorr.com>
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
index e766a4a43b..be3ba60bc2 100644
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

