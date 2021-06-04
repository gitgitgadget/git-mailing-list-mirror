Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114FBC4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0C46138C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFDVpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:45:47 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:39672 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhFDVpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 17:45:46 -0400
Received: by mail-ej1-f44.google.com with SMTP id l1so16603707ejb.6
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 14:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=LZH+8mmBfUlIu/8fW1OMgApijCvtxoSCsU/jdafiDI4=;
        b=A2ZNXMz4Su3oWhtSj3gboIHaFM84Yxyovg1X9ZIc671UctPXsVGVcDcLtjBXvTopgN
         N+rdr5NRjFDqmYBThC9obGU3MVPdReSlvQ3rfsCo5PsgPGV3S4W0QWuB13n5IIQFGoXJ
         wn/NnIDWNf9vSm7VBrhgjr+b2Fj2TuGgEJMbqrKVIAAoKqKqLZuyUJAJDUjA1LTt7ASM
         gUXxHBQr6qPB6kEW6rqX3U9nLyeYpcXfyjp1j/1Wa38vX6mIFVn4gj7JuLAOsy8tzWOl
         +ax0VmIPaZRfxI8arxo/5MM9d3dALf1jfI1mGOkk3XpPepIqWGzXhU0D6mwfZOi47M2+
         21TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=LZH+8mmBfUlIu/8fW1OMgApijCvtxoSCsU/jdafiDI4=;
        b=NsxG7qbRsESSvFfygsewbZJqj21WYGhtOFukv9+VgYik9rUBw+CsfdkWM5o0QjJMZO
         emTpX/iGOx0ZhLaTCgdeEg7colGVJQHzeqcP6F7pPbdY6b3oLqWeP6QkwtdPhgAmDKpt
         TQ3PJVLHTnWwFdoGojE3vFh5TYFAh5Ws1GiyE843jrZPDKXmLYJ2/N9VodiHOmmKmPgZ
         JGrCMasw6UyaFNLkWgk1CCCt7Ty6PJQZgCrJYJVcnKCvwtczHsTw6KSAx9DPwyfiConR
         YLhUCcl/u2172oaCTKbesYb1imjRgvTul5twSSmTbpz4Uv5Hpvkam3cWpn+Mpr6NSCoN
         GGGQ==
X-Gm-Message-State: AOAM5307Xwnir6rgK9PtjVM6XU0RsIHOSs7xcHZxSv/6vJjWBkIlHNdv
        vHAD4bDpp/x5EWP3Ar8gO30=
X-Google-Smtp-Source: ABdhPJxkqIX41ujriB3s9valhuPvfsKF8U2rIAJZIPSIG2DyQkgwIXpCvIEGu17XI38IaXRhAGnDHw==
X-Received: by 2002:a17:906:7b4f:: with SMTP id n15mr6087200ejo.220.1622842978911;
        Fri, 04 Jun 2021 14:42:58 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f3sm3829532eds.59.2021.06.04.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:42:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Date:   Fri, 04 Jun 2021 23:37:22 +0200
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
        <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
        <87y2bv0yvl.fsf@evledraar.gmail.com>
        <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
        <60b93a264cb7_39da0420855@natae.notmuch>
        <YLlEx5qlN7rgehaP@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLlEx5qlN7rgehaP@coredump.intra.peff.net>
Message-ID: <87lf7p5msj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 03 2021, Jeff King wrote:

> On Thu, Jun 03, 2021 at 03:23:02PM -0500, Felipe Contreras wrote:
>
>> Jeff King wrote:
>> > Preemptively finding portability problems may save work in the long
>> > term. And people may even be using Git on AIX and just ignoring test
>> > failures, or they have GNU coreutils installed anyway, etc. But it would
>> > also save work if we can ignore platforms that nobody uses.
>> 
>> I agree, but the Git project is overly preoccupied (IMO) with
>> hypothetical issues some hypothetical users might have in some
>> hypothetical situations, and that is used as a rationale to block changes
>> that would improve the experience of the vast majority of users.
>> 
>> This is not a hypothetical issue, and yet you are suggesting to
>> discount it?
>> 
>> I don't disagree, but this is not consistent.
>
> I don't think they're the same issue at all. One is: we have millions of
> users, and this change may affect some of them negatively, so we may
> want to err on the side of caution. The other is: this has been
> accidentally broken for four years and nobody complained, so perhaps
> nobody is actually using it.

Aside from AIX I think you're assuming less of a cowboy attitude among
packagers of these platforms than is the reality in the wild :)

I mean I don't blame them, git's just one thing they're packaging, and
e.g. on the BSD's or whatever this is just the Nth
Linux-toolchain-specific smelling test failure or issue they have that
day.

I have some incomplete work somewhere to slurp up all the package
sources I could find in the wild (SRPM's, Debian recipies etc.) and
their patches, the aim was to submit it into contrib/ so we could see
what monkeypatches to git.git existed in the wild.

Last time I looked at those (and this is from memory, and it was a while
ago) many of those patches / build recipies were simply blindly skipping
or otherwise working around test failures.

So we can't assume that failures in the wild are reported to us, and I
think many packagers are not running any of our tests at all. If it
compiles and seems to work they're probably just shipping it.
