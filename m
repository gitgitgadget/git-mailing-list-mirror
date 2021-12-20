Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D625FC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 19:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhLTTwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 14:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhLTTw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 14:52:27 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E95C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:52:25 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id m12so8522610ild.0
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 11:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7mpN0AUt3xHjK5G+XTtP+4PbmGmlE12CIS8dXdOON2w=;
        b=xQyKxVf6SJrTih6nq8hR95WWUEZNzyV3rPXkG5hMDUteyhToVnE2uoyhlFM6BcLowz
         jhI+GSuGEVei7k53gUilempH/rky4Bf8y++l2NgoAlAVHuAGWOMF51wc4nQ2dgDzDSz/
         LkA3pBRtGAXx7rTA8uScjfa8QK2vbJIVM5eu6o4yYawkatsg10GAF2obGxPnog9QP3fE
         HX5OeAIHwXi57L/2XAXhEaXst/ZLF3s7Eqqc8l6WcCDL65cYmcJG94WoOmRs3Dg0jCWF
         YcAWojDC/w3wAo6ymxGcc8agGtu8NohXhMVK+mAV6nFr/2SBt1QBrN14oAOWU7u8Jy/r
         hQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mpN0AUt3xHjK5G+XTtP+4PbmGmlE12CIS8dXdOON2w=;
        b=TtMmL79x5C0J/fDOay5pD6iJVzKcr86PR1QoECgCSrzB+C1sUFRZopjK6mOsfT/RwR
         +U1UAHB4qihZPfx+sIjP6XwXDfvcyRDPs55+LXCy/eNBBjG9dLftF6vZRc7xJzTcsjjc
         YEZtCrwiec8t6SARlRxFO8BFoCwO4W5oc3/8l2J8F9aPzMuTbM8+EDILnmc33j7jSo8p
         Qqqh75zPKDVJEr9te2OoCSmka2s7OdVJahJQKCjzL1W0dKYP3UinNca3vsbD7/cQVZg7
         pBDWO8cpQwf4eZkaTyUicK+TwAv6giegM+vTWZXTUJWMe1zLBufLZPaT9cVzpJ4lXD13
         Cjpw==
X-Gm-Message-State: AOAM5325foAXyaD7ROZGcQoXNkjFgj4R+Ric8CfXlw7ytf77Ao+Ygjtf
        TSOm/yx1rX4B/qKoVueJShH7OgvE16KJ2k1n
X-Google-Smtp-Source: ABdhPJxjqc9ok4S2zbwFmjpqQWWNaNIHaqsFpxSTtq5Y2MPbVHECjl5LYTZyuUXN7rfajKzZwM7p9A==
X-Received: by 2002:a05:6e02:1789:: with SMTP id y9mr8599413ilu.321.1640029945248;
        Mon, 20 Dec 2021 11:52:25 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o12sm11283527ilu.82.2021.12.20.11.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 11:52:24 -0800 (PST)
Date:   Mon, 20 Dec 2021 14:52:23 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
Message-ID: <YcDe9wl4XwH7PjX1@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
 <xmqqee6d648n.fsf@gitster.g>
 <886da3f3-aa6a-ac74-2aa2-26abdf832ebd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <886da3f3-aa6a-ac74-2aa2-26abdf832ebd@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 20, 2021 at 01:51:22PM -0500, Derrick Stolee wrote:
> On 12/15/2021 2:46 PM, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> >> Here is a reroll of my series which fixes a serious problem with MIDX bitmaps by
> >> which they can become corrupt when permuting their pack order.
> ...
> >> So I'm definitely open to suggestions there, but otherwise this series should go
> >> a long ways towards fixing my design mistake of having the MIDX .rev file be
> >> separate from the MIDX itself.
> >
> > Yeah, a single file with different chunks is a good way to ensure
> > atomicity of update.
>
> I just reviewed this series for the first time. Sorry for being so
> late getting to it.

Thanks for your review. I think that the upgrade plan is sane, but I can
comment a little bit more about that below.

In the meantime, some thoughts on all of the combinations of the new
GIT_TEST_ variables:

  - GIT_TEST_MIDX_READ_RIDX=0 GIT_TEST_MIDX_WRITE_REV=0: this means that
    we won't use bitmaps at all, since we won't have a .rev file to
    read, and we will pretend that the RIDX chunk does not exist.

  - GIT_TEST_MIDX_READ_RIDX=0 GIT_TEST_MIDX_WRITE_REV=1: this is the
    status-quo of how things work today.

  - GIT_TEST_MIDX_READ_RIDX=1 GIT_TEST_MIDX_WRITE_REV=0: this is the
    status-quo of of how things will work after this patch series.

  - GIT_TEST_MIDX_READ_RIDX=1 GIT_TEST_MIDX_WRITE_REV=1: this is useful
    for testing that the RIDX chunk is preferred over reading the .rev
    file.

So all but the (0, 0) combination make sense. Perhaps we should ban that
combination entirely, since nobody would ever set it for a good reason.
But I think that none of these combinations would allow us to propagate
the corruption, since we will always *write* the new RIDX chunk, which
causes the MIDX's checksum to change when we changes its object order.

I kind of hate these runtime checks that are only useful for testing. If
anybody has better ideas of how we should go about this that still
provides comprehensive coverage of .rev files, then I'm all ears.

(The nuclear option might be to just stop supporting .rev files for
MIDX's altogether, since this is such a new feature. But that seems like
a pretty drastic step, and definitely isn't backwards compatible. So I'd
be wary of going in that direction).

> 1. Can we still read a .rev?
>
> The new test script specifically verifies that existing repositories
> will continue to read their .rev upon upgrade. Their .rev files will
> be replaced with the chunk during the next write.

Yes, exactly.

> 2. What if they downgrade after the RIDX chunk is in place?
>
> The .rev file is missing and the repo has a performance issue because
> they can't use bitmaps. Correctness is not a problem. Anyone using
> .rev files for server use (where bitmaps are most useful) is hopefully
> already careful about downgrading Git versions.

Yes, and we gracefully degrade here (I think that I demonstrated this in
my previous response), so in this scenario the worst an operator would
encounter is a performance regression.

> 3. Should the chunk be made mandatory?
>
> Unfortunately, the chunk format did not follow the index format's
> example of making lowercase chunk IDs required. Instead, the chunks
> that are necessary for v1 are necessary forever and all other chunks
> are deemed optional. Changing this would require something more
> drastic like updating the version number or giving some grace period
> where released versions start treating lowercase chunk IDs as required
> before creating a new "required" chunk.
>
> This does mean that if there is a version incompatibility, the RIDX
> chunk will just be ignored by the older version of Git.
>
> In terms of making this a safe format upgrade, I think Taylor has
> achieved that.

Thanks. And yeah, the chunk should (and is) mandatory when writing a
MIDX bitmap. But if we ran `git multi-pack-index write` without
`--bitmap`, then we would be free to not write the RIDX chunk (and
indeed that is what we do).

> The only thing I can think is that server operators might want to
> deploy this version with GIT_TEST_MIDX_WRITE_REV=1 for a while, so
> any need to downgrade would not suffer a performance penalty for a
> missing .rev file. If that is a planned way to safely deploy this
> change, then it might be worth adding a test that we safely delete
> a .rev file after writing both a .rev file and a RIDX chunk. (The
> RIDX chunk will be preferred, so maybe the previous .rev file hits
> some logic that would skip its deletion?)

That logic (that we delete auxiliary files--including the .rev file--not
matching the checksum of the MIDX we just wrote) is unchanged. So I
think we should be good there since we have existing coverage.

Thanks,
Taylor
