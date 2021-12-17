Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A595C4332F
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 22:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhLQWlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 17:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhLQWlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 17:41:19 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E534DC061574
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 14:41:18 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so13350570edu.4
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 14:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=U2YM1D4Nn/ah4j3Pu4RVflP0AzkZRi8m3tWiupkfckc=;
        b=mzcusBLN1LzQPcTIklZDixHfPlwGJ0nF8tsN9KvrF21iykGGTwL2lowhm9dsH37Z1L
         kSm97JyYTj5Sto92ab3O44ZN/G75iE32jM6eLNZNoX1ipEYrCRts8EO/ieq07AdwogBX
         BK74HTvHdQqx8MvEGlINxzl0fVh0KriMFfR/rw+2+ZPLMxEJ0o6hRDIe7TZCLAjX6xs1
         m7oznWFuCJOxZ7d7JEtEK32zJaBWBSOgypIYFr6gF9LatbB2YgLA6tUMF9KxGrhwUV9c
         UHyx+gnbcfTjTlNpBG1CSc5cLIQ87Mfg3v1XimqN6cgQeQWQzyntuacMesPo6N8I/j15
         cqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=U2YM1D4Nn/ah4j3Pu4RVflP0AzkZRi8m3tWiupkfckc=;
        b=AODrjCZBnnhCLXgYlbx0R0BJ3SOvwP16HR+CWeNqHkSuPNv1kKrMuT/RkTEXAISTbC
         xWMpaDUBR3oAZ2yz2wAE/Xcqh5ER/sLnJnzHWfWRmcus3EFC6ZXoqVuFK4/ZcUl0WOw6
         fXxkUtkrGxOPHdM4JMJJ+C8JVg26aL0inMu2FcVRfu9AbeGkq41uUaBjwd3FJJAsTOqK
         22TSGu0R8ESogJoZz6NaL7MIyFtdB2HojUI2eYFhb3Do+IvbJMakXz9oFKLPisgHMtMR
         FdYFouRbMT+vSxR9AVhlVG06XUSpvBZ2V2gQ/rnSX8mAlTEjo5MSPSn5wbfjLerUzkHx
         cLQw==
X-Gm-Message-State: AOAM533vUNvMKhX0DO2qBBCKaW7/l3AflBCqgXn+eFL3glaBZ/lSArkl
        yoEUINeo118NaWInn4OPin8mfH6fdmYYMQ==
X-Google-Smtp-Source: ABdhPJyVBOcf8Bp0dw42bgDGMGL4KSWodOxyjPuLVDYgE6W/oJ4yuyigondbpPO2pIPvjkPgn9LKgw==
X-Received: by 2002:a50:9ead:: with SMTP id a42mr4791643edf.315.1639780877313;
        Fri, 17 Dec 2021 14:41:17 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hq29sm3216786ejc.224.2021.12.17.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:41:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1myLue-000Del-0a;
        Fri, 17 Dec 2021 23:41:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jerry Zhang <jerry@skydio.com>
Subject: Re: [PATCH V5 2/2] git-apply: add --allow-empty flag
Date:   Fri, 17 Dec 2021 23:28:04 +0100
References: <20211213220327.16042-1-jerry@skydio.com>
 <20211213220327.16042-2-jerry@skydio.com> <xmqqee6dz5s9.fsf@gitster.g>
 <211217.86wnk395bz.gmgdl@evledraar.gmail.com> <xmqqr1ab2c0v.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqr1ab2c0v.fsf@gitster.g>
Message-ID: <211217.865yrmyhv8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I don't see how us not having a 1=3D1 mapping between say a "mktag.sh"
>> test script and that script *only* running "git mktag" makes the
>> approach with SANITIZE=3Dleak misguided.
>
> Sorry, if I was not clear.  SANITIZE=3Dleak tests are perfectly fine.
>
> What I consider misguided is to mark each test script with
> TEST_PASSES marker.
>
> We will *NOT* have "this script uses 'git tag' to check it, and
> nothing else", ever.  It is simply impossible to test the behaviour
> of a single command, as we need other git commands to prepare the
> scene for the command being tested to work in, and other git
> commands to observe the outcome.  We'd run "git commit" to prepare a
> commit before we can 'git tag' to tag it, and 'git verify-tag' to
> see if the signature is good.
>
> And the approach to say "at this point in time, sanitize test passes
> because all the git command we happen to use in this test script are
> sanitize-clean" is misguided, when done way too early.  Because it
> is not just a statement about the state of the file at one point in
> time, but it is a declaration that anybody touches the file is now
> responsible for new leaks that triggers in that test script,
> regardless of how the leaks come.

