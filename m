Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07C2C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E9D6102A
	for <git@archiver.kernel.org>; Thu,  6 May 2021 20:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbhEFUUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 16:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbhEFUT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 16:19:59 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFACC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 13:19:01 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w9so3743877qvi.13
        for <git@vger.kernel.org>; Thu, 06 May 2021 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZ38IX1VgjM4Lmye0O4wBTegleGIPxtF5UMtV8JmqcY=;
        b=gBMQ1FZfU7wF4LiM1gW+dYn5CVxkjPu/SjEfReBiHDlb1Mxa1H3Z0gdGNDkXlmTu22
         Vh9huiK824I2QvO/ZHqlpU9Hm/KevWgFiDebOhASR0g13JW2OuivpmHl56sdqrFJY6df
         EnZqstGpx+/nYUGjirvJP1OSZtY0d8xGL67TC3vqztniyVXVjmEesdCtPPWIWdAsvc2v
         2iUYjzuJAJ9cnzHLlDUAv/tWiRoWwysEvkLpg/0eRa2j87W8blV1PhdyIVrtVEcG/+1j
         NJG583k+auVxlmlWV9hRvIx3eFr1F+3PLiK2RMOQT1FeoYhJoRtQd1mRt2s0rfnSgYhn
         Gehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZ38IX1VgjM4Lmye0O4wBTegleGIPxtF5UMtV8JmqcY=;
        b=WDd7VZe7RVC0msuIm1vVjaicP6uKjROpOFngjzDFHsfuFEOGHp3JzQjAYxMzbQ+Cfm
         X4lQfweA64KefHnJzsm7B2e65IUEeN+NCt0yV7V7+MDz5TWiPzMMV6OW+GV0jPkAVuL7
         VSdYOfORpFBNnRkNAcli4aeIS8JSWliDWh1t/n11A42t0+ty3h9SzwCxyfUcaOEFnh32
         hPq0uC3R4Xt9owgP67Rp/hmoXjBPYHiZxSCguMXNubRqxMpDMt6r/KpQMwlg8d/waJBC
         ZPOuGri/KvRkYaTrk++x/zFmvHtXGVPVNauvVbN3EStn58vl6MBfPFQDzVuzr6spC1gu
         TGPw==
X-Gm-Message-State: AOAM531bsZJjc2ByPzHuJZUBhE/ZCdGdF2ZvAbNh+YE3VWpYH4JRUn2W
        JLeNBruDGeDN/581pr77Jn1gEA==
X-Google-Smtp-Source: ABdhPJz8BFOtlagx6/HMcZ+9KxZOTXwShTYA/uPVb7EbAYM+8eyRVfu8J+QpNqtBmlmcSVqAeZEVaQ==
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr6369222qva.41.1620332340172;
        Thu, 06 May 2021 13:19:00 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:504e:fef8:576d:db44])
        by smtp.gmail.com with ESMTPSA id a187sm2750842qkd.69.2021.05.06.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 13:18:59 -0700 (PDT)
Date:   Thu, 6 May 2021 16:18:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com
Subject: Re: [PATCH 13/22] pack-bitmap: write multi-pack bitmaps
Message-ID: <YJRPMgBgg65ohRg0@nand.local>
References: <fd320c5ed48c7431b64b898f49101b0f53655a95.1617991824.git.me@ttaylorr.com>
 <20210504050230.2915390-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210504050230.2915390-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 10:02:30PM -0700, Jonathan Tan wrote:
> > +static void prepare_midx_packing_data(struct packing_data *pdata,
> > +				      struct write_midx_context *ctx)
> > +{
> > +	uint32_t i;
> > +
> > +	memset(pdata, 0, sizeof(struct packing_data));
> > +	prepare_packing_data(the_repository, pdata);
> > +
> > +	for (i = 0; i < ctx->entries_nr; i++) {
> > +		struct pack_midx_entry *from = &ctx->entries[ctx->pack_order[i]];
> > +		struct object_entry *to = packlist_alloc(pdata, &from->oid);
> > +
> > +		oe_set_in_pack(pdata, to,
> > +			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
> > +	}
> > +}
>
> It is surprising to see this right at the top. Scrolling down, I guess
> that there is more information needed than just the packing_data struct.

Hmm, which part is surprising to you? This function is setting up the
packing_data structure that I mentioned in the commit message, which
happens in two steps. First, we allocate and call
prepare_packing_data(). And then we call packlist_alloc() for each
object in the MIDX, setting up some information about each object
(like its OID and which physical pack it came from).

But if any of this is unclear, let me know which part and I'd be happy
to add a clarifying comment.

> > +static int add_ref_to_pending(const char *refname,
> > +			      const struct object_id *oid,
> > +			      int flag, void *cb_data)
> > +{
> > +	struct rev_info *revs = (struct rev_info*)cb_data;
> > +	struct object *object;
> > +
> > +	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
> > +		warning("symbolic ref is dangling: %s", refname);
> > +		return 0;
> > +	}
> > +
> > +	object = parse_object_or_die(oid, refname);
> > +	if (object->type != OBJ_COMMIT)
> > +		return 0;
> > +
> > +	add_pending_object(revs, object, "");
> > +	if (bitmap_is_preferred_refname(revs->repo, refname))
> > +		object->flags |= NEEDS_BITMAP;
> > +	return 0;
> > +}
>
> Makes sense. We need to flag certain commits as NEEDS_BITMAP because
> bitmaps are not made for all commits but only certain ones.

Right, and the NEEDS_BITMAP is a bit of a misnomer. It's true meaning is
more like BITMAPPING_THIS_WOULD_BE_A_GOOD_IDEA, since it roughly
translates to "bitmap this commit before any others in its window". More
details are in bitmap_writer_select_commits(), but in all honesty I find
the implementation there somewhat confusing.

> > +static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
> > +						    struct write_midx_context *ctx)
> > +{
> > +	struct rev_info revs;
> > +	struct bitmap_commit_cb cb;
> > +
> > +	memset(&cb, 0, sizeof(struct bitmap_commit_cb));
> > +	cb.ctx = ctx;
> > +
> > +	repo_init_revisions(the_repository, &revs, NULL);
> > +	for_each_ref(add_ref_to_pending, &revs);
> > +
> > +	fetch_if_missing = 0;
> > +	revs.exclude_promisor_objects = 1;
>
> I think that the MIDX bitmap requires all objects be present? If yes, we
> should omit these 2 lines.

It does require that all objects are present, but if we fetched any
promisor objects at this stage it would be too late. That's because by
the time we're in this function, all of the packs that are to be
included in the MIDX should already exist on disk.

Skipping promisor objects here is intentional, since it only excludes
them from the list of reachable commits that we want to select from when
computing the selection of MIDX'd commits to receive bitmaps.

But, if one of those promisor objects is reachable from another object
that is included in the bitmap, then we will complain later on that we
couldn't find a reachability closure (and fail appropriately).

That said, I'm not sure any of that is obvious from reading this code,
so I'll add a comment to that effect around these lines.

> > +
> > +	if (prepare_revision_walk(&revs))
> > +		die(_("revision walk setup failed"));
> > +
> > +	traverse_commit_list(&revs, bitmap_show_commit, NULL, &cb);
> > +	if (indexed_commits_nr_p)
> > +		*indexed_commits_nr_p = cb.commits_nr;
> > +
> > +	return cb.commits;
> > +}
>
> Hmm...I might be missing something obvious, but this function and its
> callbacks seem to be written like this in order to put the returned
> commits in a certain order. But later on in write_midx_bitmap(), the
> return value of this function is passed to
> bitmap_writer_select_commits(), which resorts the list anyway?

