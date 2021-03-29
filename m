Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E29C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7ABC61989
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 21:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhC2VPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 17:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhC2VPR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 17:15:17 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CCAC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:15:14 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y5so13887061qkl.9
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VlzusJLFuXCgH79/thkRZjI4fHB6mdlyZxwAwc64m/c=;
        b=U22j2qc3rFfgBlJhq/d1I1oIarOz89kHsMwReqJwL59VS1Q8ougA+IxoE6e89qVHlZ
         a36bAycBgFwHfCyy19B7TmbXxd4zsk6VJU2mtU6LG2YKopoq49BFqeOV09EbEeFpXvn1
         53TgHX9zdBQoJs/GWBBNhMDjMb0Y+eyto77x/XNvVQiEN9vk79wNdzZdy7X5zsOko5Gz
         p34ojFxFiAx7Bj5o/nwvdlrkHPXrS/UUguRd/LLkNTCsIYmLQuNvvvRewO5kv0DekwCL
         +sITf1NK98e17vH/QCQRLCEGS2ptB5fIyJio137cZRq6/7xzP8oFkQTQ8ghMli8RCEYR
         m0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VlzusJLFuXCgH79/thkRZjI4fHB6mdlyZxwAwc64m/c=;
        b=KoSnthvpOI4JMeK5D/3fWde3rfoHVqmrn+rUqoHPqci6Bi77uEsqvHc0z3PIZYpxLR
         LfnbpLfKHCpeeMu+G/gmSTuYoMaQblfrGWicEX0LrJ2ja+NnjOgzU5qHPd1Xr5mNgLtg
         I57jpzaxndb8kT05VmiHJbyUIOol5ReSTMR3om8g6BihPINTTkTVOf04z/bWY+JbJtpr
         gQ16JW/SjCOSPSfnrICwq3b4XTpVC22M4ppaEPrnEQ3DQ0wmWppKQ5cI2esqF2rx1D6I
         VjNojzMA5gS/e91wlgWGeh4JmosvUp9z8YofrTh1hG7U/cWHz4EtLR1HMvSTexrvIbj2
         VJyg==
X-Gm-Message-State: AOAM530/OH6emkHEWqkshC/n3FK/6LXV09pkLHh/9/nml7dp8IxAULgg
        NVl1QOsHx1VA2CwSlNKvT1tfSg==
X-Google-Smtp-Source: ABdhPJwYDdMNHxh3bSs8kj60YWHWtX6H0L2s8pD6U05kbhl4xk2+FrwyuHJivqTLLWDMjXjykdwMSQ==
X-Received: by 2002:a37:a643:: with SMTP id p64mr25998414qke.276.1617052514022;
        Mon, 29 Mar 2021 14:15:14 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7b00:4f79:8763:6261])
        by smtp.gmail.com with ESMTPSA id v66sm14564967qkd.113.2021.03.29.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 14:15:13 -0700 (PDT)
Date:   Mon, 29 Mar 2021 17:15:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v3 08/16] midx: allow marking a pack as preferred
Message-ID: <YGJDYIxicaPDMdeZ@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <cover.1615482270.git.me@ttaylorr.com>
 <30194a6786bec51e0f41de0e6c855dc2297806c6.1615482270.git.me@ttaylorr.com>
 <YGHBe1ZB/iCRpqgD@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGHBe1ZB/iCRpqgD@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 08:00:59AM -0400, Jeff King wrote:
> I think in the long run we may want to add a midx chunk that gives the
> order of the packs (and likewise allow the caller of "midx write" to
> specify the exact order), since that may allow correlating locality
> between history and object order within the .rev/.bitmap files.
>
> But I think this is a nice stopping point for this series, since we're
> not having to introduce any new on-disk formats to do it, and it seems
> to give pretty good results in practice. I guess we'll have to support
> --preferred-pack forever, but that's OK. Even if we do eventually
> support arbitrary orderings, it's just a simple subset of that
> functionality.

To add a little bit of extra detail, I think what you're getting at here
is that it would be nice to let the order of the packs be dictated by
mtime, not the order they appear in the MIDX (which is lexicographic by
their hash, and thus effectively random).

