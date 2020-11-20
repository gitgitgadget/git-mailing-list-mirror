Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B2C63777
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 12:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F762100A
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 12:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5Iy+iPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKTMKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 07:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgKTMKT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 07:10:19 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0064C0617A7
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 04:10:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bo9so6793827ejb.13
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=OWtWX40Su5oQmeOGqLI3rfdaH6PZCUN5rwBYio3fnYQ=;
        b=p5Iy+iPZVo/O7wBVAAdzUZGOuHaPWDOmVEam+oYfyFzPItpviYrLlfuUL1ghXYTrGK
         1E/eD5RXoMlxVeP3Yvkihr0gHnVNf487Z8kwY0eR8u4CuOFuYQhZfcRviWZGnPdKRjI3
         H+NFhYMD13lsnu2T7+ndKk7ysBU1TI5ubCrHxDS6y912eTMokJNjv/+C1UUQbkXUULjm
         LEa+ilnjedPsuV0eG9GBXjBiNznL3XstgWcp+txxsZ2i8rQ6Mq1SKxPEYnX9iVNe/oUT
         PEgvt3AK3hfofZRCzTMxTBPXSZU4AiFi5JPII4r0SkA/fdszOAahwxzpXopmV1z+upuq
         wnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=OWtWX40Su5oQmeOGqLI3rfdaH6PZCUN5rwBYio3fnYQ=;
        b=a6X2Ah4KTS8VYuFX1B1Xiol/7w1S2P6V11ZrniIOGvFrgg+pnRv1EJ0epQDxl6eBjI
         uQH8elR5EftveIAiRkz7a9qskPvWkW2psOv1iSRTVoDdNMEvDo9TpJIxM7ra/D0j/nW8
         4rA/YuYh59Kw+YUM1uKArmoYmpeouPJ7g7Sltk0jdTsNcI1z0Ekf7/YnLo6QGxjkSl4d
         /OFukC6/i03uqKslHzxAXiEWHgzEn2fNGzv/0wMAcLbKmd1NzMQzqHwRNxbCgif/Qa1M
         TP22WhE9u9xiIxNlWoAly0Zbko7z7LuETtVV+k100cCT+ihVzapFObktOqNOqfvlkAPb
         0iLA==
X-Gm-Message-State: AOAM5315FazGwtB0mo4RDeL0WrieXgnucPWH4nZV/rPGxBApNsPkHYyl
        K7UF8wtgeCc8N21II6ju0W5giOoEzcBBFw==
X-Google-Smtp-Source: ABdhPJxLGO1BylayYT97D0ZjYTerrUTPsfV6FWdmB+WtUIc7Jb2ePvBr7bs4SRt7ITEsX1BC7S3HtA==
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr10073620ejc.453.1605874217612;
        Fri, 20 Nov 2020 04:10:17 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id k23sm1033503ejs.100.2020.11.20.04.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 04:10:16 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, gerardu@amazon.com,
        git@vger.kernel.org
Subject: Re: RFC: auto-enabling parallel-checkout on NFS
References: <9c999e38-34db-84bb-3a91-ae2a62b964b5@jeffhostetler.com> <20201119040117.67914-1-matheus.bernardino@usp.br> <212a2def-6811-b6e4-0550-ecae2fe0c02c@jeffhostetler.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <212a2def-6811-b6e4-0550-ecae2fe0c02c@jeffhostetler.com>
Date:   Fri, 20 Nov 2020 13:10:15 +0100
Message-ID: <87mtzcp6u0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 19 2020, Jeff Hostetler wrote:

> On 11/18/20 11:01 PM, Matheus Tavares wrote:
>> Hi, Jeff
>>
>> On Mon, Nov 16, 2020 at 12:19 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>>
>>> I can't really speak to NFS performance, but I have to wonder if there's
>>> not something else affecting the results -- 4 and/or 8 core results are
>>> better than 16+ results in some columns.  And we get diminishing returns
>>> after ~16.
>>
>> Yeah, that's a good point. I'm not sure yet what's causing the
>> diminishing returns, but Geert and I are investigating. Maybe we are
>> hitting some limit for parallelism in this scenario.
>
> I seem to recall back when I was working on this problem that
> the unzip of each blob was a major pain point.  Combine this
> long delta-chains and each worker would need multiple rounds of
> read/memmap, unzip, and de-delta before it had the complete blob
> and could then smudge and write.
>
> This makes me wonder if repacking the repo with shorter delta-chains
> affects the checkout times.  And improves the perf when there are
> more workers.  I'm not saying that this is a solution, but rather
> an experiment to see if it changes anything and maybe adjust our
> focus.

I've had part success with "git gc --keep-largest-pack" /
gc.bigPackThreshold=N where N is at least the size you get from a fresh
"git clone" when on NFS.

It has the effect of essentially implementing a version of what you're
suggesting, but in an arguably better way. Your initial clone will have
whatever depth of chains you have, but all new objects pulled down will
go into new packs/objects that won't share chains with that old big
pack.

So your repository will be bigger overall, but your old/new pack/pack(s)
will eventually come to mostly reflect a cold/hot object storage. So
what you need from a pack is more likely to already have been fetched
into the FS cache, and over an NFS mount those requests may have been
pre-fetched/fetched already. You can also more effectively warm the
local OS cache by cat-ing >/dev/null the pack-files that aren't the big
large pack on-login or whatever.

>>
>>> I'm wondering if during these test runs, you were IO vs CPU bound and if
>>> VM was a problem.
>>
>> I would say we are more IO bound during these tests. While a sequential
>> linux-v5.8 checkout usually uses 100% of one core in my laptop's SSD,
>> in this setup, it only used 5% to 10%. And even with 64 workers (on a
>> single core), CPU usage stays around 60% most of the time.
>>
>> About memory, the peak PSS was around 1.75GB, with 64 workers, and the
>> machine has 10GB of RAM. But are there other numbers that I should keep
>> an eye on while running the test?
>>
>>> I'm wondering if setting thread affinity would help here.
>>
>> Hmm, I only had one core online during the benchmark, so I think thread
>> affinity wouldn't impact the runtime.
>
> I wasn't really thinking about the 64 workers on 1 core case.  I was
> more thinking about the 64 workers on 64 cores case and wondering
> if workers were being randomly bounced from core to core and we were
> thrashing.
