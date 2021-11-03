Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B49C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 09:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053876112D
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 09:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhKCJqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhKCJqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 05:46:36 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E40C061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 02:44:00 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o8so7025513edc.3
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DEZ2aqStUkVdMyz4IllyNTJUzA4+EP359TEVxutc9iM=;
        b=j981RH79cOPVbky5SSxdUgzMImNDac5MPLGRUJJEaoaj/NvRPioEz8tz1EwLZKDds9
         h0X4DAi5cqt1A4MDwgn/SuO1g2RPoN3D5WLsukBc/QV/nkrSG3kBv2AJ2Bjmr57qUgl3
         Lj4JgBGsjq3M7ik6nu78sbc/QrLrlDUEtbfbM7TU2lNxuD6lgTxpzLCOOsS8lYUovBra
         XtycWtyLbpQsLq2VelJ8Xkn9o85fvCLhvPmKVVa5Je7LIhERvY0vUfAfxkkRrq8EMcUh
         tqz0JIEAgumwW0SX3pAWFcnwsUx+OXtXGud8E7pYQ9fynh04MtcUiKmxTL5TbVo7Gc/z
         LQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DEZ2aqStUkVdMyz4IllyNTJUzA4+EP359TEVxutc9iM=;
        b=IV74kRrK4lFdT1gem8nlCioo8waylOMDxG+s4F/sK2ugTOd8IRUI3S38j2fKMqWe4S
         P90k90XJm4kZQbpuErTvhMszgB4iBGp/X+5Swe+gqTt1B7pyGA+hrKw5gsNQdr3l9elD
         fHUwzORbekSGYHHMiAxpuqeKoKLt65VrGYXOCW9dCsNPXTSVnOfRMelhNsZAsEXOUJcj
         8/tPP8fOETrB0VXemhwIMsdzgTqOs6XWDoGiBEIB6+MXeYBvCcfZYulnBSGHxL6tm8DK
         Z7I+L/fyghggPKOKMp5D3Scx5qW14IJWacU0xPqDIFVYxKfFbpSUyCqleu+NdqSUcJrL
         U2Rg==
X-Gm-Message-State: AOAM532awpW1w8t/1owQwWapZcddn25NXb64e/gJblEIYnu1/pt/od4l
        8MMJIbhZhFmJhkCoSHnJqM6LG+cW1anAhg==
X-Google-Smtp-Source: ABdhPJwIEchdgM5niiMlSvOfzy4s9sqh66FzbvZUpaOWYXtlpC1Difvpl1Jue8II/mwMDCXv9LkKXg==
X-Received: by 2002:a17:906:c9d0:: with SMTP id hk16mr52141184ejb.109.1635932638645;
        Wed, 03 Nov 2021 02:43:58 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m5sm845290ejc.62.2021.11.03.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 02:43:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1miCoH-002Frr-Iw;
        Wed, 03 Nov 2021 10:43:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: test suite speedups via some not-so-crazy ideas (was: scripting
 speedups[...])
Date:   Wed, 03 Nov 2021 10:24:57 +0100
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211144490.56@tvgsbejvaqbjf.bet>
 <20211026201448.GA29480@dcvr>
 <211030.86ee8246hy.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <211030.86ee8246hy.gmgdl@evledraar.gmail.com>
