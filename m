Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D46FA373D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 16:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJUQRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 12:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiJUQRP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 12:17:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA1022C836
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:17:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u21so7744416edi.9
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KJGgeRppNNDy4EZdylw1qDxTuiErS02PdBBgEToqk4M=;
        b=bpLHUM2T55rMWjuYO4o5TEfNuTBVFl5jHC8jxpLaf2LRvYaOmFgoCmCXy9am4XPBGP
         KvBa6utSeJHeuWKCXOqcEuuBv8Htvwu2Gloj+kl/wOp7IRSSnYIaYQ4dI0XNyOD/xefe
         qEkNMbSmcFqfbitl1iRkmaqiO5lPWSBvz1GtYd6MaDX6tQjcrh4hVfnJTsh3A9nPE122
         jiVgEN/sC0NfNJBo73TFQdT8bJrFz+hEcI5vSaCKKyPS+mTxSqVZZ0emtsFcm14t/f6y
         n6Y+X6lDJNL422cg/NZ/2vFkOBglWQWDdLassV1qwm0esDOE2ZrdHW64cNPSDJzN4NG4
         ydhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KJGgeRppNNDy4EZdylw1qDxTuiErS02PdBBgEToqk4M=;
        b=DAZfbpn4rz1sdunUuAccE+OvWlXGvdvdVA1gBnM52YWl1t4IUv0uUyrBcILgDZXJ1w
         qYx7OYCy/yHzu8qv5VvMC+uqD8N0t3qlwxCaNbJHraUoH86sqo1mgvqNRYX37RMoHowO
         EeNlYg3kJEpVkrqEVIGcSwZ3CgxiHxSXZIFLA+W9yahbLFGmSOOSdXmRLdNc+SHP/VQn
         +v3V5rgTHdKOOSG/5OLHKQEUqvr9H0LB00G25NV2QUIySfVTN1joJOWoPVw81tMxP2bd
         QvlSZr75ZTR5saKqWziYaFlb31WTP2kCdMhDg1BM38ojB0nwWdgBL44spBLi7rf9D0F5
         2zIQ==
X-Gm-Message-State: ACrzQf313ETOAzAC7HvelpCxDc78+xAtbQ3trXOxkmjFlrhY8oKfRHZC
        8xYg3MnHp1QVurRjbZjazPI=
X-Google-Smtp-Source: AMsMyM5ZMSc3BcLNTuuptjKBD3HJ9QUd168AObTkc8muQrqvKX9jUcC/Lnp1Y7FtedSpl5IJQYN1/g==
X-Received: by 2002:a17:906:fd8d:b0:780:997:8b7b with SMTP id xa13-20020a170906fd8d00b0078009978b7bmr16396700ejb.635.1666369031397;
        Fri, 21 Oct 2022 09:17:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ss5-20020a170907038500b0073c80d008d5sm11592689ejb.122.2022.10.21.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:17:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oluhp-0074yZ-0L;
        Fri, 21 Oct 2022 18:17:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 0/9] cmake: fix *nix & general issues, no test-lib.sh
 editing, ctest in CI
Date:   Fri, 21 Oct 2022 17:55:11 +0200
References: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
 <49d65210-583b-67a2-1ad5-c7166e81396e@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <49d65210-583b-67a2-1ad5-c7166e81396e@dunelm.org.uk>
Message-ID: <221021.86zgdpdud6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 21 2022, Phillip Wood wrote:

> On 21/10/2022 10:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> I think this series contains a couple of interesting ideas[...]

c'mon :) Getting it to a 100%[1] pass rate on *nix from 76%[2] & having
"ctest" running in CI now is a bit more than an interesting idea :)

> but I'm not sure hard coding the build directory or removing the
> default test options are improvements on dscho's series.

I replied to most of that in [3], but wanted to add that while I think
it makes sense to get bugfixes for the system in first before behavior
changes (especially Makefile-divergent behavior changes) I'm not going
to pick that particular hill to die on.

