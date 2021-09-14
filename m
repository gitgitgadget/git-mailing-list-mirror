Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B273C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB76A61056
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 23:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhINXfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 19:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhINXfV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 19:35:21 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D734C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 16:34:03 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id m4so893338ilj.9
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 16:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kDqGQFWCS+jVyaDmrt1EuIAMLlC+m27q4amxiF6+fKM=;
        b=ZKsU7Pqn/UhPXyvb0YPaFLUv2ZkPiY0NvuDmJnXAyINt8l+UcEO8U5iqmIXvcf6is4
         qImrhIO7/+hEcDpqvf/N0gkKsWOR+7SAsRGcMgW4SRvva3CMYAS2HlDZc1yTNDJkmfRY
         5OF17Pht/A9jMIJmM59G5oYsREHN3zRqgGsioJI2VaeROmwpValYmqyS6pSEcbkYuiTa
         fjWdV8HBkeuJI7Q8vjFXb4TjvB2gIBm0ycxzdnrKqrHc3u0XSQOi2+p/qZWYEeXfZAnQ
         OQymawBTTPEF1AkU7gyYFhJrWf1qklmfvKhoG0R2Jh3M4fmIUSWa8OEmnlCStGb5I1CD
         yl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kDqGQFWCS+jVyaDmrt1EuIAMLlC+m27q4amxiF6+fKM=;
        b=dp0D69sbz4qSndO/5DwB4mj7OCl1ZhbTSGDvVQox+35KxQmvCwCkXQBJlRAHaznVKH
         7UtsZLPiHo38Cg7hMKPNEAZsuPy4bMpoYnSGtA8B2YOzYMQy6UYMm54QsLV/O0EI2ZAh
         DD3XylCdt3vDbFXJDPehcwEqO4FknGZ9BmFVyeOqALcXFt8H4En5x9NBgmDoQAb0Ey4g
         D05a5fi2Y5ByUo84bRdrOTXJfEsIdF7/CHRQtubt3GugREdX7LRlYwjXLNGBfXCKC25z
         KV2jci8rlVAzcuFAKveQSbGxizA4lhQltGTO7MLHH4QQLVEHWivgdHGNVjgDUZopu3VH
         tmfg==
X-Gm-Message-State: AOAM532DHOVpxOcmf0ApyzPHcSTEqmhaJktP/4DsbsZLGLpMVqms+axQ
        2Ad8pNhEmYhnsIRmZR3rOLi/J65otLCRaIqV
X-Google-Smtp-Source: ABdhPJxE1l0J8oji6CjpRnFxw79LFC/fntI9dH0kJoVf0jP2U3ADGRuyeKBdFn43lXwxMbOm/+Of0g==
X-Received: by 2002:a92:de41:: with SMTP id e1mr10972222ilr.85.1631662442584;
        Tue, 14 Sep 2021 16:34:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d10sm8036990ilu.54.2021.09.14.16.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 16:34:01 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:34:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Message-ID: <YUExaCwMwjfd5h7S@nand.local>
References: <cover.1631331139.git.me@ttaylorr.com>
 <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
 <871r5v9z3i.fsf@evledraar.gmail.com>
 <87sfyb8ihg.fsf@evledraar.gmail.com>
 <YTzejKyYvqZu4v16@nand.local>
 <YUDwB0W6IpWWcU81@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDwB0W6IpWWcU81@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 02:55:03PM -0400, Jeff King wrote:
> On Sat, Sep 11, 2021 at 12:51:24PM -0400, Taylor Blau wrote:
>
> > > >> +	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
> > > >> +		oid_to_hex(oid));
> > > >
> > > > Just an idea: Maybe the file could be lines of "+\tOID\n" instead of
> > > > "+OID\n"? Lends itself more naturally to extension, use with the likes
> > > > of string_list_split() etc.
> > >
> > > Actually, even better a format like:
> > >
> > >     "OID[\t+]\n"
> > >
> > > Or
> > >
> > >     "OID[\tpreferred=1]\n"
> >
> > Sure, but I admit that I'm a little torn on this suggestion. I don't
> > want to be naive and say that we're never going to change this format
> > and paint ourselves into a corner.
> >
> > On the other hand, changing it does seem extremely unlikely to me, and
> > this tab-delimited thing feels like overkill compared to how simple the
> > '+' format is.
> >
> > So, I don't know. It's certainly easy enough to change now before we
> > lock it in, so I guess we should.
>
> I'm not sure I really see the point of making this infinitely
> extensible. This is mostly an internal interface between two Git
> programs. Sure, it's exposed to the user in the sense that they can use
> --refs-snapshot themselves. But if some writer wants to add a "foo"
> flag, do they really want to be able to do it in a way that they're
> _syntactically_ compatible with the older versions of Git, yet have no
> clue if their option was actually recognized and accepted?

I like this perspective, and tend to agree.

(I'm basically repeating what you're saying but) it seems to me that
trying to make the interface of `--refs-snapshot` compatible across
versions of Git is stretching what we consider to be our compatibility
guarantee given that:

  - the interface is basically expected to be private between `repack`
    and `multi-pack-index`, and

  - an infinitely-extensible version of `--refs-snapshot` would still
    have no way to tell the caller whether or not those new flags were
    accepted

So I tend to agree the existing format works fine and we shouldn't spend
a ton of time trying to over-engineer a solution.

(FWIW, the `+` vs `-` thing is intentional; `--stdin-packs` uses `-` to
_exclude_ packs, but `+` here means "this one is special" not "exclude
this ref").

Thanks,
Taylor
