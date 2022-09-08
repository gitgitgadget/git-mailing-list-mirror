Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A499BC38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 07:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiIHHjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 03:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIHHjF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 03:39:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687ED51CF
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 00:39:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nc14so36028032ejc.4
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=1kxtdsohUnm2s8c4JuH1ICTCXDmovCSdTbDTVIC5oEs=;
        b=nv3tLPsfNobVUJrdb2s2hAMwKe7YtDlfAvB42RgIkN0eUBBmTolpxT1KhcLJCk/yk0
         CW6SpTJQrAUdp0ycTj7FD/RhtE+Owfn039sgKyOuZi+oiFzIamEJyWS3QOK86aIwKEdI
         yyamWMZlD3xOpB2RBZO87WH/ahF5lyDoW5tMQJGlwDYn/jQkpmZHy1ISjj31SW3i2q9+
         OQsKsVHgwbl4IMPSBnKoxhT6RqieUV9NOq1JhA/bWApUNfuaF6GMCKESVPWqJ3VGCryy
         nD1CGJU3WCtBVxTwshtl84eifTsOT5zKzallc5stkcVgna3gHHs6YAIqIPkUQW4O22dw
         Nf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1kxtdsohUnm2s8c4JuH1ICTCXDmovCSdTbDTVIC5oEs=;
        b=Pe0J9FbVn/zWlxka24LbTD2n5yzXOd5uiRvN5pCxoDq8ERPjJ9OjfWgySV+kF1cmPQ
         Cm1GVC74852Rc53DUIOlsCZI3lZrXGKuGJdUQCL697+RjXySPd2B/ZokMdOEtKBZLTL5
         ggCCwDXGDK9FFBWkGKJ1hKHqfeS6vjjZFQpwSLruMMHNGTLHNk+1UuJFewEfItTa+ckj
         Vi1+kJaec8IpQCmckNmtK1cmUW7r31HMmTDy2f5jJFrqZ6CGg/xFYyOQd8jToxWUMduf
         9a+G9urhIo2uCIXXmw2bJygEY/50iBI+aGLxOb5Gxq6hbfjs53YB3+gMPlipBC25tBZd
         gGGw==
X-Gm-Message-State: ACgBeo1n68ia7Tl2owB7EKt7+WcSrGAAK4+VuKRP+z1Er8VtJiyj2YAJ
        /EPG735CblmdK3XgXIVCWS26KgOT5nbXhA==
X-Google-Smtp-Source: AA6agR5yFeYrIGs8Yafa1e0mNzyBu3t0ebvDo92VXSkAZEp4wPWwvPXJCuD3gIt/7p+C+VEqp5/HTg==
X-Received: by 2002:a17:907:7b93:b0:770:1d4f:4de9 with SMTP id ne19-20020a1709077b9300b007701d4f4de9mr5209490ejc.201.1662622742510;
        Thu, 08 Sep 2022 00:39:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kv24-20020a17090778d800b00773dbdd8205sm662448ejc.168.2022.09.08.00.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 00:39:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oWC7p-001H7t-0Q;
        Thu, 08 Sep 2022 09:39:01 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/5] cmake: increase time-out for a long-running test
Date:   Thu, 08 Sep 2022 09:34:28 +0200
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
        <6aaa675301cc56081d07974a0eb8662700fe96f8.1661243464.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6aaa675301cc56081d07974a0eb8662700fe96f8.1661243464.git.gitgitgadget@gmail.com>
Message-ID: <220908.86edwml3hm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 23 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> As suggested in
> https://github.com/git-for-windows/git/issues/3966#issuecomment-1221264238,
> t7112 can run for well over one hour, which seems to be the default
> maximum run time at least when running CTest-based tests in Visual
> Studio.
>
> Let's increase the time-out as a stop gap to unblock developers wishing
> to run Git's test suite in Visual Studio.
>
> Note: The actual run time is highly dependent on the circumstances. For
> example, in Git's CI runs, the Windows-based tests typically take a bit
> over 5 minutes to run. CI runs have the added benefit that Windows
> Defender (the common anti-malware scanner on Windows) is turned off,
> something many developers are not at liberty to do on their work
> stations. When Defender is turned on, even on this developer's high-end
> Ryzen system, t7112 takes over 15 minutes to run.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 29d7e236ae1..b1306f95256 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1088,4 +1088,8 @@ foreach(tsh ${test_scipts})
>  		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>  endforeach()
>  
> +# This test script takes an extremely long time and is known to time out even
> +# on fast machines because it requires in excess of one hour to run
> +set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
> +
>  endif()#BUILD_TESTING

I don't see per [1] that it would have any negative effect to just bump
the timeout a lot more, and for all the tests.

If we're running into 3600 seconds, then setting this to 4000 seconds
seems to be a smal stopgap at best. That's just over a 10% increase, so
if one person ran into it it 3600 someone with a slightly slower system
should be running into the same still, or if we just add a few more
tests to 7112 (or some other slow test).

So why not set this ta 3600*10 or whatever for *all* of the test scripts
instead of playing whack-a-mole?

1. https://cmake.org/cmake/help/latest/prop_test/TIMEOUT.html
