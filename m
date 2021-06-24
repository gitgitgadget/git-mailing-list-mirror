Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E227C49EA5
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 00:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBC4611AD
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 00:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhFYACv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 20:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFYACs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 20:02:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11BC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 17:00:27 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bu12so12316520ejb.0
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 17:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=RU1C/irll4LTpsSEJv/GGk4D6o2++eHCadvfIADnonI=;
        b=i7AZt1eJbL4LlPDb3BSE0s4jYUP3q2b+/4QYyH0lQ0VAH5fEuHG7Wa4XUgwieSnSLC
         oFgzkm5p+/L6pxidhpwyLxliDKC9I2ERc9ZSSCLNVpScqkq1sdDG+kxXkCcaSLPfxqFi
         yNB2/6wFTVLsZo+8P1lsWn+Mi/n4bvYA4rmiMorQ2gptTYBxj9ElyPndzCHeENrCO2OC
         tQAnf5VQHMts1+JkHadn4uHGuiDhA/oFgrbRdZr8ATji5p7Rl60LJwkWIPPUHLL+t0yY
         cVL6IXw09Fy9uOEl2HT9W4vFey/nBNGzKnacSyl0iukjAzuI9iz7MIFbTg0EcHtKCwQm
         0DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=RU1C/irll4LTpsSEJv/GGk4D6o2++eHCadvfIADnonI=;
        b=WiuUXURZ4zfM9abzscZpEIU/DOXOzjzb1LEnO1x66ARoBrQZsIlLV1MeM0R4O2rb2P
         EZODAJsfUat3rCTvy00A5ZIiS/fQcQXeNbHD9ibxqwsSQxBGsAOzmcUL+styRlA6WeST
         ONw4Jxx2piHSkpIpjqIt1LTjVnBlA0pBYAKBj3nUhoBs/c/4KLuCmcslkcIuj1HUKZj7
         4WMspCw+ula4rrCK4/dFpc4uhCK1UJ3GAhWH5LBlfoj7BB0C119U1d/ceuBvkeE23YEa
         IPxTdNF1MF/YVerUFveXItxti1xy7nFogGegO2HoOTStxyUGO6cdfWMVPwgSCv5h/GP8
         XTxw==
X-Gm-Message-State: AOAM530GlDPhnxPnUwIXi0lUby4t9ZQNcv3oqLuu2mhYTWuTCeYI/gjA
        Ny8ETR0cHYq8paqiTIxgk3c=
X-Google-Smtp-Source: ABdhPJztmP4NpoR7jwgfnVYlLYdZ5aXXvDXJmMdKAOnjs63mxh1LQdyr/hn+k4dsvLHxZ9CNL6HCAg==
X-Received: by 2002:a17:907:1c06:: with SMTP id nc6mr7794347ejc.345.1624579225912;
        Thu, 24 Jun 2021 17:00:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n4sm1822770eja.121.2021.06.24.17.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:00:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Date:   Fri, 25 Jun 2021 01:45:46 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
Message-ID: <8735t6zucn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Taylor Blau wrote:

> Write multi-pack bitmaps in the format described by
> Documentation/technical/bitmap-format.txt, inferring their presence with
> the absence of '--bitmap'.
>
> To write a multi-pack bitmap, this patch attempts to reuse as much of
> the existing machinery from pack-objects as possible. Specifically, the
> MIDX code prepares a packing_data struct that pretends as if a single
> packfile has been generated containing all of the objects contained
> within the MIDX.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-multi-pack-index.txt |  12 +-
>  builtin/multi-pack-index.c             |   2 +
>  midx.c                                 | 230 ++++++++++++++++++++++++-
>  midx.h                                 |   1 +
>  4 files changed, 236 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index ffd601bc17..ada14deb2c 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress]
> -	[--preferred-pack=<pack>] <subcommand>
> +	[--preferred-pack=<pack>] [--[no-]bitmap] <subcommand>
>  
>  DESCRIPTION
>  -----------
> @@ -40,6 +40,9 @@ write::
>  		multiple packs contain the same object. If not given,
>  		ties are broken in favor of the pack with the lowest
>  		mtime.
> +
> +	--[no-]bitmap::
> +		Control whether or not a multi-pack bitmap is written.
>  --
>  
>  verify::
> @@ -81,6 +84,13 @@ EXAMPLES
>  $ git multi-pack-index write
>  -----------------------------------------------
>  
> +* Write a MIDX file for the packfiles in the current .git folder with a
> +corresponding bitmap.
> ++
> +-------------------------------------------------------------
> +$ git multi-pack-index write --preferred-pack <pack> --bitmap
> +-------------------------------------------------------------
> +

