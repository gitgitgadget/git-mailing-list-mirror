Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D5FC4320A
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023BE60BD3
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbhHCTjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbhHCTjc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998CCC06179F
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso2477282wms.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lRk0MGLktbzJCc0V9oecVeu57BoPU490W6nuOv4B+Nk=;
        b=qNTw00H6HMDXQr+Q46eOkCkG1ffNV5Dx/kPlcHFln6AdUJoKHpWZjS8kAs+HhOIfXR
         mXmofZ4xdhVBJamPgfoDOMIQbuwEYKQdUcpbIiPc9JTbppiUPFYq3JAVDmOyjbV3yVX8
         SOrk5ldm4J43tdesd72A1ixzGguC2y+IIdPc4ctdnjbOik2Ia4vZ6s08wW0bGVT3p+/8
         ESBjxcVs93KSQSGW23NhRgjpEiQcJYs6Ljj48nTCBBrZgOb8YLKBf6jp0w4a28ofnI3t
         AwAppIvH8e0hJrZpioP++rGlmZLR/mMIYf0gqUAtJbe426xJL1me4Ybkskg+sXmdO6v4
         YVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lRk0MGLktbzJCc0V9oecVeu57BoPU490W6nuOv4B+Nk=;
        b=oxLbku6xrZMqmIjjNeVHarDUKRbWWHj4GwsjrihxYbepP3CEv2smb9xyqzzv3e/yzF
         AqcOEMTgW8WOkUeAnRMUEoSYe0MiNZ1I4rlQj9ywC0YKZnNRYhEu0w2z6XcUxdSo77Uz
         hIlMyGP5/jejZADXOTTRDJz4DTJaz9IAZlfwVD5t6PcwISACOVo9XHgEU8C1TnGHULv7
         7lBsgwW8as5TBZYj+bAEx0UDs79xI20RQxvdlfMXbpJCHBJUekIOSFYWbZbyqUi/g9r4
         S8gRB/HUrLGcl4JDcvUyfwH5W9DD3hidddLalc6Wq/kNhWxo3a0wa8fRiFaJsB+wrYDa
         1xoQ==
X-Gm-Message-State: AOAM5318c9JClTGGpaW4DskBOBI7+rlv1aLBcS4DCTNx+jNdBAOMB3cr
        dunvocqdcZS7sWQR9YclBsGzL55eLSmwCw==
X-Google-Smtp-Source: ABdhPJz7qDIl6dGbG1qbAkcKetI8Hm6jnw7rWr4IBdlB3zPxzXq/ugqCW04EaDrJFThD5/w+rJxM1w==
X-Received: by 2002:a05:600c:2dd0:: with SMTP id e16mr23894360wmh.113.1628019556816;
        Tue, 03 Aug 2021 12:39:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 07/36] hook-list.h: add a generated list of hooks, like config-list.h
Date:   Tue,  3 Aug 2021 21:38:33 +0200
Message-Id: <patch-v4-07.36-4cfd72722c1-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make githooks(5) the source of truth for what hooks git supports, and
die hooks we don't know about in find_hook(). This ensures that the
documentation and the C code's idea about existing hooks doesn't
diverge.

We still have Perl and Python code running its own hooks, but that'll
be addressed by Emily Shaffer's upcoming "git hook run" command.

This resolves a long-standing TODO item in bugreport.c of there being
no centralized listing of hooks, and fixes a bug with the bugreport
listing only knowing about 1/4 of the p4 hooks. It didn't know about
the recent "reference-transaction" hook either.

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
 Makefile                            | 10 ++++++-
 builtin/bugreport.c                 | 44 ++++++-----------------------
 contrib/buildsystems/CMakeLists.txt |  7 +++++
 generate-hooklist.sh                | 18 ++++++++++++
 hook.c                              | 19 +++++++++++++
 6 files changed, 62 insertions(+), 37 deletions(-)
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
index bc258886904..1740b99db00 100644
--- a/Makefile
+++ b/Makefile
@@ -823,6 +823,8 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+GENERATED_H += hook-list.h
+
 .PHONY: generated-hdrs
 generated-hdrs: $(GENERATED_H)
 
@@ -2226,7 +2228,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
+hook.sp hook.s hook.o: hook-list.h
+
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -2259,6 +2263,10 @@ command-list.h: $(wildcard Documentation/git*.txt)
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		command-list.txt >$@+ && mv $@+ $@
 
+hook-list.h: generate-hooklist.sh Documentation/githooks.txt
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh \
+		>$@+ && mv $@+ $@
+
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 941c8d5e270..a7a1fcb8a7a 100644
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
index 00000000000..6d4e56d1a31
--- /dev/null
+++ b/generate-hooklist.sh
@@ -0,0 +1,18 @@
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
+sed -n -e '/^~~~~*$/ {x; s/^.*$/	"&",/; p;}; x' \
+	<Documentation/githooks.txt |
+	LC_ALL=C sort
+
+cat <<EOF
+	NULL,
+};
+EOF
diff --git a/hook.c b/hook.c
index 97cd799a320..1f1db1ec9bf 100644
--- a/hook.c
+++ b/hook.c
@@ -1,11 +1,30 @@
 #include "cache.h"
 #include "hook.h"
 #include "run-command.h"
+#include "hook-list.h"
+
+static int known_hook(const char *name)
+{
+	const char **p;
+	size_t len = strlen(name);
+	for (p = hook_name_list; *p; p++) {
+		const char *hook = *p;
+
+		if (!strncmp(name, hook, len) && hook[len] == '\0')
+			return 1;
+	}
+
+	return 0;
+}
 
 const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
 
+	if (!known_hook(name))
+		die(_("the hook '%s' is not known to git, should be in hook-list.h via githooks(5)"),
+		    name);
+
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0) {
-- 
2.33.0.rc0.595.ge31e012651d

