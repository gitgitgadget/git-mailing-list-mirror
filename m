Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5193C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 21:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhKSVlr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbhKSVlp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 16:41:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6AC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 13:38:43 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id t5so48395891edd.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 13:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bABW+RkaM2DTthVtlgW2JEudtmGgx78sQiZkAOu1ON4=;
        b=L7qfpxClN/OmDtIp7U/jToKUfxfPxKX8rOFbjpayrco8bfBPQ4xcf6ereEan2RTcIY
         ig8wDWZH+TtzKK9nPE5XB/FRy4IHuWsssYg6cjVXt1QY2GbL9SmQd02/sljOCKNcUogA
         tN+Chq9YagXooRoDWURjnGE2rm4spD+6os++pBA7wds7HUAMjuCebiMXgIa9EdgreMls
         XdXnKNd21wBS7R/c5wP3PdlPtLG9AaI6uYfLgsffqf+5DCzKJMVf+69Su20oBEH2he2P
         AISt5ZAOXZbxNVrBU89/0zmHBw3BuwQ9JMc2cUoLVBtw7VNXMuR3GhcztsD1QN8PYxx8
         sFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bABW+RkaM2DTthVtlgW2JEudtmGgx78sQiZkAOu1ON4=;
        b=5ATi9a/Kt8gLuFIV4VvuLR+8TMovPEySHIfSEc9fdfsNjtjtL+3JGY66a+2W9FxROx
         yx3HmjYG6aALYMRcO+e3BREzbnzKAaxPWhrsvfYiLYtTb5UM5RDmMEJf/FFaElsntrRa
         +qEA3zpNd6uD0cLPCs159VY4vo+zb7raQBxFTy5ViYr8DfNECyHj8cQDWcx127NCyYir
         IfG1oMPh6wVBQiYxUQWtuvPR0DHVf7uKwCUUv4mdMou/6BymzGWD/m0qBLmSvh7vBv86
         RGhmkym6p555tHalL9eTNp5ko5tnO93FM8pEscISyvn2Lp+iWfFRVbELfP/m6Wwfr54Q
         Z9xA==
X-Gm-Message-State: AOAM531hL2uaJaKxdOHlN01w+RE7xC4A7r690RMybPeThdGjq6N1yEyB
        MPo7RcjhyUj/aaquCI0DNM4=
X-Google-Smtp-Source: ABdhPJwfYFwdeIHAUSJ6JMg+YdtPW25mOqgNEkEWrqpwFD6AB4nqozFPRcEzf4TwYBuTEMnbrFqjVQ==
X-Received: by 2002:a50:d543:: with SMTP id f3mr28696358edj.56.1637357921614;
        Fri, 19 Nov 2021 13:38:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k16sm447811edq.77.2021.11.19.13.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 13:38:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1moBai-000pGc-2J;
        Fri, 19 Nov 2021 22:38:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] diff histogram: intern strings
Date:   Fri, 19 Nov 2021 22:22:04 +0100
References: <pull.1079.git.1637148025.gitgitgadget@gmail.com>
 <38c771a74d2a348e6a752555f95b746de029b1d7.1637148025.git.gitgitgadget@gmail.com>
 <2b2bd380-540f-959b-b950-cfdc95cbff29@gmail.com>
 <88eaee89-4536-fba4-3aa0-c3693f58eae0@gmail.com>
 <nycvar.QRO.7.76.6.2111181631260.11028@tvgsbejvaqbjf.bet>
 <YZZ0e7CCGW5QbQlW@coredump.intra.peff.net>
 <86d38148-7b97-76aa-148b-346cc179615a@gmail.com>
 <YZe4hqF6Jf14L5tb@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZe4hqF6Jf14L5tb@coredump.intra.peff.net>
Message-ID: <211119.86v90n25cv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Jeff King wrote:

> On Fri, Nov 19, 2021 at 10:05:32AM +0000, Phillip Wood wrote:
>
>> On 18/11/2021 15:42, Jeff King wrote:
>> > On Thu, Nov 18, 2021 at 04:35:48PM +0100, Johannes Schindelin wrote:
>> > 
>> > > I think the really important thing to point out is that
>> > > `xdl_classify_record()` ensures that the `ha` attribute is different for
>> > > different text. AFAIR it even "linearizes" the `ha` values, i.e. they
>> > > won't be all over the place but start at 0 (or 1).
>> > > 
>> > > So no, I'm not worried about collisions. That would be a bug in
>> > > `xdl_classify_record()` and I think we would have caught this bug by now.
>> > 
>> > Ah, thanks for that explanation. That addresses my collision concern from
>> > earlier in the thread completely.
>> 
>> Yes, thanks for clarifying I should have been clearer in my reply to Stolee.
>> The reason I was waffling on about file sizes is that there can only be a
>> collision if there are more than 2^32 unique lines. I think the minimum file
>> size where that happens is just below 10GB when one side of the diff has
>> 2^31 lines and the other has 2^31 + 1 lines and all the lines are unique.
>
> Right, that makes more sense (and we are not likely to lift the 1GB
> limit anytime soon; there are tons of 32-bit variables and potential
> integer overflows all through the xdiff code).

Interestingly:
    
    $ du -sh 8gb*
    8.1G    8gb
    8.1G    8gb.cp
    $ ~/g/git/git -P -c core.bigFileThreshold=10g diff -U0 --no-index --no-color-moved 2gb 2gb.cp
    diff --git a/8gb b/8gb.cp
    index a886cdfe5ce..4965a132d44 100644
    --- a/8gb
    +++ b/8gb.cp
    @@ -17,0 +18 @@ more
    +blah

And the only change I made was:
    
    diff --git a/xdiff-interface.c b/xdiff-interface.c
    index 75b32aef51d..cb8ca5f5d0a 100644
    --- a/xdiff-interface.c
    +++ b/xdiff-interface.c
    @@ -117,9 +117,6 @@ int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t co
            mmfile_t a = *mf1;
            mmfile_t b = *mf2;
     
    -       if (mf1->size > MAX_XDIFF_SIZE || mf2->size > MAX_XDIFF_SIZE)
    -               return -1;
    -
            if (!xecfg->ctxlen && !(xecfg->flags & XDL_EMIT_FUNCCONTEXT))
                    trim_common_tail(&a, &b);

Perhaps we're being overly concervative with these hardcoded limits, at
least on some platforms? This is Linux x86_64.

I understand from skimming the above that it's about the pathological
case, these two files are the same except for a trailer at the end.

I wonder how far you could get with #define int size_t & the like ... :)
