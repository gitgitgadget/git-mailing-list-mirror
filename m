Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89288C2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474C42173E
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 00:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMlMPb6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfLMAnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:43:32 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:39185 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731679AbfLMAnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 19:43:31 -0500
Received: by mail-pg1-f201.google.com with SMTP id v2so348941pgv.6
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 16:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HaNUWIlAAhTM6vP3+OuIJM4fmFoY7pz91q9iMIy3d/8=;
        b=sMlMPb6KgmwlqurX5S+6GryjhFmw2XlUJXzQNy1fvUUXb24AEvmy/SEZ99mxRB0ihp
         IY1tmU76wYUd05YN4PYAuCUdwpMk7nJ+LbF3S8cwX/gtElGbO3KmzV5/OqkEh/B7omx7
         GnjZmLr5U26BYsMamZtuKI7e+fiOSaM9gJnUOrebFTYUP5J+3rf/LlU9WVdgzgCvAiBP
         OEjhyCDDROcyd5tEYad8FD0bwBBfcBKQLPFRXmXyhnw+X1oKLNPlcI1mTBx+2ljsSKVE
         guFTawLH0sYR//ow6HG9oWcSWUkSQyCvufE363C7+RbBEXF0Bmg+ByhQ/mb9ZpJ4haZp
         HTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HaNUWIlAAhTM6vP3+OuIJM4fmFoY7pz91q9iMIy3d/8=;
        b=jl0h4xLYx1iTatPrhDFugrpn1e8F7Jm73NILjS6p7MYomdpALqVq/7zpoZDXQn0xdY
         8Okfu/XkyuiI4Yi7cnzVgAwNZ12GQPL5AS2DCbxdiG9o2ZjAoUwUOa269kOyyHT9sX16
         nWjMHJRswryNniiAjVHQ0bU8gHMhWFNWM4L8lg1ivgf7xeqZaOiQrDA+fPDbofHRPrHt
         vuBfrAdwER+LECJcJT6OQYjz3vPXcI/wLsJnOFVMdo4J3ZMXsLwAbzBto0LQ7bPlHZzS
         YEqx8apQXoIqfiF44d/F3bbdkQFjC5dSrksrxfCr6Bubsk5n5UiirySuNULGP/CzB7xh
         MoHA==
X-Gm-Message-State: APjAAAWHdcrIxJgHXiGptuwtERUKMsCsttMFz5hYRFYviqHWzDqQjxxw
        ZDM4xIyIaHIPR+tO5ZjXuAY0/zFBZEeYeQSV817TwzFz0ViOEAodUu1FU6CTntXFOn7whMbGGQs
        Yx4cxqMMrKzqQJMw9EViQqTGhNphIqlSyX+Ge7O2sFK9Q8dhkPhDoV6WNVdYk07trOwV0Rns1KQ
        ==
X-Google-Smtp-Source: APXvYqxeN0s6w93VcbgVWqdz1GY/Q/5XEZH2Tndg7Cegy0M4z7ZBIbcqlruSk5667P5QXS5f1nrzURin5DDzGc5YJp4=
X-Received: by 2002:a63:1106:: with SMTP id g6mr13704486pgl.13.1576197809860;
 Thu, 12 Dec 2019 16:43:29 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:42:59 -0800
In-Reply-To: <20191213004312.169753-1-emilyshaffer@google.com>
Message-Id: <20191213004312.169753-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191213004312.169753-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v4 02/15] help: move list_config_help to builtin/help
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
 Makefile               | 16 ++++++--
 builtin/help.c         | 86 ++++++++++++++++++++++++++++++++++++++++++
 generate-cmdlist.sh    | 19 ----------
 generate-configlist.sh | 24 ++++++++++++
 help.c                 | 85 -----------------------------------------
 help.h                 |  1 -
 7 files changed, 123 insertions(+), 109 deletions(-)
 create mode 100755 generate-configlist.sh

diff --git a/.gitignore b/.gitignore
index 055a84c4a8..5dde2cc4c8 100644
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
index 9dff91436e..c49f55a521 100644
--- a/Makefile
+++ b/Makefile
@@ -815,6 +815,7 @@ LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 VCSSVN_LIB = vcs-svn/lib.a
 
+GENERATED_H += config-list.h
 GENERATED_H += command-list.h
 
 LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
@@ -2127,7 +2128,7 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 
 help.sp help.s help.o: command-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: command-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
@@ -2147,6 +2148,12 @@ $(BUILT_INS): git$X
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
@@ -2784,7 +2791,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-GEN_HDRS := command-list.h unicode-width.h
+GEN_HDRS := config-list.h command-list.h unicode-width.h
 EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
 ifndef GCRYPT_SHA256
 	EXCEPT_HDRS += sha256/gcrypt.h
@@ -2807,7 +2814,7 @@ hdr-check: $(HCO)
 style:
 	git clang-format --style file --diff --extensions c,h
 
-check: command-list.h
+check: config-list.h command-list.h
 	@if sparse; \
 	then \
 		echo >&2 "Use 'make sparse' instead"; \
@@ -3110,7 +3117,8 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) $(HCC)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
-	$(RM) *.pyc *.pyo */*.pyc */*.pyo command-list.h $(ETAGS_TARGET) tags cscope*
+	$(RM) *.pyc *.pyo */*.pyc */*.pyo config-list.h command-list.h
+	$(RM) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
 	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
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
index 0000000000..eca6a00c30
--- /dev/null
+++ b/generate-configlist.sh
@@ -0,0 +1,24 @@
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
+	while read line
+	do
+		echo "	\"$line\","
+	done
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
2.24.1.735.g03f4e72817-goog

