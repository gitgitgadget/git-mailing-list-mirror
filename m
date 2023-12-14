Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3795967217
	for <git@vger.kernel.org>; Thu, 14 Dec 2023 22:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="l2vc0E95"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1f055438492so30750fac.3
        for <git@vger.kernel.org>; Thu, 14 Dec 2023 14:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702592638; x=1703197438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHDy3Vs7lALL7DwXC1VnW4EZ41sWyCaUQtqPaaHaiNQ=;
        b=l2vc0E95LUPuq06NMTvxE3XzYUpWSkxLcQlcvNrig0mVU6VnC5sUBCq5LX5vKyuqZS
         YpsEbI+r0ixttghaiAn0Z16DQWCm0WsY1xlC/PnUWj0ZfegzsW0qzQYTxcWiQeC2mdur
         ZaT0KpyAIOJ/xgibcHhe/tlpqtqKq2XzciB21FLnuPqKBuuHcqhIKQGAbyj1fgw05n3+
         t3gC1z19ms7PuzhTI0pF2TEiLVVINCZHRhfgHmKeCAWIUlKubV4sNTn9zZD4MmG458lg
         z80fHvVOeQMXX+JUvWNTTw2xxapF2VkTNj80CcbLSv2Ci4ea3v2H6f7TL6RCOiIedZF3
         H5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702592638; x=1703197438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHDy3Vs7lALL7DwXC1VnW4EZ41sWyCaUQtqPaaHaiNQ=;
        b=Stcg5FKOAjmsduo+VqPRjj+y0RjeFqIYNejSq2hh5t0CgUJkMgc4lrgNRGhHmJOAfZ
         uCA3zAAS2YBcTZeiGTL7xIS3uO2XzsFNAaR7fO1wTtPeA9IHvVnZktwGgwysrylbFaih
         5tqE7XdJU0XY+ud2+a43ognWudu6lVfOX7i/ABKQkLdX56fI28UsjaS1nGiI7mlE8ZBi
         qIfjHN+pbY+QqdSzxhw/492rNq03uvPnYfRBkrd5L+WDsTLadLdolK44d/AGpanjDnjF
         8auy8Ed3xbqM4N0r/kPjuQfWDrebtUsbtrl0MDZeJ0fUvkTAo0H/MGEwNoxcgG6UF0C1
         X/Vg==
X-Gm-Message-State: AOJu0YwCkaGIXQvdGElEzlNg902+lEom/ceZKvDV9WDNkc6phKMOFJzQ
	cQDCjk4TX5Bal6YEOLLx3D7VBO9xtBxXJUVjYBmWGw==
X-Google-Smtp-Source: AGHT+IGnSbjS+VsgsC7iB26wl63u9ik4XRmx60VHkwS1SdOEoTSk0YhBZzfm+/+f5HPbjgEzkYdOhw==
X-Received: by 2002:a05:6870:808e:b0:203:3680:6f75 with SMTP id q14-20020a056870808e00b0020336806f75mr2856715oab.15.1702592637696;
        Thu, 14 Dec 2023 14:23:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id wd15-20020a056871a58f00b001fb21cee425sm4732577oab.40.2023.12.14.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:23:57 -0800 (PST)
Date: Thu, 14 Dec 2023 17:23:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/26] pack-bitmap: pass `bitmapped_pack` struct to
 pack-reuse functions
Message-ID: <df9233cf0f2fa835e4e7b5764acaee68f7352ecb.1702592604.git.me@ttaylorr.com>
References: <cover.1701198172.git.me@ttaylorr.com>
 <cover.1702592603.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1702592603.git.me@ttaylorr.com>

When trying to assemble a pack with bitmaps using `--use-bitmap-index`,
`pack-objects` asks the pack-bitmap machinery for a bitmap which
indicates the set of objects we can "reuse" verbatim from on-disk.

This set is roughly comprised of: a prefix of objects in the bitmapped
pack (or preferred pack, in the case of a multi-pack reachability
bitmap), plus any other objects not included in the prefix, excluding
any deltas whose base we are not sending in the resulting pack.

The pack-bitmap machinery is responsible for computing this bitmap, and
does so with the following functions:

  - reuse_partial_packfile_from_bitmap()
  - try_partial_reuse()

In the existing implementation, the first function is responsible for
(a) marking the prefix of objects in the reusable pack, and then (b)
calling try_partial_reuse() on any remaining objects to ensure that they
are also reusable (and removing them from the bitmapped set if they are
not).

