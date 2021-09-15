Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F3FC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B93C611C8
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhIOSZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhIOSZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:25:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D740C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:35 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h29so3984935ila.2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vVH+zuYyMXhDlB1w9Z5gYmQXKAOPAlYzwQBYHi6E0nI=;
        b=UuVe3w/aSCwn0cmFeZO2IHfGjwhlvFZv4dfbg4uNT0KuuHFOhUV1SmB10T/sRKmhUg
         HXy+hopVT0gaPeGmXOqqsJIMTOSBQ5/DyKQ+u5eXOf/ylhYdjL9NBfazOLQYQ91eOaGx
         91UONvGXLzY9pn4IYjeAPqh3aheMSPSy0DwAdWUL4km7dX6vZAUL2FuYjwUM8JAZ6ydy
         HIjJtT6MDA0FEVAIGt6U8m6U4uA6/VjedP+ggt32BFKStBGbC2o+S2O15N5uu8X/7DZN
         cIB7liUKlIwR7AgNM1SX0ySA5vHGMzEpKRHM/K7xV1gIzq7rl8ZzdaFOgBrev0Wu9WDY
         g1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vVH+zuYyMXhDlB1w9Z5gYmQXKAOPAlYzwQBYHi6E0nI=;
        b=nEUJG1JnCWYMH+OlFCy4xhX7VqAxR+WQorwRSIziZLTzgSmBO3HsoWeUg5Atp3XC7k
         po9GpW87yASwMOKOufIR2yd1DaZeF31VQvPf8RtmgZ0bM8kWZQEPk/hicYEMxMv4Y+Db
         bP6cl51lvoBZUHCJzPrXDb7+IoWz/yIkhdyN3I6CIwmak8DZh8dig7qR8Yns2Y9QGfAE
         jVEoXummlQCggeoi6iJCNFNXQs27jt/SVrFCOwrA0nncrDel9AiFpNqhzOH8tUfsDY0k
         HVbMMmgtW7wG3/T1G8NkJLCWOVRh3SDG6/hRdqyhBr02kQbIco4nf7ocSjzrjqfAG2xR
         yv7A==
X-Gm-Message-State: AOAM533UNoBPnEDRb0w0rGnO8ldRkDSPjdUmi6IEHBzDQc6amTspKAZR
        EBmbzHBqOeu/sMqAPGFuCz3/GvjWwm7ZzO5S
X-Google-Smtp-Source: ABdhPJymwadMyuUf0aVo3MDNWAinF4W+W8+wN1il26Fl10osPasnEgpmXbD4/ApdhnV4BB6mfBrvQw==
X-Received: by 2002:a92:cd07:: with SMTP id z7mr1061870iln.15.1631730274458;
        Wed, 15 Sep 2021 11:24:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k14sm365100ili.35.2021.09.15.11.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:24:34 -0700 (PDT)
Date:   Wed, 15 Sep 2021 14:24:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v2 0/8] repack: introduce `--write-midx`
Message-ID: <cover.1631730270.git.me@ttaylorr.com>
References: <cover.1631331139.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631331139.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a small reroll of my series to implement the final component of
multi-pack reachability bitamps, which is to be able to write them from `git
repack`.

Nothing substantial has changed since last time. Mostly re-wrapping lines and
removing braces in macro'd for_each_xyz() loops. A larger (but still small)
change is how we read input to `--refs-snapshot`. This version contains a more
idiomatic implementation, but see the sub-thread beginning at [1] for a more
complete discussion.

Otherwise, this series is unchagned. It depends on tb/multi-pack-bitmaps, which
has graduated to master. Range-diff below:

[1]: https://lore.kernel.org/git/2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com/

Taylor Blau (8):
  midx: expose `write_midx_file_only()` publicly
  builtin/multi-pack-index.c: support `--stdin-packs` mode
  midx: preliminary support for `--refs-snapshot`
  builtin/repack.c: keep track of existing packs unconditionally
  builtin/repack.c: extract showing progress to a variable
  builtin/repack.c: support writing a MIDX while repacking
  builtin/repack.c: make largest pack preferred
  builtin/repack.c: pass `--refs-snapshot` when writing bitmaps

 Documentation/git-multi-pack-index.txt |  19 ++
 Documentation/git-repack.txt           |  18 +-
 builtin/multi-pack-index.c             |  36 +++-
 builtin/repack.c                       | 255 ++++++++++++++++++++++---
 midx.c                                 |  96 ++++++++--
 midx.h                                 |  11 +-
 pack-bitmap.c                          |   2 +-
 pack-bitmap.h                          |   1 +
 t/helper/test-read-midx.c              |  25 ++-
 t/lib-midx.sh                          |   8 +
 t/t5319-multi-pack-index.sh            |  15 ++
 t/t5326-multi-pack-bitmaps.sh          |  82 ++++++++
 t/t7700-repack.sh                      |  96 ++++++++++
 t/t7703-repack-geometric.sh            |  22 +++
 14 files changed, 637 insertions(+), 49 deletions(-)
 create mode 100644 t/lib-midx.sh

