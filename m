Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48028C7619D
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2124921D56
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 01:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBZLMZPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBTB7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 20:59:15 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:50270 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgBTB7M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 20:59:12 -0500
Received: by mail-qk1-f202.google.com with SMTP id b23so1649362qkg.17
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 17:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XOVEK94ibAWDiwcsIzDovjRx3yjjmSxllhzBsSKMAkg=;
        b=RBZLMZPfyGAY2iMlT6Pw7oh92HO4nmLYZbMjBsZEwLZp2RXzxACXYx8IEGKr/sAp5j
         pG1gC1ICP7X7jrS+ZnN/WC6D1h0ObDiKF2Q1UQrnuVQC2ZmjqQRV0zaaFF6ucOfCPNhB
         3zo4sdAizBDzXjUHo2njLGDLn+u4912T6hIpQKxfT73PZi3l56fsZDMSrmge1SYLnN/L
         KhpTrX425d5D66+SUJk13DUWcLnv29Q5lYDjcLkFffKMQlPXtQYM25pbF/e14BwyPXNW
         hgoKfXWpO+oRiBEYjsFuGWUJ5nqQLFmcYFOyIyxaH5DoVm2FNnj8DRn6emaseOEOcMsJ
         0lvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XOVEK94ibAWDiwcsIzDovjRx3yjjmSxllhzBsSKMAkg=;
        b=B3U8qtreUon7zqsWtI5RpBfX+ABkoEfhPFMdoZhFVhvBJnLObqi8oBJWEzQBbEJ8pW
         GKLG5NktSQ34m5RWAI9TKUViTxRv0dJekuvEVHVbsT5uI/kph6xjeQKhovgUrsmF63+i
         L0oYfCFRoYD7gyC4pit7b6aGSRyQNhcU4vFxYmXJIN/8YGVSJe5qKIql8qmloXc6Yc9G
         eCa7s04GWIzytUc7mbBQ8DlntTUz97W+LWXJuP0/MY6jQ0q/WjVDX1jhNo0/QNOaVI/p
         nvW4x/Xe3aLENO/FQhcMheXErqiZOYIeTKaYInbWEev+Yk9rHtUi1qujTQANdBIDc/fy
         y+mg==
X-Gm-Message-State: APjAAAV0xUoAMrp+uerMMDa0ts/OyDtA0FaQ1bGWYjsM3ToW9TZViTUX
        Kt/ORSA8ZKDt4UPgw+CQDaZ9P9ijcABBoj2hXI+F09bbV3aujctNoo007twLybNFL4t05W0zU1i
        MXkbqUlRa2UYFJNG+5guEWczD7D4VeYqtlJN0ArDmk8xwgzK6lCb60BZIWy1rGEaa6dmuxp6TuQ
        ==
X-Google-Smtp-Source: APXvYqzAK5VTU/wkEG2jamLMFPrpfnonr2Q6lfc8TyQ3K3LVOoPfBfO5FLba1puySUR5tudg1ZO76d1BZV2Auy6UpJo=
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr24032568qvb.122.1582163948731;
 Wed, 19 Feb 2020 17:59:08 -0800 (PST)
Date:   Wed, 19 Feb 2020 17:58:44 -0800
In-Reply-To: <20200220015858.181086-1-emilyshaffer@google.com>
Message-Id: <20200220015858.181086-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200220015858.181086-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v8 01/15] help: move list_config_help to builtin/help
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Starting in 3ac68a93fd2, help.o began to depend on builtin/branch.o,
builtin/clean.o, and builtin/config.o. This meant that help.o was
unusable outside of the context of the main Git executable.

To make help.o usable by other commands again, move list_config_help()
into builtin/help.c (where it makes sense to assume other builtin libraries
are present).

When command-list.h is included but a member is not used, we start to
hear a compiler warning. Since the config list is generated in a fairly
different way than the command list, and since commands and config
options are semantically different, move the config list into its own
header and move the generator into its own script and build rule.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 .gitignore             |  1 +
 Makefile               | 13 +++++--
 builtin/help.c         | 86 ++++++++++++++++++++++++++++++++++++++++++
 generate-cmdlist.sh    | 19 ----------
 generate-configlist.sh | 21 +++++++++++
 help.c                 | 85 -----------------------------------------
 help.h                 |  1 -
 7 files changed, 118 insertions(+), 108 deletions(-)
 create mode 100755 generate-configlist.sh

