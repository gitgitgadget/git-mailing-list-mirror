Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ADDC433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9600D61957
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhC3PEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhC3PDr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:03:47 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B732C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:03:47 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 30so8257429qva.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gk7EtGGCDv60yYkm8Zftg3B1UCQIE21+wM0reCsdNto=;
        b=o1Csohb+DrFgSyd1LrYPZ5YXodOCp5x19mPx8LiysUkz8isTgyu+4MHEr5RpDEKcQI
         OZ5n8FIWNWxwxIngPqOsjZxJlMdEuLC++1t0kTklhRLRa4l7TS6v9na1jeiHvBTBPx1Q
         /DtCBV46YDxQLTAXDYcHwwhvZzKrXuDuS8ScIu9Wg1uO4hI0SUjYHlQ1UokaFDPXnGp8
         hyDX3Mj66t5Vdl8L3J3DtoBqD9Y0R7wDxIprEyxVS1+2tqHz7QxI454j8/gmRqMZM/QD
         vE2k11A5/7+zc1nbfEKEZwHA/VPY9zOxnQc/EUpXSCK6z730+uw4wtvkAkQSQLB16cMH
         ++HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gk7EtGGCDv60yYkm8Zftg3B1UCQIE21+wM0reCsdNto=;
        b=ZS2f/NauIUFCmkzGWeBNANitdYMOzyV77jiU8QsCux4Gz2VMK2yf9Ga9YXIiknb17N
         DEJoQW9Vn+F+qFWYTy9xLIE0APkev2oZwjsXlDcEniTe2wwuyKYEhgqAq3Neu+KV9HJR
         eQd9S0Qtx6G8hTo1jXwfVX2iti9pGZDx01MBCkYO6vKRDEBwS3HhMEIhg2TQWrphAGlG
         Wdh3gE+uu3AMVNZrvIWsgaxVHva/Q11+HQyXsfhlJd2WTHOstijgMsOIV3QvUGIcRzZS
         YqZu91x5mGqW1nnbp86GT7oX64y0vqyH5VSHdkhF1JWETLezZb8toM8HZZu+3NtBgHsy
         KMkQ==
X-Gm-Message-State: AOAM530+XiZRrK/gd3k41Jxs35TQoOa4laG3epN2Gx8or0vXg23BBK+q
        rSNP9UDIefDrCmQEt4pFP/1Hb2JJiCVbGg==
X-Google-Smtp-Source: ABdhPJwvX6CbEX7S1n0bGDKq+Rij9fwkDl8SChM+8R3rHYaKq9erh5eq6605hq4e2cH70gaxSox2XQ==
X-Received: by 2002:ad4:510d:: with SMTP id g13mr31038895qvp.3.1617116626094;
        Tue, 30 Mar 2021 08:03:46 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id d24sm15415050qkl.49.2021.03.30.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:03:45 -0700 (PDT)
Date:   Tue, 30 Mar 2021 11:03:44 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: [PATCH v4 00/16] midx: implement a multi-pack reverse index
Message-ID: <cover.1617116623.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another reroll of my series to implement a reverse index in
preparation for multi-pack reachability bitmaps.

This reroll differs only in the feedback I incorporated from Peff's review. They
are mostly cosmetic; the most substantial change being that the --preferred-pack
code now uses bsearch() to locate the name of the preferred pack (instead of
implementing a binary search itself).

I think that this version is ready to go. I would hope that it can head for
'master' and avoid sitting in 'next' forever (since it has some worthwhile
cleanups outside of preparing for MIDX bitmaps).

But in either case, this is the last prereq series before MIDX bitmaps, which
I'll send shortly (based on this one).

Jeff King (1):
  midx.c: improve cache locality in midx_pack_order_cmp()

