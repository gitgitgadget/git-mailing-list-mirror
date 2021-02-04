Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816D1C433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B1464E31
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhBDEBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 23:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbhBDEAf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 23:00:35 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E725EC06178C
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:59:24 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id v126so2096577qkd.11
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I+sQdE5BlUObmq5V9rJQa+VriLSwvSTanLLOnHF0c24=;
        b=a5Y0yJ1CJBR1C9c3VXWpXYBu2LgzETeA5S84yNbPCBoLXRGyrDYMdHSSIAJfF4H/2O
         B4G1qTeHOChkAuwStR8mktbOpLv7b0cZancq+Si0a0FBoUKSnpdHoohhWZEpxVrfbO+y
         r+7v/i3ahwEu3Dk84cfeIlk0Dr38lpQgYRz0qyIxrTU7I5eUElKIt9Eg0E7Mfl6bgOcx
         z62fvQ+PeUoYzj7hX6HxcwIkm2s7dy98qP9t+nXBc4VDb0d6xyHm09VyMffCf7eWSSQu
         Vv1oH1mPowg9VmarI7egc6OEU03nuq40ZVBrxUB3OAUBG7hsLn/irA9rmonojpaAU8qQ
         LPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I+sQdE5BlUObmq5V9rJQa+VriLSwvSTanLLOnHF0c24=;
        b=hZ5ll1rZAPbOJmx3V7I8cPKMWdyJHC84t1LLr3rS8Lftcja6FlPELmZs7DYu/bFZPG
         SfbVWBTzKidPKkAOhnAHOYM6fFSRMsoB2YBqWpVIgwfFe1DZLzxnhl0U6fytpLAU/6Df
         ghgwdqE2ut8IhYcKm7MKtpP7JThXJFkHbvGGoikuefqEX507WZxAzB/vEE/NTNKxwFrT
         T/xKPHqkbivNizgtQ34n17elytQPBldUdZ+lqvssiexR8gznNMShTycO8bWIZZ8qVH8o
         YWI5ObKgOJ1ZoxA9ZL2rxd5mi2p0HCDMYgUanbnfBkum7pLgzDZZfd7IgFOyk/e7iZmv
         N84g==
X-Gm-Message-State: AOAM5330EViBcKs3E9s/xbdyF4cSJ5wGwpUf8OEw+bcPAz9uAk07WNgt
        0OJnCsYI5Zee93aAL7Z1xsct4GaTeIUvcw==
X-Google-Smtp-Source: ABdhPJyy4SsCue451xsZCxSwcbpIngHN+dk4KJAkP1nY9sC4OYfB+UYx6uOLdvDVPtZ6atu9P0huDw==
X-Received: by 2002:ae9:ed52:: with SMTP id c79mr5945646qkg.352.1612411163827;
        Wed, 03 Feb 2021 19:59:23 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id a203sm4116891qkb.31.2021.02.03.19.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:59:23 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:59:21 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 7/8] packfile: add kept-pack cache for
 find_kept_pack_entry()
Message-ID: <f1c07324f62cf4d087c41165cefed98f554cfd78.1612411124.git.me@ttaylorr.com>
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

In a recent patch we added a function 'find_kept_pack_entry()' to look
for an object only among kept packs.

While this function avoids doing any lookup work in non-kept packs, it
is still linear in the number of packs, since we have to traverse the
linked list of packs once per object. Let's cache a reduced version of
that list to save us time.

Note that this cache will last the lifetime of the program. We could
invalidate it on reprepare_packed_git(), but there's not much point in
being rigorous here:

  - we might already fail to notice new .keep packs showing up after the
    program starts. We only reprepare_packed_git() when we fail to find
    an object. But adding a new pack won't cause that to happen.
    Somebody repacking could add a new pack and delete an old one, but
    most of the time we'd have a descriptor or mmap open to the old
    pack anyway, so we might not even notice.

  - in pack-objects we already cache the .keep state at startup, since
    56dfeb6263 (pack-objects: compute local/ignore_pack_keep early,
    2016-07-29). So this is just extending that concept further.

  - we don't have to worry about any packed_git being removed; we always
    keep the old structs around, even after reprepare_packed_git()

