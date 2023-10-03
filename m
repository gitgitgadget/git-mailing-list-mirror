Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B32E784A4
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 00:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjJCAod (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 20:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJCAoc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 20:44:32 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69705A9
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 17:44:26 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77063481352so211141685a.1
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 17:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696293865; x=1696898665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNz/D9NrbB7t+S481gQFRaJB/kEIJEK2qvRxr9vmZjs=;
        b=ew028cGDQURIzK8GWnhjsJX4VDqXATXLdAzMB9UjY1jmj0uvK1rAVWSpDH7sROE4H7
         21Je5H9makXckXHoAgp5NkN4QKl2pH5Hd7Lni8J5IrvNbO3Nw4xSl3SbG/FCKIIgZKQG
         QB706s3VT/4MiM7RQIUIcIsxUixbNPj2qwDZtJqN8ezXNvKsnY9mk+AHzOzn/Uyg+/4N
         GfRkPuHv7YOS46vI6HCF2SsFN2RDJuk9IYLzc7hYNOFeM0WXfpea10SbhWpAiG2hKMM9
         GdAwkGKlH5z+/RNtO4KnZaRxal7/sr5/OdXvLgA8FguEqv5dXN7r2RysSdgYaq+boRH0
         nOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696293865; x=1696898665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNz/D9NrbB7t+S481gQFRaJB/kEIJEK2qvRxr9vmZjs=;
        b=rEFVnHuPEcnh9M/AfGaj4ImeX6+WGC0V8CXU+92zpG7rQx/OP50DzO5Yu7sPricCbu
         GaWGaIrzISaI01PgDmfqphDNGw/Nx3Kz+6q8mp6vTrcGCCDI6UdWxC5Zq4R+GC2j8F8p
         TD/p8joU367AgI/X+LlCb3zJ8JeOS64zpjzNV18THU0WDS6bn3YzmdHUi+dSwobzth5p
         EhlVWsNSZ9bKsSwDIpyxT+qAZAqvIh/sGkFv5i6StbHGhLWRBQbU2mAXVvkaVaTVvG2j
         Mp1/ZZFMhEFYirpeL2YxM7A+P3GzPRg1ir8+oW8nWXgBkdRgykNxn8C1j6kTB+76zx4m
         eIJA==
X-Gm-Message-State: AOJu0YwduamcWo5YdWKl8dJQ2SLI6D2jEXJ4cC2vHoCRKODjCChpOuyd
        NhasHNGielJ5GIdauCt4WcqkxEcRw2wsvsw+pLipkg==
X-Google-Smtp-Source: AGHT+IEUDQcwuVLYcc1rpdHqdE3MAzO7j1SkR+GPcvbCKaexzdZhHVIEZUEshaDU+MZhZEmlBydsrQ==
X-Received: by 2002:a05:620a:1a9e:b0:767:c30:517 with SMTP id bl30-20020a05620a1a9e00b007670c300517mr1487076qkb.3.1696293865242;
        Mon, 02 Oct 2023 17:44:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u1-20020a0ca701000000b0063d5d173a51sm35563qva.50.2023.10.02.17.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:44:24 -0700 (PDT)
Date:   Mon, 2 Oct 2023 20:44:23 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] repack: implement `--cruft-max-size`
Message-ID: <cover.1696293862.git.me@ttaylorr.com>
References: <cover.1694123506.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1694123506.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(The earlier round of these patches depended on a couple of in-flight
topics, but this series has been rebased onto the tip of 'master').

This is a reroll of my series that introduces more ergonomic options for
creating and dealing with multiple cruft packs.

Much is unchanged since last time, but some notable changes that have
taken place include:

  - adding a missing commit message / s-o-b  to the first patch to split
    cruft-related tests out of t7700 into t7704.

  - renamed the option to `--max-cruft-size` (instead of
    `--cruft-max-size`), and made corresponding changes to the
    documentation, configuration options, tests, etc.

  - cleaned up our handling of how we mark packs to be deleted and
    retained

  - parsed `--max-cruft-size` as an unsigned long up front instead of
    blindly passing a char * down to pack-objects to parse it for us.

