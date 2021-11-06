Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D09C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FF161037
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhKFVd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhKFVdz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:33:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E31C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:31:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id f8so46215273edy.4
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=koQt3gC45WeEHONen1ERFWr7/WfK9UTCuVTyCynSXwM=;
        b=a4BDH6dDga9nmtP4gvKmN95NqYP7qC33AdaTE+THR2yGszJ2vi8zGfAwqyAgoCygar
         lpxFJA4DubU0zCS2QpfcSifNsUj+SQbBXpX+ZpZOlrvqpbU/BmBvXmJaAGTUh8qu7Oi/
         cDmuTJtmRsVzduSe3hDqRG7LBEThKo8uJuwJlTTKil3D1tE56+x5JunCUYzQGh6amw31
         6wt52EC/i+RQ1PKQIrZm0mCgMrsN3mrFimT0Iv3wZ54S6apWFRX1xtNcH8GKdDLc52AG
         TsybbqP8kO3XkqNzm8awtwVlLuJ3mWz4JJxv5IXoHAok+UB9OaY+9dG0/aNZqiFhUMMl
         0TlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=koQt3gC45WeEHONen1ERFWr7/WfK9UTCuVTyCynSXwM=;
        b=JIZTJUwR9271QWuM3JHfgPFYX376IT5iJQDJFvUYeeG5fkGcWmVnuJCX40WTDIS2a/
         HSGQkFJKCieQO9xKdQjAu4xIxXpjTx85lWxdsesNw5W0HU2CNhWhVbuXyBz2sWdf79Vx
         9nVrzTPt+h9gEcL0xxI7CcYlekuYzXbHlHi37gEVPsrgZUFZNdj1ENNRH0IrylHySYlI
         xJrKxga8nDQ8Ff13RBHGb+RpYKu1OUqPfMpez3ZxG7Y5gRK5eQFmtM6pUWKPg8l0Hlbq
         +yaf8F+E6Wxe0u/QDd00zLYskFmvrIc21gNPDI/wBqgB5e0SWmOezwQv8hfjeLyRzUoJ
         ItCw==
X-Gm-Message-State: AOAM530omQrWRs6VKilsOVm/CHzVmJCwkAZDvMzLIa/+j2uWDBS9KCcZ
        rMo6X8eqkiM3n84Bq4pB1o0=
X-Google-Smtp-Source: ABdhPJwwmPvH95067n8SJa5hzvZVKnzZV56DBrgLvfeuQnt0CKbxdWsyaBVkY9x89rof1ad9b3ePZA==
X-Received: by 2002:a05:6402:4389:: with SMTP id o9mr61250641edc.57.1636234272114;
        Sat, 06 Nov 2021 14:31:12 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g1sm4751030eje.105.2021.11.06.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:31:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mjTHL-000n7J-2D;
        Sat, 06 Nov 2021 22:31:11 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v2 3/3] Makefile: replace most hardcoded object lists
 with $(wildcard)
Date:   Sat, 06 Nov 2021 22:13:51 +0100
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
 <patch-v2-3.3-cd62d8f92d1-20211101T191231Z-avarab@gmail.com>
 <24482f96-7d87-1570-a171-95ec182f6091@gmail.com>
 <211106.86tugpfikn.gmgdl@evledraar.gmail.com>
 <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <40dbf962-2ccd-b4d6-7110-31317eb35e34@gmail.com>
Message-ID: <211106.86pmrdezts.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 06 2021, Phillip Wood wrote:

> On 06/11/2021 14:27, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sat, Nov 06 2021, Phillip Wood wrote:
>>=20
>>> Hi =C3=86var
>>>
>>> On 01/11/2021 19:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Remove the hardcoded lists of objects in favor of using
>>>> $(wildcard). This means that every time a built-in, test tool etc. is
>>>> added we won't need to patch the top-level Makefile, except for the
>>>> few remaining cases where the asset in question would make it onto one
>>>> of our list of exceptions.
>>>> Ever since 81b50f3ce40 (Move 'builtin-*' into a 'builtin/'
>>>> subdirectory, 2010-02-22) this has been relatively easy to do (and
>>>> even before that we could glob builtin-*.c). This pattern of
>>>> exhaustively enumerating files was then carried forward for
>>>> e.g. TEST_BUILTINS_OBJS in efd71f8913a (t/helper: add an empty
>>>> test-tool program, 2018-03-24).
>>>> One reason not to do this is that now a new *.c file at the
>>>> top-level
>>>> will be immediately picked up, so if a new *.c file is being worked on
>>>> "make" will error if it doesn't compile, whereas before that file
>>>> would need to be explicitly listed in the Makefile. I think than small
>>>> trade-off is worth it.
>>>
>>> If I need to split up some uncommitted changes into several commits
>>> and I know it is going to be fiddly to do so I will sometimes copy the
>>> original file to foo.safe.c and then edit foo.c to create each
>>> commit. Then I can easily compile and test each commit and editing the
>>> file directly is often easier than using add -p and editing the
>>> hunks. With this patch running make will fail in that case I think.
>> Would being able to do something like:
>>      make EXCLUDE_WILDCARD=3Dfoo.safe.c
>> Satisfy this use-case?
>> We can also have some DEVOPTS knob so we'll prune out files found if
>> a
>> $(shell)-out to "git status" tells us they're untracked. I wouldn't mind
>> that (and could implement it) if it was optional.
>> Also note that you've got some of this already, e.g. we'll pick up
>> *.h
>> files via a glob for "make TAGS", the dependency graph etc.
>
> I'd be happier using 'git ls-files' with a glob if we need to move
> away from listing the files explicitly rather than having to pass some=20
> exclude list when running make. Having seen your comments below about
> ls-files/find I had a look at the Makefile and they always seem to be=20
> used together as "git ls-files ... || find ...". Doing that would mean
> we wouldn't try to build any untracked files but still find everything=20
> in a tarball.

