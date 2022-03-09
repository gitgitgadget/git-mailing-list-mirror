Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DE8C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 20:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiCIUE4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbiCIUEz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 15:04:55 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FB3DFEE
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 12:03:55 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gb39so7523108ejc.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 12:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=c5ye8gAaYoceCsffTCSI52Ul0Kyb1WPH2uE7EEaFfjI=;
        b=Rr+c1xwENS5H9w1SX9xJe4do98nxB4Eb3OcEpl5Ut1xVh5/33IVD0gT4QcWrioyt3s
         TfdVAx8U/GCxrnhWsnHnGNDDIOdzsbGqUDmK/Yj8pHIZQyRCYvu/2UVUoe2qM5EZNHTa
         XMIvkuY2gmfhWOEzRJZgQ/ml2GLRS/1cS0HhMy8BDsPYA12mTYOsr6pijIUz4atJLiQA
         wh5aVVyubtp15pnrOrA7Xyp/CFkWBaH6zFW1AcPnwxoOYtiJN0z+h1gUQnKsFRrYpRix
         0IfTPcqruOcxuYXcMhlcCDctCjhmEpGO9c65vG8qa83UKzc+g6wFhGsGuX1B7MmyAf77
         tgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=c5ye8gAaYoceCsffTCSI52Ul0Kyb1WPH2uE7EEaFfjI=;
        b=fiPexMww4qb8vunV3zVglQySFHno58PwPJCKRYjUjmugkFqyjls79t8YbOsPLqspIg
         APQGAzIukU79aFZ3LUQkNPENBRGYndoVxIDbWz0aXrX728fKDY9amkgh4jpE8IyzDRlF
         tOheHwQbe6hzPbdEZMyeipcOldSATL4N8TYK3YtF7DeHz22fr9PqX6Wk/GfVOYboIlBZ
         S4xjQPZhbTwJGMzuiWoxU/jrXUOq+Aok7PLc/tn/RKL3f+FVFwOIqv9NGX8nfJUtpE1O
         C292URBZbVfkEZdqLLmOSrBqje3tTSMUznZO6TTUnSZHvTqLFNu4UAKN4j5kcvElgJEh
         TV0A==
X-Gm-Message-State: AOAM53357xMZqXOVIEN7kBXI9nUHxs/XObmSMPAXFqOe+37DMTtrq9qB
        73aX0q5FfA1Q56xsCjQsFTg=
X-Google-Smtp-Source: ABdhPJy/6eWLaKkWk0wWMmnWtvTX8Dve5od5W36Rsr0L//fwmdy6mD2X4rSP/rWL6S73P9fhVunRrQ==
X-Received: by 2002:a17:907:7fa6:b0:6db:6e1b:c467 with SMTP id qk38-20020a1709077fa600b006db6e1bc467mr1331551ejc.552.1646856233776;
        Wed, 09 Mar 2022 12:03:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ec21-20020a170906b6d500b006d170a3444csm1090749ejb.164.2022.03.09.12.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 12:03:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nS2XI-000Ecf-Fc;
        Wed, 09 Mar 2022 21:03:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Wed, 09 Mar 2022 20:47:40 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
 <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2203071655070.11118@tvgsbejvaqbjf.bet>
 <220307.86tuc9yc4b.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2203091404470.357@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2203091404470.357@tvgsbejvaqbjf.bet>
Message-ID: <220309.86tuc6lwpj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 09 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Mon, 7 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Mar 07 2022, Johannes Schindelin wrote:
>>
>> > On Wed, 2 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> >
>> >>
>> >> On Tue, Mar 01 2022, Johannes Schindelin via GitGitGadget wrote:
>> >>
>> >> > Changes since v1:
>> >> >
>> >> >  * In the patch that removed MAKE_TARGETS, a stale comment about th=
at
>> >> >    variable is also removed.
>> >> >  * The comment about set -x has been adjusted because it no longer =
applies
>> >> >    as-is.
>> >> >  * The commit message of "ci: make it easier to find failed tests' =
logs in
>> >> >    the GitHub workflow" has been adjusted to motivate the improveme=
nt
>> >> >    better.
>> >>
>> >> Just briefly: Much of the feedback I had on v1 is still unanswered,
>> >
>> > Yes, because I got the sense that your feedback ignores the goal of ma=
king
>> > it easier to diagnose test failures.
>>
>> I think that's a rather strange conclusion given that I've submitted a
>> parallel series that makes some of those failures easier to diagnose
>> than the same changes in this series. I.e. the failures in build
>> v.s. test phases, not the individual test format output (but those are
>> orthagonal).
>
> I do not know what your parallel series implements, as I did not have the
> time to read it yet (and it contains about double the number of patches of
> my series, hopefully not intended to make it impossible for me to spare
> the time to even taking a glimpse at it).