The last of those also affects `--max-pack-size`, which caused this
series to grow a new second patch which cleans up the existing code
which suffers from the same issue.

As usual, a range-diff is available below. Thanks for all of the helpful
review on the earlier round, and thanks in advance for your review on
this one!

Taylor Blau (3):
  t7700: split cruft-related tests to t7704
  builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
  builtin/repack.c: implement support for `--max-cruft-size`

 Documentation/config/gc.txt  |   6 +
 Documentation/git-gc.txt     |   7 +
 Documentation/git-repack.txt |  11 +
 builtin/gc.c                 |   7 +
 builtin/repack.c             | 140 +++++++++++--
 t/t6500-gc.sh                |  27 +++
 t/t7700-repack.sh            | 121 -----------
 t/t7704-repack-cruft.sh      | 375 +++++++++++++++++++++++++++++++++++
 8 files changed, 559 insertions(+), 135 deletions(-)
 create mode 100755 t/t7704-repack-cruft.sh

Range-diff against v1:
 1:  103e19c75a <  -:  ---------- builtin/repack.c: extract structure to store existing packs
 2:  45d5f15308 <  -:  ---------- builtin/repack.c: extract marking packs for deletion
 3:  30eccbfdcb <  -:  ---------- builtin/repack.c: extract redundant pack cleanup for --geometric
 4:  57e322301d <  -:  ---------- builtin/repack.c: extract redundant pack cleanup for existing packs
 5:  4df4a2e51e <  -:  ---------- builtin/repack.c: extract `has_existing_non_kept_packs()`
 6:  360be582b4 <  -:  ---------- builtin/repack.c: store existing cruft packs separately
 7:  ef9c8d775b <  -:  ---------- builtin/repack.c: drop `DELETE_PACK` macro
 8:  873bc16abb <  -:  ---------- builtin/repack.c: extract common cruft pack loop
 9:  de6c2a0d70 !  1:  3ed4ab61f6 t7700: split cruft-related tests to t7704
    @@ Metadata
      ## Commit message ##
         t7700: split cruft-related tests to t7704
     
    +    A small handful of the tests in t7700 (the main script for testing
    +    functionality of 'git repack') are specifically related to cruft pack
    +    operations.
    +
    +    Prepare for adding new cruft pack-related tests by moving the existing
    +    set into a new test script.
    +
    +    Signed-off-by: Taylor Blau <me@ttaylorr.com>
    +
      ## t/t7700-repack.sh ##
     @@ t/t7700-repack.sh: test_expect_success '-n overrides repack.updateServerInfo=true' '
      	test_server_info_missing
 -:  ---------- >  2:  9ec999882d builtin/repack.c: parse `--max-pack-size` with OPT_MAGNITUDE
