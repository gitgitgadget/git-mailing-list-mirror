Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D7C432BE
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601036023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhG0VVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhG0VU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:20:57 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CAC0617A1
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r18so420901iot.4
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IZxRJd/9aIw3DrutM7K7rwwUabByFz6FR5tDEzh2+xY=;
        b=BLiJCFgrBKeyS/9S1WV3Gu/D/n3bm4LJWQfBAOOMSBlYcZgOO+5W3hsXT/YC9vsHys
         uXYkQNWRnSk9amUFNx5CZMSZau3uBHomBRekZfNQta1xwZH0hcC3IUkSR2W2kTyqy6aY
         gnl4JXexCqaRUiJJhhFLki0nPG1v4ZKhBC6sV83vuxJmeAIAQwJcZen6YZfB2PYZsTia
         4KqceDSXeRxK+7TMq9EecB7s1BXUCyub7ZmTaoOhnZ+vd78uaVZx2c6aTEfoIneAUJ8p
         z3BThKaA3O5Iz/OiYj6UxxPoLnxV2tTq5pwEgjGUMrvT1l8tloPdE2b82yCsF3nDCZAK
         sMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IZxRJd/9aIw3DrutM7K7rwwUabByFz6FR5tDEzh2+xY=;
        b=PjzNCA9EXe54RgqzA3redxs/lBQXFHl00TbxqXOk1m4hIQ/roC/I6/wJiV5R7zKdDK
         49kVBSfzi6V3zprhOJvkru3Vk3SAhPkI/vr3pNXy678OfrsQdfJP5kXv4xPVUBJLtBvq
         G+9GQgR+NTxFSNBEzqLcNryK5gLpEmjHEruc+e4SrEIVWSymF9NfTxdPU8MlR4+EOJrr
         P6ZV5rvN5XlV8Tz1sFUAnqWesla8mLP8YOC3C6FBWXSbZNSg0pEK/qqFdeXNdx2O2Ozc
         JzRNADNyGIeIjtX2DK96q/j93pK/0aSwqbqM2s4t8Sq/ObNgHjAE6QcT0iJuEXuW2g8c
         g+Ew==
X-Gm-Message-State: AOAM53181lhZ0Wd5Q9yDalD6payw0SWdeBLqUpP6irOC57MAE/+jGHDi
        VvrVd0vLJ4yAodI8MSrJi085LttLRlbJO4KO
X-Google-Smtp-Source: ABdhPJz4K0Pk2VwVjgT3QrYPpxvcC9jL7IR+MWJqbIc5kIbueFSlxK3GbTnYHKF4YabA1tjftKbC0w==
X-Received: by 2002:a05:6638:1350:: with SMTP id u16mr23044937jad.19.1627420762670;
        Tue, 27 Jul 2021 14:19:22 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id w17sm3172153iom.20.2021.07.27.14.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:22 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:19:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 00/25] multi-pack reachability bitmaps
Message-ID: <cover.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another reroll of my series to implement multi-pack reachability
bitmaps, based on reviews from Ævar and Peff.

Notable changes since last time are summarized here (though a complete
range-diff is below as well):

  - Preventing multiple copies of the same MIDX from being opened, see the new
    patches 8-9 for details.
  - Ensuring preferred packs are non-empty.
  - Simplifying a handful of routines to read from MIDX bitmaps.
  - General code clean-up, removing a few stray hunks, some commit message
    tweaking.