Taylor Blau (15):
  builtin/multi-pack-index.c: inline 'flags' with options
  builtin/multi-pack-index.c: don't handle 'progress' separately
  builtin/multi-pack-index.c: define common usage with a macro
  builtin/multi-pack-index.c: split sub-commands
  builtin/multi-pack-index.c: don't enter bogus cmd_mode
  builtin/multi-pack-index.c: display usage on unrecognized command
  t/helper/test-read-midx.c: add '--show-objects'
  midx: allow marking a pack as preferred
  midx: don't free midx_name early
  midx: keep track of the checksum
  midx: make some functions non-static
  Documentation/technical: describe multi-pack reverse indexes
  pack-revindex: read multi-pack reverse indexes
  pack-write.c: extract 'write_rev_file_order'
  pack-revindex: write multi-pack reverse indexes

 Documentation/git-multi-pack-index.txt       |  14 +-
 Documentation/technical/multi-pack-index.txt |   5 +-
 Documentation/technical/pack-format.txt      |  83 +++++++
 builtin/multi-pack-index.c                   | 182 ++++++++++++---
 builtin/repack.c                             |   2 +-
 midx.c                                       | 219 +++++++++++++++++--
 midx.h                                       |  11 +-
 pack-revindex.c                              | 126 +++++++++++
 pack-revindex.h                              |  53 +++++
 pack-write.c                                 |  36 ++-
 pack.h                                       |   1 +
 packfile.c                                   |   3 +
 t/helper/test-read-midx.c                    |  24 +-
 t/t5319-multi-pack-index.sh                  |  43 ++++
 14 files changed, 734 insertions(+), 68 deletions(-)

