Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCFCC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 11:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiCILkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiCILke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 06:40:34 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDDB49F3A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 03:39:31 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bi12so4346412ejb.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 03:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=d67r4wr3Zvvxj15jbyrqLqgNjLkoYozuOoYUaJwKf+I=;
        b=M4Sk4/34d2KTS0EDpnLjiE0MpEY5XAMTyW3TIUIo8lMyJiFzQRVI4+eT5Uw3+xUu7l
         N1bN4yjOepDmy9nmCu0PwLUByaVdZ2apu3tLYXN65xfY/aUdOipH4Jc1rDbzFnOaMk6I
         aUIVnF5uFWNCIguQY3eg/xiCA/3dG52xgPUiHOQjuY2cVCNVYZ7x+Iu/o6ZBADvpSfo4
         yAXRN16AWolJxBf/CVViyTG71O88JvwkhHvdC7tBDiZKFYK9i+FP6yVRqbYghabJRTN/
         QlK/Z4a2+I7FG36+GgrpTCnoXjYMSG7gEhNqORYDppWA0PhQPtydcovSgmxUBXMR1NeR
         kR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=d67r4wr3Zvvxj15jbyrqLqgNjLkoYozuOoYUaJwKf+I=;
        b=3415Z5YMEB4JK2DdUt1PInWkXB/1SFEBahAQxr9wpFPzQkMLqB+SVCJtlJd0UYVW5g
         5l6exsQiyBDERFbkgTSimut8GSjooeIh1mgeD8CAMAfJIX9cEUpXC7vhA4mNgV7PNzPX
         VtVKmcpfELEoDXUbXT0W+cuyxQqu7fKvWh8LTYGdhdS05L0U+xdNBdW0aQOBBI7z4wbr
         pCN3j+ApjDOSXrySMiE9p1TPOyr6gIsir6kLKGRrdv0xRrhWZTJMFg66Bmd/JegdTYHX
         NkQUAZJAhSnODpVmUs0BflyzQzNnwZRXaJ+oURUXSSoCHqADgyqb0bRr7Pr5m0mVn1sK
         Mq5w==
X-Gm-Message-State: AOAM531XDvEBeJdz219l7BkJg01+wU/OCE2Rm6BmJ6+tVbASI8iTCOMg
        BchkpVLgdBeHpka9e+3naqc=
X-Google-Smtp-Source: ABdhPJzol6dfFSXKd6ET7l11jMJ0RQGoKqCr0kZ4VITLOvXQ/8IPJPV9eBQ9qQx5dSMVthFVMlqzlg==
X-Received: by 2002:a17:907:72d0:b0:6db:4788:66a9 with SMTP id du16-20020a17090772d000b006db478866a9mr7623133ejc.516.1646825970044;
        Wed, 09 Mar 2022 03:39:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090631c700b006b293ddbca1sm621602ejf.35.2022.03.09.03.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 03:39:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRufA-0008QH-OY;
        Wed, 09 Mar 2022 12:39:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Wed, 09 Mar 2022 11:56:41 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
 <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2203071655070.11118@tvgsbejvaqbjf.bet>
 <220307.86tuc9yc4b.gmgdl@evledraar.gmail.com> <xmqqtuc9sm09.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqtuc9sm09.fsf@gitster.g>
Message-ID: <220309.861qzbnymn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think that's a rather strange conclusion given that I've submitted a
>> parallel series that makes some of those failures easier to diagnose
>> than the same changes in this series. I.e. the failures in build
>> v.s. test phases, not the individual test format output (but those are
>> orthagonal).
>
> If you have a counter-proposal that you feel is solid enough, I do
> not mind dropping the topic in question and replacing it with the
> counter-proposal to let people see how it fares for a few days.  If
> it allows others to view the output easily if you revert the merge
> of this topic into 'seen' and replace with the counter-proposal and
> push it to your own repository, that would be an even better way to
> highlight the differences of two approaches, as that would allow us
> to see the same failures side-by-side.

I proposed [1] as a counter-proposal to *part of* this series, which has
various UX comparisons.

Note that it doesn't aim to change the test failure output
significantly, but to structurally simplify .github/workflows/main.yml
and ci/ for a significant line-count reduction, and improve part of the
output that we get for "make" v.s. "make test", and to make it obvious
what the parameters of each step are.

Which is partially overlapping with 1/2 of Johannes's series here, I
think it makes sense to split up those two concerns & address this more
incrementally.

