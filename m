Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CBAC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 05:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B202C611EE
	for <git@archiver.kernel.org>; Tue,  4 May 2021 05:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhEDFD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 01:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhEDFD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 01:03:27 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0673C061574
        for <git@vger.kernel.org>; Mon,  3 May 2021 22:02:32 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id f79-20020a6238520000b029028e7b5e8d7bso2989558pfa.12
        for <git@vger.kernel.org>; Mon, 03 May 2021 22:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PF+wrTirO51tOYLo3EhYTSnjT/deIxwevZ0AmSkIN8k=;
        b=knL7hDc3r+y5fvcbPH59x/SHXuWbV6R80eLCdoXzBjmSTsTDKlLs/xC9kGMMgrvBX5
         sC+WYjypndsp1pSCBRauEHjBtYjFENtyEfoIt2e62H+e5MfDUQzGzLBLOTw7ho9s5r3N
         dRz+balVezP3EfZAMLkjQmN4uf7ALvlHSupOnZwGcjryadKV/z9zHUTj+f/D5j4mbV67
         NR0k1hJGp4tKiiUZTJRZcJvmy8DcbaxSaPe2Fnk6d0T99Ny+jtV8AEjHAfv7FhrVjTK4
         g8bvX9h5/EnCOlI2EVGg7TMg8o0lx0ANzRvEE7wZzgoeKqDGJ3FtXTzwewgwOnzOZZf/
         WcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PF+wrTirO51tOYLo3EhYTSnjT/deIxwevZ0AmSkIN8k=;
        b=oH2LqL6zQy03MiacuscTvWVtlGNQZvYRmto6Akc/LBHFlW7xJLobi+l547Ix3+g9Jd
         /87xg4JBXUVUsI/s/LQlwNwbmMofLGwl4JkJPeuptGhdFgzHifJ9/gx4EtxAhWKE1sbW
         8ydD2gmvaHfd4kwq8wd9A87EeMkCI9BMF7480+bG4h0+FXR93vQVM5cD+dzdUOc+B8ML
         32HTbWae1KXh40Y+aXR0DX4Mjxq/Bi11pTC+deS763xZT8Wzv7F9fO9U5cNiAYZGAayj
         wVDmNFDuJyG8dNQWxKK5xDL0QI4XwPTvsm2MpyBvARuuQeZGLRAvgOtjzZpNWdUdS10V
         xbig==
X-Gm-Message-State: AOAM530zBN59JIbZpu3DNh6H579j7CGvaYUK8Dos3OrT3KKO/NhJJ9jP
        7t2B3lLxNqDIARUJubFNBcCDHctsNzgYygE/7oNM
X-Google-Smtp-Source: ABdhPJxlJKZ0MHUiv5uhylFqsd62u88Dnhoc5fyXKihM0GklaGWGTpX+lGZ8XaGs9CS7VBCCuDSv4ZIGtYHnsO998Hh6
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ed95:b029:ee:aa46:547a with
 SMTP id e21-20020a170902ed95b02900eeaa46547amr19923952plj.27.1620104552311;
 Mon, 03 May 2021 22:02:32 -0700 (PDT)
Date:   Mon,  3 May 2021 22:02:30 -0700
In-Reply-To: <fd320c5ed48c7431b64b898f49101b0f53655a95.1617991824.git.me@ttaylorr.com>
Message-Id: <20210504050230.2915390-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <fd320c5ed48c7431b64b898f49101b0f53655a95.1617991824.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: Re: [PATCH 13/22] pack-bitmap: write multi-pack bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Write multi-pack bitmaps in the format described by
> Documentation/technical/bitmap-format.txt, inferring their presence with
> the absence of '--bitmap'.
> 
> To write a multi-pack bitmap, this patch attempts to reuse as much of
> the existing machinery from pack-objects as possible. Specifically, the
> MIDX code prepares a packing_data struct that pretends as if a single
> packfile has been generated containing all of the objects contained
> within the MIDX.

Sounds good, and makes sense. Conceptually, the MIDX bitmap is the same
as a regular packfile bitmap, just that the order of objects in the
bitmap is defined differently.

> +static void prepare_midx_packing_data(struct packing_data *pdata,
> +				      struct write_midx_context *ctx)
> +{
> +	uint32_t i;
> +
> +	memset(pdata, 0, sizeof(struct packing_data));
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

It is surprising to see this right at the top. Scrolling down, I guess
that there is more information needed than just the packing_data struct.

> +static int add_ref_to_pending(const char *refname,
> +			      const struct object_id *oid,
> +			      int flag, void *cb_data)
> +{
> +	struct rev_info *revs = (struct rev_info*)cb_data;
> +	struct object *object;
> +
> +	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
> +		warning("symbolic ref is dangling: %s", refname);
> +		return 0;
> +	}
> +
> +	object = parse_object_or_die(oid, refname);
> +	if (object->type != OBJ_COMMIT)
> +		return 0;
> +
> +	add_pending_object(revs, object, "");
> +	if (bitmap_is_preferred_refname(revs->repo, refname))
> +		object->flags |= NEEDS_BITMAP;
> +	return 0;
> +}

