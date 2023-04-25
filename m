Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFE6C77B7C
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 21:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbjDYVZf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbjDYVZd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 17:25:33 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837B516F2F
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:25:31 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b99f374179bso1891772276.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 14:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682457930; x=1685049930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JATrskv9yx6TyRGXdcgCIOB/qe3YMKQZ05JdI3DlMmE=;
        b=Gr0JCJSNcKbNW5Lh8qlhER6s6j5XqKAZT6UhFEHwbCTvVYODmv+g/WoGzQKYonC1Jv
         Rqw78lOXUJAKlxncJI57vzrlA7kQGDi8SOuU7knXqknWPzNR1NuoB/jpZUax5R804j59
         RKO/xmEwxs5sN4XiTAtmz/Jsw1Sd7izjGvzAHohmUwwk0nsg3IitnBRz02+8qHz1ouGl
         ANU1/JXU/zgKE4HDF9YKDipq3VvQ8PZdMiDOj1WbhZb1GtFyHWyg/ofdcCoOlddihC73
         HYjDFSFUFey/WPqez6YEFJzYoYuen3+pBODM0JsJTGJBFHPgatLDEqPChOTt1ArXbKb8
         dgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682457930; x=1685049930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JATrskv9yx6TyRGXdcgCIOB/qe3YMKQZ05JdI3DlMmE=;
        b=lBb4fpkDmf53TruiNggAG50tgI/QYKtIg6gEwEkJu5JH3uDwBY188kbwS8GAAI8Wtz
         LtPSJ4GrNinqhH01rUjvHyHWPu4u2+y6xBQa8vHEma/F4nGUluhvStypWozvweAB1Pwn
         3ByPeb96H/BghY15Yc6CgbqL52R25z0Ydocbe86RBml7hZBrPPZgqajksC9LCo3zidum
         xNq5jyy5IcEcjtbvYiYZTD7mB0W+kGARoiZIo/pUssVasNx1ES9iEIz58Mh5veQPgCyB
         5/LWrayXx8/OqanKLN5UEWHDxvKIEU7FtrGF5SpiQcPK4sSiCxyBgyM6jqw2UTG4EMmY
         M7qQ==
X-Gm-Message-State: AAQBX9cAxhoETe3E2eTY4KM/N+MWEGpwOgauHQMb0KZQHkbrzOJu/qpx
        cPq34RTwxu3H0J4PNmyGH/lO3Q==
X-Google-Smtp-Source: AKy350ZljfnQpVQiZok1BAQ47i0ll6+vSccKtIxnA4H7akE92IPfqXjl3Jg1lZCYVZq2hQ6nOxQ5OQ==
X-Received: by 2002:a25:4001:0:b0:b7c:5877:d15b with SMTP id n1-20020a254001000000b00b7c5877d15bmr14930374yba.8.1682457930573;
        Tue, 25 Apr 2023 14:25:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h1-20020a5b0a81000000b00b8f54571fc0sm3662570ybq.5.2023.04.25.14.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:25:30 -0700 (PDT)
Date:   Tue, 25 Apr 2023 17:25:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
Message-ID: <ZEhFScCoAgGGM/th@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <4ba5eec2-dfbb-b918-147a-d6e03c2748b2@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ba5eec2-dfbb-b918-147a-d6e03c2748b2@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2023 at 03:42:51PM -0400, Derrick Stolee wrote:
> On 4/20/2023 1:27 PM, Taylor Blau wrote:
> > This patch introduces a new multi-valued configuration option,
> > `pack.extraCruftTips` as an alternative means to mark certain objects in
> > the cruft pack as rescued, even if they would otherwise be pruned.
>
> > However, there is no option to be able to keep around certain objects
> > that have otherwise aged out of the grace period. The only way to retain
> > those objects is:
> >
> >   - to point a reference at them, which may be undesirable or
> >     infeasible,
> >   - to extend the grace period, which may keep around other objects that
> >     the caller *does* want to discard,
> >   - or, to force the caller to construct the pack of objects they want
> >     to keep themselves, and then mark the pack as kept by adding a
> >     ".keep" file.
> >
> > This patch introduces a new configuration, `pack.extraCruftTips` which
> > allows the caller to specify a program (or set of programs) whose output
> > is treated as a set of objects to treat as "kept", even if they are
> > unreachable and have aged out of the retention period.
>
> One way to think about this is that we want to store a second set of
> references to objects we do not want to prune, but those references
> are not useful for _any other Git operation_, so polluting the ref
> space would be too expensive. And reflogs are insufficient because
> deleted references also delete their reflogs.

