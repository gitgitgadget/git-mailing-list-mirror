Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35230C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 09:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiEWJ1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiEWJ1V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 05:27:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5048E6E
        for <git@vger.kernel.org>; Mon, 23 May 2022 02:27:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g12so18308043edq.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=W+kiNb94yJgLjE0sNvrf1lP6wntclRNZ7TfF+x8bD9U=;
        b=SeeEBTyqHaK7qoUiaFSfD7s+Z7LOmQDu7Tobl7LGKY0dBrtqH5VMyXEqDYHSHe08Sm
         H+39qkp1XwyibboqxQvao40SA0BufgUekNke54KSJByZWD8kZrRJJrMfSCNdBNmdRH6u
         HpDFysdJfBEC7M1X7cr0L5CxRz9Zko8RFNPsaUZT/1/TMpYyOOnT/wIuifLvxKbhxteG
         cJ/j0WnuUceVI16thnU2X5bkgXxHlK2Bi4NoWLqojd1kpruJ+8y6Sewcjl3FRNGZmxN3
         3WfOScgr4Cta/smKIDWdNmi+PawynIH8p8VYpRszGppekFf7ce56Wx8jeoX5B+2Hf6aR
         a/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=W+kiNb94yJgLjE0sNvrf1lP6wntclRNZ7TfF+x8bD9U=;
        b=62ZKK7v14wgabHbQNMqx27AjI6bpIO85v6grcDypfvpTHta4dHbZqzTF93Jo8ijF6e
         TLYLTU9DEjsj+FJR4JUzuxcI8VTua6opCvMifarGwCc2Oo1Sk4opb51/LjFaI+Drd9Vs
         0N+PTdCmUs9Gr1atdHfDhmos2N4cXewhFZ8ucWRst39sBosqVvP0s9Cj+hyYvKyd2EWf
         ouVlfN3d2wZIsKCG2gOw89RKbyzP7SXSv/g5E/1bzE99mLw5Xm9JHrbVDzG8z3buCqbd
         h0FL0Rc5Fqt4R68fNo53kWMCSg0T4dEYmmn1wCdjSpj4mSXuklnGcVKWB/x4Rh489KAL
         X6ew==
X-Gm-Message-State: AOAM531roj+63Zyo2wzGqSCl61EV3WEq9iSAj+256ZF3vVyFuy1PvFzR
        MglVomdYPPA3XWCYrU2GVZI=
X-Google-Smtp-Source: ABdhPJyqfTMtgH27lm6KR0Oewtc2oFxXG15xyPa0opMEzSgN/Q8RYhF1qSVJXwtRtVHo/4hcZDyduw==
X-Received: by 2002:a05:6402:2790:b0:42b:7534:57c3 with SMTP id b16-20020a056402279000b0042b753457c3mr1238465ede.349.1653298029248;
        Mon, 23 May 2022 02:27:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ia16-20020a170907a07000b006f3ef214e16sm5942847ejc.124.2022.05.23.02.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 02:27:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt4L8-002rBT-Ng;
        Mon, 23 May 2022 11:27:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Mon, 23 May 2022 11:05:37 +0200
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
 <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
 <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>
 <xmqq35h2cwrm.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq35h2cwrm.fsf@gitster.g>