The reason there being the same as you pointed out in

    https://lore.kernel.org/git/YDRdmh8oS5%2Fxq4rB@coredump.intra.peff.net/

which is that it effectively would lay objects out from newest to
oldest.

But, there's a problem, which is that the MIDX doesn't store the packs'
mtimes. That's fine for writing, since we can just look that information
up ourselves. But the reading side can get broken. That's because the
reader also has to know the pack order to go from MIDX- to bit-position.

So if a third party goes and touches some of the packs after the .rev
file was written, then the reader is going to think the packs ought to
appear in a different order than they actually do. So relying on having
to look up the mtimes again later on isn't good enough.

There are two solutions to the problem:

  - You could write the mtimes in the MIDX itself. This would give you a
    single point of reference, and resolve the TOCTOU race I just
    described.

  - Or, you could forget about mtimes entirely and let the MIDX dictate
    the pack ordering itself. That resolves the race in a
    similar-but-different way.

Of the two, I prefer the latter, but I think it introduces functionality
that we don't necessarily need yet. That's because the objects within
the packs are still ordered as such, and so the compression we get in
the packs is just as good as it is for single-pack bitmaps. It's only at
the objects between pack boundaries that any runs of 1s or 0s might be
interrupted, but there are far fewer pack boundaries than objects, so it
doesn't seem to matter in practice.

Anyway, I think that you know all of that already (mostly because we
thought aloud together when I originally brought this up), but I figure
that this detail may be interesting for other readers, too.

> > @@ -74,7 +85,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
> >  		usage_with_options(builtin_multi_pack_index_write_usage,
> >  				   options);
> >
> > -	return write_midx_file(opts.object_dir, opts.flags);
> > +	return write_midx_file(opts.object_dir, opts.preferred_pack,
> > +			       opts.flags);
> >  }
>
> This has the same leak of "options" that I mentioned in the earlier
> patch.

Yup, thanks for pointing it out.

> > diff --git a/midx.c b/midx.c
> > index 971faa8cfc..46f55ff6cf 100644
> > --- a/midx.c
> > +++ b/midx.c
> > @@ -431,6 +431,24 @@ static int pack_info_compare(const void *_a, const void *_b)
> >  	return strcmp(a->pack_name, b->pack_name);
> >  }
> >
> > +static int lookup_idx_or_pack_name(struct pack_info *info,
> > +				   uint32_t nr,
> > +				   const char *pack_name)
> > +{
> > +	uint32_t lo = 0, hi = nr;
> > +	while (lo < hi) {
> > +		uint32_t mi = lo + (hi - lo) / 2;
> > +		int cmp = cmp_idx_or_pack_name(pack_name, info[mi].pack_name);
> > +		if (cmp < 0)
> > +			hi = mi;
> > +		else if (cmp > 0)
> > +			lo = mi + 1;
> > +		else
> > +			return mi;
> > +	}
> > +	return -1;
> > +}
>
> Could this just be replaced with bsearch() in the caller?

Great suggestion. Yes, it can be. FWIW, I think that I may have
originally thought that it couldn't be since we were comparing a fixed
string to an array of structs (each having a field which holds the value
we actually want to compare). But bsearch() always passes the key as the
first argument to the comparator, so this is possible to do.

> > +		git multi-pack-index --object-dir=objects \
> > +			write --preferred-pack=test-BC-$bc.idx 2>err &&
> > +		test_must_be_empty err &&
> > +
> > +		ofs=$(git show-index <objects/pack/test-BC-$bc.idx | grep $b |
> > +			cut -d" " -f1) &&
> > +		midx_expect_object_offset $b $ofs objects
> > +	)
>
> ...what we really care about is that the object came from BC. And we are
> just using the offset as a proxy for that. But doesn't "test-tool
> read-midx" give us the actual pack name? We could just be checking that.
>
> I also wondered if we should confirm that without the --preferred-pack
> option, we choose the other pack. I think it will always be true because
> the default order is to sort them lexically. A comment to that effect
> might be worth it (near the "set up two packs" comment).

Both great points, thanks.

> -Peff

Thanks,
Taylor
