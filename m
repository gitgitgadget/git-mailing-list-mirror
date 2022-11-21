Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ACCC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 13:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKUNc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiKUNcX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 08:32:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F779DBB8
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:32:22 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kt23so28512683ejc.7
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7pZqfOy8e1P++bBzY/v1B9ecZzbszbLcJL35of7dAe8=;
        b=d4Pnw/IvgSuKBqS7E6zV6zu3V4iL1/LZiTinCl3u3b0nZeJdolw1XNV1lxClS8L8ug
         dUDqb5a4H6G/eBIZvS0H7hAeOQekayRCG5ZO2CIVITjIwQcI3ABwlH8iOgEieLw+R0JK
         ErhS0GCXMnJZaQlmohma0Px2vZCIzBOkNraew1aflZaYnHPO6KX6Hc8hUyQF1ZE3nrKg
         3pE/VD72J2Ny9ZPIMoDJ7jmRe8XsW9a+XIrxYeYhZR8qrhjdwBOvJLpU469oXMVQ09KT
         dfbeGIp483Sdnzq/n6aew2iWJ5qj4DMh4ouXACdsQ0upRWGuTrETQYraLtKkHOsl0NB4
         nRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pZqfOy8e1P++bBzY/v1B9ecZzbszbLcJL35of7dAe8=;
        b=OPBJIiUQwVoz2b6ae3CECxkI0igNu0G0zfgtU7P0D/PqEPOIPbNPMlN2OpCsXI5Cq/
         1tKz/olu3ph+bdUhDQewRSadOAclat8NnNJMjPl4XRseaE9wul3XTFna531vDAn+Ien9
         sCw6OQydlmxpar140XbRC1+N4yA5N2qkZLD5TNbvFxhp1d4InZFIL27lipjBOdH1pJW2
         RUIGEffSb605zebjxUdjqJ8cZwYUaKrWEbocY8oq/BO4MJPr13EsfvZZzoftXQeXO0ui
         NhthclCDQbeEDnij2b6u8caGCcEd9ltsDEaACtUxHeLU9JDq87jkjdHncDWE2yv6uRvX
         8t0A==
X-Gm-Message-State: ANoB5pkYMZufgtltP5O3QNH/WKsWgVtjdylhEahlcTWb84nLEqCRR9dW
        H7MeV15FrCuyH2vxVtF2QcY=
X-Google-Smtp-Source: AA0mqf4oNFU3rjD5ioL1cRly8YpnUGgZZhaj/EF2y342+4gakJNKtcAO5Ti8y2rVCBcAmYQzQna+xw==
X-Received: by 2002:a17:906:3e49:b0:7b2:8008:6466 with SMTP id t9-20020a1709063e4900b007b280086466mr1857483eji.347.1669037540955;
        Mon, 21 Nov 2022 05:32:20 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id a18-20020a50ff12000000b00463a83ce063sm5111689edu.96.2022.11.21.05.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:32:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ox6uJ-00092e-30;
        Mon, 21 Nov 2022 14:32:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
Date:   Mon, 21 Nov 2022 14:28:11 +0100
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr>
 <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net>
 <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
Message-ID: <221121.86tu2sbfh8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 20 2022, Eric Sunshine wrote:

