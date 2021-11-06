Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6EDC433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 14:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67A7610A8
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 14:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhKFOtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 10:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhKFOtB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 10:49:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3518C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 07:46:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id f8so43660439edy.4
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 07:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Gs0It0buoooLoJpUq2LDuhmHMcTbwyCVt0snjJ3e+2Q=;
        b=cPswb++XhhtX03b4DjtMeTHqK2lr/G+wW//21w/ng6kb8T4L+p1XSC+9D3wRSs2lum
         gukkHEN1cRXv4LAFh1q500EdPOS7XMhbF3jrdTtIFH/J2S/E0OCzGkMSuCAS6tJPzdVi
         ygPP6R9D7j8cMgk05ucWYXvqbp2zF216oOfWIe7SvpmNVg7tClk9KS6c4Y1b5sXk0jGD
         04/6RE4Mb/DvP2sksCGD6PxqnclZtlRaexr2ASd7zHt91mlICFxyXY/ctIV6EpboKwfc
         p+YTvzNZZO0dXjt9kQc4bo/EKJbkOiOZC2mj8FJu5V28y5sXdbKqKdHY6MX4LCIvE5Iy
         J17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Gs0It0buoooLoJpUq2LDuhmHMcTbwyCVt0snjJ3e+2Q=;
        b=M5dzVW5AfKaBWc4/clb5kJujVwHbGyEjDcKMiYeviqR/AZe/NOJuqzj2JNrNTFduBf
         bn7p/0ZqdLn2+EGKtfiLjn03IXFZCPYL1RXMmOoG7Rq08+sVOZgzcDZdmUV/GBk4SxDO
         SLfxvAjz3NBTreFLzPMvuEDEGYrBI77xDO6kGKgDmC0A4fQjSqKkQBy2MbYjXq2Y7DB8
         xIjykdPF/m/b1vNtewHs2PXkKaCVuV8H/ZZ5fv1VHuB9pn4GKJzcZ2F4nAQqoSnXTlff
         Yp2xHbmzZ4KBJn+qKeGkZTUNzkQ6ZyoHbwCfmRn1eSvI+G0y6B8pBdeTFLc9dXagG7CQ
         DFOA==
X-Gm-Message-State: AOAM531mdPR/W6fyyQfmnuMRd2Pm8G/XNcSTCI9l9QmaV/NeLZS6X/Aj
        Gutb7ljk5sPG+gJrPh18h3E=
X-Google-Smtp-Source: ABdhPJwshS9oUO8Je8rTGBhYSDjsoVOX0Qj3RhhhzLrwg0XsG+NcTRG1ku4VnyZcDDVlO+t7bhCy9A==
X-Received: by 2002:aa7:d3cf:: with SMTP id o15mr9049568edr.265.1636209978048;
        Sat, 06 Nov 2021 07:46:18 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x22sm2878581edd.61.2021.11.06.07.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 07:46:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjMxU-000ghH-S6;
        Sat, 06 Nov 2021 15:46:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
Date:   Sat, 06 Nov 2021 15:27:01 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
 <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
 <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
Message-ID: <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 06 2021, Phillip Wood wrote:

> Hi =C3=86var
>
> On 01/11/2021 19:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Remove the hardcoded lists of objects in favor of using
>> $(wildcard). This means that every time a built-in, test tool etc. is
>> added we won't need to patch the top-level Makefile, except for the
>> few remaining cases where the asset in question would make it onto one
>> of our list of exceptions.
>> Ever since 81b50f3ce40 (Move 'builtin-*' into a 'builtin/'
>> subdirectory, 2010-02-22) this has been relatively easy to do (and
>> even before that we could glob builtin-*.c). This pattern of
>> exhaustively enumerating files was then carried forward for
>> e.g. TEST_BUILTINS_OBJS in efd71f8913a (t/helper: add an empty
>> test-tool program, 2018-03-24).
>> One reason not to do this is that now a new *.c file at the
>> top-level
>> will be immediately picked up, so if a new *.c file is being worked on
>> "make" will error if it doesn't compile, whereas before that file
>> would need to be explicitly listed in the Makefile. I think than small
>> trade-off is worth it.
>
> If I need to split up some uncommitted changes into several commits
> and I know it is going to be fiddly to do so I will sometimes copy the=20
> original file to foo.safe.c and then edit foo.c to create each
> commit. Then I can easily compile and test each commit and editing the
> file directly is often easier than using add -p and editing the
> hunks. With this patch running make will fail in that case I think.

