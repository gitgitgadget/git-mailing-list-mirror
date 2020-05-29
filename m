Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DF7C433E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCB9206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcVwjMXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgE2Nkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgE2Nke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:40:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9EC08C5C8
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e1so3673894wrt.5
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DWgCBQfyreZjTTd2RjQiin4jIoYz+H9G872krjVkukQ=;
        b=tcVwjMXSr9LLNRbtucwtMqEXuhi2uZqJLzg0mW22hCvLpvhf/6Byz8Fx32vg2BuoXn
         EBLYdyeTE8122neiWy7vsukl+7itswyMMoCblj7fu+nSgOLFYi0V8bmg8D/ox5MjquXi
         CN0DoeqlUZ2RdHfBOh1IGyjL3D+F8CFdWnAw+SsE7clwmwPxnq6CY9NR+rq5nmr8uC7w
         nk/3oL9uPatwyQO1/t30Ze8+odvK1R68bTLwpMd5UaKFBZ1ti1FfsOuZaTOPJYweNJQC
         ZNvgyz8OLPr/Zj1dWX15kXkRbljvstrfo8aB/Xj5RUx0wkKU+mbkivJ8PESO45PZeGLO
         4IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DWgCBQfyreZjTTd2RjQiin4jIoYz+H9G872krjVkukQ=;
        b=ANKCQ9iKcL1yneIUV1taywGBaEaBebPwSG6BJ7YCYVmJya4nUdRz1+xyRptEie+5sz
         geXi2obD/1OmgmRU7lNbt+CTBh0wIQoJbW21+qVcz/3PyZ8QOfoBDQjV+1G+8wk60PGF
         1zdebwbUg6tbec89bmuT0DiVNpXeN2aTaKTQSYCNDYSI93zB08r1XxTShBuZObC3CSG3
         fUI08H6+QaZ2nmg4qHHkKpDCav2Y9YqDiKwvzCa66F2xuYfeO8ZrnwYK0NNIR87BNp6O
         pPjX69hAzsZ1y3v5IWTqp+x1d9WSsbOcp6OKVrp7bNIxv8vN1lOmtfrQSL10JJO8nBlZ
         BSug==
X-Gm-Message-State: AOAM531fL7VoCBg/Vy0V9jOsM5SG5rH8KQO++yB3PT1XCyrIs36yyjte
        vYSdBl2NESdADds3gCHsgJJrvloY
X-Google-Smtp-Source: ABdhPJxln0pNaexCdeuPGlXE21MYMrFJKYEBOkj2w7ZxzjUwrbo6JADY8OcnQONmiuKqXaIyO/3IPw==
X-Received: by 2002:adf:bb02:: with SMTP id r2mr9136770wrg.143.1590759625595;
        Fri, 29 May 2020 06:40:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm2296325wmd.0.2020.05.29.06.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:40:24 -0700 (PDT)
Message-Id: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 13:40:16 +0000
Subject: [PATCH v3 0/8] CMake build system for git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an attempt to build Git using CMake. CMake is cross-platform build
generator which works well on a variety of platforms(primarily Linux and
Windows). Using CMake we can check whether certain headers exist, certain
functions exist, the required libraries are present and configure the build
accordingly. Using CMake we can also build and test Git out of source,
resulting in a clean source tree.

Tested platforms

Ubuntu 18.04 GCC 7.4 Clang 8.0.1

Windows MinGW GCC 9.2 Clang 9 Visual Studio 2015,2017,2019

Changes:

1) The CMake script has been relocated to contrib/buildsystems 2) The CMake
script parses the Makefile for the sources. 3) Philip suggested to change
the error message if sh/bash was not found on windows. 4) CMake now tests
for ICONV_OMITS_BOM, NO_ST_BLOCKS_IN_STRUCT_STAT

Changes v2: Changes 1,2,4 have been rebased to PATCH 01/xx CMake uses
GIT-VERSION-GEN to get the version of Git

Sibi Siddharthan (8):
  Introduce CMake support for configuring Git
  cmake: generate the shell/perl/python scripts and templates,
    translations
  cmake: installation support for git
  cmake: support for testing git with ctest
  cmake: support for testing git when building out of the source tree
  cmake: support for building git on windows with mingw
  cmake: support for building git on windows with msvc and clang.
  ci: modification of main.yml to use cmake for vs-build job

 .github/workflows/main.yml          |  38 +-
 contrib/buildsystems/CMakeLists.txt | 987 ++++++++++++++++++++++++++++
 2 files changed, 1009 insertions(+), 16 deletions(-)
 create mode 100644 contrib/buildsystems/CMakeLists.txt


base-commit: 90737beb8258c0a99181b6308eef898d77979c71
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-614%2FSibiSiddharthan%2Fgit-og-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-614/SibiSiddharthan/git-og-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/614