Message-ID: <211103.864k8t1sma.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 30 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Oct 26 2021, Eric Wong wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>> * Test suite is slow. Shell scripts and process forking.
>>>=20
>>>    * What if we had a special shell that interpreted the commands in a
>>>      single process?
>>>=20
>>>    * Even Git commands like rev-parse and hash-object, as long as that=
=E2=80=99s
>>>      not the command you=E2=80=99re trying to test
>>
>> This is something I've wanted in a very long time as a scripter.
>> fast-import has been great over the years, as is
>> "cat-file --batch(-check)", but there's gaps should be filled
>> (preferably without fragile linkage of shared libraries into a
>> script process)
>>
>>>    * Dscho wants to slip in a C-based solution
>>>=20
>>>    * Jonathan tan commented: going back to your custom shell for tests
>>>      idea, one thing we could do is have a custom command that generates
>>>      the repo commits that we want (and that saves process spawns and
>>>      might make the tests simpler too)
>>
>> Perhaps a not-seriously-proposed patch from 2006 could be
>> modernized for our now-libified internals:
>
> I think something very short of a "C-based solution" could give us most
> of the wins here. Johannes was probably thinking of the scripting being
> slow on Windows aspect of it.
>
> But the main benefit of hypothetical C-based testing is that you can
> connect it to the dependency tree we have in the Makefile, and only
> re-run tests for code you needed to re-compile.
>
> So e.g. we don't need to run tests that invoke "git tag" if the
> dependency graph of builtin/tag.c didn't change.
>
> With COMPUTE_HEADER_DEPENDENCIES we've got access to that dependency
> information for our C code.
>
> With trace2 we could record an initial test run, and know which built-in
> commands are executed by which tests (even down to the sub-test level).
>
> Connecting these two means that we can find all tests that say run "git
> fsck", and if builtin/fsck.c is the only thing that changed in an
> interactive rebase, that's the only tests we need to run.
>
> Of course changes to things like cache.h or t/test-lib.sh would spoil
> that cache entirely, but pretty much the same is true for re-compiling
> things now, so would changing say builtin/init-db.c, as almost every
> test does a "git init" somewhere.
>
> But I think that approch is viable, and should take us from a huge
> hypothetical project like "rewrite all the tests in C" to something
> that's a viable weekend hacking project for someone who's interested.

First to outline some goals: I think saying we'd like to speed up
scripts is really getting into the weeds.

Surely we'd like to speed up test runs, and generally speaking our test
suite can be parallelized, and it mostly doesn't matter if it runs on
your computer or other people's computers, as long as it runs your
code. So:

 1. Even for contributors that have a slow system they could benefit from
    the hosted CI (on GitHub or wherever else) being faster.

 2. Our CI takes around 30-60m to finish.

 3. That CI time is almost entirely something that could be sped up by
    throwing hardware at it.

 4. We're currently using "Dv2 and DSv2-series" hosted runners
    (https://docs.github.com/en/actions/using-github-hosted-runners/about-g=
ithub-hosted-runners)
    we have quite a few people on-list who work for the
    company/companies involved.

    Is it within the realm of possibility to get more CI resources
    assigned to git/git's organization network?

 5. Or, is there willingness to host/pay for hosted runners from
    someone?

    Not wearing PLC hat I'd think that we could speed that up a lot with
    some reasonable money spending, and if pushing to CI made CI run in
    3-5m instead of 60m that would be worthwhile.

 6. Related to #5: I've been able to setup hosted runner jobs, and
    self-hosted runner jobs, but is there a way to do some opportunistic
    mixture of the two? Even one where self-hosted runners could come
    and go, and if they're present contribute resources to git/git's
    network?

 7. We run the various GIT_TEST_* etc. jobs in sequence, is there a
    reason for why we're serializing things in GitHub CI that could be
    parallelized?

    The vs-build and vs-test tests run in parallel, any reason we're not
    doing that trick on the ubuntu runners other than "nobody got to
    it?". We seem to be trying hard to do the exact opposite there..

    At the extreme end we could build git ~once, and have N tests depend
    on that, where N ~=3D $(ls t/*.sh) x $number_of_test_modes). But
    perhaps runner starting overhead starts to be the limiting factor at
    some point.

 8. To a first approximation, does anyone really care about getting an
    exhaustive list of all failures in a run, or just that we have *a*
    failure? You can always do an exhaustive run later.

 9. On the "no" answer to #8: When I build/test my own git I first run
    those tests that I modified in the relevant branches, and if any of
    those fail I just stop.

    I generally don't need to run the entirety of the rest of the test
    suite to stop and investigate why I have a failure.

    Perhaps our CI could use a similar trick, i.e. first test the set of
    modified test files, and perhaps with some ad-hoc matching of
    filenames, so e.g. if you modify builtin/add.c we'd run t/*add*.sh
    in the first set, and all with --immediate per #8 above.

    If we pass that we'd run the full set, minus that initial set.
