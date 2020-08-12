Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C118C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30210207DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHLQPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:15:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44602 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgHLQPp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:15:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id c15so2560839wrs.11
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 09:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WA5wNwJ4b8xT2kdNjgC3t4lBTLcJUojKMNGfloHonyM=;
        b=G1lfa34UqDtDdvCgG3yCuQ0YgCKXO7P/sDk/a8c4RwA1GCH0+ad6EWyr27kI9itByN
         qfzcAXNtekbCHDVyPOjTFJ+K6SHnxHkjYKM8DLrCIpEkkttUOYJKZEfMOSKdRmNBzHYu
         G0G3xf8FFFVGJ3w4GXiufKsJRpialsE3PCUss5vQOh/3sE1DFf6x9zV5BEkEyStBVRI8
         x4W42dBvP60vIzqjxB2HElbZYvLfP6AEwapYOaAX6o6MPXDRzgpyUGv+4Z45qQqTc6KM
         QBCGqL01TfHS7UyE9adY0cNHSEdwu0ScJWw7vnC/u9jnIhOhGpRhkR45BOfKiSNsknEj
         QnhQ==
X-Gm-Message-State: AOAM531YT/Y3N8RHZuoTv8Cyg9EyKW3IXjG/g2JZB5RzftthscKKFBDg
        AYHFM9X+sJ96L+mmBr1365Dt3qCAwTi2KwI1Pgk=
X-Google-Smtp-Source: ABdhPJxXL66HlZyh8pK3+zL7mDqkNDpTvh2jYwRJolUpCm5xZ4B0qwMMhcovR1XNIzE5b0X0YNyKYufheOoP/eIE7Mo=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr19282wrs.226.1597248943332;
 Wed, 12 Aug 2020 09:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com> <20200811183258.GB33865@syl.lan>
 <CAPig+cSroWZEoOL78COmPS4rkvKLE-yCiqh6Part+5gUgVon+A@mail.gmail.com> <20200812153705.GC33189@coredump.intra.peff.net>
In-Reply-To: <20200812153705.GC33189@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 12 Aug 2020 12:15:32 -0400
Message-ID: <CAPig+cQNvJ02fm82oBtyyxHUqfNk3oAZJW__Lu2Kn0Qt3VaDWw@mail.gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 11:37 AM Jeff King <peff@peff.net> wrote:
> On Tue, Aug 11, 2020 at 03:25:03PM -0400, Eric Sunshine wrote:
> >     test -e = -
> > Rather than comparing literal string "-e" to literal string "-", it's
> > instead (almost) asking if the file named "=" exists; I say "almost"
> > because it's actually an error since switch -e only accepts one
> > argument, but it's being given two arguments, "=" and "-".
>
> I don't think this is an error. The program can tell which you meant by
> the number of arguments. POSIX lays out some rules here (from "man
> 1posix test" on my system, but I'm sure you can find it online):

I intentionally didn't focus on or mention POSIX in my response
because I wanted to represent the Real World reason why "x$var" is
such a common idiom. As a person who regularly uses ancient operating
systems and old computers (it's common for me to be stuck on computers
10-25 years old; my most up-to-date computer is 9.5 years old), Real
World is something I focus on more than POSIX. Okay, I may be an
outlier, but still...

> > which may or may not be an error in a particular implementation of
> > 'test'. Some implementations may understand that "-" is not a valid
> > switch, thus infer that you're actually asking for an equality
> > comparison between arguments, but other implementations may complain
> > either that there is no switch named "-" or that those arguments
> > simply make no sense.
>
> Yeah, historically I think there were shells that were not quite so
> clever. I have no idea which ones, or whether any are still around. I
> don't think we've generally been that concerned with this case in Git,
> and nobody has complained. I'd be totally unsurprised to hear that SunOS
> /bin/sh doesn't get this right, but we've already written it off as
> unusable (it doesn't even support $() expansion).

I'm probably showing my age, but having had to deal with the many
inconsistencies of implementation over the years, it's hard to _not_
worry about such things even now. Adding the "x" to "$1" or to making
other minor portability concessions is reflex at this point. These
portability concerns are also always on mind when dealing with Mac OS
since so many of its utilities are ancient and retain the old
behaviors.
