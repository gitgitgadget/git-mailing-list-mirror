Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A6AC433E1
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B668A208C9
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHINImwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgEUSyd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbgEUSya (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:54:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F08C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:54:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id d11so8049990qvv.10
        for <git@vger.kernel.org>; Thu, 21 May 2020 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0IfROp4fOd28BxrJ5FA/aqBfnpuKB/iqi/YkOVeGX4I=;
        b=cHINImwTY7Lv5bXl0KPKUVb5MAc5N6TO0kCIIxlZ13MBRBe5NXHNPEPZ94WiUE7nvD
         7A6WVJUWgTJbpzf/mKHjTH4HFZdicPo1wzBstfeCxlzYhRHm+bwB45HJGWvf6zZ2f16b
         DdiPwWAlQNvrpWTP0B8DQ7bFnMbPYCvVU889NiTrFf5JHJ2KJMjU2+zmv0HapiUjkjQA
         MFs1TQHZ3Gi9k9VCyRiiAL1Nh2LDCvZqkBSNPfRVTIU2SBKgxrT3ZZnKKuQBt7f5qEex
         d8AOeg41+Icgr8dxIsNaiFHANGiQ5ukO2bPKH+WFB09+TjVUSkgIJfUxaEfUsg8V81/1
         ZMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0IfROp4fOd28BxrJ5FA/aqBfnpuKB/iqi/YkOVeGX4I=;
        b=Hn8DQgvY0Xir/ZxFG8haIOipHPRRrLqJ5qqD1OU1PyTo547KHTkPuADI71muieR6cJ
         2EVBB1QSg7vZirOE2/7YVrE9HA26YJyWzdz4Pe7iRooLL6QGXAsPaFfN0n9+Z1Mg1ITj
         t6+DRHx1oA8YZrmX4ii9DNqJWl3lKLJnZqXjWux+9yjCmfJLJGFJZtulzv9UY+Il5FjW
         OVWSePnoBWMfXkOl78bWJn9F/cWVYmH/oDcHOE77Jrokk8UrrTijzE4VjVj2WRAFmWCU
         Dm1IPGdNAZtyRg2M6Tc+uJXyvkiyExQCaOBFth5o7Zt95Ns6iFT5zYLKe0/BE9YmW583
         ykdw==
X-Gm-Message-State: AOAM532vFC7iSkhlyDkO5K0GtmHw7iByqXpD3bDMA2xwDBHq6I05ndj+
        4mrvMD5g5MYE1uPdxiHoPARhUoF2tp0a98JQ6f4u5ceLQ066u3JspVFha6sFigalSq96BFFNVda
        1ReSuWwcjm2hqmrPS/21PyBICMQY+8hBQlr+ESFfdU+dBmcuQUOQBcSQBzteroct27o0pMnGndg
        ==
X-Google-Smtp-Source: ABdhPJyOeyPqb8piRWBOZCCWPQxuBSXK2P7McS2FYM3eM2Ydti723udXiBc7xEKT3X1Kc7ekZAM70COghj+BLHwTu8k=
X-Received: by 2002:a05:6214:5b1:: with SMTP id by17mr136944qvb.37.1590087269142;
 Thu, 21 May 2020 11:54:29 -0700 (PDT)
Date:   Thu, 21 May 2020 11:54:13 -0700
In-Reply-To: <20200521185414.43760-1-emilyshaffer@google.com>
Message-Id: <20200521185414.43760-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200521185414.43760-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 3/4] hook: add list command
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git hook list <hookname>', which checks the known configs in
order to create an ordered list of hooks to run on a given hook event.

Multiple commands can be specified for a given hook by providing
multiple "hook.<hookname>.command = <path-to-hook>" lines. Hooks will be
run in config order. If more properties need to be set on a given hook
in the future, commands can also be specified by providing
"hook.<hookname>.command = <hookcmd-name>", as well as a "[hookcmd
<hookcmd-name>]" subsection; at minimum, this subsection must contain a
"hookcmd.<hookcmd-name>.command = <path-to-hook>" line.

