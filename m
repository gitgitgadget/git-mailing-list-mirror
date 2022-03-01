Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04034C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 02:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiCACtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiCACtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 21:49:14 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632B24615A
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:48:34 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id 9so11536729ily.11
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M5bHeff1baEwP3J78WKwUudfyTPMpLHBTPASIBruWno=;
        b=exn+kGVV+Qk/ffF24QKjNgTUNvIbFuycMhC5yxLvkUvR/EKf7H4lhB4h842E794l6v
         PaVVLnFt8pS83OlZk/1M2E/5ELavEyYaO4hf34gzkk6aam6yIjN724TiNrsBnvW+DwXL
         H7pezvOQH12CcBPOwkifRPwuBo4Qrcw83UOaPCJ+8OaVoqjwA6ypxHswQokEoPfKy2ob
         /6BYm9dVvO0OSZMlI13LxGAtmTOYe6TVbD7Stj03zzWFqaN2k+xU8LfT0vEBThmVKd1o
         835jXFDMys72iHKlSpej5nR7iFOMdXC81jovpEd6lqHx1ynNWQn4Gd8bdpNLk+fRBlhj
         kk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M5bHeff1baEwP3J78WKwUudfyTPMpLHBTPASIBruWno=;
        b=D0Mjuz5RlM/BQZ0OQ5oUXrw3ioK5RPWnZe4G6OLIAXuiYxTvIEieyBEvpG8PDj82ny
         0hXxEiJ9Yi+mrQN2pdboYqBHXqPJ2+iBCbM1vCiDfea8zn2eGHLC0k18KvuZKR0hcJ/I
         tIPHDBXaJ20xvWOTayAQ++flz10aan28hT1TgxODSUbYYcKbBYN0lJ3b0PdtgDEUjaLj
         4wEeNtJ1d2BRy4nxPz+tZhKpJ7TbFrpNy6xE55mZubxB/frSxN/lmHiMADZ/YAi3BPdo
         +9VjE2riIwKklCOxDQIHEi2Ogx9JPgN1K8S7ltOTB1OzZSHvKI3DaYab7TpRYWkh6kSh
         h3zQ==
X-Gm-Message-State: AOAM530JPSZowqwL5nt1TAozsNTgdld4dmJhu3OmDPptR58mnx4J0QFR
        nlA5FPIrXyyWJN1y0xxvuv6W24ly/Z1JHKWE
X-Google-Smtp-Source: ABdhPJw98VxzDPCbgmOJUw/yrWXK1GHNPrntHRWqJRwS6OYqt3vPXm0ve1rWdIe26PM/TjYSS0VwlA==
X-Received: by 2002:a05:6e02:1746:b0:2c2:8a1f:8ca6 with SMTP id y6-20020a056e02174600b002c28a1f8ca6mr20515924ill.178.1646102913669;
        Mon, 28 Feb 2022 18:48:33 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o12-20020a92d38c000000b002c25f9905fasm7111456ilo.57.2022.02.28.18.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 18:48:33 -0800 (PST)
Date:   Mon, 28 Feb 2022 21:48:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
Subject: Re: [PATCH 08/17] builtin/pack-objects.c: --cruft without expiration
Message-ID: <Yh2JgPzR4Tg3PmNL@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <66165917a4660f63ce60b820d178d52a51304d20.1638224692.git.me@ttaylorr.com>
 <b3a30e27-7821-1fcb-bacc-07a6d2b3df76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3a30e27-7821-1fcb-bacc-07a6d2b3df76@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 06, 2021 at 04:44:31PM -0500, Derrick Stolee wrote:
> On 11/29/2021 5:25 PM, Taylor Blau wrote:
> > Generating a non-expiring cruft packs works as follows:
>
> I had trouble parsing the documentation changes below, so I came back
> to this commit message to see if that helps.
>
> >   - Callers provide a list of every pack they know about, and indicate
> >     which packs are about to be removed.
>
> This corresponds to the list over stdin.
>
> >   - All packs which are going to be removed (we'll call these the
> >     redundant ones) are marked as kept in-core, as well as any packs
> >     that `pack-objects` found but the caller did not specify.
>
> Ok, so as an implementation detail we mark these as keep packs.