10:  7e4e42e1aa !  3:  e7beb2060d builtin/repack.c: implement support for `--cruft-max-size`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    builtin/repack.c: implement support for `--cruft-max-size`
    +    builtin/repack.c: implement support for `--max-cruft-size`
     
         Cruft packs are an alternative mechanism for storing a collection of
         unreachable objects whose mtimes are recent enough to avoid being
    @@ Commit message
         (for more, see some of the details in 3d89a8c118
         (Documentation/technical: add cruft-packs.txt, 2022-05-20)).
     
    -    This all works, but can be costly from an I/O-perspective when a
    -    repository has either (a) many unreachable objects, (b) prunes objects
    -    relatively infrequently/never, or (c) both.
    +    This all works, but can be costly from an I/O-perspective when
    +    frequently repacking a repository that has many unreachable objects.
    +    This problem is exacerbated when those unreachable objects are rarely
    +    (if every) pruned.
     
         Since there is at most one cruft pack in the above scheme, each time we
         update the cruft pack it must be rewritten from scratch. Because much of
    @@ Commit message
         multiple cruft packs. This patch implements that support which we were
         lacking.
     
    -    Introduce a new option `--cruft-max-size` which allows repositories to
    +    Introduce a new option `--max-cruft-size` which allows repositories to
         accumulate cruft packs up to a given size, after which point a new
         generation of cruft packs can accumulate until it reaches the maximum
         size, and so on. To generate a new cruft pack, the process works like
    @@ Commit message
             pack, along with any other unreachable objects which have since
             entered the repository.
     
    -    This limits the I/O churn up to a quadratic function of the value
    -    specified by the `--cruft-max-size` option, instead of behaving
    -    quadratically in the number of total unreachable objects.
    +    Once a cruft pack grows beyond the size specified via `--max-cruft-size`
    +    the pack is effectively frozen. This limits the I/O churn up to a
    +    quadratic function of the value specified by the `--max-cruft-size`
    +    option, instead of behaving quadratically in the number of total
    +    unreachable objects.
     
    -    When pruning unreachable objects, we bypass the new paths which combine
    -    small cruft packs together, and instead start from scratch, passing in
    -    the appropriate `--max-pack-size` down to `pack-objects`, putting it in
    -    charge of keeping the resulting set of cruft packs sized correctly.
    +    When pruning unreachable objects, we bypass the new code paths which
    +    combine small cruft packs together, and instead start from scratch,
    +    passing in the appropriate `--max-pack-size` down to `pack-objects`,
    +    putting it in charge of keeping the resulting set of cruft packs sized
    +    correctly.
     
         This may seem like further I/O churn, but in practice it isn't so bad.
         We could prune old cruft packs for whom all or most objects are removed,
    @@ Documentation/config/gc.txt: gc.cruftPacks::
      	linkgit:git-repack[1]) instead of as loose objects. The default
      	is `true`.
      
    -+gc.cruftMaxSize::
    ++gc.maxCruftSize::
     +	Limit the size of new cruft packs when repacking. When
    -+	specified in addition to `--cruft-max-size`, the command line
    -+	option takes priority. See the `--cruft-max-size` option of
    ++	specified in addition to `--max-cruft-size`, the command line
    ++	option takes priority. See the `--max-cruft-size` option of
     +	linkgit:git-repack[1].
     +
      gc.pruneExpire::
    @@ Documentation/git-gc.txt: be performed as well.
      	cruft pack instead of storing them as loose objects. `--cruft`
      	is on by default.
      
    -+--cruft-max-size=<n>::
    ++--max-cruft-size=<n>::
     +	When packing unreachable objects into a cruft pack, limit the
     +	size of new cruft packs to be at most `<n>`. Overrides any
    -+	value specified via the `gc.cruftMaxSize` configuration. See
    -+	the `--cruft-max-size` option of linkgit:git-repack[1] for
    ++	value specified via the `gc.maxCruftSize` configuration. See
    ++	the `--max-cruft-size` option of linkgit:git-repack[1] for
     +	more.
     +
      --prune=<date>::
    @@ Documentation/git-repack.txt: to the new separate pack will be written.
      	immediately instead of waiting for the next `git gc` invocation.
      	Only useful with `--cruft -d`.
      
    -+--cruft-max-size=<n>::
    -+	Repack cruft objects into packs as large as `<n>` before
    ++--max-cruft-size=<n>::
    ++	Repack cruft objects into packs as large as `<n>` bytes before
     +	creating new packs. As long as there are enough cruft packs
     +	smaller than `<n>`, repacking will cause a new cruft pack to
     +	be created containing objects from any combined cruft packs,
    -+	along with any new unreachable objects. Cruft packs larger
    -+	than `<n>` will not be modified. Only useful with `--cruft
    -+	-d`.
    ++	along with any new unreachable objects. Cruft packs larger than
    ++	`<n>` will not be modified. When the new cruft pack is larger
    ++	than `<n>` bytes, it will be split into multiple packs, all of
    ++	which are guaranteed to be at most `<n>` bytes in size. Only
    ++	useful with `--cruft -d`.
     +
      --expire-to=<dir>::
      	Write a cruft pack containing pruned objects (if any) to the
    @@ builtin/gc.c: static const char * const builtin_gc_usage[] = {
      static int pack_refs = 1;
      static int prune_reflogs = 1;
      static int cruft_packs = 1;
    -+static char *cruft_max_size;
    ++static unsigned long max_cruft_size;
      static int aggressive_depth = 50;
      static int aggressive_window = 250;
      static int gc_auto_threshold = 6700;
    @@ builtin/gc.c: static void gc_config(void)
      	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
      	git_config_get_bool("gc.autodetach", &detach_auto);
      	git_config_get_bool("gc.cruftpacks", &cruft_packs);
    -+	git_config_get_string("gc.cruftmaxsize", &cruft_max_size);
    ++	git_config_get_ulong("gc.maxcruftsize", &max_cruft_size);
      	git_config_get_expiry("gc.pruneexpire", &prune_expire);
      	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
      	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
    @@ builtin/gc.c: static void add_repack_all_option(struct string_list *keep_pack)
      		strvec_push(&repack, "--cruft");
      		if (prune_expire)
      			strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);
    -+		if (cruft_max_size)
    -+			strvec_pushf(&repack, "--cruft-max-size=%s",
    -+				     cruft_max_size);
    ++		if (max_cruft_size)
    ++			strvec_pushf(&repack, "--max-cruft-size=%lu",
    ++				     max_cruft_size);
      	} else {
      		strvec_push(&repack, "-A");
      		if (prune_expire)
    @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      			N_("prune unreferenced objects"),
      			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
      		OPT_BOOL(0, "cruft", &cruft_packs, N_("pack unreferenced objects separately")),
    -+		OPT_STRING(0, "cruft-max-size", &cruft_max_size,
    -+			   N_("bytes"),
    -+			   N_("with --cruft, limit the size of new cruft packs")),
    ++		OPT_MAGNITUDE(0, "max-cruft-size", &max_cruft_size,
    ++			      N_("with --cruft, limit the size of new cruft packs")),
      		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
      		OPT_BOOL_F(0, "auto", &auto_gc, N_("enable auto-gc mode"),
      			   PARSE_OPT_NOCOMPLETE),
     
      ## builtin/repack.c ##
     @@
    - #define LOOSEN_UNREACHABLE 2
      #define PACK_CRUFT 4
      
    -+#define DELETE_PACK ((void*)(uintptr_t)1)
    -+#define RETAIN_PACK ((uintptr_t)(1<<1))
    -+
    + #define DELETE_PACK 1
    ++#define RETAIN_PACK 2
    + 
      static int pack_everything;
      static int delta_base_offset = 1;
    - static int pack_kept_objects = -1;
    -@@ builtin/repack.c: static int has_existing_non_kept_packs(const struct existing_packs *existing)
    - 	return existing->non_kept_packs.nr || existing->cruft_packs.nr;
    +@@ builtin/repack.c: static void pack_mark_for_deletion(struct string_list_item *item)
    + 	item->util = (void*)((uintptr_t)item->util | DELETE_PACK);
      }
      
    ++static void pack_unmark_for_deletion(struct string_list_item *item)
    ++{
    ++	item->util = (void*)((uintptr_t)item->util & ~DELETE_PACK);
    ++}
    ++
    + static int pack_is_marked_for_deletion(struct string_list_item *item)
    + {
    + 	return (uintptr_t)item->util & DELETE_PACK;
    + }
    + 
    ++static void pack_mark_retained(struct string_list_item *item)
    ++{
    ++	item->util = (void*)((uintptr_t)item->util | RETAIN_PACK);
    ++}
    ++
     +static int pack_is_retained(struct string_list_item *item)
     +{
     +	return (uintptr_t)item->util & RETAIN_PACK;
    @@ builtin/repack.c: static void mark_packs_for_deletion_1(struct string_list *name
     -		 * (if `-d` was given).
     -		 */
     -		if (!string_list_has_string(names, sha1))
    --			item->util = (void*)1;
     +
     +		if (pack_is_retained(item)) {
    -+			item->util = NULL;
    ++			pack_unmark_for_deletion(item);
     +		} else if (!string_list_has_string(names, sha1)) {
     +			/*
     +			 * Mark this pack for deletion, which ensures
    @@ builtin/repack.c: static void mark_packs_for_deletion_1(struct string_list *name
     +			 * will actually delete this pack (if `-d` was
     +			 * given).
     +			 */
    -+			item->util = DELETE_PACK;
    + 			pack_mark_for_deletion(item);
     +		}
      	}
      }
    @@ builtin/repack.c: static void mark_packs_for_deletion_1(struct string_list *name
     +	if (!item)
     +		BUG("could not find cruft pack '%s'", pack_basename(cruft));
     +
    -+	item->util = (void*)RETAIN_PACK;
    ++	pack_mark_retained(item);
     +	strbuf_release(&buf);
     +}
     +
    @@ builtin/repack.c: static void remove_redundant_bitmaps(struct string_list *inclu
     +	return 0;
     +}
     +
    -+static void collapse_small_cruft_packs(FILE *in, unsigned long max_size,
    ++static void collapse_small_cruft_packs(FILE *in, size_t max_size,
     +				       struct existing_packs *existing)
     +{
     +	struct packed_git **existing_cruft, *p;
     +	struct strbuf buf = STRBUF_INIT;
    -+	unsigned long total_size = 0;
    ++	size_t total_size = 0;
     +	size_t existing_cruft_nr = 0;
     +	size_t i;
     +
    @@ builtin/repack.c: static void remove_redundant_bitmaps(struct string_list *inclu
     +	QSORT(existing_cruft, existing_cruft_nr, existing_cruft_pack_cmp);
     +
     +	for (i = 0; i < existing_cruft_nr; i++) {
    -+		off_t proposed;
    ++		size_t proposed;
     +
     +		p = existing_cruft[i];
     +		proposed = st_add(total_size, p->pack_size);
    @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *ar
     -	for_each_string_list_item(item, &existing->cruft_packs)
     -		fprintf(in, "-%s.pack\n", item->string);
     +	if (args->max_pack_size && !cruft_expiration) {
    -+		unsigned long max_pack_size;
    -+		if (!git_parse_ulong(args->max_pack_size, &max_pack_size))
    -+			return error(_("could not parse --cruft-max-size: '%s'"),
    -+				     args->max_pack_size);
    -+		collapse_small_cruft_packs(in, max_pack_size, existing);
    ++		collapse_small_cruft_packs(in, args->max_pack_size, existing);
     +	} else {
     +		for_each_string_list_item(item, &existing->non_kept_packs)
     +			fprintf(in, "-%s.pack\n", item->string);
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      				   PACK_CRUFT),
      		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
      				N_("with --cruft, expire objects older than this")),
    -+		OPT_STRING(0, "cruft-max-size", &cruft_po_args.max_pack_size,
    -+				N_("bytes"),
    ++		OPT_MAGNITUDE(0, "max-cruft-size", &cruft_po_args.max_pack_size,
     +				N_("with --cruft, limit the size of new cruft packs")),
      		OPT_BOOL('d', NULL, &delete_redundant,
      				N_("remove redundant packs, and run git-prune-packed")),
    @@ t/t6500-gc.sh: test_expect_success 'gc.bigPackThreshold ignores cruft packs' '
      
     +cruft_max_size_opts="git repack -d -l --cruft --cruft-expiration=2.weeks.ago"
     +
    -+test_expect_success 'setup for --cruft-max-size tests' '
    ++test_expect_success 'setup for --max-cruft-size tests' '
     +	git init cruft--max-size &&
     +	(
     +		cd cruft--max-size &&
    @@ t/t6500-gc.sh: test_expect_success 'gc.bigPackThreshold ignores cruft packs' '
     +	)
     +'
     +
    -+test_expect_success '--cruft-max-size sets appropriate repack options' '
    ++test_expect_success '--max-cruft-size sets appropriate repack options' '
     +	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size \
    -+		gc --cruft --cruft-max-size=1M &&
    -+	test_subcommand $cruft_max_size_opts --cruft-max-size=1M <trace2.txt
    ++		gc --cruft --max-cruft-size=1M &&
    ++	test_subcommand $cruft_max_size_opts --max-cruft-size=1048576 <trace2.txt
     +'
     +
    -+test_expect_success 'gc.cruftMaxSize sets appropriate repack options' '
    ++test_expect_success 'gc.maxCruftSize sets appropriate repack options' '
     +	GIT_TRACE2_EVENT=$(pwd)/trace2.txt \
    -+		git -C cruft--max-size -c gc.cruftMaxSize=2M gc --cruft &&
    -+	test_subcommand $cruft_max_size_opts --cruft-max-size=2M <trace2.txt &&
    ++		git -C cruft--max-size -c gc.maxCruftSize=2M gc --cruft &&
    ++	test_subcommand $cruft_max_size_opts --max-cruft-size=2097152 <trace2.txt &&
     +
     +	GIT_TRACE2_EVENT=$(pwd)/trace2.txt \
    -+		git -C cruft--max-size -c gc.cruftMaxSize=2M gc --cruft \
    -+		--cruft-max-size=3M &&
    -+	test_subcommand $cruft_max_size_opts --cruft-max-size=3M <trace2.txt
    ++		git -C cruft--max-size -c gc.maxCruftSize=2M gc --cruft \
    ++		--max-cruft-size=3M &&
    ++	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
     +'
     +
      run_and_wait_for_auto_gc () {
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +	echo "$packdir/pack-$pack.mtimes"
     +}
     +
    -+test_expect_success '--cruft-max-size creates new packs when above threshold' '
    -+	git init cruft-max-size-large &&
    ++test_expect_success '--max-cruft-size creates new packs when above threshold' '
    ++	git init max-cruft-size-large &&
     +	(
    -+		cd cruft-max-size-large &&
    ++		cd max-cruft-size-large &&
     +		test_commit base &&
     +
     +		foo="$(pack_random_blob foo $((1*1024*1024)))" &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +		cruft_foo="$(ls $packdir/pack-*.mtimes)" &&
     +
     +		bar="$(pack_random_blob bar $((1*1024*1024)))" &&
    -+		git repack --cruft -d --cruft-max-size=1M &&
    ++		git repack --cruft -d --max-cruft-size=1M &&
     +		cruft_bar="$(ls $packdir/pack-*.mtimes | grep -v $cruft_foo)" &&
     +
     +		test-tool pack-mtimes $(basename "$cruft_foo") >foo.objects &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +	)
     +'
     +
    -+test_expect_success '--cruft-max-size combines existing packs when below threshold' '
    -+	git init cruft-max-size-small &&
    ++test_expect_success '--max-cruft-size combines existing packs when below threshold' '
    ++	git init max-cruft-size-small &&
     +	(
    -+		cd cruft-max-size-small &&
    ++		cd max-cruft-size-small &&
     +		test_commit base &&
     +
     +		foo="$(pack_random_blob foo $((1*1024*1024)))" &&
     +		git repack --cruft -d &&
     +
     +		bar="$(pack_random_blob bar $((1*1024*1024)))" &&
    -+		git repack --cruft -d --cruft-max-size=10M &&
    ++		git repack --cruft -d --max-cruft-size=10M &&
     +
     +		cruft=$(ls $packdir/pack-*.mtimes) &&
     +		test-tool pack-mtimes $(basename "$cruft") >cruft.objects &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +	)
     +'
     +
    -+test_expect_success '--cruft-max-size combines smaller packs first' '
    -+	git init cruft-max-size-consume-small &&
    ++test_expect_success '--max-cruft-size combines smaller packs first' '
    ++	git init max-cruft-size-consume-small &&
     +	(
    -+		cd cruft-max-size-consume-small &&
    ++		cd max-cruft-size-consume-small &&
     +
     +		test_commit base &&
     +		git repack -ad &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +		test-tool pack-mtimes "$(basename $cruft_bar)" >>expect.raw &&
     +		sort expect.raw >expect.objects &&
     +
    -+		# repacking with `--cruft-max-size=2M` should combine
    ++		# repacking with `--max-cruft-size=2M` should combine
     +		# both 0.5 MiB packs together, instead of, say, one of
     +		# the 0.5 MiB packs with the 1.0 MiB pack
     +		ls $packdir/pack-*.mtimes | sort >cruft.before &&
    -+		git repack -d --cruft --cruft-max-size=2M &&
    ++		git repack -d --cruft --max-cruft-size=2M &&
     +		ls $packdir/pack-*.mtimes | sort >cruft.after &&
     +
     +		comm -13 cruft.before cruft.after >cruft.new &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +	)
     +'
     +
    -+test_expect_success 'setup --cruft-max-size with freshened objects' '
    -+	git init cruft-max-size-freshen &&
    ++test_expect_success 'setup --max-cruft-size with freshened objects' '
    ++	git init max-cruft-size-freshen &&
     +	(
    -+		cd cruft-max-size-freshen &&
    ++		cd max-cruft-size-freshen &&
     +
     +		test_commit base &&
     +		git repack -ad &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +	)
     +'
     +
    -+test_expect_success '--cruft-max-size with freshened objects (loose)' '
    ++test_expect_success '--max-cruft-size with freshened objects (loose)' '
     +	(
    -+		cd cruft-max-size-freshen &&
    ++		cd max-cruft-size-freshen &&
     +
     +		# regenerate the object, setting its mtime to be more recent
     +		foo="$(generate_random_blob foo 64)" &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +	)
     +'
     +
    -+test_expect_success '--cruft-max-size with freshened objects (packed)' '
    ++test_expect_success '--max-cruft-size with freshened objects (packed)' '
     +	(
    -+		cd cruft-max-size-freshen &&
    ++		cd max-cruft-size-freshen &&
     +
     +		# regenerate the object and store it in a packfile,
     +		# setting its mtime to be more recent
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +	)
     +'
     +
    -+test_expect_success '--cruft-max-size with pruning' '
    -+	git init cruft-max-size-prune &&
    ++test_expect_success '--max-cruft-size with pruning' '
    ++	git init max-cruft-size-prune &&
     +	(
    -+		cd cruft-max-size-prune &&
    ++		cd max-cruft-size-prune &&
     +
     +		test_commit base &&
     +		foo="$(generate_random_blob foo $((1024*1024)))" &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +
     +		test-tool chmtime -10000 "$objdir/$(test_oid_to_path "$foo")" &&
     +
    -+		git repack -d --cruft --cruft-max-size=1M &&
    ++		git repack -d --cruft --max-cruft-size=1M &&
     +
     +		# backdate the mtimes of all cruft packs to validate
     +		# that they were rewritten as a result of pruning
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +			echo $cruft $mtime >>mtimes || return 1
     +		done &&
     +
    -+		# repack (and prune) with a --cruft-max-size to ensure
    ++		# repack (and prune) with a --max-cruft-size to ensure
     +		# that we appropriately split the resulting set of packs
    -+		git repack -d --cruft --cruft-max-size=1M \
    ++		git repack -d --cruft --max-cruft-size=1M \
     +			--cruft-expiration=10.seconds.ago &&
     +		ls $packdir/pack-*.mtimes | sort >cruft.after &&
     +
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +	)
     +'
     +
    -+test_expect_success '--cruft-max-size ignores non-local packs' '
    -+	repo="cruft-max-size-non-local" &&
    ++test_expect_success '--max-cruft-size ignores non-local packs' '
    ++	repo="max-cruft-size-non-local" &&
     +	git init $repo &&
     +	(
     +		cd $repo &&
    @@ t/t7704-repack-cruft.sh: test_expect_success '--expire-to stores pruned objects
     +		# ensure that we do not attempt to pick up packs from
     +		# the non-alternated repository, which would result in a
     +		# crash
    -+		git repack --cruft --cruft-max-size=1M -d
    ++		git repack --cruft --max-cruft-size=1M -d
     +	)
     +'
     +
-- 
2.42.0.310.g9604b54f73.dirty
