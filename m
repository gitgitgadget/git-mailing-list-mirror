Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F8C43217
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 14:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJROJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 10:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJROJi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 10:09:38 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F35120B6
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 07:09:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id k2so32493040ejr.2
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=st5Td/8qvq59lJHlSq0lpK56VFRGtZAb78veuxmiBKA=;
        b=Rh3gaDthjVH2Kj65EneQpdOVV4SvzCM+tRbm/AzavKqi6cNOCfJ2jU0J95cTldybHn
         7tY4w+OXfcSsndQyozTgMTufsl+weqCpbO5FDHOHl7X/ZbcUV27/JOsBio0g0cId+7BR
         J4cmC+gLaAdZFtIqM2gaOVdURjeToOWR8y0Fy6LIi+KImQAqIjbcUPwYSDbfam3QbRiE
         yzz4OhcE3rn29VcPpPP89JuZUyWc+8LtqAK5364wZ9UiSHJq3wfgTr3uo4liX1oJHn2h
         Pzn5NzIXdVbBsgGyZ/Wum1ddBbEAOGfxMIjPi2o8XhGtcx3iGP7mHPbpVDcvGccInU21
         YE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st5Td/8qvq59lJHlSq0lpK56VFRGtZAb78veuxmiBKA=;
        b=HkwYhiA5bIn4wDH5koyBIJjk5gVwZW+mzyeLav55K3rya3YLjhU0rY3H/onWQMAQWr
         wRrWZGScMxOFoxS55rwUK+CpMcoRqYgzzrKaGfxb3b8+zFcb+dbYed8Rh6WXDEm78YvH
         kDoL3q091rngeauNXeXx6y+oVMDe4X1yuKJOX63zzpJvrRr2Y+H0gVYLjkxXBLwwLj1U
         KaCyoqJlhTD61Ir5+62w+kjZUfDLX00WaFfjj7LceQFLwDTZvCjTMWZME1OXRT/qLqB/
         7kXJMz+IbS5z8nnP2Ew04G5QjV2DR/Y2L+UR6MohywO9w0NNroDXqlOdMAqBk3QGA+ge
         7LZw==
X-Gm-Message-State: ACrzQf2Ygbn2x8Bl4/3r0sNbDqTqCobnwF+Qsge5l72u6I95H6qIxoZg
        bWHPQYMGomxGJYA/EV7YEFeMvtViNA1w+g==
X-Google-Smtp-Source: AMsMyM5ehmz0Hanpm2GqP930CjzcX/DTEjAE2VG6aYCE8w5Tp5kXObs7QssE/tN8RwRgZmgtYMjOKg==
X-Received: by 2002:a17:907:9710:b0:791:8aa6:18bb with SMTP id jg16-20020a170907971000b007918aa618bbmr2484400ejc.279.1666102169099;
        Tue, 18 Oct 2022 07:09:29 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906300c00b0077a1dd3e7b7sm7674065ejz.102.2022.10.18.07.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 07:09:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oknHb-005n1X-2K;
        Tue, 18 Oct 2022 16:09:27 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 4/5] cmake: avoid editing t/test-lib.sh
Date:   Tue, 18 Oct 2022 15:54:25 +0200
References: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <pull.1320.v3.git.1666090745.gitgitgadget@gmail.com>
 <5b0c2a150e9fce1ca0284d65628b42ed5a7aad9a.1666090745.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <5b0c2a150e9fce1ca0284d65628b42ed5a7aad9a.1666090745.git.gitgitgadget@gmail.com>