Would being able to do something like:

    make EXCLUDE_WILDCARD=3Dfoo.safe.c

Satisfy this use-case?

We can also have some DEVOPTS knob so we'll prune out files found if a
$(shell)-out to "git status" tells us they're untracked. I wouldn't mind
that (and could implement it) if it was optional.

Also note that you've got some of this already, e.g. we'll pick up *.h
files via a glob for "make TAGS", the dependency graph etc.

>> We could make this simpler still for the Makefile by moving
>> "unix-socket.c" etc. to e.g. a "conditional-src/" directory, likewise
>> for $(PROGRAM_OBJS) to e.g. "programs/". If we did that we would not
>> need the "$(filter-out)" for LIB_OBJS. I don't think that's worth it,
>> e.g. due to "git log -- <path>" on the files now needing a "--follow".
>> There's a few small "while we're at it" changes here, since I'm
>> touching the code in question:
>>   - Start splitting up the the "Guard against the environment"
>> section
>>     at the top, but don't move anything that exists there out to avoid
>>     merge conflicts
>>   - The $(TEST_BUILTINS_OBJS) variable was needlessly complex,
>> because
>>     it didn't have the full paths we'd pathsubst it back & forth.
>>   - Introduce *_SRC in addition to *_OBJ for the variable I'm
>>     touching. Eventually we'll want to do this for all the *.o files,
>>     i.e. make the *.c list a source of truth for *.o, which means we can
>>     e.g. use that exhaustive list for "make TAGS".
>>   - Add a missing "curl-objs" target. See 029bac01a87 (Makefile: add
>>     {program,xdiff,test,git,fuzz}-objs & objects targets, 2021-02-23)
>>     for the commit that added the rest.
>>   - De-indent an "ifndef" block, we don't usually indent their
>>     contents.
>> On the CMake changes here:
>>   - When CMake support was introduced in was introduced
>>     061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)
>>     there was a discussion about the maintenance burden of maintaining t=
he
>>     top-level Makefile in parallel with CMakeLists.txt[1] where reviewers
>>     were assured that doing so would simply be a matter of adding someth=
ing
>>     to a list in the CMake recipe.
>>     Between change and some recent changes of mine where the
>> "vs-build"
>>     job failed to a divergence between the Makefile and CMakeList.txt I
>>     can confidently say that that doesn't at all match reality. Even
>>     seemingly trivial changes to the Makefile like this one are forcing
>>     us to do a deep-dive into CMake internals to make forward progress
>>     with our main build system.
>
> My recollection is that the discussions were about not having to touch
> CMakeList.txt when adding new files to the build and I think that=20
> largely works. I don't think a lot of the changes you have been making
> recently were anticipated in that discussion.

That's part of it, but the concern about needing to maintain two systems
in perpetuity was also brought up, and it not being a hard dependency,
having that vs-{build,test} job soft-fail on it etc. were brought up but
that's not what we've got now.

In any case, having to maintain two build systems and the maintainer(s)
of the CMake being inactive one is the situation we're in now.

