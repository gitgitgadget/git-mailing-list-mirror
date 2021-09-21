Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA366C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CB360F48
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 23:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhIUXIC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 19:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhIUXIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 19:08:01 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD47BC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:06:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id h17so2466877edj.6
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 16:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1qqTDPn5M4FIkdbVw/fxWHIsthETtiYf9aku2pJV2yc=;
        b=pXYyRZtUGSYDhOMlF6bOQWTFLjVrPEsvai74aEUaA7707oy0wl/Acz0cZAr/2VSE66
         ERJmQQWc3Cqwx4G7JUOvdYsYMtzOuFKGSIiPc4H/9YaXEMwQkf0iOW/e9h7p7oVxHVPA
         WEWcz4UJuxo88NWOHeujUmhB6zLb6iU/yZ16d1a0A1uGZBaJfBalQgOBjjpnVyIMqBbQ
         Xi7M3v4dmogJ+GjUZTzWLZ2YRoi93gKiB0tcYdZz+DwblechAHbVg0zhK8wd1Bb7U2IG
         ft/Iy0akttrWA/5N3/QXgbQaRRfoDilEVVMp4iknBB3FgYxITbSRb0s5pb1/q5wnmY7P
         UxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1qqTDPn5M4FIkdbVw/fxWHIsthETtiYf9aku2pJV2yc=;
        b=Dt6JZikL3/hlapVtCsfZHwijWl2alI1MjRQdlZf/A/iLlsl/y11gMdyS6Ts55McRJX
         jqu3/0XGLk0Z5TrW9F3zSdmomfQ6e+It/TFIr25lGaHPlRGCmVLccj1TWSbo/1ACaLc5
         ne324GcsmRVJPtlAlsEJfSMRc1CyddxI8sV1v2Dxl1SlAZ7IoV8HUHC9/+LyDnqrDQwb
         x4Jz6HoPcOItE1MIdaQBrW4jEtKvKxf0c8WZeRmAtEzXCGHJHv3JTGdnYQ+07Ojlct8H
         Yoxn/jW10SVQ0+5TTkcQULzWE+4K8t9I/usXEkuyADzzUe0IznMrqSJKuLrFKmy8KSen
         9Jog==
X-Gm-Message-State: AOAM531yRrsrH8Zu1nwO6o1uE4/nsxQC0EA5gKPH6Hs1P5ki0CJ84QBy
        7xOwtdFedJXV3e3hAvKIJOgmW29y9fIv6Q==
X-Google-Smtp-Source: ABdhPJxJbBo7c2X1wY9X6R6tStYOEItyFH4LNp52ln/Jn+/LA2ofSINoMEd5FemIqXpK6VnA5M6YRQ==
X-Received: by 2002:a50:d0d1:: with SMTP id g17mr39292211edf.96.1632265590740;
        Tue, 21 Sep 2021 16:06:30 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cn8sm146147edb.77.2021.09.21.16.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 16:06:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH 0/2] Squash leaks in t0000
Date:   Wed, 22 Sep 2021 01:01:55 +0200
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <xmqq4kafcesa.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq4kafcesa.fsf@gitster.g>
Message-ID: <87r1dh8r62.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 20 2021, Junio C Hamano wrote:

> "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Carlo points out that t0000 currently doesn't pass with leak-checking
>> enabled in:
>> https://public-inbox.org/git/CAPUEsphMUNYRACmK-nksotP1RrMn09mNGFdEHLLuNEWH4AcU7Q@mail.gmail.com/T/#m7e40220195d98aee4be7e8593d30094b88a6ee71
>>
>> Here's a series that I've sat on for a while, which adds some UNLEAK's to
>> "fix" this situation - see the individual patches for a justification of why
>> an UNLEAK seems appropriate.
>
> It seems that discussion on 1/2 seemed to be heading in an
> improvement but has petered out?  
>
> I think the simplest fix in these two patches are worth taking, even
> if we plan to further improve either by refining the granularity of
> UNLEAK application or by introducing repo_clear_revisions() as Carlo
> mentions (which is a preferred way to do this if we can manage it),
> on top.

I think per Andrzej's own [1] it's best to not pick up this series.

I've got a lot of memory leak fixes queued up locally, I'm just waiting
on the SANITIZE=leak CI mode to land on master so I can add new tests to
the whitelist as I fix the memory leaks, that includes "real" fixes for
the ones Andrzej's added "UNLEAK()"'s for here.

Hence my meniton of this sort of thing being counter-productive[2],
i.e. I'd need to monkeypatch revert this on top just to make sure I was
still finding leaks that are hidden by these new UNLEAK() (which hide
some really common ones).

1. https://lore.kernel.org/git/05754f9c-cd58-30f5-e2d3-58b9221d2770@ahunt.org/
2. https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/
