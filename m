Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A49C433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD869235FA
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbhANCFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbhAMW3E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:29:04 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD3C061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:05 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id az16so1572357qvb.5
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BDrmbsw2DTOLT5MQDY4sa3usFeDC30OJElLavZ/36Y8=;
        b=jibzNcQn1RcJoMiKTQTekZ964iml+bJTDhdDz0fz4SqCovFEz/uP+kzzV8UtNN+Q2V
         sxF1akmWIfZXuD+ygyXE92Jg7izOpwXWnldjZjcy2sYXidN/A+bI/o2AM1sljcRb/zH7
         Zu1gZ9ydhUc2vfJzqW+imlblkgqsJ360mk5bYkqwKIH9LSCaYN7OuQL1P/OX89l2NVkX
         LQ+DGH0TO8o3pi2P6T1No1gmkgGsr/VaV6EyrZUg6PmGDESmr2obDqBGPAkeZI+VJt5Q
         ToSYPdNer8t7v8XBiYvgI3DxHuEv2QXBaSFn9bTfHHGVw6FIVlW1BR1yBZWKslyo9F1P
         K0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDrmbsw2DTOLT5MQDY4sa3usFeDC30OJElLavZ/36Y8=;
        b=BUTUfPEzdV48W7DkNNvsFPbbSsKeci2Wgs4bQtGKa64eDB6DNGamsXG5f4YcElh3Aa
         CIwfDljYEvHHhlwyEpVjD0jA0K4ShD44uawhtE+oGpcuL5SIhNF25niqSB/GAraeiEUu
         IxiBPr9cdVDEvhwLDuIhg7uQ76SYXLUQxmPdInSM3EWqypb81bcTB32tqnawrzwxr4SH
         7KTcihcmvmjyvhnpTduY0cYpETs/8DjgnYdrHsVw7An4GlZxJJbnMu/Cpwwu1kGDxwCt
         Y/4CjRngF/zv0jRZ8tbQ1IHS+CnxkZ83RSndRuBdrK+4/xVLxhQWC9lZzylvmUEXl+1m
         N8Vg==
X-Gm-Message-State: AOAM532BnXp3elaEEKOYbbvMsXXq6Mhtk0FY0KUyW18HQtG6SjsJFXoW
        jW17mS1QV+vFaEDlu/ne0Rc3cv3FLfB9LQ==
X-Google-Smtp-Source: ABdhPJw5hIES6OUw+W9/a2yGbQY8TEeIkDvwVln+8SkpExUHF27dD+WIjYBQuheNpfv+y6tlzVo8qw==
X-Received: by 2002:a05:6214:1801:: with SMTP id o1mr4711507qvw.26.1610576884623;
        Wed, 13 Jan 2021 14:28:04 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id c20sm1831852qtj.29.2021.01.13.14.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:28:04 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:28:01 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 0/8] pack-revindex: introduce on-disk '.rev' format
Message-ID: <cover.1610576805.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This is the second of two series to implement support for an on-disk format for
storing the reverse index. Note that this depends on the patches in the previous
series [1], which was recently updated).

