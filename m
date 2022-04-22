Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05245C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 11:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391638AbiDVLpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 07:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiDVLpg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 07:45:36 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5D052B24
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:42:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bv19so15844286ejb.6
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dGDPuSgLPPbKRfVSDGZplr/QTfo03+nmVmiZF4a99uk=;
        b=Hi1eajbDHuLm8cG1nOAp02Cu5xvibIVX7oJ5/X9nBQQKqVnKbFgUrthNMG7tn0Ch5D
         pQJ14E1jfLzwL3sAnxyGLaSd0MCobg4zuA/3kIdTUs82nviuJNfXa6uMfgpDT9L47RFB
         LpLsZT7L2WqqUPJe3n9s3sO6XruwHzpk9USbJVbadlD/tn7ykWf6pOrqpq0tJBOWoPE9
         m9WyjUaaohSRjny5qrf/Ts/TUwlvdHfSvztT1g4RBLAy4ugxxlfKTzZ1jiVX6M+f5nUo
         Gv3yp4JvXX3RgWku8Yw660pNY1sDEPbvXKUX2PVUXphITIHjGVw8EOkeHjPrRfLiubbf
         ykMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dGDPuSgLPPbKRfVSDGZplr/QTfo03+nmVmiZF4a99uk=;
        b=A2iaSRvGC7HU62vgvME/F8yBGUM1f+b0uvi7MOnoIpBQILWzptsQ1U2wuvfVaKQRI7
         NLkACUVEKtpF5XsQ+VMbXHu8yNESW+4GFahtfskS3yDLC3oofDp8d1dV90HGU5Vkn4la
         6BZmZ9MGjrpMkfmb8Zg1nCGhiEbnigAlRjzgEOZ09FlvazHeOoXEyV/dvenRy1ekyHR+
         1YVQPqb8LL7fN92MWzYLlVu3wO3SO4g7yO66+HHT/mbwhL9QsyrwTVMsPXTNwP5XnHSg
         fDsAmLKxfFXZR96R5Qns2LwLHbD6hMV9o71emY+yJuXYuQZxcAmoAmFXDWKLRL5wl3ws
         TK8Q==
X-Gm-Message-State: AOAM532iMFX/NG03tzMf1V099r0N+NeDiMGtERcR/6bj8HvYyYbfVkvF
        rTKCH5EbU3WjIaDCGmLd1dk=
X-Google-Smtp-Source: ABdhPJxIN/Yk3cs93+G8t74bmvtZLSLePhpF1imjD3wGUMHyBcy9sU+n2hYuxsiSPaRxrDIjE0AsUQ==
X-Received: by 2002:a17:906:4fc9:b0:6ef:ff11:436 with SMTP id i9-20020a1709064fc900b006efff110436mr3655722ejw.43.1650627760175;
        Fri, 22 Apr 2022 04:42:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ek21-20020a056402371500b0042025e47eddsm747146edb.7.2022.04.22.04.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:42:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nhrgN-008iJb-7o;
        Fri, 22 Apr 2022 13:42:39 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: ab/ci-setup-simplify (was Re: What's cooking in git.git (Apr
 2022, #05; Mon, 18))
Date:   Fri, 22 Apr 2022 13:28:51 +0200
References: <xmqqbkwyz78z.fsf@gitster.g>
 <1157a463-f6c6-1df5-59cd-419d73eed1df@gmail.com>
 <220421.86fsm66zmz.gmgdl@evledraar.gmail.com>
 <34a9c2dc-f8f5-4c1b-fed8-115429ae5a9f@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <34a9c2dc-f8f5-4c1b-fed8-115429ae5a9f@gmail.com>
Message-ID: <220422.86v8v14a4w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=20
On Fri, Apr 22 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 21/04/2022 19:36, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Tue, Apr 19 2022, Phillip Wood wrote:
>>=20
>>>> * ab/ci-setup-simplify (2022-04-14) 29 commits
>>>> [...]
>>>>    Will merge to 'next'?
>>>>    source: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.c=
om>
>>>
>>> I haven't had time to read all 31 patches from v4 in detail but I have
>>> looked at the results in seen.
>>>
>>> Looking at seen:ci/install-dependencies.sh the shebang has been
>>> changed to "#!/bin/sh" but it contains
>>> "BREW_PACKAGE=3D${CC_PACKAGE/-/@}" which is a bashism.
>>>
>>> Looking at seen:.github/workflows/main.yaml to skip running the tests
>>> one has to set "skip-tests: no" which is utterly confusing.
>>>
>>>  From what I saw scanning the patches there seemed to be a lot of
>>> churn, both of existing code and code that gets added and then
>>> moved/refactored within the series.
>>>
>>> Looking at the output of a recent ci run of seen the steps to prepare
>>> the environment before building and testing print all the environment
>>> variables rather than just the ones being set for that step which
>>> seems to go against the aim of "CI: narrow down variable definitions
>>> in --build and --test". (Also the "SKIP" prefix in the output lacks a
>>> ":")
>> Thanks. Those were all helpful. I replied to these in a re-roll CL
>> at:
>> https://lore.kernel.org/git/cover-v5-00.29-00000000000-20220421T181526Z-=
avarab@gmail.com/
>> [...]=20
>>> I think splitting out the build and test steps is a good idea but I'm
>>> less convinced by some of the other changes.
>> What other changes are you referring to here?
>
> Here's a list from memory - apologies if anything here has changed in
> v5

