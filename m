Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D27CEB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 21:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjGTV16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 17:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGTV15 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 17:27:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BB319B6
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:27:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56fffdea2d0so11736297b3.1
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 14:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689888475; x=1690493275;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVU3e7499jw4F1LOVCwZLOVT/yVzHNU0D3O7FGBkHN4=;
        b=lYF9dn5VdD18nzrMcYMfsA248lpdjKUEO5UVQgGB/RpWnCPycSBMnWLjst5KvZO47l
         T5uf7G1Gckfgr2KYo2Vb/N2kRtAN8crLsAMtqxSldTqcuM4lOdoUq+C76taRfqo2IO8Y
         E+azyuFVGkKUw/ko0dDFlefSWdypufiSK1gysP1JMgeQJjBwUxw2Qk691qGl47SDuV+q
         +RQg027Q7san+rt+jVtfsizkM3SdVlJkcqi6JfYU3Y7Q1OUyBIpg9Xc0HT0u8anRBQay
         XhgkEptpnSp2DICKbT/9gE8JWzD2WW09XH+IyhEX1LfpqGeVkr5FD53GcwcmxYQ9WCeh
         yufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689888475; x=1690493275;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVU3e7499jw4F1LOVCwZLOVT/yVzHNU0D3O7FGBkHN4=;
        b=Iqa1dVkQOHYmwSGDOkQXn/+Y2QJ4g7bdB5H0SRmAPziTzMZrGTnVGRifGvybFlpGLz
         nzVhZYb0YUUZ3xq7JWN8rSF3oJGpi5ojSVSk6KIaLLeJhbF1mNwPQor+czpz4CohUtGq
         glJQv0Dtq530/73CUH6rg/bmvKSIKLmjxMZejJUopyCb1IQ3Cc3FLoqliszHKBLaJ97e
         TkzyYDhPzw+JyQ+ohqrOVUEeKjHwFYJH14TSE97kiu6l6s8f7rM3i/vQpvZ8dIZB8P8K
         s7qfw03vrR5habYm9H5cuj22k3zyfTFquQAvRp8ACbhkX1Vkl8LkhejZejJgfe9oWleD
         tS6A==
X-Gm-Message-State: ABy/qLa+tt81DMnAIeNxD0p3RV8p8F5W29kHxkMBlX4l1YAtwwi/KKfA
        hVbps+Uw336a3VupSLGqwYIRowiFHdaDwcVF4/PC
X-Google-Smtp-Source: APBJJlEulI9jqzfQ9al4AxccXw2LCm4Q9Uby2II6jDPCMjGVopAvtI34wKahTsrpxU453S55K4SqCEzTrLaNxFvIq89z
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a81:7610:0:b0:583:4f6c:e03b with
 SMTP id r16-20020a817610000000b005834f6ce03bmr2339ywc.2.1689888475640; Thu,
 20 Jul 2023 14:27:55 -0700 (PDT)
Date:   Thu, 20 Jul 2023 14:27:53 -0700
In-Reply-To: <ZLgqbB2JG8+HPoHN@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720212753.2008505-1-jonathantanmy@google.com>
Subject: Re: [PATCH v5 4/4] commit-graph: new filter ver. that fixes murmur3
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Thu, Jul 13, 2023 at 02:42:11PM -0700, Jonathan Tan wrote:
> > The murmur3 implementation in bloom.c has a bug when converting series
> > of 4 bytes into network-order integers when char is signed (which is
> > controllable by a compiler option, and the default signedness of char is
> > platform-specific). When a string contains characters with the high bit
> > set, this bug causes results that, although internally consistent within
> > Git, does not accord with other implementations of murmur3 and even with
> > Git binaries that were compiled with different signedness of char. This
> > bug affects both how Git writes changed path filters to disk and how Git
> > interprets changed path filters on disk.
> 
> I think that you make a worthwhile point that the existing
> implementation is internally consistent, but doesn't actually implement
> a conventional murmur3. I wonder if it's worth being explicit where you
> mention its internal consistency to say that the existing implementation
> would never cause us to produce wrong results, but wouldn't be readable
> by other off-the-shelf implementations of murmur3.
> 
> (To be clear, I think that you already make this point, I'm just
> suggesting that it may be worth spelling it out even more explicitly
> than what is written above).

OK, I've added some more text describing this.