Makes sense. We need to flag certain commits as NEEDS_BITMAP because
bitmaps are not made for all commits but only certain ones.

> +struct bitmap_commit_cb {
> +	struct commit **commits;
> +	size_t commits_nr, commits_alloc;
> +
> +	struct write_midx_context *ctx;
> +};
> +
> +static const struct object_id *bitmap_oid_access(size_t index,
> +						 const void *_entries)
> +{
> +	const struct pack_midx_entry *entries = _entries;
> +	return &entries[index].oid;
> +}
> +
> +static void bitmap_show_commit(struct commit *commit, void *_data)
> +{
> +	struct bitmap_commit_cb *data = _data;
> +	if (oid_pos(&commit->object.oid, data->ctx->entries,
> +		    data->ctx->entries_nr,
> +		    bitmap_oid_access) > -1) {
> +		ALLOC_GROW(data->commits, data->commits_nr + 1,
> +			   data->commits_alloc);
> +		data->commits[data->commits_nr++] = commit;
> +	}
> +}
> +
> +static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
> +						    struct write_midx_context *ctx)
> +{
> +	struct rev_info revs;
> +	struct bitmap_commit_cb cb;
> +
> +	memset(&cb, 0, sizeof(struct bitmap_commit_cb));
> +	cb.ctx = ctx;
> +
> +	repo_init_revisions(the_repository, &revs, NULL);
> +	for_each_ref(add_ref_to_pending, &revs);
> +
> +	fetch_if_missing = 0;
> +	revs.exclude_promisor_objects = 1;

I think that the MIDX bitmap requires all objects be present? If yes, we
should omit these 2 lines.

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

Hmm...I might be missing something obvious, but this function and its
callbacks seem to be written like this in order to put the returned
commits in a certain order. But later on in write_midx_bitmap(), the
return value of this function is passed to
bitmap_writer_select_commits(), which resorts the list anyway?

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
> +	 * bitmap_writer_select_commits expects objects in lex order, but
> +	 * pack_order gives us exactly that. use it directly instead of
> +	 * re-sorting the array
> +	 */
> +	for (i = 0; i < pdata.nr_objects; i++)
> +		index[ctx->pack_order[i]] = (struct pack_idx_entry *)&pdata.objects[i];
> +
> +	bitmap_writer_select_commits(commits, commits_nr, -1);

The comment above says bitmap_writer_select_commits() expects objects in
lex order, but (1) you're putting "index" in lex order, not "commits",
and (2) the first thing in bitmap_writer_select_commits() is a QSORT.
Did you mean another function?

> +	ret = bitmap_writer_build(&pdata);
> +	if (!ret)
> +		goto cleanup;
> +
> +	bitmap_writer_set_checksum(midx_hash);
> +	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, 0);

So bitmap_writer_build_type_index() and bitmap_writer_finish() are
called with 2 different orders of commits. Is this expected? If yes,
maybe this is worth a comment.

> +
> +cleanup:
> +	free(index);
> +	free(bitmap_name);
> +	return ret;
> +}

[snip]

> @@ -930,9 +1073,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  		for (i = 0; i < ctx.m->num_packs; i++) {
>  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
>  
> +			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> +				error(_("could not load pack %s"),
> +				      ctx.m->pack_names[i]);
> +				result = 1;
> +				goto cleanup;
> +			}
> +
>  			ctx.info[ctx.nr].orig_pack_int_id = i;
>  			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
> -			ctx.info[ctx.nr].p = NULL;
> +			ctx.info[ctx.nr].p = ctx.m->packs[i];
>  			ctx.info[ctx.nr].expired = 0;
>  			ctx.nr++;
>  		}

Why is this needed now and not before? From what I see in this function,
nothing seems to happen to this .p pack except that they are closed
later.

> @@ -1096,6 +1264,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  		if (ctx.info[i].p) {
>  			close_pack(ctx.info[i].p);
>  			free(ctx.info[i].p);
> +			if (ctx.m) {
> +				/*
> +				 * Destroy a stale reference to the pack in
> +				 * 'ctx.m'.
> +				 */
> +				uint32_t orig = ctx.info[i].orig_pack_int_id;
> +				if (orig < ctx.m->num_packs)
> +					ctx.m->packs[orig] = NULL;
> +			}
>  		}
>  		free(ctx.info[i].pack_name);
>  	}

Is this hunk needed? "ctx" is a local variable and will not outlast this
function.

I'll review the rest tomorrow. It seems like I've gotten over the most
difficult patches.
