Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E7EC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 22:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F94610A0
	for <git@archiver.kernel.org>; Thu,  6 May 2021 22:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEFWBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 18:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhEFWBh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 18:01:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD7C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 15:00:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g27-20020a25b11b0000b02904f8641ec14cso1730289ybj.12
        for <git@vger.kernel.org>; Thu, 06 May 2021 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vu/mtbYm2/+SeerPMvP7H+0AestC2nfVY+0zS3PIyvY=;
        b=X4rX6vfNORMaKhknd5fcRyDzKG4past7/JAcJEvjHRS+Ph5moFuanoeosNHXdqVVH+
         Jlamj/4ZUQWThfesbVZzWD0+hywPhjQUsnFoWUM/pOkcolZETrKeBAya2yERnSmHIybH
         rYztWKjV6k9imyM8OGbzDBmgpBrAZ5NpOH96qAWWPIvjn1GYZ4iDYqyQa1EaY9JZ3B0s
         hAM9dPQTYJwvJAh4lblNiDoaBvCSI50m4fCmRf6QCReOeJWNsnZp+O5VM6kXVk6PS+zZ
         eguh9oEhRRTUfj+k77LP6UQbNW3erPMSzJiMS4yVvmcCbFZEhdB7As17rQEi4D8bMkJY
         b7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vu/mtbYm2/+SeerPMvP7H+0AestC2nfVY+0zS3PIyvY=;
        b=TrJgPeAvN9gNQ3UyjZcMvRK6LrEJHlbeCMho+aKcv0Vzmw2eh6yZWpoL0ooDkIXUvo
         nrIEvs9+cjDgIjcIUvsNSPKCoDqLcf05tVnpJm6ThRSOzRy1Dwob7M65vGmR6sPgVnWA
         /XvyyaV3yZFCUZo/Z6hfge7HNkVQKPJ2sv5D3Eg9L5053K7xrXR6nwhqLOiSjrTdhrXI
         SFPMY8bQB5KmLpumlU1YLbm5qFQPa92GQ78va/URzTgyCfmHsk7aJz13ywQTQ+221vxC
         i1reti7onTFp3QBLkWaONj0CDziUq5YAoQbpAPYeS/kp46jhiuBh3GtYqFgtVrF336UK
         vbOA==
X-Gm-Message-State: AOAM532Q/d48NKeqj0rRAu2qscHObagrCBttSHOhm1NyXz0pFgAkEJkA
        Gih9GakvXxqjutcehJYcoOTKbxqh605n4bTywKZg
X-Google-Smtp-Source: ABdhPJyVyQrBiOYgXSc3b08+5hruFxGSqtdMzymXlm6o4M6N0AHc9COUxINDb9tlkqOF3ulTagEBPhsvBSy0r6HQizJ9
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:7085:: with SMTP id
 l127mr9605347ybc.293.1620338438197; Thu, 06 May 2021 15:00:38 -0700 (PDT)
Date:   Thu,  6 May 2021 15:00:35 -0700
In-Reply-To: <YJRPMgBgg65ohRg0@nand.local>
Message-Id: <20210506220035.366165-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YJRPMgBgg65ohRg0@nand.local>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: Re: [PATCH 13/22] pack-bitmap: write multi-pack bitmaps
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Mon, May 03, 2021 at 10:02:30PM -0700, Jonathan Tan wrote:
> > > +static void prepare_midx_packing_data(struct packing_data *pdata,
> > > +				      struct write_midx_context *ctx)
> > > +{
> > > +	uint32_t i;
> > > +
> > > +	memset(pdata, 0, sizeof(struct packing_data));
> > > +	prepare_packing_data(the_repository, pdata);
> > > +
> > > +	for (i = 0; i < ctx->entries_nr; i++) {
> > > +		struct pack_midx_entry *from = &ctx->entries[ctx->pack_order[i]];
> > > +		struct object_entry *to = packlist_alloc(pdata, &from->oid);
> > > +
> > > +		oe_set_in_pack(pdata, to,
> > > +			       ctx->info[ctx->pack_perm[from->pack_int_id]].p);
> > > +	}
> > > +}
> >
> > It is surprising to see this right at the top. Scrolling down, I guess
> > that there is more information needed than just the packing_data struct.
> 
> Hmm, which part is surprising to you? This function is setting up the
> packing_data structure that I mentioned in the commit message, which
> happens in two steps. First, we allocate and call
> prepare_packing_data(). And then we call packlist_alloc() for each
> object in the MIDX, setting up some information about each object
> (like its OID and which physical pack it came from).
> 
> But if any of this is unclear, let me know which part and I'd be happy
> to add a clarifying comment.

Ah, I think I was unclear. I was thinking that the commit message led me
to believe that all information needed for creating a bitmap lies in the
packing_data struct, so I would have expected several helper functions
followed by a function that actually writes the packing_data struct.
Maybe the commit message could be rewritten to avoid that confusion, but
it's probably not a big deal.