diff --git a/.gitignore b/.gitignore
index aebe7c0908..ea97de83f3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -189,6 +189,7 @@
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
 /gitweb/static/gitweb.min.*
+/config-list.h
 /command-list.h
 *.tar.gz
 *.dsc
diff --git a/Makefile b/Makefile
index 6134104ae6..c552312d3f 100644
--- a/Makefile
+++ b/Makefile
@@ -815,6 +815,7 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
+GENERATED_H += config-list.h
 GENERATED_H += command-list.h
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
@@ -2132,7 +2133,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: command-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -2152,6 +2153,12 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
+config-list.h: generate-configlist.sh
+
+config-list.h:
+	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh \
+		>$@+ && mv $@+ $@
+
 command-list.h: generate-cmdlist.sh command-list.txt
 
 command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Documentation/config/*.txt
@@ -2785,7 +2792,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-EXCEPT_HDRS := command-list.h unicode-width.h compat/% xdiff/%
+EXCEPT_HDRS := command-list.h config-list.h unicode-width.h compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
 endif
@@ -2807,7 +2814,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
-check: command-list.h
+check: config-list.h command-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
diff --git a/builtin/help.c b/builtin/help.c
index e5590d7787..1c5f2b9255 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -8,6 +8,7 @@
 #include "parse-options.h"
 #include "run-command.h"
 #include "column.h"
+#include "config-list.h"
 #include "help.h"
 #include "alias.h"
 
@@ -62,6 +63,91 @@ static const char * const builtin_help_usage[] = {
 	NULL
 };
 
+struct slot_expansion {
+	const char *prefix;
+	const char *placeholder;
+	void (*fn)(struct string_list *list, const char *prefix);
+	int found;
+};
+
+static void list_config_help(int for_human)
+{
+	struct slot_expansion slot_expansions[] = {
+		{ "advice", "*", list_config_advices },
+		{ "color.branch", "<slot>", list_config_color_branch_slots },
+		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
+		{ "color.diff", "<slot>", list_config_color_diff_slots },
+		{ "color.grep", "<slot>", list_config_color_grep_slots },
+		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
+		{ "color.remote", "<slot>", list_config_color_sideband_slots },
+		{ "color.status", "<slot>", list_config_color_status_slots },
+		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
+		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
+		{ NULL, NULL, NULL }
+	};
+	const char **p;
+	struct slot_expansion *e;
+	struct string_list keys = STRING_LIST_INIT_DUP;
+	int i;
+
+	for (p = config_name_list; *p; p++) {
+		const char *var = *p;
+		struct strbuf sb = STRBUF_INIT;
+
+		for (e = slot_expansions; e->prefix; e++) {
+
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
+			if (!strcasecmp(var, sb.buf)) {
+				e->fn(&keys, e->prefix);
+				e->found++;
+				break;
+			}
+		}
+		strbuf_release(&sb);
+		if (!e->prefix)
+			string_list_append(&keys, var);
+	}
+
+	for (e = slot_expansions; e->prefix; e++)
+		if (!e->found)
+			BUG("slot_expansion %s.%s is not used",
+			    e->prefix, e->placeholder);
+
+	string_list_sort(&keys);
+	for (i = 0; i < keys.nr; i++) {
+		const char *var = keys.items[i].string;
+		const char *wildcard, *tag, *cut;
+
+		if (for_human) {
+			puts(var);
+			continue;
+		}
+
+		wildcard = strchr(var, '*');
+		tag = strchr(var, '<');
+
+		if (!wildcard && !tag) {
+			puts(var);
+			continue;
+		}
+
+		if (wildcard && !tag)
+			cut = wildcard;
+		else if (!wildcard && tag)
+			cut = tag;
+		else
+			cut = wildcard < tag ? wildcard : tag;
+
+		/*
+		 * We may produce duplicates, but that's up to
+		 * git-completion.bash to handle
+		 */
+		printf("%.*s\n", (int)(cut - var), var);
+	}
+	string_list_clear(&keys, 0);
+}
+
 static enum help_format parse_help_format(const char *format)
 {
 	if (!strcmp(format, "man"))
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 71158f7d8b..45fecf8bdf 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -76,23 +76,6 @@ print_command_list () {
 	echo "};"
 }
 
-print_config_list () {
-	cat <<EOF
-static const char *config_name_list[] = {
-EOF
-	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
-	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
-	sort |
-	while read line
-	do
-		echo "	\"$line\","
-	done
-	cat <<EOF
-	NULL,
-};
-EOF
-}
-
 exclude_programs=
 while test "--exclude-program" = "$1"
 do
@@ -113,5 +96,3 @@ echo
 define_category_names "$1"
 echo
 print_command_list "$1"
-echo
-print_config_list
diff --git a/generate-configlist.sh b/generate-configlist.sh
new file mode 100755
index 0000000000..8692fe5cf4
--- /dev/null
+++ b/generate-configlist.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+echo "/* Automatically generated by generate-configlist.sh */"
+echo
+
+print_config_list () {
+	cat <<EOF
+static const char *config_name_list[] = {
+EOF
+	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
+	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
+	sort |
+	sed 's/^.*$/	"&",/'
+	cat <<EOF
+	NULL,
+};
+EOF
+}
+
+echo
+print_config_list
diff --git a/help.c b/help.c
index cf67624a94..a21487db77 100644
--- a/help.c
+++ b/help.c
@@ -407,91 +407,6 @@ void list_common_guides_help(void)
 	putchar('\n');
 }
 
