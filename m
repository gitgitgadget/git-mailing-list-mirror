Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDEC2D0F7
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309AD206B9
	for <git@archiver.kernel.org>; Tue, 12 May 2020 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naX2Pt6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgELQvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgELQvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 12:51:03 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11232C061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:03 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so16361242wra.7
        for <git@vger.kernel.org>; Tue, 12 May 2020 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VXIfaRV2AZjMEJjIP5VurK72AQh/sVCznNF/ZgWsoxc=;
        b=naX2Pt6rX2vq9DVXinG7UnJLr5YvCMFI1TNfmOWGPK82hxbG5wnrv/FfTHzrSdGbmY
         IVfN9fj+Ads9IvrMldWCNn9X+hKQcbS8l2umaPb2KUWWRdfVMLrvQpBH+cs7QsvEPd3W
         YToXD7qQheCn2JpeHpmif9qG1Q9/2PaTpaSkVGc2z1CbmLnuuFnySa5Cj4dQ7CGTOKBc
         YvbK6/g4+JA4rEO3NZlaUglouotpGbWlqwg37Ks213/UNef/YVoxHbF58enyBztQzrhW
         AT2p3TcpZ0FnSTi/iAi2yZ0c52aKtH5+Bk38VQ0gkcUzBSafeNUOeYQ+c5vKoJvIvefU
         8fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VXIfaRV2AZjMEJjIP5VurK72AQh/sVCznNF/ZgWsoxc=;
        b=uL5tiHJV8XAJ8sIV/9JQJjtJJqoqYPhMK6oR2IMNjBXdMzPeNybcUfYPM7XVrbpiyP
         uuY5ynUaig81N0292vySrH41zbbcHWyvEuyEsUEDlfQrY0x6YcmuMNW2HLaeBSkFQNSG
         LXWVFfCdZ4JVb5JKnAbVM0azPoHPj8eQ9UOGjarPBB+ftWkQtpH0KBpmDDsf6nIe3fWD
         oEvyoVNtIzKnqyywkJmUYYIzJucC8v+ibzlTN/S+T7FDhwQz0cLYEjwcaFwSK4VMvWkA
         WfZQm9UP3tddChVTl9bWlmCVqR9aQ8XAXSBbm2C+0tilqAq40e/RSo8IhvmDl84H5UIr
         Vq3A==
X-Gm-Message-State: AGi0PuZGarGao1czY/ppZJIYXyWyQE+k4nhYWfHPAUTC7ktbWWvF1yy+
        FX7H5of96S8UDxtV5PGnfT2rEXyO
X-Google-Smtp-Source: APiQypK59CGCcq7Qj6OkE9wFXZ0gjkdAYT2e7x2hQec0bq7cbjJBoIXpOhS636GQN0xF8xP3s9kTkQ==
X-Received: by 2002:a5d:522d:: with SMTP id i13mr25511310wra.306.1589302261527;
        Tue, 12 May 2020 09:51:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11sm3451519wrt.18.2020.05.12.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:51:01 -0700 (PDT)
Message-Id: <00cae10bbb7870b27202642d6e1e284a97a3c5b7.1589302254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
        <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 12 May 2020 16:50:49 +0000
Subject: [PATCH v2 06/11] cmake: support for building git on windows with
 mingw
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>

This patch facilitates building git on Windows with CMake using MinGW

NOTE: The funtions unsetenv and hstrerror are not checked in Windows
builds.
Reasons
NO_UNSETENV is not compatible with Windows builds.
lines 262-264 compat/mingw.h

compat/mingw.h(line 25) provides a definition of hstrerror which
conflicts with the definition provided in
git-compat-util.h(lines 733-736).

To use CMake on Windows with MinGW do this:
cmake `relative-path-to-srcdir` -G "MinGW Makefiles"

Changes:
Changed the error message when sh.exe is not found on Windows as
suggested by Philip Oakley <philipoakley@iee.email>

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 CMakeLists.txt | 121 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 98 insertions(+), 23 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 47d3f3c2866..9625e41886f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -13,9 +13,12 @@ project(git
 	VERSION ${git_version}
 	LANGUAGES C)
 
+
 #TODO gitk git-gui gitweb
+#TODO Enable NLS on windows natively
 #TODO Add pcre support
 
+
 include(CheckTypeSize)
 include(CheckCSourceRuns)
 include(CheckCSourceCompiles)
@@ -31,6 +34,7 @@ find_package(EXPAT)
 find_package(Iconv)
 find_package(Intl)
 
+
 if(NOT Intl_FOUND)
 	add_compile_definitions(NO_GETTEXT)
 	if(NOT Iconv_FOUND)