No, I'm not arranging patches in such a way as to make them harder for
you to review specifically. I thought those changes made sense as a
logical progression.

> Also: I thought we had the rule of trying to be mindful of other
> contributors and avoid interfering with patch series that are in flight?
> It could be viewed as unnecessarily adversarial.

You don't need to look at the whole thing, but in
https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab=
@gmail.com/
scroll down to "The following compares CI output" and compare:

  master: https://github.com/avar/git/runs/5274251909?check_suite_focus=3Dt=
rue
  this: https://github.com/avar/git/runs/5274464670?check_suite_focus=3Dtrue
  js: https://github.com/avar/git/runs/5272239403?check_suite_focus=3Dtrue

I.e. for the build v.s. test "grouping" you're doing early in your
series we can get the same with a significantly negative instead of
positive diffstat to .github & ci/, and it frees up the "nested groups"
that you note as a limitation in your 4/9 with another potential group
level (your 4/9:
https://lore.kernel.org/git/9333ba781b8240f704e739b00d274f8c3d887e39.164305=
0574.git.gitgitgadget@gmail.com/)

So it's not meant to be adversarial, but to help out this topic at large
by showing that a constraint you ran up against is something we don't
need to be limited by, and it makes that part of the CI output better.

I think posting working code to demonstrate that we can indeed do that
is the most productive thing to do, talk being cheap & all that.

So yes, I agree that in general it's better to avoid conflicting topics
etc., but in a case where a topic proposes to add a significant amount
of code & complexity to get to some desired end-state, it makes sense to
demonstrate with a patch or patches that we can get to the same
end-state in some simpler way.

>> I think it's a fair summary of our differences that we're just placing
>> different values on UX responsiveness. I'm pretty sure there's some
>> amount of UX slowdown you'd consider unacceptable, no matter how much
>> the output was improved.
>>
>> Clearly we just use it differently.
>
> I would gladly trade my convenience in return for making it easier for
> others to diagnose why their PR builds fail.
>
> At the moment, the way our CI/PR builds present test failures very likely
> makes every new contributor feel stupid for not knowing how to proceed.
> But they are not stupid. The failure is not theirs. The fault lies
> squarely with us, for making it so frigging hard.

I agree with you that it's relatively bad & could be improved. I don't
have much issue with the end result we're left with once the page
actually loads at the end of this series, just the practicalities of how
slow the resulting UX is.

>> >> or in the case of the performance issues I think just saying that this
>> >> output is aimed at non-long-time-contributors doesn't really justify =
the
>> >> large observed slowdowns.
>> >
>> > What good is a quickly-loading web site when it is less than useful?
>>
>> For all the flaws in the current output there are cases now where you
>> can click on a failure, see a summary of the 1-2 tests that failed, and
>> even find your way through the right place in the rather verbose raw log
>> output in 1/4 or 1/2 the time it takes the initial page on the new UX to
>> loda.
>
> I wonder where the hard data is that backs up these numbers.

I've posted some in several replies to this series,
e.g. https://lore.kernel.org/git/220222.86tucr6kz5.gmgdl@evledraar.gmail.co=
m/;
Have you tried to reproduce some of those?

I.e. the "hard data" is that usually takes me 10-20 seconds to go from a
CI link to the summary output & opening the "raw dump" view now, and the
same page is taking about a minute to just load with the new UX.

> [...]
>> > I'd much rather have a slow-loading web site that gets me to where I n=
eed
>> > to be than a fast-loading one that leaves me as puzzled as before.
>>
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
> Sure, I can do that.
>
>>  * I don't see why the changes here can't be made configurable (and
>>    perhaps you'd argue they should be on by default) via the ci-config
>>    phase.
>
> I do see why. If my goal is to unhide the logs by default, so that new
> contributors can find them more easily, I will not hide that new behavior
> behind a hard-to-find config option, an option that new contributors are
> even less likely to find. That would be highly counterproductive. If your
> goal is to help new contributors, I am certain that you will agree.

I meant that they could be on by default, but to relatively easily give
us an out to A/B test the performance of new fancy rendering v.s. the
dumb raw dump we have now.

If that's done via CI config it's a rather trivial matter of
e.g. re-pushing "master" somewhere, whereas if it needs a patch/revert
on top...