Likewise, the `try_partial_reuse()` function is responsible for checking
whether an isolated object (that is, an object from the bitmapped
pack/preferred pack not contained in the prefix from earlier) may be
reused, i.e. that it isn't a delta of an object that we are not sending
in the resulting pack.

These functions are based on two core assumptions, which we will unwind
in this and the following commits:

  1. There is only a single pack from the bitmap which is eligible for
     verbatim pack-reuse. For single-pack bitmaps, this is trivially the
     bitmapped pack. For multi-pack bitmaps, this is (currently) the
     MIDX's preferred pack.

  2. The pack eligible for reuse has its first object in bit position 0,
     and all objects from that pack follow in pack-order from that first
     bit position.

In order to perform verbatim pack reuse over multiple packs, we must
unwind these two assumptions. Most notably, in order to reuse bits from
a given packfile, we need to know the first bit position occupied by
an object form that packfile. To propagate this information around, pass
a `struct bitmapped_pack *` anywhere we previously passed a `struct
packed_git *`, since the former contains the bitmap position we're
interested in (as well as a pointer to the latter).

As an additional step, factor out a sub-routine from the main
`reuse_partial_packfile_from_bitmap()` function, called
`reuse_partial_packfile_from_bitmap_1()`. This new function will be
responsible for figuring out which objects may be reused from a single
pack, and the existing function will dispatch multiple calls to its new
helper function for each reusable pack.

Consequently, `reuse_partial_packfile_from_bitmap()` will now maintain
an array of reusable packs instead of a single such pack. We currently
expect that array to have only a single element, so this awkward state
is short-lived. It will serve as useful scaffolding in subsequent
commits as we begin to work towards enabling multi-pack reuse.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 118 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 87 insertions(+), 31 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index d2f1306960..d64a80c30c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1836,7 +1836,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
  * -1 means "stop trying further objects"; 0 means we may or may not have
  * reused, but you can keep feeding bits.
  */