This reroll also dropped three patches present in v2, namely:

  - A patch to build Documentation/technical/bitmap-format.txt (the document is
    poorly formatted and the generated HTML isn't readable).
  - A patch to make some MIDX-related functions non-static (the required
    functions are instead exposed in the patches that first make use of them).
  - A patch to respect `core.multiPackIndex` when writing MIDXs (see patches 8-9
    for the replacement).

Thanks in advance for your review. I think Peff still wanted to read through
patches 16-25, but that the first 15 or so should be in pretty good shape by
now.

Jeff King (2):
  t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
  t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP

Taylor Blau (23):
  pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
  pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
  pack-bitmap-write.c: free existing bitmaps
  Documentation: describe MIDX-based bitmaps
  midx: clear auxiliary .rev after replacing the MIDX
  midx: reject empty `--preferred-pack`'s
  midx: infer preferred pack when not given one
  midx: close linked MIDXs, avoid leaking memory
  midx: avoid opening multiple MIDXs when writing
  pack-bitmap.c: introduce 'bitmap_num_objects()'
  pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
  pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
  pack-bitmap.c: avoid redundant calls to try_partial_reuse
  pack-bitmap: read multi-pack bitmaps
  pack-bitmap: write multi-pack bitmaps
  t5310: move some tests to lib-bitmap.sh
  t/helper/test-read-midx.c: add --checksum mode
  t5326: test multi-pack bitmap behavior
  t5319: don't write MIDX bitmaps in t5319
  t7700: update to work with MIDX bitmap test knob
  midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
  p5310: extract full and partial bitmap tests
  p5326: perf tests for MIDX bitmaps

 Documentation/git-multi-pack-index.txt       |  18 +-
 Documentation/technical/bitmap-format.txt    |  71 ++-
 Documentation/technical/multi-pack-index.txt |  10 +-
 builtin/multi-pack-index.c                   |   2 +
 builtin/pack-objects.c                       |   8 +-
 builtin/repack.c                             |  12 +-
 ci/run-build-and-tests.sh                    |   1 +
 midx.c                                       | 321 +++++++++++-
 midx.h                                       |   5 +
 pack-bitmap-write.c                          |  79 ++-
 pack-bitmap.c                                | 499 ++++++++++++++++---
 pack-bitmap.h                                |   9 +-
 packfile.c                                   |   2 +-
 t/README                                     |   4 +
 t/helper/test-read-midx.c                    |  16 +-
 t/lib-bitmap.sh                              | 240 +++++++++
 t/perf/lib-bitmap.sh                         |  69 +++
 t/perf/p5310-pack-bitmaps.sh                 |  65 +--
 t/perf/p5326-multi-pack-bitmaps.sh           |  43 ++
 t/t0410-partial-clone.sh                     |  12 +-
 t/t5310-pack-bitmaps.sh                      | 231 +--------
 t/t5319-multi-pack-index.sh                  |  20 +-
 t/t5326-multi-pack-bitmaps.sh                | 277 ++++++++++
 t/t7700-repack.sh                            |  18 +-
 24 files changed, 1596 insertions(+), 436 deletions(-)
 create mode 100644 t/perf/lib-bitmap.sh
 create mode 100755 t/perf/p5326-multi-pack-bitmaps.sh
 create mode 100755 t/t5326-multi-pack-bitmaps.sh

Range-diff against v2:
 1:  a18baeb0b4 !  1:  fa4cbed48e pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
    @@ pack-bitmap.c: void count_bitmap_commit_list(struct bitmap_index *bitmap_git,
     +		bitmaps_nr++;
     +	}
     +
    -+	if (!bitmap_type)
    ++	if (bitmap_type == OBJ_NONE)
     +		die("object %s not found in type bitmaps",
     +		    oid_to_hex(&obj->oid));
     +
 2:  3e637d9ec8 =  2:  2b15c1fc5c pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
 3:  490d733d12 =  3:  2ad513a230 pack-bitmap-write.c: free existing bitmaps
 4:  b0bb2e8051 <  -:  ---------- Documentation: build 'technical/bitmap-format' by default
 5:  64a260e0c6 !  4:  8da5de7c24 Documentation: describe MIDX-based bitmaps
    @@ Documentation/technical/bitmap-format.txt
     +
     +		o1 <= o2 <==> pack(o1) <= pack(o2) /\ offset(o1) <= offset(o2)
     +
    -+	The ordering between packs is done lexicographically by the pack name,
    -+	with the exception of the preferred pack, which sorts ahead of all other
    -+	packs.
    ++	The ordering between packs is done according to the MIDX's .rev file.
    ++	Notably, the preferred pack sorts ahead of all other packs.
     +
     +The on-disk representation (described below) of a bitmap is the same regardless
     +of whether or not that bitmap belongs to a packfile or a MIDX. The only
 6:  b3a12424d7 <  -:  ---------- midx: make a number of functions non-static
 7:  1448ca0d2b =  5:  49297f57ed midx: clear auxiliary .rev after replacing the MIDX
 8:  dfd1daacc5 <  -:  ---------- midx: respect 'core.multiPackIndex' when writing
 -:  ---------- >  6:  c5513f2a75 midx: reject empty `--preferred-pack`'s
 9:  9495f6869d !  7:  53ef0a6d67 midx: infer preferred pack when not given one
    @@ Commit message
         Not specifying a preferred pack can cause serious problems with
         multi-pack reachability bitmaps, because these bitmaps rely on having at
         least one pack from which all duplicates are selected. Not having such a
    -    pack causes problems with the pack reuse code (e.g., like assuming that
    -    a base object was sent from that pack via reuse when in fact the base
    -    was selected from a different pack).
    +    pack causes problems with the code in pack-objects to reuse packs
    +    verbatim (e.g., that code assumes that a delta object in a chunk of pack
    +    sent verbatim will have its base object sent from the same pack).
     
         So why does not marking a pack preferred cause problems here? The reason
         is roughly as follows:
    @@ Commit message
             later).
     
           - The psuedo pack-order (described in
    -        Documentation/technical/bitmap-format.txt) is computed by
    +        Documentation/technical/pack-format.txt under the section
    +        "multi-pack-index reverse indexes") is computed by
             midx_pack_order(), and sorts by pack ID and pack offset, with
             preferred packs sorting first.
     
    @@ Commit message
         order, which the bitmap code will treat as the preferred one) did *not*
         have all duplicate objects resolved in its favor, resulting in breakage.
     
    -    The fix is simple: pick a (semi-arbitrary) preferred pack when none was
    -    specified. This forces that pack to have duplicates resolved in its
    -    favor, and (critically) to sort first in pseudo-pack order.
    -    Unfortunately, testing this behavior portably isn't possible, since it
    -    depends on readdir() order which isn't guaranteed by POSIX.
    +    The fix is simple: pick a (semi-arbitrary, non-empty) preferred pack
    +    when none was specified. This forces that pack to have duplicates
    +    resolved in its favor, and (critically) to sort first in pseudo-pack
    +    order.  Unfortunately, testing this behavior portably isn't possible,
    +    since it depends on readdir() order which isn't guaranteed by POSIX.
    +
    +    (Note that multi-pack reachability bitmaps have yet to be implemented;
    +    so in that sense this patch is fixing a bug which does not yet exist.
    +    But by having this patch beforehand, we can prevent the bug from ever
    +    materializing.)
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
     +			warning(_("unknown preferred pack: '%s'"),
     +				preferred_pack_name);
     +	} else if (ctx.nr && (flags & MIDX_WRITE_REV_INDEX)) {
    -+		time_t oldest = ctx.info[0].p->mtime;
    ++		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
     +		ctx.preferred_pack_idx = 0;
     +
     +		if (packs_to_drop && packs_to_drop->nr)
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
     +		 * (and not another pack containing a duplicate)
     +		 */
     +		for (i = 1; i < ctx.nr; i++) {
    -+			time_t mtime = ctx.info[i].p->mtime;
    -+			if (mtime < oldest) {
    -+				oldest = mtime;
    ++			struct packed_git *p = ctx.info[i].p;
    ++
    ++			if (!oldest->num_objects || p->mtime < oldest->mtime) {
    ++				oldest = p;
     +				ctx.preferred_pack_idx = i;
     +			}
     +		}
    ++
    ++		if (!oldest->num_objects) {
    ++			/*
    ++			 * If all packs are empty; unset the preferred index.
    ++			 * This is acceptable since there will be no duplicate
    ++			 * objects to resolve, so the preferred value doesn't
    ++			 * matter.
    ++			 */
    ++			ctx.preferred_pack_idx = -1;
    ++		}
     +	} else {
     +		/*
     +		 * otherwise don't mark any pack as preferred to avoid
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
     +		ctx.preferred_pack_idx = -1;
      	}
      
    - 	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
    + 	if (ctx.preferred_pack_idx > -1) {
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
      						      ctx.info, ctx.nr,
      						      sizeof(*ctx.info),
 -:  ---------- >  8:  114773d9cd midx: close linked MIDXs, avoid leaking memory
 -:  ---------- >  9:  40cff5beb5 midx: avoid opening multiple MIDXs when writing
10:  373aa47528 = 10:  ca7f726abf pack-bitmap.c: introduce 'bitmap_num_objects()'
11:  ac1f46aa1f ! 11:  67e6897a34 pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
    @@ pack-bitmap.c: static inline uint8_t read_u8(const unsigned char *buffer, size_t
      
      #define MAX_XOR_OFFSET 160
      
    -+static void nth_bitmap_object_oid(struct bitmap_index *index,
    -+				  struct object_id *oid,
    -+				  uint32_t n)
    ++static int nth_bitmap_object_oid(struct bitmap_index *index,
    ++				 struct object_id *oid,
    ++				 uint32_t n)
     +{
    -+	nth_packed_object_id(oid, index->pack, n);
    ++	return nth_packed_object_id(oid, index->pack, n);
     +}
     +
      static int load_bitmap_entries_v1(struct bitmap_index *index)
    @@ pack-bitmap.c: static int load_bitmap_entries_v1(struct bitmap_index *index)
      		flags = read_u8(index->map, &index->map_pos);
      
     -		if (nth_packed_object_id(&oid, index->pack, commit_idx_pos) < 0)
    --			return error("corrupt ewah bitmap: commit index %u out of range",
    --				     (unsigned)commit_idx_pos);
    -+		nth_bitmap_object_oid(index, &oid, commit_idx_pos);
    ++		if (nth_bitmap_object_oid(index, &oid, commit_idx_pos) < 0)
    + 			return error("corrupt ewah bitmap: commit index %u out of range",
    + 				     (unsigned)commit_idx_pos);
      
    - 		bitmap = read_bitmap_1(index);
    - 		if (!bitmap)
     @@ pack-bitmap.c: static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
      		off_t ofs = pack_pos_to_offset(pack, pos);
      		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
12:  c474d2eda5 ! 12:  743a1a138e pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
    @@ Commit message
         'pack.preferBitmapTips' configuration. This patch prepares the
         multi-pack bitmap code to respect this configuration, too.
     
    -    Since the multi-pack bitmap code already does a traversal of all
    -    references (in order to discover the set of reachable commits in the
    -    multi-pack index), it is more efficient to check whether or not each
    -    reference is a suffix of any value of 'pack.preferBitmapTips' rather
    -    than do an additional traversal.
    +    The yet-to-be implemented code will find that it is more efficient to
    +    check whether each reference contains a prefix found in the configured
    +    set of values rather than doing an additional traversal.
     
    -    Implement a function 'bitmap_is_preferred_refname()' which does just
    -    that. The caller will be added in a subsequent patch.
    +    Implement a function 'bitmap_is_preferred_refname()' which will perform
    +    that check. Its caller will be added in a subsequent patch.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
 -:  ---------- > 13:  a3b641b3e6 pack-bitmap.c: avoid redundant calls to try_partial_reuse
13:  7d44ba6299 ! 14:  141ff83275 pack-bitmap: read multi-pack bitmaps
    @@ Commit message
         in a MIDX.
     
         Note that there are currently no writers who write multi-pack bitmaps,
    -    and that this will be implemented in the subsequent commit.
    +    and that this will be implemented in the subsequent commit. Note also
    +    that get_midx_checksum() and get_midx_filename() are made non-static so
    +    they can be called from pack-bitmap.c.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ builtin/pack-objects.c: static void write_reused_pack(struct hashfile *f)
      			display_progress(progress_state, ++written);
      		}
     
    + ## midx.c ##
    +@@ midx.c: static uint8_t oid_version(void)
    + 	}
    + }
    + 
    +-static const unsigned char *get_midx_checksum(struct multi_pack_index *m)
    ++const unsigned char *get_midx_checksum(struct multi_pack_index *m)
    + {
    + 	return m->data + m->data_len - the_hash_algo->rawsz;
    + }
    + 
    +-static char *get_midx_filename(const char *object_dir)
    ++char *get_midx_filename(const char *object_dir)
    + {
    + 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
    + }
    +
    + ## midx.h ##
    +@@ midx.h: struct multi_pack_index {
    + #define MIDX_PROGRESS     (1 << 0)
    + #define MIDX_WRITE_REV_INDEX (1 << 1)
    + 
    ++const unsigned char *get_midx_checksum(struct multi_pack_index *m);
    ++char *get_midx_filename(const char *object_dir);
    + char *get_midx_rev_filename(struct multi_pack_index *m);
    + 
    + struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local);
    +
      ## pack-bitmap-write.c ##
     @@ pack-bitmap-write.c: void bitmap_writer_show_progress(int show)
      }
    @@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
      	index->map_pos += header_size;
      	return 0;
      }
    -@@ pack-bitmap.c: static void nth_bitmap_object_oid(struct bitmap_index *index,
    - 				  struct object_id *oid,
    - 				  uint32_t n)
    +@@ pack-bitmap.c: static int nth_bitmap_object_oid(struct bitmap_index *index,
    + 				 struct object_id *oid,
    + 				 uint32_t n)
      {
    --	nth_packed_object_id(oid, index->pack, n);
     +	if (index->midx)
    -+		nth_midxed_object_oid(oid, index->midx, n);
    -+	else
    -+		nth_packed_object_id(oid, index->pack, n);
    ++		return nth_midxed_object_oid(oid, index->midx, n) ? 0 : -1;
    + 	return nth_packed_object_id(oid, index->pack, n);
      }
      
    - static int load_bitmap_entries_v1(struct bitmap_index *index)
     @@ pack-bitmap.c: static int load_bitmap_entries_v1(struct bitmap_index *index)
      	return 0;
      }
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
      		warning("ignoring extra bitmap file: %s", packfile->pack_name);
      		close(fd);
      		return -1;
    - 	}
    - 
    -+	if (!is_pack_valid(packfile)) {
    -+		close(fd);
    -+		return -1;
    -+	}
    -+
    - 	bitmap_git->pack = packfile;
    - 	bitmap_git->map_size = xsize_t(st.st_size);
    - 	bitmap_git->map = xmmap(NULL, bitmap_git->map_size, PROT_READ, MAP_PRIVATE, fd, 0);
     @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
      	return 0;
      }
    @@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, st
     +		uint32_t i;
     +		int ret;
     +
    -+		ret = load_midx_revindex(bitmap_git->midx);
    -+		if (ret)
    -+			return ret;
    -+
    ++		/*
    ++		 * The multi-pack-index's .rev file is already loaded via
    ++		 * open_pack_bitmap_1().
    ++		 *
    ++		 * But we still need to open the individual pack .rev files,
    ++		 * since we will need to make use of them in pack-objects.
    ++		 */
     +		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
     +			if (prepare_midx_pack(the_repository, bitmap_git->midx, i))
     +				die(_("load_reverse_index: could not open pack"));
    @@ pack-bitmap.c: static int open_pack_bitmap(struct repository *r,
      
     -	if (!open_pack_bitmap(r, bitmap_git) && !load_pack_bitmap(bitmap_git))
     +	if (!open_bitmap(r, bitmap_git) && !load_bitmap(bitmap_git))
    ++		return bitmap_git;
    ++
    ++	free_bitmap_index(bitmap_git);
    ++	return NULL;
    ++}
    ++
    ++struct bitmap_index *prepare_midx_bitmap_git(struct repository *r,
    ++					     struct multi_pack_index *midx)
    ++{
    ++	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
    ++
    ++	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(bitmap_git))
      		return bitmap_git;
      
      	free_bitmap_index(bitmap_git);
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
      
      	object_array_clear(&revs->pending);
     @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    - }
    - 
    - static void try_partial_reuse(struct bitmap_index *bitmap_git,
    -+			      struct packed_git *pack,
    - 			      size_t pos,
    - 			      struct bitmap *reuse,
    - 			      struct pack_window **w_curs)
    +  * reused, but you can keep feeding bits.
    +  */
    + static int try_partial_reuse(struct bitmap_index *bitmap_git,
    ++			     struct packed_git *pack,
    + 			     size_t pos,
    + 			     struct bitmap *reuse,
    + 			     struct pack_window **w_curs)
      {
     -	off_t offset, header;
     +	off_t offset, delta_obj_offset;
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
      	unsigned long size;
      
     -	if (pos >= bitmap_num_objects(bitmap_git))
    --		return; /* not actually in the pack or MIDX */
    +-		return -1; /* not actually in the pack or MIDX */
     +	/*
     +	 * try_partial_reuse() is called either on (a) objects in the
     +	 * bitmapped pack (in the case of a single-pack bitmap) or (b)
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
     -	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
     -	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
     +	if (pos >= pack->num_objects)
    -+		return; /* not actually in the pack or MIDX preferred pack */
    ++		return -1; /* not actually in the pack or MIDX preferred pack */
     +
     +	offset = delta_obj_offset = pack_pos_to_offset(pack, pos);
     +	type = unpack_object_header(pack, w_curs, &offset, &size);
      	if (type < 0)
    - 		return; /* broken packfile, punt */
    + 		return -1; /* broken packfile, punt */
      
    -@@ pack-bitmap.c: static void try_partial_reuse(struct bitmap_index *bitmap_git,
    +@@ pack-bitmap.c: static int try_partial_reuse(struct bitmap_index *bitmap_git,
      		 * and the normal slow path will complain about it in
      		 * more detail.
      		 */
    @@ pack-bitmap.c: static void try_partial_reuse(struct bitmap_index *bitmap_git,
     +		base_offset = get_delta_base(pack, w_curs, &offset, type,
     +					     delta_obj_offset);
      		if (!base_offset)
    - 			return;
    + 			return 0;
     -		if (offset_to_pack_pos(bitmap_git->pack, base_offset, &base_pos) < 0)
     +		if (offset_to_pack_pos(pack, base_offset, &base_pos) < 0)
    - 			return;
    + 			return 0;
      
      		/*
    -@@ pack-bitmap.c: static void try_partial_reuse(struct bitmap_index *bitmap_git,
    - 	bitmap_set(reuse, pos);
    +@@ pack-bitmap.c: static int try_partial_reuse(struct bitmap_index *bitmap_git,
    + 	return 0;
      }
      
     +static uint32_t midx_preferred_pack(struct bitmap_index *bitmap_git)
    @@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitma
      				break;
      
      			offset += ewah_bit_ctz64(word >> offset);
    --			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
    -+			if (bitmap_is_midx(bitmap_git)) {
    -+				/*
    -+				 * Can't reuse from a non-preferred pack (see
    -+				 * above).
    -+				 */
    -+				if (pos + offset >= objects_nr)
    -+					continue;
    -+			}
    -+			try_partial_reuse(bitmap_git, pack, pos + offset, reuse, &w_curs);
    - 		}
    - 	}
    - 
    +-			if (try_partial_reuse(bitmap_git, pos + offset, reuse,
    +-					      &w_curs) < 0) {
    ++			if (try_partial_reuse(bitmap_git, pack, pos + offset,
    ++					      reuse, &w_curs) < 0) {
    + 				/*
    + 				 * try_partial_reuse indicated we couldn't reuse
    + 				 * any bits, so there is no point in trying more
     @@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
      	 * need to be handled separately.
      	 */
    @@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_
      {
      	struct bitmap *result = bitmap_git->result;
     -	struct packed_git *pack = bitmap_git->pack;
    -+	struct packed_git *pack;
      	off_t total = 0;
      	struct ewah_iterator it;
      	eword_t filter;
     @@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
    + 			continue;
    + 
    + 		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
    +-			size_t pos;
    +-
    + 			if ((word >> offset) == 0)
      				break;
      
      			offset += ewah_bit_ctz64(word >> offset);
     -			pos = base + offset;
    +-			total += pack_pos_to_offset(pack, pos + 1) -
    +-				 pack_pos_to_offset(pack, pos);
     +
     +			if (bitmap_is_midx(bitmap_git)) {
     +				uint32_t pack_pos;
     +				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, base + offset);
    -+				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
     +				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
     +
    -+				pack = bitmap_git->midx->packs[pack_id];
    ++				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
    ++				struct packed_git *pack = bitmap_git->midx->packs[pack_id];
     +
     +				if (offset_to_pack_pos(pack, offset, &pack_pos) < 0) {
     +					struct object_id oid;
     +					nth_midxed_object_oid(&oid, bitmap_git->midx, midx_pos);
     +
    -+					die(_("could not find %s in pack #%"PRIu32" at offset %"PRIuMAX),
    ++					die(_("could not find %s in pack %s at offset %"PRIuMAX),
     +					    oid_to_hex(&oid),
    -+					    pack_id,
    ++					    pack->pack_name,
     +					    (uintmax_t)offset);
     +				}
     +
    -+				pos = pack_pos;
    ++				total += pack_pos_to_offset(pack, pack_pos + 1) - offset;
     +			} else {
    -+				pack = bitmap_git->pack;
    -+				pos = base + offset;
    ++				size_t pos = base + offset;
    ++				total += pack_pos_to_offset(bitmap_git->pack, pos + 1) -
    ++					 pack_pos_to_offset(bitmap_git->pack, pos);
     +			}
    -+
    - 			total += pack_pos_to_offset(pack, pos + 1) -
    - 				 pack_pos_to_offset(pack, pos);
      		}
    + 	}
    + 
     @@ pack-bitmap.c: off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
      	return total;
      }
    @@ pack-bitmap.c: off_t get_disk_usage_from_bitmap(struct bitmap_index *bitmap_git,
     +{
     +	return !!bitmap_git->midx;
     +}
    -+
    -+off_t bitmap_pack_offset(struct bitmap_index *bitmap_git, uint32_t pos)
    -+{
    -+	if (bitmap_is_midx(bitmap_git))
    -+		return nth_midxed_offset(bitmap_git->midx,
    -+					 pack_pos_to_midx(bitmap_git->midx, pos));
    -+	return nth_packed_object_offset(bitmap_git->pack,
    -+					pack_pos_to_index(bitmap_git->pack, pos));
    -+}
     +
      const struct string_list *bitmap_preferred_tips(struct repository *r)
      {
      	return repo_config_get_value_multi(r, "pack.preferbitmaptips");
     
      ## pack-bitmap.h ##
    +@@ pack-bitmap.h: typedef int (*show_reachable_fn)(
    + struct bitmap_index;
    + 
    + struct bitmap_index *prepare_bitmap_git(struct repository *r);
    ++struct bitmap_index *prepare_midx_bitmap_git(struct repository *r,
    ++					     struct multi_pack_index *midx);
    + void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
    + 			      uint32_t *trees, uint32_t *blobs, uint32_t *tags);
    + void traverse_bitmap_commit_list(struct bitmap_index *,
     @@ pack-bitmap.h: void bitmap_writer_finish(struct pack_idx_entry **index,
      			  uint32_t index_nr,
      			  const char *filename,
    @@ pack-bitmap.h: void bitmap_writer_finish(struct pack_idx_entry **index,
     +char *pack_bitmap_filename(struct packed_git *p);
     +
     +int bitmap_is_midx(struct bitmap_index *bitmap_git);
    -+off_t bitmap_pack_offset(struct bitmap_index *bitmap_git, uint32_t pos);
      
      const struct string_list *bitmap_preferred_tips(struct repository *r);
      int bitmap_is_preferred_refname(struct repository *r, const char *refname);
14:  a8cec2463d ! 15:  54600b5814 pack-bitmap: write multi-pack bitmaps
    @@ Documentation/git-multi-pack-index.txt: SYNOPSIS
      DESCRIPTION
      -----------
     @@ Documentation/git-multi-pack-index.txt: write::
    - 		multiple packs contain the same object. If not given,
    - 		ties are broken in favor of the pack with the lowest
    - 		mtime.
    + 		multiple packs contain the same object. `<pack>` must
    + 		contain at least one object. If not given, ties are
    + 		broken in favor of the pack with the lowest mtime.
     +
     +	--[no-]bitmap::
     +		Control whether or not a multi-pack bitmap is written.
    @@ Documentation/git-multi-pack-index.txt: EXAMPLES
     +corresponding bitmap.
     ++
     +-------------------------------------------------------------
    -+$ git multi-pack-index write --preferred-pack <pack> --bitmap
    ++$ git multi-pack-index write --preferred-pack=<pack> --bitmap
     +-------------------------------------------------------------
     +
      * Write a MIDX file for the packfiles in an alternate object store.
    @@ midx.c
      
      #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
      #define MIDX_VERSION 1
    -@@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
    - static void clear_midx_files_ext(struct repository *r, const char *ext,
    - 				 unsigned char *keep_hash);
    +@@ midx.c: static int midx_checksum_valid(struct multi_pack_index *m)
    + 	return hashfile_checksum_valid(m->data, m->data_len);
    + }
      
     +static void prepare_midx_packing_data(struct packing_data *pdata,
     +				      struct write_midx_context *ctx)
    @@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *mid
     +static void bitmap_show_commit(struct commit *commit, void *_data)
     +{
     +	struct bitmap_commit_cb *data = _data;
    -+	if (oid_pos(&commit->object.oid, data->ctx->entries,
    -+		    data->ctx->entries_nr,
    -+		    bitmap_oid_access) > -1) {
    -+		ALLOC_GROW(data->commits, data->commits_nr + 1,
    -+			   data->commits_alloc);
    -+		data->commits[data->commits_nr++] = commit;
    -+	}
    ++	int pos = oid_pos(&commit->object.oid, data->ctx->entries,
    ++			  data->ctx->entries_nr,
    ++			  bitmap_oid_access);
    ++	if (pos < 0)
    ++		return;
    ++
    ++	ALLOC_GROW(data->commits, data->commits_nr + 1, data->commits_alloc);
    ++	data->commits[data->commits_nr++] = commit;
     +}
     +
     +static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
     +						    struct write_midx_context *ctx)
     +{
     +	struct rev_info revs;
    -+	struct bitmap_commit_cb cb;
    ++	struct bitmap_commit_cb cb = {0};
     +
    -+	memset(&cb, 0, sizeof(struct bitmap_commit_cb));
     +	cb.ctx = ctx;
     +
     +	repo_init_revisions(the_repository, &revs, NULL);
    ++	setup_revisions(0, NULL, &revs, NULL);
     +	for_each_ref(add_ref_to_pending, &revs);
     +
     +	/*
    @@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *mid
     +	fetch_if_missing = 0;
     +	revs.exclude_promisor_objects = 1;
     +
    -+	/*
    -+	 * Pass selected commits in topo order to match the behavior of
    -+	 * pack-bitmaps when configured with delta islands.
    -+	 */
    -+	revs.topo_order = 1;
    -+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
    -+
     +	if (prepare_revision_walk(&revs))
     +		die(_("revision walk setup failed"));
     +
    @@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *mid
     +	 */
     +	ALLOC_ARRAY(index, pdata.nr_objects);
     +	for (i = 0; i < pdata.nr_objects; i++)
    -+		index[i] = (struct pack_idx_entry *)&pdata.objects[i];
    ++		index[i] = &pdata.objects[i].idx;
     +
     +	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
     +	bitmap_writer_build_type_index(&pdata, index, pdata.nr_objects);
    @@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *mid
     +	 * bitmap_writer_finish().
     +	 */
     +	for (i = 0; i < pdata.nr_objects; i++)
    -+		index[ctx->pack_order[i]] = (struct pack_idx_entry *)&pdata.objects[i];
    ++		index[ctx->pack_order[i]] = &pdata.objects[i].idx;
     +
     +	bitmap_writer_select_commits(commits, commits_nr, -1);
     +	ret = bitmap_writer_build(&pdata);
    @@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *mid
     +	return ret;
     +}
     +
    - static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
    + static int write_midx_internal(const char *object_dir,
      			       struct string_list *packs_to_drop,
      			       const char *preferred_pack_name,
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    - 		for (i = 0; i < ctx.m->num_packs; i++) {
    - 			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
    +@@ midx.c: static int write_midx_internal(const char *object_dir,
      
    -+			if (prepare_midx_pack(the_repository, ctx.m, i)) {
    -+				error(_("could not load pack %s"),
    -+				      ctx.m->pack_names[i]);
    -+				result = 1;
    -+				goto cleanup;
    -+			}
    -+
      			ctx.info[ctx.nr].orig_pack_int_id = i;
      			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
     -			ctx.info[ctx.nr].p = NULL;
     +			ctx.info[ctx.nr].p = ctx.m->packs[i];
      			ctx.info[ctx.nr].expired = 0;
    - 			ctx.nr++;
    - 		}
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    + 
    + 			if (flags & MIDX_WRITE_REV_INDEX) {
    +@@ midx.c: static int write_midx_internal(const char *object_dir,
      	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &ctx);
      	stop_progress(&ctx.progress);
      
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
     +		int bitmap_exists;
     +		int want_bitmap = flags & MIDX_WRITE_BITMAP;
     +
    -+		bitmap_git = prepare_bitmap_git(the_repository);
    ++		bitmap_git = prepare_midx_bitmap_git(the_repository, ctx.m);
     +		bitmap_exists = bitmap_git && bitmap_is_midx(bitmap_git);
     +		free_bitmap_index(bitmap_git);
     +
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      
      	if (preferred_pack_name) {
      		int found = 0;
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    +@@ midx.c: static int write_midx_internal(const char *object_dir,
      		if (!found)
      			warning(_("unknown preferred pack: '%s'"),
      				preferred_pack_name);
     -	} else if (ctx.nr && (flags & MIDX_WRITE_REV_INDEX)) {
     +	} else if (ctx.nr &&
     +		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
    - 		time_t oldest = ctx.info[0].p->mtime;
    + 		struct packed_git *oldest = ctx.info[ctx.preferred_pack_idx].p;
      		ctx.preferred_pack_idx = 0;
      
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    +@@ midx.c: static int write_midx_internal(const char *object_dir,
      	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
      	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
      
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      	if (ctx.nr - dropped_packs == 0) {
      		error(_("no pack files to index."));
      		result = 1;
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    +@@ midx.c: static int write_midx_internal(const char *object_dir,
      	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
      	free_chunkfile(cf);
      
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
     +			goto cleanup;
     +		}
     +	}
    ++
    ++	close_midx(ctx.m);
      
      	commit_lock_file(&lk);
      
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      	clear_midx_files_ext(the_repository, ".rev", midx_hash);
      
      cleanup:
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    - 		if (ctx.info[i].p) {
    - 			close_pack(ctx.info[i].p);
    - 			free(ctx.info[i].p);
    -+			if (ctx.m) {
    -+				/*
    -+				 * Destroy a stale reference to the pack in
    -+				 * 'ctx.m'.
    -+				 */
    -+				uint32_t orig = ctx.info[i].orig_pack_int_id;
    -+				if (orig < ctx.m->num_packs)
    -+					ctx.m->packs[orig] = NULL;
    -+			}
    - 		}
    - 		free(ctx.info[i].pack_name);
    - 	}
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    +@@ midx.c: static int write_midx_internal(const char *object_dir,
      	free(ctx.pack_perm);
      	free(ctx.pack_order);
      	free(midx_name);
    -+	if (ctx.m)
    -+		close_midx(ctx.m);
     +
      	return result;
      }
15:  c63eb637c8 = 16:  168b7b0976 t5310: move some tests to lib-bitmap.sh
16:  bedb7afb37 = 17:  60ec8b3466 t/helper/test-read-midx.c: add --checksum mode
17:  fbfac4ae8e = 18:  3258ccfc1c t5326: test multi-pack bitmap behavior
18:  2a5df1832a = 19:  47c7e6bb9b t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
19:  2d24c5b7ad = 20:  6a708858b1 t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
20:  4cbfaa0e97 = 21:  1eaa744b24 t5319: don't write MIDX bitmaps in t5319
21:  839a7a79eb = 22:  a4a899e31f t7700: update to work with MIDX bitmap test knob
22:  00418d5b09 ! 23:  50865e52a3 midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      		if (!(pack_everything & ALL_INTO_ONE) ||
      		    !is_bare_repository())
      			write_bitmaps = 0;
    --	}
     +	} else if (write_bitmaps &&
     +		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
    -+		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0))
    ++		   git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0)) {
     +		write_bitmaps = 0;
    + 	}
      	if (pack_kept_objects < 0)
      		pack_kept_objects = write_bitmaps > 0;
    - 
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
      		update_server_info(0);
      	remove_temporary_files();
23:  98fa73a76a = 24:  0f1fd6e7d4 p5310: extract full and partial bitmap tests
24:  ec0f53b424 = 25:  82e8133bf4 p5326: perf tests for MIDX bitmaps
-- 
2.31.1.163.ga65ce7f831