> On Tue, Sep 6, 2022 at 7:27 PM Jeff King <peff@peff.net> wrote:
>> I did some timings the other night, and I found something quite curious
>> with the thread stuff.
>>
>> I was quite surprised that it made things slower! It's nice that we're
>> only calling it once per script instead of once per test, but it seems
>> the startup overhead of the script is really high.
>>
>> And since in this mode we're only feeding it one script at a time, I
>> tried reverting the "chainlint.pl: validate test scripts in parallel"
>> commit. And indeed, now things are much faster:
>>
>>   Benchmark 1: make
>>     Time (mean =C2=B1 =CF=83):     61.544 s =C2=B1  3.364 s    [User: 55=
6.486 s, System: 384.001 s]
>>     Range (min =E2=80=A6 max):   57.660 s =E2=80=A6 63.490 s    3 runs
>>
>> And you can see the same thing just running chainlint by itself:
>>
>>   $ time perl chainlint.pl /dev/null
>>   real  0m0.069s
>>   user  0m0.042s
>>   sys   0m0.020s
>>
>>   $ git revert HEAD^{/validate.test.scripts.in.parallel}
>>   $ time perl chainlint.pl /dev/null
>>   real  0m0.014s
>>   user  0m0.010s
>>   sys   0m0.004s
>>
>> I didn't track down the source of the slowness. Maybe it's loading extra
>> modules, or maybe it's opening /proc/cpuinfo, or maybe it's the thread
>> setup. But it's a surprising slowdown.
>
> It is surprising, and unfortunate. Ditching "ithreads" would probably
> be a good idea. (more on that below)
>
>> Now of course your intent is to do a single repo-wide invocation. And
>> that is indeed a bit faster. Here it is without the parallel code:
>>
>>   Benchmark 1: make
>>     Time (mean =C2=B1 =CF=83):     61.727 s =C2=B1  2.140 s    [User: 50=
7.712 s, System: 377.753 s]
>>     Range (min =E2=80=A6 max):   59.259 s =E2=80=A6 63.074 s    3 runs
>>
>> The wall-clock time didn't improve much, but the CPU time did. Restoring
>> the parallel code does improve the wall-clock time a bit, but at the
>> cost of some extra CPU:
>>
>>   Benchmark 1: make
>>     Time (mean =C2=B1 =CF=83):     59.029 s =C2=B1  2.851 s    [User: 51=
5.690 s, System: 380.369 s]
>>     Range (min =E2=80=A6 max):   55.736 s =E2=80=A6 60.693 s    3 runs
>>
>> which makes sense. If I do a with/without of just "make test-chainlint",
>> the parallelism is buying a few seconds of wall-clock:
>>
>>   Benchmark 1: make test-chainlint
>>     Time (mean =C2=B1 =CF=83):     900.1 ms =C2=B1 102.9 ms    [User: 12=
049.8 ms, System: 79.7 ms]
>>     Range (min =E2=80=A6 max):   704.2 ms =E2=80=A6 994.4 ms    10 runs
>>
>>   Benchmark 1: make test-chainlint
>>     Time (mean =C2=B1 =CF=83):      3.778 s =C2=B1  0.042 s    [User: 3.=
756 s, System: 0.023 s]
>>     Range (min =E2=80=A6 max):    3.706 s =E2=80=A6  3.833 s    10 runs
>>
>> I'm not sure what it all means. For Linux, I think I'd be just as happy
>> with a single non-parallelized test-chainlint run for each file. But
>> maybe on Windows the startup overhead is worse? OTOH, the whole test run
>> is so much worse there. One process per script is not going to be that
>> much in relative terms either way.
>
> Somehow Windows manages to be unbelievably slow no matter what. I
> mentioned elsewhere (after you sent this) that I tested on a five or
> six year old 8-core dual-boot machine. Booted to Linux, running a
> single chainlint.pl invocation using all 8 cores to check all scripts
> in the project took under 1 second walltime. The same machine booted
> to Windows using all 8 cores took just under two minutes(!) walltime
> for the single Perl invocation to check all scripts in the project.
>
> So, at this point, I have no hope for making linting fast on Windows;
> it seems to be a lost cause.

I'd be really interested in seeing e.g. the NYTProf output for that run,
compared with that on *nix (if you could upload the HTML versions of
both somewhere, even better).

Maybe "chainlint.pl" is doing something odd, but this goes against the
usual wisdom about what is and isn't slow in Perl on windows, as I
understand it.

I.e. process star-up etc. is slow there, and I/O's a bit slower, but
once you're started up and e.g. slurping up all of those files & parsing
them you're just running "perl-native" code.

Which shouldn't be much slower at all. A perl compiled with ithreads is
(last I checked) around 10-20% slower, and the Windows version is always
compiled with that (it's needed for "fork" emulation).

But most *nix versions are compiled with that too, and certainly the one
you're using with "threads", so that's not the difference.

So I suspect something odd's going on...

>> And if we did cache the results and avoid extra invocations via "make",
>> then we'd want all the parallelism to move to there anyway.
>>
>> Maybe that gives you more food for thought about whether perl's "use
>> threads" is worth having.
>
> I'm not especially happy about the significant overhead of "ithreads";
> on my (old) machine, although it does improve perceived time
> significantly, it eats up quite a bit of additional user-time. As
> such, I would not be unhappy to see "ithreads" go away, especially
> since fast linting on Windows seems unattainable (at least with Perl).
>
> Overall, I think =C3=86var's plan to parallelize linting via "make" is
> probably the way to go.

Yeah, but that seems to me to be orthagonal to why it's this slow on
Windows, and if it is that wouldn't help much, except for incremental
re-runs.