Message-ID: <220523.86ee0kzjix.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, May 21 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> * print the verbose logs only for the failed test cases (to massively c=
ut
>>>   down on the size of the log, particularly when there's only a couple
>>>   failures in a test file with a lot of passing tests).
>>
>> That's an amazingly simple trick to improve the speed by a ton, indeed.
>> Thank you for this splendid idea!
>>
>>> * skip printing the full text of the test in 'finalize_test_case_output'
>>>   when creating the group, i.e., use '$1' instead of '$*' (in both pass=
ing
>>>   and failing tests, this information is already printed via some other
>>>   means).
>>>
>>> If you wanted to make sure a user could still access the full failure l=
ogs
>>> (i.e., including the "ok" test results), you could print a link to the
>>> artifacts page as well - that way, all of the information we currently
>>> provide to users can still be found somewhere.
>>
>> That's a good point, I added that hint to the output (the link is
>> unfortunately not available at the time we print that advice).
>
> https://github.com/git/git/runs/6539786128 shows that all in-flight
> topics merged to 'seen', except for the ds/bundle-uri-more, passes
> the linux-leaks job.  The ds/bundle-uri-more topic introduces some
> leaks to commands that happen to be used in tests that are marked as
> leak-checker clean, making the job fail.
>
> Which makes a great guinea pig for the CI output improvement topic.
>
> So, I created two variants of 'seen' with this linux-leaks breakage.
> One is with the js/ci-github-workflow-markup topic on this thread.
> The other one is with the ab/ci-github-workflow-markup topic (which
> uses a preliminary clean-up ab/ci-setup-simplify topic as its base).
> They should show the identical test results and failures.
>
> And here are their output:
>
>  - https://github.com/git/git/runs/6539835065
>  - https://github.com/git/git/runs/6539900608
>
> If I recall correctly, the selling point of the ab/* variant over
> js/* variant was that it would give quicker UI response compared to
> the former, but other than that, both variants' UI are supposed to
> be as newbie friendly as the other.

...

> When I tried the former, it reacted too poorly to my attempt to
> scroll (with mouse scroll wheel, if it makes a difference) that
> sometimes I was staring a blank dark-gray space for a few seconds
> waiting for it to be filled by something, which was a bit jarring
> experience.  When I tried the latter, it didn't show anything to
> help diagnosing the details of the breakage in "run make test" step
> and the user needed to know "print test failures" needs to be looked
> at, which I am not sure is an inherent limitation of the approach.
> After the single extra click, navigating the test output to find the
> failed steps among many others that succeeded was not a very pleasant
> experience.
>
> Those who are interested in UX experiment may want to visit these
> two output to see how usable each of these is for themselves.

Re selling point & feature comparison: The point of the ab/* variant was
to re-roll Johannes's onto a "base" topic that made much of his
unnecessary, because the building up of features to emit GitHub markup
can be replaced by unrolling things like "make" and "make test" to the
top-level.

That has its own UX benefits, e.g. you can see at a glance what command
was run and what the environment was, and "make" and "make test" are now
split up from one monolithic "build and test" step.

But the primary intention was not to provide a prettier UX, but to show
that this arrangement made sense. I was hoping that Johannes would reply
with some variant of "ah, I see what you mean, that does make things
simpler!" and run with it, but alas...

So small bits in the UX like what you pointed out with needing an extra
click are in there, that one would be easy to solve, it's because we
"focus" on the last step with a false exit code, so we'd just have to
arrange for the "print" step to be that step.

Anyway, the v3 CL of Johannes's series claims that the re-roll "improves
the time to load pages".

I ran both the Firefox and Chrome debugger with performance benchmarks
against:

    https://github.com/git/git/runs/6540394142

And:

    https://github.com/avar/git/runs/6551581584?check_suite_focus=3Dtrue

The former is what Johannes noted as the correct v3 in
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2205222045130.352@tvgsbejvaqb=
jf.bet/,
the latter is the current "seen" with ab/ci-github-workflow-markup
reverted, i.e. just my "base" changes.

In Chrome/Firefox the time to load the page (as in the spinner stops,
and we "focus" on the right content) is:

    JS: ~60s / ~80s=20
    =C3=86: ~25s / ~18s

This is with Chrome Version 101.0.4951.54 (Official Build) (64-bit) and
Firefox 91.8.0esr (64-bit), both on a Debain Linux x86_64 Dell laptop.

The case of Chrome is quite revealing (since its developer tools seem to
show a better summary). It shows that the "=C3=86" version spent ~200ms on
"scripting", ~1ms on "rendering", and ~20k ms "idle".

For "JS" that's ~30k ms on "scripting", 15k ms on "rendering", then 7k
ms on "painting" (which is ~0ms in the other one). 7k ms are spent on
"idle".

So these are basically the same performance results as I reported in
earlier iterations.

I think a v4 of this series really deserves a much less terse
CL. I.e. there are specific reports about major slowdowns in the UX. Any
re-roll should really be re-testing those with the same/similar software
and reporting before/after results.

Clearly the primary goal of improving the CI UX should not be to
optimize the rendering of the results as a goal in itself, but in this
case it becomes *so slow* that it precludes certain major use-cases,
such as seeing a failure and being able to view it in some timely
fashion.

