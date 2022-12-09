Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75354C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 14:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiLIOIl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiLIOII (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 09:08:08 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C3D7F894
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 06:06:11 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id fc4so11672252ejc.12
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2UVmn2AXu+jpnpCGVHyzlzUQvbvWV9ZX3bK5oc+M50=;
        b=OZHxWSHL0cINUZvpbr7GwyOZpfPXJkJXcFJ4MVVkF3k/dYhr4oXMYZ/lMJ3sXiMXrA
         B6lyKXXVdOmicTByrsQdF7EzYDDo8FiSoIVJaZtFU6RSaa6GwZsJZxTfADtEWRa+RLIf
         hVI6fj0ogkNsKwiaSTsG8k4VwuYAY8w7yr+17HPz+xsaRraPPIxdZySE1oqzEoFknIgK
         atz2t/5UM75r8YS31q9zciX1AY6BmQMlRJOuzXR6HpyEq8u//ugk+R1xHOWG/Yuvv2L/
         sBh0i73NxCbWmJBmVFPSqf/a69dDIDMoJoWhh8SnlZh03WFzLLl49qOaaUjJeIiRvD91
         YxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2UVmn2AXu+jpnpCGVHyzlzUQvbvWV9ZX3bK5oc+M50=;
        b=LN4LAJwtjh/rZ+PPkSuBPklXrD2TkORF+JyUApLOKnXqZwmIanvQE7/mLxFLx6rt8l
         Z52VIBdTkOL8+FOFLD7DNYcRL1xx6DhL6q2k3sPYiT1IhGMNbvH9AeXh6WvKJNlQrD8d
         4Mn2C4xVINY1V+gdQGrMqX/59fDfMSwxMWzWf7Ti6ZdwBBQraeAruXCJGwT98fTIwF5n
         ceE8tJncBiU7kciVHjMoCzjUALNODXh0GXQOmUTkmb105l3bUoz3MspOTCp+a/7GfxDq
         +hWfyBTSXM/wlUkYAoEDwSKMKjSaKoNdgqtmHOPVzTgFihm6CNqomi9UoCbCvIlOrJoi
         t0YA==
X-Gm-Message-State: ANoB5pkd4+2HuMHg19dHDwrTdnrrJ/uncoi/nPpExb7KM9yCbpRa8q3Z
        FU/J79M+O+OxZzUb/zmoChw=
X-Google-Smtp-Source: AA0mqf6i30vTD6IKzF6M4WcBQMLoi4/DovyWBdYKEzVgbOahdUOugdiOkzTAzOcwO4M6uSthDwbS0g==
X-Received: by 2002:a17:906:844:b0:7ad:fd3e:8fd4 with SMTP id f4-20020a170906084400b007adfd3e8fd4mr4531607ejd.69.1670594767366;
        Fri, 09 Dec 2022 06:06:07 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id v25-20020a17090606d900b0073dc5bb7c32sm604900ejb.64.2022.12.09.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:06:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p3e0q-0057lw-1s;
        Fri, 09 Dec 2022 15:06:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: ab/cmake-nix-and-ci, was Re: [PATCH] test-lib.sh: discover
 "git" in subdirs of "contrib/buildsystems/out"
Date:   Fri, 09 Dec 2022 14:55:08 +0100
References: <663b93ef-0c89-a5f6-1069-b4be97915d20@dunelm.org.uk>
        <patch-1.1-f27d8bd4491-20221201T162451Z-avarab@gmail.com>
        <xmqq5yeuspam.fsf@gitster.g>
        <87f22a55-ee84-2f76-7b9b-924a97f44f89@dunelm.org.uk>
        <221202.86sfhxg2ng.gmgdl@evledraar.gmail.com>
        <Y4qF3iHW2s+I0yNe@coredump.intra.peff.net>
        <221203.86pmd1dyqn.gmgdl@evledraar.gmail.com>
        <Y45/8WnuUnP9gOMo@nand.local>
        <Y46clyoKk9KzFiqj@coredump.intra.peff.net>
        <221206.86zgc1cnc3.gmgdl@evledraar.gmail.com>
        <Y46jT0i/7DhxHzfS@coredump.intra.peff.net>
        <221206.86mt81claa.gmgdl@evledraar.gmail.com>
        <xmqqilipnq8j.fsf@gitster.g>
        <30360f4c-91a5-177b-133f-eb7036ed676a@dunelm.org.uk>
        <221206.865yeodbtg.gmgdl@evledraar.gmail.com>
        <oq7p2776-po8p-r9s0-82o2-o77so874n419@tzk.qr>
        <xmqqk0311blt.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqk0311blt.fsf@gitster.g>
Message-ID: <221209.867cz07jub.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 09 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Junio, maybe you could clarify your take on this? As project lead, it is
>> your decision to define how Git uses Continuous Builds, and how the
>> project handles failed CI runs.
>
> I have pretty much been with what Peff and Taylor said in the thread
> already ever since we added CMake support to help Windows/VS folks.
> I agree with you that we do not need to run it for Linux or macOS,
> and if the promised/hoped-for benefit, i.e. that running them on
> non-Windows build would uncover issues that are common across the
> platform and help Windows, is not something that is likely to
> materialize, I'd prefer to see our resources (CI time and developer
> attention) not spent on that.

