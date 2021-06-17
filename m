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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E43C49EA3
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78837613E9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhFQKLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhFQKLv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:11:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8CC061760
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:09:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n7so6106667wri.3
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYGjwRxfoCXb0Kc8G+BpcZd7EuK1P/ZncOSgZZaOleM=;
        b=uvJAwTxjjrlOmNRlA/seSKvr+5aWL+cs/WiR5vSgZvaCQx2Snn1ZilzNKikM09GC+7
         rWZ6GLoZ1JKCeeKn3GnmnFkvzoX3bIpZwfEcL2N3ecNSD6pYzsAUJWA6a0tkPv17Ml1w
         UulB+4Yaj/CGcxZu+jjuZZhj4hXkDNbI+LkNdjT35k+Ad42mE4klYeNaKG9SHjxxkUy8
         Gq7tQj4D6tDVhxqEXEz1YvhnMklou8tviql3/VGWl4o8hRBbehaD0ydL5PUNdMVeu+J8
         O06GZlxR7Gvz3J7W3OL8AWnVFDEl4SBsWiNXM59zCe/y017E9UfxVd3vQWd1jHBhGRpD
         o3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYGjwRxfoCXb0Kc8G+BpcZd7EuK1P/ZncOSgZZaOleM=;
        b=J2QvVFthVYHx48D9Rsz3V/rezM3CYX5cR+W9FfdSWuyTp9xDQF8ob/8lt3DDTp7Yf9
         fHneVyzV18+XX0n9OVCvckDyLIkatt0ffrxHo9+OwHmRdEvY3vDybjGLlMZvaCP+ey51
         tPjyJrOwgOSXFxzOCBBCWMfUkxIOdDu9ktntOfCeKYjKs64BgtBgoelRRtOJPV18dXYG
         yfj7hVsco/VJxNEssGgNQbYk9uwPWEZgJNe71+XgK4L6ODbonJm2KZsNSovqsjxQrPfn
         uC8xALOKMScKE6Xg0ne9BEyiFvvOFhXnWw65uK6zoWrxRnFjn8nkY7U1lPcFVh+gXQlW
         0p9w==
X-Gm-Message-State: AOAM5328txDOs28l1eu+EQfD7pMMHifyMZ+u/bSjwmkVKNZ0oOo4UGbj
        DgdP0s9mDzP+unoEvJ5MOxlS9mvpIwPCww==
X-Google-Smtp-Source: ABdhPJzo35Un2sbdQnDl+WClRL3seVtAAgNMJKDT2Wiz2rT3vZoieCsz9BPSIjqHFolB4y3U7HUYUA==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr4584824wrw.419.1623924580926;
        Thu, 17 Jun 2021 03:09:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9sm7348425wmm.33.2021.06.17.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:09:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] hook-list.h: add a generated list of hooks, like config-list.h
Date:   Thu, 17 Jun 2021 12:09:36 +0200
Message-Id: <patch-3.3-f343fc7ae6-20210617T100239Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore                          |  1 +
 Makefile                            | 11 +++++++-
 builtin/bugreport.c                 | 44 ++++++-----------------------
 contrib/buildsystems/CMakeLists.txt |  7 +++++
 generate-hooklist.sh                | 24 ++++++++++++++++
 hook.c                              | 19 +++++++++++++
 6 files changed, 69 insertions(+), 37 deletions(-)
 create mode 100755 generate-hooklist.sh

diff --git a/.gitignore b/.gitignore
index 311841f9be..6be9de41ae 100644
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
index d155b7be21..9bd31e1ac5 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,8 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+GENERATED_H += hook-list.h
+
 .PHONY: generated-hdrs
 generated-hdrs: $(GENERATED_H)
 
@@ -2208,7 +2210,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
+hook.sp hook.s hook.o: hook-list.h
+
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -2241,6 +2245,11 @@ command-list.h: $(wildcard Documentation/git*.txt)
 		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
 		command-list.txt >$@+ && mv $@+ $@
 
+hook-list.h: generate-hooklist.sh
+hook-list.h: Documentation/githooks.txt
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh \
+		>$@+ && mv $@+ $@
+
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
 	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 941c8d5e27..a7a1fcb8a7 100644
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
index a87841340e..c216940945 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -602,6 +602,13 @@ if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
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
index 0000000000..5a3f7f849c
--- /dev/null
+++ b/generate-hooklist.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+echo "/* Automatically generated by generate-hooklist.sh */"
+
+print_hook_list () {
+	cat <<EOF
+static const char *hook_name_list[] = {
+EOF
+	perl -ne '
+		chomp;
+		@l[$.] = $_;
+		push @h => $l[$. - 1] if /^~~~+$/s;
+		END {
+			print qq[\t"$_",\n] for sort @h;
+		}
+	' <Documentation/githooks.txt
+	cat <<EOF
+	NULL,
+};
+EOF
+}
+
+echo
+print_hook_list
diff --git a/hook.c b/hook.c
index 97cd799a32..1f1db1ec9b 100644
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
2.32.0.576.g59759b6ca7d