> > > +static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr_p,
> > > +						    struct write_midx_context *ctx)
> > > +{
> > > +	struct rev_info revs;
> > > +	struct bitmap_commit_cb cb;
> > > +
> > > +	memset(&cb, 0, sizeof(struct bitmap_commit_cb));
> > > +	cb.ctx = ctx;
> > > +
> > > +	repo_init_revisions(the_repository, &revs, NULL);
> > > +	for_each_ref(add_ref_to_pending, &revs);
> > > +
> > > +	fetch_if_missing = 0;
> > > +	revs.exclude_promisor_objects = 1;
> >
> > I think that the MIDX bitmap requires all objects be present? If yes, we
> > should omit these 2 lines.
> 
> It does require that all objects are present, but if we fetched any
> promisor objects at this stage it would be too late. That's because by
> the time we're in this function, all of the packs that are to be
> included in the MIDX should already exist on disk.
> 
> Skipping promisor objects here is intentional, since it only excludes
> them from the list of reachable commits that we want to select from when
> computing the selection of MIDX'd commits to receive bitmaps.
> 
> But, if one of those promisor objects is reachable from another object
> that is included in the bitmap, then we will complain later on that we
> couldn't find a reachability closure (and fail appropriately).
> 
> That said, I'm not sure any of that is obvious from reading this code,
> so I'll add a comment to that effect around these lines.

So you're saying that if we have missing promisor commits as in the
following graph:

   A
  / \
 B   C
 |   |
 .   .
 .   .
 .   .

where B is missing but promised, and only C is NEEDS_BITMAP, then the
MIDX bitmap write will still work? (So the rev walk is intended to walk
through A and C but not B, and because we are only building bitmaps for
C and potentially its ancestors, we only need the objects in C's
transitive closure.) Even if this is true, "exclude_promisor_objects" is
the wrong option here, because it will exclude all commits that came
from a promisor remote (regardless of whether it is present locally).
(That's how "promisor object" is defined in partial-clone.txt.) What we
need would be an option that permits missing links.

And even if we go with that option that permits missing links, it still
remains that we have very little support for missing promisor commits in
Git right now.

It might be better to just assume that MIDX will only be used for full
clones. If you want, you can add a NEEDSWORK explaining the above case.

> > > +
> > > +	if (prepare_revision_walk(&revs))
> > > +		die(_("revision walk setup failed"));
> > > +
> > > +	traverse_commit_list(&revs, bitmap_show_commit, NULL, &cb);
> > > +	if (indexed_commits_nr_p)
> > > +		*indexed_commits_nr_p = cb.commits_nr;
> > > +
> > > +	return cb.commits;
> > > +}
> >
> > Hmm...I might be missing something obvious, but this function and its
> > callbacks seem to be written like this in order to put the returned
> > commits in a certain order. But later on in write_midx_bitmap(), the
> > return value of this function is passed to
> > bitmap_writer_select_commits(), which resorts the list anyway?
> 
> It isn't intentional, but rather just to build up the list in topo
> order. In fact, the order we build it up in isn't quite the same as how
> the pack bitmap code generates it (it is in true topo order, at least on
> GitHub's servers, as a side effect of using delta islands).
> 
> The fact that we resort according to date_compare makes me wonder why
> changing that seemed to make such a difference for us. The whole
> selection code is a mystery to me.
> 
> But no, the order shouldn't matter since we QSORT it later. Any code
> here that looks like it's putting it in a certain order has much more to
> do with convenience than anything else.

If the order doesn't matter, why don't you just copy one-by-one from
data->ctx->entries into data->commits? (Unless data->ctx->entries has
extra commits?)

> > > +	ret = bitmap_writer_build(&pdata);
> > > +	if (!ret)
> > > +		goto cleanup;
> > > +
> > > +	bitmap_writer_set_checksum(midx_hash);
> > > +	bitmap_writer_finish(index, pdata.nr_objects, bitmap_name, 0);
> >
> > So bitmap_writer_build_type_index() and bitmap_writer_finish() are
> > called with 2 different orders of commits. Is this expected? If yes,
> > maybe this is worth a comment.
> 
> Confusingly so, but yes, these two do expect different orders. You can
> see the same re-sorting going on much more subtly in
> pack-write.c:write_idx_file(), which is called by
> builtin/pack-objects.c:finish_tmp_packfile(), which happens between
> bitmap_writer_build_type_index() and bitmap_writer_finish().
> 
> Definitely worth adding a comment.

Ah, I see. Thanks for your explanation.

> > > @@ -930,9 +1073,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> > >  		for (i = 0; i < ctx.m->num_packs; i++) {
> > >  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> > >
> > > +			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> > > +				error(_("could not load pack %s"),
> > > +				      ctx.m->pack_names[i]);
> > > +				result = 1;
> > > +				goto cleanup;
> > > +			}
> > > +
> > >  			ctx.info[ctx.nr].orig_pack_int_id = i;
> > >  			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
> > > -			ctx.info[ctx.nr].p = NULL;
> > > +			ctx.info[ctx.nr].p = ctx.m->packs[i];
> > >  			ctx.info[ctx.nr].expired = 0;
> > >  			ctx.nr++;
> > >  		}
> >
> > Why is this needed now and not before? From what I see in this function,
> > nothing seems to happen to this .p pack except that they are closed
> > later.
> 
> These are used by prepare_midx_packing_data().

Ah, thanks.

> > > @@ -1096,6 +1264,15 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> > >  		if (ctx.info[i].p) {
> > >  			close_pack(ctx.info[i].p);
> > >  			free(ctx.info[i].p);
> > > +			if (ctx.m) {
> > > +				/*
> > > +				 * Destroy a stale reference to the pack in
> > > +				 * 'ctx.m'.
> > > +				 */
> > > +				uint32_t orig = ctx.info[i].orig_pack_int_id;
> > > +				if (orig < ctx.m->num_packs)
> > > +					ctx.m->packs[orig] = NULL;
> > > +			}
> > >  		}
> > >  		free(ctx.info[i].pack_name);
> > >  	}
> >
> > Is this hunk needed? "ctx" is a local variable and will not outlast this
> > function.
> 
> I can't remember exactly why I added this. I'll play around with it and
> either remove it or add a comment why it's necessary before the next
> reroll.

OK.

> 
> > I'll review the rest tomorrow. It seems like I've gotten over the most
> > difficult patches.
> 
> Thanks, and sorry that this took me a few days to get back to. I
> appreciate your review immensely.

No worries, and thanks for these patches.