Thanks for following up, I think "probably not" re "anything changed"...

> Separating the environment setup from running the build/tests is quite
> github specific. If instead we just had scripts that setup the
> environment and ran the appropriate make command they could be used by
> any future CI setup. Doing that would avoid lib.sh being a top level
> script rather than a library as well.

The part where we do :

 - ci/lib.sh --build
 - make

Is very GitHub-specific, i.e. it's relying on the "setenv" wrapper
setting things in $GITHUB_ENV, which is then carried across "steps".

Now, it could just use "export" and have every "step" be the equivalent
of:

 - ci/lib.sh --build && make

I.e. to have it "export", and not use $GITHUB_ENV, but I think the
resulting UX is much better. I.e. the second step shows what variables
are in use by the "step" now.

And for future-proofing I think we're better off as far as CI
portability is concerned, and in fact I mostly want this so I can
trivially run things locally "like in CI".

Adding another CI is a trivial matter of either eval-ing the ci/lib.sh
output (which the tip commit emits instructions about how to do), or
echo-ing to whatever that CI's equivalent of $GITHUB_ENV is.

> I expected tput.sh to be some kind of wrapper around tput but it just
> sets $TERM if it is not already set. We already do that in lib.sh I
> think and I don't see what the point of changing that. I think we'd
> want to do that whenever TERM is not set, not just for github actions.

You're right that we could do that earlier, i.e. to stick it in
$GITHUB_ENV, but for these variables that were used only for some
implementation detail of the scripts themselves I wanted to "source"
them so they wouldn't appear in the variable list at the top.

I.e. that variable (unlike MAKEFLAGS etc.) isn't important to see how a
run failed, and how it was configured, it's just working around
platform-specific nits in the GitHub CI itself.

On the other hand it's just used in two places, and it's two lines, I
could just copy/paste it. Do you think that's better?

> Moving things from environment variables into MAKEFLAGS adds
> unnecessary complexity as we still have to export those variables on
> windows.

I may have gotten something wrong here, but I was careful to move only
the ones that are *for the Makefile* into MAKEFLAGS.

In most cases it's equivalent, but re $GITHUB_ENV dump readability it
makes it more obvious what's being set for what things. I.e. Makefile
itself v.s. the actual tests it then runs.

> The script to run docker builds and tests under a unprivileged user
> is just deleted rather than fixing our docker builds to not run as
> root. At the moment some of the httpd tests are skipped because they
> refuse to run as root.

What tests are being skipped? I may have gotten this horribly wrong, but
I "git rm'd" those as part of deleting more leftover dead Travis code. I
don't see where our current CI uses these at all.

*looks a bit*

I think you mean this, but this is in next (and master, but for some
reason that run wasn't there):
https://github.com/git/git/runs/6064756450?check_suite_focus=3Dtrue#step:5:=
1279

So we should probably fix that, but I think that's unrelated to my
series. It looks like we've been skipping those tests on GitHub CI ever
since we had it at all.

> One thing I do like is moving the environment setup out of the github
> actions yaml and into the scripts as it should make it easier to
> support other CI setups.

*nod*, I very much have that as a goal.
