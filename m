Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87A0C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 14:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiKUOUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 09:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiKUOUd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 09:20:33 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C960BFD2B
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:20:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt23so28845190ejc.7
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 06:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZunP0ODpzQFZbWVhm/IaO6ibmXPNGIC2G80y8bButM4=;
        b=HZH/ATYDjMJQTpRyoxhF9U9/QB4XFjvvxp0faTouRQTPrZoekiVSGZi/Lo/JhTpXDb
         ikQSk3nL/bTTS+YVKITf1JU7ZEpAtpu/3Sy2MRIGdhF0XB+VOGuEoHLLYyUTBSSaxEDn
         7dagtS9DwU6B/IeCvdJg1rOHxtFJ3reGtbq5BM4Zto62shaDNO8tGeGV0MlER8kZva+8
         lIh6UIlfgRuYjqBbPjFZwK5za5xN5s4ycYeKOLZEmUuwFE6A57jIJCXS2L47oKvw+LgS
         Qh9sogQSRm8PTAGtn5GNbjrs8keIEUATK/l+mYQXybemPEevEhMjYOnJAP85fVLbBvW9
         eDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZunP0ODpzQFZbWVhm/IaO6ibmXPNGIC2G80y8bButM4=;
        b=oleTh0VUGqlMl3rVjIVxddu7QKJS2VeQSIQa2SabNa2qNd1n8E6YEvf2khSVU0sCr2
         AI6U82GIu1G3A/MSLy/3zOakS6hAOrbpj3JGZj0wVcE1+iI4IMCNNABhe7R6pBEEnZZR
         CdpplN1yq1sJjmGMM9H/NY4lejLWj5qPYZfTZjUUL0oXb29yH3r1OrDNLWVmQew/+sZf
         qi1S8AmlRW7ZbKSBEQtiMPIMhUZEh0odEIxLUAdQzIgjlikqhX9G8/kAG+7tdVdi/lBU
         /y2l78jl8qe1g0XiP6pynIJPNxqs2P3p5DXmnM+jZzB4iAfvi4EBEPIB8GrCwswITwLx
         wsiQ==
X-Gm-Message-State: ANoB5plZ7RumqFD/fqhsscjYedrZ2VTCBVJ/OIZjdkJIRHWNMx371ZMr
        Grs+vprC48pYTJ3fxlrxOr6XAJ7HRxpKIw==
X-Google-Smtp-Source: AA0mqf4M6mNm6Mcgh6BHAK9Fj8YHYTiLfZusfSxbRbjYP6bsUOh0GDD70SsxMSjgN/gNDhWnaLzDpQ==
X-Received: by 2002:a17:906:6bd8:b0:78b:a8d:e76a with SMTP id t24-20020a1709066bd800b0078b0a8de76amr16023650ejs.725.1669040427771;
        Mon, 21 Nov 2022 06:20:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id hf12-20020a1709072c4c00b007ae38d837c5sm5102120ejc.174.2022.11.21.06.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 06:20:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ox7es-000Axr-25;
        Mon, 21 Nov 2022 15:20:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
Date:   Mon, 21 Nov 2022 15:18:49 +0100
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr>
 <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net>
 <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
 <221121.86tu2sbfh8.gmgdl@evledraar.gmail.com>
 <CAPig+cS3Ui=SFuRLPKKugT9RFvtUV3FmO23Wse_Rhih5hgbPmg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cS3Ui=SFuRLPKKugT9RFvtUV3FmO23Wse_Rhih5hgbPmg@mail.gmail.com>
Message-ID: <221121.86leo4bd91.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 21 2022, Eric Sunshine wrote:

> On Mon, Nov 21, 2022 at 8:32 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> On Sun, Nov 20 2022, Eric Sunshine wrote:
>> > Somehow Windows manages to be unbelievably slow no matter what. I
>> > mentioned elsewhere (after you sent this) that I tested on a five or
>> > six year old 8-core dual-boot machine. Booted to Linux, running a
>> > single chainlint.pl invocation using all 8 cores to check all scripts
>> > in the project took under 1 second walltime. The same machine booted
>> > to Windows using all 8 cores took just under two minutes(!) walltime
>> > for the single Perl invocation to check all scripts in the project.
>>
>> I'd be really interested in seeing e.g. the NYTProf output for that run,
>> compared with that on *nix (if you could upload the HTML versions of
>> both somewhere, even better).
>
> Unfortunately, I no longer have access to that machine, or usable
> Windows in general. Of course, someone else with access to a dual-boot
> machine could generate such a report, but whether anyone will offer to
> do so is a different matter.

:(

>> Maybe "chainlint.pl" is doing something odd, but this goes against the
>> usual wisdom about what is and isn't slow in Perl on windows, as I
>> understand it.
>>
>> I.e. process star-up etc. is slow there, and I/O's a bit slower, but
>> once you're started up and e.g. slurping up all of those files & parsing
>> them you're just running "perl-native" code.
>>
>> Which shouldn't be much slower at all. A perl compiled with ithreads is
>> (last I checked) around 10-20% slower, and the Windows version is always
>> compiled with that (it's needed for "fork" emulation).
>>
>> But most *nix versions are compiled with that too, and certainly the one
>> you're using with "threads", so that's not the difference.
>>
>> So I suspect something odd's going on...
>
> This is all my understanding, as well, which is why I was so surprised
> by the difference in speed. Aside from suspecting Windows I/O as the
> culprit, another obvious possible culprit would be whatever
> mechanism/primitives "ithreads" is using on Windows for
> locking/synchronizing and passing messages between threads. I wouldn't
> be surprised to learn that those mechanisms/primitives have very high
> overhead on that platform.

Yeah, that could be, but then...

>> > Overall, I think =C3=86var's plan to parallelize linting via "make" is
>> > probably the way to go.
>>
>> Yeah, but that seems to me to be orthagonal to why it's this slow on
>> Windows, and if it is that wouldn't help much, except for incremental
>> re-runs.
>
> Oh, I didn't at all mean that `make` parallelism would be helpful on
> Windows; I can't imagine that it ever would be (though I could once
> again be wrong). What I meant was that `make` parallelism would be a
> nice improvement and simplification (of sorts), in general,
> considering that I've given up hope of ever seeing linting be speedy
> on Windows.

...that parallelism probably wouldn't be helpful, as it'll run into
another thing that's slow.

But just ditching the "ithreads" commit from chainlint.pl should make it
much faster, as sequentially parsing all the files isn't that slow, and
as that won't use threads should be much faster then.

