Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A41C4708E
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 00:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLHAZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 19:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLHAZF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 19:25:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E2288B45
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 16:25:03 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id n20so270217ejh.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 16:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tKoEeVneitihZUqk2PqvLLNMZ5DwP8Sc9r0OSvEafm4=;
        b=agI5o2vXBjroTXifOp9r6+mCKQqZ7rBKf6ssxou5czJqaY9EUUrVoH4IIcwsYdRP39
         AYgLgsCdox82k8K1A1uie4VKEJtnj7hy/mUBnZZxOptsegou05y+pdfbih5gHbmE9ChJ
         BAXedJxBXIk+DNICcm5kOASWG4mTY+PPwcveFEeXKxO8gNOcpF+lrFuZqGJqTaZOeA5p
         wYZvkb+3VBOrNVlt1WF0bdRS/NgDd/1l+KDGfCvPtrWznaDa/YkMEwdeaoPPpOoRFoJD
         UDQ5+5L8JX9QOHU96rwPGA8GqLqWdvVD8rqk19bjooNYJ9AsYXTRjSoHAK8/g8MIuyL4
         R7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKoEeVneitihZUqk2PqvLLNMZ5DwP8Sc9r0OSvEafm4=;
        b=Ob6BrYa5kW9/1/RXvlKJSyDlwo9H4fu2ccrUB8ryaJ3qQE7A042UZEXKAd14FzNVJD
         y27WlwooqJiaaYXGM3gbrgCoaGM70z3i5mPRPmz0w6JVBuyW50QotuY8xRmc4yTR+KHo
         wjgMhIF2zd8KiZiOv+m/SNOqV8KtAsUBE2F31NuBqHyHLYbGMdNF+BKbfyXC+koupwvF
         Ru60KWNgi3UGv6rPsMaZKPQ5H9zbUELRzrPYV6H8i3Qm2U39vgO+yVef8ZKLEjoxUqkF
         pv4ASwCsyAMJ64vS/LTkVVaFwsJLg04Y0kYPwPHyuP3TtPwZhisTwOCzfu7i6VZfMU/d
         rQmg==
X-Gm-Message-State: ANoB5pnaxqH/ope6FPI5xqc2LMXeRzMw19kyfOadvOy9MtDvh1roY04q
        A5JqPeWFoQZj89E9SQvrF9I=
X-Google-Smtp-Source: AA0mqf6vlAkFETmCGW2aIlB8gypPY0K8cfvRqJZQFFA9Tvz96yeeLY1ZBZkpHN3iSYmLz8EoShjWlQ==
X-Received: by 2002:a17:906:84d:b0:7bb:7e1a:f770 with SMTP id f13-20020a170906084d00b007bb7e1af770mr863114ejd.35.1670459102115;
        Wed, 07 Dec 2022 16:25:02 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id gg19-20020a170906e29300b007c0f5d6f754sm4062071ejb.79.2022.12.07.16.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 16:25:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p34ij-004j8R-0Q;
        Thu, 08 Dec 2022 01:25:01 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v6 00/15] cmake: document, fix on *nix, add CI
Date:   Thu, 08 Dec 2022 01:06:07 +0100
References: <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
 <cover-v6-00.15-00000000000-20221206T001617Z-avarab@gmail.com>
 <b56d6f29-b22f-f64a-82b3-e7217c0e720d@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <b56d6f29-b22f-f64a-82b3-e7217c0e720d@dunelm.org.uk>
Message-ID: <221208.865yem91ya.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 06/12/2022 02:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This topic gets our tests from passing ~80% with ctest on *nix to
>> passing 100%.
>> See passing CI job for "cmake + ctest" on Ubuntu at:
>> https://github.com/avar/git/actions/runs/3625189647
>> See
>> https://lore.kernel.org/git/cover-v5-00.15-00000000000-20221202T110947Z-=
avarab@gmail.com/
>> for the v5.
>> Changes since v5:
>> * Typo/grammar etc. fixes noted by Eric.
>> * Phillip reported the "chmod" fallback no working on Windows. I
>>    couldn't reproduce that, but running it was always redundant there
>>    we'll now skip doing that on Windows.
>
> I suspect the issue is that "chmod" is not in %path% (i.e. $PATH in
> posix shell speak) when CMake is run from visual studio (the mingw
> stuff is only available when running "sh" by default to prevent name
> clashes with the windows find command etc.) but is added to $PATH in
> the CI after installing the git-for-windows sdk.

Maybe, presumably the "sh" then sets the $PATH, because we do run
shellscripts at the top-level that expect to find the binutils,
e.g. "sed" and the like, which presumably are in the same location as
"chmod".

But in any case this v6 avoids the issue entirely.

>> * Adjust 15/15 to fold into an existing "case" statement, rather than
>>    adding a new "if" statement.
>> For this v6 I experimented with changing the "win+VS build|test" job
>> build in "contrib/buildsystems/out" rather than at the top-level[1]. I
>> left those changes out here, but doing so makes that a lot simpler, as
>> it no longer needs to rely on the Makefile to tell it what cmake might
>> have built.
>
> Long term I think that is a good direction for the CI job. The CI job
> is not a good simulation of running CMake from Visual Studio.

Yes, I just didn't want to make this series even larger, but I can
submit that after.

> That does not normally matter but has been a problem for this
> series. Ideally it would run the test with CTest as well, I'm not sure
> how much work that would be.

In principle trivial, I did try, but it seems the Windows image doesn't
have "ctest", but does have "cmake" (unlike the Ubuntu image).

(Or come to think of it, maybe it does and I tried "ctest" and not
"ctest.exe". I can't remember)

Other than that it should just work, and the "linux-cmake-ctest" CI job
added by this series already does a run with "ctest".

>> But even without including that here, those changes should give more
>> confidence in these changes, i.e. they show that our CI's "msbuild"
>> doesn't require the "cmake" to build things at the top-level.
>> 1. https://github.com/avar/git/tree/avar/cmake-test-path-no-make-for-win=
dows-ci
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (15):
>>    cmake: don't invoke msgfmt with --statistics
>>    cmake: use "-S" and "-B" to specify source and build directories
>>    cmake: update instructions for portable CMakeLists.txt
>>    cmake: don't copy chainlint.pl to build directory
>>    cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>>    cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>>    cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>>    Makefile + test-lib.sh: don't prefer cmake-built to make-built git
>
> As far as I can see this changes test-lib.sh to prefer the make-built
> git if it exists even after running cmake and ctest. Ideally we'd test=20
> the most recent build.

Ideally, but as summarized in the v5 CL this already isn't the case on
"master". I.e. you can e.g. build with cmake, then "make git", then your
tests will use the cmake (older) git, not your newly built one with
"make".

I think the only sane state of affairs here is what this series changes
it to.

If we have a top-level "git" we should always prefer it, as "make" is
our primary build system, and it would be impractical to plug all the
gaps and intercept the "latest git" in all places.

But more importantly, isn't this concern entirely academic?

We can imagine scenarios where you build with both, but the VS users
that are the primary audience of the cmake recipe aren't going to also
build with "make", they're just building with "cmake" and "msbuild".

So I don't think this will impact anyone in practice.

Even you have both a "make" and "cmake" build in play the "make test"
and "ctest" will always select the "make" and "cmake" built one,
respectively.

The only case where we need to pick one is if you run a test manually by
cd-ing to "t" and invoking a shellscript.

You also brought up a concern about multiple builds in
contrib/buildsystems/ in a previous iteration. With the way this series
leaves it that'll actually work in some sensible way. I.e. your "ctest"
run for a "prod" build run won't switch to a new git that you built
midway through the run, as it would on "master".

