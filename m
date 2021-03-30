Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2462BC433E3
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E28A619DC
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhC3PE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhC3PE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:04:29 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676A0C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:29 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id y5so16130608qkl.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xklA/J4YMarRCg2zjTV1xfE1mmzJQEg1xUYjYS6whic=;
        b=lawUqpn78u3Bk5iuOG6T7eehL0ig7mhrHbPpJ1Rs1gw1FkOuzHPpKOTchJ94f6J3Gh
         lSOXtFfJf6MWqSmoJOTWPnbMkeztd9RR+5bDF40MDP+DgnuaMWf9cxVFzJU+pcufeECc
         kGuTv6nv3jE5OtpSgaX/4T1RKXhbflNItoTjHn3+dwJNFGD4dw5mbJ+MgVc5Ysxg4dlE
         Hha7QhxGrrMvsw2ZjjtX8BZNFo9pcgjadS6T40IWnBxlaeHOV22nXnRj+TdTKOxjn8XE
         L+ovPHh5keUWSeXLe2VCGu94MMP+uadO9xmu/WP5r5SEiR8IwFBPbPLrYL55Qz8pQPTH
         noRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xklA/J4YMarRCg2zjTV1xfE1mmzJQEg1xUYjYS6whic=;
        b=QlV6USzrSGQ5JFdX3Z2ZNvtO5y8dqR7VNan3pEj/ScXG1yZ4k1yx+/he1IuTwojA2l
         CfFDgRhgPx8R0Y3nia3Agknd0qiAdipk+wnfV8OFZ5AP8ZsbJCf9JMlCT3j0C2bUyS3Y
         EgeenRtVgNZIN/VXF9DTME55aUEYLlhO6eib2DMyR87lYx9Gt81s4hmqko/drmVkUU02
         39O2TmulyVdjWK84MRqy6/SRVBtxGAMx4r1x10g/AjU0WJwrkxNgsHnu5bKoebMwhNKj
         MMTdK6JXDFthMFi7mxXhctBuXNKOsJBSgyYcRlVJ5HkPYHlvVlJBi87D0Pp4XAlshDyE
         gshg==
X-Gm-Message-State: AOAM530s4zChxbpKYtcplc6XO7nFxDSVC/aK42YLK7LFQ7i3ulQ94kIK
        4Iu3q8YdQQ5HyTlk6dr2KzR0lOMoWgXTkg==
X-Google-Smtp-Source: ABdhPJyKvvbEa0Nz6p+WoPN3vypZLulH+XmuPvnBI2NkboJvokW1KZY4PsjvJ46dbD7YjDwir5pCfw==
X-Received: by 2002:a37:9dc1:: with SMTP id g184mr32255433qke.285.1617116668167;
        Tue, 30 Mar 2021 08:04:28 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id g2sm13474453qtu.0.2021.03.30.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:04:27 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:04:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 13/16] pack-revindex: read multi-pack reverse indexes
Message-ID: <c070b9c99f50dffe10d627e3506d55bc7fd500d1.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617116623.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement reading for multi-pack reverse indexes, as described in the
previous patch.

Note that these functions don't yet have any callers, and won't until
multi-pack reachability bitmaps are introduced in a later patch series.
In the meantime, this patch implements some of the infrastructure
necessary to support multi-pack bitmaps.

There are three new functions exposed by the revindex API:

  - load_midx_revindex(): loads the reverse index corresponding to the
    given multi-pack index.

  - midx_to_pack_pos() and pack_pos_to_midx(): these convert between the
    multi-pack index and pseudo-pack order.

load_midx_revindex() and pack_pos_to_midx() are both relatively
straightforward.

load_midx_revindex() needs a few functions to be exposed from the midx
API. One to get the checksum of a midx, and another to get the .rev's
filename. Similar to recent changes in the packed_git struct, three new
fields are added to the multi_pack_index struct: one to keep track of
the size, one to keep track of the mmap'd pointer, and another to point
past the header and at the reverse index's data.

pack_pos_to_midx() simply reads the corresponding entry out of the
table.

midx_to_pack_pos() is the trickiest, since it needs to find an object's
position in the psuedo-pack order, but that order can only be recovered
in the .rev file itself. This mapping can be implemented with a binary
search, but note that the thing we're binary searching over isn't an
array of values, but rather a permuted order of those values.

So, when comparing two items, it's helpful to keep in mind the
difference. Instead of a traditional binary search, where you are
comparing two things directly, here we're comparing a (pack, offset)
tuple with an index into the multi-pack index. That index describes
another (pack, offset) tuple, and it is _those_ two tuples that are
compared.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c          |  11 +++++
 midx.h          |   6 +++
 pack-revindex.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++
 pack-revindex.h |  53 ++++++++++++++++++++
 packfile.c      |   3 ++
 5 files changed, 199 insertions(+)

