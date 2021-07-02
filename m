Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013EAC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 17:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D6B613F9
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 17:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhGBRqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhGBRqs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 13:46:48 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B57C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 10:44:14 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id s19so10511864ilj.1
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aJfsWQDvv1HdK8I0TEx6dycmZX1qEi4I92cKXA802Hw=;
        b=tHjB5IXgj7Nnmh0jYT8xQyuGrSW9XSCKvx2qef4NqXLvgrtyoW+kz7oIl8NloP+ntD
         T+CcLf62HpJQtutkZ8fj33vCdCYevlmY1KGTCqVk2EmyCF5TZWWh8XY34ZUKbjs3z2i6
         KJKN22mDB0pQFi5aQZW2i5gpGHKG1yHcED7q5vs4BneseEhPv+NYj2s73H35gAG8XAY7
         9JEnpZg63qyO3hGvn6QkbK0MLvaeCnkL/M+w69/hmadpjHaCbykvOBQX1pT2iplcJmue
         U8cYYMi+EYiShI+mzlpE9omlub8cVEVcKDw64aR46nsOY8QdF3d0DsT7qrRDOWDBS1+y
         2o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aJfsWQDvv1HdK8I0TEx6dycmZX1qEi4I92cKXA802Hw=;
        b=Jb7Yz2H0PJ0SH6dBBnwvNpSkA1P9HZR3eOViVAGXJMo3CS+7kpPo/3gduyj00xj35z
         6b8SEwu80rNCJ9gSi0TQkRC0taTQiag066kNUKW1X8HtqSBQ6DKTu/ArVjs1cmJNN8c/
         eAL1C2p+Lx1NA1/ux/4c2BnS/wTDxrsoGexRn5JdoeCA1oAD1k8B/AKdKpQPqBzOkd5m
         BwMhq33283Cin4aJqIWe4B0v50gLW+9++x5OqN2Op43B9Y+TIKcWWGjzlYdvXXe0Yswf
         j4QROnr6SaCQ/kEnQxWqEPR3nHzUF2I3Z6IieBqgwaRgY+eMMZobT725vfT5PAmc2Olf
         Ipfg==
X-Gm-Message-State: AOAM533RuOjRAIfrW3bosQkKiZ0F7ipUFnMM3hW7mVpVLI9iKSM7Zbhc
        14s48nzOeuifQwMzR3wtprzwug==
X-Google-Smtp-Source: ABdhPJyr/1wvtkMllQpadMUKP7/gTXsFyHx08zTtcEg5LxD6CC5cUp6uqt2Nmly+nCaWLKnDm/Hr1w==
X-Received: by 2002:a92:c210:: with SMTP id j16mr774400ilo.91.1625247854138;
        Fri, 02 Jul 2021 10:44:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c10sm2055550ild.72.2021.07.02.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 10:44:13 -0700 (PDT)
Date:   Fri, 2 Jul 2021 13:44:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] connected: implement connectivity check using
 bitmaps
Message-ID: <YN9QbEaWgP09PfeD@nand.local>
References: <cover.1624858240.git.ps@pks.im>
 <7687dedd4722c39b5ecef2c2165147c25d16b8d9.1624858240.git.ps@pks.im>
 <YNovuzAsaEb2uIaa@nand.local>
 <YNuiM8TR5evSeNsN@nand.local>
 <YNvRSJI1oWN9W25Y@coredump.intra.peff.net>
 <YNvgA6RLIMdD77Hk@nand.local>
 <YNwE3wES3iv+Xynp@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNwE3wES3iv+Xynp@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 01:45:03AM -0400, Jeff King wrote:
> That implies to me that yes, it really is saving time, especially in the
> cold-cache case. But if you have to do any actual fill-in traversal, the
> benefits get totally lost in the noise. _Especially_ in the cold-cache
> case, because then we're faulting in the actual object data, etc.

That's definitely true. I would say that any patches in this direction
would have the general sense of "this helps in some cases where we don't
have to do much traversal by eliminating an unnecessarily eager part of
loading bitmaps, and does not make anything worse when the bitmap
coverage is incomplete (and requires traversing)."