> >     These packs are presumed to have entered the repository between
> >     the caller collecting packs and invoking `pack-objects`. Since we
> >     do not want to include objects in these packs (because we don't know
> >     which of their objects are or aren't reachable), these are also
> >     marked as kept in-core.
>
> Here, "are presumed" is doing a lot of work. Theoretically, there could
> be three categories:
>
> 1. This pack was just repacked and will be removed because all of its
>    objects were placed into new objects.
>
> 2. Either this pack was repacked and contains important reachable objects
>    OR we did a repack of reachable objects and this pack contained some
>    extra, unreachable objects.
>
> 3. This pack was added to the repository while creating those repacked
>    packs from category 2, so we don't know if things are reachable or
>    not.
>
> So, the packs that we discover on-disk but are not specified over stdin
> are in this third category, but these are grouped with category 1 as we
> will treat them the same.

Ah, I think I caused some unintentional confusion by attaching "are
presumed" to "these packs", when it wasn't clear that "these packs"
meant "ones that aren't listed over stdin".

Since the caller is supposed to provide a complete picture of the
repository as they see it, any packs known to the pack-objects process
that aren't mentioned over stdin are assumed to have entered the
repository after the caller was spun up.

I'll clarify this section of the commit message, since I agree it is
unnecessarily confusing.

> >   - Then, we enumerate all objects in the repository, and add them to
> >     our packing list if they do not appear in an in-core kept pack.
>
> Here, we are looking at all of the objects in category 2 as well as
> loose objects.

We're enumerating any objects that aren't in packs which are marked as
kept in-core (along with loose objects which don't appear in packs that
are marked as kept in-core).

The in-core kept packs are ones that the caller (and I find it's helpful
to read "the caller" as "git repack") has marked as "will delete". So
the non in-core pack(s) that we're looking at here contain all reachable
objects (e.g., like you would get with `git repack -A`).

> > +	Packs unreachable objects into a separate "cruft" pack, denoted
> > +	by the existence of a `.mtimes` file. Pack names provided over
> > +	stdin indicate which packs will remain after a `git repack`.
> > +	Pack names prefixed with a `-` indicate those which will be
> > +	removed. (...)
>
> This description is too tied to 'git repack'. Can we describe the
> input using terms independent of the 'git repack' operation? I need
> to keep reading.
>
> > (...) The contents of the cruft pack are all objects not
> > +	contained in the surviving packs specified by `--keep-pack`)
>
> Now you use --keep-pack, which is a way of specifying a pack as
> "in-core keep" which was not in your commit message. Here, we also
> don't link the packs over stdin to the concept of keep packs.

The mention of `--keep-pack` is a mistake left over from a previous
version; thanks for spotting. Here's a version of the first paragraph
from this piece of documentation which is less tied to `git repack` and
hopefully a little clearer:

    --cruft::
            Packs unreachable objects into a separate "cruft" pack, denoted
            by the existence of a `.mtimes` file. Typically used by `git
            repack --cruft`. Callers provide a list of pack names and
            indicate which packs will remain in the repository, along with
            which packs will be deleted (indicated by the `-` prefix). The
            contents of the cruft pack are all objects not contained in the
            surviving packs which have not exceeded the grace period (see
            `--cruft-expiration` below), or which have exceeded the grace
            period, but are reachable from an other object which hasn't.

> > +	which have not exceeded the grace period (see
> > +	`--cruft-expiration` below), or which have exceeded the grace
> > +	period, but are reachable from an other object which hasn't.
>
> And now we think about the grace period! There is so much going on
> that I need to break it down to understand.
>
>   An object is _excluded_ from the new cruft pack if
>
>   1. It is reachable from at least one reference.
>   2. It is in a pack from stdin prefixed with "-"
>   3. It is in a pack specified by `--keep-pack`
>   4. It is in an existing cruft pack and the .mtimes file states
>      that its mtime is at least as recent as the time specified by
>      the --cruft-expiration option.
>
> Breaking it down into a list like this helps me, at least. I'm not
> sure what the best way would look like.

Given some expiration T, cruft packs contain all unreachable objects
which are newer than T, along with any cruft objects (i.e., those not
directly reachable from any ref) which are older than T, but reachable
from another cruft object newer than T.

Thanks,
Taylor