diff --git a/midx.c b/midx.c
index 2173a9b45c..c04e794888 100644
--- a/midx.c
+++ b/midx.c
@@ -47,11 +47,22 @@ static uint8_t oid_version(void)
 	}
 }
 
+static const unsigned char *get_midx_checksum(struct multi_pack_index *m)
+{
+	return m->data + m->data_len - the_hash_algo->rawsz;
+}
+
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
 }
 
+char *get_midx_rev_filename(struct multi_pack_index *m)
+{
+	return xstrfmt("%s/pack/multi-pack-index-%s.rev",
+		       m->object_dir, hash_to_hex(get_midx_checksum(m)));
+}
+
 static int midx_read_oid_fanout(const unsigned char *chunk_start,
 				size_t chunk_size, void *data)
 {
diff --git a/midx.h b/midx.h
index 93bd68189e..0a8294d2ee 100644
--- a/midx.h
+++ b/midx.h
@@ -15,6 +15,10 @@ struct multi_pack_index {
 	const unsigned char *data;
 	size_t data_len;
 
+	const uint32_t *revindex_data;
+	const uint32_t *revindex_map;
+	size_t revindex_len;
+
 	uint32_t signature;
 	unsigned char version;
 	unsigned char hash_len;
@@ -37,6 +41,8 @@ struct multi_pack_index {
 
 #define MIDX_PROGRESS     (1 << 0)
 
+char *get_midx_rev_filename(struct multi_pack_index *m);
+
 struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
 int prepare_midx_pack(struct repository *r, struct multi_pack_index *m, uint32_t pack_int_id);
 int bsearch_midx(const struct object_id *oid, struct multi_pack_index *m, uint32_t *result);
diff --git a/pack-revindex.c b/pack-revindex.c
index 4262530449..0e4a31d9db 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -3,6 +3,7 @@
 #include "object-store.h"
 #include "packfile.h"
 #include "config.h"
+#include "midx.h"
 
 struct revindex_entry {
 	off_t offset;
@@ -293,6 +294,43 @@ int load_pack_revindex(struct packed_git *p)
 	return -1;
 }
 
+int load_midx_revindex(struct multi_pack_index *m)
+{
+	char *revindex_name;
+	int ret;
+	if (m->revindex_data)
+		return 0;
+
+	revindex_name = get_midx_rev_filename(m);
+
+	ret = load_revindex_from_disk(revindex_name,
+				      m->num_objects,
+				      &m->revindex_map,
+				      &m->revindex_len);
+	if (ret)
+		goto cleanup;
+
+	m->revindex_data = (const uint32_t *)((const char *)m->revindex_map + RIDX_HEADER_SIZE);
+
+cleanup:
+	free(revindex_name);
+	return ret;
+}
+
+int close_midx_revindex(struct multi_pack_index *m)
+{
+	if (!m || !m->revindex_map)
+		return 0;
+
+	munmap((void*)m->revindex_map, m->revindex_len);
+
+	m->revindex_map = NULL;
+	m->revindex_data = NULL;
+	m->revindex_len = 0;
+
+	return 0;
+}
+
 int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
 {
 	unsigned lo, hi;
@@ -347,3 +385,91 @@ off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
 	else
 		return nth_packed_object_offset(p, pack_pos_to_index(p, pos));
 }
+
+uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos)
+{
+	if (!m->revindex_data)
+		BUG("pack_pos_to_midx: reverse index not yet loaded");
+	if (m->num_objects <= pos)
+		BUG("pack_pos_to_midx: out-of-bounds object at %"PRIu32, pos);
+	return get_be32(m->revindex_data + pos);
+}
+
+struct midx_pack_key {
+	uint32_t pack;
+	off_t offset;
+
+	uint32_t preferred_pack;
+	struct multi_pack_index *midx;
+};
+
+static int midx_pack_order_cmp(const void *va, const void *vb)
+{
+	const struct midx_pack_key *key = va;
+	struct multi_pack_index *midx = key->midx;
+
+	uint32_t versus = pack_pos_to_midx(midx, (uint32_t*)vb - (const uint32_t *)midx->revindex_data);
+	uint32_t versus_pack = nth_midxed_pack_int_id(midx, versus);
+	off_t versus_offset;
+
+	uint32_t key_preferred = key->pack == key->preferred_pack;
+	uint32_t versus_preferred = versus_pack == key->preferred_pack;
+
+	/*
+	 * First, compare the preferred-ness, noting that the preferred pack
+	 * comes first.
+	 */
+	if (key_preferred && !versus_preferred)
+		return -1;
+	else if (!key_preferred && versus_preferred)
+		return 1;
+
+	/* Then, break ties first by comparing the pack IDs. */
+	if (key->pack < versus_pack)
+		return -1;
+	else if (key->pack > versus_pack)
+		return 1;
+
+	/* Finally, break ties by comparing offsets within a pack. */
+	versus_offset = nth_midxed_offset(midx, versus);
+	if (key->offset < versus_offset)
+		return -1;
+	else if (key->offset > versus_offset)
+		return 1;
+
+	return 0;
+}
+
+int midx_to_pack_pos(struct multi_pack_index *m, uint32_t at, uint32_t *pos)
+{
+	struct midx_pack_key key;
+	uint32_t *found;
+
+	if (!m->revindex_data)
+		BUG("midx_to_pack_pos: reverse index not yet loaded");
+	if (m->num_objects <= at)
+		BUG("midx_to_pack_pos: out-of-bounds object at %"PRIu32, at);
+
+	key.pack = nth_midxed_pack_int_id(m, at);
+	key.offset = nth_midxed_offset(m, at);
+	key.midx = m;
+	/*
+	 * The preferred pack sorts first, so determine its identifier by
+	 * looking at the first object in pseudo-pack order.
+	 *
+	 * Note that if no --preferred-pack is explicitly given when writing a
+	 * multi-pack index, then whichever pack has the lowest identifier
+	 * implicitly is preferred (and includes all its objects, since ties are
+	 * broken first by pack identifier).
+	 */
+	key.preferred_pack = nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
+
+	found = bsearch(&key, m->revindex_data, m->num_objects,
+			sizeof(*m->revindex_data), midx_pack_order_cmp);
+
+	if (!found)
+		return error("bad offset for revindex");
+
+	*pos = found - m->revindex_data;
+	return 0;
+}
diff --git a/pack-revindex.h b/pack-revindex.h
index ba7c82c125..479b8f2f9c 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -14,6 +14,20 @@
  *
  * - offset: the byte offset within the .pack file at which the object contents
  *   can be found
+ *
+ * The revindex can also be used with a multi-pack index (MIDX). In this
+ * setting:
+ *
+ *   - index position refers to an object's numeric position within the MIDX
+ *
+ *   - pack position refers to an object's position within a non-existent pack
+ *     described by the MIDX. The pack structure is described in
+ *     Documentation/technical/pack-format.txt.
+ *
+ *     It is effectively a concatanation of all packs in the MIDX (ordered by
+ *     their numeric ID within the MIDX) in their original order within each
+ *     pack), removing duplicates, and placing the preferred pack (if any)
+ *     first.
  */
 
 
@@ -24,6 +38,7 @@
 #define GIT_TEST_REV_INDEX_DIE_IN_MEMORY "GIT_TEST_REV_INDEX_DIE_IN_MEMORY"
 
 struct packed_git;
+struct multi_pack_index;
 
 /*
  * load_pack_revindex populates the revindex's internal data-structures for the
@@ -34,6 +49,22 @@ struct packed_git;
  */
 int load_pack_revindex(struct packed_git *p);
 
+/*
+ * load_midx_revindex loads the '.rev' file corresponding to the given
+ * multi-pack index by mmap-ing it and assigning pointers in the
+ * multi_pack_index to point at it.
+ *
+ * A negative number is returned on error.
+ */
+int load_midx_revindex(struct multi_pack_index *m);
+
+/*
+ * Frees resources associated with a multi-pack reverse index.
+ *
+ * A negative number is returned on error.
+ */
+int close_midx_revindex(struct multi_pack_index *m);
+
 /*
  * offset_to_pack_pos converts an object offset to a pack position. This
  * function returns zero on success, and a negative number otherwise. The
@@ -71,4 +102,26 @@ uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
  */
 off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
 
+/*
+ * pack_pos_to_midx converts the object at position "pos" within the MIDX
+ * pseudo-pack into a MIDX position.
+ *
+ * If the reverse index has not yet been loaded, or the position is out of
+ * bounds, this function aborts.
+ *
+ * This function runs in time O(log N) with the number of objects in the MIDX.
+ */
+uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos);
+
+/*
+ * midx_to_pack_pos converts from the MIDX-relative position at "at" to the
+ * corresponding pack position.
+ *
+ * If the reverse index has not yet been loaded, or the position is out of
+ * bounds, this function aborts.
+ *
+ * This function runs in constant time.
+ */
+int midx_to_pack_pos(struct multi_pack_index *midx, uint32_t at, uint32_t *pos);
+
 #endif
diff --git a/packfile.c b/packfile.c
index 6661f3325a..8668345d93 100644
--- a/packfile.c
+++ b/packfile.c
@@ -862,6 +862,9 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 
 	if (!strcmp(file_name, "multi-pack-index"))
 		return;
+	if (starts_with(file_name, "multi-pack-index") &&
+	    ends_with(file_name, ".rev"))
+		return;
 	if (ends_with(file_name, ".idx") ||
 	    ends_with(file_name, ".rev") ||
 	    ends_with(file_name, ".pack") ||
-- 
2.30.0.667.g81c0cbc6fd

