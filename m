Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2446C433EF
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC78C60EE4
	for <git@archiver.kernel.org>; Sun, 26 Sep 2021 19:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhIZTF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 15:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhIZTFR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 15:05:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B6CC061604
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:40 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v17so2015853wrv.9
        for <git@vger.kernel.org>; Sun, 26 Sep 2021 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYEONVduxMEKD6Z4E0+Rm3E/MNFnUnQKAp467O6U5mc=;
        b=hDSMHOqREvGBk17QhKeZB0eQhXgIbXJIY1fJZEY4V44sgwSHIv62QOTl9N7BVBRlPI
         b8ImDyo3LuPLYA64WfXEaFDFKG+Px5u2Wt3ldDjByfMXtwhQ2UGIbYhuqaZjJ6FkZgn/
         yapsEbrN7kh4H9941fjAj7aU1Zj95LgXNwgZLK1zHQAxhtxQOnTEfP8BboA9wNSpqkQZ
         q4L+mUdz88FVj48y2jepyn90eQcjkZQUxy40BqP8rL58ZAcXjJJodyAe+2CrhiR7PEPu
         cGRa7IIiExp2ZmnTuhcnKai8nDaFe8oxLdsOWlHOvbdMwjdfuJ6XYMrQEtOdIZUz1KQ8
         AAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYEONVduxMEKD6Z4E0+Rm3E/MNFnUnQKAp467O6U5mc=;
        b=Pmfdizgp7bgKMBDGG3itQD/ePQl3USaSFsomZQB2hqOrM3GqmnkGPY9CixADLlfmaJ
         M9Fz8JaVbTRtNADBM5bk5GoyJOI9NI8w9ezV0HWfy32BMEDmWbOMZFfOPazD3jevN1Oq
         xC0byT6+Ukdo44JEEfxgK9LmimJiaxSiUMYh1wTVwFXpojw+4Q5JxvcSAHopT6sjKcyn
         8gUaYxF+8UAU2uF3IwlB0ysIyvDNNiD90U5BNTNWUaA55KOrMnn+RJ2Hc1LzGthPBV1s
         lRrjqTzkzIITGLMXuFVC5VzElIcz9frk8EgFYQYeDZ/tdxuTQnJ/Ho0LWt4+r2mYzwm1
         wBzg==
X-Gm-Message-State: AOAM53299ky/WCM7abIMkprZdWuw911uk2fpEtVT5/PnaG8W1rWIgBNf
        GBjS8xPJ6ziWDbQYv0p+k5iJHgsboa6MHQ==
X-Google-Smtp-Source: ABdhPJwBvXaf5CbNSVfZg78Lhv9yIaYr2YrIbX5zu9GSwoYfOSSD42RVmY+oBsIrr07VBtzwnxtSJw==
X-Received: by 2002:a1c:43c3:: with SMTP id q186mr4179033wma.143.1632683018680;
        Sun, 26 Sep 2021 12:03:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v20sm14691523wra.73.2021.09.26.12.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 12:03:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] hook-list.h: add a generated list of hooks, like config-list.h
Date:   Sun, 26 Sep 2021 21:03:29 +0200
Message-Id: <patch-v2-8.8-7420267ce09-20210926T185800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1291.g8857a6a91ac
In-Reply-To: <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210926T185800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make githooks(5) the source of truth for what hooks git supports, and
punt out early on hooks we don't know about in find_hook(). This
ensures that the documentation and the C code's idea about existing
hooks doesn't diverge.

We still have Perl and Python code running its own hooks, but that'll
be addressed by Emily Shaffer's upcoming "git hook run" command.

This resolves a long-standing TODO item in bugreport.c of there being
no centralized listing of hooks, and fixes a bug with the bugreport
listing only knowing about 1/4 of the p4 hooks. It didn't know about
the recent "reference-transaction" hook either.

We could make the find_hook() function die() or BUG() out if the new
known_hook() returned 0, but let's make it return NULL just as it does
when it can't find a hook of a known type. Making it die() is overly
anal, and unlikely to be what we need in catching stupid typos in the
name of some new hook hardcoded in git.git's sources. By making this
be tolerant of unknown hook names, changes in a later series to make
"git hook run" run arbitrary user-configured hook names will be easier
to implement.

I have not been able to directly test the CMake change being made
here. Since 4c2c38e800 (ci: modification of main.yml to use cmake for
vs-build job, 2020-06-26) some of the Windows CI has a hard dependency
on CMake, this change works there, and is to my eyes an obviously
correct use of a pattern established in previous CMake changes,
namely:

 - 061c2240b1 (Introduce CMake support for configuring Git,
    2020-06-12)
 - 709df95b78 (help: move list_config_help to builtin/help,
    2020-04-16)
 - 976aaedca0 (msvc: add a Makefile target to pre-generate the Visual
   Studio solution, 2019-07-29)

