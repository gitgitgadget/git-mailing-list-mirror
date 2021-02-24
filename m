Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C59C433E9
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE7264F19
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhBXTKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbhBXTKA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:10:00 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9F2C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:19 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id n28so1753096qkk.4
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HhyynpAwzhI0i1rVtR1GNTQ8YBAgiUf5MpxBcZ45X/I=;
        b=MHbsxVXBcK52Hiu1XN1nJaDvoEJynCwGOeZPZ07rHD2UCAGdTJUdwflrrF+mUueMsa
         noBXlv9njf+jRxr/MG11nRuciJSG5c0JQEqg/dbllRBCj2VLWELEdvZxmBjyAcU/nD1E
         YA+2n4ODIjrkh5FPDf7ieyxdg5mHdHjXCPbfKSZlN2OgWcdJbE5IYNj0F2yHpRxfAswF
         pK8yx2RXmdgv58nA5OMR3nfpENx2N6ewSaN/8kYJFOXTYmV9kwiGvUr8NVVOn2H7npp8
         YxSPgGIAGlJcH4ouVvdntkzgIr1UW2TPtgWXtnpUWrZBBUQMlN7i6tC2Fzs4NpAavNaL
         zvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HhyynpAwzhI0i1rVtR1GNTQ8YBAgiUf5MpxBcZ45X/I=;
        b=WvTnEVkZ2v5eskwz0D8B6tk3b0SYwEA0lGT1ahzhfmoWTD2CrHdPEbT1DkgH72MSe7
         Jkt1eLh4eO2APDaMTizaNgC+qfTi98FqJXylzjr2mooPVZ3UNRpNaBLd4vswhpArKedw
         eJuKkW0wN0uuAdP7xeGDYxMxuTu6Bzv2JEcqERcfIALWuZq2Yc1egTRD+fVLdMB5a1iZ
         NiC/NaNovjoGL29Z8RQir0fW93ZeVPe/G+PtKjHW8Y/hXr1PzajpQ774KtnhJFdZng9k
         +sPuMyFhTQpNgSxmS9hdfZKCZ5ubeekWSnfAxoxiaEVtHAF7c+TiX+hXmaLaXLeutA27
         gn+A==
X-Gm-Message-State: AOAM531JrHPIpuEzVluKOxTO0N7xGljjwaqwN+gIMgFO7U/bzv64DEuu
        I9LcV/BJcD5rZyuwG5/Ku02GOGkuV5xfUNsv
X-Google-Smtp-Source: ABdhPJxk8udgaSahFXudFMuiGEIWfUTjP5kg5iG69svZ6ahuVcy1oTeGdIQKhNNX1VCqNf6bs9bhaA==
X-Received: by 2002:a05:620a:400e:: with SMTP id h14mr32418798qko.244.1614193758007;
        Wed, 24 Feb 2021 11:09:18 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:268b:c46e:d22e:db6b])
        by smtp.gmail.com with ESMTPSA id i75sm2177086qke.47.2021.02.24.11.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:09:17 -0800 (PST)
Date:   Wed, 24 Feb 2021 14:09:12 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, avarab@gmail.com,
        gitster@pobox.com
Subject: [PATCH v2 00/15] midx: implement a multi-pack reverse index
Message-ID: <cover.1614193703.git.me@ttaylorr.com>
References: <cover.1612998106.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1612998106.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series to implement a reverse index in preparation for
multi-pack reachability bitmaps. This version is based on a merge of
'ds/chunked-file-api' (currently on 'next') with the tip of 'master'.

The range-diff below looks complicated, but it isn't. The main changes from last
time are:

  - A handful of new patches at the front inspired by Ævar to handle
    sub-command options separately from the main 'git multi-pack-index' builtin.

  - Minor tweaks to the '--show-objects' mode for the multi-pack index helper
    (the information now follows the existing output instead of preceeding it).

  - Many fields have been folded into the new 'write_midx_context' struct, which
    allowed for some related cleanup.

  - A new 'close_midx_revindex()' was added, which I discovered I need for the
    multi-pack bitmaps topic.

I know that we're getting close to an -rc0, so I'm torn about what should happen
with this branch assuming that no major issues are uncovered during review. I
would be happy if this were queued soon so that we can start working on the main
topic which all of this is in support of, but I'm not sure how that would
interact with the upcoming release.

