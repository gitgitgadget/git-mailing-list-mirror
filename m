Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414B6C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E92D206C0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="XdBSaFY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgF3T1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgF3T1V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 15:27:21 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950EDC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 12:27:21 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g13so16511963qtv.8
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BwU/WMK1916Ec1TgsOb503De0g7WGLFWtvNsMXGApXs=;
        b=XdBSaFY4r9R6SrEFzNpmJnVnK5J+Q+jTZnYWgRLZMBCXfmPYJ6I7Y07auKecmKR0ds
         uh9Lmt0rIWRwW3cwhSCskXQtVITs7EhFuRwBlJi7n95mEpsIwAn7TV8mfjzHcIxTK0W+
         rznx4rTCmcU7HGdmUud1H+nraHiAkRzBntI+UE0PTxfrmIE8uRKLo0VatvD71l4mVY1O
         kTC6Gjjyjh3LrURelGtMFAi46BmIJWmCdVTXqmaxXeFs8M/bmj65u7Kh5CYci60Ex8Tr
         lH/7AnXTsx8/P1w+jJ9CXr4iLXtBIuAGx/EduRUtFeFEd/IvowISFKcJ+KFUUeD92SnS
         kMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwU/WMK1916Ec1TgsOb503De0g7WGLFWtvNsMXGApXs=;
        b=rV4RQHd2yw/bYUIf5iBOSFpC84zqHI14Ovkwx2nySPiypWTqdpSOTQxwYvS4OfLXuq
         q5WR46/bIMIW6RBU9Q1eWBmkICivtq6/tvkm9mmCdwVk/I42XW2mddAVNmDcKZP6tKEI
         +501hOtWCtvK90/NjLiuVz2Gog+ThqEqyxV5vcoOerwpHxv4/Xuto8HnFrk3ac6q21Dl
         Zu7t6qgt3LZYf43ssojriFTqGfuFZUBc/bgOp4LSDRodrHZJ8tDhq3SdkdmngfO18x3A
         ElSObUQR1phjb97+YKlIR2P1QV81T10g7qZR81iReFaJZHvPeaKi8OVGdxnkLtySZv3M
         dCJQ==
X-Gm-Message-State: AOAM533K0H0Awra/6TqRhOHoxmu0xSrZIm9TDZzBuf0QZABBSnaGXsL4
        8oCfyYLg9qom8tpdBxy7WkDlY0mHhq9Y/A==
X-Google-Smtp-Source: ABdhPJxAlqK5cHEd7NQDt2K+GxjSLAoU2f7DoA1sZd6wsgg+Mz3XByaLXGwFSyIJwrrTxF7J5xPjlQ==
X-Received: by 2002:ac8:41c6:: with SMTP id o6mr22225691qtm.292.1593545240642;
        Tue, 30 Jun 2020 12:27:20 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:f0ef:6367:5d8f:d7c])
        by smtp.gmail.com with ESMTPSA id v184sm3688707qki.12.2020.06.30.12.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 12:27:20 -0700 (PDT)
Date:   Tue, 30 Jun 2020 15:27:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
Subject: Re: [PATCH 3/3] commit-graph: respect 'core.useBloomFilters'
Message-ID: <20200630192718.GA31522@syl.lan>
References: <cover.1593536481.git.me@ttaylorr.com>
 <4cfa086e503e19763a9d581fcb6a2ef818776dfc.1593536481.git.me@ttaylorr.com>
 <20200630191834.GC1888406@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630191834.GC1888406@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 03:18:34PM -0400, Jeff King wrote:
> On Tue, Jun 30, 2020 at 01:17:48PM -0400, Taylor Blau wrote:
>
> > Git uses the 'core.commitGraph' configuration value to control whether
> > or not the commit graph is used when parsing commits or performing a
> > traversal.
>
> I think this is a good thing to have, and the patch itself makes sense
> to me (this is actually my first time reviewing it, despite its intended
> use within GitHub :) ).
>
> If I may bikeshed for a moment:
>
> > Introduce 'core.useBloomFilters' to control whether or not Bloom filters
> > are read. Note that this configuration is independent from both:
> >
> >   - 'core.commitGraph', to allow flexibility in using all parts of a
> >     commit-graph _except_ for its Bloom filters.
> >
> >   - The '--changed-paths' option for 'git commit-graph write', to allow
> >     reading and writing Bloom filters to be controlled independently.
>
> Should we avoid exposing the user to the words "Bloom filter"?
>
> The command-line option for writing them was genericized to
> "changed-paths", which I think is good. The use of Bloom filters is an
> implementation detail. What the user cares about is whether we can
> optimize queries of which paths changed in a commit.
>
> When we introduced reachability bitmaps long ago, we made the mistake of
> just calling them "bitmaps". That jargon is well understood by people
> who work with that code, but it's confusing outside of that (even within
> other parts of Git) because bitmaps are just a generic data structure.
> You can have a bitmap of just about anything (and indeed we do use other
> bitmaps these days). Consistently calling them "reachability bitmaps",
> especially in the user facing bits, would have reduced confusion over
> the years.
>
> Similarly, Bloom filters are a generic structure we might use elsewhere.
> I don't really care if we use the word "Bloom" internally to refer to
> this feature, but we'll be stuck with this config option for all time. I
> think it's worth picking something more clear.

All good thoughts. I wondered about this, too, when writing the patch,
but ultimately decided to expose the name since this is the only usage
of Bloom filters within Git to date. Whether that will continue to be
true, I'm not sure, so it probably isn't a great idea to lock ourselves
into that decision within the 'core' namespace.

So, I'm certainly open to changing it, although I'm not sure that I'm as
worried about exposing the implementation detail as I am about squatting
on Bloom filters within Git in general. I don't think that this
configuration will end up getting used by folks other than server
administrators and for debugging purposes, so those populations are
already likely to be aware of changed-path Bloom filters beforehand.

But, hiding the implementation detail seems like sane advice either way.

> It might even be worth considering whether "changed paths" needs more
> context (or would if we add new features in the future). On a "git
> commit-graph write" command-line it is perfectly clear, but would
> core.commitGraphChangedPaths be worth it? It's definitely more specific,
> but it's also way more ugly. ;)

Here's a third option what about 'graph.readChangedPaths'. I think that
Stolee and I discussed a new top-level 'graph' section, since we now
have a few commit-graph-related configuration variables in 'core'.

That's a little shorter, and it adds the verb 'read', which is more
descriptive than 'use' (I touch on this in the third patch, where I say
that this configuration variable _doesn't_ affect the '--changed-path'
option when writing).

Either way, I'd love to hear your thoughts and others', too, to figure
out what we think the most agreeable configuration name is.

> > diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
> > index 6d0c962438..5f585a1725 100644
> > --- a/t/helper/test-read-graph.c
> > +++ b/t/helper/test-read-graph.c
> > @@ -12,11 +12,12 @@ int cmd__read_graph(int argc, const char **argv)
> >  	setup_git_directory();
> >  	odb = the_repository->objects->odb;
> >
> > +	prepare_repo_settings(the_repository);
> > +
> >  	graph = read_commit_graph_one(the_repository, odb);
>
> I wondered why we would need this prepare_repo_settings() now, when it
> should have been needed already to cover core.commitGraph already. I
> strongly suspect the answer is: "test-tool read-graph" never properly
> respected core.commitGraph in the first place.

Yep. Could probably be broken out into a separate patch (or mentioned as
an aside in this one), but you're right: this helper did not respect
any configuration that 'prepare_repo_settings' picks up.

> And now presumably it would. If true, I don't think any tests need
> adjusted because the only places we set it are:
>
>   - on a "git -c" command line, which wouldn't run a test-tool helper
>
>   - when we do set it, it is always to "true", which is the default
>     anyway
>
> >  	if (!graph)
> >  		return 1;
> >
> > -
> >  	printf("header: %08x %d %d %d %d\n",
> >  		ntohl(*(uint32_t*)graph->data),
> >  		*(unsigned char*)(graph->data + 4),
>
> Oh good, I happened to be looking at this code earlier today for an
> unrelated reason and was bothered by this extra newline. :)

I hoped that nobody would mine me sneaking this in ;-).

>
> -Peff
Thanks,
Taylor
