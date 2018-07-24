Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2741F597
	for <e@80x24.org>; Tue, 24 Jul 2018 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbeGXS1r (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 14:27:47 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44069 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbeGXS1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 14:27:46 -0400
Received: by mail-yb0-f196.google.com with SMTP id l16-v6so1917420ybk.11
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 10:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dp5LkLHGnRZtsnIxirL8gJNxTrxOcB/chyAi1CBcMak=;
        b=YEeStSKoApP9dQrwBimhGiOMk5+T12LSKiIOeC13dfyeDkoaV6NJ9K7Xn8lysyhGZn
         g4r/UduLHudFnB+8xZM8sjKhT6ywarUhWRFJRykgYH3Ms009wj86f59N5O8T+6W5E8DG
         mPdzs5S23kvS8Gkr5in/RYbSB5c+b1KfXsWctOB8jy9H3VfTTtEnKoykqwiwtNvw7OS0
         8c0UucXEX7FBr8WIRmLClL8sixJQ7V1/F0I+voktHtHdCUiYWK4Sifw5Aahzm5zMIYQu
         N986cCYGDzcloDbJ6P3gbzr9WFchXGw2dd/itKBQC5FtDmEE/IwSo2mX5mCDWmiqBk4a
         ieXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dp5LkLHGnRZtsnIxirL8gJNxTrxOcB/chyAi1CBcMak=;
        b=YfvnO/icGHqwKDOol5YFs9FC76iTV3mUFZeizD/dQySA03lLoQlXyB8jA7N1GKHili
         Z+7Mq891xLqQhlpXzLEBnkak+iQiT8n99Gclgc6YqyaD3i1dWwMyuCfKL31L8AswZwEG
         lw9ESopMCLKWdkK6QOvLH/tJIEIq4N8Spo8aNCwbUflzgyV0Cq9qxm19p20TWtmX7QWP
         ywMQmoH1z4cdXwlFjNYMJVBfjB7vRGGKhfMKbCHPerQlXth7KgOcpkJpr2jFstfVaqs1
         CbQWcUZFQa76Bfc1ziL/bnSmN8TuM78qRV/HdE5BBPafAsi4FP635e5qXmRg1KlcRvAr
         /g5g==
X-Gm-Message-State: AOUpUlELVL6ffF9QQZ6fQ1YuToKe0FcJYjfwxlYUGahDnCfI28kwVT5b
        DNAg5yLB0NPRTeFVZ7LSlNKhtBc4iWDuVJmfW/kML26B460=
X-Google-Smtp-Source: AAOMgpfGwAa9HQBWthN973+Bxh14losfqApLvfT5TCuLUc0XKemiJPg2iCG2jplh97J7TP4LlbsUof804bGGBE7y6UA=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr8591629ybi.247.1532452816681;
 Tue, 24 Jul 2018 10:20:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-4-chriscool@tuxfamily.org> <CAGZ79kbF7g3E4hBa0VqMqBoovbAb2dHaGFNRL=+f7Lce1AduVg@mail.gmail.com>
 <20180724095843.GB3578@sigill.intra.peff.net>
In-Reply-To: <20180724095843.GB3578@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 24 Jul 2018 10:20:05 -0700
Message-ID: <CAGZ79kZkagveB+jG9iLQ2ohaSfAzY5YtWC=BTdD1o9OQUrw90Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] pack-objects: add delta-islands support
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 2:58 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Jul 23, 2018 at 11:52:49AM -0700, Stefan Beller wrote:
>
> > > +DELTA ISLANDS
> > > +-------------
> > [...]
> >
> > I had to read all of this [background information] to understand the
> > concept and I think it is misnamed, as my gut instinct first told me
> > to have deltas only "within an island and no island hopping is allowed".
> > (This message reads a bit like a commit message, not as documentation
> > as it is long winded, too).
>
> I'm not sure if I'm parsing your sentence correctly, but the reason I
> called them "islands" is exactly that you'd have deltas within an island
> and want to forbid island hopping. So I wasn't sure if you were saying
> "that's what I think, but not how the feature works".

Yeah, you want to avoid island hopping, but still want the sea bed to be
useful for all islands (i.e. to have the largest possible base pack, that all
islands can share without being overexposed with objects they should
not see). And that is the main feature IMHO. It is not so much about
island separation (as you could use its own physically separated repo
for these separation tasks), but the main selling point of this feature
is that it enables a base pack that can be shared across all islands
without violating ACLs for example or making one island "too big"
(having unneeded objects on the island).

So metaphorically speaking I assumed the sea bed to support
all islands, which themselves are independent from each other.

> There _is_ a tricky thing, which is that a given object is going to
> appear in many islands. So the rule is really "you cannot hop to a base
> that is not in all of your islands".

Yes, if islands were numbers, we'd be looking for the Greatest common
common divisor for all of them, as all islands have to have access to
all objects in the base pack.

>
> > What about renaming this feature to
> >
> > [pack]
> >     excludePartialReach = refs/virtual/[0-9]]+/tags/
> >
> >   "By setting `pack.excludePartialReach`, object deltafication is
> >   prohibited for objects that are not reachable from all
> >   manifestations of the given regex"
> >
> > Cryptic, but it explains it in my mind in a shorter, more concise way. ;-)
>
> So I'm hopelessly biased at this point, having developed and worked with
> the feature under the "island" name for several years. But I find your
> name and explanation pretty confusing. :)

Ok.

>
> Worse, though, it does not have any noun to refer to the reachable set.
> The regex capture and the island names are an important part of the
> feature, because it lets you make a single island out of:
>
>   refs/virtual/([0-9]+)/heads
>   refs/virtual/([0-9]+)/tags
>
> but exclude:
>
>   refs/virtual/([0-9]+)/(foo)
>
> which goes into its own island ("123-foo" instead of "123"). So what's
> the equivalent nomenclature to "island name"?

So in my understanding we have a "common base pack" and specific
packs on top for each "island".

Regarding naming I find islands interesting and well fitting here, I don't
know of any better name.

I was just confused in the beginning as the name indicates that we care
about the islands, but we rather care about *not* hopping them.

Do you envision to have "groups of islands" (an atoll) for say all
open source clones of linux.git, such that you can layer the packs?
You would not just have the base pack + island pack, but have one
pack that is common to most islands?

Sorry if the initial email came off as a rant; I think the islands
metaphor is very good.

Thanks,
Stefan