Message-ID: <221018.86sfjlgr54.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 7f5397a07c6c (cmake: support for testing git when building out of the
> source tree, 2020-06-26), we implemented support for running Git's test
> scripts even after building Git in a different directory than the source
> directory.
>
> The way we did this was to edit the file `t/test-lib.sh` to override
> `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
> directory.
>
> This is unideal because it always leaves a tracked file marked as
> modified, and it is all too easy to commit that change by mistake.
>
> Let's change the strategy by teaching `t/test-lib.sh` to detect the
> presence of a file called `GIT-BUILD-DIR` in the source directory. If it
> exists, the contents are interpreted as the location to the _actual_
> build directory. We then write this file as part of the CTest
> definition.
>
> To support building Git via a regular `make` invocation after building
> it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (for
> convenience, this is done as part of the Makefile rule that is already
> run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
> up to date).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Re my earlier feedback, I came up with this as an alternative, which
nicely allows us to have "cmake" and "make" play together, you can even
run them concurrently!:

	https://github.com/avar/git/commit/30f2265fd07aee97ea66f6e84a824d85d241e245

In case that OID changes it's on my
https://github.com/avar/git/commits/avar/cmake-test-path branch,
currently 30f2265fd07 (cmake & test-lib.sh: add a $GIT_SOURCE_DIR
variable, 2022-10-14).

And it...

> diff --git a/Makefile b/Makefile
> index 88178c5b466..886614340c7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3029,6 +3029,7 @@ else
>  	@echo RUNTIME_PREFIX=\'false\' >>$@+
>  endif
>  	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> +	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi

...allows us to get rid of this, which you understandably need with your
approach, but which I'd *really* prefer we not have. Let's not sneak
things into make's dependency DAG that it doesn't know about in FORCE'd
shell command (but more on that later).

>  ### Detect Python interpreter path changes
>  ifndef NO_PYTHON
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 0c741e7d878..1d8cebb4cfe 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -1067,14 +1067,9 @@ endif()
>  #Make the tests work when building out of the source tree
>  get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
>  if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
> -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
> -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
>  	#Setting the build directory in test-lib.sh before running tests
>  	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
> -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
> -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
> -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> +		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
>  	#misc copies
>  	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)
>  	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)

...and this whole section just goes away, we don't need any
cmake-specifi hacking here, and actually it's not cmake-specific at
all. It's just a "GIT_TEST_INSTALLED for things that are built, not
installed". E.g.:

            (cd g/git.scratch && make)
            (cd g/git && make clean && GIT_TEST_BUILD_DIR="$PWD/../git.scratch" make -C t)

Supporting cmake then just becomes a special-case of test-lib.sh knowing
"hey, my built stuff is at <dir> instead of "../".

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 120f11812c3..dfc0144ed3b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -47,6 +47,16 @@ then
>  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>  	exit 1
>  fi
> +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> +then
> +	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> +	# On Windows, we must convert Windows paths lest they contain a colon
> +	case "$(uname -s)" in
> +	*MINGW*)
> +		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
> +		;;
> +	esac
> +fi

...but one thing that I migh thave missed (and would really appreciate
your testing for) is that I didn't invoke cygpath in my version. CI
passes, but since Windows CI doesn't use "ctest" that doesn't tell us
much, and in any case that's Cygwin, no, which we don't run anyway
there?

Anyway, we could run that "cypath" easily in the cmake recipe itself, or
just pass a "hey, please make this canonical" flag to test-lib.sh.

But anyway, one thing that approach explicitly leaves out is that you
want to be able to:

 1. Build with cmake
 2. cd t
 3. Run a test

And have the test itself know to locate and use the cmake binaries
instead of the "main" binaries.

Now, I suspect that we don't actually have cases anyone cares about
where we have *both*, but that's how this code behaves. I.e. a
top-level:

	make test

Will wpe that GIT-BUILD-DIR and use the "make" built "git", but e.g.:

	make
	<build with cmake>
	cd t
	# At this point I forgot I used cmake earlier
	./t0001-init.sh # silently uses cmake...

I can see thy case for auto-discovery, per the IDE case you mentioned,
but isn't it much better to just make this part of the slightly later
part (but we need to set it up here now) part where we discover the
built "git" and:

 A. Do we not have it in ../git?
 B. Do we have it it contrib/buildsystems/out/git

Then (pseudocode):

	if (!A && B)
		use_cmake();
	else if (A && B)
		die("you have both, pick one!");

Or just say that "make" entry points always run with stuff it built, and
"ctest" runs with contrib/buildsystems/out/git, that's explicitly what
you don't want though...

Anyway, to wrap this up, I really wish the interaction between the two
wouldn't have these pitfalls. I get that you want to support it on the
specific Windows IDE case, but can't we more narrowlry do that without:

	(cd t && ./t0001-init.sh)

Having this new "pick either one" behavior? Cheers.
		


