Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FC3C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 07:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDBD206BE
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 07:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjw4JgI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgF3HZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgF3HZY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 03:25:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7698C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 00:25:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e18so9530530pgn.7
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AUpWjI6aFA+Ca29t+J8nE5LwSwLNyXuQXvG1n93mYbc=;
        b=Bjw4JgI1nvOxB3XSroQ3RoE1fkVJhm6rNp++aF4LZvNUzDgtjkuCUJYb6jaOufARLw
         2crWCvnz7ZEcRPzjidJAG1W26DhWQYNBG9Ky3+JRJjVfIKN/J8EhKTMO9sqNUF5mnTPC
         1lmlo0ThZzecE4SYdqp4b9yTGxEZmYSpvPjURAHSUkQoGwpynve6av1HatvWKYD5H1G9
         JOisrN355aZ3zA/jRxqk68HaYpthv0vcgSONDI8f1BjvRXhROYAhzOwde6xuNtTbQavr
         tDPz7mK4sQJ2eQdqBFbBUIsFy5dtRjuFAd3ct8ATTbqmQOedNoGPwu8D9Xq4651TbtWZ
         OzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AUpWjI6aFA+Ca29t+J8nE5LwSwLNyXuQXvG1n93mYbc=;
        b=mavo+p3plY5LOVPkxD30LA49xZx+AgH/E9efa9CrmulbSvO116MOgjHxi51+N7EzmG
         gzwAM4s9DvWpWOfAizDAYY60mkctqvKuo8hmXXsGtUMv+OvNsaox83MOzwWizMjs7vLN
         rX+sX1lAsSSiwaOnxaVUIdtZvkfYYRumNxLAblXYpzvad6XJIRlDeJaa7oeWwVWsndE8
         qKhDi5GWCCIUUPvU4gD14C1aZQGxEhB6AMGuL4asjOAau8Vds3CtWmYoOF/t/itcD3Hf
         0yv3aK4o5oKuoBucS2TnHf7DhPOR1etP+7m/QZJEMwZmnWGh/i8cRhje3aWLvfMKKLKw
         Kj4w==
X-Gm-Message-State: AOAM533lSGVDNNpSDtQru2pz+j8FQ3UTevfz1znsgfH2TFnqOEa4FfAn
        Ii+QpZb9nfLCTQU0cTOT+YQ=
X-Google-Smtp-Source: ABdhPJzS3GXHWqqoZRRzyi8RJKEMvIA4DGtBveF2YARuylVECtdwcG794s43iIDC8ELDcP7NKsTIyQ==
X-Received: by 2002:a63:e00c:: with SMTP id e12mr13768381pgh.413.1593501924157;
        Tue, 30 Jun 2020 00:25:24 -0700 (PDT)
Received: from gmail.com (108-81-23-119.lightspeed.irvnca.sbcglobal.net. [108.81.23.119])
        by smtp.gmail.com with ESMTPSA id w9sm1707730pfq.178.2020.06.30.00.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 00:25:23 -0700 (PDT)
Date:   Tue, 30 Jun 2020 00:25:21 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH v5 6/8] cmake: support for building git on windows with
 mingw
Message-ID: <20200630072521.GC1962986@gmail.com>
References: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
 <pull.614.v5.git.1593187898.gitgitgadget@gmail.com>
 <10acdbf5e4d4c49f69889ab1129d3d6b5a7fd754.1593187898.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10acdbf5e4d4c49f69889ab1129d3d6b5a7fd754.1593187898.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 04:11:36PM +0000, Sibi Siddharthan via GitGitGadget wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> 
