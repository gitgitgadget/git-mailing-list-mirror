Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F70EC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 09:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJUJo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiJUJoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 05:44:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19ED25293
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bv10so3996060wrb.4
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 02:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ybsiJQ7Y1RAF/aJAwX9WsIhgglUqI4308oEd81kZygg=;
        b=dAyM9OWN3EOs+4Uz3hgfmBmcdvcOhf67fdsMOvkzpiLmf5hjQjoPbab58F34J4ha+V
         uMe0V/KPOvVgy89O5aDSnL88eZZpMUs/D72j7W72l3Ybo7PHxOEzeLQeblOMe8DSohIp
         rGgMyM5SoIDWGksCDLMZPdwzpqqvQoLEFZ92/8zX57Cj8xcvZyHMUIquLMgwC9/rb4k6
         yOFzcgiTmvJPNcOrxo29xD+fRbqCnJCItfGO+3HIk7tdo9dITp9Kl6Esd9g1K7VeFSSv
         +TItQfisr4FRKVOZAl3aMSQCVdxlVrKoZm/L8M0wQKiBdPWFG/j7o2QplADOpGEtt+xb
         MZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybsiJQ7Y1RAF/aJAwX9WsIhgglUqI4308oEd81kZygg=;
        b=EUQU6hLnvskLlYkAHotXd0nKhEki5m6w78+dm9hAUlZ+693M4by6qs1rqwaBxoU1wB
         A1VGFx1pWY4N8DkZKeY9F6Yz4OVnPISWKwl8LJd6/ctGU6+Zy7g6tvATyVvqtKR/sSs9
         qw03HbQBdtha4ZRaNvbiVgA37laVJBKEna6f9VMT3WgE+FUmJPHQCTTq/SW/xkIHH5z1
         R6cX6iZqJN/yfzRW4NmjsQRZz7gitRPOfpfDeIsa1P+fFmxErvOVg9L449Jh1nE3vf8t
         cVGhgWzYma3On2MNWupuzAmAVuhSaXrPEODkKOLnjVMaqYu1P19BpyC0hEDMZ0qX2kdV
         DPFQ==
X-Gm-Message-State: ACrzQf2JqQmzqlGn+9Fm6yYET62LQJ/9MEH6sVbKuNG/RyNMZbEUElcr
        gfSbPAsZ/LxKBtHDiZmoRJ09ViTE2k1BKg==
X-Google-Smtp-Source: AMsMyM7dnUyGpAjUkdQfp/aeutCLqAuwe9jYjvNTK+EJyoZHtbSdGgKLQCLJZaG8ZYiZEZJ/4fjq6A==
X-Received: by 2002:adf:ff89:0:b0:22e:669c:f2b7 with SMTP id j9-20020adfff89000000b0022e669cf2b7mr10697243wrr.202.1666345481136;
        Fri, 21 Oct 2022 02:44:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b002258235bda3sm18277768wrn.61.2022.10.21.02.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 02:44:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/9] cmake: fix *nix & general issues, no test-lib.sh editing, ctest in CI
Date:   Fri, 21 Oct 2022 11:44:13 +0200
Message-Id: <cover-0.9-00000000000-20221021T091013Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1205.gcea0601d673
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18 2022, Johannes Schindelin wrote:

[For context:
https://lore.kernel.org/git/on2q3qos-sr0n-0p8p-606p-5pq39n46qq4q@tzk.qr/
is upthread of here, but spinning this off into another thread]

>> Re my earlier feedback, I came up with this as an alternative, which
>> nicely allows us to have "cmake" and "make" play together, you can even
>> run them concurrently!:
>>
>>      https://github.com/avar/git/commit/30f2265fd07aee97ea66f6e84a824d85d241e245
>
> This approach _still_ modifies the `test-lib.sh`, which is the entire
> reason for the patch under review.
>
> I hope you find an elegant, user-friendly alternative that leaves
> `test-lib.sh` unmodified even when building via CMake. I would gladly take
> that and drop my `GIT-BUILD-DIR` patch.

You did ask for it :)

To clarify, what I had upthread was a patch on the way towards a
solution that didn't edit t/test-lib.sh at all, but that patch itself
wasn't sufficient. It's the equivalent of 3/9 here.