I.e. my series shows that you can get what the first half of this series
proposes to do by adding GitHub-specific output to ci/* without any such
CI-backend-specific output, and the resulting presentation in the UX is
better.

It'll still apply to "master" with this topic ejected, there was a minor
comment (needing commit message rephrasing) from SZEDER G=C3=A1bor on it, I
could re-roll it if you're interested.

> Am I correct to understand that one of the the common goals here is
> to eliminate the need to discover how to get to the first failure
> output without turning it slow by 10x to load the output?

That's definitely an eventual common goal, I have a POC for how to do
that with an alternate approach that doesn't suffer from that slowdown,
and shows you much more targeted failure output (only the specific tests
that failed) at [2].

I just think it makes sense to split up the concerns how we arrange
.github/workflows/main.yml & ci/* and how doing that differently can
improve the CI UX, v.s. the mostly orthagonal concern of how test-lib.sh
+ prove can best summarize their failure output.

>> I think it's clear that we're going to disagree on this point, but I'd
>> still think that:
>>
>>  * In a re-roll, you should amend these patches to clearly note that's a
>>    UX trade-off you're making, perhaps with rough before/after timings
>>    similar to the ones I've posted.
>>
>>    I.e. now those patches say nothing about the UX change resulting in
>>    UX that's *much* slower than before. Clearly noting that trade-off
>>    for reviewers is not the same as saying the trade-off can't be made.
>
> Whether we perform counter-proposal comparison or not, the above is
> a reasonable thing to ask.
>
>>  * I don't see why the changes here can't be made configurable (and
>>    perhaps you'd argue they should be on by default) via the ci-config
>>    phase.
>
> I do not know if such a knob is feasible, though.

It would be rather trivial. Basically a matter of adding a "if:
needs.ci-config.outputs.style =3D=3D 'basic'" to ci/print-test-failures.sh,
and a corresponding flag passed down to ci/lib.sh to have it invoke
test-lib.sh with --github-workflow-markup or not.

I.e. this series detects it's running in GitHub CI and optionally tells
test-lib.sh to emit different output, so to get the old output you'd
just need to not opt-in to that.

I think we can have our cake and eat it too though, so I don't think
there's any point in such a knob per-se. The only reason I'm suggesting
it is because Johannes doesn't otherwise seem to want to address the
significant CI UX slowdowns in this series.

I do think the approach taken by this series is inherently limited in
solving that problem though, in a way that the approach outlined in [2]
isn't.

I.e. the problem is that we're throwing say ~30k-90k lines of raw CI
output at some GitHub JavaScript to format and present. Your browser
needs to download all the output, and then the browser needs to spin at
100% CPU to present it to you.

The reason for that is that anything that tweaks the test-lib.sh output
is something you need to consume *in its entirety*. I.e. when you have a
sequence like:

    ok 1 test one
    ok 2 test two
    not ok 3 test three
    1..3

You don't know until the third test that you've had a failure. Short of
teaching test-lib.sh even more complexity (e.g. pre-buffering its
"passing" output) a UX layer needs to present all of it, and won't
benefit from a parsed representation of it.

Which is why I think adding other output formatters to test-lib.sh is a
dead end approach to this problem.

I mean, sure we could start parsing the new output emitted here, but
that doesn't make sense either.

We already run a full TAP parser over the output of the entire test
suite, which we can easily use to only print details about those tests
that failed[2]. We could also still have the full & raw output, but that
could be in some other tab (or "stage", just like
"ci/print-test-failures.sh" is now.

To be fair that isn't quite as trivial in terms of patch count. In
particular we have edge cases currently where the TAP output isn't valid
due to bugs in test-lib.sh and/or tests, and can't combine it with the
--verbose output. The demo at [2] is on top of some patches I've got
locally to fix all of that.

But I really think it's worth it to move a bit slower there & get it
right rather than heading down the wrong direction of having another
not-quite-machine-readable output target.

I.e. once it's machine readable & parsed we can present it however we
like, and can do *much better* output such as correlating trace output
to the test source, and e.g. showing what specific line we failed
on. Right now all of that needs to be eyeballed & inferred from the
"--verbose -x" output (which is often non-obvious & a pain, especially
when the "test_expect_success" block calls helper functions).

1. https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-ava=
rab@gmail.com/
2. https://lore.kernel.org/git/220302.86mti87cj2.gmgdl@evledraar.gmail.com/
