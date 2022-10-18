Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08A7C433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 15:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJRPNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 11:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJRPNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 11:13:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1DBC45D
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 08:13:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so32921360ejb.13
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4XTLcwNQKfW6qfjbys3iuee/lAEeF4DuZc2jdKUefHI=;
        b=Kjudu8BmGs4KPPqnJOAlOVO0oPPin+2ZKgkBrW61rukzxyiPtz9Y5+JdAvdrwZMH1/
         Y2N+iLl01tR6/JK+9CuZtcm8K76rAmmcj0bGTIfZkHOwSyApT71mpxuiOBMqO/QScrrm
         b0tJGaU+CtVI/7+TyJkF2u+in2ehNPw1NzuPPf604m3rz8LcVDovz2ZPi2IqB2R/NwUC
         gXK849+JmWDxgyL4a+QBK0Z6giL9hvmiLgiPZhuwWzxteQtE2l7pjqwQ5RaBIZDlHa8K
         dfBXq3d40mz+aM1mo48/f1PQE3HbRcKncDzfhP3kLdOagdEOGSvADa7jTEHd9yCCXnBN
         ZTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4XTLcwNQKfW6qfjbys3iuee/lAEeF4DuZc2jdKUefHI=;
        b=Y3m6Y4uJCyhHUWGAnuhJOLW/SM7FsHZumQ3ONKBItE4wxshGcX714ahIALzmTQlLbE
         JgP/nrn80t7y42FlogdCZeV1NTP70SDE1qVubYTkSxsDbr3vlTyVuPs3vSGEcl1cmwOr
         U1c1qLXtZA9bONY9SlqF45IT6MMr6PFetI513fQ8k4D4RvhksKzB49EabUCXvVr1xe4O
         7e5S8hb/ZGcM7zpNQM2iNxneaWGejsytz4GvBUB7dfkYv3H4vuoy1K1jseYsVipltv/K
         C6Dq3JC2fWxIXMN4FDwWYvLhNsrxNYlw+XNXXooaufcHsU+dMd7NkdgGfdCd97XfTSa/
         bxTw==
X-Gm-Message-State: ACrzQf0vSwBlIZBvqI0NSVwcW6VrakF9r+A28STMzVppxOR1iv89+cqz
        zMzdDb5cdKeGEPU3nV0kWfk=
X-Google-Smtp-Source: AMsMyM6xYqWd/Qek3L56G4WQ0hDkvXfTJIOyK6/1WPRbqGQXw3ydtjJiJCvHWsR8UhPDBnpg+SQnpg==
X-Received: by 2002:a17:907:7207:b0:78d:9b37:8d0c with SMTP id dr7-20020a170907720700b0078d9b378d0cmr2792720ejc.717.1666106022565;
        Tue, 18 Oct 2022 08:13:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709067c9300b00770880dfc4fsm7699979ejo.29.2022.10.18.08.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:13:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1okoHk-005ndd-1t;
        Tue, 18 Oct 2022 17:13:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 4/5] cmake: avoid editing t/test-lib.sh
Date:   Tue, 18 Oct 2022 17:09:44 +0200
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
 <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
 <22473d6b8f3d4e4c482c27a4fb3b58705d4c93ca.1661243463.git.gitgitgadget@gmail.com>
 <220908.86a67al3c1.gmgdl@evledraar.gmail.com>
 <851094n0-2o53-77n8-41o6-773q479q5sqq@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <851094n0-2o53-77n8-41o6-773q479q5sqq@tzk.qr>
