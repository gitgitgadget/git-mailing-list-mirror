Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1986CC433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6216207F7
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 18:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1e7mkLa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgFLS3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgFLS3d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 14:29:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DDFC08C5C1
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so10691431wrv.4
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fM6k/y9r6L6+uhRJkQJTc0G/DZ9x2espfI9XgsEJX2g=;
        b=f1e7mkLavqKHXc4QUg7ZjBymkbeV3G3hV08AHOIbrtJoG6meYBjNQ8D10iv0isShBh
         Gimqbwxgq2Q3cBuZ6pzGS7LkVXTK/mi4SQGfn8OoDQpjjxq5aQmwnhW168PL0ThSdojf
         cgVMxBmHZNzhbvBN2AIwIxNPHMkZGGWrC5eAiIrBHrpq29eV5CAlmo7RB8Ps0Z7DUvUY
         NRoOfOQaqWxsms/VMP4Mqx2fwTuu4qIHqbq7f/5tjzpL7NHCEkHcQAvkqfZewZSDke2R
         H9MAKImyQTZPXsgOFyfiYb/OdcQj4wi86WSfsTl8imjQxJv+X3cPnzEkSg9oXQCqukAQ
         saag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fM6k/y9r6L6+uhRJkQJTc0G/DZ9x2espfI9XgsEJX2g=;
        b=LjbJgKMd1fDeltU6QNJgTzqho94gzRj7nQtJc80u+yftoN2qwkwsqFb/6yUXJQzWTC
         9SgitmIi7Qjwmm515Qd03Akje7KVF1JAuyMI/YFhkm/3EIVDNfJKio06QmXBt49T8zm+
         TMti74ZUdGALGoW+HJQXQjiKE1tO+nwtvmk6i9xvpQwqk1kmul7CjSoOxzmb2EFliI/e
         Z7yeL1pI19HTuUu7GCWKR2KdcLhNprE+Q0jkwbeT/NBiFLpl0vYr+lpI+C2lsUszPxkD
         AwBhGc1mymKGPdpquoA5Jlu5JSHK82e+F/VuJ8xE5iCW4PBtuTtJTkNLKmmiioHoLhPU
         AP/w==
X-Gm-Message-State: AOAM532t/vJjx+Pcul/x9+k53O1zPifsQzy8nBibvzURgczxqZ6oJt+Y
        Hte0xVen+0bXXTL70vdQTbL1OmX6
X-Google-Smtp-Source: ABdhPJwiN5MfXGUZ7ktTjSpBTEbLddN8/N7PWS3Z1fCFFb4Frgls1HKQKez2ojVRssCGO3lwkKYg1A==
X-Received: by 2002:adf:f7ce:: with SMTP id a14mr15952565wrq.362.1591986570340;
        Fri, 12 Jun 2020 11:29:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m24sm9825309wmi.14.2020.06.12.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 11:29:29 -0700 (PDT)
Message-Id: <abb9e6e1d585b34d55ec2b447a80f7ddf6dcb7da.1591986566.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
References: <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
        <pull.614.v4.git.1591986566.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Jun 2020 18:29:20 +0000
Subject: [PATCH v4 2/8] cmake: generate the shell/perl/python scripts and
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

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 contrib/buildsystems/CMakeLists.txt | 110 +++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1e910d9df85..b3863bffee6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -66,7 +66,7 @@ project(git
 	LANGUAGES C)
 
 
-#macros for parsing the Makefile for sources
+#macros for parsing the Makefile for sources and scripts
 macro(parse_makefile_for_sources list_var regex)
 	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
 	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
@@ -77,6 +77,16 @@ macro(parse_makefile_for_sources list_var regex)
 	list(REMOVE_ITEM ${list_var} "") #remove empty list elements
 endmacro()
 
+macro(parse_makefile_for_scripts list_var regex lang)
+	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
+	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
+	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
+	string(REPLACE " " ";" ${list_var} ${${list_var}}) #convert string to a list
+	if(NOT ${lang}) #exclude for SCRIPT_LIB
+		list(TRANSFORM ${list_var} REPLACE "${lang}" "") #do the replacement
+	endif()
+endmacro()
+
 include(CheckTypeSize)
 include(CheckCSourceRuns)
 include(CheckCSourceCompiles)
@@ -112,6 +122,11 @@ if(Intl_FOUND)
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
@@ -590,3 +605,96 @@ add_custom_command(OUTPUT ${git_links} ${git_http_links}
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
+parse_makefile_for_scripts(git_shlib_scripts "SCRIPT_LIB" "")
+set(git_shell_scripts
+	${git_sh_scripts} ${git_shlib_scripts} git-instaweb)
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
+file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
+list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
+list(REMOVE_ITEM templates ".gitignore")
+list(REMOVE_ITEM templates "Makefile")
+
+list(REMOVE_ITEM templates "branches--")
+file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
+
+#templates have @.*@ replacement so use configure_file instead
+foreach(tm ${templates})
+	string(REPLACE "--" "/" blt_tm ${tm})
+	string(REPLACE "this" "" blt_tm ${blt_tm})# for this--
+	configure_file(${CMAKE_SOURCE_DIR}/templates/${tm} ${CMAKE_BINARY_DIR}/templates/blt/${blt_tm} @ONLY)
+endforeach()
+
+
+#translations
+if(MSGFMT_EXE)
+	file(GLOB po_files "${CMAKE_SOURCE_DIR}/po/*.po")
+	list(TRANSFORM po_files REPLACE "${CMAKE_SOURCE_DIR}/po/" "")
+	list(TRANSFORM po_files REPLACE ".po" "")
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

