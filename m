Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BBC433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F02206E2
	for <git@archiver.kernel.org>; Fri, 29 May 2020 13:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gtm+GFY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgE2Nkb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgE2Nk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 09:40:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D345CC08C5C6
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so3567348wrm.13
        for <git@vger.kernel.org>; Fri, 29 May 2020 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1elT2gPeRZO2fpw/fcvUd4aGw6j6HM+Ro2zJaIz5apI=;
        b=Gtm+GFY4/ANiHUn2y5LtCkso4Eb4zyOL0UMUol6GjFXTje90SO31BczCVQVmi6a0Wq
         qhj8lkCAywDvVWNDgazf33zCIK9XlfQU9fhSkszhOQ82rhHKexvPQYPovCa8aaFHDLeN
         aRFa8oh83oJwpM03x3euG6gFyLwkxcaNS0meo2LB/ltojUDIoEzSPI9ZARkrLW1ZuAt7
         mXSKE+QZS5AU/XX51StKvzt+eUToUsavRI2+DZCBnHh0ecmwvwF+NK8CkQYK2rCsYLYz
         cNtGzLvGBteX3HCeqyaYUBXCdZ8Ta6c+iKh94UI1neNSKTJI7OJi7fWmtiaic9Jfo71r
         YBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1elT2gPeRZO2fpw/fcvUd4aGw6j6HM+Ro2zJaIz5apI=;
        b=l4+vEotMWA2wiP4+YM30yUoHI+IVRRHVEhyadKutxP6Xdi7lc9oK1IXoZDjJq+I64A
         CJY9dIUSbz/S0ro8Oms6iGU9WLRnUDdU7J5uhDhK7/14rXV45F1u93I+h/HEFqCVqUqX
         x9eDUTCRurvtJjo6tw1uJQFNvMk3XUiO0+a35Q6zZWmuygGmOygQ5me+1Op9SR5cvwNn
         dlrbyMQle7Idtz/K3oJPddP4f7SJ96igZpysIU1MprkS54ZqPgXNzs8j4NeNl2TdCLC4
         q1vhbDK13oNbo3YFo5xkurXsDeh+CPlIFogmqey65jf+mIcpR8y+ksUGTSR5t7kte8jE
         TQvw==
X-Gm-Message-State: AOAM531wuwWl5N6o5Ih/WGiJWTwVbFHD+gt+fpAaRN9cVWT17p1Mt3fD
        IcYCWZaFRgK9FnwvzsubZXKbkLa+
X-Google-Smtp-Source: ABdhPJxUMtw2U0M0hhc6+k0GqqK+PmeU+BEKwR8HqQPX5GgWu7iI0ZHRrMW71WLGi0FeoC4qyNzu2Q==
X-Received: by 2002:a5d:4745:: with SMTP id o5mr8339216wrs.87.1590759627340;
        Fri, 29 May 2020 06:40:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i15sm10424672wml.47.2020.05.29.06.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 06:40:26 -0700 (PDT)
Message-Id: <f19794fdbc09cc3c57392dc522920f7b01691d88.1590759624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 May 2020 13:40:18 +0000
Subject: [PATCH v3 2/8] cmake: generate the shell/perl/python scripts and
 templates, translations
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

Implement the placeholder substitution to generate scripted
Porcelain commands, e.g. git-request-pull out of
git-request-pull.sh

Generate shell/perl/python scripts and template using CMake instead of
using sed like the build procedure in the Makefile does.

The text translations are only build if `msgfmt` is found in your path.

NOTE: The scripts and templates are generated during configuration.

Changes
The CMake script parses the Makefile for:
SCRIPT_SH
SCRIPT_PERL

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 111 +++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 8e2b27f44a6..11c909d23e3 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -58,7 +58,7 @@ project(git
 	LANGUAGES C)
 
 
-#macros for parsing the Makefile for sources
+#macros for parsing the Makefile for sources and scripts
 macro(parse_makefile_for_sources list_var regex)
 	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
 	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
@@ -69,6 +69,14 @@ macro(parse_makefile_for_sources list_var regex)
 	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
 endmacro()
 
+macro(parse_makefile_for_scripts list_var regex lang)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
+	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
+	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
+	string(REPLACE " " ";" ${list_var} ${${list_var}}) #convert string to a list
+	list(TRANSFORM ${list_var} REPLACE "${lang}" "") #do the replacement
+endmacro()
+
 include(CheckTypeSize)
 include(CheckCSourceRuns)
 include(CheckCSourceCompiles)
@@ -104,6 +112,11 @@ if(Intl_FOUND)
 	include_directories(SYSTEM ${Intl_INCLUDE_DIRS})
 endif()
 
+find_program(MSGFMT_EXE msgfmt)
+if(NOT MSGFMT_EXE)
+	message(WARNING "Text Translations won't be build")
+endif()
+
 #default behaviour
 include_directories(${CMAKE_SOURCE_DIR})
 add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
