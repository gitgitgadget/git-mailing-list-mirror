Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003EDC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 13:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiJRNtF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiJRNs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 09:48:57 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEEBCE9BF
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 06:48:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d26so32282708ejc.8
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TC42zjym0By4gfFPztSyHy2/tEZVNaVqFIOeRbPLuh0=;
        b=dW3z/CguaD8JtltmqboMa4Jt9RPtrMrE0T67cQu0uyFMJxG3uBH1E7v5wNWCxia6Wo
         v+KVZND5sj03HFNjJpuOVyqbBDUmv4nrmBlSVwol+DqqdZSojeewmT/j6+ECLqQjT5R4
         JSJB5OKThGcSSWxEzkFk1be++n/dc2jTJjlZf6Aa8A0NBCUTIuWyG6iTfXtyiTGhV6HO
         ox7F/d5K4BHYv4XC3/O4CV7K5R2qV3IxorcQMdYMUcbGfu8BB7P6sf8eYTry1psS3cY4
         exJMr+pfKzIM+0NRYrNRdTfui35N/ysdJ6FFAE4cpPNh7NgKncYlC9XQFMclRX7NvSVf
         OrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TC42zjym0By4gfFPztSyHy2/tEZVNaVqFIOeRbPLuh0=;
        b=EcMG8ZHKaT9PPQIqmeWGqdtLMsTUJm9ruP0TYpdJ9LdtnKYsB75nS7UPAhfNActq00
         AsZ9mB1FbINtBYXnAQyAcnAdvL47OCKweycCI0mEbWeJ8nOhlf4ppOJXKzovEBpRjGQ0
         +9b9kzN0JxKQTgH5roXxmFGxaD0GwtQkUHIXGDJqizKaRFDD2hE0+FQcc751XK8JDOm9
         TbrRMFyRggaCV/HA0l6/9OwOn07WZwl6B8lbnxKChgBfK6h+EGZh3NGqSj5jVsg3NRch
         smDOS6eSfD+kEFd6Umjr0au9+jxG1lATJk9PsA6Wj588/eUqEuw+9d8Mfm77h75sSBOY
         VtKg==
X-Gm-Message-State: ACrzQf3Ks3XvbZCfXsl42ETQd5EeZ0JppaJ8ELv/AZ1Y0kMoYD03k7Tb
        a+xBiatc3CwqAuBJdezsKZiss0iFePDMNw==
X-Google-Smtp-Source: AMsMyM7GLpZqYkopnbk/j9YAz3HlzCMZHJVoolWBc/eO9CdOFciyNxHO3yqN7d1VR38MHgWo3hgJRg==
X-Received: by 2002:a17:907:a46:b0:782:1c1c:8141 with SMTP id be6-20020a1709070a4600b007821c1c8141mr2458436ejc.549.1666100934672;
        Tue, 18 Oct 2022 06:48:54 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kw8-20020a170907770800b007821f4bc328sm7721276ejc.178.2022.10.18.06.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 06:48:53 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okmxg-005mMT-2t;
        Tue, 18 Oct 2022 15:48:52 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/5] cmake: make it easier to diagnose regressions in
 CTest runs
Date:   Tue, 18 Oct 2022 15:41:43 +0200
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
 <356b2e9a1007bcd1382f26f333926ff0d5b9abe2.1666090745.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <356b2e9a1007bcd1382f26f333926ff0d5b9abe2.1666090745.git.gitgitgadget@gmail.com>
Message-ID: <221018.865yghi6nv.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When a test script fails in Git's test suite, the usual course of action
> is to re-run it using options to increase the verbosity of the output,
> e.g. `-v` and `-x`.
>
> Like in Git's CI runs, when running the tests in Visual Studio via the
> CTest route, it is cumbersome or at least requires a very unintuitive
> approach to pass options to the test scripts: the CMakeLists.txt file
> would have to be modified, passing the desired options to _all_ test
> scripts, and then the CMake Cache would have to be reconfigured before
> running the test in question individually. Unintuitive at best, and
> opposite to the niceties IDE users expect.
>
> So let's just pass those options by default: This will not clutter any
> output window but the log that is written to a log file will have
> information necessary to figure out test failures.
>
> While at it, also imitate what the Windows jobs in Git's CI runs do to
> accelerate running the test scripts: pass the `--no-bin-wrappers` and
> `--no-chain-lint` options.
>
> This makes the test runs noticeably faster because the `bin-wrappers/`
> scripts as well as the `chain-lint` code make heavy use of POSIX shell
> scripting, which is really, really slow on Windows due to the need to
> emulate POSIX behavior via the MSYS2 runtime. In a test by Eric
> Sunshine, it added two minutes (!) just to perform the chain-lint task.
>
> The idea of adding a CMake config option (=C3=A1 la `GIT_TEST_OPTS`) was
> considered during the development of this patch, but then dropped: such
> a setting is global, across _all_ tests, where e.g. `--run=3D...` would
> not make sense. Users wishing to override these new defaults are better
> advised running the test script manually, in a Git Bash, with full
> control over the command line.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  contrib/buildsystems/CMakeLists.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/C=
MakeLists.txt
> index 2237109b57f..6ac20bc5054 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1088,7 +1088,7 @@ file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]=
*.sh")
>  #test
>  foreach(tsh ${test_scipts})
>  	add_test(NAME ${tsh}
> -		COMMAND ${SH_EXE} ${tsh}
> +		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
>  		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>  endforeach()

This all seems sensible, but where you lose me is why this needs to be
cmake-specific.

Maybe I'm just missing something, but everything you're describing seems
to me to be Windows-specific, e.g. "chain lint is slow on windows" and
the like.

Why aren't we just declaring that it's not worth it on Windows, but
doing so in test-lib.sh, or at least doing it in both cmake's recipe &
the Makefile?

I can see why we'd e.g. want it not to run with "make test", but want it
when you run individual tests, but then both could just set some "this
is running as a batch" env flag or whatever.

Also, even then everything you're describing is eliding that:

 - This ill makes sense for Windows, sure, but the cmake recipe is no
   longer Windows-specific, was this authored before that happened &
   rebased? Why do we want cmake/ctest on Linux to have --no-chain-lint?

 - Having cmake be some "mostly the Makefile, but also other defaults"
   is really changing the scope of the whole cmake build alternative,
   which until now (but I may have missed some other special-cases) has
   been "let's build it like the Makefile".

 - That "ctest" doesn't work on Linux *at all* currently, this fixes it,
   but is really sweeping the underlying issue under the rug. AFAICT
   it's been limping along because there's no "chmod +x" or whatever on
   Windows (IIRC we magically look at she shebang).

For that last one & more I hacked up
https://github.com/avar/git/tree/avar/cmake-test-path a few days ago as
an alternative to some parts of this series, but given past exchanges
wanted to ask you first what you thought about it off-list, but didn't
get around to it..

But anyway, I do think starting with something like
https://github.com/avar/git/commit/5bd0ee2bc826d2bb358af9d93c88ba28584bbda1
makes more sense, i.e. get "ctest" to work at all with the
bin-wrappers/* in a portable way, and then *maybe* tweak it/Makefile to
pass some custom flags on some platform(s).
