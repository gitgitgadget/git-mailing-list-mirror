Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A965BC5518A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FA320774
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6URRGIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDXEBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726031AbgDXEBm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 00:01:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C404CC09B046
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x4so8909238wmj.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BvKxDIUZtFzcjTUd0oRMgPzqcdtXj74OPUNH44IfWpA=;
        b=l6URRGIEjVRix5r7V8QVmR8foW9bILSVMe7Qq+ximfkVHvrVbylkVWQPyPtMRp1yN3
         kwELQXA85mJuEL0SNjEfIRQbkymlrPYCI35jrdpJFXCONF1ye7BAs8fC4peLKEHGbeJL
         /cqMCWvhQ/3O67LsPl67tCr037vksVsjeXWTVAjSLVFfooDUAjudmCdzshhLg9KXVW0A
         Iv9t/I+jgJjJVeiECYO3FfoTG4dffoDYJX6nkfyaFTZuW8j1y9PUK4IYAwvJn1aFv4RY
         kfbp877ds/UgNu+QBXwOx/fiAmVqzJlBH2VSaNLyW67IiIeTpmD3AHmzOjiGZ2NoRXf5
         jXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BvKxDIUZtFzcjTUd0oRMgPzqcdtXj74OPUNH44IfWpA=;
        b=LFWbRijvaz6IvRS4GND8fKjG246VnLSWjr67/UShPiGo1fI+0pD0Bob2qfdWMs9Lh9
         h31GkmLiMWoQQKIDB4A0HhQlmbYAtHIzK+0stbQ2/I+IZN0QECV1JcxOLFq2tkGkMsAg
         VObMg9lhHy4EIDD6Qtsns5haTU3OGOWHrIfqWkpbWc0sMrW3sMRfyi63l0f8J/6uxQGA
         dkvmxmNrZitE836uqBguXUvDIIWQZCWlwgowutcBOL08q1kEjTgWMe1jRcicJy3agTWh
         gRvXOgXpJMkTqYjXjN8FxHn0FBD6SvI+sQfdfsKjlo6e50bSqUXGONmj9abReuq0NCIe
         evlA==
X-Gm-Message-State: AGi0PuYAeOjpiS91QszKOUou6RjtxV3IvlpqL7O8vn44WuwBdVWF42NO
        S59JYdvTijVU0N2C+rJGFsw/XTEl
X-Google-Smtp-Source: APiQypJ5qcaWd7nvE5HCwJvfLDxUTGxycwOS9o2Yw/krBi9jFufpqZGRuC0fHynZJcDRmMJpjajAJQ==
X-Received: by 2002:a1c:9c0a:: with SMTP id f10mr7622662wme.139.1587700900300;
        Thu, 23 Apr 2020 21:01:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6sm6380113wrw.34.2020.04.23.21.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 21:01:39 -0700 (PDT)
Message-Id: <ca242cf5bda74aafca6c169ad53ce33a62761027.1587700897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.614.git.1587700897.gitgitgadget@gmail.com>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 04:01:31 +0000
Subject: [PATCH 2/8] cmake: generate the shell/perl/python scripts and
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

This patch implements the placeholder substitution to generate, say,
`git-request-pull` from `git-request-pull.sh`.

The shell/perl/python scripts and template are generated using CMake
(very similar to what sed does).

The text translations are only build if `msgfmt` is found in your path.

NOTE: The scripts and templates are generated during configuration.

Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
---
 CMakeLists.txt | 107 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 73703bd321f..788b53be873 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -51,6 +51,11 @@ endif()
 
 find_program(SH_EXE sh)
 
+find_program(MSGFMT_EXE msgfmt)
+if(NOT MSGFMT_EXE)
+	message(WARNING "Text Translations won't be build")
+endif()
+
 #default behaviour
 include_directories(${CMAKE_SOURCE_DIR})
 add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
@@ -525,4 +530,104 @@ endif()
 add_custom_command(OUTPUT ${git_links} ${git_http_links}
 		COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/CreateLinks.cmake
 		DEPENDS git git-remote-http)
-add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
\ No newline at end of file
+add_custom_target(git-links ALL DEPENDS ${git_links} ${git_http_links})
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
+set(git_shell_scripts
+	git-bisect git-difftool--helper git-filter-branch
+	git-merge-octopus git-merge-one-file git-merge-resolve
+	git-mergetool git-quiltimport
+	git-request-pull git-submodule git-web--browse
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
+set(git_perl_scripts
+	git-add--interactive git-archimport git-cvsexportcommit
+	git-cvsimport git-cvsserver git-send-email git-svn)
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