As I just noted in the side-thread I think we should just recommend
removing the "TEST_PASSES_SANITIZE_LEAK=3Dtrue" at the sligtest hint of
trouble:
https://lore.kernel.org/git/211217.86a6gyyihr.gmgdl@evledraar.gmail.com/

I think that should mostly address this as a problem in practice.

> Surely, I am sympathetic to the intent.  If you are updating "git
> frotz" that is sanitizer-clean, and if you write a new test in a
> test script that happens to be sanitizer-clean, if you introduced a
> new leak to "git frotz", you would appreciate if the CI notices it
> and blocks you.
>
> But it is not the only way to get blockoed by CI.  You may need to
> use another git subcommand that is known not to be sanitizer-clean
> yet to set things up or validate the result of the new feature you
> added to "git frotz", and use of these commands will be caught as a
> "new leak in the script file", even if your change to "git frotz"
> introduced no new leaks.
>
> The only time we can sensibly do the "now these are leak-free, and
> we will catch and yell at you when you add a new leak" is when we
> know _all_ git commands are sanitize clean; then _any_ future change
> to _any_ git command that introduce a new leak can be caught.  Doing
> so before that is way too early, especially when only 230 among 940
> scripts can be marked as clean (and there are ones that are
> incorrectly marked as clean, too).  There is a very high chance for
> any of these 230 that are marked as "clean" to need to use a git
> command that is not yet sanitizer ready to set up the scene or
> validate the result, when a change is made to a command that is
> already clean and is the target of the test.
>
>> You can, FWIW, mark things in a more gradual manner than un-marking the
>> script entirely. There's the SANITIZE_LEAK prerequisite for individual
>> "test_expect_success".
>
> That will *NOT* work for the setup step, and you know it.

Yes. I mean sometimes you can us that, or "test_done" early under that
mode, or just un-mark the whole script by removing the
"TEST_PASSES_SANITIZE_LEAK=3Dtrue" line.

> What would have been nicer was a more gradual and finer-grained
> approach.  If we ignore feasibility for a moment, the ideal would be
> to have a central catalog of commands that are already sanitizer
> clean, so that test framework, when running a git command that is
> known to be leaky, would disable sanitizer to avoid triggering its
> output and non-zero exit, while enabling the sanitizer to catch any
> new leaks in a git command that was known and declared to be
> leak-free (which was the reason why it was placed on that catalog).
>
> If we had something like that, we wouldn't be having this discussion
> on this thread, which is about improving the "git apply" command,
> not about plugging known leaks in "format-patch" command.  "apply"
> would have been on the "clean" list, and the "format-patch" whose
> use is introduced to the "setup" step in this series is known to be
> unclean.

FWIW if we're going back to the drawing board a more viable way of doing
this (which I do locally) is to instrument LSAN to log normalized stack
traces, and then whitelist or blacklist certain stacktrace start/end
markers.

That allows you to whitelist something like a cmd_apply, but importantly
doesn't limit you to just that, and you can at some point whitelist
setup_revisions, declare that no leak should be attributed downstream of
mailmap.c etc.

> Merging down the "mark more of them as sanitizer-clean" topic at
> f346fcb6 (Merge branch 'ab/mark-leak-free-tests-even-more',
> 2021-12-15) was a mistake.  It was way too early, but unfortunately
> reverting and waiting would not help all that much, as the tests the
> patches in that topic touch will be updated while it is waiting, and
> the point of the topic is to take a snapshot and to declare that all
> the git commands it happens to use are leak-free, at least in the way
> they are used in the script.

[...]

> Having said that, what would be the next step to help developers to
> avoid introducing new leaks while yelling at them for existing leaks
> they did not introduce and not forbidding them to use git subccommands
> with existing leaks in their tests?
>
> I would prefer an approach that does not force the project to make
> it the highest priority to plug leaks over everything else.
>
> Hopefully, this time I was clear enough?

Yes, as noted in the interim we shouldn't hesitate to just remove
individual "TEST_PASSES_SANITIZE_LEAK=3Dtrue".

As for the best way forward I think this will all be much less painful
once some of the "big" leaks are fixed. I.e. revision.c, "git commit"
etc.

I've had those changes locally for a while now, but it's been slow going
with the whole submission/cooking etc. cycle. I didn't expect it to be
painful for this long, sorry.
