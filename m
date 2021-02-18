Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C5C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A81B64E3E
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBRDPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhBRDO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:14:59 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBA8C061756
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:19 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id c3so848839qkj.11
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gnooYuzFE9U5xs3bVfru21QnB8P7E+qaJoxRTCQ7obA=;
        b=twjmcLDLTbB9RPuMJNcyP/fEVzt6eGfegTiFLXp2BxP8lGBIejZp5U8J3v+C7wp8EG
         ug3pI2PYV+UA9A53AGPaN5meghaSKHHtZ0VIHdecyVG+7m5650Kl/nEPC5M0XLI1mdrE
         yZs05BQkkROI/MFlDT5VrO5TtVA85CZ87wA8BvDGrdSBlFWKQiCMWhxJyzRPnI+vR1ts
         u4xoHKQCHRdTw9EqE75jXUn85ggfBePbqvsc6VHfzlBKB+8loKGqkrJM5JwTRjIFihhW
         gVTigqjwNjs4bgSRrv9z+SuAm2U0S1EZV8Db/LPr6qqzR0/0tBPaK4hbPRocm/RH2+NO
         5syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gnooYuzFE9U5xs3bVfru21QnB8P7E+qaJoxRTCQ7obA=;
        b=h7/9NzPhN5Q9pOzYPJimBgFF1NjdcCqYjHNFK7NpIu69ds2oRLQgKjD5z76lLJ1bQM
         HHsLoflTyWOBnpVvmAAEKy90WvtwMPyC593wYhndkyuarrpME399LvITINRN58ujLiTo
         Asnptke2RgFE4Jh5z9Q57G7ptiGoWI8i089JUx2iK9GOBlhU3gESHhIFzPYDft18YcMO
         CXL9GfKfb0eYBOXd6yJChcH8Oz7shqmlF1fM1xH5siR90KtnpUHq8kAzqDTXoOesrDCT
         2MkSpDh+syMFnPmt0Cxdsv3F96TuOdMvF87DqpmLp8UgiVwGonI9j7uFGhZ94csf7NY7
         O3/A==
X-Gm-Message-State: AOAM531NHTtCY/BDBUT8fnWdQhwqp8TZq9mqoK0piIDHMBgb/HED6OqV
        /nC3cSrv8/9YbOow9FzPAKFqc1eueRkJDqOM
X-Google-Smtp-Source: ABdhPJwPtTW0iEWYcfxSP9sqrT+Cyk7CZGRoNuvzuESkVVuWUe+Z5cXxT5//DMo3NSh0rhFUOBGuAw==
X-Received: by 2002:a05:620a:4050:: with SMTP id i16mr2470488qko.473.1613618058334;
        Wed, 17 Feb 2021 19:14:18 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:1f29:6ff9:b466:8c60])
        by smtp.gmail.com with ESMTPSA id f26sm3005036qkh.80.2021.02.17.19.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 19:14:17 -0800 (PST)
Date:   Wed, 17 Feb 2021 22:14:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v3 1/8] packfile: introduce 'find_kept_pack_entry()'
Message-ID: <aa94edf39b957f3547c625fe11938082cdc30421.1613618042.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613618042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Future callers will want a function to fill a 'struct pack_entry' for a
given object id but _only_ from its position in any kept pack(s).

In particular, an new 'git repack' mode which ensures the resulting
packs form a geometric progress by object count will mark packs that it
does not want to repack as "kept in-core", and it will want to halt a
reachability traversal as soon as it visits an object in any of the kept
packs. But, it does not want to halt the traversal at non-kept, or
.keep packs.

The obvious alternative is 'find_pack_entry()', but this doesn't quite
suffice since it only returns the first pack it finds, which may or may
not be kept (and the mru cache makes it unpredictable which one you'll
get if there are options).

Short of that, you could walk over all packs looking for the object in
each one, but it scales with the number of packs, which may be
prohibitive.

Introduce 'find_kept_pack_entry()', a function which is like
'find_pack_entry()', but only fills in objects in the kept packs.

Handle packs which have .keep files, as well as in-core kept packs
separately, since certain callers will want to distinguish one from the
other. (Though on-disk and in-core kept packs share the adjective
"kept", it is best to think of the two sets as independent.)

