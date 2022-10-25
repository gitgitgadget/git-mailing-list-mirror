Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD98EFA373E
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 20:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiJYUhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 16:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJYUhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 16:37:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08BAD0188
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 13:37:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x2so10935072edd.2
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 13:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xhc8peQ6PknMFTOSYy1oTWlmbS8IaBaeu+5lcLYRzLM=;
        b=QyGJrg+brnkIq/KsIOSioaauepel5Q2xEuKXikewmGZPl+5C0k8Ni6EcZnsl/fWgBj
         AGNK9JIW1OhzRQ4B1eisSmT9h2qWrZ6yl0iFWqZ0OnQ7b5Y44iN2x2cw/N2wsXLBqWUp
         eIgf74+f/q7a20/6s2++ptLiRIZ4DyOYXne/FBpRCrnqb24k7z1imz2kDKkWBzuCAvzA
         +w0oUK40BAmFLseJLr7/cZXcoMbFRVjJLwikKah/JBZXs8fY4vZvNU2x5Fj+rJIpqOsc
         YPHtdkKbIkyO6bEVcwLy/C/3YLXJGp9KHSAJFmVbVkWLYby0mCAVt63kHtnertmDhgug
         yBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhc8peQ6PknMFTOSYy1oTWlmbS8IaBaeu+5lcLYRzLM=;
        b=MJMJQxm06vjZRilASe1J4zypaP1Kb+00xLiQ9VCAJxjnK7nvK1zohrOBksUxIJQfHq
         xXJ9x0135jIbVSjwZjGnHDWvQYp9qxr0UgHtguGRuj70QwqwOYherhTurjelChipQn7d
         1csqhiC7TrITREIjDcjfaOG+KmUB1SDt7BgEAmDwp79bw0ApoCAhYNOuUX6rxfZHJQkn
         /iFy2aTinRYbaGsL1uIBSDBH5f3Ce4mxkM3y+8YWSUS7YAudP7ZMvLjWJB6qFV4XwGSb
         7MoRcYUCEVxI//1w6Qd+QW/orhAYbRtwat+90WlAEICACILW6F4S873IYU+68crc3y/Q
         SjXA==
X-Gm-Message-State: ACrzQf1UyW4sIwFK+uFG3AaNZFVr/60KrMmeuxxuQ3mLm3fGGdp6Jjy5
        frYE9O0mNaK93A1Vrc8ezGU=
X-Google-Smtp-Source: AMsMyM6CtUHQkkPVFsnFIYlEvLBz5TwbJJZvxGMcZ8mB2P/8zXRuBrrZeOlcxO2Ep+6dd8fBt2QbqQ==
X-Received: by 2002:a05:6402:348f:b0:461:8a9d:2e37 with SMTP id v15-20020a056402348f00b004618a9d2e37mr16388597edc.150.1666730233322;
        Tue, 25 Oct 2022 13:37:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7d347000000b00457b5ba968csm2192843edr.27.2022.10.25.13.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:37:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onQff-008EOz-2l;
        Tue, 25 Oct 2022 22:37:11 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 7/9] cmake: support using GIT_TEST_OPTS from the
 environment
Date:   Tue, 25 Oct 2022 22:18:08 +0200
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
        <patch-7.9-fc9f036695f-20221021T091013Z-avarab@gmail.com>
        <830905ef-fb90-9b2a-c40a-67cf24f7a24b@dunelm.org.uk>
        <221021.864jvxfa3c.gmgdl@evledraar.gmail.com>
        <494668dc-9df0-ee20-1cc1-bd5f01d1dc19@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <494668dc-9df0-ee20-1cc1-bd5f01d1dc19@dunelm.org.uk>
Message-ID: <221025.86bkpzd4i0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 25 2022, Phillip Wood wrote:

> On 21/10/2022 16:45, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Oct 21 2022, Phillip Wood wrote:
>>=20
>>> Hi =C3=86var
>>>
>>> On 21/10/2022 10:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> Get "GIT_TEST_OPTS" from the environment, and use it to pass arguments
>>>> to tests. This allows for passing arguments to tests with e.g.:
>>>> 	GIT_TEST_OPTS=3D"--verbose --debug" cmake .; ctest -R t0001
>>>> --verbose
>>>> There's some overlap with this and what was suggested in [1], but as
>>>> noted there we're not passing "--verbose" and friends unconditionally,
>>>> so a plain "ctest" invocation without a "cmake" re-build won't pick up
>>>> the options.
>>>
>>> The aim of dscho's patch was to make debugging information available
>>> in the test logs without the user having to do anything, now to get
>>> that information every user has to set
>>> GIT_TEST_OPTS=3D"--no-bin-wrappers --no-chain-lint -vx" when running
>>> cmake.
>>>
>>> I think it would be helpful to have some default options set if the
>>> user does not pass GIT_TEST_OPTS. Ideally one would be able to do
>>>
>>> 	GIT_TEST_OPTS=3D... ctest
>>>
>>> and have the tests pick up the options at runtime. Following on from
>>> my previous comment, if we used "sh -c" to launch the tests we could
>>> have something like
>>>
>>> 	COMMAND ${SH_EXE} -c [[GIT_TEST_BUILD_DIR=3D"$1"; . "$2"
>>> 	${GIT_TEST_OPTS:---no-bin-wrappers --no-chain-lint -vx}]]
>>> 	"${tsh}" "${CMAKE_BINARY_DIR}" "${tsh}"
>> That sounds reasonable to me. FWIW I looked into
>> $CTEST_INTERACTIVE_DEBUG_MODE for this purpose, i.e. to stick something
>> like this in test-lib.sh:
>> 	if test -n "$CTEST_INTERACTIVE_DEBUG_MODE"
>> 	then
>> 		verbose=3Dt
>> 		trace=3Dt
>> 	fi
>
> I think it is useful to have -vx set even if we're not passing
> --verbose to ctest[...]

Yeah, and to clarify, that's basically what this is, i.e. you don't need
to pass --verbose.

> [...] as if a test fails we've got the information to debug it stored
> in ctest's log without having to re-run the test.

Yes, that's sounds useful, but I'm still entirely unclear on why that
needs to be build-system specific.

I.e. you'll have the same with "make test" and "--verbose-log", with
ctest the equivalent of a hypothetical "--tee-to-al-log" is the default,
so we're partway towards a "--verbose-log".

Is it just an omission and we should add it to t/Makefile and/or
t/test-lib.sh eventually, or something cmake/ctest-specific in some way
I don't get?

>> But I was hoping for some way to tell that "ctest" was in "--verbose"
>> mode, but AFAICT there's no way to get at that without something like
>> compat/linux/procinfo.c (basically a fancier way of parsing "ps auxf").
>> Anyway, as noted in my review of dscho's series I thought this part
>> of
>> it was odd/outdated given that this thing runs on Linux (mostly, but
>> entirely after this series).
>> I.e. why would we hardcode Windows-specific trade-offs into a
>> portable
>> build-system, and if you do want e.g. "--no-bin-wrappers" why would you
>> want that just when you run "cmake", not "make"? Surely if we're pushing
>> for a new default it should be agnostic to the user's build system.
>> But in any case I think if we're pushing for new (or cmake-specific)
>> opinionated defaults it makes sense to split those up & justify them
>> separately from bug fixes or workarounds.
>> E.g. 2/9 in this series makes much of the tests pass on *nix, but so
>> does "--no-bin-wrappers", but just because it happens to bypass the
>> broken-on-master bin-wrappers/* made by cmake.
>
> I agree that --no-chain-lint --no-bin-wrappers are there just for
> windows. We could quite easily add those just for windows builds but
> the cmake build is basically only there for windows and the linux
> support is just there to allow testing the cmake build without having
> to run the ci.

That part makes sense.
