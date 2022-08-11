Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6EFC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 11:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiHKLv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 07:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiHKLvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 07:51:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BDA6567B
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:51:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w19so33070376ejc.7
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=bdTYh0oxuyjBI1ZP0WSXP3XuzWlnhp9/AHO68MU9ufI=;
        b=cqkTIANZDJ0Kb4VM4FRu90Xn/PG13BCr6RTuBX//ImCkUykJpQu8RGA1lKAZGjlpME
         fhXVbLAO2iO9OReC4IKtQ4rMunzqKP2ZmCU8llaPzeBP0rmWNLpie5F5YA2Oh+yzlOaw
         WnUlGCMveNQAHm5tO9nHdYKwHz+l4cc83GUALD/fIeSOYHVBgCQTV42iKG7Z0+L3iwB2
         C36L5U1w+si+LBovviyRuwU3lMth+K4TLFheZoQbewGq5/egJt4YukZe2fcUwV5YG0Ye
         94RUYXcUmepdMPmFnhcMt01dyo4qHiBbcK3LJUqKfTWX0xt/YUvUbSWReR27FOeNjCVE
         47yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bdTYh0oxuyjBI1ZP0WSXP3XuzWlnhp9/AHO68MU9ufI=;
        b=JHe8Qlrp9VQHh1RZixFefPLrBEjEsyQ5yoXE/tYn1pXj+6zqOGlvIJxCVtOTZodkza
         a57I7ZzlRyKiKFkQXsJN+mhlp0mU6D94H7ADB5VBPIwob54mqtqsP4+HkiJjWp3cvwBP
         gIjJj+WuKlEPlRNfqYQBcd5dXwBYLoLS0ajVSjODJBzk+ls4406EhL0cdlEuU9RWFdGS
         DQhLkT7XcvmZlfc5TD6ZDvUAcHsKfUS/QcFDSUXnhLlLaUobquuYw0YJ9ne0GOcgnBaJ
         rWz/ZgGdLkKBUjgPbp+88NyWAAdrk8dnzW7YXfzdjUyIp011e8R+cbwrLfK4qJsHT+mS
         uYxA==
X-Gm-Message-State: ACgBeo2OWiE2Hn6bcc7VoZRL02BPmpdw2AeQd96KXBdb2+Xy3B8hSfe1
        vl9ByNKaVbHbjnm2Qrl/IZ0=
X-Google-Smtp-Source: AA6agR7m/0+x1oeE/RyJcLsLTJXuNRkK4g1wepO7fH4fksL+aexnf/OhvFKBEXFA/w0p8GPh4r/1JQ==
X-Received: by 2002:a17:907:7241:b0:734:b282:184b with SMTP id ds1-20020a170907724100b00734b282184bmr1960756ejc.445.1660218681686;
        Thu, 11 Aug 2022 04:51:21 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a15-20020a056402168f00b0043aba618bf6sm8976894edv.80.2022.08.11.04.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 04:51:20 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oM6ie-001Cej-0n;
        Thu, 11 Aug 2022 13:51:20 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 5/5] cmake: avoid editing t/test-lib.sh
Date:   Thu, 11 Aug 2022 13:35:43 +0200
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <c7fc5a4ee4cbc49b8afb2f9579763482552fffb0.1660143750.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <c7fc5a4ee4cbc49b8afb2f9579763482552fffb0.1660143750.git.gitgitgadget@gmail.com>
Message-ID: <220811.86sfm3ov5z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 10 2022, Johannes Schindelin via GitGitGadget wrote:

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
> ---
>  .gitignore                          |  1 +
>  Makefile                            |  1 +
>  contrib/buildsystems/CMakeLists.txt |  7 +------
>  t/test-lib.sh                       | 11 ++++++++++-
>  4 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index a4522157641..b72ddf09346 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -2,6 +2,7 @@
>  /fuzz_corpora
>  /fuzz-pack-headers
>  /fuzz-pack-idx
> +/GIT-BUILD-DIR
>  /GIT-BUILD-OPTIONS
>  /GIT-CFLAGS
>  /GIT-LDFLAGS
> diff --git a/Makefile b/Makefile
> index 04d0fd1fe60..9347ed90da7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3028,6 +3028,7 @@ else
>  	@echo RUNTIME_PREFIX=\'false\' >>$@+
>  endif
>  	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
> +	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
>  
>  ### Detect Python interpreter path changes
>  ifndef NO_PYTHON
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index fe606c179f7..29d7e236ae1 100644
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
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 55857af601b..4468ac51f25 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -42,7 +42,16 @@ then
>  	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
>  fi
>  GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
> -if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
> +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> +then
> +	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> +	# On Windows, we must convert Windows paths lest they contain a colon
> +	case "$(uname -s)" in
> +	*MINGW*)
> +		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
> +		;;
> +	esac
> +elif test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
>  then
>  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>  	exit 1

So we'll now skip the assertion added in 9dbf20e7f62 (test-lib: correct
and assert TEST_DIRECTORY overriding, 2022-02-27), shouldn't these tests
run inside a "t" directory generated in contrib/buildsystems/ ?

This really seems like a hack-upon-hack, and will break some workflows
when you switch back & forth, e.g.:

	make
	# run cmake
	make -C t

Will now pick up this new file, and result in broken tests, as we'll
rely on the now-stale file.

IOW you're making the assumption that by piggy-backing on the
GIT-BUILD-OPTIONS rule that anything that needs it will also *re-run
it*, but that's not the case.

I can think of ways to get around it, but it would be nasty as we'd need
to complete the dependency graph between the two, and figure out the
various interactions.

But why do we need this at all? Right now I tried:

 * (Manually) removing the existing hack
 * Copying t/*lib*.sh over to contrib/buildsystems/t
 * cd contrib/buildsystems/t
 * ../../../t/t0001-init.sh 

Which (aside from a small fixable nit about oid-info) Just Works,
because the cmake build is already creating a GIT-BUILD-OPTIONS.

Presumably that "copying" step should be simlynking, or we'd be smarter
about doing includes from test-lib.sh.

But isn't that a much better approach? Rather than working around the
directory discovery just teach it to run from the generated t/ directory
directly?
