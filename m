Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBD9C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D1023A1D
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgLHWFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbgLHWFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:05:18 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C10C0617B0
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 14:04:37 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id w3so206251otp.13
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 14:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oK9d8MRvwLAr4PgAX2C7YmL72QhE9Q310xr6XLqZic=;
        b=wKbDFcOUE8qavn+MkPwGTFR5vBn8ktTJfLokzkc1U37um0Ng95FWmjxDj5cCgohuuq
         yWKS64YzKKPdHz0oaQrYTZBgklWroBzwGYfgOeZDnj4UbgJN54jam6xDE946vTnX8kOD
         YuQcphW2kGoVyG8HsqxuGGJoYMiMrcZ3rtIrtvoSBi4T+6SOVj28S8q4yj5U1qKQeQf0
         8+pYtz9GqnYpwUHm6qa7FV/1ACq+OoEC9YsfbBEec2c3evu1QhKrKxskxtXS22W40f3H
         cJJUggPVmwkUKSBVKNy6rJ3LILPdJwseXXzWPiy0ee2+1DQWlVe6cEZIN5snv2W71xJ1
         oGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5oK9d8MRvwLAr4PgAX2C7YmL72QhE9Q310xr6XLqZic=;
        b=j02u5O4fcg9ECITTBFNx3qlRedoEoeKah+imBx021EIEkbsU/yV6L7uZuUM/L8VGwW
         1Ddak8VbhTDl1QXCAFSOuv3zUJT+s5AZIPaeUFUl+4rS9w08A5sEJO5E3NevLNB7LWHD
         ylTISo38VVsw+H62khbj290v+CMTeHL+ZfC7BiKOuv6nLDcfd1hCt63y9cCluj/6m/IK
         ck6UcODMgdqlbe2Ov6DXmTeh1yRTlSp+HHYuhaDkpV6FH9OZcK2WCRVMP4seMFt+a4TF
         igxDJhz9FN0qFU/gpoDonsIafWHQ6i+a/SWEClttb4Fecb9yq/WWK2/A9DpWpWojbqsb
         jGeQ==
X-Gm-Message-State: AOAM531Qyxp8wLT8/GKCUnKTBO+AZGpnLPNlFwXt+cVs3uEDhqz8puuv
        dxhR0KUPZ8EQlGmu0lsquTQ0YjU/E2EEBzYF
X-Google-Smtp-Source: ABdhPJx7E9zkTKc0KYI+K45toqFe21yxDEfF2bX14ir37t07P4Y/3ohAdgMOMhgnTN9jYkgasTT+5A==
X-Received: by 2002:a05:6830:22d3:: with SMTP id q19mr119349otc.115.1607465076958;
        Tue, 08 Dec 2020 14:04:36 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l132sm19018oia.23.2020.12.08.14.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:04:36 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:04:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com, dstolee@microsoft.com,
        gitster@pobox.com
Subject: [PATCH v4 19/24] pack-bitmap-write: ignore BITMAP_FLAG_REUSE
Message-ID: <d973cf240d7ce28c20b9eb2a0207edd1cb2e1968.1607464775.git.me@ttaylorr.com>
References: <cover.1605123652.git.me@ttaylorr.com>
 <cover.1607464775.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607464775.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

The on-disk bitmap format has a flag to mark a bitmap to be "reused".
This is a rather curious feature, and works like this:

  - a run of pack-objects would decide to mark the last 80% of the
    bitmaps it generates with the reuse flag

  - the next time we generate bitmaps, we'd see those reuse flags from
    the last run, and mark those commits as special:

      - we'd be more likely to select those commits to get bitmaps in
        the new output

      - when generating the bitmap for a selected commit, we'd reuse the
        old bitmap as-is (rearranging the bits to match the new pack, of
        course)

However, neither of these behaviors particularly makes sense.

Just because a commit happened to be bitmapped last time does not make
it a good candidate for having a bitmap this time. In particular, we may
choose bitmaps based on how recent they are in history, or whether a ref
tip points to them, and those things will change. We're better off
re-considering fresh which commits are good candidates.

Reusing the existing bitmap _is_ a reasonable thing to do to save
computation. But only reusing exact bitmaps is a weak form of this. If
we have an old bitmap for A and now want a new bitmap for its child, we
should be able to compute that only by looking at trees and that are new
to the child. But this code would consider only exact reuse (which is
perhaps why it was eager to select those commits in the first place).

Furthermore, the recent switch to the reverse-edge algorithm for
generating bitmaps dropped this optimization entirely (and yet still
performs better).

