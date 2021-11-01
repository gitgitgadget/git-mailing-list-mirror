Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EF8C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10894610EA
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhKATVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhKATVo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:21:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA203C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:19:10 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u18so29607851wrg.5
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TTVXLAJGi4GT71xV85MzwQpuDD9x0brC9bGnMnnI3Jw=;
        b=T4obZISpZSPpqxUWnskZLjqGUp7QwJpTapNdT2mv4BJZQhmtvaUAWOB9ouvDk+Khjj
         o4ZYX88iOvG1lDu9+FMmwBhBjSFZyqoXg86pM5F2mcyDymAhhLtoIzSK/Yo5rtg/w0q/
         w7uoQgKkw4QXSmAHjXhTrIpjK71e0cURmQ5M3Q7XO7YW3vV3r9ctph/o4QCLUf6kZoT0
         kMmeMO4VEuqSdwesb8nTCruBkt6PFg2RE3i5zKbXeR9bTtm/7MOSedN18IUkJ2L+JARA
         tAKSTNmgq2C+naYkn7Ve0dFEIGS30kHpYq2EyrIdnaYGMwYqeLdkzeRZptdVQFHOdmhm
         t8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TTVXLAJGi4GT71xV85MzwQpuDD9x0brC9bGnMnnI3Jw=;
        b=k7ioezp8JiEvxHu39Gs4Q4QkV5KP/ziYQJIHJYHFO6Dg2GEWY4RpPYIj3eNIrPa14h
         1262gLu7+Vw00lUkD9aNlmH/EwCJ+/VKR9TOSAP2bIsc/Xe2zvk2r6NaDtojHGdGzG0v
         Uk8rd67YSWpRWkqku0j9X399W3TbDofIp00Exg7D5gZcO1wYkrITJ9rzqEDM4JJJOZXV
         IEBxxgdqYiyd/H6GRrJbtv2DussHO2pvmpHRaxBd1Y7b5k/77FnZ4RkdII5HaSbZX2NR
         ch6TCwpfj9UhIsmV0HR5F0Oz9SvAXNTbGCSSy5EW6GlLDwoCuCo8xl92pf/jQtmR9cBz
         UrHA==
X-Gm-Message-State: AOAM533vNhlr8qXbastXR304gv0dfwYp5U1eio5m94PHU4km+K2vOlCN
        3u8Gh6OZt9RhYUbrC5Oh7RCboR9iyCU9oLuG
X-Google-Smtp-Source: ABdhPJylDkbuLj0xjfh77o/ukqePdV76Y/ieHSmW1a8qelZZ1I4Xfp+BLPqc8pVgQBaXCzzpVFmV0A==
X-Received: by 2002:adf:8bc4:: with SMTP id w4mr39723989wra.36.1635794348918;
        Mon, 01 Nov 2021 12:19:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm339437wme.35.2021.11.01.12.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:19:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] Makefile: replace most hardcoded object lists with $(wildcard)
