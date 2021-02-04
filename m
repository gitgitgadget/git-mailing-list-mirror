Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F40AC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D118364F6A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhBDEAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 23:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbhBDD7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 22:59:35 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC674C0613D6
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:58:54 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id z22so1505615qto.7
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jYKeWecrw8cLxAZ34m2igv6eAKHd7g+fCAOupy0iX/w=;
        b=cMt0V38cey8XcucsgCVIsJFzCBTifqtI02gSKaujLOrJdM4AhPD6DF5RhAKiSHByT+
         m6YGfUyMcj4TkTsQ+eEPD5Du+t/VVM6kvSF0m1NaJgJ3QqdUEXaq+LgdQPJnpxY+RGCh
         DpVYvQlDMO0zFT+aL5djsrdfMLAzr76X4tbe3TDjDnOA+o4vvMhvkgoiz2tZYt4f4H01
         g3u6X2CI3/VP/ApCuULfUhxpO0ENUI8nFaZUmrWMcbMmg8Ef9m+A9Gt1wuAUHE7lU0nN
         4gfk1pjx1F5hNQ/9Y3JMt3QR5cdrMcWQKM0oyxd+PlUU54dlwh0zilVQRaIeaZ7Ui5fW
         K2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jYKeWecrw8cLxAZ34m2igv6eAKHd7g+fCAOupy0iX/w=;
        b=ZwOeEWs+3wT1ccpH2DBhtwjrBmsZyHFafKalHpEabuUKnGfTDFCZGfS1VRR47zTst8
         U4103H42Z+3yNvSlqjwJyjPWgquvAGt4wHKSWt9WOZl/4dPs+rrXO2VinjCf6SjN2ctj
         ed5/c+l3UagmUGYZ0x8ZnWJ++nxHStTZAVQRDDZm/w+5qdtP+SkqBcLJNcQkj7hGxCm9
         xFpusZF4r9xc6eSRNgDcfwzPmD4Hgjy8In/2M6kjiVa/NcPjYIHUy0LZmeNDxg7uy/xC
         0cAyjQLsVozLlZqilWdf+gPdQYlkR/yWbDjDGPS4fgLowxMYi/k7TG6neTL7fFT0+DJ4
         ZCrQ==
X-Gm-Message-State: AOAM531SWUYwRcPPqKoyYaGKUyM+fTzEjeNI2w3VbsU63zZidLuh0bfX
        eiB9xsmwYOpCtjNDHjE4KoycfJFG0bzgzQ==
X-Google-Smtp-Source: ABdhPJySRtj68V/FSdqDi4VaVh4sn8W9oBWEwXyCo+8fDx2bNtFerW8eYZr5CHegjgu61Cq6e8nlTQ==
X-Received: by 2002:ac8:5995:: with SMTP id e21mr5438293qte.294.1612411133517;
        Wed, 03 Feb 2021 19:58:53 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id i3sm3854839qkd.119.2021.02.03.19.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:58:52 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:58:50 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 1/8] packfile: introduce 'find_kept_pack_entry()'
Message-ID: <f7186147ebb0b2d01d8f1e0f742f367204d7d9c9.1612411123.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612411123.git.me@ttaylorr.com>
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
 packfile.h |  6 +++++
 2 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/packfile.c b/packfile.c
index 4b938b4372..5f35cfe788 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2031,7 +2031,10 @@ static int fill_pack_entry(const struct object_id *oid,
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
@@ -2041,26 +2044,77 @@ int find_pack_entry(struct repository *r, const struct object_id *oid, struct pa
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
index a58fc738e0..624327f64d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -161,13 +161,19 @@ int packed_object_info(struct repository *r,
 void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
+#define ON_DISK_KEEP_PACKS 1
+#define IN_CORE_KEEP_PACKS 2
+#define ALL_KEEP_PACKS (ON_DISK_KEEP_PACKS | IN_CORE_KEEP_PACKS)
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
2.30.0.533.g2f8b6b552f.dirty

