Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B7C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 21:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241123AbiBWVp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbiBWVp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 16:45:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322514F9FE
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:44:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s14so284774edw.0
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 13:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dZUR7mPbBCDutX9d6J8Y1yD9WSIyWAH8g6AFyDTpnb8=;
        b=leu07rKga4P37kVbwKmj38dWcf853gqLHE0z3LdcTY7y8WMfylMmOxOfTGxKIEkh3X
         Qj47FXRcKlcEqBSWTlpO5F0R/973Le0ENxsWU1H3itLBOYYSgVYoS+5vuR6X/yNkHwlh
         odTDV7TeBuC1RKPNal3jobnn7SNQXdj8/+YRLu5wbxh44Gx6QrrWJ/r/tnpLQ3FbYabf
         b+7ukoqdNaTURd+BORnen7VT/l+zai6b9l1VUPzW48QO3okLFJ6mXE51vFw/P4b/3ITv
         SlwzyJJTRHa8KNmeqr4Yv7J7ejs862qC9E93CGiyWU1S09JYhYgLaf/EHEmkZbRUIyNI
         Qp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dZUR7mPbBCDutX9d6J8Y1yD9WSIyWAH8g6AFyDTpnb8=;
        b=LKhg9j1vntMJbDH4iLybtm6l5tb6cj8idjX2kVpQV87nYaQrrSybCcbnlUsmv52eXx
         Dgo4jnwW6xz6pd5A+SNfQOqrl+mBzuNkD1YojMqax5f0bxqkp/Uofl21TGLSGXEkmd/w
         3xARjihyn4gtw9DOPlq/uhGhw4alHi01q8+vAlIkFHssfzH2m/rS3Cd8MJVVmRxankO4
         iozVRRykABFOuSQgedCdgP4izhy0DhoAt7bYdAhD5gzXmQvXAn6ZE+xO1WfpKxYwmTFF
         S/eJkuMF/GAG6VWhreSxzGnBYEgen8WnGftgze0fmmeG8If/CTGNS/mRPDtncrius+ji
         nBgw==
X-Gm-Message-State: AOAM533xSexKY4FhY3NDM4s3IsTAPYp5hR0GDagFLxQwf0sfKMdnOSoI
        OmyG92A4q1vkBXD1hqof47s=
X-Google-Smtp-Source: ABdhPJyu6lqXTUg449J24lkKQaHZl4fnUxMxEpEqS7gFy8QVEkvl6tyz4YJP2AeBj2tnCNEvSuvEog==
X-Received: by 2002:aa7:d453:0:b0:410:d407:da20 with SMTP id q19-20020aa7d453000000b00410d407da20mr1319002edr.351.1645652697409;
        Wed, 23 Feb 2022 13:44:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id mb23sm344941ejb.62.2022.02.23.13.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 13:44:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMzRQ-0002ke-1d;
        Wed, 23 Feb 2022 22:44:56 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
Date:   Wed, 23 Feb 2022 22:18:21 +0100
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com>
 <4d3fecbf-23f9-f6b6-414e-8eaca620aced@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <4d3fecbf-23f9-f6b6-414e-8eaca620aced@gmail.com>
Message-ID: <220223.86pmndb6lj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Phillip Wood wrote:

