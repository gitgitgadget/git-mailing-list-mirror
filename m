Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D83EC49EA3
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761876141E
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbhFNKlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhFNKiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:38:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577A5C0611C0
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n7so7814210wri.3
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50F9Y5seLSwaPstRpyvEtgeCricW1QUgDtiwclRPDjI=;
        b=HgIuMddttzyYaAlqRWlTb7b3tt7ImPj/eqYaCoqaRCMfLQGdWuU5Mm3Bal2UlDbGPq
         /9xSrMIA3yMYXfk9nhrPKaH7yIwe6dC4UVhNRtLYah3DbFAU0BmwGfQJfxdNgWe/3MdU
         TxqBThO1kC3Luftqn5oB6L368NifUVRzRtRXWG2OUEc4wWjSD8a4mhw8ApE/GfuegtFE
         ME0BDK0hx1WkbL4GyMVt2C4aK3UpEivg7JAu1ge0cV8ROVDDtLxgbwQrmLVlSBIQKLGn
         YbeTJVZ0gspt/KTcBmwMbVioW4KTPcN7IJFd9ibOBMNMaTOVopIm04ZrOWZxgaWlAF7u
         r30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50F9Y5seLSwaPstRpyvEtgeCricW1QUgDtiwclRPDjI=;
        b=Bp8Q7cKowWhCbYH27GffYrJZeeZ/Yxjla9gx8mvfusoHBtaEWIR/1xhMUfNiyt+SuC
         MSROejTb4IkBMJm7+k6DzSKuPozAo4F8EED+oDgRCPlAIrb+E4KhSi/W7nv7QqCyAUD3
         HE5iKJeqCnRz6ly+XtJ4MLCVq5b/HOtJLkRbpEXMsMZkfKLBPvJTp6HkYrpNF3N5yuuT
         dAUh227SWR37x3aMZAOp+ztStQNDDB8X1yyk9I1OReIv7pNn6x7Z81ll7E/ZNxNE9phi
         V6iX2WbJSRyzEv+7LPGKjAskrM11yi4RfYP1hOsooDtPkLHrBRCpiURipO5VIVxxPt93
         o8zg==
X-Gm-Message-State: AOAM532yLFtt6z9Bs7vo8G7id4BsS9wJgXWsZbY1we4WLyeL3OAdaOgu
        olA+eGdA5HtcwfMN3j/AT0YDZbc2Q2uPWA==
X-Google-Smtp-Source: ABdhPJwg9tlHlk2kjj7HEPzlmauEc8SBEj9+h42pwosqzINPxmpeRMlh6195ZlceP9sozmF844iUqg==
X-Received: by 2002:a5d:694b:: with SMTP id r11mr18168238wrw.168.1623666850691;
        Mon, 14 Jun 2021 03:34:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:34:10 -0700 (PDT)
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
        <avarab@gmail.com>
Subject: [PATCH v2 30/30] hook-list.h: add a generated list of hooks, like config-list.h
Date:   Mon, 14 Jun 2021 12:33:19 +0200
Message-Id: <patch-30.30-bc086454d68-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resolve a long-standing TODO item in bugreport.c of there being no
centralized listing of hooks, this fixes a bug with the bugreport
listing only knowing about 1/4 of the p4 hooks. It didn't know about
the "reference-transaction" hook either.

We can now make sure this is kept up-to-date, as the hook.c library
will die if asked to find a hook we don't know about yet. The only
(undocumented) exception is the artificial "test-hook" used in our own
test suite. Move some of the tests away from the "does-not-exist"
pseudo-hook, and test for the new behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitignore           |  1 +
 Makefile             | 14 +++++++++++---
 builtin/bugreport.c  | 44 ++++++++------------------------------------
 generate-hooklist.sh | 24 ++++++++++++++++++++++++
 hook.c               | 22 ++++++++++++++++++++++
 t/t1800-hook.sh      | 14 +++++++++++---
 6 files changed, 77 insertions(+), 42 deletions(-)
 create mode 100755 generate-hooklist.sh

diff --git a/.gitignore b/.gitignore
index de39dc9961b..66189ca3cdc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -191,6 +191,7 @@
 /gitweb/static/gitweb.min.*
 /config-list.h
 /command-list.h
+/hook-list.h
 *.tar.gz
 *.dsc
 *.deb
diff --git a/Makefile b/Makefile
index a6b71a0fbed..d0532f3c744 100644
--- a/Makefile
+++ b/Makefile
@@ -817,6 +817,7 @@ XDIFF_LIB = xdiff/lib.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
+GENERATED_H += hook-list.h
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
 	$(FIND) . \
@@ -2207,7 +2208,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
+hook.sp hook.s hook.o: hook-list.h
+
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -2240,6 +2243,11 @@ command-list.h: $(wildcard Documentation/git*.txt)
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
@@ -2890,7 +2898,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
+EXCEPT_HDRS := command-list.h config-list.h hook-list.h unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
@@ -2912,7 +2920,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
-check: config-list.h command-list.h
+check: config-list.h command-list.h hook-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
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
diff --git a/generate-hooklist.sh b/generate-hooklist.sh
new file mode 100755
index 00000000000..5a3f7f849c8
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
index 3cf51460279..68e8c1ba868 100644
--- a/hook.c
+++ b/hook.c
@@ -1,11 +1,33 @@
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
+	if (!strcmp(name, "test-hook") ||
+	    !strcmp(name, "does-not-exist"))
+		return 1;
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
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 1a6b708137e..a4b089eb7fe 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -6,17 +6,25 @@ test_description='git-hook command'
 
 test_expect_success 'git hook run -- nonexistent hook' '
 	cat >stderr.expect <<-\EOF &&
-	error: cannot find a hook named does-not-exist
+	error: cannot find a hook named test-hook
 	EOF
-	test_expect_code 1 git hook run does-not-exist 2>stderr.actual &&
+	test_expect_code 1 git hook run test-hook 2>stderr.actual &&
 	test_cmp stderr.expect stderr.actual
 '
 
 test_expect_success 'git hook run -- nonexistent hook with --ignore-missing' '
-	git hook run --ignore-missing does-not-exist 2>stderr.actual &&
+	git hook run --ignore-missing test-hook 2>stderr.actual &&
 	test_must_be_empty stderr.actual
 '
 
+test_expect_success 'git hook run -- nonexistent hook with --ignore-missing' '
+	cat >stderr.expect <<-\EOF &&
+	fatal: the hook '"'"'unknown-hook'"'"' is not known to git, should be in hook-list.h via githooks(5)
+	EOF
+	test_expect_code 128 git hook run unknown-hook 2>stderr.actual &&
+	test_cmp stderr.expect stderr.actual
+'
+
 test_expect_success 'git hook run -- basic' '
 	write_script .git/hooks/test-hook <<-EOF &&
 	echo Test hook
-- 
2.32.0.rc3.434.gd8aed1f08a7