@@ -53,6 +57,17 @@ if(Intl_FOUND)
 endif()
 
 find_program(SH_EXE sh)
+if(NOT SH_EXE)
+	message(FATAL_ERROR "sh: shell interpreter was not found in your path, please install one."
+			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
+endif()
+
+if(WIN32)
+	find_program(WINDRES_EXE windres)
+	if(NOT WINDRES_EXE)
+		message(FATAL_ERROR "Install windres on Windows for resource files")
+	endif()
+endif()
 
 find_program(MSGFMT_EXE msgfmt)
 if(NOT MSGFMT_EXE)
@@ -85,11 +100,39 @@ add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
 			BINDIR="bin"
 			GIT_BUILT_FROM_COMMIT="")
 
-set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
-add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+if(WIN32)
+	set(FALLBACK_RUNTIME_PREFIX /mingw64)
+	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+else()
+	set(FALLBACK_RUNTIME_PREFIX /home/$ENV{USER})
+	add_compile_definitions(FALLBACK_RUNTIME_PREFIX="${FALLBACK_RUNTIME_PREFIX}")
+endif()
 
-add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
-list(APPEND compat_SOURCES unix-socket.c)
+
+#Platform Specific
+if(${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
+	include_directories(compat/win32)
+	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
+				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
+				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0 NO_ST_BLOCKS_IN_STRUCT_STAT
+				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
+				UNICODE _UNICODE HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET)
+	list(APPEND compat_SOURCES compat/mingw.c compat/winansi.c compat/win32/path-utils.c
+		compat/win32/pthread.c compat/win32mmap.c compat/win32/syslog.c
+		compat/win32/trace2_win32_process_info.c compat/win32/dirent.c
+		compat/nedmalloc/nedmalloc.c compat/strdup.c)
+	set(NO_UNIX_SOCKETS 1)
+
+elseif(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
+	list(APPEND compat_SOURCES unix-socket.c)
+endif()
+
+if(WIN32)
+	set(EXE_EXTENSION .exe)
+else()
+	set(EXE_EXTENSION)
+endif()
 
 #header checks
 check_include_file(libgen.h HAVE_LIBGEN_H)
@@ -150,7 +193,12 @@ endif()
 #function checks
 set(function_checks
 	strcasestr memmem strlcpy strtoimax strtoumax strtoull
-	setenv  mkdtemp poll pread  memmem unsetenv hstrerror)
+	setenv  mkdtemp poll pread  memmem)
+
+#unsetenv,hstrerror are incompatible with windows build
+if(NOT WIN32)
+	list(APPEND function_checks unsetenv hstrerror)
+endif()
 
 foreach(f ${function_checks})
 	string(TOUPPER ${f} uf)
@@ -309,7 +357,13 @@ endif()
 #programs
 set(PROGRAMS_BUILT
 	git git-bugreport git-credential-store git-daemon git-fast-import git-http-backend git-sh-i18n--envsubst
-	git-shell git-remote-testsvn git-credential-cache git-credential-cache--daemon)
+	git-shell git-remote-testsvn)
+
+if(NO_UNIX_SOCKETS)
+	list(APPEND excluded_progs git-credential-cache git-credential-cache--daemon)
+else()
+	list(APPEND PROGRAMS_BUILT git-credential-cache git-credential-cache--daemon)
+endif()
 
 if(NOT CURL_FOUND)
 	list(APPEND excluded_progs git-http-fetch git-http-push)
@@ -410,15 +464,34 @@ set(libvcs-svn_SOURCES
 	vcs-svn/svndiff.c vcs-svn/svndump.c)
 add_library(vcs-svn STATIC ${libvcs-svn_SOURCES})
 
+#add git.rc for gcc
+if(WIN32)
+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
+			COMMAND ${WINDRES_EXE} -O coff -DMAJOR=${PROJECT_VERSION_MAJOR} -DMINOR=${PROJECT_VERSION_MINOR}
+				-DMICRO=${PROJECT_VERSION_PATCH} -DPATCHLEVEL=0 -DGIT_VERSION="\\\"${PROJECT_VERSION}.GIT\\\""
+				-i ${CMAKE_SOURCE_DIR}/git.rc -o ${CMAKE_BINARY_DIR}/git.res
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+			VERBATIM)
+	add_custom_target(git-rc DEPENDS ${CMAKE_BINARY_DIR}/git.res)
+endif()
+
 #link all required libraries to common-main
 add_library(common-main OBJECT common-main.c)
-target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES} pthread rt)
+
+target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
 if(Intl_FOUND)
 	target_link_libraries(common-main ${Intl_LIBRARIES})
 endif()
 if(Iconv_FOUND)
 	target_link_libraries(common-main ${Iconv_LIBRARIES})
 endif()