Range-diff against v1:
1:  6d50f46080 ! 1:  03c1b2c4d3 midx: expose 'write_midx_file_only()' publicly
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    midx: expose 'write_midx_file_only()' publicly
    +    midx: expose `write_midx_file_only()` publicly
     
         Expose a variant of the write_midx_file() function which ignores packs
         that aren't included in an explicit "allow" list.
    @@ midx.c: struct write_midx_context {
      
      static void add_pack_to_midx(const char *full_path, size_t full_path_len,
     @@ midx.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
    - 
    - 	if (ends_with(file_name, ".idx")) {
      		display_progress(ctx->progress, ++ctx->pack_paths_checked);
    --		if (ctx->m && midx_contains_pack(ctx->m, file_name))
    --			return;
    -+		if (ctx->m) {
    -+			if (midx_contains_pack(ctx->m, file_name))
    -+				return;
    -+		} else if (ctx->to_include) {
    -+			if (!string_list_has_string(ctx->to_include, file_name))
    -+				return;
    -+		}
    + 		if (ctx->m && midx_contains_pack(ctx->m, file_name))
    + 			return;
    ++		else if (ctx->to_include &&
    ++			 !string_list_has_string(ctx->to_include, file_name))
    ++			return;
      
      		ALLOC_GROW(ctx->info, ctx->nr + 1, ctx->alloc);
      
    @@ midx.h: int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pa
      int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
      
      int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
    -+int write_midx_file_only(const char *object_dir, struct string_list *packs_to_include, const char *preferred_pack_name, unsigned flags);
    ++int write_midx_file_only(const char *object_dir,
    ++			 struct string_list *packs_to_include,
    ++			 const char *preferred_pack_name,
    ++			 unsigned flags);
      void clear_midx_file(struct repository *r);
      int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
      int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
2:  66aa7f4b48 ! 2:  59556e5545 builtin/multi-pack-index.c: support --stdin-packs mode
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    builtin/multi-pack-index.c: support --stdin-packs mode
    +    builtin/multi-pack-index.c: support `--stdin-packs` mode
     
         To power a new `--write-midx` mode, `git repack` will want to write a
         multi-pack index containing a certain set of packs in the repository.
    @@ builtin/multi-pack-index.c: static struct option *add_common_options(struct opti
     +static void read_packs_from_stdin(struct string_list *to)
     +{
     +	struct strbuf buf = STRBUF_INIT;
    -+	while (strbuf_getline(&buf, stdin) != EOF) {
    -+		string_list_append(to, strbuf_detach(&buf, NULL));
    -+	}
    ++	while (strbuf_getline(&buf, stdin) != EOF)
    ++		string_list_append(to, buf.buf);
     +	string_list_sort(to);
    ++
    ++	strbuf_release(&buf);
     +}
     +
      static int cmd_multi_pack_index_write(int argc, const char **argv)
    @@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, cons
      	FREE_AND_NULL(options);
      
     +	if (opts.stdin_packs) {
    -+		struct string_list packs = STRING_LIST_INIT_NODUP;
    ++		struct string_list packs = STRING_LIST_INIT_DUP;
     +		int ret;
     +
     +		read_packs_from_stdin(&packs);
3:  f74a967be3 ! 3:  42f1ae9ede midx: preliminary support for `--refs-snapshot`
    @@ midx.h: int fill_midx_entry(struct repository *r, const struct object_id *oid, s
      int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
      
     -int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
    --int write_midx_file_only(const char *object_dir, struct string_list *packs_to_include, const char *preferred_pack_name, unsigned flags);
    -+int write_midx_file(const char *object_dir, const char *preferred_pack_name, const char *refs_snapshot, unsigned flags);
    -+int write_midx_file_only(const char *object_dir, struct string_list *packs_to_include, const char *preferred_pack_name, const char *refs_snapshot, unsigned flags);
    ++int write_midx_file(const char *object_dir,
    ++		    const char *preferred_pack_name,
    ++		    const char *refs_snapshot,
    ++		    unsigned flags);
    + int write_midx_file_only(const char *object_dir,
    + 			 struct string_list *packs_to_include,
    + 			 const char *preferred_pack_name,
    ++			 const char *refs_snapshot,
    + 			 unsigned flags);
      void clear_midx_file(struct repository *r);
      int verify_midx_file(struct repository *r, const char *object_dir, unsigned flags);
    - int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags);
     
      ## t/t5326-multi-pack-bitmaps.sh ##
     @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitmapTips' '
4:  5067c2cc65 = 4:  c0d045a9de builtin/repack.c: keep track of existing packs unconditionally
5:  d5990e3b69 = 5:  09de03de47 builtin/repack.c: extract showing progress to a variable
6:  d32d800954 ! 6:  83dfdb8b12 builtin/repack.c: support writing a MIDX while repacking
    @@ builtin/repack.c: static void clear_pack_geometry(struct pack_geometry *geometry
     +{
     +	struct string_list_item *item;
     +
    -+	for_each_string_list_item(item, existing_kept_packs) {
    ++	for_each_string_list_item(item, existing_kept_packs)
     +		string_list_insert(include, xstrfmt("%s.idx", item->string));
    -+	}
    -+	for_each_string_list_item(item, names) {
    ++	for_each_string_list_item(item, names)
     +		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
    -+	}
     +	if (geometry) {
     +		struct strbuf buf = STRBUF_INIT;
     +		uint32_t i;
    @@ builtin/repack.c: static void clear_pack_geometry(struct pack_geometry *geometry
     +		return ret;
     +
     +	in = xfdopen(cmd.in, "w");
    -+	for_each_string_list_item(item, include) {
    ++	for_each_string_list_item(item, include)
     +		fprintf(in, "%s\n", item->string);
    -+	}
     +	fclose(in);
     +
     +	return finish_command(&cmd);
7:  515e1d95a6 ! 7:  68bc49d8ae builtin/repack.c: make largest pack preferred
    @@ builtin/repack.c: static void split_pack_geometry(struct pack_geometry *geometry
      
     +static struct packed_git *get_largest_active_pack(struct pack_geometry *geometry)
     +{
    ++	if (!geometry) {
    ++		/*
    ++		 * No geometry means either an all-into-one repack (in which
    ++		 * case there is only one pack left and it is the largest) or an
    ++		 * incremental one.
    ++		 *
    ++		 * If repacking incrementally, then we could check the size of
    ++		 * all packs to determine which should be preferred, but leave
    ++		 * this for later.
    ++		 */
    ++		return NULL;
    ++	}
     +	if (geometry->split == geometry->pack_nr)
     +		return NULL;
     +	return geometry->pack[geometry->pack_nr - 1];
    @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
      				     int show_progress, int write_bitmaps)
      {
      	struct child_process cmd = CHILD_PROCESS_INIT;
    + 	struct string_list_item *item;
    ++	struct packed_git *largest = get_largest_active_pack(geometry);
    + 	FILE *in;
    + 	int ret;
    + 
     @@ builtin/repack.c: static int write_midx_included_packs(struct string_list *include,
      	if (write_bitmaps)
      		strvec_push(&cmd.args, "--bitmap");
      
    -+	if (geometry) {
    -+		struct packed_git *largest = get_largest_active_pack(geometry);
    -+		if (largest)
    -+			strvec_pushf(&cmd.args, "--preferred-pack=%s",
    -+				     pack_basename(largest));
    -+		else
    -+			/*
    -+			 * The largest pack was repacked, meaning only one pack
    -+			 * exists (and tautologically, it is the largest).
    -+			 */
    -+			;
    -+	}
    ++	if (largest)
    ++		strvec_pushf(&cmd.args, "--preferred-pack=%s",
    ++			     pack_basename(largest));
     +
      	ret = start_command(&cmd);
      	if (ret)
    @@ t/t7703-repack-geometric.sh: test_expect_success '--geometric ignores kept packs
     +	test_when_finished "rm -fr geometric" &&
     +	(
     +		cd geometric &&
    -+		git config core.multiPackIndex true &&
     +
     +		# These packs already form a geometric progression.
     +		test_commit_bulk --start=1 1 && # 3 objects
8:  74a9da0ef0 ! 8:  eb24b308ec builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
    @@ builtin/repack.c: static void clear_pack_geometry(struct pack_geometry *geometry
     +	return 0;
     +}
     +
    -+static int midx_snapshot_refs(struct tempfile *f)
    ++static void midx_snapshot_refs(struct tempfile *f)
     +{
     +	struct midx_snapshot_ref_data data;
     +	const struct string_list *preferred = bitmap_preferred_tips(the_repository);
    @@ builtin/repack.c: static void clear_pack_geometry(struct pack_geometry *geometry
     +		struct string_list_item *item;
     +
     +		data.preferred = 1;
    -+		for_each_string_list_item(item, preferred) {
    ++		for_each_string_list_item(item, preferred)
     +			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
    -+		}
     +		data.preferred = 0;
     +	}
     +
     +	for_each_ref(midx_snapshot_ref_one, &data);
     +
    -+	return close_tempfile_gently(f);
    ++	if (close_tempfile_gently(f)) {
    ++		int save_errno = errno;
    ++		delete_tempfile(&f);
    ++		errno = save_errno;
    ++		die_errno(_("could not close refs snapshot tempfile"));
    ++	}
     +}
     +
      static void midx_included_packs(struct string_list *include,
    @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
      {
      	struct child_process cmd = CHILD_PROCESS_INIT;
     @@ builtin/repack.c: static int write_midx_included_packs(struct string_list *include,
    - 			;
    - 	}
    + 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
    + 			     pack_basename(largest));
      
     +	if (refs_snapshot)
     +		strvec_pushf(&cmd.args, "--refs-snapshot=%s", refs_snapshot);
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +			    "bitmap-ref-tips");
     +
     +		refs_snapshot = xmks_tempfile(path.buf);
    -+		if (midx_snapshot_refs(refs_snapshot) < 0)
    -+			die(_("could not take a snapshot of references"));
    ++		midx_snapshot_refs(refs_snapshot);
     +
     +		strbuf_release(&path);
     +	}
-- 
2.33.0.96.g73915697e6