It isn't intentional, but rather just to build up the list in topo
order. In fact, the order we build it up in isn't quite the same as how
the pack bitmap code generates it (it is in true topo order, at least on
GitHub's servers, as a side effect of using delta islands).

The fact that we resort according to date_compare makes me wonder why
changing that seemed to make such a difference for us. The whole
selection code is a mystery to me.

But no, the order shouldn't matter since we QSORT it later. Any code
here that looks like it's putting it in a certain order has much more to
do with convenience than anything else.

>
> > +static int write_midx_bitmap(char *midx_name, unsigned char *midx_hash,
> > +			     struct write_midx_context *ctx,
> > +			     unsigned flags)
> > +{
> > +	struct packing_data pdata;
> > +	struct pack_idx_entry **index;
> > +	struct commit **commits = NULL;
> > +	uint32_t i, commits_nr;
> > +	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name, hash_to_hex(midx_hash));
> > +	int ret;
> > +
> > +	prepare_midx_packing_data(&pdata, ctx);
> > +
> > +	commits = find_commits_for_midx_bitmap(&commits_nr, ctx);
> > +
> > +	/*
> > +	 * Build the MIDX-order index based on pdata.objects (which is already
> > +	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
> > +	 * this order).
> > +	 */
> > +	ALLOC_ARRAY(index, pdata.nr_objects);
> > +	for (i = 0; i < pdata.nr_objects; i++)
> > +		index[i] = (struct pack_idx_entry *)&pdata.objects[i];
> > +
> > +	bitmap_writer_show_progress(flags & MIDX_PROGRESS);
> > +	bitmap_writer_build_type_index(&pdata, index, pdata.nr_objects);
> > +
> > +	/*
> > +	 * bitmap_writer_select_commits expects objects in lex order, but
> > +	 * pack_order gives us exactly that. use it directly instead of
> > +	 * re-sorting the array
> > +	 */
> > +	for (i = 0; i < pdata.nr_objects; i++)
> > +		index[ctx->pack_order[i]] = (struct pack_idx_entry *)&pdata.objects[i];
> > +
> > +	bitmap_writer_select_commits(commits, commits_nr, -1);
>
> The comment above says bitmap_writer_select_commits() expects objects in
> lex order, but (1) you're putting "index" in lex order, not "commits",
> and (2) the first thing in bitmap_writer_select_commits() is a QSORT.
> Did you mean another function?

Ack, I definitely meant bitmap_writer_build(). Thanks for catching.

> > +	ret = bitmap_writer_build(&pdata);
> > +	if (!ret)
> > +		goto cleanup;
> > +
> > +	bitmap_writer_set_checksum(midx_hash);
> > +	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, 0);
>
> So bitmap_writer_build_type_index() and bitmap_writer_finish() are
> called with 2 different orders of commits. Is this expected? If yes,
> maybe this is worth a comment.

Confusingly so, but yes, these two do expect different orders. You can
see the same re-sorting going on much more subtly in
pack-write.c:write_idx_file(), which is called by
builtin/pack-objects.c:finish_tmp_packfile(), which happens between
bitmap_writer_build_type_index() and bitmap_writer_finish().

Definitely worth adding a comment.

> > @@ -930,9 +1073,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >  		for (i = 0; i < ctx.m->num_packs; i++) {
> >  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> >
> > +			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> > +				error(_("could not load pack %s"),
> > +				      ctx.m->pack_names[i]);
> > +				result = 1;
> > +				goto cleanup;
> > +			}
> > +
> >  			ctx.info[ctx.nr].orig_pack_int_id = i;
> >  			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
> > -			ctx.info[ctx.nr].p = NULL;
> > +			ctx.info[ctx.nr].p = ctx.m->packs[i];
> >  			ctx.info[ctx.nr].expired = 0;
> >  			ctx.nr++;
> >  		}
>
> Why is this needed now and not before? From what I see in this function,
> nothing seems to happen to this .p pack except that they are closed
> later.

These are used by prepare_midx_packing_data().

> > @@ -1096,6 +1264,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >  		if (ctx.info[i].p) {
> >  			close_pack(ctx.info[i].p);
> >  			free(ctx.info[i].p);
> > +			if (ctx.m) {
> > +				/*
> > +				 * Destroy a stale reference to the pack in
> > +				 * 'ctx.m'.
> > +				 */
> > +				uint32_t orig = ctx.info[i].orig_pack_int_id;
> > +				if (orig < ctx.m->num_packs)
> > +					ctx.m->packs[orig] = NULL;
> > +			}
> >  		}
> >  		free(ctx.info[i].pack_name);
> >  	}
>
> Is this hunk needed? "ctx" is a local variable and will not outlast this
> function.

I can't remember exactly why I added this. I'll play around with it and
either remove it or add a comment why it's necessary before the next
reroll.

> I'll review the rest tomorrow. It seems like I've gotten over the most
> difficult patches.

Thanks, and sorry that this took me a few days to get back to. I
appreciate your review immensely.

Thanks,
Taylor