+if(WIN32)
+	target_link_libraries(common-main ws2_32 ntdll ${CMAKE_BINARY_DIR}/git.res)
+	add_dependencies(common-main git-rc)
+	target_link_options(common-main PUBLIC -municode -Wl,--nxcompat -Wl,--dynamicbase -Wl,--pic-executable,-e,mainCRTStartup)
+elseif(UNIX)
+	target_link_libraries(common-main pthread rt)
+endif()
 
 
 set(git_SOURCES
@@ -501,11 +574,13 @@ endif()
 add_executable(git-remote-testsvn remote-testsvn.c)
 target_link_libraries(git-remote-testsvn common-main vcs-svn)
 
-add_executable(git-credential-cache credential-cache.c)
-target_link_libraries(git-credential-cache common-main)
+if(NOT NO_UNIX_SOCKETS)
+	add_executable(git-credential-cache credential-cache.c)
+	target_link_libraries(git-credential-cache common-main)
 
-add_executable(git-credential-cache--daemon credential-cache--daemon.c)
-target_link_libraries(git-credential-cache--daemon common-main)
+	add_executable(git-credential-cache--daemon credential-cache--daemon.c)
+	target_link_libraries(git-credential-cache--daemon common-main)
+endif()
 
 
 set(git_builtin_extra
@@ -517,16 +592,16 @@ set(git_builtin_extra
 foreach(s ${git_SOURCES} ${git_builtin_extra})
 	string(REPLACE "builtin/" "" s ${s})
 	string(REPLACE ".c" "" s ${s})
-	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git git-${s})\n")
-	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s})
+	file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git${EXE_EXTENSION} git-${s}${EXE_EXTENSION})\n")
+	list(APPEND git_links ${CMAKE_BINARY_DIR}/git-${s}${EXE_EXTENSION})
 endforeach()
 
 if(CURL_FOUND)
 	set(remote_exes
 		git-remote-https git-remote-ftp git-remote-ftps)
 	foreach(s ${remote_exes})
-		file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http ${s})\n")
-		list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s})
+		file(APPEND ${CMAKE_BINARY_DIR}/CreateLinks.cmake "file(CREATE_LINK git-remote-http${EXE_EXTENSION} ${s}${EXE_EXTENSION})\n")
+		list(APPEND git_http_links ${CMAKE_BINARY_DIR}/${s}${EXE_EXTENSION})
 	endforeach()
 endif()
 
@@ -654,20 +729,20 @@ set(bin_links
 	git-receive-pack git-upload-archive git-upload-pack)
 
 foreach(b ${bin_links})
-install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/bin/${b})")
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/bin/${b}${EXE_EXTENSION})")
 endforeach()
 
-install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git)")
-install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell)")
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git${EXE_EXTENSION})")
+install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git-shell${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-shell${EXE_EXTENSION})")
 
 foreach(b ${git_links})
 	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
-	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
+	install(CODE "file(CREATE_LINK ${CMAKE_INSTALL_PREFIX}/bin/git${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
 endforeach()
 
 foreach(b ${git_http_links})
 	string(REPLACE "${CMAKE_BINARY_DIR}" "" b ${b})
-	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b})")
+	install(CODE "file(CREATE_LINK  ${CMAKE_INSTALL_PREFIX}/libexec/git-core/git-remote-http${EXE_EXTENSION} ${CMAKE_INSTALL_PREFIX}/libexec/git-core/${b}${EXE_EXTENSION})")
 endforeach()
 
 install(PROGRAMS ${git_shell_scripts} ${git_perl_scripts} ${CMAKE_BINARY_DIR}/git-p4
@@ -734,14 +809,14 @@ set(wrapper_test_scripts
 foreach(script ${wrapper_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
-	string(REPLACE "@@PROG@@" "${script}" content "${content}")
+	string(REPLACE "@@PROG@@" "${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
 foreach(script ${wrapper_test_scripts})
 	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
 	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
-	string(REPLACE "@@PROG@@" "t/helper/${script}" content "${content}")
+	string(REPLACE "@@PROG@@" "t/helper/${script}${EXE_EXTENSION}" content "${content}")
 	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/${script} ${content})
 endforeach()
 
@@ -807,7 +882,7 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_UNIX_SOCKETS='${NO_UNIX_SOCKETS}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PAGER_ENV='${PAGER_ENV}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "DC_SHA1='${DC_SHA1}'\n")
-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X=''\n")
+file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "X='${EXE_EXTENSION}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
 file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
-- 
gitgitgadget