-struct slot_expansion {
-	const char *prefix;
-	const char *placeholder;
-	void (*fn)(struct string_list *list, const char *prefix);
-	int found;
-};
-
-void list_config_help(int for_human)
-{
-	struct slot_expansion slot_expansions[] = {
-		{ "advice", "*", list_config_advices },
-		{ "color.branch", "<slot>", list_config_color_branch_slots },
-		{ "color.decorate", "<slot>", list_config_color_decorate_slots },
-		{ "color.diff", "<slot>", list_config_color_diff_slots },
-		{ "color.grep", "<slot>", list_config_color_grep_slots },
-		{ "color.interactive", "<slot>", list_config_color_interactive_slots },
-		{ "color.remote", "<slot>", list_config_color_sideband_slots },
-		{ "color.status", "<slot>", list_config_color_status_slots },
-		{ "fsck", "<msg-id>", list_config_fsck_msg_ids },
-		{ "receive.fsck", "<msg-id>", list_config_fsck_msg_ids },
-		{ NULL, NULL, NULL }
-	};
-	const char **p;
-	struct slot_expansion *e;
-	struct string_list keys = STRING_LIST_INIT_DUP;
-	int i;
-
-	for (p = config_name_list; *p; p++) {
-		const char *var = *p;
-		struct strbuf sb = STRBUF_INIT;
-
-		for (e = slot_expansions; e->prefix; e++) {
-
-			strbuf_reset(&sb);
-			strbuf_addf(&sb, "%s.%s", e->prefix, e->placeholder);
-			if (!strcasecmp(var, sb.buf)) {
-				e->fn(&keys, e->prefix);
-				e->found++;
-				break;
-			}
-		}
-		strbuf_release(&sb);
-		if (!e->prefix)
-			string_list_append(&keys, var);
-	}
-
-	for (e = slot_expansions; e->prefix; e++)
-		if (!e->found)
-			BUG("slot_expansion %s.%s is not used",
-			    e->prefix, e->placeholder);
-
-	string_list_sort(&keys);
-	for (i = 0; i < keys.nr; i++) {
-		const char *var = keys.items[i].string;
-		const char *wildcard, *tag, *cut;
-
-		if (for_human) {
-			puts(var);
-			continue;
-		}
-
-		wildcard = strchr(var, '*');
-		tag = strchr(var, '<');
-
-		if (!wildcard && !tag) {
-			puts(var);
-			continue;
-		}
-
-		if (wildcard && !tag)
-			cut = wildcard;
-		else if (!wildcard && tag)
-			cut = tag;
-		else
-			cut = wildcard < tag ? wildcard : tag;
-
-		/*
-		 * We may produce duplicates, but that's up to
-		 * git-completion.bash to handle
-		 */
-		printf("%.*s\n", (int)(cut - var), var);
-	}
-	string_list_clear(&keys, 0);
-}
-
 static int get_alias(const char *var, const char *value, void *data)
 {
 	struct string_list *list = data;
diff --git a/help.h b/help.h
index 7a455beeb7..9071894e8c 100644
--- a/help.h
+++ b/help.h
@@ -22,7 +22,6 @@ static inline void mput_char(char c, unsigned int num)
 void list_common_cmds_help(void);
 void list_all_cmds_help(void);
 void list_common_guides_help(void);
-void list_config_help(int for_human);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
-- 
2.25.0.265.gbab2e86ba0-goog