Message-ID: <221018.86o7u9go63.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 18 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 8 Sep 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Aug 23 2022, Johannes Schindelin via GitGitGadget wrote:
>>
>> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> >
>> > In 7f5397a07c6c (cmake: support for testing git when building out of t=
he
>> > source tree, 2020-06-26), we implemented support for running Git's test
>> > scripts even after building Git in a different directory than the sour=
ce
>> > directory.
>> >
>> > The way we did this was to edit the file `t/test-lib.sh` to override
>> > `GIT_BUILD_DIR` to point somewhere else than the parent of the `t/`
>> > directory.
>> >
>> > This is unideal because it always leaves a tracked file marked as
>> > modified, and it is all too easy to commit that change by mistake.
>> >
>> > Let's change the strategy by teaching `t/test-lib.sh` to detect the
>> > presence of a file called `GIT-BUILD-DIR` in the source directory. If =
it
>> > exists, the contents are interpreted as the location to the _actual_
>> > build directory. We then write this file as part of the CTest
>> > definition.
>> >
>> > To support building Git via a regular `make` invocation after building
>> > it using CMake, we ensure that the `GIT-BUILD-DIR` file is deleted (for
>> > convenience, this is done as part of the Makefile rule that is already
>> > run with every `make` invocation to ensure that `GIT-BUILD-OPTIONS` is
>> > up to date).
>> >
>> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > ---
>> >  .gitignore                          |  1 +
>> >  Makefile                            |  1 +
>> >  contrib/buildsystems/CMakeLists.txt |  7 +------
>> >  t/test-lib.sh                       | 11 ++++++++++-
>> >  4 files changed, 13 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/.gitignore b/.gitignore
>> > index a4522157641..b72ddf09346 100644
>> > --- a/.gitignore
>> > +++ b/.gitignore
>> > @@ -2,6 +2,7 @@
>> >  /fuzz_corpora
>> >  /fuzz-pack-headers
>> >  /fuzz-pack-idx
>> > +/GIT-BUILD-DIR
>> >  /GIT-BUILD-OPTIONS
>> >  /GIT-CFLAGS
>> >  /GIT-LDFLAGS
>> > diff --git a/Makefile b/Makefile
>> > index 04d0fd1fe60..9347ed90da7 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -3028,6 +3028,7 @@ else
>> >  	@echo RUNTIME_PREFIX=3D\'false\' >>$@+
>> >  endif
>> >  	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
>> > +	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
>> >
>> >  ### Detect Python interpreter path changes
>> >  ifndef NO_PYTHON
>> > diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystem=
s/CMakeLists.txt
>> > index fe606c179f7..29d7e236ae1 100644
>> > --- a/contrib/buildsystems/CMakeLists.txt
>> > +++ b/contrib/buildsystems/CMakeLists.txt
>> > @@ -1067,14 +1067,9 @@ endif()
>> >  #Make the tests work when building out of the source tree
>> >  get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMa=
keCache.txt ABSOLUTE)
>> >  if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
>> > -	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BI=
NARY_DIR}/CMakeCache.txt)
>> > -	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_R=
ELATIVE})
>> >  	#Setting the build directory in test-lib.sh before running tests
>> >  	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
>> > -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL =
REGEX \"GIT_BUILD_DIR=3D(.*)\")\n"
>> > -		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CON=
SUME)\n"
>> > -		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=3D\\\"$T=
EST_DIRECTORY/../${BUILD_DIR_RELATIVE}\\\"\" content \"\${content}\")\n"
>> > -		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
>> > +		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}=
\")")
>> >  	#misc copies
>> >  	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BI=
NARY_DIR}/t/)
>> >  	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DI=
R}/po/)
>> > diff --git a/t/test-lib.sh b/t/test-lib.sh
>> > index 55857af601b..4468ac51f25 100644
>> > --- a/t/test-lib.sh
>> > +++ b/t/test-lib.sh
>> > @@ -42,7 +42,16 @@ then
>> >  	TEST_OUTPUT_DIRECTORY=3D$TEST_DIRECTORY
>> >  fi
>> >  GIT_BUILD_DIR=3D"${TEST_DIRECTORY%/t}"
>> > -if test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
>> > +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
>> > +then
>> > +	GIT_BUILD_DIR=3D"$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
>> > +	# On Windows, we must convert Windows paths lest they contain a colon
>> > +	case "$(uname -s)" in
>> > +	*MINGW*)
>> > +		GIT_BUILD_DIR=3D"$(cygpath -au "$GIT_BUILD_DIR")"
>> > +		;;
>> > +	esac
>> > +elif test "$TEST_DIRECTORY" =3D "$GIT_BUILD_DIR"
>> >  then
>> >  	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?"=
 >&2
>> >  	exit 1
>>
>> As pointed out in the v1 this breaks the cmake<->make interaction in
>> some scenarios, but from some brief testing there seemed to be an easy
>> workaround which didn't suffer from that problem:
>> https://lore.kernel.org/git/220811.86sfm3ov5z.gmgdl@evledraar.gmail.com/
>
> I do not think that the CMake <-> make interaction will come up in any
> other scenario than your and my tests in the context of this mailing list
> thread.
>
> Therefore, I am certain that we need not cater to that scenario at all.

I run it like that now when I build locally, and it slots nicely in with:

 	1. First run a bunch of 'build' targets
	2. Then run a bunch of 'test' targets

I'm not opposed to having this e.g. as a special-case on Windows, or
that we pick up when you *only* have cmake/ctest unconditionally, and
auto-do the right thing.

But I do think that:

	A. Getting a "run test-lib against this build dir over there" is
	   *different* from the bundled behavior of the auto-flip-flopping.

	B. Your case for doing it this way seems to be the
	   Windows-specific case noted in 1/5, can't we just make that
	   part Windows-specific then? I don't get why it needs to be
	   bundled up with cmake everywhere....
