Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AE2C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C16204FD
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 14:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="s3Pw+V+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHYOlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYOlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 10:41:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFFC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 07:41:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id g26so11119453qka.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j9ZJzNiAEUeCt7Fv8Y5NCQgrgxXiqPOe4ef/S96AqnE=;
        b=s3Pw+V+ZSOtBYy7AgSIN8tMhxlIOngmeQBO5suQyjWHGRnce0ZifCyLCdnMQZ0P/9w
         Y4g0skRtCVkL+bwg9i+adwv84X959S27JZL0rxKgNOBgoWnrsYoc9B5G8FApO+UYlQRu
         tyGn40yhqh62rLZx3hhgI0KJ+dLFVBkHWa6uHLjbjSfVo202tGfsljmCDJ1GDxeLP0bY
         RYzd0g+fUYIN1ryfTuNTEmtkEJWFXmXM+8EK3C4EkVmnOTeX3eo8lJJy6Fly590J7f4R
         SqSl3VaiuG0rMFbFjEDFeNFzzSotEBm2dbK+Q2y0P3Msjo0KSABhDI0FFKC/DkR6HNPN
         WlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9ZJzNiAEUeCt7Fv8Y5NCQgrgxXiqPOe4ef/S96AqnE=;
        b=HuJuvCPqqe5hDjK70qj2zFLUNl8luEtp5cy65xLQuEyL7EOOjEitMS8lvl6rFW1Shz
         CVjvklLxPABI1Y0eaVFZBBKWlfbMkRYeG2IbdDgh2R2KmnrNNljh+uceccpDmTt4FoJc
         7yP7ddIlzqeeH7f+dZEfqwLwmgBAEL/7cR2CUR/maZ7tJxe92QjHtWw4bYaiDxV4YWHB
         MBsIXdx9THjECOQEYHYkAtTuNFnGIvx4e6+UEJMPPOt8TTX26kOZvEmpFFTHEnMkpApO
         CGH1iWV9/b7Aa/PRtN4G1XAx46K7jnbrU/YZBXc9iDZ8/kbLKxKiE52yD68YKWjXo09x
         o7mA==
X-Gm-Message-State: AOAM533thBoLoKYdZFdTBlssnkrhKt81wXAbVu++UAersiYDqu3TPV5l
        sm/l9QPPwBRiyyL4OAJyZFx5YA==
X-Google-Smtp-Source: ABdhPJzeF5TBR3aTNIKOuZWRWTNlrsRI4vd2VXP+KtAZ4Z7mF+tm7Lx0jQAzXlxY5IdN5FMldgswcg==
X-Received: by 2002:a05:620a:143a:: with SMTP id k26mr9388217qkj.262.1598366508400;
        Tue, 25 Aug 2020 07:41:48 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1558:8dc0:5209:36ba])
        by smtp.gmail.com with ESMTPSA id j4sm7652241qkd.129.2020.08.25.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:41:47 -0700 (PDT)
Date:   Tue, 25 Aug 2020 10:41:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
Message-ID: <20200825144146.GA7671@syl.lan>
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <20200825023710.GA98081@syl.lan>
 <e7eb9fb6-f1ea-f932-efaa-7434ad809989@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7eb9fb6-f1ea-f932-efaa-7434ad809989@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 25, 2020 at 09:14:19AM -0400, Derrick Stolee wrote:
> On 8/24/2020 10:37 PM, Taylor Blau wrote:
> > On Mon, Aug 24, 2020 at 10:26:14PM -0400, Jeff King wrote:
> >> On Mon, Aug 24, 2020 at 10:01:04PM -0400, Taylor Blau wrote:
> >>
> >>> In 525e18c04b (midx: clear midx on repack, 2018-07-12), 'git repack'
> >>> learned to remove a multi-pack-index file if it added or removed a pack
> >>> from the object store.
> >>>
> >>> This mechanism is a little over-eager, since it is only necessary to
> >>> drop a MIDX if 'git repack' removes a pack that the MIDX references.
> >>> Adding a pack outside of the MIDX does not require invalidating the
> >>> MIDX, and likewise for removing a pack the MIDX does not know about.
> >>
> >> Does "git repack" ever remove just one pack? Obviously "git repack -ad"
> >> or "git repack -Ad" is going to pack everything and delete the old
> >> packs. So I think we'd want to remove a midx there.
> >>
> >> And "git repack -d" I think of as deleting only loose objects that we
> >> just packed. But I guess it could also remove a pack that has now been
> >> made redundant? That seems like a rare case in practice, but I suppose
> >> is possible.
> >
> > Yeah, the patch message makes this sound more likely than it actually
> > is, which I agree is very rare. I often write 'git repack' instead of
> > 'git pack-objects' to slurp up everything loose into a new pack without
> > having to list loose objects by name.
> >
> > That's the case that I really care about here: purely adding a new pack
> > should not invalidate the existing MIDX.
> >
> >> Not exactly related to your fix, but kind of the flip side of it: would
> >> we ever need to retain a midx that mentions some packs that still exist?
> >>
> >> E.g., imagine we have a midx that points to packs A and B, and
> >> git-repack deletes B. By your logic above, we need to remove the midx
> >> because now it points to objects in B which aren't accessible. But by
> >> deleting it, could we be deleting the only thing that mentions the
> >> objects in A?
> >>
> >> I _think_ the answer is "no", because we never went all-in on midx and
> >> allowed deleting the matching .idx files for contained packs. So we'd
> >> still have that A.idx, and we could just use the pack as normal. But
> >> it's an interesting corner case if we ever do go in that direction.
> >
> > Agreed. Maybe a (admittedly somewhat large) #leftoverbits.
> >
> >> If you'll let me muse a bit more on midx-lifetime issues (which I've
> >> never really thought about before just now):
> >>
> >> I'm also a little curious how bad it is to have a midx whose pack has
> >> gone away. I guess we'd answer queries for "yes, we have this object"
> >> even if we don't, which is bad. Though in practice we'd only delete
> >> those packs if we have their objects elsewhere. And the pack code is
> >> pretty good about retrying other copies of objects that can't be
> >> accessed. Alternatively, I wonder if the midx-loading code ought to
> >> check that all of the constituent packs are available.
> >>
> >> In that line of thinking, do we even need to delete midx files if one of
> >> their packs goes away? The reading side probably ought to be able to
> >> handle that gracefully.
> >
> > I think that this is probably the right direction, although I've only
> > spend time in the MIDX code over the past couple of weeks, so I can't
> > say with authority. It seems like it would be pretty annoying, though.
> > For example, code that cares about listing all objects in a MIDX would
> > have to check first whether the pack they're in still exists before
> > emitting them. On top of that, there are more corner cases when object X
> > exists in more than one pack, but some strict subset of those packs
> > containing X have gone away.
> >
> > I don't think that it couldn't be done, though.
> >
> >> And the more interesting case is when you repack everything with "-ad"
> >> or similar, at which point you shouldn't even need to look up what's in
> >> the midx to see if you deleted its packs. The point of your operation is
> >> to put it all-into-one, so you know the old midx should be discarded.
> >>
> >>> Teach 'git repack' to check for this by loading the MIDX, and checking
> >>> whether the to-be-removed pack is known to the MIDX. This requires a
> >>> slightly odd alternation to a test in t5319, which is explained with a
> >>> comment.
> >>
> >> My above musings aside, this seems like an obvious improvement.
> >>
> >>> diff --git a/builtin/repack.c b/builtin/repack.c
> >>> index 04c5ceaf7e..98fac03946 100644
> >>> --- a/builtin/repack.c
> >>> +++ b/builtin/repack.c
> >>> @@ -133,7 +133,11 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
> >>>  static void remove_redundant_pack(const char *dir_name, const char *base_name)
> >>>  {
> >>>  	struct strbuf buf = STRBUF_INIT;
> >>> -	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
> >>> +	struct multi_pack_index *m = get_multi_pack_index(the_repository);
> >>> +	strbuf_addf(&buf, "%s.pack", base_name);
> >>> +	if (m && midx_contains_pack(m, buf.buf))
> >>> +		clear_midx_file(the_repository);
> >>> +	strbuf_insertf(&buf, 0, "%s/", dir_name);
> >>
> >> Makes sense. midx_contains_pack() is a binary search, so we'll spend
> >> O(n log n) effort deleting the packs (I wondered if this might be
> >> accidentally quadratic over the number of packs).
> >
> > Right. The MIDX stores packs in lexographic order, so checking them is
> > O(log n), which we do at most 'n' times.
> >
> >> And after we clear, "m" will be NULL, so we'll do it at most once. Which
> >> is why you can get rid of the manual "midx_cleared" flag from the
> >> preimage.
> >
> > Yep. I thought briefly about passing 'm' as a parameter, but then you
> > have to worry about a dangling reference to
> > 'the_repository->objects->multi_pack_index' after calling
> > 'clear_midx_file()', so it's easier to look it up each time.
>
> The discussion in this thread matches my understanding of the
> situation.
>
> >> So the patch looks good to me.
>
> The code in builtin/repack.c looks good for sure. I have a quick question
> about this new test:
>
> +test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> +	git multi-pack-index write &&
> +	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
> +	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
> +
> +	# Write a new pack that is unknown to the multi-pack-index.
> +	git hash-object -w </dev/null >blob &&
> +	git pack-objects $objdir/pack/pack <blob &&
> +
> +	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
> +	test_cmp_bin $objdir/pack/multi-pack-index \
> +		$objdir/pack/multi-pack-index.bak
> +'
> +
>
> You create an arbitrary blob, and then add it to a pack-file. Do we
> know that 'git repack' is definitely creating a new pack-file that makes
> our manually-created pack-file redundant?
>
> My suggestion is to have the test check itself:
>
> +test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> +	git multi-pack-index write &&
> +	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
> +	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
> +
> +	# Write a new pack that is unknown to the multi-pack-index.
> +	git hash-object -w </dev/null >blob &&
> +	HASH=$(git pack-objects $objdir/pack/pack <blob) &&
> +
> +	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
> +	test_cmp_bin $objdir/pack/multi-pack-index \
> +		$objdir/pack/multi-pack-index.bak &&
> +	test_path_is_missing $objdir/pack/pack-$HASH.pack
> +'
> +
>
> This test fails for me, on the 'test_path_is_missing'. Likely, the
> blob is seen as already in a pack-file so is just pruned by 'git repack'
> instead. I thought that perhaps we need to add a new pack ourselves that
> overrides the small pack. Here is my attempt:
>
> test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
> 	git multi-pack-index write &&
> 	cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
> 	test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
>
> 	# Write a new pack that is unknown to the multi-pack-index.
> 	BLOB1=$(echo blob1 | git hash-object -w --stdin) &&
> 	BLOB2=$(echo blob2 | git hash-object -w --stdin) &&
> 	cat >blobs <<-EOF &&
> 	$BLOB1
> 	$BLOB2
> 	EOF
> 	HASH1=$(echo $BLOB1 | git pack-objects $objdir/pack/pack) &&
> 	HASH2=$(git pack-objects $objdir/pack/pack <blobs) &&
> 	GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
> 	test_cmp_bin $objdir/pack/multi-pack-index \
> 		$objdir/pack/multi-pack-index.bak &&
> 	test_path_is_file $objdir/pack/pack-$HASH2.pack &&
> 	test_path_is_missing $objdir/pack/pack-$HASH1.pack
> '
>
> However, this _still_ fails on the "test_path_is_missing" line, so I'm not sure
> how to make sure your logic is tested. I saw that 'git repack' was writing
> "nothing new to pack" in the output, so I also tested adding a few commits and
> trying to force it to repack reachable data, but I cannot seem to trigger it
> to create a new pack that overrides only one pack that is not in the MIDX.
>
> Likely, I just don't know how 'git rebase' works well enough to trigger this
> behavior. But the test as-is is not testing what you want it to test.

I think this case might actually be impossible to tickle in a test. I
thought that 'git repack -d' looked for existing packs whose objects are
a subset of some new pack generated. But, it's much simpler than that:
'-d' by itself just looks for packs that were already on disk with the
same SHA-1 as a new pack, and it removes the old one.

Note that 'git repack' uses 'git pack-objects' internally to find
objects and generate a packfile. When calling 'git pack-objects', 'git
repack -d' passes '--all' and '--unpacked', which means that there is no
way we'd generate a new pack with the same SHA-1 as an existing pack
ordinarily.

So, I think this case is impossible, or at least astronomically
unlikely. What is more interesting (and untested) is that adding a _new_
pack doesn't cause us to invalidate the MIDX. Here's a patch that does
that:

  diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
  index 16a1ad040e..620f2058d6 100755
  --- a/t/t5319-multi-pack-index.sh
  +++ b/t/t5319-multi-pack-index.sh
  @@ -391,18 +391,27 @@ test_expect_success 'repack removes multi-pack-index when deleting packs' '
          test_path_is_missing $objdir/pack/multi-pack-index
   '

  -test_expect_success 'repack preserves multi-pack-index when deleting unknown packs' '
  -       git multi-pack-index write &&
  -       cp $objdir/pack/multi-pack-index $objdir/pack/multi-pack-index.bak &&
  -       test_when_finished "rm -f $objdir/pack/multi-pack-index.bak" &&
  -
  -       # Write a new pack that is unknown to the multi-pack-index.
  -       git hash-object -w </dev/null >blob &&
  -       git pack-objects $objdir/pack/pack <blob &&
  -
  -       GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
  -       test_cmp_bin $objdir/pack/multi-pack-index \
  -               $objdir/pack/multi-pack-index.bak
  +test_expect_success 'repack preserves multi-pack-index when creating packs' '
  +       git init preserve &&
  +       test_when_finished "rm -fr preserve" &&
  +       (
  +               cd preserve &&
  +               midx=.git/objects/pack/multi-pack-index &&
  +
  +               test_commit "initial" &&
  +               git repack -ad &&
  +               git multi-pack-index write &&
  +               ls .git/objects/pack | grep "\.pack$" >before &&
  +
  +               cp $midx $midx.bak &&
  +
  +               test_commit "another" &&
  +               GIT_TEST_MULTI_PACK_INDEX=0 git -c core.multiPackIndex repack -d &&
  +               ls .git/objects/pack | grep "\.pack$" >after &&
  +
  +               test_cmp_bin $midx.bak $midx &&
  +               ! test_cmp before after
  +       )
   '

   compare_results_with_midx "after repack"

What do you think about applying this on top and then calling it a day?

> Thanks,
> -Stolee

Thanks,
Taylor