Range-diff against v3:
 1:  43fc0ad276 !  1:  90e021725f builtin/multi-pack-index.c: inline 'flags' with options
    @@ Commit message
         'verify', etc.) will want to optionally change a set of shared flags
         that are eventually passed to the MIDX libraries.
     
    -    Right now, options and flags are handled separately. Inline them into
    -    the same structure so that sub-commands can more easily share the
    -    'flags' data.
    +    Right now, options and flags are handled separately. That's fine, since
    +    the options structure is never passed around. But a future patch will
    +    make it so that common options shared by all sub-commands are defined in
    +    a common location. That means that "flags" would have to become a global
    +    variable.
    +
    +    Group it with the options structure so that we reduce the number of
    +    global variables we have overall.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
 2:  181f11e4c5 =  2:  130c191b80 builtin/multi-pack-index.c: don't handle 'progress' separately
 3:  94c498f0e2 =  3:  5a274b9096 builtin/multi-pack-index.c: define common usage with a macro
 4:  d084f90466 !  4:  b8c89cc239 builtin/multi-pack-index.c: split sub-commands
    @@ builtin/multi-pack-index.c: static struct opts_multi_pack_index {
     -		OPT_FILENAME(0, "object-dir", &opts.object_dir,
     -		  N_("object directory containing set of packfile and pack-index pairs")),
     -		OPT_BIT(0, "progress", &opts.flags, N_("force progress reporting"), MIDX_PROGRESS),
    -+	struct option *with_common = parse_options_concat(common_opts, prev);
    -+	free(prev);
    -+	return with_common;
    ++	return parse_options_concat(common_opts, prev);
     +}
     +
     +static int cmd_multi_pack_index_write(int argc, const char **argv)
    @@ builtin/multi-pack-index.c: static struct opts_multi_pack_index {
      		OPT_END(),
      	};
      
    -+	options = parse_options_dup(builtin_multi_pack_index_repack_options);
    -+	options = add_common_options(options);
    ++	options = add_common_options(builtin_multi_pack_index_repack_options);
     +
     +	argc = parse_options(argc, argv, NULL,
     +			     options,
    @@ builtin/multi-pack-index.c: static struct opts_multi_pack_index {
     +		usage_with_options(builtin_multi_pack_index_repack_usage,
     +				   options);
     +
    ++	FREE_AND_NULL(options);
    ++
     +	return midx_repack(the_repository, opts.object_dir,
     +			   (size_t)opts.batch_size, opts.flags);
     +}
 5:  bc3b6837f2 !  5:  d817920e2a builtin/multi-pack-index.c: don't enter bogus cmd_mode
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_expire(int argc, con
      			     options, builtin_multi_pack_index_expire_usage,
      			     PARSE_OPT_KEEP_UNKNOWN);
     @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_repack(int argc, const char **argv)
    - 	options = parse_options_dup(builtin_multi_pack_index_repack_options);
    - 	options = add_common_options(options);
    + 
    + 	options = add_common_options(builtin_multi_pack_index_repack_options);
      
     +	trace2_cmd_mode(argv[0]);
     +
 6:  f117e442c3 !  6:  604a02ce85 builtin/multi-pack-index.c: display usage on unrecognized command
    @@ Commit message
         more helpful:
     
             $ git.compile multi-pack-index bogus
    +        error: unrecognized subcommand: bogus
             usage: git multi-pack-index [<options>] write
                or: git multi-pack-index [<options>] verify
                or: git multi-pack-index [<options>] expire
    @@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc, const char **argv
      	if (!strcmp(argv[0], "repack"))
      		return cmd_multi_pack_index_repack(argc, argv);
     @@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc, const char **argv,
    + 		return cmd_multi_pack_index_verify(argc, argv);
      	else if (!strcmp(argv[0], "expire"))
      		return cmd_multi_pack_index_expire(argc, argv);
    - 	else
    +-	else
     -		die(_("unrecognized subcommand: %s"), argv[0]);
    ++	else {
     +usage:
    ++		error(_("unrecognized subcommand: %s"), argv[0]);
     +		usage_with_options(builtin_multi_pack_index_usage,
     +				   builtin_multi_pack_index_options);
    ++	}
      }
 7:  ae85a68ef2 =  7:  37e073ea27 t/helper/test-read-midx.c: add '--show-objects'
 8:  30194a6786 !  8:  d061828e7e midx: allow marking a pack as preferred
    @@ builtin/multi-pack-index.c: static struct option *add_common_options(struct opti
     +		OPT_END(),
     +	};
     +
    -+	options = parse_options_dup(builtin_multi_pack_index_write_options);
    -+	options = add_common_options(options);
    ++	options = add_common_options(builtin_multi_pack_index_write_options);
      
      	trace2_cmd_mode(argv[0]);
      
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
      				   options);
      
     -	return write_midx_file(opts.object_dir, opts.flags);
    ++	FREE_AND_NULL(options);
    ++
     +	return write_midx_file(opts.object_dir, opts.preferred_pack,
     +			       opts.flags);
      }
    @@ midx.c: static int pack_info_compare(const void *_a, const void *_b)
      	return strcmp(a->pack_name, b->pack_name);
      }
      
    -+static int lookup_idx_or_pack_name(struct pack_info *info,
    -+				   uint32_t nr,
    -+				   const char *pack_name)
    ++static int idx_or_pack_name_cmp(const void *_va, const void *_vb)
     +{
    -+	uint32_t lo = 0, hi = nr;
    -+	while (lo < hi) {
    -+		uint32_t mi = lo + (hi - lo) / 2;
    -+		int cmp = cmp_idx_or_pack_name(pack_name, info[mi].pack_name);
    -+		if (cmp < 0)
    -+			hi = mi;
    -+		else if (cmp > 0)
    -+			lo = mi + 1;
    -+		else
    -+			return mi;
    -+	}
    -+	return -1;
    ++	const char *pack_name = _va;
    ++	const struct pack_info *compar = _vb;
    ++
    ++	return cmp_idx_or_pack_name(pack_name, compar->pack_name);
     +}
     +
      struct write_midx_context {
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      
     +	/* Check that the preferred pack wasn't expired (if given). */
     +	if (preferred_pack_name) {
    -+		int preferred_idx = lookup_idx_or_pack_name(ctx.info,
    -+							    ctx.nr,
    -+							    preferred_pack_name);
    -+		if (preferred_idx < 0)
    ++		struct pack_info *preferred = bsearch(preferred_pack_name,
    ++						      ctx.info, ctx.nr,
    ++						      sizeof(*ctx.info),
    ++						      idx_or_pack_name_cmp);
    ++
    ++		if (!preferred)
     +			warning(_("unknown preferred pack: '%s'"),
     +				preferred_pack_name);
     +		else {
    -+			uint32_t orig = ctx.info[preferred_idx].orig_pack_int_id;
    -+			uint32_t perm = ctx.pack_perm[orig];
    -+
    ++			uint32_t perm = ctx.pack_perm[preferred->orig_pack_int_id];
     +			if (perm == PACK_EXPIRED)
     +				warning(_("preferred pack '%s' is expired"),
     +					preferred_pack_name);
    @@ midx.h: int fill_midx_entry(struct repository *r, const struct object_id *oid, s
      int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
     
      ## t/t5319-multi-pack-index.sh ##
    -@@ t/t5319-multi-pack-index.sh: midx_read_expect () {
    - 	test_cmp expect actual
    - }
    - 
    -+midx_expect_object_offset () {
    -+	OID="$1"
    -+	OFFSET="$2"
    -+	OBJECT_DIR="$3"
    -+	test-tool read-midx --show-objects $OBJECT_DIR >actual &&
    -+	grep "^$OID $OFFSET" actual
    -+}
    -+
    - test_expect_success 'setup' '
    - 	test_oid_cache <<-EOF
    - 	idxoff sha1:2999
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'warn on improper hash version' '
      	)
      '
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'warn on improper hash version'
     +
     +		# Set up two packs, duplicating the object "B" at different
     +		# offsets.
    ++		#
    ++		# Note that the "BC" pack (the one we choose as preferred) sorts
    ++		# lexically after the "AB" pack, meaning that omitting the
    ++		# --preferred-pack argument would cause this test to fail (since
    ++		# the MIDX code would select the copy of "b" in the "AB" pack).
     +		git pack-objects objects/pack/test-AB <<-EOF &&
     +		$a
     +		$b
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'warn on improper hash version'
     +			write --preferred-pack=test-BC-$bc.idx 2>err &&
     +		test_must_be_empty err &&
     +
    ++		echo hi &&
    ++		test-tool read-midx --show-objects objects >out &&
    ++
     +		ofs=$(git show-index <objects/pack/test-BC-$bc.idx | grep $b |
     +			cut -d" " -f1) &&
    -+		midx_expect_object_offset $b $ofs objects
    ++		printf "%s %s\tobjects/pack/test-BC-%s.pack\n" \
    ++			"$b" "$ofs" "$bc" >expect &&
    ++		grep ^$b out >actual &&
    ++
    ++		test_cmp expect actual
     +	)
     +'
      
 9:  5c5aca761a =  9:  33b8af97e7 midx: don't free midx_name early
10:  a22a1463a5 = 10:  3fc9b83dc6 midx: keep track of the checksum
11:  efa54479b1 = 11:  2ada397320 midx: make some functions non-static
12:  4745bb8590 ! 12:  8bb3dd24a7 Documentation/technical: describe multi-pack reverse indexes
    @@ Documentation/technical/pack-format.txt: CHUNK DATA:
     +position.
     +
     +One solution is to let bits occupy the same position in the oid-sorted
    -+index stored by the MIDX. But because oids are effectively random, there
    ++index stored by the MIDX. But because oids are effectively random, their
     +resulting reachability bitmaps would have no locality, and thus compress
     +poorly. (This is the reason that single-pack bitmaps use the pack
     +ordering, and not the .idx ordering, for the same purpose.)
    @@ Documentation/technical/pack-format.txt: CHUNK DATA:
     +order in the actual packfile.
     +
     +Given the list of packs and their counts of objects, you can
    -+na&iuml;vely reconstruct that pseudo-pack ordering (e.g., the object at
    ++naïvely reconstruct that pseudo-pack ordering (e.g., the object at
     +position 27 must be (c,1) because packs "a" and "b" consumed 25 of the
     +slots). But there's a catch. Objects may be duplicated between packs, in
     +which case the MIDX only stores one pointer to the object (and thus we'd
    @@ Documentation/technical/pack-format.txt: CHUNK DATA:
     +too.
     +
     +Objects from the MIDX are ordered as follows to string together the
    -+pseudo-pack. Let _pack(o)_ return the pack from which _o_ was selected
    ++pseudo-pack. Let `pack(o)` return the pack from which `o` was selected
     +by the MIDX, and define an ordering of packs based on their numeric ID
    -+(as stored by the MIDX). Let _offset(o)_ return the object offset of _o_
    -+within _pack(o)_. Then, compare _o~1~_ and _o~2~_ as follows:
    ++(as stored by the MIDX). Let `offset(o)` return the object offset of `o`
    ++within `pack(o)`. Then, compare `o1` and `o2` as follows:
     +
    -+  - If one of _pack(o~1~)_ and _pack(o~2~)_ is preferred and the other
    ++  - If one of `pack(o1)` and `pack(o2)` is preferred and the other
     +    is not, then the preferred one sorts first.
     ++
     +(This is a detail that allows the MIDX bitmap to determine which
     +pack should be used by the pack-reuse mechanism, since it can ask
     +the MIDX for the pack containing the object at bit position 0).
     +
    -+  - If _pack(o~1~) &ne; pack(o~2~)_, then sort the two objects in
    -+    descending order based on the pack ID.
    ++  - If `pack(o1) ≠ pack(o2)`, then sort the two objects in descending
    ++    order based on the pack ID.
     +
    -+  - Otherwise, _pack(o~1~) &equals; pack(o~2~)_, and the objects are
    -+    sorted in pack-order (i.e., _o~1~_ sorts ahead of _o~2~_ exactly
    -+    when _offset(o~1~) &lt; offset(o~2~)_).
    ++  - Otherwise, `pack(o1) = pack(o2)`, and the objects are sorted in
    ++    pack-order (i.e., `o1` sorts ahead of `o2` exactly when `offset(o1)
    ++    < offset(o2)`).
     +
     +In short, a MIDX's pseudo-pack is the de-duplicated concatenation of
     +objects in packs stored by the MIDX, laid out in pack order, and the
13:  a6ebd4be91 ! 13:  c070b9c99f pack-revindex: read multi-pack reverse indexes
    @@ pack-revindex.c: int load_pack_revindex(struct packed_git *p)
     +
     +int close_midx_revindex(struct multi_pack_index *m)
     +{
    -+	if (!m)
    ++	if (!m || !m->revindex_map)
     +		return 0;
     +
    -+	if (munmap((void*)m->revindex_map, m->revindex_len))
    -+		return -1;
    ++	munmap((void*)m->revindex_map, m->revindex_len);
     +
     +	m->revindex_map = NULL;
     +	m->revindex_data = NULL;
    @@ pack-revindex.c: off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
     +		BUG("pack_pos_to_midx: reverse index not yet loaded");
     +	if (m->num_objects <= pos)
     +		BUG("pack_pos_to_midx: out-of-bounds object at %"PRIu32, pos);
    -+	return get_be32((const char *)m->revindex_data + (pos * sizeof(uint32_t)));
    ++	return get_be32(m->revindex_data + pos);
     +}
     +
     +struct midx_pack_key {
    @@ pack-revindex.c: off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
     +	key.preferred_pack = nth_midxed_pack_int_id(m, pack_pos_to_midx(m, 0));
     +
     +	found = bsearch(&key, m->revindex_data, m->num_objects,
    -+			sizeof(uint32_t), midx_pack_order_cmp);
    ++			sizeof(*m->revindex_data), midx_pack_order_cmp);
     +
     +	if (!found)
     +		return error("bad offset for revindex");
14:  f5314f1822 = 14:  9f40019eb3 pack-write.c: extract 'write_rev_file_order'
15:  fa3acb5d5a = 15:  47409cc508 pack-revindex: write multi-pack reverse indexes
16:  550e785f10 = 16:  7b793e7d09 midx.c: improve cache locality in midx_pack_order_cmp()
-- 
2.30.0.667.g81c0cbc6fd
