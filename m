Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C33C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580EA6124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhFUW1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFUW1N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:13 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A36FC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:24:58 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g22so3925519iom.1
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hKwCWs4UFFqaK7hpInFsUAtnMgHY3nO0d9DeGDhlcC4=;
        b=WX7GTrvO2wKXNNL16h/UuOr32SI0frnmT/CJlRqrUEyhsiNux5WJIo+zHh5GQiCASF
         UiNK7cHFawah5/oUui7SuIQgAMQSIrePKFoB8ZkzElXy1v7QKLbxSAKmerBm6CYp8z+Z
         jr31AgaLft7lNQt2DkJVWdiUT+pDZP6QgnHLjPDC985tugAisizzI19ZPt1nMZVSqN7W
         eKLQYgOgJ0R6Km9C03avKp4HRuiXReqH1k6s+SXqs9Dg5Ad+zioxYvpTLNYrucwS7Pia
         Mv04YtluSBIJK/9yxX1DQ6c0BVhGzRZKKzu0qkBu2gBlganrswnoleaFcxqinAo/kk8q
         Wf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hKwCWs4UFFqaK7hpInFsUAtnMgHY3nO0d9DeGDhlcC4=;
        b=eRHOlL60rezQ4Shl74WwGIHwDdDjRIdJ7xuHhO3PHiYBA+HQTbVONAyz5qpxHcsh0w
         Mb7qTd1/mQMCBzSe7WHaqgdxWg0kqG7roTb1FJ9txLEHlMXHGSZDs9cWxmeh+oc4ZJAc
         BPWEJl7DEJbECrZ6VUHcOBUIRa+zNsH93zQD+L6J2YIx9E5GHz0nuWXqU3ejylmX9yXO
         dMWKIpz+XCf1PLH2hwXppmJnkNJ885YZoGAmcXbh8PKsv8kQRHRlwM1Am+dKyi9nchKR
         nYZ1tj4KJvamyVz3SMQ54+3fbNtFOuX0+6R78MI2YQQElfmJi9AoUZWLO6tMj2QjnI27
         YGAw==
X-Gm-Message-State: AOAM531IpKTCZpRXxyerqIv1x1yZfRDlzEHwVsWRdMahCT2nIwsgxv50
        fVJO68XEuy+WkWZZOrjxCvU+cwJeMjltdrP7
X-Google-Smtp-Source: ABdhPJy2E5mE5vH0MeK2UyFBZ0NPvqlLoffdRALA8EgvdyieyYZ9BsOZXdGAkYQ1sGI/z3syCjfmpA==
X-Received: by 2002:a5d:8b8b:: with SMTP id p11mr228951iol.77.1624314297348;
        Mon, 21 Jun 2021 15:24:57 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id h18sm3195719ilr.86.2021.06.21.15.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:24:56 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:24:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 00/24] multi-pack reachability bitmaps
Message-ID: <cover.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series to implement multi-pack reachability bitmaps. It
is based on 'master', and incorporates a handful of changes from an earlier
round of review from Jonathan Tan, as well as a handful of tweaks useful to us
at GitHub that we've picked up over a few months of running these patches in
production.

I have been quite behind in sending this to the list because a number of
non-work things that have kept me busy. But those seem to have settled down, so
here is a second reroll.

Notable changes since last time are summarized here (though a complete
range-diff is below):

  - A preferred pack is inferred when not otherwise specified. This fixes a
    nasty bug dependent on readdir() ordering which can cause bitmap corruption.
    See the new ninth patch for the gory details.
  - A bug which broke CI on 'seen' is fixed where t0410.27 would fail when
    writing a bitmap (as is the case when
    GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1 is set).
  - Comments in unclear portions of the code having to do with promisor objects,
    and object order when fed to bitmap writing routines are added.
  - A number of spots dealing with pack reuse were simplified to avoid using the
    MIDX's .rev file where unnecessary (along with a comment explaining why the
    optimization is possible in the first place).

Thanks in advance for your review, and sorry for the wait.

Jeff King (2):
  t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
  t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP

Taylor Blau (22):
  pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
  pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
  pack-bitmap-write.c: free existing bitmaps
  Documentation: build 'technical/bitmap-format' by default
  Documentation: describe MIDX-based bitmaps
  midx: make a number of functions non-static
  midx: clear auxiliary .rev after replacing the MIDX
  midx: respect 'core.multiPackIndex' when writing
  midx: infer preferred pack when not given one
  pack-bitmap.c: introduce 'bitmap_num_objects()'
  pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
  pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
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

 Documentation/Makefile                       |   1 +
 Documentation/git-multi-pack-index.txt       |  12 +-
 Documentation/technical/bitmap-format.txt    |  72 ++-
 Documentation/technical/multi-pack-index.txt |  10 +-
 builtin/multi-pack-index.c                   |   2 +
 builtin/pack-objects.c                       |   8 +-
 builtin/repack.c                             |  13 +-
 ci/run-build-and-tests.sh                    |   1 +
 midx.c                                       | 288 +++++++++++-
 midx.h                                       |   5 +
 pack-bitmap-write.c                          |  79 +++-
 pack-bitmap.c                                | 470 +++++++++++++++++--
 pack-bitmap.h                                |   8 +-
 packfile.c                                   |   2 +-
 t/README                                     |   4 +
 t/helper/test-read-midx.c                    |  16 +-
 t/lib-bitmap.sh                              | 240 ++++++++++
 t/perf/lib-bitmap.sh                         |  69 +++
 t/perf/p5310-pack-bitmaps.sh                 |  65 +--
 t/perf/p5326-multi-pack-bitmaps.sh           |  43 ++
 t/t0410-partial-clone.sh                     |  12 +-
 t/t5310-pack-bitmaps.sh                      | 231 +--------
 t/t5319-multi-pack-index.sh                  |   3 +-
 t/t5326-multi-pack-bitmaps.sh                | 277 +++++++++++
 t/t7700-repack.sh                            |  18 +-
 25 files changed, 1534 insertions(+), 415 deletions(-)
 create mode 100644 t/perf/lib-bitmap.sh
 create mode 100755 t/perf/p5326-multi-pack-bitmaps.sh
 create mode 100755 t/t5326-multi-pack-bitmaps.sh