>>   - The promised "We can add a (continue-on-error) to vs-build job to
>>     make this process less of a hindrance." in [2] never materialized.
>>     Since 4c2c38e800f (ci: modification of main.yml to use cmake for
>>     vs-build job, 2020-06-26) got a hard dependency on CMake as far as
>>     getting the CI to pass goes.
>>   - The "vs-build" CI doesn't actually require that there be no GNU
>> make
>>     usage in the job, as it itself has a hard dependency on running a
>>     "make -n artifacts-tar" command. So as far as any vs-specific specia=
l-sauce
>>     goes we don't need a GNU-make free build system for vs-build.
>
> We need GNU-make for the ci job but an individual developer using
> CMake does not need GNU-make installed. On linux it is possible to
> build git without having make installed by using cmake and ninja [1]

I'd tried that, but didn't know about your [1] topic. If you or someone
is actively willing to fix things up in CMake....

>>   - The stated goal in 061c2240b1b of avoiding a GNU make dependency
>>     for developer because it requires an SDK that "occupies around two
>>     gigabytes" and "three quarters of a gigabyte worth of Git objects"
>>     hardly seems worthwhile trade-off given the above. Disk space is che=
ap,
>>     developer time required to maintain two parallel build systems isn't.
>
> That rather assumes everyone has plenty of disk space and a decent
> network connection.

I realize that there's going to be a person who's got 1.5GB of disk
space and needs to delete a movie they've downloaded or whatever. I just
think that's worth it v.s. maintenance trade-off.

Doesn't just a Windows base installation need something in the tens of
GB of disk space these days? We're not really talking about embedded
systems.

Just the gcc etc. I've got on my Debian box is approaching a
GB. Whatever we think about other trade-offs optimizing for disk space
doesn't seem very compelling.

>> My attempt to amend/revert 4c2c38e800f to have it use the
>> pre-4c2c38e800f "make" invocation as a fallback failed, partially
>> because I don't have a Windows development environment, so any attempt
>> to change it is a painfully slow round-trip to GitHub CI.
>> Let's instead have CMake call out to the Makefile asking it what the
>> definition of various variables lists is, rather than being forced to
>> maintain those lists in a way that CMake can parse with regexes (which
>> precludes anything but a giant hardcoded list).
>> I could familiarize myself enough with CMake to do this in some
>> CMake-native way, but that would take "just as long as adding it to
>> the Makefile"[2] (I think that took me <5 minutes, but I'm several
>> hours into fighting with CMake)
>> So I consider this both a bugfix to the stated aims of this CMake
>> integration, and a better way forward for having an alternate build
>> system. I.e. If someone really does care about a having a
>> GNU-make-less dependency for the "vs-build" I think this change offers
>> a much better way forward for that.
>
> I don't see how relying on GNU-make is a step forward for the CMake
> integration when it works without it now.

It's not if we assume we've got infinite man hours to maintain these
systems, but we don't.

I have some pending patches to make various common cases when using make
much better, mainly speeding up no-op runs so things in rebase --exec go
faster.

So far I've been submitting the parts of that that don't step on the
toes of this cmake integration, and realistically if I've got to
implement everything in lockstep in two systems I'll probably just give
up on it.

Hence asking if there's some middle ground we can find here.

So you don't want to install "make" on Windows, but how about if we had
a script in contrib/ that generated these extractions of lists from the
Makefile instead of doing it on the fly, we could even commit those to
the repo.

Then I'd effectively get what I'm aiming for here, and cmake users could
just re-run that script, and if one of them did they could push the
result somewhere, and others could just fetch the generated assets.

> Overall I'm don't think that moving from a known set of dependencies
> to "build whatever C files are lying around in this directory" is an=20
> improvement.

The caveat you note above with "foo.safe.c" is something we've got
already, see various "$(wildcard)", "find" and "git ls-files" in the
Makefile. So this way we'll at least be consistent. Now we'll add stray
files to TAGS, apply "coccicheck" to them etc.

So one thing I was aiming for here was closing that gap.

I do tihnk having a well understood hierarchy does help a lot, since you
can know that t/helpers/*.c is always one sort of thing etc.

> [1] The CMake integration is currently broken for non-windows builds,
> I've got some fixes at=20
> https://github.com/phillipwood/git/tree/wip/cmake-fixes