-static int try_partial_reuse(struct packed_git *pack,
+static int try_partial_reuse(struct bitmapped_pack *pack,
 			     size_t pos,
 			     struct bitmap *reuse,
 			     struct pack_window **w_curs)
@@ -1868,11 +1868,11 @@ static int try_partial_reuse(struct packed_git *pack,
 	 * preferred pack precede all bits from other packs.
 	 */
 
-	if (pos >= pack->num_objects)
+	if (pos >= pack->p->num_objects)
 		return -1; /* not actually in the pack or MIDX preferred pack */
 
-	offset = delta_obj_offset = pack_pos_to_offset(pack, pos);
-	type = unpack_object_header(pack, w_curs, &offset, &size);
+	offset = delta_obj_offset = pack_pos_to_offset(pack->p, pos);
+	type = unpack_object_header(pack->p, w_curs, &offset, &size);
 	if (type < 0)
 		return -1; /* broken packfile, punt */
 
@@ -1888,11 +1888,11 @@ static int try_partial_reuse(struct packed_git *pack,
 		 * and the normal slow path will complain about it in
 		 * more detail.
 		 */
-		base_offset = get_delta_base(pack, w_curs, &offset, type,
+		base_offset = get_delta_base(pack->p, w_curs, &offset, type,
 					     delta_obj_offset);
 		if (!base_offset)
 			return 0;
-		if (offset_to_pack_pos(pack, base_offset, &base_pos) < 0)
+		if (offset_to_pack_pos(pack->p, base_offset, &base_pos) < 0)
 			return 0;
 
 		/*
@@ -1915,14 +1915,14 @@ static int try_partial_reuse(struct packed_git *pack,
 		 * to REF_DELTA on the fly. Better to just let the normal
 		 * object_entry code path handle it.
 		 */
-		if (!bitmap_get(reuse, base_pos))
+		if (!bitmap_get(reuse, pack->bitmap_pos + base_pos))
 			return 0;
 	}
 
 	/*
 	 * If we got here, then the object is OK to reuse. Mark it.
 	 */
-	bitmap_set(reuse, pos);
+	bitmap_set(reuse, pack->bitmap_pos + pos);
 	return 0;
 }
 
@@ -1934,29 +1934,13 @@ uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
 	return nth_midxed_pack_int_id(m, pack_pos_to_midx(bitmap_git->midx, 0));
 }
 
-int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
-				       struct packed_git **packfile_out,
-				       uint32_t *entries,
-				       struct bitmap **reuse_out)
+static void reuse_partial_packfile_from_bitmap_1(struct bitmap_index *bitmap_git,
+						 struct bitmapped_pack *pack,
+						 struct bitmap *reuse)
 {
-	struct repository *r = the_repository;
-	struct packed_git *pack;
 	struct bitmap *result = bitmap_git->result;
-	struct bitmap *reuse;
 	struct pack_window *w_curs = NULL;
 	size_t i = 0;
-	uint32_t offset;
-	uint32_t objects_nr;
-
-	assert(result);
-
-	load_reverse_index(r, bitmap_git);
-
-	if (bitmap_is_midx(bitmap_git))
-		pack = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
-	else
-		pack = bitmap_git->pack;
-	objects_nr = pack->num_objects;
 
 	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
 		i++;
@@ -1969,15 +1953,15 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	 * we use it instead of another pack. In single-pack bitmaps, the choice
 	 * is made for us.
 	 */
-	if (i > objects_nr / BITS_IN_EWORD)
-		i = objects_nr / BITS_IN_EWORD;
+	if (i > pack->p->num_objects / BITS_IN_EWORD)
+		i = pack->p->num_objects / BITS_IN_EWORD;
 
-	reuse = bitmap_word_alloc(i);
 	memset(reuse->words, 0xFF, i * sizeof(eword_t));
 
 	for (; i < result->word_alloc; ++i) {
 		eword_t word = result->words[i];
 		size_t pos = (i * BITS_IN_EWORD);
+		size_t offset;
 
 		for (offset = 0; offset < BITS_IN_EWORD; ++offset) {
 			if ((word >> offset) == 0)
@@ -2002,6 +1986,78 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 
 done:
 	unuse_pack(&w_curs);
+}
+
+static int bitmapped_pack_cmp(const void *va, const void *vb)
+{
+	const struct bitmapped_pack *a = va;
+	const struct bitmapped_pack *b = vb;
+
+	if (a->bitmap_pos < b->bitmap_pos)
+		return -1;
+	if (a->bitmap_pos > b->bitmap_pos)
+		return 1;
+	return 0;
+}
+
+int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
+				       struct packed_git **packfile_out,
+				       uint32_t *entries,
+				       struct bitmap **reuse_out)
+{
+	struct repository *r = the_repository;
+	struct bitmapped_pack *packs = NULL;
+	struct bitmap *result = bitmap_git->result;
+	struct bitmap *reuse;
+	size_t i;
+	size_t packs_nr = 0, packs_alloc = 0;
+	size_t word_alloc;
+	uint32_t objects_nr = 0;
+
+	assert(result);
+
+	load_reverse_index(r, bitmap_git);
+
+	if (bitmap_is_midx(bitmap_git)) {
+		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
+			struct bitmapped_pack pack;
+			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
+				warning(_("unable to load pack: '%s', disabling pack-reuse"),
+					bitmap_git->midx->pack_names[i]);
+				free(packs);
+				return -1;
+			}
+			if (!pack.bitmap_nr)
+				continue; /* no objects from this pack */
+			if (pack.bitmap_pos)
+				continue; /* not preferred pack */
+
+			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
+			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
+
+			objects_nr += pack.p->num_objects;
+		}
+
+		QSORT(packs, packs_nr, bitmapped_pack_cmp);
+	} else {
+		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
+
+		packs[packs_nr].p = bitmap_git->pack;
+		packs[packs_nr].bitmap_pos = 0;
+		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
+
+		objects_nr = packs[packs_nr++].p->num_objects;
+	}
+
+	word_alloc = objects_nr / BITS_IN_EWORD;
+	if (objects_nr % BITS_IN_EWORD)
+		word_alloc++;
+	reuse = bitmap_word_alloc(word_alloc);
+
+	if (packs_nr != 1)
+		BUG("pack reuse not yet implemented for multiple packs");
+
+	reuse_partial_packfile_from_bitmap_1(bitmap_git, packs, reuse);
 
 	*entries = bitmap_popcount(reuse);
 	if (!*entries) {
@@ -2014,7 +2070,7 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 	 * need to be handled separately.
 	 */
 	bitmap_and_not(result, reuse);
-	*packfile_out = pack;
+	*packfile_out = packs[0].p;
 	*reuse_out = reuse;
 	return 0;
 }
-- 
2.43.0.102.ga31d690331.dirty