> This patch facilitates building git on Windows with CMake using MinGW
> 
> NOTE: The funtions unsetenv and hstrerror are not checked in Windows
> builds.
> Reasons
> NO_UNSETENV is not compatible with Windows builds.
> lines 262-264 compat/mingw.h
> 
> compat/mingw.h(line 25) provides a definition of hstrerror which
> conflicts with the definition provided in
> git-compat-util.h(lines 733-736).
> 
> To use CMake on Windows with MinGW do this:
> cmake `relative-path-to-srcdir` -G "MinGW Makefiles"
> 
> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  contrib/buildsystems/CMakeLists.txt | 117 ++++++++++++++++++++++------
>  1 file changed, 94 insertions(+), 23 deletions(-)
> 
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index 2768ee5b71..2d7c0ed88e 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -42,6 +42,10 @@ cmake_minimum_required(VERSION 3.14)
>  set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
>  
>  find_program(SH_EXE sh)
> +if(NOT SH_EXE)
> +	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
> +			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
> +endif()
>  
>  #Create GIT-VERSION-FILE using GIT-VERSION-GEN
>  if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
> @@ -65,7 +69,9 @@ project(git
>  	VERSION ${git_version}
>  	LANGUAGES C)
>  
> +
>  #TODO gitk git-gui gitweb
> +#TODO Enable NLS on windows natively
>  #TODO Add pcre support
>  
>  #macros for parsing the Makefile for sources and scripts
> @@ -104,6 +110,7 @@ find_package(EXPAT)
>  find_package(Iconv)
>  find_package(Intl)
>  
> +
>  if(NOT Intl_FOUND)
>  	add_compile_definitions(NO_GETTEXT)
>  	if(NOT Iconv_FOUND)
> @@ -125,6 +132,14 @@ if(Intl_FOUND)
>  	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
>  endif()
>  
> +
> +if(WIN32)
> +	find_program(WINDRES_EXE windres)
> +	if(NOT WINDRES_EXE)
> +		message(FATAL_ERROR "Install windres on Windows for resource files")
> +	endif()
> +endif()
> +
>  find_program(MSGFMT_EXE msgfmt)
>  if(NOT MSGFMT_EXE)
>  	message(WARNING "Text Translations won't be build")
> @@ -156,11 +171,35 @@ add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
>  			BINDIR="bin"
>  			GIT_BUILT_FROM_COMMIT="")
>  
> -set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
> -add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> +if(WIN32)
> +	set(FALLBACK_RUNTIME_PREFIX /mingw64)
> +	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> +else()
> +	set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
> +	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
> +endif()
> +
> +
> +#Platform Specific
> +if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
> +	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
> +	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
> +				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
> +				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
> +				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
> +				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
> +	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
> +		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
> +		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
> +		compat/nedmalloc/nedmalloc.c compat/strdup.c)
> +	set(NO_UNIX_SOCKETS 1)
> +
> +elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
> +	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> +	list(APPEND compat_SOURCES unix-socket.c)
> +endif()
>  
> -add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
> -list(APPEND compat_SOURCES unix-socket.c)
> +set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
>  
>  #header checks
>  check_include_file(libgen.h HAVE_LIBGEN_H)
> @@ -223,7 +262,12 @@ endif()
>  #function checks
>  set(function_checks
>  	strcasestr memmem strlcpy strtoimax strtoumax strtoull
> -	setenv mkdtemp poll pread memmem unsetenv hstrerror)
> +	setenv mkdtemp poll pread memmem)
> +
> +#unsetenv,hstrerror are incompatible with windows build
> +if(NOT WIN32)
> +	list(APPEND function_checks unsetenv hstrerror)
> +endif()
>  
>  foreach(f ${function_checks})
>  	string(TOUPPER ${f} uf)
> @@ -444,7 +488,13 @@ unset(CMAKE_REQUIRED_INCLUDES)
>  #programs
>  set(PROGRAMS_BUILT
>  	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
> -	git-shell git-remote-testsvn git-credential-cache git-credential-cache--daemon)
> +	git-shell git-remote-testsvn)
> +
> +if(NO_UNIX_SOCKETS)
> +	list(APPEND excluded_progs git-credential-cache git-credential-cache--daemon)
> +else()
> +	list(APPEND PROGRAMS_BUILT git-credential-cache git-credential-cache--daemon)
> +endif()
>  
>  if(NOT CURL_FOUND)
>  	list(APPEND excluded_progs git-http-fetch git-http-push)
> @@ -516,15 +566,34 @@ parse_makefile_for_sources(libvcs-svn_SOURCES "VCSSVN_OBJS")
>  list(TRANSFORM libvcs-svn_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
>  add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
>  
> +#add git.rc for gcc
> +if(WIN32)
> +	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
> +			COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
> +				-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
> +				-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
> +			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
> +			VERBATIM)
> +	add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
> +endif()
> +
>  #link all required libraries to common-main
>  add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
> -target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES} pthread rt)
> +
> +target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
>  if(Intl_FOUND)
>  	target_link_libraries(common-main ${Intl_LIBRARIES})
>  endif()
>  if(Iconv_FOUND)
>  	target_link_libraries(common-main ${Iconv_LIBRARIES})
>  endif()
> +if(WIN32)
> +	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
> +	add_dependencies(common-main git-rc)
> +	target_link_options(common-main PUBLIC -municode -Wl,--nxcompat -Wl,--dynamicbase -Wl,--pic-executable,-e,mainCRTStartup)
> +elseif(UNIX)
> +	target_link_libraries(common-main pthread rt)
> +endif()


Small note about pthread.  In CMake land, the typical convention is to
use the FindThreads module. [1]

To use it, add this to the top-level:

	set(THREADS_PREFER_PTHREAD_FLAG TRUE)
	find_package(Threads REQUIRED)

and then use the Threads::Threads target with target_link_libraries()
instead of hard-coding "pthread" here.

That way it'll only use the "-pthread" flag and library links as needed.

I'm not sure if mingw makes this advice moot, but I figured it was worth
mentioning.

[1] https://cmake.org/cmake/help/latest/module/FindThreads.html
-- 
David