Range-diff vs v2:

  1:  70ab1f03dd5 !  1:  09c972de52b Introduce CMake support for configuring Git on Linux
     @@ Metadata
      Author: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
       ## Commit message ##
     -    Introduce CMake support for configuring Git on Linux
     +    Introduce CMake support for configuring Git
      
          At the moment, the recommended way to configure Git's builds is to
          simply run `make`. If that does not work, the recommended strategy is to
     @@ Commit message
          occupies around two gigabytes (!) on disk and downloads about three
          quarters of a gigabyte worth of Git objects).
      
     -    To make this a little less awkward, the Git for Windows project offers
     -    the `vs/master` branch which has a full Visual Studio solution generated
     -    and committed. This branch can therefore be used to tinker with Git in
     -    Visual Studio _without_ having to download the full Git for Windows SDK.
     -    Unfortunatly, that branch is auto-generated from Git for Windows'
     -    `master`. If a developer wants to tinker, say, with `pu`, they are out
     -    of luck.
     -
     -    CMake was invented to make this sort of problem go away, by providing a
     -    more standardized, cross-platform way to configure builds.
     +    The build infrastructure for Git is written around being able to run
     +    make, which is not supported natively on Windows.
     +    To help Windows developers a CMake build script is introduced here.
      
          With a working support CMake, developers on Windows need only install
          CMake, configure their build, load the generated Visual Studio solution
     @@ Commit message
          With a CMake script an out of source build of git is possible resulting
          in a clean source tree.
      
     -    Note: earlier endeavors on the Git mailing list to introduce CMake ended
     -    up in dead water. The primary reason for that was that reviewers
     -    _expected_ CMake support to fall out of maintenance, unless the
     -    contributor would promise to keep an eye on keeping CMake support up to
     -    date. However, in the meantime, support for automated testing has been
     -    introduced in Git's source code, and a later patch will modify the
     -    (still experimental) GitHub workflow to continually verify that CMake
     -    support is still complete. That will make maintenance reasonably easy.
     -
          Note: this patch asks for the minimum version v3.14 of CMake (which is
          not all that old as of time of writing) because that is the first
          version to offer a platform-independent way to generate hardlinks as
          part of the build. This is needed to generate all those hardlinks for
          the built-in commands of Git.
      
     -    Instructions to run CMake:
     -
     -    cmake `relative-path-to-srcdir` -DCMAKE_BUILD_TYPE=Release
     +    Changes
     +    The CMake script parses the Makefile for:
     +    LIB_OBJS
     +    BUILTIN_OBJS
     +    XDIFF_OBJS
     +    VCSSVN_OBJS
     +    TEST_BUILTINS_OBJS
      
     -    Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
     -    compiler flags
     -    Debug : -g
     -    Release: -O3
     -    RelWithDebInfo : -O2 -g
     -    MinSizeRel : -Os
     -    empty(default) :
     +    By doing this we avoid duplication of text between the Makefile and
     +    the CMake script.
      
     -    NOTE: -DCMAKE_BUILD_TYPE is optional
     +    The CMake script has been relocated to contrib/buildsystems.
      
     -    This process generates a Makefile.
     -    Then run `make` to build Git.
     -
     -    NOTE: By default CMake uses Makefile as the build tool on Linux, to use
     -    another tool say `ninja` add this to the command line when configuring.
     -    `-G Ninja`
     +    The CMake script uses GIT-VERSION-GEN to determine the version of Git
     +    being built.
      
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
     - ## CMakeLists.txt (new) ##
     + ## contrib/buildsystems/CMakeLists.txt (new) ##
      @@
      +#
      +#	Copyright (c) 2020 Sibi Siddharthan
      +#
      +
     ++#[[
     ++
     ++Instructions to run CMake:
     ++
     ++cmake `relative-path-to-CMakeLists.txt` -DCMAKE_BUILD_TYPE=Release
     ++
     ++Possible build configurations(-DCMAKE_BUILD_TYPE) with corresponding
     ++compiler flags
     ++Debug : -g
     ++Release: -O3
     ++RelWithDebInfo : -O2 -g
     ++MinSizeRel : -Os
     ++empty(default) :
     ++
     ++NOTE: -DCMAKE_BUILD_TYPE is optional. For multi-config generators like Visual Studio
     ++this option is ignored
     ++
     ++This process generates a Makefile(Linux) , Visual Studio solution(Windows) by default.
     ++Run `make` to build Git on Linux.
     ++Open git.sln on Windows and build Git.
     ++
     ++NOTE: By default CMake uses Makefile as the build tool on Linux and Visual Studio in Windows,
     ++to use another tool say `ninja` add this to the command line when configuring.
     ++`-G Ninja`
     ++
     ++]]
      +cmake_minimum_required(VERSION 3.14)
      +
     -+#Parse GIT-VERSION-GEN to get the version
     -+file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN git_version REGEX "DEF_VER=v(.*)")
     -+string(REPLACE "DEF_VER=v" "" git_version ${git_version})
     -+string(REPLACE ".GIT" ".0" git_version ${git_version})#for building from a snapshot
     ++#set the source directory to root of git
     ++set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
     ++
     ++find_program(SH_EXE sh)
     ++
     ++#Create GIT-VERSION-FILE using GIT-VERSION-GEN
     ++if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
     ++	message("Generating GIT-VERSION-FILE")
     ++	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
     ++		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
     ++endif()
     ++
     ++#Parse GIT-VERSION-FILE to get the version
     ++file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE git_version REGEX "GIT_VERSION = (.*)")
     ++string(REPLACE "GIT_VERSION = " "" git_version ${git_version})
     ++string(FIND ${git_version} "GIT" location)
     ++if(location EQUAL -1)
     ++	string(REGEX MATCH "[0-9]*\\.[0-9]*\\.[0-9]*" git_version ${git_version})
     ++else()
     ++	string(REGEX MATCH "[0-9]*\\.[0-9]*" git_version ${git_version})
     ++	string(APPEND git_version ".0") #for building from a snapshot
     ++endif()
      +
      +project(git
      +	VERSION ${git_version}
      +	LANGUAGES C)
      +
      +
     ++#macros for parsing the Makefile for sources
     ++macro(parse_makefile_for_sources list_var regex)
     ++	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
     ++	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
     ++	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
     ++	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
     ++	string(REPLACE ".o" ".c;" ${list_var} ${${list_var}}) #change .o to .c, ; is for converting the string into a list
     ++	list(TRANSFORM ${list_var} STRIP) #remove trailing/leading whitespaces for each element in list
     ++	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
     ++endmacro()
     ++
      +include(CheckTypeSize)
      +include(CheckCSourceRuns)
      +include(CheckCSourceCompiles)
     @@ CMakeLists.txt (new)
      +	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
      +endif()
      +
     -+find_program(SH_EXE sh)
     -+
      +#default behaviour
      +include_directories(${CMAKE_SOURCE_DIR})
      +add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
     @@ CMakeLists.txt (new)
      +#function checks
      +set(function_checks
      +	strcasestr memmem strlcpy strtoimax strtoumax strtoull
     -+	setenv  mkdtemp poll pread  memmem unsetenv hstrerror)
     ++	setenv mkdtemp poll pread memmem unsetenv hstrerror)
      +
      +foreach(f ${function_checks})
      +	string(TOUPPER ${f} uf)
     @@ CMakeLists.txt (new)
      +endforeach()
      +
      +if(NOT HAVE_POLL_H OR NOT HAVE_SYS_POLL_H OR NOT HAVE_POLL)
     -+	include_directories(compat/poll)
     ++	include_directories(${CMAKE_SOURCE_DIR}/compat/poll)
      +	add_compile_definitions(NO_POLL)
      +	list(APPEND compat_SOURCES compat/poll/poll.c)
      +endif()
     @@ CMakeLists.txt (new)
      +	add_compile_definitions(HAVE_CLOCK_MONOTONIC)
      +endif()
      +
     ++#check for st_blocks in struct stat
     ++check_struct_has_member("struct stat" st_blocks "sys/stat.h" STRUCT_STAT_HAS_ST_BLOCKS)
     ++if(NOT STRUCT_STAT_HAS_ST_BLOCKS)
     ++	add_compile_definitions(NO_ST_BLOCKS_IN_STRUCT_STAT)
     ++endif()
      +
      +#compile checks
      +check_c_source_runs("
     @@ CMakeLists.txt (new)
      +int main(){return 0;}"
      +HAVE_REGEX)
      +if(NOT HAVE_REGEX)
     -+	include_directories(compat/regex )
     ++	include_directories(${CMAKE_SOURCE_DIR}/compat/regex)
      +	list(APPEND compat_SOURCES compat/regex/regex.c )
      +	add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
      +endif()
     @@ CMakeLists.txt (new)
      +	add_compile_definitions(HAVE_BSD_SYSCTL)
      +endif()
      +
     ++set(CMAKE_REQUIRED_LIBRARIES ${Iconv_LIBRARIES})
     ++set(CMAKE_REQUIRED_INCLUDES ${Iconv_INCLUDE_DIRS})
     ++
     ++check_c_source_compiles("
     ++#include <iconv.h>
     ++
     ++extern size_t iconv(iconv_t cd,
     ++		char **inbuf, size_t *inbytesleft,
     ++		char **outbuf, size_t *outbytesleft);
     ++
     ++int main(){return 0;}"
     ++HAVE_NEW_ICONV)
     ++if(HAVE_NEW_ICONV)
     ++	set(HAVE_OLD_ICONV 0)
     ++else()
     ++	set(HAVE_OLD_ICONV 1)
     ++endif()
     ++
     ++check_c_source_runs("
     ++#include <iconv.h>
     ++#if ${HAVE_OLD_ICONV}
     ++typedef const char *iconv_ibp;
     ++#else
     ++typedef char *iconv_ibp;
     ++#endif
     ++
     ++int main()
     ++{
     ++	int v;
     ++	iconv_t conv;
     ++	char in[] = \"a\"; iconv_ibp pin = in;
     ++	char out[20] = \"\"; char *pout = out;
     ++	size_t isz = sizeof in;
     ++	size_t osz = sizeof out;
     ++
     ++	conv = iconv_open(\"UTF-16\", \"UTF-8\");
     ++	iconv(conv, &pin, &isz, &pout, &osz);
     ++	iconv_close(conv);
     ++	v = (unsigned char)(out[0]) + (unsigned char)(out[1]);
     ++	return v != 0xfe + 0xff;
     ++}"
     ++ICONV_DOESNOT_OMIT_BOM)
     ++if(NOT ICONV_DOESNOT_OMIT_BOM)
     ++	add_compile_definitions(ICONV_OMITS_BOM)
     ++endif()
     ++
     ++unset(CMAKE_REQUIRED_LIBRARIES)
     ++unset(CMAKE_REQUIRED_INCLUDES)
     ++
     ++
      +#programs
      +set(PROGRAMS_BUILT
      +	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
     @@ CMakeLists.txt (new)
      +list(APPEND EXCLUSION_PROGS empty)
      +set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS} CACHE STRING "Programs not built" FORCE)
      +
     -+if(NOT EXISTS ${CMAKE_SOURCE_DIR}/command-list.h OR NOT EXCLUSION_PROGS_CACHE STREQUAL EXCLUSION_PROGS)
     ++if(NOT EXISTS ${CMAKE_BINARY_DIR}/command-list.h OR NOT EXCLUSION_PROGS_CACHE STREQUAL EXCLUSION_PROGS)
      +	list(REMOVE_ITEM EXCLUSION_PROGS empty)
      +	message("Generating command-list.h")
      +	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-cmdlist.sh ${EXCLUSION_PROGS} command-list.txt
      +			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
     -+			OUTPUT_FILE ${CMAKE_SOURCE_DIR}/command-list.h)
     ++			OUTPUT_FILE ${CMAKE_BINARY_DIR}/command-list.h)
      +endif()
      +
     -+if(NOT EXISTS ${CMAKE_SOURCE_DIR}/config-list.h)
     ++if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
      +	message("Generating config-list.h")
      +	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh
      +			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
     -+			OUTPUT_FILE ${CMAKE_SOURCE_DIR}/config-list.h)
     ++			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
      +endif()
      +
     ++include_directories(${CMAKE_BINARY_DIR})
      +
      +#build
     -+set(libgit_SOURCES
     -+	abspath.c add-interactive.c add-patch.c advice.c alias.c
     -+	alloc.c apply.c archive.c archive-tar.c archive-zip.c argv-array.c
     -+	attr.c base85.c bisect.c blame.c blob.c bloom.c branch.c bulk-checkin.c
     -+	bundle.c cache-tree.c chdir-notify.c checkout.c color.c column.c
     -+	combine-diff.c commit.c commit-graph.c commit-reach.c compat/obstack.c
     -+	compat/terminal.c config.c connect.c connected.c convert.c copy.c credential.c
     -+	csum-file.c ctype.c date.c decorate.c delta-islands.c diffcore-break.c
     -+	diffcore-delta.c diffcore-order.c diffcore-pickaxe.c diffcore-rename.c
     -+	diff-delta.c diff-lib.c diff-no-index.c diff.c dir.c dir-iterator.c editor.c
     -+	entry.c environment.c ewah/bitmap.c ewah/ewah_bitmap.c ewah/ewah_io.c
     -+	ewah/ewah_rlw.c exec-cmd.c fetch-negotiator.c fetch-pack.c fmt-merge-msg.c fsck.c fsmonitor.c
     -+	gettext.c gpg-interface.c graph.c grep.c hashmap.c linear-assignment.c help.c hex.c
     -+	ident.c interdiff.c json-writer.c kwset.c levenshtein.c line-log.c line-range.c list-objects.c
     -+	list-objects-filter.c list-objects-filter-options.c ll-merge.c lockfile.c
     -+	log-tree.c ls-refs.c mailinfo.c mailmap.c match-trees.c mem-pool.c merge.c merge-blobs.c
     -+	merge-recursive.c mergesort.c midx.c name-hash.c negotiator/default.c
     -+	negotiator/skipping.c notes.c notes-cache.c notes-merge.c notes-utils.c object.c oidmap.c
     -+	oidset.c oid-array.c packfile.c pack-bitmap.c pack-bitmap-write.c pack-check.c pack-objects.c
     -+	pack-revindex.c pack-write.c pager.c parse-options.c parse-options-cb.c patch-delta.c
     -+	patch-ids.c path.c pathspec.c pkt-line.c preload-index.c pretty.c prio-queue.c progress.c
     -+	promisor-remote.c prompt.c protocol.c prune-packed.c quote.c range-diff.c reachable.c read-cache.c rebase.c
     -+	rebase-interactive.c reflog-walk.c refs.c refs/files-backend.c refs/iterator.c
     -+	refs/packed-backend.c refs/ref-cache.c refspec.c ref-filter.c remote.c replace-object.c
     -+	repo-settings.c repository.c rerere.c reset.c resolve-undo.c revision.c run-command.c
     -+	send-pack.c sequencer.c serve.c server-info.c setup.c sha1-lookup.c
     -+	sha1-file.c sha1-name.c shallow.c sideband.c sigchain.c split-index.c
     -+	stable-qsort.c strbuf.c streaming.c string-list.c submodule.c submodule-config.c
     -+	sub-process.c symlinks.c tag.c tempfile.c thread-utils.c tmp-objdir.c
     -+	trace.c trace2.c trace2/tr2_cfg.c trace2/tr2_cmd_name.c trace2/tr2_dst.c
     -+	trace2/tr2_sid.c trace2/tr2_sysenv.c trace2/tr2_tbuf.c trace2/tr2_tgt_event.c
     -+	trace2/tr2_tgt_normal.c trace2/tr2_tgt_perf.c trace2/tr2_tls.c trailer.c transport.c
     -+	transport-helper.c tree-diff.c tree.c tree-walk.c unpack-trees.c upload-pack.c url.c
     -+	urlmatch.c usage.c userdiff.c utf8.c varint.c version.c versioncmp.c walker.c wildmatch.c
     -+	worktree.c wrapper.c write-or-die.c ws.c wt-status.c xdiff-interface.c
     -+	zlib.c)
     ++#libgit
     ++parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
      +
     ++list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
     ++list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
      +add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
      +
     -+set(libxdiff_SOURCES
     -+	xdiff/xdiffi.c xdiff/xprepare.c xdiff/xutils.c xdiff/xemit.c
     -+	xdiff/xmerge.c xdiff/xpatience.c xdiff/xhistogram.c)
     ++#libxdiff
     ++parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
     ++
     ++list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
      +add_library(xdiff STATIC ${libxdiff_SOURCES})
      +
     -+set(libvcs-svn_SOURCES
     -+	vcs-svn/line_buffer.c vcs-svn/sliding_window.c vcs-svn/fast_export.c
     -+	vcs-svn/svndiff.c vcs-svn/svndump.c)
     ++#libvcs-svn
     ++parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
     ++
     ++list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
      +add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
      +
      +#link all required libraries to common-main
     -+add_library(common-main OBJECT common-main.c)
     ++add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
      +target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES} pthread rt)
      +if(Intl_FOUND)
      +	target_link_libraries(common-main ${Intl_LIBRARIES})
     @@ CMakeLists.txt (new)
      +	target_link_libraries(common-main ${Iconv_LIBRARIES})
      +endif()
      +
     ++#git
     ++parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
     ++
     ++list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
     ++add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
     ++target_link_libraries(git common-main)
      +
     -+set(git_SOURCES
     -+	builtin/add.c builtin/am.c builtin/annotate.c builtin/apply.c
     -+	builtin/archive.c builtin/bisect--helper.c builtin/blame.c
     -+	builtin/branch.c builtin/bundle.c builtin/cat-file.c builtin/check-attr.c
     -+	builtin/check-ignore.c builtin/check-mailmap.c builtin/check-ref-format.c
     -+	builtin/checkout-index.c builtin/checkout.c builtin/clean.c
     -+	builtin/clone.c builtin/column.c builtin/commit-tree.c
     -+	builtin/commit.c builtin/commit-graph.c builtin/config.c
     -+	builtin/count-objects.c builtin/credential.c builtin/describe.c
     -+	builtin/diff-files.c builtin/diff-index.c builtin/diff-tree.c
     -+	builtin/diff.c builtin/difftool.c builtin/env--helper.c
     -+	builtin/fast-export.c builtin/fetch-pack.c builtin/fetch.c builtin/fmt-merge-msg.c
     -+	builtin/for-each-ref.c builtin/fsck.c builtin/gc.c
     -+	builtin/get-tar-commit-id.c builtin/grep.c builtin/hash-object.c
     -+	builtin/help.c builtin/index-pack.c builtin/init-db.c
     -+	builtin/interpret-trailers.c builtin/log.c builtin/ls-files.c
     -+	builtin/ls-remote.c builtin/ls-tree.c builtin/mailinfo.c builtin/mailsplit.c
     -+	builtin/merge.c builtin/merge-base.c builtin/merge-file.c builtin/merge-index.c
     -+	builtin/merge-ours.c builtin/merge-recursive.c builtin/merge-tree.c
     -+	builtin/mktag.c builtin/mktree.c builtin/multi-pack-index.c builtin/mv.c
     -+	builtin/name-rev.c builtin/notes.c builtin/pack-objects.c builtin/pack-redundant.c
     -+	builtin/pack-refs.c builtin/patch-id.c builtin/prune-packed.c builtin/prune.c
     -+	builtin/pull.c builtin/push.c builtin/range-diff.c builtin/read-tree.c
     -+	builtin/rebase.c builtin/receive-pack.c builtin/reflog.c builtin/remote.c
     -+	builtin/remote-ext.c builtin/remote-fd.c builtin/repack.c builtin/replace.c
     -+	builtin/rerere.c builtin/reset.c builtin/rev-list.c builtin/rev-parse.c
     -+	builtin/revert.c builtin/rm.c builtin/send-pack.c builtin/shortlog.c
     -+	builtin/show-branch.c builtin/show-index.c builtin/show-ref.c
     -+	builtin/sparse-checkout.c builtin/stash.c builtin/stripspace.c
     -+	builtin/submodule--helper.c builtin/symbolic-ref.c builtin/tag.c
     -+	builtin/unpack-file.c builtin/unpack-objects.c builtin/update-index.c
     -+	builtin/update-ref.c builtin/update-server-info.c builtin/upload-archive.c
     -+	builtin/upload-pack.c builtin/var.c builtin/verify-commit.c builtin/verify-pack.c
     -+	builtin/verify-tag.c builtin/worktree.c builtin/write-tree.c)
     -+
     -+add_executable(git git.c ${git_SOURCES})
     -+target_link_libraries(git common-main )
     -+
     -+add_executable(git-bugreport bugreport.c)
     ++add_executable(git-bugreport ${CMAKE_SOURCE_DIR}/bugreport.c)
      +target_link_libraries(git-bugreport common-main)
      +
     -+add_executable(git-credential-store credential-store.c)
     ++add_executable(git-credential-store ${CMAKE_SOURCE_DIR}/credential-store.c)
      +target_link_libraries(git-credential-store common-main)
      +
     -+add_executable(git-daemon daemon.c)
     ++add_executable(git-daemon ${CMAKE_SOURCE_DIR}/daemon.c)
      +target_link_libraries(git-daemon common-main)
      +
     -+add_executable(git-fast-import fast-import.c)
     ++add_executable(git-fast-import ${CMAKE_SOURCE_DIR}/fast-import.c)
      +target_link_libraries(git-fast-import common-main)
      +
     -+add_executable(git-http-backend http-backend.c)
     ++add_executable(git-http-backend ${CMAKE_SOURCE_DIR}/http-backend.c)
      +target_link_libraries(git-http-backend common-main)
      +
     -+add_executable(git-sh-i18n--envsubst sh-i18n--envsubst.c)
     ++add_executable(git-sh-i18n--envsubst ${CMAKE_SOURCE_DIR}/sh-i18n--envsubst.c)
      +target_link_libraries(git-sh-i18n--envsubst common-main)
      +
     -+add_executable(git-shell shell.c)
     ++add_executable(git-shell ${CMAKE_SOURCE_DIR}/shell.c)
      +target_link_libraries(git-shell common-main)
      +
      +if(CURL_FOUND)
     -+	add_library(http_obj OBJECT http.c)
     ++	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
      +
     -+	add_executable(git-imap-send imap-send.c)
     ++	add_executable(git-imap-send ${CMAKE_SOURCE_DIR}/imap-send.c)
      +	target_link_libraries(git-imap-send http_obj common-main ${CURL_LIBRARIES})
      +
     -+	add_executable(git-http-fetch http-walker.c http-fetch.c)
     ++	add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/http-fetch.c)
      +	target_link_libraries(git-http-fetch http_obj common-main ${CURL_LIBRARIES})
      +
     -+	add_executable(git-remote-http http-walker.c remote-curl.c)
     ++	add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/remote-curl.c)
      +	target_link_libraries(git-remote-http http_obj common-main ${CURL_LIBRARIES} )
      +
      +	if(EXPAT_FOUND)
     -+		add_executable(git-http-push http-push.c)
     ++		add_executable(git-http-push ${CMAKE_SOURCE_DIR}/http-push.c)
      +		target_link_libraries(git-http-push http_obj common-main ${CURL_LIBRARIES} ${EXPAT_LIBRARIES})
      +	endif()
      +endif()
      +
     -+add_executable(git-remote-testsvn remote-testsvn.c)
     ++add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
      +target_link_libraries(git-remote-testsvn common-main vcs-svn)
      +
     -+add_executable(git-credential-cache credential-cache.c)
     ++add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
      +target_link_libraries(git-credential-cache common-main)
      +
     -+add_executable(git-credential-cache--daemon credential-cache--daemon.c)
     ++add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
      +target_link_libraries(git-credential-cache--daemon common-main)
      +
      +
     @@ CMakeLists.txt (new)
      +
      +#Creating hardlinks
      +foreach(s ${git_SOURCES} ${git_builtin_extra})
     -+	string(REPLACE "builtin/" "" s ${s})
     ++	string(REPLACE "${CMAKE_SOURCE_DIR}/builtin/" "" s ${s})
      +	string(REPLACE ".c" "" s ${s})
      +	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git git-${s})\n")
      +	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s})
     @@ CMakeLists.txt (new)
      +		COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
      +		DEPENDS git git-remote-http)
      +add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
     - \ No newline at end of file
  2:  ca242cf5bda !  2:  f19794fdbc0 cmake: generate the shell/perl/python scripts and templates, translations
     @@ Metadata
       ## Commit message ##
          cmake: generate the shell/perl/python scripts and templates, translations
      
     -    This patch implements the placeholder substitution to generate, say,
     -    `git-request-pull` from `git-request-pull.sh`.
     +    Implement the placeholder substitution to generate scripted
     +    Porcelain commands, e.g. git-request-pull out of
     +    git-request-pull.sh
      
     -    The shell/perl/python scripts and template are generated using CMake
     -    (very similar to what sed does).
     +    Generate shell/perl/python scripts and template using CMake instead of
     +    using sed like the build procedure in the Makefile does.
      
          The text translations are only build if `msgfmt` is found in your path.
      
          NOTE: The scripts and templates are generated during configuration.
      
     +    Changes
     +    The CMake script parses the Makefile for:
     +    SCRIPT_SH
     +    SCRIPT_PERL
     +
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
     - ## CMakeLists.txt ##
     -@@ CMakeLists.txt: endif()
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: project(git
     + 	LANGUAGES C)
     + 
     + 
     +-#macros for parsing the Makefile for sources
     ++#macros for parsing the Makefile for sources and scripts
     + macro(parse_makefile_for_sources list_var regex)
     + 	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
     + 	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
     +@@ contrib/buildsystems/CMakeLists.txt: macro(parse_makefile_for_sources list_var regex)
     + 	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
     + endmacro()
       
     - find_program(SH_EXE sh)
     ++macro(parse_makefile_for_scripts list_var regex lang)
     ++	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
     ++	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
     ++	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
     ++	string(REPLACE " " ";" ${list_var} ${${list_var}}) #convert string to a list
     ++	list(TRANSFORM ${list_var} REPLACE "${lang}" "") #do the replacement
     ++endmacro()
     ++
     + include(CheckTypeSize)
     + include(CheckCSourceRuns)
     + include(CheckCSourceCompiles)
     +@@ contrib/buildsystems/CMakeLists.txt: if(Intl_FOUND)
     + 	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
     + endif()
       
      +find_program(MSGFMT_EXE msgfmt)
      +if(NOT MSGFMT_EXE)
     @@ CMakeLists.txt: endif()
       #default behaviour
       include_directories(${CMAKE_SOURCE_DIR})
       add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
     -@@ CMakeLists.txt: endif()
     - add_custom_command(OUTPUT ${git_links} ${git_http_links}
     +@@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT ${git_links} ${git_http_links}
       		COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
       		DEPENDS git git-remote-http)
     --add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
     - \ No newline at end of file
     -+add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
     + add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
      +
      +
      +#creating required scripts
     @@ CMakeLists.txt: endif()
      +set(INSTLIBDIR ${FALLBACK_RUNTIME_PREFIX}/share/perl5)
      +
      +#shell scripts
     ++parse_makefile_for_scripts(git_sh_scripts "SCRIPT_SH" ".sh")
      +set(git_shell_scripts
     -+	git-bisect git-difftool--helper git-filter-branch
     -+	git-merge-octopus git-merge-one-file git-merge-resolve
     -+	git-mergetool git-quiltimport
     -+	git-request-pull git-submodule git-web--browse
     ++	${git_sh_scripts}
      +	git-mergetool--lib git-parse-remote git-rebase--preserve-merges
      +	git-sh-setup git-sh-i18n git-instaweb)
      +
     @@ CMakeLists.txt: endif()
      +endforeach()
      +
      +#perl scripts
     -+set(git_perl_scripts
     -+	git-add--interactive git-archimport git-cvsexportcommit
     -+	git-cvsimport git-cvsserver git-send-email git-svn)
     ++parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
      +
      +#create perl header
      +file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
  3:  b2974432d77 !  3:  6ec73d3e967 cmake: installation support for git
     @@ Metadata
       ## Commit message ##
          cmake: installation support for git
      
     -    This patch provides the facility to install the built binaries and
     -    scripts.
     +    Install the built binaries and scripts using CMake
      
          This is very similar to `make install`.
          By default the destination directory(DESTDIR) is /usr/local/ on Linux
     @@ Commit message
      
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
     - ## CMakeLists.txt ##
     -@@ CMakeLists.txt: project(git
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: project(git
       	VERSION ${git_version}
       	LANGUAGES C)
       
      +#TODO gitk git-gui gitweb
      +#TODO Add pcre support
       
     - include(CheckTypeSize)
     - include(CheckCSourceRuns)
     -@@ CMakeLists.txt: if(MSGFMT_EXE)
     + #macros for parsing the Makefile for sources and scripts
     + macro(parse_makefile_for_sources list_var regex)
     +@@ contrib/buildsystems/CMakeLists.txt: if(MSGFMT_EXE)
       	endforeach()
       	add_custom_target(po-gen ALL DEPENDS ${po_gen})
       endif()
     @@ CMakeLists.txt: if(MSGFMT_EXE)
      +install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
      +	DESTINATION libexec/git-core)
      +
     -+install(DIRECTORY mergetools DESTINATION libexec/git-core)
     ++install(DIRECTORY ${CMAKE_SOURCE_DIR}/mergetools DESTINATION libexec/git-core)
      +install(DIRECTORY ${CMAKE_BINARY_DIR}/perl/build/lib/ DESTINATION share/perl5
      +	FILES_MATCHING PATTERN "*.pm")
      +install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/templates)
  4:  2bd8870fb96 !  4:  cdc53172b3f cmake: support for testing git with ctest
     @@ Commit message
      
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
     - ## CMakeLists.txt ##
     -@@ CMakeLists.txt: include(CheckIncludeFile)
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: include(CheckIncludeFile)
       include(CheckFunctionExists)
       include(CheckSymbolExists)
       include(CheckStructHasMember)
     @@ CMakeLists.txt: include(CheckIncludeFile)
       
       find_package(ZLIB REQUIRED)
       find_package(CURL)
     -@@ CMakeLists.txt: install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/
     +@@ contrib/buildsystems/CMakeLists.txt: install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION share/git-core/
       if(MSGFMT_EXE)
       	install(DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale DESTINATION share)
       endif()
     @@ CMakeLists.txt: install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION
      +if(BUILD_TESTING)
      +
      +#tests-helpers
     -+add_executable(test-fake-ssh t/helper/test-fake-ssh.c)
     ++add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
      +target_link_libraries(test-fake-ssh common-main)
      +
     -+add_executable(test-line-buffer t/helper/test-line-buffer.c)
     ++add_executable(test-line-buffer ${CMAKE_SOURCE_DIR}/t/helper/test-line-buffer.c)
      +target_link_libraries(test-line-buffer common-main vcs-svn)
      +
     -+add_executable(test-svn-fe t/helper/test-svn-fe.c)
     ++add_executable(test-svn-fe ${CMAKE_SOURCE_DIR}/t/helper/test-svn-fe.c)
      +target_link_libraries(test-svn-fe common-main vcs-svn)
      +
     -+set(test-tool_SOURCES
     -+	t/helper/test-tool.c t/helper/test-advise.c t/helper/test-bloom.c t/helper/test-chmtime.c
     -+	t/helper/test-config.c t/helper/test-ctype.c t/helper/test-date.c t/helper/test-delta.c
     -+	t/helper/test-dir-iterator.c t/helper/test-drop-caches.c t/helper/test-dump-cache-tree.c
     -+	t/helper/test-dump-fsmonitor.c t/helper/test-dump-split-index.c
     -+	t/helper/test-dump-untracked-cache.c t/helper/test-example-decorate.c
     -+	t/helper/test-genrandom.c t/helper/test-genzeros.c t/helper/test-hash.c
     -+	t/helper/test-hashmap.c t/helper/test-hash-speed.c t/helper/test-index-version.c
     -+	t/helper/test-json-writer.c t/helper/test-lazy-init-name-hash.c
     -+	t/helper/test-match-trees.c t/helper/test-mergesort.c t/helper/test-mktemp.c
     -+	t/helper/test-oidmap.c t/helper/test-online-cpus.c t/helper/test-parse-options.c
     -+	t/helper/test-parse-pathspec-file.c t/helper/test-path-utils.c t/helper/test-pkt-line.c
     -+	t/helper/test-prio-queue.c t/helper/test-progress.c t/helper/test-reach.c
     -+	t/helper/test-read-cache.c t/helper/test-read-graph.c t/helper/test-read-midx.c
     -+	t/helper/test-ref-store.c t/helper/test-regex.c t/helper/test-repository.c
     -+	t/helper/test-revision-walking.c t/helper/test-run-command.c t/helper/test-scrap-cache-tree.c
     -+	t/helper/test-serve-v2.c t/helper/test-sha1.c t/helper/test-oid-array.c t/helper/test-sha256.c
     -+	t/helper/test-sigchain.c t/helper/test-strcmp-offset.c t/helper/test-string-list.c
     -+	t/helper/test-submodule-config.c t/helper/test-submodule-nested-repo-config.c t/helper/test-subprocess.c
     -+	t/helper/test-trace2.c t/helper/test-urlmatch-normalization.c t/helper/test-xml-encode.c
     -+	t/helper/test-wildmatch.c t/helper/test-windows-named-pipe.c t/helper/test-write-cache.c)
     -+
     -+add_executable(test-tool ${test-tool_SOURCES})
     ++#test-tool
     ++parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
     ++
     ++list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
     ++add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
      +target_link_libraries(test-tool common-main)
      +
      +set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
     @@ CMakeLists.txt: install(DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/ DESTINATION
      +endforeach()
      +
      +endif()#BUILD_TESTING
     - \ No newline at end of file
  5:  096f6311ad5 !  5:  cdc68f102cb cmake: support for testing git when building out of the source tree
     @@ Commit message
      
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
     - ## CMakeLists.txt ##
     -@@ CMakeLists.txt: file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
       
      +#Make the tests work when building out of the source tree
     -+if(NOT ${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
     ++get_filename_component(CACHE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../CMakeCache.txt ABSOLUTE)
     ++if(NOT ${CMAKE_BINARY_DIR}/CMakeCache.txt STREQUAL ${CACHE_PATH})
      +	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
      +	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})
      +	#Setting the build directory in test-lib.sh before running tests
  6:  00cae10bbb7 !  6:  f41cbd43081 cmake: support for building git on windows with mingw
     @@ Commit message
          Changed the error message when sh.exe is not found on Windows as
          suggested by Philip Oakley <philipoakley@iee.email>
      
     +    v2:
     +    Fixed a bug where a Windows user can pose as Linux user and vice versa.
     +
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
     - ## CMakeLists.txt ##
     -@@ CMakeLists.txt: project(git
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: cmake_minimum_required(VERSION 3.14)
     + set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
     + 
     + find_program(SH_EXE sh)
     ++if(NOT SH_EXE)
     ++	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
     ++			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
     ++endif()
     + 
     + #Create GIT-VERSION-FILE using GIT-VERSION-GEN
     + if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
     +@@ contrib/buildsystems/CMakeLists.txt: project(git
       	VERSION ${git_version}
       	LANGUAGES C)
       
     @@ CMakeLists.txt: project(git
      +#TODO Enable NLS on windows natively
       #TODO Add pcre support
       
     -+
     - include(CheckTypeSize)
     - include(CheckCSourceRuns)
     - include(CheckCSourceCompiles)
     -@@ CMakeLists.txt: find_package(EXPAT)
     + #macros for parsing the Makefile for sources and scripts
     +@@ contrib/buildsystems/CMakeLists.txt: find_package(EXPAT)
       find_package(Iconv)
       find_package(Intl)
       
     @@ CMakeLists.txt: find_package(EXPAT)
       if(NOT Intl_FOUND)
       	add_compile_definitions(NO_GETTEXT)
       	if(NOT Iconv_FOUND)
     -@@ CMakeLists.txt: if(Intl_FOUND)
     +@@ contrib/buildsystems/CMakeLists.txt: if(Intl_FOUND)
     + 	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
       endif()
       
     - find_program(SH_EXE sh)
     -+if(NOT SH_EXE)
     -+	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
     -+			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
     -+endif()
      +
      +if(WIN32)
      +	find_program(WINDRES_EXE windres)
     @@ CMakeLists.txt: if(Intl_FOUND)
      +		message(FATAL_ERROR "Install windres on Windows for resource files")
      +	endif()
      +endif()
     - 
     ++
       find_program(MSGFMT_EXE msgfmt)
       if(NOT MSGFMT_EXE)
     -@@ CMakeLists.txt: add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
     + 	message(WARNING "Text Translations won't be build")
     +@@ contrib/buildsystems/CMakeLists.txt: add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
       			BINDIR="bin"
       			GIT_BUILT_FROM_COMMIT="")
       
     @@ CMakeLists.txt: add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
      -list(APPEND compat_SOURCES unix-socket.c)
      +
      +#Platform Specific
     -+if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
     -+	include_directories(compat/win32)
     ++if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
     ++	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
      +	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
      +				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
     -+				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0 NO_ST_BLOCKS_IN_STRUCT_STAT
     ++				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
      +				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
      +				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
      +	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
     @@ CMakeLists.txt: add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
      +		compat/nedmalloc/nedmalloc.c compat/strdup.c)
      +	set(NO_UNIX_SOCKETS 1)
      +
     -+elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
     ++elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
      +	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
      +	list(APPEND compat_SOURCES unix-socket.c)
      +endif()
     @@ CMakeLists.txt: add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
       
       #header checks
       check_include_file(libgen.h HAVE_LIBGEN_H)
     -@@ CMakeLists.txt: endif()
     +@@ contrib/buildsystems/CMakeLists.txt: endif()
       #function checks
       set(function_checks
       	strcasestr memmem strlcpy strtoimax strtoumax strtoull
     --	setenv  mkdtemp poll pread  memmem unsetenv hstrerror)
     -+	setenv  mkdtemp poll pread  memmem)
     +-	setenv mkdtemp poll pread memmem unsetenv hstrerror)
     ++	setenv mkdtemp poll pread memmem)
      +
      +#unsetenv,hstrerror are incompatible with windows build
      +if(NOT WIN32)
     @@ CMakeLists.txt: endif()
       
       foreach(f ${function_checks})
       	string(TOUPPER ${f} uf)
     -@@ CMakeLists.txt: endif()
     +@@ contrib/buildsystems/CMakeLists.txt: unset(CMAKE_REQUIRED_INCLUDES)
       #programs
       set(PROGRAMS_BUILT
       	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
     @@ CMakeLists.txt: endif()
       
       if(NOT CURL_FOUND)
       	list(APPEND excluded_progs git-http-fetch git-http-push)
     -@@ CMakeLists.txt: set(libvcs-svn_SOURCES
     - 	vcs-svn/svndiff.c vcs-svn/svndump.c)
     +@@ contrib/buildsystems/CMakeLists.txt: parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
     + list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
       add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
       
      +#add git.rc for gcc
     @@ CMakeLists.txt: set(libvcs-svn_SOURCES
      +endif()
      +
       #link all required libraries to common-main
     - add_library(common-main OBJECT common-main.c)
     + add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
      -target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES} pthread rt)
      +
      +target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
     @@ CMakeLists.txt: set(libvcs-svn_SOURCES
      +	target_link_libraries(common-main pthread rt)
      +endif()
       
     - 
     - set(git_SOURCES
     -@@ CMakeLists.txt: endif()
     - add_executable(git-remote-testsvn remote-testsvn.c)
     + #git
     + parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
     +@@ contrib/buildsystems/CMakeLists.txt: endif()
     + add_executable(git-remote-testsvn ${CMAKE_SOURCE_DIR}/remote-testsvn.c)
       target_link_libraries(git-remote-testsvn common-main vcs-svn)
       
     --add_executable(git-credential-cache credential-cache.c)
     +-add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
      -target_link_libraries(git-credential-cache common-main)
      +if(NOT NO_UNIX_SOCKETS)
     -+	add_executable(git-credential-cache credential-cache.c)
     ++	add_executable(git-credential-cache ${CMAKE_SOURCE_DIR}/credential-cache.c)
      +	target_link_libraries(git-credential-cache common-main)
       
     --add_executable(git-credential-cache--daemon credential-cache--daemon.c)
     +-add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
      -target_link_libraries(git-credential-cache--daemon common-main)
     -+	add_executable(git-credential-cache--daemon credential-cache--daemon.c)
     ++	add_executable(git-credential-cache--daemon ${CMAKE_SOURCE_DIR}/credential-cache--daemon.c)
      +	target_link_libraries(git-credential-cache--daemon common-main)
      +endif()
       
       
       set(git_builtin_extra
     -@@ CMakeLists.txt: set(git_builtin_extra
     +@@ contrib/buildsystems/CMakeLists.txt: set(git_builtin_extra
       foreach(s ${git_SOURCES} ${git_builtin_extra})
     - 	string(REPLACE "builtin/" "" s ${s})
     + 	string(REPLACE "${CMAKE_SOURCE_DIR}/builtin/" "" s ${s})
       	string(REPLACE ".c" "" s ${s})
      -	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git git-${s})\n")
      -	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s})
     @@ CMakeLists.txt: set(git_builtin_extra
       	endforeach()
       endif()
       
     -@@ CMakeLists.txt: set(bin_links
     +@@ contrib/buildsystems/CMakeLists.txt: set(bin_links
       	git-receive-pack git-upload-archive git-upload-pack)
       
       foreach(b ${bin_links})
     @@ CMakeLists.txt: set(bin_links
       endforeach()
       
       install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
     -@@ CMakeLists.txt: set(wrapper_test_scripts
     +@@ contrib/buildsystems/CMakeLists.txt: set(wrapper_test_scripts
       foreach(script ${wrapper_scripts})
       	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
       	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
     @@ CMakeLists.txt: set(wrapper_test_scripts
       	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
       endforeach()
       
     -@@ CMakeLists.txt: file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\
     +@@ contrib/buildsystems/CMakeLists.txt: file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\
       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
       file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
  7:  af6c606881d !  7:  8f36e30cd22 cmake: support for building git on windows with msvc and clang.
     @@ Commit message
      
          Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
      
     - ## CMakeLists.txt ##
     -@@
     - #	Copyright (c) 2020 Sibi Siddharthan
     - #
     - 
     --cmake_minimum_required(VERSION 3.14)
     -+cmake_minimum_required(VERSION 3.15)
     - 
     - #Parse GIT-VERSION-GEN to get the version
     - file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN git_version REGEX "DEF_VER=v(.*)")
     -@@ CMakeLists.txt: find_package(ZLIB REQUIRED)
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: find_package(ZLIB REQUIRED)
       find_package(CURL)
       find_package(EXPAT)
       find_package(Iconv)
     @@ CMakeLists.txt: find_package(ZLIB REQUIRED)
       
       if(NOT Intl_FOUND)
       	add_compile_definitions(NO_GETTEXT)
     -@@ CMakeLists.txt: if(NOT SH_EXE)
     - 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
     +@@ contrib/buildsystems/CMakeLists.txt: if(Intl_FOUND)
       endif()
       
     + 
      -if(WIN32)
      +if(WIN32 AND NOT MSVC)#not required for visual studio builds
       	find_program(WINDRES_EXE windres)
       	if(NOT WINDRES_EXE)
       		message(FATAL_ERROR "Install windres on Windows for resource files")
     -@@ CMakeLists.txt: if(NOT MSGFMT_EXE)
     +@@ contrib/buildsystems/CMakeLists.txt: if(NOT MSGFMT_EXE)
       	message(WARNING "Text Translations won't be build")
       endif()
       
     @@ CMakeLists.txt: if(NOT MSGFMT_EXE)
       #default behaviour
       include_directories(${CMAKE_SOURCE_DIR})
       add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
     -@@ CMakeLists.txt: endif()
     +@@ contrib/buildsystems/CMakeLists.txt: endif()
       
       #Platform Specific
     - if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
     + if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
      +	if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
     -+		include_directories(compat/vcbuild/include)
     ++		include_directories(${CMAKE_SOURCE_DIR}/compat/vcbuild/include)
      +		add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)
      +	endif()
     - 	include_directories(compat/win32)
     + 	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
       	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
       				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
     -@@ CMakeLists.txt: set(libvcs-svn_SOURCES
     - 	vcs-svn/svndiff.c vcs-svn/svndump.c)
     +@@ contrib/buildsystems/CMakeLists.txt: parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
     + list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
       add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
       
      -#add git.rc for gcc
     @@ CMakeLists.txt: set(libvcs-svn_SOURCES
       	add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
       endif()
       
     -@@ CMakeLists.txt: endif()
     +@@ contrib/buildsystems/CMakeLists.txt: endif()
       if(WIN32)
       	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
       	add_dependencies(common-main git-rc)
     @@ CMakeLists.txt: endif()
       elseif(UNIX)
       	target_link_libraries(common-main pthread rt)
       endif()
     -@@ CMakeLists.txt: target_link_libraries(test-tool common-main)
     +@@ contrib/buildsystems/CMakeLists.txt: target_link_libraries(test-tool common-main)
       set_target_properties(test-fake-ssh test-line-buffer test-svn-fe test-tool
       			PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/helper)
       
  8:  f496cd7d8aa <  -:  ----------- cmake: added checks for struct stat and libiconv
  9:  9c674372fb5 <  -:  ----------- cmake: relocated script file contrib/buildsystems
 10:  b0a321a714a <  -:  ----------- cmake: parse the makefile for the sources.
 11:  fa1b8032906 !  8:  bb329d16ce0 ci: modification of main.yml to use cmake for vs-build job
     @@
       ## Metadata ##
     -Author: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
     +Author: Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
      
       ## Commit message ##
          ci: modification of main.yml to use cmake for vs-build job
      
     -    This patch modifies .github/workflows/main.yml to use CMake for
     -    Visual Studio builds.
     +    Teach .github/workflows/main.yml to use CMake for VS builds.
      
          Modified the vs-test step to match windows-test step. This speeds
          up the vs-test. Calling git-cmd from powershell and then calling git-bash
     @@ Commit message
          building git (eg zlib,libiconv). So we extract the libraries before we
          configure.
      
     -    Changes:
     -    The CMake script has been relocated to contib/buildsystems, so point
     -    to the CMakeLists.txt in the invocation commands.
     -
     -    The generation command now uses the absolute paths for the generation
     -    step.
     -
          To check for ICONV_OMITS_BOM libiconv.dll needs to be in the working
          directory of script or path. So we copy the dlls before we configure.
      
     -    Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
     +    Signed-off-by: Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
      
       ## .github/workflows/main.yml ##
      @@ .github/workflows/main.yml: jobs:
     -     - name: download git-sdk-64-minimal
     -       shell: bash
     -       run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
     +         ## Unzip and remove the artifact
     +         unzip artifacts.zip
     +         rm artifacts.zip
      -    - name: generate Visual Studio solution
      -      shell: powershell
      -      run: |
     @@ .github/workflows/main.yml: jobs:
               & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
                 mkdir -p artifacts &&
                 eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts 2>&1 | grep ^tar)\"
     -@@ .github/workflows/main.yml: jobs:
     -         nr: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
     -     steps:
     -     - uses: actions/checkout@v1
     --    - name: download git-64-portable
     -+    - name: download git-sdk-64-minimal
     -       shell: bash
     --      run: a=git-64-portable && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
     -+      run: a=git-sdk-64-minimal && mkdir -p $a && curl -# https://wingit.blob.core.windows.net/ci-artifacts/$a.tar.xz | tar -C $a -xJf -
     -     - name: download build artifacts
     -       uses: actions/download-artifact@v1
     -       with:
      @@ .github/workflows/main.yml: jobs:
           - name: extract build artifacts
             shell: bash
     @@ .github/workflows/main.yml: jobs:
             shell: powershell
             env:
               MSYSTEM: MINGW64
     -         NO_SVN_TESTS: 1
     -         GIT_TEST_SKIP_REBASE_P: 1
     -       run: |
     --        & git-64-portable\git-cmd.exe --command=usr\bin\bash.exe -lc @"
     --          # Let Git ignore the SDK and the test-cache
     --          printf '%s\n' /git-64-portable/ /test-cache/ >>.git/info/exclude
     -+        & .\git-sdk-64-minimal\usr\bin\bash.exe -lc @"
     -+          # Let Git ignore the SDK
     -+          printf '%s\n' /git-sdk-64-minimal/ >>.git/info/exclude
     +@@ .github/workflows/main.yml: jobs:
     +           # Let Git ignore the SDK and the test-cache
     +           printf '%s\n' /git-sdk-64-minimal/ /test-cache/ >>.git/info/exclude
       
      -          cd t &&
      -          PATH=\"`$PWD/helper:`$PATH\" &&
     @@ .github/workflows/main.yml: jobs:
      +        name: failed-tests-windows
      +        path: ${{env.FAILED_TEST_ARTIFACTS}}
         regular:
     -     strategy:
     -       matrix:
     +     needs: ci-config
     +     if: needs.ci-config.outputs.enabled == 'yes'
     +@@ .github/workflows/main.yml: jobs:
     +     steps:
     +     - uses: actions/checkout@v1
     +     - run: ci/install-dependencies.sh
     +-    - run: ci/test-documentation.sh
     ++    - run: ci/test-documentation.sh
     + \ No newline at end of file

-- 
gitgitgadget