So let's do a few cleanups:

 - drop the whole "reusing bitmaps" phase of generating bitmaps. It's
   not helping anything, and is mostly unused code (or worse, code that
   is using CPU but not doing anything useful)

 - drop the use of the on-disk reuse flag to select commits to bitmap

 - stop setting the on-disk reuse flag in bitmaps we generate (since
   nothing respects it anymore)

We will keep a few innards of the reuse code, which will help us
implement a more capable version of the "reuse" optimization:

 - simplify rebuild_existing_bitmaps() into a function that only builds
   the mapping of bits between the old and new orders, but doesn't
   actually convert any bitmaps

 - make rebuild_bitmap() public; we'll call it lazily to convert bitmaps
   as we traverse (using the mapping created above)

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c |  1 -
 pack-bitmap-write.c    | 50 +++++-------------------------------------
 pack-bitmap.c          | 46 +++++---------------------------------
 pack-bitmap.h          |  6 ++++-
 4 files changed, 16 insertions(+), 87 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5617c01b5a..2a00358f34 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1104,7 +1104,6 @@ static void write_pack_file(void)
 				stop_progress(&progress_state);
 
 				bitmap_writer_show_progress(progress);
-				bitmap_writer_reuse_bitmaps(&to_pack);
 				bitmap_writer_select_commits(indexed_commits, indexed_commits_nr, -1);
 				bitmap_writer_build(&to_pack);
 				bitmap_writer_finish(written_list, nr_written,
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 0af93193d8..333058854d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -30,7 +30,6 @@ struct bitmap_writer {
 	struct ewah_bitmap *tags;
 
 	kh_oid_map_t *bitmaps;
-	kh_oid_map_t *reused;
 	struct packing_data *to_pack;
 
 	struct bitmapped_commit *selected;
@@ -112,7 +111,7 @@ void bitmap_writer_build_type_index(struct packing_data *to_pack,
  * Compute the actual bitmaps
  */
 
-static inline void push_bitmapped_commit(struct commit *commit, struct ewah_bitmap *reused)
+static inline void push_bitmapped_commit(struct commit *commit)
 {
 	if (writer.selected_nr >= writer.selected_alloc) {
 		writer.selected_alloc = (writer.selected_alloc + 32) * 2;
@@ -120,7 +119,7 @@ static inline void push_bitmapped_commit(struct commit *commit, struct ewah_bitm
 	}
 
 	writer.selected[writer.selected_nr].commit = commit;
-	writer.selected[writer.selected_nr].bitmap = reused;
+	writer.selected[writer.selected_nr].bitmap = NULL;
 	writer.selected[writer.selected_nr].flags = 0;
 
 	writer.selected_nr++;
@@ -372,13 +371,6 @@ static void store_selected(struct bb_commit *ent, struct commit *commit)
 	khiter_t hash_pos;
 	int hash_ret;
 
-	/*
-	 * the "reuse bitmaps" phase may have stored something here, but
-	 * our new algorithm doesn't use it. Drop it.
-	 */
-	if (stored->bitmap)
-		ewah_free(stored->bitmap);
-
 	stored->bitmap = bitmap_to_ewah(ent->bitmap);
 
 	hash_pos = kh_put_oid_map(writer.bitmaps, commit->object.oid, &hash_ret);
@@ -480,35 +472,6 @@ static int date_compare(const void *_a, const void *_b)
 	return (long)b->date - (long)a->date;
 }
 
-void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack)
-{
-	struct bitmap_index *bitmap_git;
-	if (!(bitmap_git = prepare_bitmap_git(to_pack->repo)))
-		return;
-
-	writer.reused = kh_init_oid_map();
-	rebuild_existing_bitmaps(bitmap_git, to_pack, writer.reused,
-				 writer.show_progress);
-	/*
-	 * NEEDSWORK: rebuild_existing_bitmaps() makes writer.reused reference
-	 * some bitmaps in bitmap_git, so we can't free the latter.
-	 */
-}
-
-static struct ewah_bitmap *find_reused_bitmap(const struct object_id *oid)
-{
-	khiter_t hash_pos;
-
-	if (!writer.reused)
-		return NULL;
-
-	hash_pos = kh_get_oid_map(writer.reused, *oid);
-	if (hash_pos >= kh_end(writer.reused))
-		return NULL;
-
-	return kh_value(writer.reused, hash_pos);
-}
-
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 				  unsigned int indexed_commits_nr,
 				  int max_bitmaps)
@@ -522,12 +485,11 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 	if (indexed_commits_nr < 100) {
 		for (i = 0; i < indexed_commits_nr; ++i)
-			push_bitmapped_commit(indexed_commits[i], NULL);
+			push_bitmapped_commit(indexed_commits[i]);
 		return;
 	}
 
 	for (;;) {
-		struct ewah_bitmap *reused_bitmap = NULL;
 		struct commit *chosen = NULL;
 
 		next = next_commit_index(i);
@@ -542,15 +504,13 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 
 		if (next == 0) {
 			chosen = indexed_commits[i];
-			reused_bitmap = find_reused_bitmap(&chosen->object.oid);
 		} else {
 			chosen = indexed_commits[i + next];
 
 			for (j = 0; j <= next; ++j) {
 				struct commit *cm = indexed_commits[i + j];
 
-				reused_bitmap = find_reused_bitmap(&cm->object.oid);
-				if (reused_bitmap || (cm->object.flags & NEEDS_BITMAP) != 0) {
+				if ((cm->object.flags & NEEDS_BITMAP) != 0) {
 					chosen = cm;
 					break;
 				}
@@ -560,7 +520,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
 			}
 		}
 
-		push_bitmapped_commit(chosen, reused_bitmap);
+		push_bitmapped_commit(chosen);
 
 		i += next + 1;
 		display_progress(writer.progress, i);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 60c781d100..d1368b69bb 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1338,9 +1338,9 @@ void test_bitmap_walk(struct rev_info *revs)
 	free_bitmap_index(bitmap_git);
 }
 
-static int rebuild_bitmap(uint32_t *reposition,
-			  struct ewah_bitmap *source,
-			  struct bitmap *dest)
+int rebuild_bitmap(const uint32_t *reposition,
+		   struct ewah_bitmap *source,
+		   struct bitmap *dest)
 {
 	uint32_t pos = 0;
 	struct ewah_iterator it;
@@ -1369,19 +1369,11 @@ static int rebuild_bitmap(uint32_t *reposition,
 	return 0;
 }
 
-int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
-			     struct packing_data *mapping,
-			     kh_oid_map_t *reused_bitmaps,
-			     int show_progress)
+uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
+				struct packing_data *mapping)
 {
 	uint32_t i, num_objects;
 	uint32_t *reposition;
-	struct bitmap *rebuild;
-	struct stored_bitmap *stored;
-	struct progress *progress = NULL;
-
-	khiter_t hash_pos;
-	int hash_ret;
 
 	num_objects = bitmap_git->pack->num_objects;
 	reposition = xcalloc(num_objects, sizeof(uint32_t));
@@ -1399,33 +1391,7 @@ int rebuild_existing_bitmaps(struct bitmap_index *bitmap_git,
 			reposition[i] = oe_in_pack_pos(mapping, oe) + 1;
 	}
 
-	rebuild = bitmap_new();
-	i = 0;
-
-	if (show_progress)
-		progress = start_progress("Reusing bitmaps", 0);
-
-	kh_foreach_value(bitmap_git->bitmaps, stored, {
-		if (stored->flags & BITMAP_FLAG_REUSE) {
-			if (!rebuild_bitmap(reposition,
-					    lookup_stored_bitmap(stored),
-					    rebuild)) {
-				hash_pos = kh_put_oid_map(reused_bitmaps,
-							  stored->oid,
-							  &hash_ret);
-				kh_value(reused_bitmaps, hash_pos) =
-					bitmap_to_ewah(rebuild);
-			}
-			bitmap_reset(rebuild);
-			display_progress(progress, ++i);
-		}
-	});
-
-	stop_progress(&progress);
-
-	free(reposition);
-	bitmap_free(rebuild);
-	return 0;
+	return reposition;
 }
 
 void free_bitmap_index(struct bitmap_index *b)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 1203120c43..afa4115136 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -73,7 +73,11 @@ void bitmap_writer_set_checksum(unsigned char *sha1);
 void bitmap_writer_build_type_index(struct packing_data *to_pack,
 				    struct pack_idx_entry **index,
 				    uint32_t index_nr);
-void bitmap_writer_reuse_bitmaps(struct packing_data *to_pack);
+uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
+				struct packing_data *mapping);
+int rebuild_bitmap(const uint32_t *reposition,
+		   struct ewah_bitmap *source,
+		   struct bitmap *dest);
 void bitmap_writer_select_commits(struct commit **indexed_commits,
 		unsigned int indexed_commits_nr, int max_bitmaps);
 void bitmap_writer_build(struct packing_data *to_pack);
-- 
2.29.2.533.g07db1f5344

