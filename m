Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64F1FA373D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJUPwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiJUPwR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:52:17 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13253265505
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:52:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b12so7481389edd.6
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9SIHf94luf5uUR/ehzfkIMf11gQ40h5dcHYFQVmo2Gc=;
        b=jAJLm6vn41dlt9xWf7/VfQTYULZbZ9bv+yPJR8voPU3I3IaQ9d+yqkRSUDQJBqwkus
         xogBMv3SY/IKfKFen7W/bAnloUZ2tHWMycl55JbnUaNnxBWHgqbb0vOpIOOOw4d3AAcp
         2/XHqGirFHQaoHjZHtnnC07XI/qBX8vX89RgrbNHfIKHdiURE1avKePtZCXEp4n/vP9t
         UjhgF1cBOBbXlSALFhOvWA9kjXEz4tJed8x/JKztQdjyvUm8XFk3L2uma3CmbpFuXP0/
         kQHuD567ZEzSOCt5xFCZIw4FOa+LAQjQRq6YVN2E9AinPKmcn9lpqUI6P23BzOSXDIyp
         9TVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9SIHf94luf5uUR/ehzfkIMf11gQ40h5dcHYFQVmo2Gc=;
        b=s6K4++oHHxVAeD2EIA9c4gOBcVkQTfRQSk10ZMzhR+WfXGdNLItSyCeh3cKBNgCPUv
         aHfERi2PMcX5f9rzZSkAaCw2fuvjmAmKD40cVis3439KlIuQcLus6np1aPBT8qA7YeSx
         XH4m99B+G5JJx4xkuNZq1pdUkuI+1BS+9MtluIt0Qew/vFPUOikjSm4c0xD2pG9GfeAz
         JO0bP8ogZeLHo2fTYFnbw8ppNvumtN5rjXaQmN71FhL4CsRH7xAB8wSe/8lJxH9RvuCe
         +URl4tL+bbnE+IqEBTICbxeUGBvvfWiRc2N6b1arZdfZBrkvfG3vrmP1pOOJEU2ptE+I
         byiw==
X-Gm-Message-State: ACrzQf3X4cjkWZ9TGBamTkn8yZmj3lPdM+NHu7+jfKM9L4Nvz2LHk56x
        nBXfZ5+CPbya51phlLQZdrM=
X-Google-Smtp-Source: AMsMyM6wmUFTN2F403Odr0aVclJuW/4oxMTgTlLJMjR1GNxCup0tSPMs0eeEGuOyfVp/i1SavkxcCA==
X-Received: by 2002:a17:906:5a5f:b0:79f:9f1f:2fef with SMTP id my31-20020a1709065a5f00b0079f9f1f2fefmr201409ejc.396.1666367529378;
        Fri, 21 Oct 2022 08:52:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b6-20020a056402138600b00457b5ba968csm13816163edv.27.2022.10.21.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:52:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oluJb-0074FZ-21;
        Fri, 21 Oct 2022 17:52:07 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 7/9] cmake: support using GIT_TEST_OPTS from the
 environment
Date:   Fri, 21 Oct 2022 17:45:34 +0200
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <patch-7.9-fc9f036695f-20221021T091013Z-avarab@gmail.com>
 <830905ef-fb90-9b2a-c40a-67cf24f7a24b@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <830905ef-fb90-9b2a-c40a-67cf24f7a24b@dunelm.org.uk>
Message-ID: <221021.864jvxfa3c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 21/10/2022 10:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Get "GIT_TEST_OPTS" from the environment, and use it to pass arguments
>> to tests. This allows for passing arguments to tests with e.g.:
>> 	GIT_TEST_OPTS=3D"--verbose --debug" cmake .; ctest -R t0001
>> --verbose
>> There's some overlap with this and what was suggested in [1], but as
>> noted there we're not passing "--verbose" and friends unconditionally,
>> so a plain "ctest" invocation without a "cmake" re-build won't pick up
>> the options.
>
> The aim of dscho's patch was to make debugging information available
> in the test logs without the user having to do anything, now to get
> that information every user has to set
> GIT_TEST_OPTS=3D"--no-bin-wrappers --no-chain-lint -vx" when running
> cmake.
>
> I think it would be helpful to have some default options set if the
> user does not pass GIT_TEST_OPTS. Ideally one would be able to do
>
> 	GIT_TEST_OPTS=3D... ctest
>
> and have the tests pick up the options at runtime. Following on from
> my previous comment, if we used "sh -c" to launch the tests we could
> have something like
>
> 	COMMAND ${SH_EXE} -c [[GIT_TEST_BUILD_DIR=3D"$1"; . "$2"
> 	${GIT_TEST_OPTS:---no-bin-wrappers --no-chain-lint -vx}]]
> 	"${tsh}" "${CMAKE_BINARY_DIR}" "${tsh}"

That sounds reasonable to me. FWIW I looked into
$CTEST_INTERACTIVE_DEBUG_MODE for this purpose, i.e. to stick something
like this in test-lib.sh:

	if test -n "$CTEST_INTERACTIVE_DEBUG_MODE"
	then
		verbose=3Dt
		trace=3Dt
	fi

But I was hoping for some way to tell that "ctest" was in "--verbose"
mode, but AFAICT there's no way to get at that without something like
compat/linux/procinfo.c (basically a fancier way of parsing "ps auxf").

Anyway, as noted in my review of dscho's series I thought this part of
it was odd/outdated given that this thing runs on Linux (mostly, but
entirely after this series).

I.e. why would we hardcode Windows-specific trade-offs into a portable
build-system, and if you do want e.g. "--no-bin-wrappers" why would you
want that just when you run "cmake", not "make"? Surely if we're pushing
for a new default it should be agnostic to the user's build system.

But in any case I think if we're pushing for new (or cmake-specific)
opinionated defaults it makes sense to split those up & justify them
separately from bug fixes or workarounds.

E.g. 2/9 in this series makes much of the tests pass on *nix, but so
does "--no-bin-wrappers", but just because it happens to bypass the
broken-on-master bin-wrappers/* made by cmake.

