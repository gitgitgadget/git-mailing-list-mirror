Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F923C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E22820709
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 20:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="WaM7ls9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgIBUkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUkt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 16:40:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA739C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 13:40:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 92so254627qtb.6
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pleeFtfDKW3Kr9o8oG3it9xt6VvPxjAVxmcEBhkIhnY=;
        b=WaM7ls9RNXeVcMmfVlYcHaa9XdKnAKSs85aQiRW/qWKG0Q0ykQ5Yf7Bcmp/B97uQ9B
         LgWbSwGz0uiJlBnuqhnLMVaDogdWCv25pVS1nG3lf6JiCAPJtrdkExVWvjl0NPzRu6dV
         JmLa/SY5cgpD1lY6T+6r2EXznAJ2eDUX0FaCHBnYzHmAATomOl/2IrxQCRDc0KC4GrGO
         zQ4G+c0u7PxGRlR52A+6mpQWje24gFQ56Jio2cWvXVNdeoa0N9Dz8jVZ65BFltoLiczP
         WEWIE0xQ7yRApqEUIvMVqE2V/clYzu/WHY2yrPbEJMnrg/GIMtsnvVX30tv+TzBO7tSy
         dWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pleeFtfDKW3Kr9o8oG3it9xt6VvPxjAVxmcEBhkIhnY=;
        b=leaXAyJ4Md2ejsS3nFN8Mbf39hpFHAwb+yZURyO4GWyTSpoXaDq8A+dtronJ6Zh0E2
         e3hHPKKpBWYbqZaPo7tI6IkiCnTVCoSI701KNz2IIBwDpGeDUV3fRMaw4k/2jGAyoaum
         zT9mwz0eN3g4At1bbLTVIB23tjLnoqsnSsVDsk21T1Ry7gQRGfAe13gOlAZw0khKUw0E
         YZhIpd+HqiHgGXb/i6qQs5RkT4pX0Ettyp64rcO9TZKoAql4KrtjeAIkm4DuLoEvu5na
         jEiLOORbJ1Cdo0Z6GPpVxevWoKioqpZ3PNio7819BabkGFAH4l8z8sv4KU8Tw38H9Krl
         yuWA==
X-Gm-Message-State: AOAM531YZG23uEvKP0r+wDNcC+DKH4KgZlOcdWoSa9CkmsxHf61k2kK0
        QLJVVJ0yCybwfW6pz7VLiZypYw==
X-Google-Smtp-Source: ABdhPJx3pT1Al+6e3NOSYSv8Ovg0jv1DriH2PDuO/+83Y65GdTeJhn2zfSHFdTCiUAX4iZE+kwlyvQ==
X-Received: by 2002:aed:3145:: with SMTP id 63mr49333qtg.29.1599079247722;
        Wed, 02 Sep 2020 13:40:47 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:945e:14e0:5690:8262])
        by smtp.gmail.com with ESMTPSA id i65sm574506qkf.126.2020.09.02.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 13:40:47 -0700 (PDT)
Date:   Wed, 2 Sep 2020 16:40:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 12/14] commit-graph: add large-filters bitmap chunk
Message-ID: <20200902204042.GB5281@nand.local>
References: <cover.1596480582.git.me@ttaylorr.com>
 <cover.1597178914.git.me@ttaylorr.com>
 <619e0c619dd12e2bea2b80c7d249ba66fe2a315c.1597178915.git.me@ttaylorr.com>
 <20200901143546.GA5678@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200901143546.GA5678@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 01, 2020 at 04:35:46PM +0200, SZEDER Gábor wrote:
> On Tue, Aug 11, 2020 at 04:52:07PM -0400, Taylor Blau wrote:
> > This is already undesirable, since it means that we are wasting
> > considerable effort to discover that a commit with too many changed
> > paths, only to throw that effort away (and then repeat the process the
> > next time a roll-up is performed).
>
> Is this really the case?
>
> If a commit has a corresponding entry in the Bloom filters chunks,
> then the commit-graph machinery does know the Bloom filter associated
> with that commit.  The size of that filter should not matter, i.e.
> even if it is a zero-length filter, the commit-graph machinery should
> know about it all the same.  And as far as I can tell it does indeed,
> because load_bloom_filter_from_graph() sets a non-NULL 'filter->data'
> pointer even if 'filter->len' is zero, which get_bloom_filter() treats
> as "we know about this", and returns early without (re)computing the
> filter.  Even the test 'Bloom generation does not recompute too-large
> filters' added in this patch is expected to succeed, and my
> superficial and makeshift testing seems to corroborate this; at least
> I couldn't find a combination of commands and options that would
> recompute any existing zero-length Bloom filters.
>
> Am I missing something?

I'm not sure that this would work, or at least that it creates another
pair of cases that we have to disambiguate. Here's what I'm thinking
after reading what you wrote:

  - By this point in the series, we expect every commit in a
    commit-graph layer to have a corresponding entry in the 'BIDX' chunk
    (if one exists, obviously all of this is meaningless without
    specifying '--changed-paths').

  - In a future commit (specifically, "builtin/commit-graph.c: introduce
    '--max-new-filters=<n>'"), this will no longer be the case.

  - So, by that point in the series, we would have two possible reasons
    why a commit did not show up in the BIDX. Either:

      * The commit has too many changed paths, in which case we don't
        want to write it down, or

      * We had already computed too many new filters, and so didn't have
        the budget to compute the filter for some commit(s).

In the first of those two cases, we want to avoid recomputing the
too-large filter. But, in the latter case, we *do* want to compute the
filter from scratch, since we want to "backfill" commits with missing
filters by letting them trickle in over time.

I might be missing something, too, but I think that those two cases are
just as indistinguishable as what's in the commit-graph today (without
the 'BFXL' chunk).

