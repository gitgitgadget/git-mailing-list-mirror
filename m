Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F58C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjHASJF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjHASJB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:09:01 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8AC268C
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:08:52 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d1d398ec0ebso6084083276.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690913332; x=1691518132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPkCT6ZRuV964xmkUNZ1Yl5tR7viBwFnN3bHbTSMsGc=;
        b=AR6TYokSVoSsfkVJJpPBBqDvnMxWKnNyK0cXo9lkVzBll/Jr632qqt3gGKXBZhtOhp
         IWEYhHm17v3idYfZ8GNEGCfeU1QaiS6ruj1BcQ0TR3JHVVs7TA/1cQ93Xi3cjsR3UBWE
         aFg39UAVzGkBzQi4tzUOPMZCEJunypCfJ+od42ULhuWkU0pqrVLLtZOvy0xuJOY3dGPn
         4/KyPpxpDPZGUx1u4SNyLP0xms7HiOesaO5pFo80YzDAMAn0P8W3zjG9XKtUTKSDqvrR
         9t8k1Rl43ihI/3EFOMYdD67XJPaPi4taoId3sc25KCpl1Iu2KbWh9NnTFY13lmqqLbRg
         z1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690913332; x=1691518132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPkCT6ZRuV964xmkUNZ1Yl5tR7viBwFnN3bHbTSMsGc=;
        b=BhP2tB5SmAViFVaYijazxRhTmP0WtFZkKT1BGBv2ebmKTl2c26d9uQ0z2g2lM9GsZR
         1U7swAx0BOhXsx0Y+DvDjRbvx1kMozs5UnlXLlTm93UKfxC04AnQE7yDDa9MlwhSmktX
         XadGQgbANZTqXzuiRdwgqBILAPnqVJcUcEoxq6cSiibWnoKDQWzxokoJX5kOWdRMLU4B
         TnZSLaeJiWBnQyagdnf7x1p9ZO+ewxoDGYqnEaF7vaKWUcpkYQdiNzWM4vucx7JBmADd
         6V1p6DiUq1a2JCsofgu+7J3j0FuE67FiueymPPiatxbVkyHro2rWcKuBPIbaMpc2O68i
         NEOA==
X-Gm-Message-State: ABy/qLZMI8p0IY4oabizb+tMk8pNNzxG277U5fhEfeXahT4JsNKZ3cpf
        7mAvPTgkLkOzlbqBX622esYpjg==
X-Google-Smtp-Source: APBJJlEwJrwqdoC8+tvGOTvHWNhlLJX+5BV8jZydg7e1Rqea3qmSLWJWDJ46vPqe1j2tY2uGpEegkg==
X-Received: by 2002:a25:2385:0:b0:d08:5a25:e6b4 with SMTP id j127-20020a252385000000b00d085a25e6b4mr13770367ybj.28.1690913331811;
        Tue, 01 Aug 2023 11:08:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m205-20020a25d4d6000000b00d1692bf6eebsm3228712ybf.13.2023.08.01.11.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 11:08:51 -0700 (PDT)
Date:   Tue, 1 Aug 2023 14:08:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
Message-ID: <ZMlKMmAs3wKULAOd@nand.local>
References: <ZMKvsObx+uaKA8zF@nand.local>
 <20230727205308.401364-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727205308.401364-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2023 at 01:53:08PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > > The intention in the current patch set was to not load it at all when we
> > > have incompatible Bloom settings because it appeared quite troublesome
> > > to notate which Bloom filter in memory is of which version. If we want
> > > to copy forward existing results, we can change that, but I don't know
> > > whether it's worth doing that (and if we think it's worth doing, this
> > > should probably go in another patch set).
> >
> > Yeah, I think having Bloom filters accessible from a commit-graph
> > regardless of whether or not it matches our Bloom filter version is
> > prerequisite to being able to implement something like this.
> >
> > I feel like this is important enough to do in the same patch set, or the
> > same release to avoid surprising operators when their commit-graph write
> > suddenly recomputes all of its Bloom filters.
>
> Suddenly reading many (or most) of the repo's trees would be a similar
> surprise, right?

That's a good point. I think in general I'd expect Git to avoid
recomputing Bloom filters where that work can be avoided, if the work in
order to detect whether or not we need to recompute a filter is cheap
enough to carry out.

> Also this would happen only if the server operator explicitly sets a
> changed path filter version. If they leave it as-is, commit graphs will
> still be written with the same version as the one on disk.

I think that I could live with that if the default is to leave things
as-is.

I still think that it's worth it to have this functionality to propagate
Bloom filters forward should ship in Git, but we can work on that
outside of this series.

> Regarding consulting commit_graph->bloom_filter_settings->hash_version,
> the issue I ran into was that firstly, I didn't know what to do about
> commit_graph->base_graph (which also has its own bloom_filter_settings)
> and what to do if it had a contradictory hash_version. And even if
> we found a way to unify those, it is not true that every Bloom filter
> in memory is of that version, since we may have generated some that
> correspond to the version we're writing (not the version on disk).
> In particular, the Bloom filters we write come from a commit slab
> (bloom_filters in bloom.c) and in that slab, both Bloom filters from
> disk and Bloom filters that were generated in-process coexist.

Would we ever want to have a commit-graph chain with mixed Bloom filter
versions?

We avoid mixing generation number schemes across multiple layers of a
commit-graph chain. But I don't see any reason that we should or need to
have a similar restriction in place for the Bloom filter version. Both
are readable, as long as the user-provided configuration allows them to
be.

We just have to interpret them differently depending on what layer of
the graph (and therefore, what Bloom filter version they are) they come
from.

Sorry for thinking aloud a little there. I think that this means that we
at minimum have to keep in context the commit-graph layer we found the
Bloom filter in so that we can tie that back to its Bloom filter
version. That might just mean that we have to tag each Bloom filter with
the version it was computed under, or maybe we already have the
commit-graph layer in context, in which case we shouldn't need an
additional field.

My gut is telling me that we probably *do* need such a field, since we
don't often have a reference to the particular layer that we found a
Bloom filter in, just the tip of the commit-graph chain that it came
from.

> I also thought of your other proposal of augmenting struct bloom_filter
> to also include the version. The issue I ran into there is if, for a
> given commit, there already exists a Bloom filter read from disk with
> the wrong version, what should we do? Overwrite it, or store both
> versions in memory? (We can't just immediately output the Bloom filter
> to disk and forget about the new version, only storing its size so that
> we can generate the BIDX, because in the current code, generation and
> writing to disk are separate. We could try to refactor it, but I didn't
> want to make such a large change to reduce the possibility of bugs.)
> Both storing the version number and storing an additional pointer for a
> second version would increase memory consumption too, even when
> supporting two versions isn't needed, but maybe this isn't a big deal.

It's likely that I'm missing something here, but what is stopping us
from discarding the old Bloom filter as soon as we generate the new
one? We shouldn't need to load the old filter again out of the commit
slab, right?

Thanks,
Taylor