Range-diff against v1:
 1:  2d1c6ccab5 =  1:  a18baeb0b4 pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
 2:  d199954ef2 !  2:  3e637d9ec8 pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
    @@ Commit message
         bitmaps would be incomplete).
     
         Pack bitmaps are never written from 'git repack' unless repacking
    -    all-into-one, and so we never write non-closed bitmaps.
    +    all-into-one, and so we never write non-closed bitmaps (except in the
    +    case of partial clones where we aren't guaranteed to have all objects).
     
         But multi-pack bitmaps change this, since it isn't known whether the
         set of objects in the MIDX is closed under reachability until walking
    @@ Commit message
         include in the bitmap, bitmap_writer_build() knows that the set is not
         closed, and so it now fails gracefully.
     
    -    (The new conditional in builtin/pack-objects.c:bitmap_writer_build()
    -    guards against other failure modes, but is never triggered here, because
    -    of the all-into-one detail above. This return value will be important to
    -    check from the multi-pack index caller.)
    +    A test is added in t0410 to trigger a bitmap write without full
    +    reachability closure by removing local copies of some reachable objects
    +    from a promisor remote.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ pack-bitmap-write.c: void bitmap_writer_build(struct packing_data *to_pack)
     -	compute_xor_offsets();
     +	if (closed)
     +		compute_xor_offsets();
    -+	return closed;
    ++	return closed ? 0 : -1;
      }
      
      /**
    @@ pack-bitmap.h: struct ewah_bitmap *bitmap_for_commit(struct bitmap_index *bitmap
      void bitmap_writer_finish(struct pack_idx_entry **index,
      			  uint32_t index_nr,
      			  const char *filename,
    +
    + ## t/t0410-partial-clone.sh ##
    +@@ t/t0410-partial-clone.sh: test_expect_success 'gc does not repack promisor objects if there are none' '
    + repack_and_check () {
    + 	rm -rf repo2 &&
    + 	cp -r repo repo2 &&
    +-	git -C repo2 repack $1 -d &&
    ++	if test x"$1" = "x--must-fail"
    ++	then
    ++		shift
    ++		test_must_fail git -C repo2 repack $1 -d
    ++	else
    ++		git -C repo2 repack $1 -d
    ++	fi &&
    + 	git -C repo2 fsck &&
    + 
    + 	git -C repo2 cat-file -e $2 &&
    +@@ t/t0410-partial-clone.sh: test_expect_success 'repack -d does not irreversibly delete promisor objects' '
    + 	printf "$THREE\n" | pack_as_from_promisor &&
    + 	delete_object repo "$ONE" &&
    + 
    ++	repack_and_check --must-fail -ab "$TWO" "$THREE" &&
    + 	repack_and_check -a "$TWO" "$THREE" &&
    + 	repack_and_check -A "$TWO" "$THREE" &&
    + 	repack_and_check -l "$TWO" "$THREE"
 3:  014c18b896 =  3:  490d733d12 pack-bitmap-write.c: free existing bitmaps
 4:  46de889cd2 =  4:  b0bb2e8051 Documentation: build 'technical/bitmap-format' by default
 5:  0d4822a64e =  5:  64a260e0c6 Documentation: describe MIDX-based bitmaps
 6:  c76dfc198e =  6:  b3a12424d7 midx: make a number of functions non-static
 7:  26c3a312f9 =  7:  1448ca0d2b midx: clear auxiliary .rev after replacing the MIDX
 8:  8643174a67 =  8:  dfd1daacc5 midx: respect 'core.multiPackIndex' when writing
 -:  ---------- >  9:  9495f6869d midx: infer preferred pack when not given one
 9:  af507f4b29 = 10:  373aa47528 pack-bitmap.c: introduce 'bitmap_num_objects()'
10:  a6fdf7234a = 11:  ac1f46aa1f pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
11:  a78f83a127 = 12:  c474d2eda5 pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
12:  d5eeca4f11 ! 13:  7d44ba6299 pack-bitmap: read multi-pack bitmaps
    @@ builtin/pack-objects.c: static void write_reused_pack(struct hashfile *f)
      				break;
      
      			offset += ewah_bit_ctz64(word >> offset);
    --			write_reused_pack_one(pos + offset, f, &w_curs);
    -+			if (bitmap_is_midx(bitmap_git)) {
    -+				off_t pack_offs = bitmap_pack_offset(bitmap_git,
    -+								     pos + offset);
    -+				uint32_t pos;
    -+
    -+				if (offset_to_pack_pos(reuse_packfile, pack_offs, &pos) < 0)
    -+					die(_("write_reused_pack: could not locate %"PRIdMAX),
    -+					    (intmax_t)pack_offs);
    -+				write_reused_pack_one(pos, f, &w_curs);
    -+			} else
    -+				write_reused_pack_one(pos + offset, f, &w_curs);
    ++			/*
    ++			 * Can use bit positions directly, even for MIDX
    ++			 * bitmaps. See comment in try_partial_reuse()
    ++			 * for why.
    ++			 */
    + 			write_reused_pack_one(pos + offset, f, &w_curs);
      			display_progress(progress_state, ++written);
      		}
    - 	}
     
      ## pack-bitmap-write.c ##
     @@ pack-bitmap-write.c: void bitmap_writer_show_progress(int show)
    @@ pack-bitmap.c: struct bitmap_index {
      	/* If not NULL, this is a name-hash cache pointing into map. */
      	uint32_t *hashes;
      
    ++	/* The checksum of the packfile or MIDX; points into map. */
     +	const unsigned char *checksum;
     +
      	/*
    @@ pack-bitmap.c: static char *pack_bitmap_filename(struct packed_git *p)
     +
     +	if (bitmap_git->pack || bitmap_git->midx) {
     +		/* ignore extra bitmap file; we can only handle one */
    ++		warning("ignoring extra bitmap file: %s",
    ++			get_midx_filename(midx->object_dir));
    ++		close(fd);
     +		return -1;
     +	}
     +
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
      		goto cleanup;
      
      	object_array_clear(&revs->pending);
    -@@ pack-bitmap.c: static void try_partial_reuse(struct bitmap_index *bitmap_git,
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    + }
    + 
    + static void try_partial_reuse(struct bitmap_index *bitmap_git,
    ++			      struct packed_git *pack,
    + 			      size_t pos,
      			      struct bitmap *reuse,
      			      struct pack_window **w_curs)
      {
     -	off_t offset, header;
    -+	struct packed_git *pack;
     +	off_t offset, delta_obj_offset;
      	enum object_type type;
      	unsigned long size;
      
    - 	if (pos >= bitmap_num_objects(bitmap_git))
    - 		return; /* not actually in the pack or MIDX */
    +-	if (pos >= bitmap_num_objects(bitmap_git))
    +-		return; /* not actually in the pack or MIDX */
    ++	/*
    ++	 * try_partial_reuse() is called either on (a) objects in the
    ++	 * bitmapped pack (in the case of a single-pack bitmap) or (b)
    ++	 * objects in the preferred pack of a multi-pack bitmap.
    ++	 * Importantly, the latter can pretend as if only a single pack
    ++	 * exists because:
    ++	 *
    ++	 *   - The first pack->num_objects bits of a MIDX bitmap are
    ++	 *     reserved for the preferred pack, and
    ++	 *
    ++	 *   - Ties due to duplicate objects are always resolved in
    ++	 *     favor of the preferred pack.
    ++	 *
    ++	 * Therefore we do not need to ever ask the MIDX for its copy of
    ++	 * an object by OID, since it will always select it from the
    ++	 * preferred pack. Likewise, the selected copy of the base
    ++	 * object for any deltas will reside in the same pack.
    ++	 *
    ++	 * This means that we can reuse pos when looking up the bit in
    ++	 * the reuse bitmap, too, since bits corresponding to the
    ++	 * preferred pack precede all bits from other packs.
    ++	 */
      
     -	offset = header = pack_pos_to_offset(bitmap_git->pack, pos);
     -	type = unpack_object_header(bitmap_git->pack, w_curs, &offset, &size);
    -+	if (bitmap_is_midx(bitmap_git)) {
    -+		uint32_t pack_id, midx_pos;
    ++	if (pos >= pack->num_objects)
    ++		return; /* not actually in the pack or MIDX preferred pack */
     +
    -+		midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
    -+		pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
    -+
    -+		pack = bitmap_git->midx->packs[pack_id];
    -+		offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
    -+	} else {
    -+		pack = bitmap_git->pack;
    -+		offset = pack_pos_to_offset(bitmap_git->pack, pos);
    -+	}
    -+
    -+	delta_obj_offset = offset;
    ++	offset = delta_obj_offset = pack_pos_to_offset(pack, pos);
     +	type = unpack_object_header(pack, w_curs, &offset, &size);
      	if (type < 0)
      		return; /* broken packfile, punt */
    @@ pack-bitmap.c: static void try_partial_reuse(struct bitmap_index *bitmap_git,
      			return;
      
      		/*
    -@@ pack-bitmap.c: static void try_partial_reuse(struct bitmap_index *bitmap_git,
    - 		 * packs we write fresh, and OFS_DELTA is the default). But
    - 		 * let's double check to make sure the pack wasn't written with
    - 		 * odd parameters.
    -+		 *
    -+		 * Note that the base does not need to be repositioned, i.e.,
    -+		 * the MIDX is guaranteed to have selected the copy of "base"
    -+		 * from the same pack, since this function is only ever called
    -+		 * on the preferred pack (and all duplicate objects are resolved
    -+		 * in favor of the preferred pack).
    -+		 *
    -+		 * This means that we can reuse base_pos when looking up the bit
    -+		 * in the reuse bitmap, too, since bits corresponding to the
    -+		 * preferred pack precede all bits from other packs.
    - 		 */
    - 		if (base_pos >= pos)
    - 			return;
     @@ pack-bitmap.c: static void try_partial_reuse(struct bitmap_index *bitmap_git,
      	bitmap_set(reuse, pos);
      }
    @@ pack-bitmap.c: static void try_partial_reuse(struct bitmap_index *bitmap_git,
      int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
      				       struct packed_git **packfile_out,
      				       uint32_t *entries,
    -@@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
    + 				       struct bitmap **reuse_out)
    + {
    ++	struct packed_git *pack;
    + 	struct bitmap *result = bitmap_git->result;
    + 	struct bitmap *reuse;
    + 	struct pack_window *w_curs = NULL;
      	size_t i = 0;
      	uint32_t offset;
    - 	uint32_t objects_nr = bitmap_num_objects(bitmap_git);
    -+	uint32_t preferred_pack = 0;
    +-	uint32_t objects_nr = bitmap_num_objects(bitmap_git);
    ++	uint32_t objects_nr;
      
      	assert(result);
      
     +	load_reverse_index(bitmap_git);
     +
    -+	if (bitmap_is_midx(bitmap_git)) {
    -+		preferred_pack = midx_preferred_pack(bitmap_git);
    -+		objects_nr = bitmap_git->midx->packs[preferred_pack]->num_objects;
    -+	} else
    -+		objects_nr = bitmap_git->pack->num_objects;
    ++	if (bitmap_is_midx(bitmap_git))
    ++		pack = bitmap_git->midx->packs[midx_preferred_pack(bitmap_git)];
    ++	else
    ++		pack = bitmap_git->pack;
    ++	objects_nr = pack->num_objects;
     +
      	while (i < result->word_alloc && result->words[i] == (eword_t)~0)
      		i++;
    @@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitma
      				break;
      
      			offset += ewah_bit_ctz64(word >> offset);
    +-			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
     +			if (bitmap_is_midx(bitmap_git)) {
     +				/*
     +				 * Can't reuse from a non-preferred pack (see
    @@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitma
     +				if (pos + offset >= objects_nr)
     +					continue;
     +			}
    - 			try_partial_reuse(bitmap_git, pos + offset, reuse, &w_curs);
    ++			try_partial_reuse(bitmap_git, pack, pos + offset, reuse, &w_curs);
      		}
      	}
    + 
     @@ pack-bitmap.c: int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
      	 * need to be handled separately.
      	 */
      	bitmap_and_not(result, reuse);
     -	*packfile_out = bitmap_git->pack;
    -+	*packfile_out = bitmap_git->pack ?
    -+		bitmap_git->pack :
    -+		bitmap_git->midx->packs[preferred_pack];
    ++	*packfile_out = pack;
      	*reuse_out = reuse;
      	return 0;
      }
    @@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_
      	struct ewah_iterator it;
      	eword_t filter;
     @@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
    + 				break;
      
      			offset += ewah_bit_ctz64(word >> offset);
    - 			pos = base + offset;
    +-			pos = base + offset;
     +
     +			if (bitmap_is_midx(bitmap_git)) {
     +				uint32_t pack_pos;
    -+				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, pos);
    ++				uint32_t midx_pos = pack_pos_to_midx(bitmap_git->midx, base + offset);
     +				uint32_t pack_id = nth_midxed_pack_int_id(bitmap_git->midx, midx_pos);
     +				off_t offset = nth_midxed_offset(bitmap_git->midx, midx_pos);
     +
    @@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_
     +				}
     +
     +				pos = pack_pos;
    -+			} else
    ++			} else {
     +				pack = bitmap_git->pack;
    ++				pos = base + offset;
    ++			}
     +
      			total += pack_pos_to_offset(pack, pos + 1) -
      				 pack_pos_to_offset(pack, pos);