For example:

  $ git config --list | grep ^hook
  hook.pre-commit.command=baz
  hook.pre-commit.command=~/bar.sh
  hookcmd.baz.command=~/baz/from/hookcmd.sh

  $ git hook list pre-commit
  ~/baz/from/hookcmd.sh
  ~/bar.sh

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    | 37 +++++++++++++-
 Makefile                      |  1 +
 builtin/hook.c                | 55 +++++++++++++++++++--
 hook.c                        | 90 +++++++++++++++++++++++++++++++++++
 hook.h                        | 15 ++++++
 t/t1360-config-based-hooks.sh | 51 +++++++++++++++++++-
 6 files changed, 242 insertions(+), 7 deletions(-)
 create mode 100644 hook.c
 create mode 100644 hook.h

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 2d50c414cc..e458586e96 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,12 +8,47 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook'
+'git hook' list <hook-name>
 
 DESCRIPTION
 -----------
 You can list, add, and modify hooks with this command.
 
+This command parses the default configuration files for sections "hook" and
+"hookcmd". "hook" is used to describe the commands which will be run during a
+particular hook event; commands are run in config order. "hookcmd" is used to
+describe attributes of a specific command. If additional attributes don't need
+to be specified, a command to run can be specified directly in the "hook"
+section; if a "hookcmd" by that name isn't found, Git will attempt to run the
+provided value directly. For example:
+
+Global config
+----
+  [hook "post-commit"]
+    command = "linter"
+    command = "~/typocheck.sh"
+
+  [hookcmd "linter"]
+    command = "/bin/linter --c"
+----
+
+Local config
+----
+  [hook "prepare-commit-msg"]
+    command = "linter"
+  [hook "post-commit"]
+    command = "python ~/run-test-suite.py"
+----
+
+COMMANDS
+--------
+
+list <hook-name>::
+
+List the hooks which have been configured for <hook-name>. Hooks appear
+in the order they should be run, and note the config scope where the relevant
+`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index fce6ee154e..b7bbf3be7b 100644
--- a/Makefile
+++ b/Makefile
@@ -894,6 +894,7 @@ LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += interdiff.o
 LIB_OBJS += json-writer.o
diff --git a/builtin/hook.c b/builtin/hook.c
index b2bbc84d4d..cfd8e388bd 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,21 +1,68 @@
 #include "cache.h"
 
 #include "builtin.h"
+#include "config.h"
+#include "hook.h"
 #include "parse-options.h"
+#include "strbuf.h"
 
 static const char * const builtin_hook_usage[] = {
-	N_("git hook"),
+	N_("git hook list <hookname>"),
 	NULL
 };
 
-int cmd_hook(int argc, const char **argv, const char *prefix)
+static int list(int argc, const char **argv, const char *prefix)
 {
-	struct option builtin_hook_options[] = {
+	struct list_head *head, *pos;
+	struct hook *item;
+	struct strbuf hookname = STRBUF_INIT;
+
+	struct option list_options[] = {
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, builtin_hook_options,
+	argc = parse_options(argc, argv, prefix, list_options,
 			     builtin_hook_usage, 0);
 
+	if (argc < 1) {
+		usage_msg_opt("a hookname must be provided to operate on.",
+			      builtin_hook_usage, list_options);
+	}
+
+	strbuf_addstr(&hookname, argv[0]);
+
+	head = hook_list(&hookname);
+
+	if (!head) {
+		printf(_("no commands configured for hook '%s'\n"),
+		       hookname.buf);
+		return 0;
+	}
+
+	list_for_each(pos, head) {
+		item = list_entry(pos, struct hook, list);
+		if (item)
+			printf("%s:\t%s\n",
+			       config_scope_name(item->origin),
+			       item->command.buf);
+	}
+
+	clear_hook_list();
+	strbuf_release(&hookname);
+
 	return 0;
 }
+
+int cmd_hook(int argc, const char **argv, const char *prefix)
+{
+	struct option builtin_hook_options[] = {
+		OPT_END(),
+	};
+	if (argc < 2)
+		usage_with_options(builtin_hook_usage, builtin_hook_options);
+
+	if (!strcmp(argv[1], "list"))
+		return list(argc - 1, argv + 1, prefix);
+
+	usage_with_options(builtin_hook_usage, builtin_hook_options);
+}
diff --git a/hook.c b/hook.c
new file mode 100644
index 0000000000..9dfc1a885e
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,90 @@
+#include "cache.h"
+
+#include "hook.h"
+#include "config.h"
+
+static LIST_HEAD(hook_head);
+
+void free_hook(struct hook *ptr)
+{
+	if (ptr) {
+		strbuf_release(&ptr->command);
+		free(ptr);
+	}
+}
+
+static void emplace_hook(struct list_head *pos, const char *command)
+{
+	struct hook *to_add = malloc(sizeof(struct hook));
+	to_add->origin = current_config_scope();
+	strbuf_init(&to_add->command, 0);
+	strbuf_addstr(&to_add->command, command);
+
+	list_add_tail(&to_add->list, pos);
+}
+
+static void remove_hook(struct list_head *to_remove)
+{
+	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
+	list_del(to_remove);
+	free_hook(hook_to_remove);
+}
+
+void clear_hook_list(void)
+{
+	struct list_head *pos, *tmp;
+	list_for_each_safe(pos, tmp, &hook_head)
+		remove_hook(pos);
+}
+
+static int hook_config_lookup(const char *key, const char *value, void *hook_key_cb)
+{
+	const char *hook_key = hook_key_cb;
+
+	if (!strcmp(key, hook_key)) {
+		const char *command = value;
+		struct strbuf hookcmd_name = STRBUF_INIT;
+		struct list_head *pos = NULL, *tmp = NULL;
+
+		/* Check if a hookcmd with that name exists. */
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
+		git_config_get_value(hookcmd_name.buf, &command);
+
+		if (!command)
+			BUG("git_config_get_value overwrote a string it shouldn't have");
+
+		/*
+		 * TODO: implement an option-getting callback, e.g.
+		 *   get configs by pattern hookcmd.$value.*
+		 *   for each key+value, do_callback(key, value, cb_data)
+		 */
+
+		list_for_each_safe(pos, tmp, &hook_head) {
+			struct hook *hook = list_entry(pos, struct hook, list);
+			/*
+			 * The list of hooks to run can be reordered by being redeclared
+			 * in the config. Options about hook ordering should be checked
+			 * here.
+			 */
+			if (0 == strcmp(hook->command.buf, command))
+				remove_hook(pos);
+		}
+		emplace_hook(pos, command);
+	}
+
+	return 0;
+}
+
+struct list_head* hook_list(const struct strbuf* hookname)
+{
+	struct strbuf hook_key = STRBUF_INIT;
+
+	if (!hookname)
+		return NULL;
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
+
+	git_config(hook_config_lookup, (void*)hook_key.buf);
+
+	return &hook_head;
+}
diff --git a/hook.h b/hook.h
new file mode 100644
index 0000000000..aaf6511cff
--- /dev/null
+++ b/hook.h
@@ -0,0 +1,15 @@
+#include "config.h"
+#include "list.h"
+#include "strbuf.h"
+
+struct hook
+{
+	struct list_head list;
+	enum config_scope origin;
+	struct strbuf command;
+};
+
+struct list_head* hook_list(const struct strbuf *hookname);
+
+void free_hook(struct hook *ptr);
+void clear_hook_list(void);
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 34b0df5216..4e46d7dd4e 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -4,8 +4,55 @@ test_description='config-managed multihooks, including git-hook command'
 
 . ./test-lib.sh
 
-test_expect_success 'git hook command does not crash' '
-	git hook
+test_expect_success 'git hook rejects commands without a mode' '
+	test_must_fail git hook pre-commit
+'
+
+
+test_expect_success 'git hook rejects commands without a hookname' '
+	test_must_fail git hook list
+'
+
+test_expect_success 'setup hooks in global, and local' '
+	git config --add --local hook.pre-commit.command "/path/ghi" &&
+	git config --add --global hook.pre-commit.command "/path/def"
+'
+
+test_expect_success 'git hook list orders by config order' '
+	cat >expected <<-\EOF &&
+	global:	/path/def
+	local:	/path/ghi
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list dereferences a hookcmd' '
+	git config --add --local hook.pre-commit.command "abc" &&
+	git config --add --global hookcmd.abc.command "/path/abc" &&
+
+	cat >expected <<-\EOF &&
+	global:	/path/def
+	local:	/path/ghi
+	local:	/path/abc
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list reorders on duplicate commands' '
+	git config --add --local hook.pre-commit.command "/path/def" &&
+
+	cat >expected <<-\EOF &&
+	local:	/path/ghi
+	local:	/path/abc
+	local:	/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.27.0.rc0.183.gde8f92d652-goog