> > To address this, add a new chunk which encodes a bitmap where the ith
> > bit is on iff the ith commit has zero or at least 512 changed paths.
> > Likewise store the maximum number of changed paths we are willing to
> > store in order to prepare for eventually making this value more easily
> > customizable.
>
> I don't understand how storing this value would make it any easier to
> customize.

It doesn't, but it's also not meant to. The idea is that if the value
ever were easy to customize, then we could keep track of which layers
were written with which threshold. This would allow you to invent fancy
rules like dropping filters when the threshold lowers, or recomputing
ones that you wouldn't have otherwise when it goes up.

> > Another approach would be to introduce a new BIDX chunk (say, one
> > identified by 'BID2') which is identical to the existing BIDX chunk,
> > except the most-significant bit of each offset is interpreted as "this
> > filter is too big" iff looking at a BID2 chunk. This avoids having to
> > write a bitmap, but forces older clients to rewrite their commit-graphs
> > (as well as reduces the theoretical largest Bloom filters we couldl
>
> And it reduces the max possible size of the BDAT chunk, and thus the
> max number of commits with Bloom filters as well.

Fair point.

> s/couldl/could/

Oops, thanks.

> > write, and forces us to maintain the code necessary to translate BIDX
> > chunks to BID2 ones). Separately from this patch, I implemented this
> > alternate approach and did not find it to be advantageous.
>
> Let's take a step back to reconsider what should be stored in this
> bitmap for a moment.  Sure, setting a bit for each commit that doesn't
> modify any paths or modifies too many makes it possible to repliably
> identify commits that don't have Bloom filters yet.  But isn't it a
> bit roundabout way?  I think it would be better to directly track
> which commits don't have Bloom filters yet.  IOW what you really want
> is a, say, BNCY "Bloom filter Not Computed Yet" chunk, where we set
> the corresponding bit for each commit which has an entry in the BIDX
> chunk but for which a Bloom filter hasn't been computed yet.
>
>   - It's simpler and easier to explain (IMO).
>
>   - This bitmap chunk can easily be made optional: if all Bloom
>     filters have been computed, then the bitmap will contain all
>     zeros.  So why bother writing it, when we can save a bit of space
>     instead?

I don't think that this is true. Omitting the chunk (because you have
computed--or tried to compute--filters for every commit in the graph)
isn't distinguishable from what exists today, so we are back at square
one there.

>   - It avoids the unpleasentness of setting a bit in the _Large_ Bloom
>     Filters chunks for commits _not_ modifying any paths.

I agree it's unpleasant, but I also don't think it's a show-stopper.

>   - Less incentive to spill implementation details to the format
>     specification (e.g. 512 modified paths).
>
> Now, let's take another step back: is such a bitmap really necessary?
> We could write a single-byte Bloom filter with no bits set for commits
> not modifying any paths, and a single-byte Bloom filter with all bits
> set for commits modifying too many paths.  This is compatible with the
> specs and any existing implementation should do the right thing when
> reading such filters, this would allow us to interpret zero-length
> filters as "not computed yet", and if that bitmap chunk won't be
> optional, then this would save space as long as less than 1/8 of
> commits modify no or too many paths.  Unfortunately, however, all
> existing zero-length Bloom filters have to be recomputed.

I think this is a semantic difference: either you store a bitmap, or a
Bloom filter containing the same data. To me, I don't think there's a
huge difference, since we're talking about 1 bit per commit. If we were
really worried, we could store them as EWAH-compressed bitmaps, but I
don't get a sense that such a concern exists.

I do feel strongly about using a non-probabilistic data structure,
though, since the point of this feature is to be able to make tighter
guarentees about the runtime of 'git commit-graph write'.

>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  .../technical/commit-graph-format.txt         | 12 +++
> >  bloom.h                                       |  2 +-
> >  commit-graph.c                                | 96 ++++++++++++++++---
> >  commit-graph.h                                |  4 +
> >  t/t4216-log-bloom.sh                          | 25 ++++-
> >  5 files changed, 124 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
> > index 440541045d..5f2d9ab4d7 100644
> > --- a/Documentation/technical/commit-graph-format.txt
> > +++ b/Documentation/technical/commit-graph-format.txt
> > @@ -123,6 +123,18 @@ CHUNK DATA:
> >        of length zero.
> >      * The BDAT chunk is present if and only if BIDX is present.
> >
> > +  Large Bloom Filters (ID: {'B', 'F', 'X', 'L'}) [Optional]
> > +    * It starts with a 32-bit unsigned integer specifying the maximum number of
> > +      changed-paths that can be stored in a single Bloom filter.
>
> Should this value be the same in all elements of a commit-graph chain?
> Note that in this case having different values won't affect revision
> walks using modified path Bloom filters.

I don't think it needs to be the same necessarily.

> > +    * It then contains a list of 64-bit words (the length of this list is
> > +      determined by the width of the chunk) which is a bitmap. The 'i'th bit is
> > +      set exactly when the 'i'th commit in the graph has a changed-path Bloom
> > +      filter with zero entries (either because the commit is empty, or because
> > +      it contains more than 512 changed paths).
>
> Please make clear the byte order of these 64 bit words in the specs as
> well.
>
> Furthermore, that 512 path limit is an implementation detail, so it
> would be better if it didn't leak into the specification of this new
> chunk.

Addressed both, thanks.

Thanks,
Taylor