13:  fd320c5ed4 ! 14:  a8cec2463d pack-bitmap: write multi-pack bitmaps
    @@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *mid
     +	repo_init_revisions(the_repository, &revs, NULL);
     +	for_each_ref(add_ref_to_pending, &revs);
     +
    ++	/*
    ++	 * Skipping promisor objects here is intentional, since it only excludes
    ++	 * them from the list of reachable commits that we want to select from
    ++	 * when computing the selection of MIDX'd commits to receive bitmaps.
    ++	 *
    ++	 * Reachability bitmaps do require that their objects be closed under
    ++	 * reachability, but fetching any objects missing from promisors at this
    ++	 * point is too late. But, if one of those objects can be reached from
    ++	 * an another object that is included in the bitmap, then we will
    ++	 * complain later that we don't have reachability closure (and fail
    ++	 * appropriately).
    ++	 */
     +	fetch_if_missing = 0;
     +	revs.exclude_promisor_objects = 1;
     +
    ++	/*
    ++	 * Pass selected commits in topo order to match the behavior of
    ++	 * pack-bitmaps when configured with delta islands.
    ++	 */
    ++	revs.topo_order = 1;
    ++	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
    ++
     +	if (prepare_revision_walk(&revs))
     +		die(_("revision walk setup failed"));
     +
    @@ midx.c: static void write_midx_reverse_index(char *midx_name, unsigned char *mid
     +	bitmap_writer_build_type_index(&pdata, index, pdata.nr_objects);
     +
     +	/*
    -+	 * bitmap_writer_select_commits expects objects in lex order, but
    -+	 * pack_order gives us exactly that. use it directly instead of
    -+	 * re-sorting the array
    ++	 * bitmap_writer_finish expects objects in lex order, but pack_order
    ++	 * gives us exactly that. use it directly instead of re-sorting the
    ++	 * array.
    ++	 *
    ++	 * This changes the order of objects in 'index' between
    ++	 * bitmap_writer_build_type_index and bitmap_writer_finish.
    ++	 *
    ++	 * The same re-ordering takes place in the single-pack bitmap code via
    ++	 * write_idx_file(), which is called by finish_tmp_packfile(), which
    ++	 * happens between bitmap_writer_build_type_index() and
    ++	 * bitmap_writer_finish().
     +	 */
     +	for (i = 0; i < pdata.nr_objects; i++)
     +		index[ctx->pack_order[i]] = (struct pack_idx_entry *)&pdata.objects[i];
     +
     +	bitmap_writer_select_commits(commits, commits_nr, -1);
     +	ret = bitmap_writer_build(&pdata);
    -+	if (!ret)
    ++	if (ret < 0)
     +		goto cleanup;
     +
     +	bitmap_writer_set_checksum(midx_hash);
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
     +		}
     +	}
      
    - 	ctx.preferred_pack_idx = -1;
      	if (preferred_pack_name) {
    + 		int found = 0;
    +@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    + 		if (!found)
    + 			warning(_("unknown preferred pack: '%s'"),
    + 				preferred_pack_name);
    +-	} else if (ctx.nr && (flags & MIDX_WRITE_REV_INDEX)) {
    ++	} else if (ctx.nr &&
    ++		   (flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))) {
    + 		time_t oldest = ctx.info[0].p->mtime;
    + 		ctx.preferred_pack_idx = 0;
    + 
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
      	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
      	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      
      	if (flags & MIDX_WRITE_REV_INDEX)
      		write_midx_reverse_index(midx_name, midx_hash, &ctx);
    -+	if (flags & MIDX_WRITE_BITMAP)
    -+		write_midx_bitmap(midx_name, midx_hash, &ctx, flags);
    ++	if (flags & MIDX_WRITE_BITMAP) {
    ++		if (write_midx_bitmap(midx_name, midx_hash, &ctx, flags) < 0) {
    ++			error(_("could not write multi-pack bitmap"));
    ++			result = 1;
    ++			goto cleanup;
    ++		}
    ++	}
      
      	commit_lock_file(&lk);
      
14:  570e3de9ed ! 15:  c63eb637c8 t5310: move some tests to lib-bitmap.sh
    @@ t/lib-bitmap.sh: test_bitmap_traversal () {
     +		git --git-dir=clone.git rev-parse HEAD >actual &&
     +		test_cmp expect actual
     +	'
    ++
    ++	test_expect_success 'enumerating progress counts pack-reused objects' '
    ++		count=$(git rev-list --objects --all --count) &&
    ++		git repack -adb &&
    ++
    ++		# check first with only reused objects; confirm that our
    ++		# progress showed the right number, and also that we did
    ++		# pack-reuse as expected.  Check only the final "done"
    ++		# line of the meter (there may be an arbitrary number of
    ++		# intermediate lines ending with CR).
    ++		GIT_PROGRESS_DELAY=0 \
    ++			git pack-objects --all --stdout --progress \
    ++			</dev/null >/dev/null 2>stderr &&
    ++		grep "Enumerating objects: $count, done" stderr &&
    ++		grep "pack-reused $count" stderr &&
    ++
    ++		# now the same but with one non-reused object
    ++		git commit --allow-empty -m "an extra commit object" &&
    ++		GIT_PROGRESS_DELAY=0 \
    ++			git pack-objects --all --stdout --progress \
    ++			</dev/null >/dev/null 2>stderr &&
    ++		grep "Enumerating objects: $((count+1)), done" stderr &&
    ++		grep "pack-reused $count" stderr
    ++	'
     +}
     +
     +# have_delta <obj> <expected_base>
    @@ t/t5310-pack-bitmaps.sh: test_expect_success 'truncated bitmap fails gracefully
      	test_i18ngrep corrupted.bitmap.index stderr
      '
      
    +-test_expect_success 'enumerating progress counts pack-reused objects' '
    +-	count=$(git rev-list --objects --all --count) &&
    +-	git repack -adb &&
    +-
    +-	# check first with only reused objects; confirm that our progress
    +-	# showed the right number, and also that we did pack-reuse as expected.
    +-	# Check only the final "done" line of the meter (there may be an
    +-	# arbitrary number of intermediate lines ending with CR).
    +-	GIT_PROGRESS_DELAY=0 \
    +-		git pack-objects --all --stdout --progress \
    +-		</dev/null >/dev/null 2>stderr &&
    +-	grep "Enumerating objects: $count, done" stderr &&
    +-	grep "pack-reused $count" stderr &&
    +-
    +-	# now the same but with one non-reused object
    +-	git commit --allow-empty -m "an extra commit object" &&
    +-	GIT_PROGRESS_DELAY=0 \
    +-		git pack-objects --all --stdout --progress \
    +-		</dev/null >/dev/null 2>stderr &&
    +-	grep "Enumerating objects: $((count+1)), done" stderr &&
    +-	grep "pack-reused $count" stderr
    +-'
    +-
     -# have_delta <obj> <expected_base>
     -#
     -# Note that because this relies on cat-file, it might find _any_ copy of an
15:  060ee427be = 16:  bedb7afb37 t/helper/test-read-midx.c: add --checksum mode
16:  ff74181e85 ! 17:  fbfac4ae8e t5326: test multi-pack bitmap behavior
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +	git multi-pack-index write --bitmap &&
     +
     +	ls $objdir/pack/pack-*.pack >packs &&
    -+	test_line_count = 26 packs &&
    ++	test_line_count = 25 packs &&
     +
     +	test_path_is_file $midx &&
     +	test_path_is_file $midx-$(midx_checksum $objdir).bitmap
    @@ t/t5326-multi-pack-bitmaps.sh (new)
     +		$(git rev-parse packed)
     +		EOF
     +
    -+		git multi-pack-index write --bitmap 2>err &&
    ++		test_must_fail git multi-pack-index write --bitmap 2>err &&
     +		grep "doesn.t have full closure" err &&
    -+		test_path_is_file $midx &&
    -+		test_path_is_missing $midx-$(midx_checksum $objdir).bitmap
    ++		test_path_is_missing $midx
     +	)
     +'
     +
 -:  ---------- > 18:  2a5df1832a t0410: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
17:  8f328bb5bc = 19:  2d24c5b7ad t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
18:  dbd953815b = 20:  4cbfaa0e97 t5319: don't write MIDX bitmaps in t5319
19:  ee952e4300 = 21:  839a7a79eb t7700: update to work with MIDX bitmap test knob
20:  83614f9284 = 22:  00418d5b09 midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
21:  2f3836bf2e = 23:  98fa73a76a p5310: extract full and partial bitmap tests
22:  b75b534446 = 24:  ec0f53b424 p5326: perf tests for MIDX bitmaps
-- 
2.31.1.163.ga65ce7f831