The LC_ALL=C is needed because at least in my locale the dash ("-") is
ignored for the purposes of sorting, which results in a different
order. I'm not aware of anything in git that has a hard dependency on
the order, but e.g. the bugreport output would end up using whatever
locale was in effect when git was compiled.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: René Scharfe <l.s.r@web.de>
---
 .gitignore                          |  1 +
 Makefile                            |  8 +++++-
 builtin/bugreport.c                 | 44 ++++++-----------------------
 contrib/buildsystems/CMakeLists.txt |  7 +++++
 generate-hooklist.sh                | 20 +++++++++++++
 5 files changed, 43 insertions(+), 37 deletions(-)
 create mode 100755 generate-hooklist.sh

diff --git a/.gitignore b/.gitignore
index 311841f9bed..6be9de41ae8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -190,6 +190,7 @@
 /gitweb/static/gitweb.min.*
 /config-list.h
 /command-list.h
+/hook-list.h
 *.tar.gz
 *.dsc
 *.deb
diff --git a/Makefile b/Makefile
index 1f2b0205da5..21e2bcc21e3 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,8 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+GENERATED_H += hook-list.h
+
 .PHONY: generated-hdrs
 generated-hdrs: $(GENERATED_H)
 
@@ -2208,8 +2210,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 		$(filter %.o,$^) $(LIBS)
 
 help.sp help.s help.o: command-list.h
+hook.sp hook.s hook.o: hook-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -2241,6 +2244,9 @@ command-list.h: $(wildcard Documentation/git*.txt)
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		command-list.txt >$@
 
+hook-list.h: generate-hooklist.sh Documentation/githooks.txt
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh >$@
+
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index a02c2540bb1..9de32bc96e7 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -4,6 +4,7 @@
 #include "help.h"
 #include "compat/compiler.h"
 #include "hook.h"
+#include "hook-list.h"
 
 
 static void get_system_info(struct strbuf *sys_info)
@@ -41,39 +42,7 @@ static void get_system_info(struct strbuf *sys_info)
 
 static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 {
-	/*
-	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
-	 * so below is a transcription of `git help hooks`. Later, this should
-	 * be replaced with some programmatically generated list (generated from
-	 * doc or else taken from some library which tells us about all the
-	 * hooks)
-	 */
-	static const char *hook[] = {
-		"applypatch-msg",
-		"pre-applypatch",
-		"post-applypatch",
-		"pre-commit",
-		"pre-merge-commit",
-		"prepare-commit-msg",
-		"commit-msg",
-		"post-commit",
-		"pre-rebase",
-		"post-checkout",
-		"post-merge",
-		"pre-push",
-		"pre-receive",
-		"update",
-		"post-receive",
-		"post-update",
-		"push-to-checkout",
-		"pre-auto-gc",
-		"post-rewrite",
-		"sendemail-validate",
-		"fsmonitor-watchman",
-		"p4-pre-submit",
-		"post-index-change",
-	};
-	int i;
+	const char **p;
 
 	if (nongit) {
 		strbuf_addstr(hook_info,
@@ -81,9 +50,12 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 		return;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(hook); i++)
-		if (hook_exists(hook[i]))
-			strbuf_addf(hook_info, "%s\n", hook[i]);
+	for (p = hook_name_list; *p; p++) {
+		const char *hook = *p;
+
+		if (hook_exists(hook))
+			strbuf_addf(hook_info, "%s\n", hook);
+	}
 }
 
 static const char * const bugreport_usage[] = {
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 171b4124afe..fd1399c440f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -624,6 +624,13 @@ if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
 			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
 endif()
 
+if(NOT EXISTS ${CMAKE_BINARY_DIR}/hook-list.h)
+	message("Generating hook-list.h")
+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-hooklist.sh
+			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
+			OUTPUT_FILE ${CMAKE_BINARY_DIR}/hook-list.h)
+endif()
+
 include_directories(${CMAKE_BINARY_DIR})
 
 #build
diff --git a/generate-hooklist.sh b/generate-hooklist.sh
new file mode 100755
index 00000000000..2f9f54eb545
--- /dev/null
+++ b/generate-hooklist.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+#
+# Usage: ./generate-hooklist.sh >hook-list.h
+
+cat <<EOF
+/* Automatically generated by generate-hooklist.sh */
+
+static const char *hook_name_list[] = {
+EOF
+
+sed -n \
+	-e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}' \
+	-e 'x' \
+	<Documentation/githooks.txt |
+	LC_ALL=C sort
+
+cat <<EOF
+	NULL,
+};
+EOF
-- 
2.33.0.1291.g8857a6a91ac

