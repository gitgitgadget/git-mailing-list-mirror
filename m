Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56731C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 07:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIHH3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 03:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIHH24 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 03:28:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C11B8F13
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 00:28:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so23018713edd.4
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=pU1pI4oR6PRyCo5ZLCdcwm6O/wfQWbMadB2T5AR8viQ=;
        b=FsKDTYzyxf3ImSE2SYZ4XRbDlL43JOxwEqdB/MtUoxk7fxVq4UyMMuYYAoHBGpcQ45
         ms/xuYJw5jYOtTKQz1O32fpwYd+nR+8OjDhRJWkFEAzXx0eZIiuDiOgxR0MiC5/k+cna
         3MXlqr4lphHURID1M/3vsNhT7kYoljUMUQxyfcLAHOgqZ+6XXeNSa8yRt9EqjXKo8sU5
         tIQ+a4CGbGt3u1HyoaDYM56iwf3lAtvR2VuvdSOBdlUyl05ur5Xp3jhdRpseTYj0UWu0
         4iQwAAat8Gb0gU402uxtI5CT7NPIenQKx4ICG9e2Sby1TDL5TC+tj8O1zuC0fC7vGn8g
         aQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=pU1pI4oR6PRyCo5ZLCdcwm6O/wfQWbMadB2T5AR8viQ=;
        b=dcYZ+uoiNEvMGDiJkKk1FRhB3ZL0ZEFR98vcWbwl2LGe/NwxvujknWOWhlTe8053IT
         ApaTFt/bialvgmCdpeOrtKia46F99/OdH3TnAAWHstSY0Xx0Li5ES+wkROa058j84eS3
         P2n8y9qly04ulsWI8A51Cj0fCb61r0b09Kf4RRtdPrddsKKenQuLRJ1arsoQJSx6CskX
         hcXNRj8D0ZJ1GsP2w6AEc4aOrQfCZ5ZNEpp3N5VdP7foRT9vH3GcGmFiWQOuHXlnRasg
         U22ySfs3XyWEAdjEGyqg+30JB6HCm0GFedhvJFaztcM9VaOk0ohya3aGazWm4ZEnGick
         ExSQ==
X-Gm-Message-State: ACgBeo0QBXCImL7OvuH/7MjYa1PAN+7RUlBd6BtFF5dCBAI3CYfoP44m
        Q2Hx3PVltZE2iYzPWwT6g1v5/sXdSjke5w==
X-Google-Smtp-Source: AA6agR5wGZIE0JkoGiUHk/qluPf1JKJdLnebwIdrSkdrIonWfmw1aiFhqTFS2H+5Ppl9PX0zVL8uLw==
X-Received: by 2002:a05:6402:1d8c:b0:44e:dec5:512b with SMTP id dk12-20020a0564021d8c00b0044edec5512bmr5924055edb.408.1662622129293;
        Thu, 08 Sep 2022 00:28:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7cb87000000b0044ea7b8f57bsm6349295edt.1.2022.09.08.00.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 00:28:48 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oWBxv-001Gk8-29;
        Thu, 08 Sep 2022 09:28:47 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH v2 1/5] cmake: make it easier to diagnose regressions in
 CTest runs
Date:   Thu, 08 Sep 2022 09:22:10 +0200
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <e00cb37b98ac09cff010e843ef19eeec761f8985.1661243463.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <e00cb37b98ac09cff010e843ef19eeec761f8985.1661243463.git.gitgitgadget@gmail.com>
Message-ID: <220908.86illyl3yo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Aug 23 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When a test script fails in Git's test suite, the usual course of action
> is to re-run it using options to increase the verbosity of the output,
> e.g. `-v` and `-x`.
>
> Like in Git's CI runs, when running the tests in Visual Studio via the
> CTest route, it is cumbersome or at least requires a very unintuitive
> approach to pass options to the test scripts.
>
> So let's just pass those options by default: This will not clutter any
> output window but the log that is written to a log file will have
> information necessary to figure out test failures.
>
> While at it, also imitate what the Windows jobs in Git's CI runs do to
> accelerate running the test scripts: pass the `--no-bin-wrappers` and
> `--no-chain-lint` options. This makes the test runs noticeably faster
> because the `bin-wrappers/` scripts as well as the `chain-lint` code
> make heavy use of POSIX shell scripting, which is really, really slow on
> Windows due to the need to emulate POSIX behavior via the MSYS2 runtime.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 1b23f2440d8..4aee1e24342 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1088,7 +1088,7 @@ file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>  #test
>  foreach(tsh ${test_scipts})
>  	add_test(NAME ${tsh}
> -		COMMAND ${SH_EXE} ${tsh}
> +		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
>  		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>  endforeach()

The -vx part of this looks sensible, and matches the commit message
$subject.

I think the "--no-bin-wrappers --no-chain-lint" and the "while at it"
here should be stripped out, and put into its own commit.

Which, as I commented on in the v1[1] is making the implicit assumption
that this cmake file is only used on Windows, but since 561962479c
(cmake: fix CMakeLists.txt on Linux, 2022-05-24) that isn't the case.

So, perhaps we should have a performance hack due to Windows's slowness,
but:

 A. It should be guarded by some "is windows?" check. Your commit
    message justifies why this is a good idea on Windows, but completely
    elides over the fact that this isn't Windows-specific code anymore.

 B. We can still build wind "make" or "cmake", I don't see a reason for
    why such a perf hack (if we decide to keep it) should depend on the
    build system.

 C. Since I sent [1] we've had submitted chainlint.pl in-flight
    series. It's partly trying to take special considerations to be fast
    on Windows. I don't think it's the case with that series that this
    needs to be skipped on Windows anymore (and if it is, Eric would
    like to know).

1.  https://lore.kernel.org/git/220811.861qtnqb5p.gmgdl@evledraar.gmail.com/