I would add that these effects change with the size of the bitmap.
Let's just consider the "count the number of objects in a bitmapped
commit". On my local copy of the kernel, I see a relatively modest
improvement:

    $ tip=2ab38c17aac10bf55ab3efde4c4db3893d8691d2
    $ hyperfine \
      'GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $tip' \
      'GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $tip' \
      --warmup=3
    Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $tip
      Time (mean ± σ):      21.5 ms ±   5.6 ms    [User: 8.7 ms, System: 12.7 ms]
      Range (min … max):    12.4 ms …  34.2 ms    170 runs

    Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $tip
      Time (mean ± σ):      10.6 ms ±   1.6 ms    [User: 7.1 ms, System: 3.5 ms]
      Range (min … max):     4.5 ms …  11.9 ms    258 runs

but on my copy of the kernel's fork network repo (that containing all of
torvalds/linux's objects, as well as all of its fork's objects, too),
the magnitude of the effect is much bigger:

    Benchmark #1: GIT_READ_COMMIT_TABLE=0 git.compile rev-list --count --objects --use-bitmap-index $tip
      Time (mean ± σ):     332.3 ms ±  12.6 ms    [User: 210.4 ms, System: 121.8 ms]
      Range (min … max):   322.7 ms … 362.4 ms    10 runs

    Benchmark #2: GIT_READ_COMMIT_TABLE=1 git.compile rev-list --count --objects --use-bitmap-index $tip
      Time (mean ± σ):     260.0 ms ±   9.3 ms    [User: 191.0 ms, System: 69.0 ms]
      Range (min … max):   250.4 ms … 272.8 ms    11 runs

That's a more modest 1.28x improvement (versus 2.03x in just linux.git),
but the overall magnitude is much bigger.

This is basically an effect of the bitmaps themselves. In the latter
example, there are more bitmaps (around 1.6k of them, versus just over
500 in my copy of just the kernel), and each of them are much wider
(because there are far more objects, 40.2M versus just 7.8M). So there
is more work to do, and the page cache is less efficient for us because
we can't fit as much of the .bitmap file in the page cache at once.

> By the way, one other thing I noticed is that having a fully-build
> commit-graph also made a big difference (much bigger than this patch),
> especially for the non-bitmapped commit. Which makes sense, since it is
> saving us from loading commit objects from disk during fill-in
> traversal.

Likewise having an reverse index helps a lot, too. That radix sort
scales linearly with the number of objects in the bitmapped pack (plus
you're paying the cost to allocate more heap, etc).

This clouded up some of my timings in p5310, which made me think that it
would be a good idea to `git config pack.writeReverseIndex true` in the
setup for those tests, but an even better direction would be to change
the default of pack.writeReverseIndex to true everywhere.

> So I dunno. There's absolutely savings for some cases, but I suspect in
> practice it's not going to really be noticeable. Part of me says "well,
> if it ever provides a benefit and there isn't a downside, why not?". So
> just devil's advocating on downsides for a moment:
>
>   - there's some extra complexity in the file format and code to read
>     and write these (and still fall back to the old system when they're
>     absent). I don't think it's a deal-breaker, as it's really not that
>     complicated a feature.

I agree with both of these. The complexity is manageable, I think,
especially since I dropped support for the extended offset table (having
a bitmap file that is >2GiB seems extremely unlikely to me, and it's
possible to add support for it in the future) and
fanout table (there are usually less than <1k commits with bitmaps, so
a 256-entry fanout table doesn't seem to help much in benchmarking).

So what's left of the format is really just:

  - a table of object id's
  - a table of (uint32_t, uint32_t) tuples describing the (short) offset
    of the bitmap, and an index position of the xor'd bitmap (if one
    exists).

>   - we're using extra bytes on disk (and the associated cold block cache
>     effects there). It's not very many bytes, though (I guess 20 for the
>     hash, plus a few offset integers; if we wanted to really
>     penny-pinch, we could probably store 32-bit pointers to the hashes
>     in the associated .idx file, at the cost of an extra level of
>     indirection while binary searching). But that is only for a few
>     hundred commits that are bitmapped, not all of them. And it's
>     balanced by not needing to allocate a similar in-memory lookup table
>     in each command. So it's probably a net win.

Worth benchmarking, at least.

I'll be offline for the next ~week and a half for my wedding, but I'll
post some patches to the list shortly after I get back.

Thanks,
Taylor