Here are p5303 results (as always, measured against the kernel):

  Test                                        HEAD^                   HEAD
  ----------------------------------------------------------------------------------------------
  5303.5: repack (1)                          57.44(54.71+10.78)      57.06(54.29+10.96) -0.7%
  5303.6: repack with --stdin-packs (1)       0.01(0.00+0.01)         0.01(0.01+0.00) +0.0%
  5303.10: repack (50)                        71.32(88.38+4.90)       71.47(88.60+5.04) +0.2%
  5303.11: repack with --stdin-packs (50)     3.43(11.81+0.22)        3.49(12.21+0.26) +1.7%
  5303.15: repack (1000)                      215.59(493.75+14.62)    217.41(495.36+14.85) +0.8%
  5303.16: repack with --stdin-packs (1000)   131.44(314.24+8.11)     126.75(309.88+8.09) -3.6%

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |   6 +--
 object-store.h         |  10 ++++
 packfile.c             | 103 +++++++++++++++++++++++------------------
 packfile.h             |   4 --
 revision.c             |   8 ++--
 5 files changed, 76 insertions(+), 55 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fbd7b54d70..b2ba5aa14f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1225,9 +1225,9 @@ static int want_found_object(const struct object_id *oid, int exclude,
 		 */
 		unsigned flags = 0;
 		if (ignore_packed_keep_on_disk)
-			flags |= ON_DISK_KEEP_PACKS;
+			flags |= CACHE_ON_DISK_KEEP_PACKS;
 		if (ignore_packed_keep_in_core)
-			flags |= IN_CORE_KEEP_PACKS;
+			flags |= CACHE_IN_CORE_KEEP_PACKS;
 
 		if (ignore_packed_keep_on_disk && p->pack_keep)
 			return 0;
@@ -3089,7 +3089,7 @@ static void read_packs_list_from_stdin(void)
 	 * an optimization during delta selection.
 	 */
 	revs.no_kept_objects = 1;
-	revs.keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+	revs.keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
 	revs.blob_objects = 1;
 	revs.tree_objects = 1;
 	revs.tag_objects = 1;
diff --git a/object-store.h b/object-store.h
index c4fc9dd74e..4cbe8eae3c 100644
--- a/object-store.h
+++ b/object-store.h
@@ -105,6 +105,14 @@ static inline int pack_map_entry_cmp(const void *unused_cmp_data,
 	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
 }
 
+#define CACHE_ON_DISK_KEEP_PACKS 1
+#define CACHE_IN_CORE_KEEP_PACKS 2
+
+struct kept_pack_cache {
+	struct packed_git **packs;
+	unsigned flags;
+};
+
 struct raw_object_store {
 	/*
 	 * Set of all object directories; the main directory is first (and
@@ -150,6 +158,8 @@ struct raw_object_store {
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
+	struct kept_pack_cache *kept_pack_cache;
+
 	/*
 	 * A map of packfiles to packed_git structs for tracking which
 	 * packs have been loaded already.
diff --git a/packfile.c b/packfile.c
index 5f35cfe788..2a139c907b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2031,10 +2031,7 @@ static int fill_pack_entry(const struct object_id *oid,
 	return 1;
 }
 
-static int find_one_pack_entry(struct repository *r,
-			       const struct object_id *oid,
-			       struct pack_entry *e,
-			       int kept_only)
+int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
 {
 	struct list_head *pos;
 	struct multi_pack_index *m;
@@ -2044,49 +2041,64 @@ static int find_one_pack_entry(struct repository *r,
 		return 0;
 
 	for (m = r->objects->multi_pack_index; m; m = m->next) {
-		if (!fill_midx_entry(r, oid, e, m))
-			continue;
-
-		if (!kept_only)
-			return 1;
-
-		if (((kept_only & ON_DISK_KEEP_PACKS) && e->p->pack_keep) ||
-		    ((kept_only & IN_CORE_KEEP_PACKS) && e->p->pack_keep_in_core))
+		if (fill_midx_entry(r, oid, e, m))
 			return 1;
 	}
 
 	list_for_each(pos, &r->objects->packed_git_mru) {
 		struct packed_git *p = list_entry(pos, struct packed_git, mru);
-		if (p->multi_pack_index && !kept_only) {
-			/*
-			 * If this pack is covered by the MIDX, we'd have found
-			 * the object already in the loop above if it was here,
-			 * so don't bother looking.
-			 *
-			 * The exception is if we are looking only at kept
-			 * packs. An object can be present in two packs covered
-			 * by the MIDX, one kept and one not-kept. And as the
-			 * MIDX points to only one copy of each object, it might
-			 * have returned only the non-kept version above. We
-			 * have to check again to be thorough.
-			 */
-			continue;
-		}
-		if (!kept_only ||
-		    (((kept_only & ON_DISK_KEEP_PACKS) && p->pack_keep) ||
-		     ((kept_only & IN_CORE_KEEP_PACKS) && p->pack_keep_in_core))) {
-			if (fill_pack_entry(oid, e, p)) {
-				list_move(&p->mru, &r->objects->packed_git_mru);
-				return 1;
-			}
+		if (!p->multi_pack_index && fill_pack_entry(oid, e, p)) {
+			list_move(&p->mru, &r->objects->packed_git_mru);
+			return 1;
 		}
 	}
 	return 0;
 }
 