This version is largely unchanged from the original, with the following
exceptions:

  - It has been rebased onto the patches in the first series.
  - The operands of two comparisons in 'offset_to_pack_pos()' were swapped so
    that the smaller of the two appears on the left-hand side of the comparison.
  - A brown-paper-bag bug was fixed in tests so that they pass on Windows (last
    night's integration broke 'seen' on Windows).
  - The GIT_TEST_WRITE_REV_INDEX mode was enabled in the "all-features" test.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/cover.1610129796.git.me@ttaylorr.com/

Taylor Blau (8):
  packfile: prepare for the existence of '*.rev' files
  pack-write.c: prepare to write 'pack-*.rev' files
  builtin/index-pack.c: write reverse indexes
  builtin/pack-objects.c: respect 'pack.writeReverseIndex'
  Documentation/config/pack.txt: advertise 'pack.writeReverseIndex'
  t: prepare for GIT_TEST_WRITE_REV_INDEX
  t: support GIT_TEST_WRITE_REV_INDEX
  pack-revindex: ensure that on-disk reverse indexes are given
    precedence

 Documentation/config/pack.txt           |   7 ++
 Documentation/git-index-pack.txt        |  20 ++--
 Documentation/technical/pack-format.txt |  17 ++++
 builtin/index-pack.c                    |  67 +++++++++++--
 builtin/pack-objects.c                  |   9 ++
 builtin/repack.c                        |   1 +
 ci/run-build-and-tests.sh               |   1 +
 object-store.h                          |   3 +
 pack-revindex.c                         | 116 ++++++++++++++++++++--
 pack-revindex.h                         |  10 +-
 pack-write.c                            | 123 +++++++++++++++++++++++-
 pack.h                                  |   4 +
 packfile.c                              |  13 ++-
 packfile.h                              |   1 +
 t/README                                |   3 +
 t/t5319-multi-pack-index.sh             |   5 +-
 t/t5325-reverse-index.sh                |  97 +++++++++++++++++++
 t/t5604-clone-reference.sh              |   2 +-
 t/t5702-protocol-v2.sh                  |  12 ++-
 t/t6500-gc.sh                           |   6 +-
 t/t9300-fast-import.sh                  |   5 +-
 tmp-objdir.c                            |   4 +-
 22 files changed, 485 insertions(+), 41 deletions(-)
 create mode 100755 t/t5325-reverse-index.sh

 -:  ---------- >  1:  e1aa89244a pack-revindex: introduce a new API
 -:  ---------- >  2:  0fca7d5812 write_reuse_object(): convert to new revindex API
 -:  ---------- >  3:  7676822a54 write_reused_pack_one(): convert to new revindex API
 -:  ---------- >  4:  dd7133fdb7 write_reused_pack_verbatim(): convert to new revindex API
 -:  ---------- >  5:  8e93ca3886 check_object(): convert to new revindex API
 -:  ---------- >  6:  084bbf2145 bitmap_position_packfile(): convert to new revindex API
 -:  ---------- >  7:  68794e9484 show_objects_for_type(): convert to new revindex API
 -:  ---------- >  8:  31ac6f5703 get_size_by_pos(): convert to new revindex API
 -:  ---------- >  9:  acd80069a2 try_partial_reuse(): convert to new revindex API
 -:  ---------- > 10:  569acdca7f rebuild_existing_bitmaps(): convert to new revindex API
 -:  ---------- > 11:  9881637724 get_delta_base_oid(): convert to new revindex API
 -:  ---------- > 12:  df8bb571a5 retry_bad_packed_offset(): convert to new revindex API
 -:  ---------- > 13:  41b2e00947 packed_object_info(): convert to new revindex API
 -:  ---------- > 14:  8ad49d231f unpack_entry(): convert to new revindex API
 -:  ---------- > 15:  e757476351 for_each_object_in_pack(): convert to new revindex API
 -:  ---------- > 16:  a500311e33 builtin/gc.c: guess the size of the revindex
 -:  ---------- > 17:  67d14da04a pack-revindex: remove unused 'find_pack_revindex()'
 -:  ---------- > 18:  3b5c92be68 pack-revindex: remove unused 'find_revindex_position()'
 -:  ---------- > 19:  cabafce4a1 pack-revindex: hide the definition of 'revindex_entry'
 -:  ---------- > 20:  8400ff6c96 pack-revindex.c: avoid direct revindex access in 'offset_to_pack_pos()'
 1:  ddf47a0a50 ! 21:  6742c15c84 packfile: prepare for the existence of '*.rev' files
    @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)
     +
      int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
      {
    - 	int lo = 0;
    + 	unsigned lo, hi;
     @@ pack-revindex.c: int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)

      uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos)
    @@ pack-revindex.c: int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_
     -	if (!p->revindex)
     +	if (!(p->revindex || p->revindex_data))
      		BUG("pack_pos_to_index: reverse index not yet loaded");
    - 	if (pos >= p->num_objects)
    + 	if (p->num_objects <= pos)
      		BUG("pack_pos_to_index: out-of-bounds object at %"PRIu32, pos);
     -	return p->revindex[pos].nr;
     +
    @@ pack-revindex.c: int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_
     -	if (!p->revindex)
     +	if (!(p->revindex || p->revindex_data))
      		BUG("pack_pos_to_index: reverse index not yet loaded");
    - 	if (pos > p->num_objects)
    + 	if (p->num_objects < pos)
      		BUG("pack_pos_to_offset: out-of-bounds object at %"PRIu32, pos);
     -	return p->revindex[pos].offset;
     +
    @@ pack-revindex.c: int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_
     +		return nth_packed_object_offset(p, pack_pos_to_index(p, pos));
      }

    + ## pack-revindex.h ##
    +@@ pack-revindex.h: struct packed_git;
    + /*
    +  * load_pack_revindex populates the revindex's internal data-structures for the
    +  * given pack, returning zero on success and a negative value otherwise.
    ++ *
    ++ * If a '.rev' file is present, it is checked for consistency, mmap'd, and
    ++ * pointers are assigned into it (instead of using the in-memory variant).
    +  */
    + int load_pack_revindex(struct packed_git *p);
    +
    +@@ pack-revindex.h: uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
    +  * If the reverse index has not yet been loaded, or the position is out of
    +  * bounds, this function aborts.
    +  *
    +- * This function runs in constant time.
    ++ * This function runs in constant time under both in-memory and on-disk reverse
    ++ * indexes, but an additional step is taken to consult the corresponding .idx
    ++ * file when using the on-disk format.
    +  */
    + off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
    +
    +
      ## packfile.c ##
     @@ packfile.c: void close_pack_index(struct packed_git *p)
      	}
 2:  88393e2662 = 22:  8648c87fa7 pack-write.c: prepare to write 'pack-*.rev' files
 3:  b0a7329824 ! 23:  5b18ada611 builtin/index-pack.c: write reverse indexes
    @@ t/t5325-reverse-index.sh (new)
     +	rm -f $rev &&
     +	conf=$1 &&
     +	shift &&
    ++	# remove the index since Windows won't overwrite an existing file
    ++	rm $packdir/pack-$pack.idx &&
     +	git -c pack.writeReverseIndex=$conf index-pack "$@" \
     +		$packdir/pack-$pack.pack
     +}
 4:  e297a31875 = 24:  68bde3ea97 builtin/pack-objects.c: respect 'pack.writeReverseIndex'
 5:  5d3e96a498 = 25:  38a253d0ce Documentation/config/pack.txt: advertise 'pack.writeReverseIndex'
 6:  2288571fbe <  -:  ---------- t: prepare for GIT_TEST_WRITE_REV_INDEX
 -:  ---------- > 26:  12cdf2d67a t: prepare for GIT_TEST_WRITE_REV_INDEX
 7:  3525c4d114 ! 27:  6b647d9775 t: support GIT_TEST_WRITE_REV_INDEX
    @@ Commit message

         Add a new option that unconditionally enables the pack.writeReverseIndex
         setting in order to run the whole test suite in a mode that generates
    -    on-disk reverse indexes.
    +    on-disk reverse indexes. Additionally, enable this mode in the second
    +    run of tests under linux-gcc in 'ci/run-build-and-tests.sh'.

         Once on-disk reverse indexes are proven out over several releases, we
         can change the default value of that configuration to 'true', and drop
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
      	progress = isatty(2);
      	argc = parse_options(argc, argv, prefix, pack_objects_options,

    + ## ci/run-build-and-tests.sh ##
    +@@ ci/run-build-and-tests.sh: linux-gcc)
    + 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
    + 	export GIT_TEST_MULTI_PACK_INDEX=1
    + 	export GIT_TEST_ADD_I_USE_BUILTIN=1
    ++	export GIT_TEST_WRITE_REV_INDEX=1
    + 	make test
    + 	;;
    + linux-clang)
    +
      ## pack-revindex.h ##
     @@
    - #ifndef PACK_REVINDEX_H
    - #define PACK_REVINDEX_H
    +  *   can be found
    +  */

     +#define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
     +
      struct packed_git;

    - int load_pack_revindex(struct packed_git *p);
    + /*

      ## t/README ##
     @@ t/README: GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
 8:  6e580d43d1 ! 28:  48926ae182 pack-revindex: ensure that on-disk reverse indexes are given precedence
    @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)

      ## pack-revindex.h ##
     @@
    - #define PACK_REVINDEX_H
    +  */

      #define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
     +#define GIT_TEST_REV_INDEX_DIE_IN_MEMORY "GIT_TEST_REV_INDEX_DIE_IN_MEMORY"
    @@ t/t5325-reverse-index.sh: test_expect_success 'pack-objects respects pack.writeR
      '

     +test_expect_success 'reverse index is not generated when available on disk' '
    -+	git index-pack --rev-index $packdir/pack-$pack.pack &&
    ++	test_index_pack true &&
    ++	test_path_is_file $rev &&
     +
     +	git rev-parse HEAD >tip &&
     +	GIT_TEST_REV_INDEX_DIE_IN_MEMORY=1 git cat-file \
--
2.30.0.138.g6d7191ea01
