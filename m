Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD221F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfD3SsN (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:48:13 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:40366 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3SsM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:48:12 -0400
Received: by mail-ed1-f44.google.com with SMTP id e56so6918223ede.7
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MYshi+R8LbeUsoysrVUClNZTFzcxtrBxaXuHuI9BZoY=;
        b=R2mgN76i/v0KcjH7VcS+/Iu/Ppek25lt/6aiy96xyYjNnPlFbas7VBsgRaDepX8A1n
         PRbHEUK8lwrDc6zaIEt+ypLfFF6nCZzuhSaeTyCE/FBW0JI6ypVnLYBpoNu65+hcU2Cb
         /L1ws3JWaeXhhByB7C4aw9YGUY4SJ5QcS+vGnGC8cOJnYx/VGtIwBj+ibX7x1gjz7APZ
         U5DFUmOCEYeVruJSl6LZRFGle/Dl60MLctZuei/1++aOvvOWuawAgWQig2wZCpOvJDSH
         8jGZ1bgdqlY7HEhnp8VjmZDm4p5O2osaFEsdxEQynz0QOll+NnaYP6hb8t9Ddoy8Lcl9
         CZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MYshi+R8LbeUsoysrVUClNZTFzcxtrBxaXuHuI9BZoY=;
        b=RCNiE8+qTU20wvqclSq03yWah9ocaMV0a81mG/wrSF4FNVuYvxRGV56h3P3fscGX0o
         n+TbEYVyDce5T4L8ILLr5doZSKj90W6bFTJU68BSotalTNgx8AH/JLxHk6D9tRkdQF9H
         jgXjR5B/iHQkrJ8CUjpoREjVodMzzr2eTQcK/0g9lGGahgzWWGyXhRnN9WOhSDojvYUs
         D4QZhsFTFmgnsvi31hUNDC6WbW5sYV/3lGps/n0gSwaidUevEJ3GaP5SOoX/nxfl/DR2
         5ADAVPOGvHQB7zGJmPhYpnyPA3KYKIdQ8v5HVIOmSoxrSAoarWuSKn1RgYXxi1alcbRs
         iLlg==
X-Gm-Message-State: APjAAAVS9/zyWDkxgH1s7/oCxHY+RI83kdNtoyPIPg7WadGVcu2SBVZU
        SCURta/RPKqLSn8uXpv6pZI=
X-Google-Smtp-Source: APXvYqzXcvGum6uCgcdBKZ9VIgJcC+pwfOp0COHrQsmlY1xlplI3Y/epHreMVt+wlZHI0T7e+l92GA==
X-Received: by 2002:aa7:d908:: with SMTP id a8mr43157126edr.68.1556650090159;
        Tue, 30 Apr 2019 11:48:10 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id v9sm10271738ede.32.2019.04.30.11.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Apr 2019 11:48:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Resolving deltas dominates clone time
References: <259296914.jpyqiltySj@mfick-lnx> <16052712.dFCfNLlQnN@mfick-lnx>
        <20190422205653.GA30286@sigill.intra.peff.net>
        <19221376.OlD5LWjr85@mfick-lnx>
        <20190423015538.GA16369@sigill.intra.peff.net>
        <20190423042109.GA19183@sigill.intra.peff.net>
        <CACsJy8B7tjjpUZK+zH4rvOSk=uTLOHCOy6hk4FkkHXqCzNZU9g@mail.gmail.com>
        <20190430175048.GB16729@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190430175048.GB16729@sigill.intra.peff.net>
Date:   Tue, 30 Apr 2019 20:48:08 +0200
Message-ID: <87sgtzqqhj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 30 2019, Jeff King wrote:

> On Tue, Apr 23, 2019 at 05:08:40PM +0700, Duy Nguyen wrote:
>
>> On Tue, Apr 23, 2019 at 11:45 AM Jeff King <peff@peff.net> wrote:
>> >
>> > On Mon, Apr 22, 2019 at 09:55:38PM -0400, Jeff King wrote:
>> >
>> > > Here are my p5302 numbers on linux.git, by the way.
>> > >
>> > >   Test                                           jk/p5302-repeat-fix
>> > >   ------------------------------------------------------------------
>> > >   5302.2: index-pack 0 threads                   307.04(303.74+3.30)
>> > >   5302.3: index-pack 1 thread                    309.74(306.13+3.56)
>> > >   5302.4: index-pack 2 threads                   177.89(313.73+3.60)
>> > >   5302.5: index-pack 4 threads                   117.14(344.07+4.29)
>> > >   5302.6: index-pack 8 threads                   112.40(607.12+5.80)
>> > >   5302.7: index-pack default number of threads   135.00(322.03+3.74)
>> > >
>> > > which still imply that "4" is a win over "3" ("8" is slightly better
>> > > still in wall-clock time, but the total CPU rises dramatically; that's
>> > > probably because this is a quad-core with hyperthreading, so by that
>> > > point we're just throttling down the CPUs).
>> >
>> > And here's a similar test run on a 20-core Xeon w/ hyperthreading (I
>> > tweaked the test to keep going after eight threads):
>> >
>> > Test                            HEAD
>> > ----------------------------------------------------
>> > 5302.2: index-pack 1 threads    376.88(364.50+11.52)
>> > 5302.3: index-pack 2 threads    228.13(371.21+17.86)
>> > 5302.4: index-pack 4 threads    151.41(387.06+21.12)
>> > 5302.5: index-pack 8 threads    113.68(413.40+25.80)
>> > 5302.6: index-pack 16 threads   100.60(511.85+37.53)
>> > 5302.7: index-pack 32 threads   94.43(623.82+45.70)
>> > 5302.8: index-pack 40 threads   93.64(702.88+47.61)
>> >
>> > I don't think any of this is _particularly_ relevant to your case, but
>> > it really seems to me that the default of capping at 3 threads is too
>> > low.
>>
>> Looking back at the multithread commit, I think the trend was the same
>> and I capped it because the gain was not proportional to the number of
>> cores we threw at index-pack anymore. I would not be opposed to
>> raising the cap though (or maybe just remove it)
>
> I'm not sure what the right cap would be. I don't think it's static;
> we'd want ~4 threads on the top case, and 10-20 on the bottom one.
>
> It does seem like there's an inflection point in the graph at N/2
> threads. But then maybe that's just because these are hyper-threaded
> machines, so "N/2" is the actual number of physical cores, and the
> inflated CPU times above that are just because we can't turbo-boost
> then, so we're actually clocking slower. Multi-threaded profiling and
> measurement is such a mess. :)
>
> So I'd say the right answer is probably either online_cpus() or half
> that. The latter would be more appropriate for the machines I have, but
> I'd worry that it would leave performance on the table for non-intel
> machines.

It would be a nice #leftoverbits project to do this dynamically at
runtime, i.e. hook up the throughput code in progress.c to some new
utility functions where the current code using pthreads would
occasionally stop and try to find some (local) maximum throughput given
N threads.

You could then dynamically save that optimum for next time, or adjust
threading at runtime every X seconds, e.g. on a server with N=24 cores
you might want 24 threads if you have one index-pack, but if you have 24
index-packs you probably don't want each with 24 threads, for a total of
576.