> On 21/02/2022 14:46, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [...]
>> =3D=3D Details
>> This series conflicts with and is a proposed alternative to
>> Johannes's
>> proposed changes to teach "ci/lib.sh" GitHub specific syntax to
>> "group" certain parts of the output[2]. That series proposes to keep
>> the "ci/run-build-and-tests.sh" and similar scripts, but to teach them
>> to emit markers indicating when the "build" part commences, then
>> "test" etc.
>> I think the approach offered here is better as elaborated on in
>> 12/25[1], especially because as Johannes notes[3] we only have one
>> level of "grouping" within a "step" available to us. In his version
>> using it for "build" v.s. "test" precludes being able to group parts
>> of that "build" or "test" output in the future.
>> The following compares CI output between the three with a
>> change-on-top which caused a compilation error ("this" is this series,
>> "js" is Johannes's) when clicking on the "linux-gcc" failure:
>>    master:
>> https://github.com/avar/git/runs/5274251909?check_suite_focus=3Dtrue
>>    this: https://github.com/avar/git/runs/5274464670?check_suite_focus=
=3Dtrue
>>    js: https://github.com/avar/git/runs/5272239403?check_suite_focus=3Dt=
rue
>>    Here we went from 93 lines of output on "master" to 47 in "this"
>>    (107 in "js"). Note also how in "this" we can:
>>    - Expand the "Run make" to get the "MAKEFLAGS" and other
>> variables
>>      used in the step. That's now a 3-line summary instead of the
>>      first 50 lines being the old "ci/lib.sh" "set -x" output.
>>    - Because "make" failed, we have an elided "make test" step
>> that's
>>      not being run below. We can thus see what steps our failure caused
>>      us to skip.
>>    - Unlike the "js" version we'll show the compilation error by
>>      default (the "js" version is grouped and needs to be expanded),
>>      but our output is now brief enough that that's no longer
>>      surrounded by other irrelevant output.
>>    - Unlike the "js" version there is no "CI setup" group within
>> each
>>      step. That work is in the earlier "ci/lib.sh --build" step
>>      instead, which sets the config for all subsequent steps.
>
> I can see that showing compilation errors without having to expand
> anything is useful but in my experience they are relatively rare=20
> compared to test failures. If I understand the rest of the message
> correctly we're left with having to expand print-test-failures and=20
> searching for "not ok" to find out what went wrong with this series.

Yes, it's a non-goal of this series to directly improve or change the
"prove" output, or to replace or change the functioning of
ci/print-test-failures.sh.

I think that's also a thing worth doing, it's just not what I'm aiming
for here. I.e. the goals of this & Johannes's series is only partial.

The above summary is comparing the parts of the two where those goals do
overlap, i.e. it's rougly comparable to patches 1-4/9 of Johannes's
series. His 5-9/9 are (mostly) orthagonal modifications to t/test-lib.sh
etc.

>> For other output changes look at the difference between "master" and
>> "this" at:
>>    master: https://github.com/git/git/actions/runs/1866786595
>>    this: https://github.com/avar/git/actions/runs/1876270588
>> Not explicitly covered in the summary above is that various other
>> parts of ci/* were doing the same sort of within-step setup, but now
>> do so via cross-step passing of variables via $GITHUB_ENV. E.g. on
>> "master" the test slices for the Windows tests have a lot of verbosity
>> before they get to running the test itself:
>>      https://github.com/git/git/runs/5254267914?check_suite_focus=3Dtrue=
#step:5:56
>> In the "js" version the test output is hidden ("grouped"), but we've
>> got the same amount of verbosity by default:
>>      https://github.com/gitgitgadget/git/runs/4937491771?check_suite_foc=
us=3Dtrue#step:5:67
>> Whereas in "this" version that verbosity is in the preceding "select
>> tests" step, with the "test" step showing only the relevant end-state
>> of the "$T" variable we'll use in the Makefile (hidden by default,
>> expanded in this link):
>>      https://github.com/avar/git/runs/5274558869?check_suite_focus=3Dtru=
e#step:7:13
>
> All I can see in the "$T" variable I have to scroll to get the prove
> output on screen

Yes, what that link is showing you is that for the test run the
variables that control the full set of variables that control the test
run are now prominently displayed.

All of the output etc. after that isn't changed.

The point of those comparisons is to draw your eyes to the part that
*is* changed v.s. master, and how using that variable passing mechanism
is making things related to that simpler & less verbose.

>> This series does not attempt to replace the use of the "group" output
>> used for the "ok" or "not ok" portion of tests in Johannes's
>> series. When a test fails the output in this series (sans config
>> discovery not being repeated, and now summarized in the $GITHUB_ENV
>> drop-down) is substantially the same as on "master".
>> My summary at [4] goes into other overlap & non-overlap between the
>> two. I think using the "group" output for those purposes might be
>> useful, although I left some feedback on [5] with problems in the
>> current "js" implementation.
>> I do think any such changes should follow behind this series, as
>> doing
>> that sort of grouping once we can effectively free up an extra "group"
>> level (by peeling those off into "steps", as is done here) would be
>> much more useful.
>
> I can see the attraction of being able to use make directly in the ci
> from an implementation point of view but from the point of view of=20
> someone trying to investigate a test failure then unless I've
> misunderstood I don't think this series improves the current
> situation.

Johannes's series is making use of GitHub's group output with changes to
ci/lib.sh to e.g. distinguish the "make" phase from "make test".

This series shows that's not something that's needed to "group" those
two.

Instead we can set set the variables and other context that ci/lib.sh
currently sets at the start of every "step" in an earlier "step" in a
way that spans later steps.

Those later steps are then a light "make" or "make test", and because
steps are their own "group" it accomplishes the same goals for grouping
that part of the output, without needing any CI-specific syntax in ci/*.

Further, if we ever wanted to make use of such syntax for the
"ci/lib.sh" part we could do that on top of this series for
e.g. "grouping" individual errors that "make" emits.

Doing that wouldn't be possible with Johannes's approach, since there's
only one "group" level, you can't nest them. So using it for "build" and
"test" means you've already used up your one-level.

It's also a lot simpler, the resulting code size for the two in terms of
*.sh code in ci/ is:

    $ git grep . avar/ci-unroll-make-commands-to-ci-recipe 'ci/**.sh'|wc -l
    422
    $ git grep . pr-1117/dscho/use-grouping-in-ci-v1 'ci/**.sh'|wc -l
    721

> Why can't you build on top of Dscho's series that makes it
> easier to see the output of the failed tests?

Because building on top of it would mean adding a bunch of code and
complexity to ci/* to accomplish a goal that this series shows that we
can equally get without that complexity and added code, as the diffstat
etc. shows.

What we do about t/test-lib.sh, "prove" etc. emitting summary output
about tests is then a mostly orthagonal change on top of that.

"Mostly" except insofar that Johannes's series notes that he's left with
the limitation[3] that "sadly, workflow output currently cannot contain
any nested groups".

Of course that's also true after this series (that GitHub CI feature
will be the same).

But the difference is that since we won't have used the "group" for
"make" and "make test" (as it's "kicked up" to the "step" level) a
series to add "group"-ing to the test output wouldn't have the group for
an individual test failure at the same level as "make test".

>> 1. https://lore.kernel.org/git/patch-12.25-dfd823f2e7d-20220221T122605Z-=
avarab@gmail.com
>> 2. https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gma=
il.com/
>> 3. https://lore.kernel.org/git/9333ba781b8240f704e739b00d274f8c3d887e39.=
1643050574.git.gitgitgadget@gmail.com/
>> 4. https://lore.kernel.org/git/220127.86ilu5cdnf.gmgdl@evledraar.gmail.c=
om/
>> 5. https://lore.kernel.org/git/220126.86sftbfjl4.gmgdl@evledraar.gmail.c=
om/
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (25):
>>    CI: run "set -ex" early in ci/lib.sh
>>    CI: make "$jobname" explicit, remove fallback
>>    CI: remove more dead Travis CI support
>>    CI: remove dead "tree skipping" code
>>    CI: remove unused Azure ci/* code
>>    CI: don't have "git grep" invoke a pager in tree content check
>>    CI: have "static-analysis" run a "make ci-static-analysis" target
>>    CI: have "static-analysis" run "check-builtins", not "documentation"
>>    CI: move p4 and git-lfs variables to ci/install-dependencies.sh
>>    CI: consistently use "export" in ci/lib.sh
>>    CI: export variables via a wrapper
>>    CI: remove "run-build-and-tests.sh", run "make [test]" directly
>>    CI: check ignored unignored build artifacts in "win[+VS] build" too
>>    CI: invoke "make artifacts-tar" directly in windows-build
>>    CI: split up and reduce "ci/test-documentation.sh"
>>    CI: combine ci/install{,-docker}-dependencies.sh
>>    CI: move "env" definitions into ci/lib.sh
>>    ci/run-test-slice.sh: replace shelling out with "echo"
>>    CI: pre-select test slice in Windows & VS tests
>>    CI: only invoke ci/lib.sh as "steps" in main.yml
>>    CI: narrow down variable definitions in --build and --test
>>    CI: add more variables to MAKEFLAGS, except under vs-build
>>    CI: stop over-setting the $CC variable
>>    CI: set PYTHON_PATH setting for osx-{clang,gcc} into "$jobname" case
>>    CI: don't use "set -x" in "ci/lib.sh" output
>>   .github/workflows/main.yml            | 100 +++++---
>>   Makefile                              |  32 ++-
>>   ci/check-directional-formatting.bash  |   2 +-
>>   ci/check-unignored-build-artifacts.sh |  20 ++
>>   ci/install-dependencies.sh            |  53 ++++-
>>   ci/install-docker-dependencies.sh     |  22 --
>>   ci/lib-ci-type.sh                     |  10 +
>>   ci/lib-tput.sh                        |   2 +
>>   ci/lib.sh                             | 315 ++++++++++++--------------
>>   ci/make-test-artifacts.sh             |  12 -
>>   ci/mount-fileshare.sh                 |  25 --
>>   ci/print-test-failures.sh             |  16 +-
>>   ci/run-build-and-tests.sh             |  54 -----
>>   ci/run-docker-build.sh                |  66 ------
>>   ci/run-docker.sh                      |  47 ----
>>   ci/run-static-analysis.sh             |  32 ---
>>   ci/run-test-slice.sh                  |  17 --
>>   ci/select-test-slice.sh               |  10 +
>>   ci/test-documentation.sh              |  37 +--
>>   ci/util/extract-trash-dirs.sh         |  50 ----
>>   20 files changed, 345 insertions(+), 577 deletions(-)
>>   create mode 100755 ci/check-unignored-build-artifacts.sh
>>   delete mode 100755 ci/install-docker-dependencies.sh
>>   create mode 100644 ci/lib-ci-type.sh
>>   create mode 100644 ci/lib-tput.sh
>>   delete mode 100755 ci/make-test-artifacts.sh
>>   delete mode 100755 ci/mount-fileshare.sh
>>   delete mode 100755 ci/run-build-and-tests.sh
>>   delete mode 100755 ci/run-docker-build.sh
>>   delete mode 100755 ci/run-docker.sh
>>   delete mode 100755 ci/run-static-analysis.sh
>>   delete mode 100755 ci/run-test-slice.sh
>>   create mode 100755 ci/select-test-slice.sh
>>   delete mode 100755 ci/util/extract-trash-dirs.sh
>>=20