There is a gotcha when looking up objects that are duplicated in kept
and non-kept packs, particularly when the MIDX stores the non-kept
version and the caller asked for kept objects only. This could be
resolved by teaching the MIDX to resolve duplicates by always favoring
the kept pack (if one exists), but this breaks an assumption in existing
MIDXs, and so it would require a format change.

The benefit to changing the MIDX in this way is marginal, so we instead
have a more thorough check here which is explained with a comment.

Callers will be added in subsequent patches.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 packfile.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 packfile.h |  5 +++++
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 1fec12ac5f..7f84f221ce 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2042,7 +2042,10 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
+static int find_one_pack_entry(struct repository *r,
+			       const struct object_id *oid,
+			       struct pack_entry *e,
+			       int kept_only)
 {
 	struct list_head *pos;
 	struct multi_pack_index *m;
@@ -2052,26 +2055,77 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
 		return 0;
 
 	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		if (fill_midx_entry(r, oid, e, m))
+		if (!fill_midx_entry(r, oid, e, m))
+			continue;
+
+		if (!kept_only)
+			return 1;
+
+		if (((kept_only & ON_DISK_KEEP_PACKS) && e->p->pack_keep) ||
+		    ((kept_only & IN_CORE_KEEP_PACKS) && e->p->pack_keep_in_core))
 			return 1;
 	}
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
-			list_move(&p->mru, &r->objects->packed_git_mru);
-			return 1;
+		if (p->multi_pack_index && !kept_only) {
+			/*
+			 * If this pack is covered by the MIDX, we'd have found
+			 * the object already in the loop above if it was here,
+			 * so don't bother looking.
+			 *
+			 * The exception is if we are looking only at kept
+			 * packs. An object can be present in two packs covered
+			 * by the MIDX, one kept and one not-kept. And as the
+			 * MIDX points to only one copy of each object, it might
+			 * have returned only the non-kept version above. We
+			 * have to check again to be thorough.
+			 */
+			continue;
+		}
+		if (!kept_only ||
+		    (((kept_only & ON_DISK_KEEP_PACKS) && p->pack_keep) ||
+		     ((kept_only & IN_CORE_KEEP_PACKS) && p->pack_keep_in_core))) {
+			if (fill_pack_entry(oid, e, p)) {
+				list_move(&p->mru, &r->objects->packed_git_mru);
+				return 1;
+			}
 		}
 	}
 	return 0;
 }
 
+int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
+{
+	return find_one_pack_entry(r, oid, e, 0);
+}
+
+int find_kept_pack_entry(struct repository *r,
+			 const struct object_id *oid,
+			 unsigned flags,
+			 struct pack_entry *e)
+{
+	/*
+	 * Load all packs, including midx packs, since our "kept" strategy
+	 * relies on that. We're relying on the side effect of it setting up
+	 * r->objects->packed_git, which is a little ugly.
+	 */
+	get_all_packs(r);
+	return find_one_pack_entry(r, oid, e, flags);
+}
+
 int has_object_pack(const struct object_id *oid)
 {
 	struct pack_entry e;
 	return find_pack_entry(the_repository, oid, &e);
 }
 
+int has_object_kept_pack(const struct object_id *oid, unsigned flags)
+{
+	struct pack_entry e;
+	return find_kept_pack_entry(the_repository, oid, flags, &e);
+}
+
 int has_pack_index(const unsigned char *sha1)
 {
 	struct stat st;
diff --git a/packfile.h b/packfile.h
index 4cfec9e8d3..3ae117a8ae 100644
--- a/packfile.h
+++ b/packfile.h
@@ -162,13 +162,18 @@ int packed_object_info(struct repository *r,
 void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
+#define ON_DISK_KEEP_PACKS 1
+#define IN_CORE_KEEP_PACKS 2
+
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
 int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
+int find_kept_pack_entry(struct repository *r, const struct object_id *oid, unsigned flags, struct pack_entry *e);
 
 int has_object_pack(const struct object_id *oid);
+int has_object_kept_pack(const struct object_id *oid, unsigned flags);
 
 int has_pack_index(const unsigned char *sha1);
 
-- 
2.30.0.667.g81c0cbc6fd