This series:

 * Can be grabbed at
   https://github.com/avar/git/tree/avar/cmake-test-path

 * Conflicts with js/cmake-updates[1], although I've seen it go in &
   out of {gitster,git}/seen (currently in gitster/seen, not in
   git.git's "seen".

   But the conflict is easily fixed to keep both, see below.

 * Fixes numerous bugs in the current cmake recipe, running "ctest"
   was a dumpster fire on Linux, after this with 9/9 we can run our
   whole test suite in CI on ubuntu-latest:
   https://github.com/avar/git/actions/runs/3293378319/jobs/5431721245

 * Handles the case where you want to build with cmake and have "(cd t
   && ./t0001-init.sh)" just work, i.e. we spot that we have a built
   "contrib/buildsystems/out" and use that.

 * I pushed out a "js/cmake-update-ci" in my repo, which is a (rebased
   on master) "js/cmake-updates" plus the 9/9 here:
   https://github.com/avar/git/actions/runs/3294352976/jobs/5432095664

   Some of those failures are due to orthagonal fixes here, e.g. you
   clearly haven't been testing cmake+ctest on Linux, or you'd have
   seen the issue 2/9 fixes, a lot of failures are due to a missing
   "chmod +x".

   But others are due to e.g. your [2] missing a lot of cases. 3/9 and
   8/9 cover some of those, i.e. the Windows CI skips a lot of tests
   (e.g. all Perl + Python stuff), no libpcre2 etc. So a lot of
   failures were related to that.

 * I also merged this with yours at
   https://github.com/avar/git/tree/avar/cmake-test-path-plus-js/cmake-updates

   The --remerge-diff of the resulting merge commit is, with
   un-indented inline commentary:

	diff --git a/.gitignore b/.gitignore
	index cb0231fb401..62720c6135d 100644
	--- a/.gitignore
	+++ b/.gitignore
	@@ -1,5 +1,4 @@
	 /fuzz_corpora
	-/GIT-BUILD-DIR
	 /GIT-BUILD-OPTIONS
	 /GIT-CFLAGS
	 /GIT-LDFLAGS
	diff --git a/Makefile b/Makefile
	index 9e3c4588e7d..d93ad956e58 100644
	--- a/Makefile
	+++ b/Makefile
	@@ -3041,7 +3041,6 @@ else
	 	@echo RUNTIME_PREFIX=\'false\' >>$@+
	 endif
	 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
	-	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi


   As yuo asked for: We can get what you want without
   GIT-BUILD-DIR. When we run via "ctest" we pass
   GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR}, and when we run ad-hoc the
   test-lib.sh checks "contrib/buildsystems/out" and uses it if we
   have a built git there, but not in ../git.

	 ### Detect Python interpreter path changes
	 ifndef NO_PYTHON
	diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
	remerge CONFLICT (content): Merge conflict in contrib/buildsystems/CMakeLists.txt
	index bfc4d87026b..fafe6d9cb95 100644
	--- a/contrib/buildsystems/CMakeLists.txt
	+++ b/contrib/buildsystems/CMakeLists.txt
	@@ -1081,24 +1081,6 @@ if(USE_VCPKG)
	 	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
	 endif()

	-<<<<<<< b81f18dec61 (CI: add a "linux-cmake-test" to run cmake & ctest on linux)
	-=======
	-#Make the tests work when building out of the source tree
	-get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
	-if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
	-	#Setting the build directory in test-lib.sh before running tests
	-	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
	-		"file(WRITE ${CMAKE_SOURCE_DIR}/GIT-BUILD-DIR \"${CMAKE_BINARY_DIR}\")")
	-	#misc copies
	-	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.pl DESTINATION ${CMAKE_BINARY_DIR}/t/)
	-	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
	-	file(GLOB mergetools "${CMAKE_SOURCE_DIR}/mergetools/*")
	-	file(COPY ${mergetools} DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
	-	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
	-	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
	-endif()
	-
	->>>>>>> 27870f309d0 (cmake: increase time-out for a long-running test)
	 file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")

   This whole "copy stuff and munge test-lib.sh" part is gone in my
   version. Rather than copy over mergetools/* the relevant tests know
   where to find it (it doesn't need to be built at all).

	 #test
	@@ -1106,11 +1088,7 @@ set(GIT_TEST_OPTS "$ENV{GIT_TEST_OPTS}")
	 separate_arguments(GIT_TEST_OPTS)
	 foreach(tsh ${test_scipts})
	 	add_test(NAME ${tsh}
	-<<<<<<< b81f18dec61 (CI: add a "linux-cmake-test" to run cmake & ctest on linux)
	-		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh} ${GIT_TEST_OPTS}
	-=======
	-		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
	->>>>>>> 27870f309d0 (cmake: increase time-out for a long-running test)
	+		COMMAND env GIT_TEST_BUILD_DIR=${CMAKE_BINARY_DIR} ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx ${GIT_TEST_OPTS}
	 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
	 endforeach()

   I did not include your "--no-bin-wrappers --no-chain-lint -vx"
   change.

   As 7/9 here shows I pick up GIT_TEST_OPTS from the environment, so
   if you want to set these you can set them in the environment.

   But your 1/5[3] adds these partially for speeding up things on
   Windows, but as this series shows this also runs on
   Linux. Therefore if we still want this I'd think we'd at least want
   to make it specific to that platform (per [4]).

	diff --git a/t/test-lib.sh b/t/test-lib.sh
	index 333079d9127..284b619708a 100644
	--- a/t/test-lib.sh
	+++ b/t/test-lib.sh
	@@ -69,16 +69,6 @@ then
	 	echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
	 	exit 1
	 fi
	-if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
	-then
	-	GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
	-	# On Windows, we must convert Windows paths lest they contain a colon
	-	case "$(uname -s)" in
	-	*MINGW*)
	-		GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
	-		;;
	-	esac
	-fi

   The changes I needed to the test-lib.sh are above this context.

	 # Prepend a string to a VAR using an arbitrary ":" delimiter, not
	 # adding the delimiter if VAR or VALUE is empty. I.e. a generalized:

   Elided here is the inclusion of your 5/5[5], which didn't
   conflict. If we'd like to keep it it probably makes sense to make
   it Windows-specific too, I don't see that being needed on Linux.

   Aside from this topic I'd be curious to know if you see the same
   slowdown with my [6], i.e. once git-submodule.sh has gone away. For
   me it's ~25% faster than "master", but I'd expect on a system with
   high fork overhead that would be a lot higher.

1. https://lore.kernel.org/git/pull.1320.v3.git.1666090745.gitgitgadget@gmail.com/
2. https://lore.kernel.org/git/9faca9d5cbe706c00d03ca2a125f2e113294a548.1666090745.git.gitgitgadget@gmail.com/
3. https://lore.kernel.org/git/356b2e9a1007bcd1382f26f333926ff0d5b9abe2.1666090745.git.gitgitgadget@gmail.com/
4. https://lore.kernel.org/git/221018.865yghi6nv.gmgdl@evledraar.gmail.com/
5. https://lore.kernel.org/git/40cf872f48386f8eca0fa814e4cdfb0ded915ed8.1666090745.git.gitgitgadget@gmail.com/
6. https://lore.kernel.org/git/cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  cmake: don't copy chainlint.pl to build directory
  cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
  cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
  cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
  test-lib.sh: support a "GIT_TEST_BUILD_DIR"
  cmake: use GIT_TEST_BUILD_DIR instead of editing hack
  cmake: support using GIT_TEST_OPTS from the environment
  cmake: copy over git-p4.py for t983[56] perforce test
  CI: add a "linux-cmake-test" to run cmake & ctest on linux

 .github/workflows/main.yml          |  3 +++
 ci/run-build-and-tests.sh           | 13 +++++++++--
 contrib/buildsystems/CMakeLists.txt | 33 +++++++++++----------------
 t/README                            |  3 +++
 t/lib-gettext.sh                    |  2 +-
 t/lib-gitweb.sh                     |  2 +-
 t/t7609-mergetool--lib.sh           |  2 +-
 t/t9902-completion.sh               | 14 ++++++------
 t/t9903-bash-prompt.sh              |  2 +-
 t/test-lib.sh                       | 35 +++++++++++++++++++++++++++--
 10 files changed, 74 insertions(+), 35 deletions(-)

-- 
2.38.0.1205.gcea0601d673