So if the consensus is that we want it too I'd be happy to bundle it all
together in a way that one-to-one maps to the features / behavior
changes Johannes submitted (especially as he's short on time[4]).

I started looking at this because I have changes locally that make the
Makefile much faster by replacing all that FORCE shell-out stuff with
built-in Makefile functions, which really cuts down on the fixed cost of
running "make" (really helpful in large interactive rebases).

Sneaking a "while generating this file, let's remove this other file"
into the Makefile dependency DAG is pretty much free as long as
everything's a FORCE'd shellscript, but that approach would block
representing that data in Make's native way of viewing dependencies
(which is much faster).

But anyway, if there's an insistance on the GIT-BUILD-DIR approach that
can be made to work with that also, in a way that I believe satisfies
the stated use-case.

> Combining fixes for cmake and linux with changes for running ctest on
> windows is not particularly helpful and would be better as two
> separate series.

I guess, in summary (G =3D general, N =3D *nix, W =3D Windows) fix:

 1/9: G
 2/9: N
 3/9: G
 5/9: G
 6/9: G
 7/9: G
 8/9: G
 9/9: G

So, aside from the "chmod +x" which we need on *nix it's all general
fixes (and 9/9 while adding an Ubuntu job will stress CMake paths used
on Windows too).

> We really need to have a clear policy of what the
> status of building with cmake on linux is. I think having a usable
> cmake build on linux could be useful for anyone making changes to
> CMakeLists.txt as they can do some testing and debugging locally
> before running our ci to check it works on windows but I'm not sure
> we need to support it as an alternative to the Makefile.

I wish we didn't have it at all, but I also don't use Windows/VS, or
anything that benefits from cmake's IDE integration over plain old make,
so it doesn't scratch my itch.

I'm not advocating for removing it, mind you, that's just my knee-jerk
reaction.

But I think it's clearly here to stay, so we're going to have to live
with it, and seemingly maintain both in perpetuity.

Given that it's staying, and that our answer to "cmake is broken" has by
default been "it needs fixing before the topic breaking it is merged"
(and not "people who use this cmake contrib thing should fix it
eventually") this series makes it *much* easier to deal with it for
those of us who use *nix for development.

I had a few local topics that broke cmake in one minor way or another,
which I knew about. But before this (and f31b6244950 (Merge branch
'yw/cmake-updates', 2022-06-07) earlier this year) seeing why it was
breaking involved long ping-pongs with the GitHub Windows CI.

But once I got this working I could fix several of those issues in a
few minutes, because I could run the full cmake/ctest featureset
locally.

So I think this makes it much more useful, and as the above "G/N/W"
summary shows it's really not a burden to make CMakeLists.txt portable.

1. https://github.com/avar/git/actions/runs/3294344038/jobs/5432094502#step=
:4:2787
2. https://github.com/avar/git/actions/runs/3294352976/jobs/5432095664#step=
:4:2785
3. https://lore.kernel.org/git/221021.864jvxfa3c.gmgdl@evledraar.gmail.com/
4. https://lore.kernel.org/git/s42p6rn0-s5oo-2874-636p-2541n475p045@tzk.qr/

>> On Tue, Oct 18 2022, Johannes Schindelin wrote:
>> [For context:
>> https://lore.kernel.org/git/on2q3qos-sr0n-0p8p-606p-5pq39n46qq4q@tzk.qr/
>> is upthread of here, but spinning this off into another thread]
>>=20
>>>> Re my earlier feedback, I came up with this as an alternative, which
>>>> nicely allows us to have "cmake" and "make" play together, you can even
>>>> run them concurrently!:
>>>>
>>>>       https://github.com/avar/git/commit/30f2265fd07aee97ea66f6e84a824=
d85d241e245
>>>
>>> This approach _still_ modifies the `test-lib.sh`, which is the entire
>>> reason for the patch under review.
>>>
>>> I hope you find an elegant, user-friendly alternative that leaves
>>> `test-lib.sh` unmodified even when building via CMake. I would gladly t=
ake
>>> that and drop my `GIT-BUILD-DIR` patch.
>> You did ask for it :)
>> To clarify, what I had upthread was a patch on the way towards a
>> solution that didn't edit t/test-lib.sh at all, but that patch itself
>> wasn't sufficient. It's the equivalent of 3/9 here.
>> This series:
>>   * Can be grabbed at
>>     https://github.com/avar/git/tree/avar/cmake-test-path
>>   * Conflicts with js/cmake-updates[1], although I've seen it go in
>> &
>>     out of {gitster,git}/seen (currently in gitster/seen, not in
>>     git.git's "seen".
>>     But the conflict is easily fixed to keep both, see below.
>>   * Fixes numerous bugs in the current cmake recipe, running "ctest"
>>     was a dumpster fire on Linux, after this with 9/9 we can run our
>>     whole test suite in CI on ubuntu-latest:
>>     https://github.com/avar/git/actions/runs/3293378319/jobs/5431721245
>>   * Handles the case where you want to build with cmake and have
>> "(cd t
>>     && ./t0001-init.sh)" just work, i.e. we spot that we have a built
>>     "contrib/buildsystems/out" and use that.
>>   * I pushed out a "js/cmake-update-ci" in my repo, which is a
>> (rebased
>>     on master) "js/cmake-updates" plus the 9/9 here:
>>     https://github.com/avar/git/actions/runs/3294352976/jobs/5432095664
>>     Some of those failures are due to orthagonal fixes here,
>> e.g. you
>>     clearly haven't been testing cmake+ctest on Linux, or you'd have
>>     seen the issue 2/9 fixes, a lot of failures are due to a missing
>>     "chmod +x".
>>     But others are due to e.g. your [2] missing a lot of cases. 3/9
>> and
>>     8/9 cover some of those, i.e. the Windows CI skips a lot of tests
>>     (e.g. all Perl + Python stuff), no libpcre2 etc. So a lot of
>>     failures were related to that.
>>   * I also merged this with yours at
>>     https://github.com/avar/git/tree/avar/cmake-test-path-plus-js/cmake-=
updates
>>     The --remerge-diff of the resulting merge commit is, with
>>     un-indented inline commentary:
>> 	diff --git a/.gitignore b/.gitignore
>> 	index cb0231fb401..62720c6135d 100644
>> 	--- a/.gitignore
>> 	+++ b/.gitignore
>> 	@@ -1,5 +1,4 @@
>> 	 /fuzz_corpora
>> 	-/GIT-BUILD-DIR
>> 	 /GIT-BUILD-OPTIONS
>> 	 /GIT-CFLAGS
>> 	 /GIT-LDFLAGS
>> 	diff --git a/Makefile b/Makefile
>> 	index 9e3c4588e7d..d93ad956e58 100644
>> 	--- a/Makefile
>> 	+++ b/Makefile
>> 	@@ -3041,7 +3041,6 @@ else
>> 	 	@echo RUNTIME_PREFIX=3D\'false\' >>$@+
>> 	 endif
>> 	 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
>> 	-	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
>>=20
>>     As yuo asked for: We can get what you want without
>>     GIT-BUILD-DIR. When we run via "ctest" we pass
>>     GIT_TEST_BUILD_DIR=3D${CMAKE_BINARY_DIR}, and when we run ad-hoc the
>>     test-lib.sh checks "contrib/buildsystems/out" and uses it if we
>>     have a built git there, but not in ../git.
>> 	 ### Detect Python interpreter path changes
>> 	 ifndef NO_PYTHON
>> 	diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems=
/CMakeLists.txt
>> 	remerge CONFLICT (content): Merge conflict in contrib/buildsystems/CMak=
eLists.txt
>> 	index bfc4d87026b..fafe6d9cb95 100644
>> 	--- a/contrib/buildsystems/CMakeLists.txt
>> 	+++ b/contrib/buildsystems/CMakeLists.txt
>> 	@@ -1081,24 +1081,6 @@ if(USE_VCPKG)
>> 	 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=3D\"$PATH:$TE=
ST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
>> 	 endif()
>> 	-<<<<<<< b81f18dec61 (CI: add a "linux-cmake-test" to run
>> cmake & ctest on linux)
>> 	-=3D=3D=3D=3D=3D=3D=3D
>> 	-#Make the tests work when building out of the source tree
>> 	-get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMak=
eCache.txt ABSOLUTE)
>> 	-if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
>> 	-	#Setting the build directory in test-lib.sh before running tests
>> 	-	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
>> 	-		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\=
")")
>> 	-	#misc copies
>> 	-	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.pl DESTINATION ${CMAKE_BINA=
RY_DIR}/t/)
>> 	-	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR=
}/po/)
>> 	-	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
>> 	-	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
>> 	-	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTIN=
ATION ${CMAKE_BINARY_DIR}/contrib/completion/)
>> 	-	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash =
DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
>> 	-endif()
>> 	-
>> 	->>>>>>> 27870f309d0 (cmake: increase time-out for a long-running test)
>> 	 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
>>     This whole "copy stuff and munge test-lib.sh" part is gone in my
>>     version. Rather than copy over mergetools/* the relevant tests know
>>     where to find it (it doesn't need to be built at all).
>> 	 #test
>> 	@@ -1106,11 +1088,7 @@ set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}")
>> 	 separate_arguments(GIT_TEST_OPTS)
>> 	 foreach(tsh ${test_scipts})
>> 	 	add_test(NAME ${tsh}
>> 	-<<<<<<< b81f18dec61 (CI: add a "linux-cmake-test" to run cmake & ctest=
 on linux)
>> 	-		COMMAND env GIT_TEST_BUILD_DIR=3D${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh=
} ${GIT_TEST_OPTS}
>> 	-=3D=3D=3D=3D=3D=3D=3D
>> 	-		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
>> 	->>>>>>> 27870f309d0 (cmake: increase time-out for a long-running test)
>> 	+		COMMAND env GIT_TEST_BUILD_DIR=3D${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh=
} --no-bin-wrappers --no-chain-lint -vx ${GIT_TEST_OPTS}
>> 	 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
>> 	 endforeach()
>>     I did not include your "--no-bin-wrappers --no-chain-lint -vx"
>>     change.
>>     As 7/9 here shows I pick up GIT_TEST_OPTS from the environment,
>> so
>>     if you want to set these you can set them in the environment.
>>     But your 1/5[3] adds these partially for speeding up things on
>>     Windows, but as this series shows this also runs on
>>     Linux. Therefore if we still want this I'd think we'd at least want
>>     to make it specific to that platform (per [4]).
>> 	diff --git a/t/test-lib.sh b/t/test-lib.sh
>> 	index 333079d9127..284b619708a 100644
>> 	--- a/t/test-lib.sh
>> 	+++ b/t/test-lib.sh
>> 	@@ -69,16 +69,6 @@ then
>> 	 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" =
>&2
>> 	 	exit 1
>> 	 fi
>> 	-if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
>> 	-then
>> 	-	GIT_BUILD_DIR=3D"$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
>> 	-	# On Windows, we must convert Windows paths lest they contain a colon
>> 	-	case "$(uname -s)" in
>> 	-	*MINGW*)
>> 	-		GIT_BUILD_DIR=3D"$(cygpath -au "$GIT_BUILD_DIR")"
>> 	-		;;
>> 	-	esac
>> 	-fi
>>     The changes I needed to the test-lib.sh are above this context.
>> 	 # Prepend a string to a VAR using an arbitrary ":" delimiter,
>> not
>> 	 # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:
>>     Elided here is the inclusion of your 5/5[5], which didn't
>>     conflict. If we'd like to keep it it probably makes sense to make
>>     it Windows-specific too, I don't see that being needed on Linux.
>>     Aside from this topic I'd be curious to know if you see the same
>>     slowdown with my [6], i.e. once git-submodule.sh has gone away. For
>>     me it's ~25% faster than "master", but I'd expect on a system with
>>     high fork overhead that would be a lot higher.
>> 1. https://lore.kernel.org/git/pull.1320.v3.git.1666090745.gitgitgadget@=
gmail.com/
>> 2. https://lore.kernel.org/git/9faca9d5cbe706c00d03ca2a125f2e113294a548.=
1666090745.git.gitgitgadget@gmail.com/
>> 3. https://lore.kernel.org/git/356b2e9a1007bcd1382f26f333926ff0d5b9abe2.=
1666090745.git.gitgitgadget@gmail.com/
>> 4. https://lore.kernel.org/git/221018.865yghi6nv.gmgdl@evledraar.gmail.c=
om/
>> 5. https://lore.kernel.org/git/40cf872f48386f8eca0fa814e4cdfb0ded915ed8.=
1666090745.git.gitgitgadget@gmail.com/
>> 6. https://lore.kernel.org/git/cover-00.10-00000000000-20221017T115544Z-=
avarab@gmail.com/
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
>>    cmake: don't copy chainlint.pl to build directory
>>    cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
>>    cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
>>    cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
>>    test-lib.sh: support a "GIT_TEST_BUILD_DIR"
>>    cmake: use GIT_TEST_BUILD_DIR instead of editing hack
>>    cmake: support using GIT_TEST_OPTS from the environment
>>    cmake: copy over git-p4.py for t983[56] perforce test
>>    CI: add a "linux-cmake-test" to run cmake & ctest on linux
>>   .github/workflows/main.yml          |  3 +++
>>   ci/run-build-and-tests.sh           | 13 +++++++++--
>>   contrib/buildsystems/CMakeLists.txt | 33 +++++++++++----------------
>>   t/README                            |  3 +++
>>   t/lib-gettext.sh                    |  2 +-
>>   t/lib-gitweb.sh                     |  2 +-
>>   t/t7609-mergetool--lib.sh           |  2 +-
>>   t/t9902-completion.sh               | 14 ++++++------
>>   t/t9903-bash-prompt.sh              |  2 +-
>>   t/test-lib.sh                       | 35 +++++++++++++++++++++++++++--
>>   10 files changed, 74 insertions(+), 35 deletions(-)
>>=20

