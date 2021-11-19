Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD24BC433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B336D61154
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhKSUth (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhKSUtf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:49:35 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFEFC06173E
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:46:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so47934009edd.0
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=S9AQQhceeSb9iOb/E8ex59JOSZWroLv680VIv8O+D2o=;
        b=mbBi3DzLbym3sg6xTgLHf9IcA2Fplful5hkcOAyKSDEYS7Mc+MJy7chJ0GTADpwXbw
         2ZJ60dEAycomiX4a/B2QNmJEmiTppN0lnNIt7dDorW4mpYQvakYzt/eYMChpjuO1jP8j
         mVG0V8/pTYZQkHL9sN6zeR4iPFMUV1wt4V/e7tbuxAQJkt2+O2NmwKsOSuoZL72ttUm6
         km/rVkXm8CnxuWDsaljA7c+hnZB5B0gdxQNRcQ+0Hc8e209RbQvAj5y+smVg62rNZwAx
         4Y6CzVjgiu/dcLfu2RctHnhwHqqPm/Vd+j5fJ26ShLQT/Pc1P6M4zB0ohe14hXIsvtfB
         56Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=S9AQQhceeSb9iOb/E8ex59JOSZWroLv680VIv8O+D2o=;
        b=zTqfYBqopg1VQjVi36R0OgboJtmSjyQVYO1SsVJiVNofnpCUeHi6ZEuoEiXv8hR5dm
         uaIT1Nr/pq4AISqXQKL02auxpJ/ypQIGVL6eNH1K6TzVqr+bvrlYWH1894k/nKsnca1Z
         8Q41b/x5xyI2vMWQBXgOlujwu5jVrv8iFTNG3vEkCxX7va7cuc/9hyoLpD0Hm6rtEw7L
         ay7McUBXZG5KKPdOumFSGWuAzCvNDVX0CXB3qmV7OAHJEEk+jQQ0qu5g7Z8Y8Vj0+Uen
         c+7xm1rp/NP5NFXg0MPcC3YkC6hrS1AK//V02aDiLLdXQJUwch4ecpEZNExuWVS7KPy5
         DaVg==
X-Gm-Message-State: AOAM533aSWlhGL4Z1+aWx3KVn1BU2QATDroV5mqoUaROVDrRc77l+9pI
        TQXhLrgBSKsAngKALjhJH08=
X-Google-Smtp-Source: ABdhPJzo99APk++NUwLqkaULbifaVqayXBED9QyBMA3gnndKYNHrjipepD/IKaFngbUDhsuduG3Qiw==
X-Received: by 2002:a05:6402:1c09:: with SMTP id ck9mr29150108edb.389.1637354791174;
        Fri, 19 Nov 2021 12:46:31 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id b11sm464664edz.50.2021.11.19.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:46:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1moAmE-000o5E-9W;
        Fri, 19 Nov 2021 21:46:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 1/2] CI: use shorter names that fit in UX tooltips
Date:   Fri, 19 Nov 2021 21:39:03 +0100
References: <cover-0.2-00000000000-20211119T135343Z-avarab@gmail.com>
 <patch-1.2-26f80c87c8d-20211119T135343Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2111191556001.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111191556001.63@tvgsbejvaqbjf.bet>
Message-ID: <211119.868rxj3mc9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Johannes Schindelin wrote:

> On Fri, 19 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Change the names used for the GitHub CI workflows to be short enough
>> to (mostly) fit in the pop-up tool-tips that GitHub shows in the
>> commit view. I.e. when mouse-clicking on the passing or failing
>> check-mark next to the commit subject.
>>
>> That description is truncated to 24 characters, with the 3 at the end
>> being placed by "...".
>>
>> E.g. the full job name (visible at [1]):
>>
>>     "regular (linux-gcc-default, gcc, ubuntu-latest)"
>>
>> Will, when shown in the tool-tip be truncated to:
>>
>>     "CI/PR / regular (linu..."
>>
>> There's then a further limit in the expanded view where the job names
>> are observably truncated to 44 characters (including "..."). I.e.:
>>
>>     "regular (linux-gcc-default, gcc, ubuntu-l..."
>>
>> With this change we shorten both the job names, and change the
>> top-level "name" from "CI/PR" to "CI", since it will be used as a
>> prefix in the tooltips. We also remove redundant or superfluous
>> information from the name, e.g. "ubuntu-latest" isn't really needed
>> for "linux-leaks", it'll suffice to say linux. For discovering what
>> image runs that specifically we can consult main.yml itself.
>>
>> The above "regular (linux-gcc-default, gcc, ubuntu-latest)" job name
>> then becomes a 1=3D1 match to the "$jobname" used in
>> "ci/run-build-and-tests.sh". A "( push" or " (pull_request" is then
>> added implicitly as before (from the top-level "on" parameter in
>> "main.yml"). In the tooltip we'll now show:
>>
>>     "CI / linux-leaks (pu..."
>>
>> We then have no truncation in the expanded view. See [2] for a
>> currently visible CI run using this commit, and [3] for the GitHub
>> workflow syntax involved being changed here.
>>
>> We could avoid even more truncation with more compact names,
>> e.g. changing "linux" to "lin" or "lnx", but I didn't do that since
>> any additional shortening seemed counterproductive, i.e. "w32" is a
>> well-known way of referring to "Windows", but "lin" isn't). We could
>> also shorten e.g. "::build" and "::test" to "+bld" and "+tst", but
>> those seem similarly to be overly obtuse.
>>
>> 1. https://github.com/git/git/tree/master/
>> 2. https://github.com/avar/git/tree/avar/ci-shorter-names
>> 3. https://docs.github.com/en/actions/learn-github-actions/workflow-synt=
ax-for-github-actions
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> My vote is to drop this patch: it does a lot of things, but I do not see
> any benefit. Names that are too long in one person's setup are not too
> long in another one's.

What person's setup are we talking about here? Satya Nadella's? :)

This isn't a terminal I resized, it's your employer's website.

From the browsers I've tried (Firefox, Chrome, logged in & out) it's the
same for everyone.=20

Do you not see the existing labels truncated in the same way?

> Also, it drops the "PR" as if we would not do PR builds at all anymore
> ("CI" is for "Continuous Integration", i.e. the testing of the current
> `main` branch).

I think "CI" is commonly understood to not mean that these days. It's
just "the test thing that runs on push" to most people. Is anyone
confused that CI is running in their topic branch without a merge back
to mainline?

What's the potential for confusion here? Do you really need to see "CI /
PR" there to be assured that the thing you're looking at running is
actually running?

I dropped it because omitting the " / PR" is worth it not truncate the
actual meaningful info that comes after, e.g. showing both of
"linux-gcc"and "linux-leaks" as "linu..." or whatever.

> And `w32`? Really? *Really*?

I didn't know what to pick there, "win" was suggested in a side-thread.

FWIW I just ran "find" on some repos that I've got checked out locally
of various software, many of which had something-w32.c, or a w32
directory, even if that software is obviously targeting Windows 64 bit
these days.

I thought it was like how my kernel says I'm running an "amd64", even
though it's an Intel :)