I wondered if this was a <pack> positional argument, but it's just the
argument for --preferred-pack, even though the synopsis uses the "="
style for it. Even if parse-options.c is loose about it, let's use one
or the other in examples consistently.

>  * Write a MIDX file for the packfiles in an alternate object store.
>  +
>  -----------------------------------------------
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 5d3ea445fd..bf6fa982e3 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -68,6 +68,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>  		OPT_STRING(0, "preferred-pack", &opts.preferred_pack,
>  			   N_("preferred-pack"),
>  			   N_("pack for reuse when computing a multi-pack bitmap")),
> +		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
> +			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
>  		OPT_END(),
>  	};
>  
> diff --git a/midx.c b/midx.c
> index 752d36c57f..a58cca707b 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -13,6 +13,10 @@
>  #include "repository.h"
>  #include "chunk-format.h"
>  #include "pack.h"
> +#include "pack-bitmap.h"
> +#include "refs.h"
> +#include "revision.h"
> +#include "list-objects.h"
>  
>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>  #define MIDX_VERSION 1
> @@ -885,6 +889,172 @@ static void write_midx_reverse_index(char *midx_name, unsigned char *midx_hash,
>  static void clear_midx_files_ext(struct repository *r, const char *ext,
>  				 unsigned char *keep_hash);
>  
> +static void prepare_midx_packing_data(struct packing_data *pdata,
> +				      struct write_midx_context *ctx)
> +{
> +	uint32_t i;
> +
> +	memset(pdata, 0, sizeof(struct packing_data));

We initialize this on the stack in write_midx_bitmap(), shouldn't we
just there do:

    struct packing_data pdata = {0}

Instead of:

    struct packing_data pdata;

And then doing this memset() here?

> +	prepare_packing_data(the_repository, pdata);
> +
> +	for (i = 0; i < ctx->entries_nr; i++) {
> +		struct pack_midx_entry *from = &ctx->entries[ctx->pack_order[i]];
> +		struct object_entry *to = packlist_alloc(pdata, &from->oid);
> +
> +		oe_set_in_pack(pdata, to,
> +			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
> +	}
> +}
> +
> +static int add_ref_to_pending(const char *refname,
> +			      const struct object_id *oid,
> +			      int flag, void *cb_data)
> +{
> +	struct rev_info *revs = (struct rev_info*)cb_data;
> +	struct object *object;
> +
> +	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {

Just since I'd mentioned HAS_MULTI_BITS() offhand on another patch of
yours, it's for cases like this, so:

-    if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
+    if (HAS_MULTI_BITS(flag & (REF_ISSYMREF|REF_ISBROKEN)) {

Saves you 3 bytes of code:) Anyway, you don't need to use it, just an
intresting function... :)

> +{
> +	struct rev_info revs;
> +	struct bitmap_commit_cb cb;
> +
> +	memset(&cb, 0, sizeof(struct bitmap_commit_cb));

Another case of s/memset/"= {0}"/g ?

> +	cb.ctx = ctx;
> +
> +	repo_init_revisions(the_repository, &revs, NULL);
> +	for_each_ref(add_ref_to_pending, &revs);
> +
> +	/*
> +	 * Skipping promisor objects here is intentional, since it only excludes
> +	 * them from the list of reachable commits that we want to select from
> +	 * when computing the selection of MIDX'd commits to receive bitmaps.
> +	 *
> +	 * Reachability bitmaps do require that their objects be closed under
> +	 * reachability, but fetching any objects missing from promisors at this
> +	 * point is too late. But, if one of those objects can be reached from
> +	 * an another object that is included in the bitmap, then we will
> +	 * complain later that we don't have reachability closure (and fail
> +	 * appropriately).
> +	 */
> +	fetch_if_missing = 0;
> +	revs.exclude_promisor_objects = 1;
> +
> +	/*
> +	 * Pass selected commits in topo order to match the behavior of
> +	 * pack-bitmaps when configured with delta islands.
> +	 */
> +	revs.topo_order = 1;
> +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> +
> +	if (prepare_revision_walk(&revs))
> +		die(_("revision walk setup failed"));
> +
> +	traverse_commit_list(&revs, bitmap_show_commit, NULL, &cb);
> +	if (indexed_commits_nr_p)
> +		*indexed_commits_nr_p = cb.commits_nr;
> +
> +	return cb.commits;
> +}
> +
> +static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
> +			     struct write_midx_context *ctx,
> +			     unsigned flags)
> +{
> +	struct packing_data pdata;
> +	struct pack_idx_entry **index;
> +	struct commit **commits = NULL;
> +	uint32_t i, commits_nr;
> +	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
> +	int ret;
> +
> +	prepare_midx_packing_data(&pdata, ctx);
> +
> +	commits = find_commits_for_midx_bitmap(&commits_nr, ctx);
> +
> +	/*
> +	 * Build the MIDX-order index based on pdata.objects (which is already
> +	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
> +	 * this order).
> +	 */
> +	ALLOC_ARRAY(index, pdata.nr_objects);
> +	for (i = 0; i < pdata.nr_objects; i++)
> +		index[i] = (struct pack_idx_entry *)&pdata.objects[i];
> +
> +	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
> +	bitmap_writer_build_type_index(&pdata, index, pdata.nr_objects);
> +
> +	/*
> +	 * bitmap_writer_finish expects objects in lex order, but pack_order
> +	 * gives us exactly that. use it directly instead of re-sorting the
> +	 * array.
> +	 *
> +	 * This changes the order of objects in 'index' between
> +	 * bitmap_writer_build_type_index and bitmap_writer_finish.
> +	 *
> +	 * The same re-ordering takes place in the single-pack bitmap code via
> +	 * write_idx_file(), which is called by finish_tmp_packfile(), which
> +	 * happens between bitmap_writer_build_type_index() and
> +	 * bitmap_writer_finish().
> +	 */
> +	for (i = 0; i < pdata.nr_objects; i++)
> +		index[ctx->pack_order[i]] = (struct pack_idx_entry *)&pdata.objects[i];
> +
> +	bitmap_writer_select_commits(commits, commits_nr, -1);
> +	ret = bitmap_writer_build(&pdata);
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	bitmap_writer_set_checksum(midx_hash);
> +	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, 0);
> +
> +cleanup:
> +	free(index);
> +	free(bitmap_name);
> +	return ret;
> +}
> +
>  static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
>  			       struct string_list *packs_to_drop,
>  			       const char *preferred_pack_name,
> @@ -930,9 +1100,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  		for (i = 0; i < ctx.m->num_packs; i++) {
>  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
>  
> +			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> +				error(_("could not load pack %s"),
> +				      ctx.m->pack_names[i]);

Isn't the prepare_midx_pack() tasked with populating that pack_names[i]
that you can't load (the strbuf_addf() it does), but it can also exit
before that, do we get an empty string here then? Maybe I'm misreading
it (I haven't run this, just skimmed the code).

> @@ -1132,6 +1342,9 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  	free(ctx.pack_perm);
>  	free(ctx.pack_order);
>  	free(midx_name);
> +	if (ctx.m)
> +		close_midx(ctx.m);
> +

I see Stolee made close_midx() just return silently if !ctx.m in
1dcd9f2043a (midx: close multi-pack-index on repack, 2018-10-12), but
grepping the uses of it it seems calls to it are similarly guarded by
"if"'s.

Just a nit, weird to have a free-like function not invoked like
free. Perhaps (and maybe better for an unrelated cleanup) to either drop
the conditionals, or make it BUG() if it's called with NULL, but at
least we should pick one :)