Well put. I think that reflogs only stick around as long as their
references do is the key point and is under-emphasized in my original patch.

At the risk of repeating what you already said: yes, we (a) want to keep
around a second set of objects, but (b) don't want to point references
at them, since they are useless to all other operations as well as
expensive to track, and (c) don't want to use reflogs since their
lifetime is tied to the reference they're tracking.

> > The implementation is straightforward: after determining the set of
> > objects to pack into the cruft pack (either by calling
> > `enumerate_cruft_objects()` or `enumerate_and_traverse_cruft_objects()`)
> > we figure out if there are any program(s) we need to consult in order to
> > determine if there are any objects which we need to "rescue". We then
> > add those as tips to another reachability traversal, marking every
> > object along the way as cruft (and thus retaining it in the cruft pack).
>
> I initially wondered why we would need a second walk, and I _think_
> one reason is that we don't want to update the mtimes for these
> objects as if they were reachable. The next point about the reachable
> pack is also critical.

Their mtimes might be updated during that second walk, but the key point
is that we want to rescue any objects that the extra tips might reach
(but aren't listed themselves in the output of one of the hooks).

The idea there is similar to the rescuing pass we do for pruning GC's,
where we'll save any objects which would have been pruned, but are
reachable from another object which won't yet be pruned.

> > Instead, keep these unreachable objects in the cruft pack instead, to
> > ensure that we can continue to have a pack containing just reachable
> > objects, which is always safe to write a bitmap over.
>
> Makes sense. Also: don't update their mtime so they could be removed
> immediately if the external pointers change.

I don't think I'm quite following why we would want to leave their
mtimes alone here. I think we'd want their mtimes to be accurate as of
the last time we updated the *.mtimes file so that if they (a) no longer
appear in the output of one of the extra-cruft hooks, and (b) they have
been written recently, that they would not be pruned immediately.

> > +pack.extraCruftTips::
> > +	When generating a cruft pack, use the shell to execute the
> > +	specified command(s), and interpret their output as additional
> > +	tips of objects to keep in the cruft pack, regardless of their
> > +	age.
> > ++
> > +Output must contain exactly one hex object ID per line, and nothing
> > +else. Objects which cannot be found in the repository are ignored.
> > +
>
> This only indicates it is multi-valued by the word "command(s)". It
> also doesn't specify that we execute them all or stop when one
> completes with success. (see code)

> > +	return ret;
> > +}
> > +
> > +static int enumerate_extra_cruft_tips(void)
> > +{
> > +	struct rev_info revs;
> > +	const struct string_list *programs;
> > +	int ret = 0;
> > +	size_t i;
> > +
> > +	if (git_config_get_string_multi("pack.extracrufttips", &programs))
> > +		return ret;
> > +
> > +	repo_init_revisions(the_repository, &revs, NULL);
> > +
> > +	revs.tag_objects = 1;
> > +	revs.tree_objects = 1;
> > +	revs.blob_objects = 1;
> > +
> > +	revs.include_check = cruft_include_check;
> > +	revs.include_check_obj = cruft_include_check_obj;
> > +
> > +	revs.ignore_missing_links = 1;
> > +
> > +	if (progress)
> > +		progress_state = start_progress(_("Enumerating extra cruft tips"), 0);
>
> Should we be including two progress counts? or would it be sufficient
> to say "traversing extra cruft objects" and include both of these steps
> in that one progress mode?

I may be missing something, but there are already two progress meters
here: one (above) for enumerating the list of extra cruft tips, which
increments each time we read a new line that refers to an extant object,
and another (below) for the number of objects that we visit along the
second walk.

> > +	nr_seen = 0;
> > +	for (i = 0; i < programs->nr; i++) {
> > +		ret = enumerate_extra_cruft_tips_1(&revs,
> > +						   programs->items[i].string);
> > +		if (!ret)
> > +			break;
> > +	}
> > +	stop_progress(&progress_state);
> > +
> > +	if (ret)
> > +		die(_("unable to enumerate additional cruft tips"));
>
> If we are going to die() here, we might as well do it in the loop
> instead of the break. But wait... this seems backwards.
>
> I suppose what this is saying is: try each possible hook until we
> get a success (in which case we stop trying). If we have a failure
> in all attempts, then we die().
>
> I was expecting this to be a cumulative operation: we execute each
> hook in order and include all of their output. This implementation
> doesn't seem to match that (or I'm reading something wrong).

Yeah, this is definitely a bug, and the if-statement should read "if
(ret)" not "if (!ret)". We should ideally consult all of the hooks here,
but if any one of them fails, we should stop and refuse to generate a
cruft pack.