I think this should be addressed by the "I count less than 20 lines in a
~1.1k line recipe that are really "MSVC"-specific" in the sibling
mail[1]. I.e. the large majority of it is generic recipe code that's run
on all platforms.

> I do not think "how the project handles filed CI runs" is a very big
> issue.  I often ignore partial failures (e.g. "winVS(n) test job
> triggered rate limit") and the only annoyance I feel is that such a
> temporary failure contribute one more message to my trash mailbox,
> and I can learn to do the same for a test that marked as failed due
> to linux-cmake-ctest job.  I expect that regular contributors are
> doing the same pretty much.
>
> How blocking is a CI failure for drive-by contributors who use GGG?
> While I do not necessarily value drive-by contributions as much as
> you do, if such "an unimportant failure we can ignore" discourages
> those coming from GGG route, that would be unfortunate, exactly
> because they may not have contributed anything to the failures.
> This is not just cmake-ctest, but the leak checking job where a new
> use of a tool that is known to be leaky in a test can turn a test
> that has been passing to fail.  If we can mark failures in selected
> jobs as non-blocking, we definitely should do so.

I realize that we've been digressing to the larger topic of what to do
with CI in general, but I don't think the question of whether say
"win+VS build" should "soft fail" is something we should conflate with
this "ab/cmake-nix-and-ci" topic.

It doesn't change the status quo there, and I think is a net
improvement.

Even if we make the CI for anything cmake-related soft-fail, this topic
will still help to get it back up to speed, as you'll be able to run the
full cmake+ctest chain on non-Windows.

> Between keeping and marking linux-cmake-ctest as non-blocking, and
> removing it altogether, I am inclined to say that I'd favor the
> latter for the reasons I explained earlier in this message.  But to
> help casual contributors coming via GGG, we would anyway need to (1)
> allow submitting even with failing tests, and (2) tell them that it
> is OK to do so.  Which means it is not the end of the world, from
> the point of view of helping casual developers, if we had kept these
> brittle CI jobs like linux-cmake-ctest and linux-leaks.

I can peel off the commit that adds the "linux-cmake-ctest" CI job from
this series, or even just make it do the equivalent of:

	cmake && make || echo oops, we're broken

So it'll "soft-fail" (AFAIK GitHub CI, unlike GitLab[2] doesn't support
a native way to "soft-fail").

But I don't think that doing that would help without *also* making
"win+VS {build,test}" soft-fail. I.e. if "linux-cmake-ctest" *and*
"win+VS" (with all else passing) you can be pretty sure it's a generic
cmake problem.

If only one or the other is failing somewhere in cmake having the
"linux-cmake-ctest" job now will help narrow down whether it's a
platform-specific cmake issue.

So, just let me know what you'd prefer, but I think per the above even
if you're impatient with cmake failures the "linux-cmake-ctest" job
should help spend less time on them.

1. https://lore.kernel.org/git/221208.86wn726qcv.gmgdl@evledraar.gmail.com/
2. https://docs.gitlab.com/ee/ci/yaml/#allow_failure -- In the UX:
   green=passing, red=failing, yellow=soft-fail
