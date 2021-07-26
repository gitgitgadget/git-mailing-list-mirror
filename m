Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A54C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5D60F90
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 18:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhGZRcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhGZRcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 13:32:03 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7081EC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:12:32 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u7so6608151ilj.8
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=09Nmh8V0Fun6xEkDpfq67eyxAOaTaF2HwdM1F4xUFhc=;
        b=uiYLxDzOrgDkBG/2ULrtOhHsFw67SgaXAEN+5TN1J6cwbETE40bNsi8/ny1btpmSX0
         SzW7mRI5nmCCyryYJVNfbfBfzriNw1l9J/n4TsfBGnayd/rnJLuhZikC7HCCJVDMYzv6
         xRNckg22JOHTqgLLIdOSNxfcAHzAqmvAgERWvZTt+VDcdQ43ZaFSpYLF/Xjhl9aNiw8K
         e83Y9+rmX98R0OJIMIvtkuAxH5o2Mierp8/Ag5hM21thaLRFncqR0gX314CCtey4iCYC
         tKf+SjOYWlsPRljW3UTrFeccFw8f2Htvgg1kJNIhl2H0nuGn3K21F5HBKAeSJawZbJS1
         8MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=09Nmh8V0Fun6xEkDpfq67eyxAOaTaF2HwdM1F4xUFhc=;
        b=oz4T0sGtaDhj/RTn0XU+bTzxsDEpzkJVLababjlZWJiwr7gvxGpe39d5NBlwOr9NE+
         givyNSPQvk3S7jbd6YmLp0TsWmTeSdhF6LazuvITYI1wV0J/FPySt5mlZj2nEksroWhJ
         SoGGXWH9msnxyIZjTt5hMTz7tCc8uM/80beuOXqklLiEOvZjcrIH9f5YjB1VJ1V9USnJ
         WIx09Y2/obXMC7Epx5ogBHGSyIf+zY49JMzNyKsOc9qN1hp6CwMKEdiD9FFOWefBV0pr
         4JnEKjJ2K+KmTh7aG8o8w7n1t/yGv99lEl0/UxRUTmv8CDPTi+ayUiqSrhvAvKyoJeyL
         S/qw==
X-Gm-Message-State: AOAM532ODUuFrymUQacOTKz8QBeLFbwCkDfC6HbohGl7yNr85J464kJ1
        MiQZKkFnJRGl+BE9YBOYLpS2/Q==
X-Google-Smtp-Source: ABdhPJyX+lphlQbX/vIjZAJDVlySLdwxGgS3VH93zMacnzX6F/3Lnz6eedkqK+KUe3FbX2OUPWo5yg==
X-Received: by 2002:a92:dc8a:: with SMTP id c10mr13766782iln.48.1627323151768;
        Mon, 26 Jul 2021 11:12:31 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:18ae:76f8:f6b8:4b88])
        by smtp.gmail.com with ESMTPSA id 10sm243478ilt.60.2021.07.26.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:12:31 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:12:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 14/24] pack-bitmap: write multi-pack bitmaps
Message-ID: <YP77DiffrCrxunvg@nand.local>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <a8cec2463d0993b1118abdd31cb6c9e88a32e0c4.1624314293.git.me@ttaylorr.com>
 <YPgObwXjt/tzAJvV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPgObwXjt/tzAJvV@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 08:09:19AM -0400, Jeff King wrote:
> On Mon, Jun 21, 2021 at 06:25:34PM -0400, Taylor Blau wrote:
>
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
> OK, so we'll look at each ref to get the set of commits that we want to
> traverse to put into the bitmap. Which is roughly the same as what the
> pack bitmap does. We only generate bitmaps for all-into-one repacks, so
> it is traversing all of the reachable objects. It is a little different
> in that the pack version is probably hitting reflogs, but IMHO we are
> better off to ignore reflogs for the purposes of bitmaps (I would
> suggest to do so in the pack-bitmap case, too, except that it is
> combined with the "what to pack" traversal there, and by the time we see
> each commit we don't know how we got there).

Right. And we might end up ignoring a lot of these commits, too: the
for-each-ref is just a starting point to enumerate everything, but we
only care about parts of the object graph that are contained in a pack
which is included in the MIDX we are writing (hence the bare "return"
you're commenting around below).

> > +static void bitmap_show_commit(struct commit *commit, void *_data)
> > +{
> > +	struct bitmap_commit_cb *data = _data;
> > +	if (oid_pos(&commit->object.oid, data->ctx->entries,
> > +		    data->ctx->entries_nr,
> > +		    bitmap_oid_access) > -1) {
>
> This "> -1" struck me as a little bit funny. Perhaps ">= 0" would be a
> more obvious way of saying "we found it"?

Sure. (I looked for other uses of oid_pos() to see what is more
common, but there really are vanishingly few uses.) Easier to read might
even be:

    int pos = oid_pos(...);
    if (pos < 0)
      return;
    ALLOC_GROW(...);

which is what I ended up going for.

> > +	/*
> > +	 * Pass selected commits in topo order to match the behavior of
> > +	 * pack-bitmaps when configured with delta islands.
> > +	 */
> > +	revs.topo_order = 1;
> > +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
>
> Hmm. Why do we want to match this side effect of delta islands here?
>
> The only impact this has is on the order of commits we feed for bitmap
> selection (and during the actual generation phase, it may impact
> visitation order).
>
> Now I'm of the opinion that topo order is probably the best thing for
> bitmap generation (since the bitmaps themselves are connected to the
> graph structure). But if it is the best thing, shouldn't we perhaps be
> turning on topo-order for single-pack bitmaps, too?
>
> And if it isn't the best thing, then why would we want it here?

Heh, you were the one that suggested I bring this over to MIDX-based
bitmaps in the first place ;).

This comes from an investigation into why bitmap coverage had worsened
for some repositories using MIDX bitmaps at GitHub. The real reason was
resolved and unrelated to this, but trying to match the behavior of MIDX
bitmaps to our existing pack bitmap setup (which uses delta-islands) was
one strategy we tried while debugging.

I actually suspect that it doesn't really matter what order we feed this
list to bitmap_writer_select_commits() in, because the first thing that
it does is QSORT() the incoming list of commits in date order.

But it does mirror the behavior of our previous bitmap generation
settings, which has been running for years.

So... we could probably drop this hunk? I'd probably rather err on the
safe side and leave this alone since it matches a system that we know to
work well in practice.

> > +	if (prepare_revision_walk(&revs))
> > +		die(_("revision walk setup failed"));
>
> We call init_revisions(), and then go straight to
> prepare_revision_walk() with no call to setup_revisions() between. It
> doesn't seem to be clearly documented, but I think you're supposed to,
> as it finalizes some bits like diff_setup_done().
>
> I suspect it works OK in practice, and I did find a few other spots that
> do not call it (e.g., builtin/am.c:write_commit_patch). But most spots
> do at least an empty setup_revisions(0, NULL, &rev, NULL).

Sure, thanks.

> > +	/*
> > +	 * Build the MIDX-order index based on pdata.objects (which is already
> > +	 * in MIDX order; c.f., 'midx_pack_order_cmp()' for the definition of
> > +	 * this order).
> > +	 */
> > +	ALLOC_ARRAY(index, pdata.nr_objects);
> > +	for (i = 0; i < pdata.nr_objects; i++)
> > +		index[i] = (struct pack_idx_entry *)&pdata.objects[i];
>
> This cast is correct because the pack_idx_entry is at the start of each
> object_entry. But maybe:
>
>   index[i] = &pdata.objects[i].idx;
>
> would be less scary looking?

Definitely, and thanks (for this spot and the other one you mentioned).

> > +	bitmap_writer_select_commits(commits, commits_nr, -1);
>
> Not related to your patch, but I had to refresh my memory on what this
> "-1" was for. It's "max_bitmaps", and is ignored if it's negative. But
> the only callers pass "-1"! So we could get rid of it entirely.
>
> It probably makes sense to leave that cleanup out of this
> already-complicated series. But maybe worth doing later on top.

Yeah, seems like an easy topic for somebody interested in any
#leftoverbits could pick up. Once this lands, I'll be happy to take care
of it myself, too.

> > @@ -930,9 +1100,16 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >  		for (i = 0; i < ctx.m->num_packs; i++) {
> >  			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);
> >
> > +			if (prepare_midx_pack(the_repository, ctx.m, i)) {
> > +				error(_("could not load pack %s"),
> > +				      ctx.m->pack_names[i]);
> > +				result = 1;
> > +				goto cleanup;
> > +			}
>
> It might be worth a comment here. I can easily believe that there is
> some later part of the bitmap generation code that assumes the packs are
> loaded. But somebody reading this is not likely to understand why it's
> here.
>
> Should this be done conditionally only if we're writing a bitmap? (That
> might also make it obvious why we are doing it).

Ah. Actually, I don't think this was necessary before, but we *do* need
it now because we want to compare the pack mtime's for inferring a
preferred pack when one wasn't given. And we also need to open the pack
indexes, too, because we care about the object counts (to make sure that
we don't infer a preferred pack which has no objects).

Luckily, any new packs will be loaded (and likewise have their indexes
open, too), via the the add_pack_to_midx() callback that we pass as an
argument to for_each_file_in_pack_dir().

But we could do something like this instead:

--- 8< ---

diff --git a/midx.c b/midx.c
index 8426e1a0b1..a70a6bca81 100644
--- a/midx.c
+++ b/midx.c
@@ -1111,16 +1111,29 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 		for (i = 0; i < ctx.m->num_packs; i++) {
 			ALLOC_GROW(ctx.info, ctx.nr + 1, ctx.alloc);

-			if (prepare_midx_pack(the_repository, ctx.m, i)) {
-				error(_("could not load pack"));
-				result = 1;
-				goto cleanup;
-			}
-
 			ctx.info[ctx.nr].orig_pack_int_id = i;
 			ctx.info[ctx.nr].pack_name = xstrdup(ctx.m->pack_names[i]);
-			ctx.info[ctx.nr].p = ctx.m->packs[i];
+			ctx.info[ctx.nr].p = NULL;
 			ctx.info[ctx.nr].expired = 0;
+
+			if (flags & MIDX_WRITE_REV_INDEX) {
+				/*
+				 * If generating a reverse index, need to have
+				 * packed_git's loaded to compare their
+				 * mtimes and object count.
+				 */
+				if (prepare_midx_pack(the_repository, ctx.m, i)) {
+					error(_("could not load pack"));
+					result = 1;
+					goto cleanup;
+				}
+
+				if (open_pack_index(ctx.m->packs[i]))
+					die(_("could not open index for %s"),
+					    ctx.m->packs[i]->pack_name);
+				ctx.info[ctx.nr].p = ctx.m->packs[i];
+			}
+
 			ctx.nr++;
 		}
 	}

--- >8 ---

> > @@ -1075,9 +1271,6 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
> >  	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
> >  	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
> >
> > -	if (ctx.m)
> > -		close_midx(ctx.m);
> > -
> >  	if (ctx.nr - dropped_packs == 0) {
> >  		error(_("no pack files to index."));
> >  		result = 1;
>
> I'm not sure what this hunk is doing. We do pick up the close_midx()
> call at the end of the function, amidst the other cleanup.
>
> I expect the answer is something like "we need it open when we generate
> the bitmaps". But it makes me wonder if we could hit any cases where we
> try to overwrite it while it's still open, which would cause problems on
> Windows.

The reason is kind of annoying. If we're building a MIDX bitmap
in-process (e.g., `git multi-pack-index write --bitmap`) then we'll call
prepare_packed_git() to build our pseudo-packing list which we pass to
the bitmap generation machinery.

But prepare_packed_git() calls prepare_packed_git_one() ->
for_each_file_in_pack_dir() with the prepare_pack() callback -> which
the wants to see if the MIDX we have open already knows about a given
pack so we avoid opening it twice.

But even though the MIDX would have gone away by this point (with the
previous close_midx() call that is removed above), we still hold onto
a pointer to it via the object_store's `multi_pack_index` pointer. And
then all the way down in packfile.c:prepare_pack() we try to pass a
now-defunct pointer as the first argument to midx_contains_pack(), and
crash.

And clearing out that `multi_pack_index` pointer is tricky, because the
MIDX would have to compare the odb's `object_dir` with its own (which is
brittle in its own right), but also would have to see if that object
store is pointing at *it*, and not some other MIDX.

So we do have to keep it open there. Which makes me wonder how this
could possibly work on Windows, because holding the MIDX open will make
the commit_lock_file() definitely fail. But it seems OK in the
Windows-based CI runs?

Puzzled.

Thanks,
Taylor