> > +	if (prepare_revision_walk(&revs))
> > +		die(_("revision walk setup failed"));
> > +	if (progress)
> > +		progress_state = start_progress(_("Traversing extra cruft objects"), 0);
> > +	nr_seen = 0;
> > +	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
>
> Hm. I'm trying to look at these helpers and figure out what they
> are doing to prevent these objects from being pruned. This could
> use a comment or something, as I'm unable to grok it at present.

Very fair, the show_cruft_object() callback calls
add_cruft_object_entry(), which adds the visited object to the cruft
pack regardless of its mtime with respect to pruning.

A comment here might look like:

    /* retain all objects reachable from extra tips via show_cruft_object() */

or something.

> Could we store this commit to make sure it is removed from the
> repository later?

Possibly, though I think we already have good coverage of this in other
tests. So I'd be equally happy to assert on the exact contents of the
cruft pack (which wouldn't include the above commit), but I'm happy to
assert on it more directly if you feel strongly.

> > +		git checkout --orphan old &&
> > +		git rm -fr . &&
> > +		test_commit --no-tag cruft.old &&
> > +		cruft_old="$(git rev-parse HEAD)" &&
> > +
> > +		git checkout --orphan new &&
> > +		git rm -fr . &&
> > +		test_commit --no-tag cruft.new &&
> > +		cruft_new="$(git rev-parse HEAD)" &&
> > +
> > +		git checkout main &&
> > +		git branch -D old new &&
>
> Do you need to delete the 'discard' branch here?

Great catch. I didn't notice it here because even though it was
reachable (and not mentioned as an extra tip), so didn't appear in the
cruft pack.

> > +		# Write the script to list extra tips, which are limited
> > +		# to cruft.old, in this case.
> > +		write_script extra-tips <<-EOF &&
> > +		echo $cruft_old
> > +		EOF
> > +		git config pack.extraCruftTips ./extra-tips &&
> > +
> > +		git repack --cruft --cruft-expiration=now -d &&
>
> So, at this point, it seems we are not including the 'discard'
> objects in the cruft pack because they are still reachable. Or,
> am I reading that incorrectly?

My mistake, see above.

> > +		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
> > +		git show-index <${mtimes%.mtimes}.idx >cruft &&
> > +		cut -d" " -f2 cruft | sort >cruft.actual &&
> > +		test_cmp cruft.expect cruft.actual
>
> One thing that would be good, as a safety check, is to remove
> the pack.extraCruftTips config and re-run the repack and be
> sure that we are pruning the objects previously saved by the
> hook.

Good call. I think this amounts to:

--- 8< ---
diff --git a/t/t5329-pack-objects-cruft.sh b/t/t5329-pack-objects-cruft.sh
index 1260e11d41..44852e6925 100755
--- a/t/t5329-pack-objects-cruft.sh
+++ b/t/t5329-pack-objects-cruft.sh
@@ -773,7 +773,7 @@ test_expect_success 'additional cruft tips may be specified via pack.extraCruftT
 		cruft_new="$(git rev-parse HEAD)" &&

 		git checkout main &&
-		git branch -D old new &&
+		git branch -D discard old new &&
 		git reflog expire --all --expire=all &&

 		# mark cruft.old with an mtime that is many minutes
@@ -802,6 +802,19 @@ test_expect_success 'additional cruft tips may be specified via pack.extraCruftT
 		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
 		git show-index <${mtimes%.mtimes}.idx >cruft &&
 		cut -d" " -f2 cruft | sort >cruft.actual &&
+		test_cmp cruft.expect cruft.actual &&
+
+		# Ensure that the "old" objects are removed after
+		# dropping the pack.extraCruftTips hook.
+		git config --unset pack.extraCruftTips &&
+		git repack --cruft --cruft-expiration=now -d &&
+
+		mtimes="$(ls .git/objects/pack/pack-*.mtimes)" &&
+		git show-index <${mtimes%.mtimes}.idx >cruft &&
+		cut -d" " -f2 cruft | sort >cruft.actual &&
+
+		git rev-list --objects --no-object-names $cruft_new >cruft.raw &&
+		sort cruft.raw >cruft.expect &&
 		test_cmp cruft.expect cruft.actual
 	)
 '
--- >8 ---

> It would be helpful to include a test for the multi-value case where
> multiple scripts are executed and maybe include an "exit 1" in some
> of them?

Definitely, that is a great suggestion (especially because it would have
caught the "if (!ret)" bug that you pointed out above).

Thanks for a thorough review. I'll wait for other feedback before
re-rolling, or do so in a couple of days if I haven't heard anything.

Thanks,
Taylor