In fact, I think that the first six patches couple make it into 2.31 as-is,
since they have not much to do with the substance of this series and should be
fairly uncontroversial.

In any case, thanks in advance for your review.

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
 Documentation/technical/pack-format.txt      |  80 +++++++
 builtin/multi-pack-index.c                   | 182 ++++++++++++---
 builtin/repack.c                             |   2 +-
 midx.c                                       | 229 +++++++++++++++++--
 midx.h                                       |  11 +-
 pack-revindex.c                              | 127 ++++++++++
 pack-revindex.h                              |  53 +++++
 pack-write.c                                 |  39 +++-
 pack.h                                       |   1 +
 packfile.c                                   |   3 +
 t/helper/test-read-midx.c                    |  24 +-
 t/t5319-multi-pack-index.sh                  |  39 ++++
 14 files changed, 740 insertions(+), 69 deletions(-)

Range-diff against v1:
 -:  ---------- >  1:  0527fa89a9 builtin/multi-pack-index.c: inline 'flags' with options
 -:  ---------- >  2:  a4e107b1f8 builtin/multi-pack-index.c: don't handle 'progress' separately
 -:  ---------- >  3:  8679dfd212 builtin/multi-pack-index.c: define common usage with a macro
 -:  ---------- >  4:  bc42b56ea2 builtin/multi-pack-index.c: split sub-commands
 -:  ---------- >  5:  5daa2946d3 builtin/multi-pack-index.c: don't enter bogus cmd_mode
 -:  ---------- >  6:  98d9ea0770 builtin/multi-pack-index.c: display usage on unrecognized command
 1:  e36acb005d !  7:  2fd9f4debf t/helper/test-read-midx.c: add '--show-objects'
    @@ t/helper/test-read-midx.c
      	uint32_t i;
      	struct multi_pack_index *m;
     @@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir)
    - 	if (!m)
    - 		return 1;
    + 
    + 	printf("object-dir: %s\n", m->object_dir);
      
     +	if (show_objects) {
     +		struct object_id oid;
    @@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir)
     +		return 0;
     +	}
     +
    - 	printf("header: %08x %d %d %d %d\n",
    - 	       m->signature,
    - 	       m->version,
    -@@ t/helper/test-read-midx.c: static int read_midx_file(const char *object_dir)
    + 	return 0;
    + }
      
      int cmd__read_midx(int argc, const char **argv)
      {
 2:  4a358d57cf !  8:  223b899094 midx: allow marking a pack as preferred
    @@ Documentation/git-multi-pack-index.txt: git-multi-pack-index - Write and verify
      DESCRIPTION
      -----------
     @@ Documentation/git-multi-pack-index.txt: OPTIONS
    - 	Turn progress on/off explicitly. If neither is specified, progress is
    - 	shown if standard error is connected to a terminal.
    - 
    -+--preferred-pack=<pack>::
    -+	When using the `write` subcommand, optionally specify the
    -+	tie-breaking pack used when multiple packs contain the same
    -+	object. Incompatible with other subcommands, including `repack`,
    -+	which may repack the pack marked as preferred. If not given, the
    -+	preferred pack is inferred from an existing `multi-pack-index`,
    -+	if one exists, otherwise the pack with the lowest mtime.
    -+
      The following subcommands are available:
      
      write::
    +-	Write a new MIDX file.
    ++	Write a new MIDX file. The following options are available for
    ++	the `write` sub-command:
    +++
    ++--
    ++	--preferred-pack=<pack>::
    ++		Optionally specify the tie-breaking pack used when
    ++		multiple packs contain the same object. If not given,
    ++		ties are broken in favor of the pack with the lowest
    ++		mtime.
    ++--
    + 
    + verify::
    + 	Verify the contents of the MIDX file.
     
      ## Documentation/technical/multi-pack-index.txt ##
     @@ Documentation/technical/multi-pack-index.txt: Design Details
    @@ builtin/multi-pack-index.c
      #include "trace2.h"
     +#include "object-store.h"
      
    - static char const * const builtin_multi_pack_index_usage[] = {
    - 	N_("git multi-pack-index [<options>] (write|verify|expire|repack --batch-size=<size>)"),
    + static char const * const builtin_multi_pack_index_write_usage[] = {
    + #define BUILTIN_MIDX_WRITE_USAGE \
    +-	N_("git multi-pack-index [<options>] write")
    ++	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]")
    + 	BUILTIN_MIDX_WRITE_USAGE,
    + 	NULL
    + };
     @@ builtin/multi-pack-index.c: static char const * const builtin_multi_pack_index_usage[] = {
      
      static struct opts_multi_pack_index {
      	const char *object_dir;
     +	const char *preferred_pack;
      	unsigned long batch_size;
    - 	int progress;
    + 	unsigned flags;
      } opts;
    -@@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc, const char **argv,
    - 	static struct option builtin_multi_pack_index_options[] = {
    - 		OPT_FILENAME(0, "object-dir", &opts.object_dir,
    - 		  N_("object directory containing set of packfile and pack-index pairs")),
    -+		OPT_STRING(0, "preferred-pack", &opts.preferred_pack, N_("preferred-pack"),
    -+		  N_("pack for reuse when computing a multi-pack bitmap")),
    - 		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting")),
    - 		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
    - 		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
    -@@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc, const char **argv,
    - 		return 1;
    - 	}
    +@@ builtin/multi-pack-index.c: static struct option *add_common_options(struct option *prev)
      
    -+	if (strcmp(argv[0], "write") && opts.preferred_pack)
    -+		die(_("'--preferred-pack' requires 'write'"));
    + static int cmd_multi_pack_index_write(int argc, const char **argv)
    + {
    +-	struct option *options = common_opts;
    ++	struct option *options;
    ++	static struct option builtin_multi_pack_index_write_options[] = {
    ++		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
    ++			   N_("preferred-pack"),
    ++			   N_("pack for reuse when computing a multi-pack bitmap")),
    ++		OPT_END(),
    ++	};
     +
    ++	options = parse_options_dup(builtin_multi_pack_index_write_options);
    ++	options = add_common_options(options);
    + 
      	trace2_cmd_mode(argv[0]);
      
    - 	if (!strcmp(argv[0], "repack"))
    -@@ builtin/multi-pack-index.c: int cmd_multi_pack_index(int argc, const char **argv,
    - 		die(_("--batch-size option is only for 'repack' subcommand"));
    +@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv)
    + 		usage_with_options(builtin_multi_pack_index_write_usage,
    + 				   options);
      
    - 	if (!strcmp(argv[0], "write"))
    --		return write_midx_file(opts.object_dir, flags);
    -+		return write_midx_file(opts.object_dir, opts.preferred_pack,
    -+				       flags);
    - 	if (!strcmp(argv[0], "verify"))
    - 		return verify_midx_file(the_repository, opts.object_dir, flags);
    - 	if (!strcmp(argv[0], "expire"))
    +-	return write_midx_file(opts.object_dir, opts.flags);
    ++	return write_midx_file(opts.object_dir, opts.preferred_pack,
    ++			       opts.flags);
    + }
    + 
    + static int cmd_multi_pack_index_verify(int argc, const char **argv)
     
      ## builtin/repack.c ##
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    @@ midx.c: static int pack_info_compare(const void *_a, const void *_b)
     +	return -1;
     +}
     +
    - struct pack_list {
    + struct write_midx_context {
      	struct pack_info *info;
      	uint32_t nr;
    +@@ midx.c: struct write_midx_context {
    + 	uint32_t *pack_perm;
    + 	unsigned large_offsets_needed:1;
    + 	uint32_t num_large_offsets;
    ++
    ++	int preferred_pack_idx;
    + };
    + 
    + static void add_pack_to_midx(const char *full_path, size_t full_path_len,
     @@ midx.c: struct pack_midx_entry {
      	uint32_t pack_int_id;
      	time_t pack_mtime;
    @@ midx.c: static struct pack_midx_entry *get_sorted_entries(struct multi_pack_inde
      				nr_fanout++;
      			}
      		}
    -@@ midx.c: static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
    +@@ midx.c: static int write_midx_large_offsets(struct hashfile *f,
      }
      
      static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
    @@ midx.c: static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_l
     +			       const char *preferred_pack_name,
     +			       unsigned flags)
      {
    - 	unsigned char cur_chunk, num_chunks = 0;
      	char *midx_name;
    + 	uint32_t i;
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    - 	int pack_name_concat_len = 0;
    - 	int dropped_packs = 0;
    - 	int result = 0;
    -+	int preferred_pack_idx = -1;
    - 
    - 	midx_name = get_midx_filename(object_dir);
    - 	if (safe_create_leading_directories(midx_name))
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    - 	if (packs.m && packs.nr == packs.m->num_packs && !packs_to_drop)
    + 	if (ctx.m && ctx.nr == ctx.m->num_packs && !packs_to_drop)
      		goto cleanup;
      
    --	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
    +-	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr);
     +	if (preferred_pack_name) {
    -+		for (i = 0; i < packs.nr; i++) {
    ++		for (i = 0; i < ctx.nr; i++) {
     +			if (!cmp_idx_or_pack_name(preferred_pack_name,
    -+						  packs.info[i].pack_name)) {
    -+				preferred_pack_idx = i;
    ++						  ctx.info[i].pack_name)) {
    ++				ctx.preferred_pack_idx = i;
     +				break;
     +			}
     +		}
    -+	}
    ++	} else
    ++		ctx.preferred_pack_idx = -1;
     +
    -+	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries,
    -+				     preferred_pack_idx);
    ++	ctx.entries = get_sorted_entries(ctx.m, ctx.info, ctx.nr, &ctx.entries_nr,
    ++					 ctx.preferred_pack_idx);
      
    - 	for (i = 0; i < nr_entries; i++) {
    - 		if (entries[i].offset > 0x7fffffff)
    + 	ctx.large_offsets_needed = 0;
    + 	for (i = 0; i < ctx.entries_nr; i++) {
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    - 			pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
    + 			pack_name_concat_len += strlen(ctx.info[i].pack_name) + 1;
      	}
      
     +	/*
     +	 * Recompute the preferred_pack_idx (if applicable) according to the
     +	 * permuted pack order.
     +	 */
    -+	preferred_pack_idx = -1;
    ++	ctx.preferred_pack_idx = -1;
     +	if (preferred_pack_name) {
    -+		preferred_pack_idx = lookup_idx_or_pack_name(packs.info,
    -+							     packs.nr,
    ++		ctx.preferred_pack_idx = lookup_idx_or_pack_name(ctx.info,
    ++							     ctx.nr,
     +							     preferred_pack_name);
    -+		if (preferred_pack_idx < 0)
    ++		if (ctx.preferred_pack_idx < 0)
     +			warning(_("unknown preferred pack: '%s'"),
     +				preferred_pack_name);
     +		else {
    -+			uint32_t orig = packs.info[preferred_pack_idx].orig_pack_int_id;
    -+			uint32_t perm = pack_perm[orig];
    ++			uint32_t orig = ctx.info[ctx.preferred_pack_idx].orig_pack_int_id;
    ++			uint32_t perm = ctx.pack_perm[orig];
     +
     +			if (perm == PACK_EXPIRED) {
     +				warning(_("preferred pack '%s' is expired"),
     +					preferred_pack_name);
    -+				preferred_pack_idx = -1;
    ++				ctx.preferred_pack_idx = -1;
     +			} else
    -+				preferred_pack_idx = perm;
    ++				ctx.preferred_pack_idx = perm;
     +		}
     +	}
     +
    @@ t/t5319-multi-pack-index.sh: test_expect_success 'warn on improper hash version'
     +		) &&
     +
     +		git multi-pack-index --object-dir=objects \
    -+			--preferred-pack=test-BC-$bc.idx write 2>err &&
    ++			write --preferred-pack=test-BC-$bc.idx 2>err &&
     +		test_must_be_empty err &&
     +
     +		ofs=$(git show-index <objects/pack/test-BC-$bc.idx | grep $b |
 3:  218474158a !  9:  976848bc4b midx: don't free midx_name early
    @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack
      	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
     -	FREE_AND_NULL(midx_name);
      
    - 	if (packs.m)
    - 		close_midx(packs.m);
    + 	if (ctx.m)
    + 		close_midx(ctx.m);
 4:  b4b842fa1e <  -:  ---------- midx: keep track of the checksum
 -:  ---------- > 10:  5ed47f7e3a midx: keep track of the checksum
 5:  953beabaa4 ! 11:  0292508e12 midx: make some functions non-static
    @@ midx.c: static off_t nth_midxed_offset(struct multi_pack_index *m, uint32_t pos)
     -static uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
     +uint32_t nth_midxed_pack_int_id(struct multi_pack_index *m, uint32_t pos)
      {
    - 	return get_be32(m->chunk_object_offsets + pos * MIDX_CHUNK_OFFSET_WIDTH);
    - }
    + 	return get_be32(m->chunk_object_offsets +
    + 			(off_t)pos * MIDX_CHUNK_OFFSET_WIDTH);
     
      ## midx.h ##
     @@ midx.h: struct multi_pack_index {
 6:  e64504bad6 <  -:  ---------- Documentation/technical: describe multi-pack reverse indexes
 -:  ---------- > 12:  404d730498 Documentation/technical: describe multi-pack reverse indexes
 7:  4c5e64c5fc ! 13:  d4e01a44e7 pack-revindex: read multi-pack reverse indexes
    @@ midx.c: static uint8_t oid_version(void)
     +		       m->object_dir, hash_to_hex(get_midx_checksum(m)));
     +}
     +
    - struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local)
    + static int midx_read_oid_fanout(const unsigned char *chunk_start,
    + 				size_t chunk_size, void *data)
      {
    - 	struct multi_pack_index *m = NULL;
     
      ## midx.h ##
     @@ midx.h: struct multi_pack_index {
    @@ pack-revindex.c: int load_pack_revindex(struct packed_git *p)
     +	free(revindex_name);
     +	return ret;
     +}
    ++
    ++int close_midx_revindex(struct multi_pack_index *m)
    ++{
    ++	if (!m)
    ++		return 0;
    ++
    ++	if (munmap((void*)m->revindex_map, m->revindex_len))
    ++		return -1;
    ++
    ++	m->revindex_map = NULL;
    ++	m->revindex_data = NULL;
    ++	m->revindex_len = 0;
    ++
    ++	return 0;
    ++}
     +
      int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
      {
    @@ pack-revindex.h: struct packed_git;
     + * A negative number is returned on error.
     + */
     +int load_midx_revindex(struct multi_pack_index *m);
    ++
    ++/*
    ++ * Frees resources associated with a multi-pack reverse index.
    ++ *
    ++ * A negative number is returned on error.
    ++ */
    ++int close_midx_revindex(struct multi_pack_index *m);
     +
      /*
       * offset_to_pack_pos converts an object offset to a pack position. This
 8:  4829b93f42 = 14:  ab7012b283 pack-write.c: extract 'write_rev_file_order'
 9:  fb5954b769 ! 15:  01bd6a35c6 pack-revindex: write multi-pack reverse indexes
    @@ Commit message
     
      ## midx.c ##
     @@
    - #include "trace2.h"
      #include "run-command.h"
      #include "repository.h"
    + #include "chunk-format.h"
     +#include "pack.h"
      
      #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
      #define MIDX_VERSION 1
    -@@ midx.c: static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
    - 	return written;
    +@@ midx.c: struct write_midx_context {
    + 	uint32_t entries_nr;
    + 
    + 	uint32_t *pack_perm;
    ++	uint32_t *pack_order;
    + 	unsigned large_offsets_needed:1;
    + 	uint32_t num_large_offsets;
    + 
    +@@ midx.c: static int write_midx_large_offsets(struct hashfile *f,
    + 	return 0;
      }
      
    -+struct midx_pack_order_data {
    -+	struct pack_midx_entry *entries;
    -+	uint32_t *pack_perm;
    -+};
    -+
    -+static int midx_pack_order_cmp(const void *va, const void *vb, void *_data)
    ++static int midx_pack_order_cmp(const void *va, const void *vb, void *_ctx)
     +{
    -+	struct midx_pack_order_data *data = _data;
    ++	struct write_midx_context *ctx = _ctx;
     +
    -+	struct pack_midx_entry *a = &data->entries[*(const uint32_t *)va];
    -+	struct pack_midx_entry *b = &data->entries[*(const uint32_t *)vb];
    ++	struct pack_midx_entry *a = &ctx->entries[*(const uint32_t *)va];
    ++	struct pack_midx_entry *b = &ctx->entries[*(const uint32_t *)vb];
     +
    -+	uint32_t perm_a = data->pack_perm[a->pack_int_id];
    -+	uint32_t perm_b = data->pack_perm[b->pack_int_id];
    ++	uint32_t perm_a = ctx->pack_perm[a->pack_int_id];
    ++	uint32_t perm_b = ctx->pack_perm[b->pack_int_id];
     +
     +	/* Sort objects in the preferred pack ahead of any others. */
     +	if (a->preferred > b->preferred)
    @@ midx.c: static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_l
     +	return 0;
     +}
     +
    -+static uint32_t *midx_pack_order(struct pack_midx_entry *entries,
    -+				 uint32_t *pack_perm,
    -+				 uint32_t entries_nr)
    ++static uint32_t *midx_pack_order(struct write_midx_context *ctx)
     +{
    -+	struct midx_pack_order_data data;
     +	uint32_t *pack_order;
     +	uint32_t i;
     +
    -+	data.entries = entries;
    -+	data.pack_perm = pack_perm;
    -+
    -+	ALLOC_ARRAY(pack_order, entries_nr);
    -+	for (i = 0; i < entries_nr; i++)
    ++	ALLOC_ARRAY(pack_order, ctx->entries_nr);
    ++	for (i = 0; i < ctx->entries_nr; i++)
     +		pack_order[i] = i;
    -+	QSORT_S(pack_order, entries_nr, midx_pack_order_cmp, &data);
    ++	QSORT_S(pack_order, ctx->entries_nr, midx_pack_order_cmp, ctx);
     +
     +	return pack_order;
     +}
     +
     +static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
    -+				     uint32_t *pack_order,
    -+				     uint32_t entries_nr)
    ++				     struct write_midx_context *ctx)
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +
     +	strbuf_addf(&buf, "%s-%s.rev", midx_name, hash_to_hex(midx_hash));
     +
    -+	write_rev_file_order(buf.buf, pack_order, entries_nr, midx_hash,
    -+			     WRITE_REV);
    ++	write_rev_file_order(buf.buf, ctx->pack_order, ctx->entries_nr,
    ++			     midx_hash, WRITE_REV);
     +
     +	strbuf_release(&buf);
     +}
    @@ midx.c: static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_l
      			       struct string_list *packs_to_drop,
      			       const char *preferred_pack_name,
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    - 	struct lock_file lk;
    - 	struct pack_list packs;
    - 	uint32_t *pack_perm = NULL;
    -+	uint32_t *pack_order = NULL;
    - 	uint64_t written = 0;
    - 	uint32_t chunk_ids[MIDX_MAX_CHUNKS + 1];
    - 	uint64_t chunk_offsets[MIDX_MAX_CHUNKS + 1];
    -@@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    - 		    chunk_offsets[num_chunks]);
      
      	finalize_hashfile(f, midx_hash, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
    + 	free_chunkfile(cf);
    ++
     +	if (flags & MIDX_WRITE_REV_INDEX)
    -+		pack_order = midx_pack_order(entries, pack_perm, nr_entries);
    ++		ctx.pack_order = midx_pack_order(&ctx);
     +
     +	if (flags & MIDX_WRITE_REV_INDEX)
    -+		write_midx_reverse_index(midx_name, midx_hash, pack_order,
    -+					 nr_entries);
    ++		write_midx_reverse_index(midx_name, midx_hash, &ctx);
     +	clear_midx_files_ext(the_repository, ".rev", midx_hash);
     +
      	commit_lock_file(&lk);
      
      cleanup:
     @@ midx.c: static int write_midx_internal(const char *object_dir, struct multi_pack_index *
    - 	free(packs.info);
    - 	free(entries);
    - 	free(pack_perm);
    -+	free(pack_order);
    + 	free(ctx.info);
    + 	free(ctx.entries);
    + 	free(ctx.pack_perm);
    ++	free(ctx.pack_order);
      	free(midx_name);
      	return result;
      }
-- 
2.30.0.667.g81c0cbc6fd