-int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e)
+static void maybe_invalidate_kept_pack_cache(struct repository *r,
+					     unsigned flags)
 {
-	return find_one_pack_entry(r, oid, e, 0);
+	if (!r->objects->kept_pack_cache)
+		return;
+	if (r->objects->kept_pack_cache->flags == flags)
+		return;
+	free(r->objects->kept_pack_cache->packs);
+	FREE_AND_NULL(r->objects->kept_pack_cache);
+}
+
+static struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
+{
+	maybe_invalidate_kept_pack_cache(r, flags);
+
+	if (!r->objects->kept_pack_cache) {
+		struct packed_git **packs = NULL;
+		size_t nr = 0, alloc = 0;
+		struct packed_git *p;
+
+		/*
+		 * We want "all" packs here, because we need to cover ones that
+		 * are used by a midx, as well. We need to look in every one of
+		 * them (instead of the midx itself) to cover duplicates. It's
+		 * possible that an object is found in two packs that the midx
+		 * covers, one kept and one not kept, but the midx returns only
+		 * the non-kept version.
+		 */
+		for (p = get_all_packs(r); p; p = p->next) {
+			if ((p->pack_keep && (flags & CACHE_ON_DISK_KEEP_PACKS)) ||
+			    (p->pack_keep_in_core && (flags & CACHE_IN_CORE_KEEP_PACKS))) {
+				ALLOC_GROW(packs, nr + 1, alloc);
+				packs[nr++] = p;
+			}
+		}
+		ALLOC_GROW(packs, nr + 1, alloc);
+		packs[nr] = NULL;
+
+		r->objects->kept_pack_cache = xmalloc(sizeof(*r->objects->kept_pack_cache));
+		r->objects->kept_pack_cache->packs = packs;
+		r->objects->kept_pack_cache->flags = flags;
+	}
+
+	return r->objects->kept_pack_cache->packs;
 }
 
 int find_kept_pack_entry(struct repository *r,
@@ -2094,13 +2106,15 @@ int find_kept_pack_entry(struct repository *r,
 			 unsigned flags,
 			 struct pack_entry *e)
 {
-	/*
-	 * Load all packs, including midx packs, since our "kept" strategy
-	 * relies on that. We're relying on the side effect of it setting up
-	 * r->objects->packed_git, which is a little ugly.
-	 */
-	get_all_packs(r);
-	return find_one_pack_entry(r, oid, e, flags);
+	struct packed_git **cache;
+
+	for (cache = kept_pack_cache(r, flags); *cache; cache++) {
+		struct packed_git *p = *cache;
+		if (fill_pack_entry(oid, e, p))
+			return 1;
+	}
+
+	return 0;
 }
 
 int has_object_pack(const struct object_id *oid)
@@ -2109,7 +2123,8 @@ int has_object_pack(const struct object_id *oid)
 	return find_pack_entry(the_repository, oid, &e);
 }
 
-int has_object_kept_pack(const struct object_id *oid, unsigned flags)
+int has_object_kept_pack(const struct object_id *oid,
+			 unsigned flags)
 {
 	struct pack_entry e;
 	return find_kept_pack_entry(the_repository, oid, flags, &e);
diff --git a/packfile.h b/packfile.h
index 624327f64d..eb56db2a7b 100644
--- a/packfile.h
+++ b/packfile.h
@@ -161,10 +161,6 @@ int packed_object_info(struct repository *r,
 void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
-#define ON_DISK_KEEP_PACKS 1
-#define IN_CORE_KEEP_PACKS 2
-#define ALL_KEEP_PACKS (ON_DISK_KEEP_PACKS | IN_CORE_KEEP_PACKS)
-
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
diff --git a/revision.c b/revision.c
index 4c5adb90b1..41c0478705 100644
--- a/revision.c
+++ b/revision.c
@@ -2338,14 +2338,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		die(_("--unpacked=<packfile> no longer supported"));
 	} else if (!strcmp(arg, "--no-kept-objects")) {
 		revs->no_kept_objects = 1;
-		revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
-		revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
+		revs->keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
+		revs->keep_pack_cache_flags |= CACHE_ON_DISK_KEEP_PACKS;
 	} else if (skip_prefix(arg, "--no-kept-objects=", &optarg)) {
 		revs->no_kept_objects = 1;
 		if (!strcmp(optarg, "in-core"))
-			revs->keep_pack_cache_flags |= IN_CORE_KEEP_PACKS;
+			revs->keep_pack_cache_flags |= CACHE_IN_CORE_KEEP_PACKS;
 		if (!strcmp(optarg, "on-disk"))
-			revs->keep_pack_cache_flags |= ON_DISK_KEEP_PACKS;
+			revs->keep_pack_cache_flags |= CACHE_ON_DISK_KEEP_PACKS;
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
 		revs->diffopt.flags.recursive = 1;
-- 
2.30.0.533.g2f8b6b552f.dirty