Yes we could use the $(wildcard) in a tarball, the issue of picking up
untracked files is a dev-checkout-only issue, no?

>>> [...]
>>> My recollection is that the discussions were about not having to touch
>>> CMakeList.txt when adding new files to the build and I think that
>>> largely works. I don't think a lot of the changes you have been making
>>> recently were anticipated in that discussion.
>> That's part of it, but the concern about needing to maintain two
>> systems
>> in perpetuity was also brought up, and it not being a hard dependency,
>> having that vs-{build,test} job soft-fail on it etc. were brought up but
>> that's not what we've got now.
>> In any case, having to maintain two build systems and the
>> maintainer(s)
>> of the CMake being inactive one is the situation we're in now.
>>=20
>>>>    - The promised "We can add a (continue-on-error) to vs-build job to
>>>>      make this process less of a hindrance." in [2] never materialized.
>>>>      Since 4c2c38e800f (ci: modification of main.yml to use cmake for
>>>>      vs-build job, 2020-06-26) got a hard dependency on CMake as far as
>>>>      getting the CI to pass goes.
>>>>    - The "vs-build" CI doesn't actually require that there be no GNU
>>>> make
>>>>      usage in the job, as it itself has a hard dependency on running a
>>>>      "make -n artifacts-tar" command. So as far as any vs-specific spe=
cial-sauce
>>>>      goes we don't need a GNU-make free build system for vs-build.
>>>
>>> We need GNU-make for the ci job but an individual developer using
>>> CMake does not need GNU-make installed. On linux it is possible to
>>> build git without having make installed by using cmake and ninja [1]
>> I'd tried that, but didn't know about your [1] topic. If you or
>> someone
>> is actively willing to fix things up in CMake....
>
> I only started working on that a few days ago. I was interested to see
> if using ninja was faster for building when just a few files have been=20
> changed but it doesn't make much difference unless absolutely nothing
> has changed - I guess we don't have that many files in the grand
> scheme of things. The CMake support still lags the Makefile as
> currently things like GIT-VERSION-FILE and git-hooks.h are not
> regenerated when their inputs change. I'm not sure if I want to commit
> to doing much more on that at the moment.

I suspect that any other build system is faster because it doesn't
actually do what our Makefile does, which is something I've been trying
to slowly fix.

E.g. getting rid of the FORCE dependencies we've got. I submitted a
series just now to do some prep work for that:
https://lore.kernel.org/git/cover-00.16-00000000000-20211106T205717Z-avarab=
@gmail.com/

The performance of that:

0 $ hyperfine --warmup 3 -L v master,next,avar/Makefile-perl-python-shell-q=
uote-various-fixes,avar/Makefile-get-rid-of-FORCE-rules-for-gmake-4.2-depen=
dency -p 'git checkout {v} && make -j8 all' 'echo {v} && make -j8 all'
Benchmark #1: echo master && make -j8 all
  Time (mean =C2=B1 =CF=83):     127.7 ms =C2=B1  40.8 ms    [User: 111.5 m=
s, System: 17.4 ms]
  Range (min =E2=80=A6 max):   113.2 ms =E2=80=A6 243.8 ms    10 runs
=20
options.
=20
Benchmark #2: echo next && make -j8 all
  Time (mean =C2=B1 =CF=83):     114.9 ms =C2=B1   0.9 ms    [User: 105.6 m=
s, System: 23.1 ms]
  Range (min =E2=80=A6 max):   113.5 ms =E2=80=A6 116.3 ms    11 runs
=20
Benchmark #3: echo avar/Makefile-perl-python-shell-quote-various-fixes && m=
ake -j8 all
  Time (mean =C2=B1 =CF=83):     121.6 ms =C2=B1  16.8 ms    [User: 107.9 m=
s, System: 22.2 ms]
  Range (min =E2=80=A6 max):   113.6 ms =E2=80=A6 167.4 ms    10 runs
