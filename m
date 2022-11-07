Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B5C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 21:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbiKGVQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 16:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbiKGVQH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 16:16:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236852FC02
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 13:12:31 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id y14so33538226ejd.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 13:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qrRzniun0q4q7QPcgjiE1I25aw/F0Z29a6fMAIzAFQU=;
        b=NxHmm0rqR7p82m7hVGD8aeYfmc8q0Vw+IXxvNIRtPusoqJZhk4xjdVh2YNnW5tSBfq
         QCfCKAgY2B554pRkMXwIpqaDDIV4tMLIvBHazCYT1rnWLGsvvHTjYJcRMd/jiKbLf2R4
         mBvzG0vdPoc9EZkRfOhgJ4NZcv7yKQMx7y2lsFAREmXdcaDwkKwbMXgRxWKV7QRNqweQ
         Ac8cx7Yz1vHKx9QSRzvavSov1R80tjOqNRttxWc+mybN6fDqFu3bJf408xkREPEOeFt5
         PJr3ld31jmtOwvrwDLgkS3RLdm2X64YCbok5Pl/OZBFlMNUk9Mz8MlC7guxlrm6nrJuv
         1rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrRzniun0q4q7QPcgjiE1I25aw/F0Z29a6fMAIzAFQU=;
        b=4vxZk5sfgwTG6cV3EDIULrz8ugyIzl467NQIAey3VqqscQecGSWJUGgH2ACNZ/RDVy
         hyFg9WDxFb5blRRvL4Nys4RA/6GcUum7adPsniS/yBlCezPXeHilHHWNOOaQp3xCje55
         7onD1bB5W9lWX7FschwZKbzHTE7erNwiUgtRBsPJcjNPHxLvCJRSTafQwQARBQwSUf3j
         m4B3l/3JbCq9X44SdJ7bj+0LfaX0HhT5sekc6EtWNRvRWFvuGbB1vHxh5UgW+AJrTOTC
         qql0lycGTT2xGvMdcAwIIkqquAhl/1JrYeK5GkOTrHG3r2J56T9GCSvDS92ZhcoH4Rmw
         /q7w==
X-Gm-Message-State: ACrzQf16Cgqk3fAgwvkdnGM60WYuoz6hVt3Gncpv9BpHFr4njLXNLdPz
        iTQQ1KwYvuBW990nswXMD7s=
X-Google-Smtp-Source: AMsMyM6tIlq5OdpArOvgtGWPD4VnsYuO2cx58CkqKfsz9gQrbQf0teoyxloDg0A+YT9/htoUldBvUA==
X-Received: by 2002:a17:907:6a09:b0:7ae:2793:aa23 with SMTP id rf9-20020a1709076a0900b007ae2793aa23mr20836806ejc.184.1667855549401;
        Mon, 07 Nov 2022 13:12:29 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id lj18-20020a170906f9d200b007adade0e9easm3824797ejb.85.2022.11.07.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:12:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os9Pv-000LBK-1u;
        Mon, 07 Nov 2022 22:12:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: avoid unnecessary builds
Date:   Mon, 07 Nov 2022 22:03:23 +0100
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
        <f975f57e-71e2-3227-8039-14dff82f04db@github.com>
        <Y2liOzOFLyz4uzd0@nand.local>
        <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <85b30a45-e00e-44b5-ae4a-b09542a9fb19@github.com>
Message-ID: <221107.865yfqv58k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Derrick Stolee wrote:

> On 11/7/22 2:53 PM, Taylor Blau wrote:
>> On Mon, Nov 07, 2022 at 02:45:24PM -0500, Derrick Stolee wrote:
>>> On 11/3/22 9:34 AM, Johannes Schindelin via GitGitGadget wrote:
>>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>>
>>>> Whenever a branch is pushed to a repository which has GitHub Actions
>>>> enabled, a bunch of new workflow runs are started.
>>>>
>>>> We sometimes see contributors push multiple branch updates in rapid
>>>> succession, which in conjunction with the impressive time swallowed by
>>>> even just a single CI build frequently leads to many queued-up runs.
>>>>
>>>> This is particularly problematic in the case of Pull Requests where a
>>>> single contributor can easily (inadvertently) prevent timely builds for
>>>> other contributors.
>>>
>>> As someone who is both the cause and the victim of this, I
>>> thank you for finding a way to reduce wasted CPU time. This
>>> patch looks good to me, though I'll need to trust the docs
>>> and your testing to be sure it will work. We will definitely
>>> see it in place as it merges into 'next' and 'main'.
>>=20
>> I wonder how we should treat =C3=86var's concerns in this thread. I susp=
ect
>> that the vast majority of workflows wouldn't be affected, but I don't
>> want to completely break =C3=86var's workflow, either ;-).
>>=20
>> Some kind of configuration mechanism like I proposed might be nice.
>> Thoughts?
>
> Taking a look at that sub-thread, I have two thoughts:
>
> 1. I don't think supporting a "multiple pushes of WIP work"
>    scenario is a good use of "free" resources. If you want to
>    test multiple versions of something, then use multiple
>    branches (and I think Johannes's patch allows concurrent
>    builds for distinct branch names).

The setting Taylor proposed in
https://lore.kernel.org/git/Y2R3vJf1A2KOZwA7@nand.local/ is off by
default, i.e. it would behave the same way as what Johannes is
proposing, just give you (well, me) an opt-out from the default, without
patching main.yml on every branch.

So it seems like a win-win, why force others to change their workflow?
Sure, I could push multiple branches, but you could also manually cancel
your outstanding jobs before re-pushing...

I agree that cancelling the outstanding job is a better default, and if
we had to pick one or the other I'd say "sure", but if we can have
both...

> 2. The change you recommend requires running the job and
>    deciding at runtime whether to do the actual build
>    (unless I'm mistaken). It is better to let the workflow
>    coordinator decide on concurrency before the stage where
>    worker VMs are engaged.

Doesn't the "concurrency" setting say "I am a job thaht's prepared to
have its run cancelled if another job shows up with this <key>".

I.e. we'd already be running the VM by definition if we're going to
benefit from it (very tight races aside), and in any case getting to the
"configure" stage doesn't require much in the way of resources, a few
seconds of VM time...

Whereas the "this tree already ran" *would* benefit from not starting a
VM, but that's "I'm a new push, and maybe I shouldn't run at all",
whereas this feature is "I always want to run, but someone might cancel
me later".

> Either of these points may have an incorrect assumption, so
> I'm prepared to be wrong.

I *think* you're wrong about #2, but I'm not sure either.

I don't think you can be wrong about #1, "others should change their
workflow to fit a new worldview" is more of a value-judgment :)