@@ -573,3 +586,99 @@ add_custom_command(OUTPUT ${git_links} ${git_http_links}
 		COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
 		DEPENDS git git-remote-http)
 add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
+
+
+#creating required scripts
+set(SHELL_PATH /bin/sh)
+set(PERL_PATH /usr/bin/perl)
+set(LOCALEDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
+set(GITWEBDIR ${FALLBACK_RUNTIME_PREFIX}/share/locale)
+set(INSTLIBDIR ${FALLBACK_RUNTIME_PREFIX}/share/perl5)
+
+#shell scripts
+parse_makefile_for_scripts(git_sh_scripts "SCRIPT_SH" ".sh")
+set(git_shell_scripts
+	${git_sh_scripts}
+	git-mergetool--lib git-parse-remote git-rebase--preserve-merges
+	git-sh-setup git-sh-i18n git-instaweb)
+
+foreach(script ${git_shell_scripts})
+	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.sh content NEWLINE_CONSUME)
+	string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" content "${content}")
+	string(REPLACE "@@DIFF@@" "diff" content "${content}")
+	string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" content "${content}")
+	string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" content "${content}")
+	string(REPLACE "@@NO_CURL@@" "" content "${content}")
+	string(REPLACE "@@USE_GETTEXT_SCHEME@@" "" content "${content}")
+	string(REPLACE "# @@BROKEN_PATH_FIX@@" "" content "${content}")
+	string(REPLACE "@@PERL@@" "${PERL_PATH}" content "${content}")
+	string(REPLACE "@@SANE_TEXT_GREP@@" "-a" content "${content}")
+	string(REPLACE "@@PAGER_ENV@@" "LESS=FRX LV=-c" content "${content}")
+	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+endforeach()
+
+#perl scripts
+parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
+
+#create perl header
+file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
+string(REPLACE "@@PATHSEP@@" ":" perl_header "${perl_header}")
+string(REPLACE "@@INSTLIBDIR@@" "${INSTLIBDIR}" perl_header "${perl_header}")
+
+foreach(script ${git_perl_scripts})
+	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
+	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
+	string(REPLACE "@@GIT_VERSION@@" "${PROJECT_VERSION}" content "${content}")
+	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
+endforeach()
+
+#python script
+file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
+string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
+file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
+
+#perl modules
+file(GLOB_RECURSE perl_modules "${CMAKE_SOURCE_DIR}/perl/*.pm")
+
+foreach(pm ${perl_modules})
+	string(REPLACE "${CMAKE_SOURCE_DIR}/perl/" "" file_path ${pm})
+	file(STRINGS ${pm} content NEWLINE_CONSUME)
+	string(REPLACE "@@LOCALEDIR@@" "${LOCALEDIR}" content "${content}")
+	string(REPLACE "@@NO_PERL_CPAN_FALLBACKS@@" "" content "${content}")
+	file(WRITE ${CMAKE_BINARY_DIR}/perl/build/lib/${file_path} ${content})
+#test-lib.sh requires perl/build/lib to be the build directory of perl modules
+endforeach()
+
+
+#templates
+file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
+set(hooks_templates
+	applypatch-msg.sample pre-applypatch.sample pre-push.sample
+	commit-msg.sample pre-commit.sample pre-rebase.sample
+	fsmonitor-watchman.sample pre-merge-commit.sample pre-receive.sample
+	post-update.sample prepare-commit-msg.sample update.sample)
+
+#templates have @.*@ replacement so use configure_file instead
+#hooks
+foreach(tm ${hooks_templates})
+	configure_file(${CMAKE_SOURCE_DIR}/templates/hooks--${tm} ${CMAKE_BINARY_DIR}/templates/blt/hooks/${tm} @ONLY)
+endforeach()
+
+#info
+configure_file(${CMAKE_SOURCE_DIR}/templates/info--exclude ${CMAKE_BINARY_DIR}/templates/blt/info/exclude @ONLY)
+
+#this
+configure_file(${CMAKE_SOURCE_DIR}/templates/this--description ${CMAKE_BINARY_DIR}/templates/blt/description @ONLY)
+
+
+#translations
+if(MSGFMT_EXE)
+	set(po_files bg  ca  de  el  es  fr  is  it  ko  pt_PT  ru  sv  tr  vi  zh_CN  zh_TW)
+	foreach(po ${po_files})
+		file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES)
+		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo
+				COMMAND ${MSGFMT_EXE} --check --statistics -o ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo ${CMAKE_SOURCE_DIR}/po/${po}.po)
+		list(APPEND po_gen ${CMAKE_BINARY_DIR}/po/build/locale/${po}/LC_MESSAGES/git.mo)
+	endforeach()
+	add_custom_target(po-gen ALL DEPENDS ${po_gen})
+endif()
-- 
gitgitgadget