=20
Benchmark #4: echo avar/Makefile-get-rid-of-FORCE-rules-for-gmake-4.2-depen=
dency && make -j8 all
  Time (mean =C2=B1 =CF=83):      71.4 ms =C2=B1  17.2 ms    [User: 61.7 ms=
, System: 11.1 ms]
  Range (min =E2=80=A6 max):    64.2 ms =E2=80=A6 131.9 ms    15 runs
=20
Summary
  'echo avar/Makefile-get-rid-of-FORCE-rules-for-gmake-4.2-dependency && ma=
ke -j8 all' ran
    1.61 =C2=B1 0.39 times faster than 'echo next && make -j8 all'
    1.70 =C2=B1 0.47 times faster than 'echo avar/Makefile-perl-python-shel=
l-quote-various-fixes && make -j8 all'
    1.79 =C2=B1 0.72 times faster than 'echo master && make -j8 all'

I.e. so far I haven't really optimized anything much, but the next step
after that series above speeds it up by almost 2x for a noop run, and
there's other low-hanging fruit after that that I've got in some WIP
code somewhere. I think I managed to get it down to the 10-20ms range
for noop runs in one of those.

>>> [...]
>>>> My attempt to amend/revert 4c2c38e800f to have it use the
>>>> pre-4c2c38e800f "make" invocation as a fallback failed, partially
>>>> because I don't have a Windows development environment, so any attempt
>>>> to change it is a painfully slow round-trip to GitHub CI.
>>>> Let's instead have CMake call out to the Makefile asking it what the
>>>> definition of various variables lists is, rather than being forced to
>>>> maintain those lists in a way that CMake can parse with regexes (which
>>>> precludes anything but a giant hardcoded list).
>>>> I could familiarize myself enough with CMake to do this in some
>>>> CMake-native way, but that would take "just as long as adding it to
>>>> the Makefile"[2] (I think that took me <5 minutes, but I'm several
>>>> hours into fighting with CMake)
>>>> So I consider this both a bugfix to the stated aims of this CMake
>>>> integration, and a better way forward for having an alternate build
>>>> system. I.e. If someone really does care about a having a
>>>> GNU-make-less dependency for the "vs-build" I think this change offers
>>>> a much better way forward for that.
>>>
>>> I don't see how relying on GNU-make is a step forward for the CMake
>>> integration when it works without it now.
>> It's not if we assume we've got infinite man hours to maintain these
>> systems, but we don't.
>> I have some pending patches to make various common cases when using
>> make
>> much better, mainly speeding up no-op runs so things in rebase --exec go
>> faster.
>> So far I've been submitting the parts of that that don't step on the
>> toes of this cmake integration, and realistically if I've got to
>> implement everything in lockstep in two systems I'll probably just give
>> up on it.
>> Hence asking if there's some middle ground we can find here.
>
> What is it about listing the input files explicitly that slows things
> down? Surely it's faster than globbing the filesystem.

It doesn't slow things down. I'd like to get rid of these big hardcoded
lists to make it easier to add new [test] commands, anything that cuts
down on the "modify these N files, copy/pasting the last similar commit"
helps with that.

And we've got churn related to these lists being unsorted, being
re-sorted, and occasional tiresome merge conflicts etc.

The initial reason I finished this up was because I had a WIP patch to
add a "sort assertion" for these lists, per the discussion here:
https://lore.kernel.org/git/87mtv2dk18.fsf@evledraar.gmail.com/

But I realized instead of doing that we could just use $(wildcard)
instead.

>> So you don't want to install "make" on Windows, but how about if we had
>> a script in contrib/ that generated these extractions of lists from the
>> Makefile instead of doing it on the fly, we could even commit those to
>> the repo.
>
> If I understand there would be some make rule that generates a list of
> dependencies and we'd commit that list to the repo and consume it in=20
> CMakeLists.txt. I'd be fine with that

Ok that certainly helps & is a viable workaround.

>> Then I'd effectively get what I'm aiming for here, and cmake users could
>> just re-run that script, and if one of them did they could push the
>> result somewhere, and others could just fetch the generated assets.
>>=20
>>> Overall I'm don't think that moving from a known set of dependencies
>>> to "build whatever C files are lying around in this directory" is an
>>> improvement.
>> The caveat you note above with "foo.safe.c" is something we've got
>> already, see various "$(wildcard)", "find" and "git ls-files" in the
>> Makefile. So this way we'll at least be consistent. Now we'll add stray
>> files to TAGS, apply "coccicheck" to them etc.
>
> I'm not so worried about those other targets, but being able to
> reliably build and test git with some cruft lying around is useful
> though. I'm still not entirely sure what the motivation for this
> change is (adding new files is not that common) but I think using the
> established "git ls-files || find" pattern would be a good way of
> globbing without picking up rubbish if there is a compelling reason to
> drop the lists.

I would like to get rid of those ls-files or whatever globs entirely,
whether that's by moving everything to wildcards or having them consume
the hardcoded lists doesn't really matter.

But it's a a wart that we're e.g. running coccicheck on one globbed set
of files, and compile a hardcoded list of files. Partially it's because
we conflate "list of known files" with "here's what we'd like to compile
on this platform".