Date:   Mon,  1 Nov 2021 20:19:01 +0100
Message-Id: <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series replaces the hardcoded lists *.o files in the top-level
Makefile with a reliance on globbing, e.g. built-ins are $(wildcard
builtin/*.c now, instead of an exhausitive list of every built-in in
the tree.

This makes future development easier as we won't be running into merge
conflicts with these lists, see 3/3 for some more disucssion.

As noted in the v1 discussion the v1 had changes that broke the
"cmake" integration. In going back and reading the discussions around
it it seems we've ended up with a state for that "contrib" component
that was never the intent, and which we tried to explicitly avoid when
integrating it.

There are more details in the updated commit message, but this v2 gets
it working with passing CI, and in such a way as to reduce future
maintenance burden related to that component.

Ævar Arnfjörð Bjarmason (3):
  Makefile: rename $(SCRIPT_LIB) to $(SCRIPT_LIB_GEN)
  Makefile: add a utility to dump variables
  Makefile: replace most hardcoded object lists with $(wildcard)

 Makefile                            | 510 ++++------------------------
 contrib/buildsystems/CMakeLists.txt |  53 ++-
 2 files changed, 91 insertions(+), 472 deletions(-)

Range-diff against v1:
-:  ----------- > 1:  0b23b8395ec Makefile: rename $(SCRIPT_LIB) to $(SCRIPT_LIB_GEN)
-:  ----------- > 2:  97738b056cf Makefile: add a utility to dump variables
1:  bbacbed5c95 ! 3:  cd62d8f92d1 Makefile: replace most hardcoded object lists with $(wildcard)
    @@ Commit message
         would need to be explicitly listed in the Makefile. I think than small
         trade-off is worth it.
     
    +    We could make this simpler still for the Makefile by moving
    +    "unix-socket.c" etc. to e.g. a "conditional-src/" directory, likewise
    +    for $(PROGRAM_OBJS) to e.g. "programs/". If we did that we would not
    +    need the "$(filter-out)" for LIB_OBJS. I don't think that's worth it,
    +    e.g. due to "git log -- <path>" on the files now needing a "--follow".
    +
         There's a few small "while we're at it" changes here, since I'm
         touching the code in question:
     
    @@ Commit message
          - De-indent an "ifndef" block, we don't usually indent their
            contents.
     
    +    On the CMake changes here:
    +
    +     - When CMake support was introduced in was introduced
    +       061c2240b1b (Introduce CMake support for configuring Git, 2020-06-12)
    +       there was a discussion about the maintenance burden of maintaining the
    +       top-level Makefile in parallel with CMakeLists.txt[1] where reviewers
    +       were assured that doing so would simply be a matter of adding something
    +       to a list in the CMake recipe.
    +
    +       Between change and some recent changes of mine where the "vs-build"
    +       job failed to a divergence between the Makefile and CMakeList.txt I
    +       can confidently say that that doesn't at all match reality. Even
    +       seemingly trivial changes to the Makefile like this one are forcing
    +       us to do a deep-dive into CMake internals to make forward progress
    +       with our main build system.
    +
    +     - The promised "We can add a (continue-on-error) to vs-build job to
    +       make this process less of a hindrance." in [2] never materialized.
    +       Since 4c2c38e800f (ci: modification of main.yml to use cmake for
    +       vs-build job, 2020-06-26) got a hard dependency on CMake as far as
    +       getting the CI to pass goes.
    +
    +     - The "vs-build" CI doesn't actually require that there be no GNU make
    +       usage in the job, as it itself has a hard dependency on running a
    +       "make -n artifacts-tar" command. So as far as any vs-specific special-sauce
    +       goes we don't need a GNU-make free build system for vs-build.
    +
    +     - The stated goal in 061c2240b1b of avoiding a GNU make dependency
    +       for developer because it requires an SDK that "occupies around two
    +       gigabytes" and "three quarters of a gigabyte worth of Git objects"
    +       hardly seems worthwhile trade-off given the above. Disk space is cheap,
    +       developer time required to maintain two parallel build systems isn't.
    +
    +    My attempt to amend/revert 4c2c38e800f to have it use the
    +    pre-4c2c38e800f "make" invocation as a fallback failed, partially
    +    because I don't have a Windows development environment, so any attempt
    +    to change it is a painfully slow round-trip to GitHub CI.
    +
    +    Let's instead have CMake call out to the Makefile asking it what the
    +    definition of various variables lists is, rather than being forced to
    +    maintain those lists in a way that CMake can parse with regexes (which
    +    precludes anything but a giant hardcoded list).
    +
    +    I could familiarize myself enough with CMake to do this in some
    +    CMake-native way, but that would take "just as long as adding it to
    +    the Makefile"[2] (I think that took me <5 minutes, but I'm several
    +    hours into fighting with CMake)
    +
    +    So I consider this both a bugfix to the stated aims of this CMake
    +    integration, and a better way forward for having an alternate build
    +    system. I.e. If someone really does care about a having a
    +    GNU-make-less dependency for the "vs-build" I think this change offers
    +    a much better way forward for that.
    +
    +    Once we invoke the Makefile to spew out e.g. its idea of "LIB_OBJS",
    +    it's going to be trivial to do that via some wrapper script that lives
    +    in "contrib/buildsystems". Such a script would either invoke "make
    +    print-{var,list}-%", or alternatively use an in-tree committed text
    +    file with the last known result of such a "make print-{var,list}-%"
    +    run.
    +
    +    1. https://lore.kernel.org/git/xmqq8sikblv2.fsf@gitster.c.googlers.com
    +    2. https://lore.kernel.org/git/CAKiG+9Xtof8Hj3npsS-M0SnT_dcjtHjP_+avWB4oOHkaMdnSbw@mail.gmail.com/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Makefile ##
    @@ Makefile: TEST_OBJS =
     +XDIFF_SRC =
     +
     +## Guard against env: objects
    -+ALL_COMPAT_OBJS =
    ++CONDITIONAL_OBJS =
     +CURL_OBJS =
     +LIB_OBJS_DIRS =
     +
    - # Having this variable in your environment would break pipelines because
    - # you cause "cd" to echo its destination to stdout.  It can also take
    - # scripts to unexpected places.  If you like CDPATH, define it for your
    + # Utility to dump whatever variables are defined here
    + print-var-%:
    + 	@echo $($*)
     @@ Makefile: X =
      
      PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
    @@ Makefile: LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!
     -LIB_OBJS += commit-reach.o
     -LIB_OBJS += commit.o
     +# LIB_OBJS: compat/* objects that live at the top-level
    -+ALL_COMPAT_OBJS += unix-socket.o
    -+ALL_COMPAT_OBJS += unix-stream-server.o
    -+ALL_COMPAT_OBJS += sha1dc_git.o
    ++CONDITIONAL_OBJS += unix-socket.o
    ++CONDITIONAL_OBJS += unix-stream-server.o
    ++CONDITIONAL_OBJS += sha1dc_git.o
     +
     +# LIB_OBJS: Mostly glob *.c at the top-level, with some exlusions
     +LIB_OBJS += $(filter-out \
    -+	$(ALL_COMPAT_OBJS) \
    ++	$(CONDITIONAL_OBJS) \
     +	git.o common-main.o $(PROGRAM_OBJS) \
     +	$(FUZZ_OBJS) $(CURL_OBJS),\
     +	$(patsubst %.c,%.o,$(wildcard *.c)))
    @@ Makefile: LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!
     +LIB_OBJS_DIRS += negotiator
     +LIB_OBJS_DIRS += refs
     +LIB_OBJS_DIRS += trace2
    -+LIB_OBJS += $(patsubst %.c,%.o,$(foreach dir,$(LIB_OBJS_DIRS),$(wildcard $(dir)/*.c)))
    ++LIB_OBJS += $(patsubst %.c,%.o,$(wildcard $(addsuffix /*.c,$(LIB_OBJS_DIRS))))
     +
     +# LIB_OBJS: unconditional compat/* objects
      LIB_OBJS += compat/obstack.o
    @@ Makefile: LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!
      
      # THIRD_PARTY_SOURCES is a list of patterns compatible with the
      # $(filter) and $(filter-out) family of functions. They specify source
    +@@ Makefile: endif
    + LIBS = $(filter-out %.o, $(GITLIBS)) $(EXTLIBS)
    + 
    + BASIC_CFLAGS += $(COMPAT_CFLAGS)
    ++LIB_OBJS_NO_COMPAT := $(LIB_OBJS)
    + LIB_OBJS += $(COMPAT_OBJS)
    + 
    + # Quote for C
     @@ Makefile: reconfigure config.mak.autogen: config.status
      .PHONY: reconfigure # This is a convenience target.
      endif
    @@ Makefile: perf: all
      
      t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
      	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
    +
    + ## contrib/buildsystems/CMakeLists.txt ##
    +@@ contrib/buildsystems/CMakeLists.txt: project(git
    + #TODO Add pcre support
    + 
    + #macros for parsing the Makefile for sources and scripts
    +-macro(parse_makefile_for_sources list_var regex)
    +-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
    +-	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
    +-	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
    +-	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
    +-	string(REPLACE ".o" ".c;" ${list_var} ${${list_var}}) #change .o to .c, ; is for converting the string into a list
    +-	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
    +-	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
    +-endmacro()
    +-
    +-macro(parse_makefile_for_scripts list_var regex lang)
    +-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
    +-	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
    +-	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
    +-	string(REPLACE " " ";" ${list_var} ${${list_var}}) #convert string to a list
    +-	if(NOT ${lang}) #exclude for SCRIPT_LIB
    +-		list(TRANSFORM ${list_var} REPLACE "${lang}" "") #do the replacement
    +-	endif()
    +-endmacro()
    +-
    +-macro(parse_makefile_for_executables list_var regex)
    +-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+= git-(.*)")
    +-	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
    ++macro(ask_makefile_for_list list_var var_name)
    ++	execute_process(COMMAND make print-list-${var_name}
    ++			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    ++			OUTPUT_VARIABLE ${list_var})
    ++	string(REGEX REPLACE "\\.o\n" ".c\n" ${list_var} ${${list_var}}) #change .o to .c
    + 	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
    +-	string(REPLACE "git-" "" ${list_var} ${${list_var}}) #strip `git-` prefix
    +-	string(REPLACE "\$X" ";" ${list_var} ${${list_var}}) #strip $X, ; is for converting the string into a list
    ++	## Parse the Makefile print-list-% format
    ++	string(REGEX REPLACE "${var_name} =\n" "" ${list_var} ${${list_var}})
    ++	string(REGEX REPLACE "${var_name} \\+?= ([^\n]+)" "\\1;" ${list_var} ${${list_var}})
    + 	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
    + 	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
    + endmacro()
    +@@ contrib/buildsystems/CMakeLists.txt: include_directories(${CMAKE_BINARY_DIR})
    + 
    + #build
    + #libgit
    +-parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
    ++ask_makefile_for_list(libgit_SOURCES "LIB_OBJS_NO_COMPAT")
    + 
    + list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
    + 
    + #libxdiff
    +-parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
    ++ask_makefile_for_list(libxdiff_SOURCES "XDIFF_OBJS")
    + 
    + list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_library(xdiff STATIC ${libxdiff_SOURCES})
    +@@ contrib/buildsystems/CMakeLists.txt: elseif(UNIX)
    + endif()
    + 
    + #git
    +-parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
    ++ask_makefile_for_list(git_SOURCES "BUILTIN_OBJS")
    + 
    + list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
    +@@ contrib/buildsystems/CMakeLists.txt: if(CURL_FOUND)
    + 	endif()
    + endif()
    + 
    +-parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
    ++ask_makefile_for_list(git_builtin_extra "BUILT_INS")
    ++list(TRANSFORM git_builtin_extra REPLACE "^git-(.*)" "\\1") #strip `git-` prefix
    ++list(TRANSFORM git_builtin_extra REPLACE "\.exe$" "") #strip $X
    + 
    + option(SKIP_DASHED_BUILT_INS "Skip hardlinking the dashed versions of the built-ins")
    + 
    +@@ contrib/buildsystems/CMakeLists.txt: set(GITWEBDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
    + set(INSTLIBDIR ${FALLBACK_RUNTIME_PREFIX}/share/perl5)
    + 
    + #shell scripts
    +-parse_makefile_for_scripts(git_sh_scripts "SCRIPT_SH" ".sh")
    +-parse_makefile_for_scripts(git_shlib_scripts "SCRIPT_LIB" "")
    ++ask_makefile_for_list(git_sh_scripts "SCRIPT_SH_GEN")
    ++ask_makefile_for_list(git_shlib_scripts "SCRIPT_LIB_GEN")
    + set(git_shell_scripts
    + 	${git_sh_scripts} ${git_shlib_scripts} git-instaweb)
    + 
    +@@ contrib/buildsystems/CMakeLists.txt: foreach(script ${git_shell_scripts})
    + endforeach()
    + 
    + #perl scripts
    +-parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
    ++ask_makefile_for_list(git_perl_scripts "SCRIPT_PERL_GEN")
    + 
    + #create perl header
    + file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
    +@@ contrib/buildsystems/CMakeLists.txt: add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
    + target_link_libraries(test-fake-ssh common-main)
    + 
    + #test-tool
    +-parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
    ++ask_makefile_for_list(test-tool_SOURCES "TEST_BUILTINS_OBJS")
    + 
    +-list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
    ++list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
    + target_link_libraries(test-tool common-main)
    + 
-- 
2.33.1.1570.g069344fdd45