> > Because this bug only manifests with characters that have the high bit
> > set, it may be possible that some (or all) commits in a given repo would
> > have the same changed path filter both before and after this fix is
> > applied. However, in order to determine whether this is the case, the
> > changed paths would first have to be computed, at which point it is not
> > much more expensive to just compute a new changed path filter.
> 
> Hmm. I think in the general case that is true, but I wonder if there's a
> shortcut we could take for trees that are known to not have *any*
> characters with their high-order bits set. That is, if we scan both of
> the first parent's trees and determine that no such paths exist, the
> contents of the Bloom filter would be the same in either version, right?
> 
> I think that that would be faster than recomputing all filters from
> scratch. In either case, we have to load the whole tree. But if we can
> quickly scan (and cache our results by setting some bit--indicating the
> absence of paths with characters having their highest bit set--on the tree
> objects' `flags` field), then we should be able to copy forward the
> existing representation of the filter.
> 
> I think the early checks would be more expensive, since in the worst
> case you have to walk the entire tree, only to realize that you actually
> wanted to compute a first-parent tree diff, meaning you have to
> essentially repeat the whole walk over again. But for repositories that
> have few or no commits whose Bloom filters need computing, I think it
> would be significantly faster, since many of the sub-trees wouldn't need
> to be visited again.

So for repositories that need little-to-no recomputation of Bloom
filters, your idea likely means that each tree needs to be read once,
as compared to recomputing everything in which, I think, each tree needs
to be read roughly twice (once when computing the Bloom filter for the
commit that introduces it, and once for the commit that substitutes a
different tree in place).

I could change the text of the commit message to discuss this (instead
of the blanket statement that it would be too hard), although I think
that an implementation of this can be done after this patchset. What do
you think?

> > There is a change in write_commit_graph(). graph_read_bloom_data()
> > makes it possible for chunk_bloom_data to be non-NULL but
> > bloom_filter_settings to be NULL, which causes a segfault later on. I
> > produced such a segfault while developing this patch, but couldn't find
> > a way to reproduce it neither after this complete patch (or before),
> > but in any case it seemed like a good thing to include that might help
> > future patch authors.
> 
> Hmm. Interesting, I'd love to know more about what you were doing that
> produced the segfault. I think it would be worth it to prove to
> ourselves that this segfault can't occur in the wild. Or if it can, it
> would be worth it to understand the bug and prevent it from happening.

If I remember correctly, I changed the version in
DEFAULT_BLOOM_FILTER_SETTINGS to 2 and ran it to see what broke. This
was a while back so I don't remember it exactly, though.

> > @@ -130,8 +187,10 @@ void fill_bloom_key(const char *data,
> >  	int i;
> >  	const uint32_t seed0 = 0x293ae76f;
> >  	const uint32_t seed1 = 0x7e646e2c;
> > -	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
> > -	const uint32_t hash1 = murmur3_seeded(seed1, data, len);
> > +	const uint32_t hash0 = (settings->hash_version == 2
> > +		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed0, data, len);
> > +	const uint32_t hash1 = (settings->hash_version == 2
> > +		? murmur3_seeded_v2 : murmur3_seeded_v1)(seed1, data, len);
> 
> I do admire the ternary operator over the function being called, as I
> think that Stolee pointed out earlier in this series. But I worry that
> these two checks could fall out of sync with each other, causing us to
> pick incosistent values for hash0, and hash1, respectively.
> 
> FWIW, I would probably write this as:
> 
>     const uint32_t hash0, hash1;
>     if (settings->hash_version == 2) {
>         hash0 = murmur3_seeded_v2(seed0, data, len);
>         hash1 = murmur3_seeded_v2(seed1, data, len);
>     } else {
>         hash0 = murmur3_seeded_v1(seed0, data, len);
>         hash1 = murmur3_seeded_v1(seed1, data, len);
>     }
> 
> I suppose that there isn't anything keeping the calls within each arm of
> the if-statement above in sync with each other (i.e., I could call
> murmur3_seeded_v1() immediately before dispatching a call to
> murmur3_seeded_v2()). So in that sense I think that this is no more or
> less safe than what's already written.
> 
> But IMHO I think this one reads more cleanly, so I might prefer it over
> what you have in this patch. But I don't feel so strongly about it
> either way.

I'm OK either way, so I'll go with your approach (except the "const",
since my compiler doesn't like that).

> > @@ -302,16 +302,25 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
> >  	return 0;
> >  }
> >
> > +struct graph_read_bloom_data_data {
> > +	struct commit_graph *g;
> > +	int *commit_graph_changed_paths_version;
> > +};
> > +
> 
> Nit: maybe `graph_read_bloom_data_context`, to avoid repeating "data"? I
> don't have strong feelings here, FWIW.

I'll use "context".

> The rest of the implementation and tests look good to me.
> 
> Thanks,
> Taylor

Thanks for the review.
