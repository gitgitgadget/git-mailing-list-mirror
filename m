Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DC2C2BB86
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 00:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 599B120732
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 00:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mryp462I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390678AbgDNAzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 20:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgDNAzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 20:55:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B264C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 17:55:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o132so6175167ybc.14
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 17:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z8Bv8uQEGi+iHWDFarm7CqCL3hnFrsH8hmYJ5f1Onak=;
        b=mryp462IgM62Oq2DVZUsSlv8PLHQWnkCLVdLH8becdq5ZeexVk3THhf4rE2cSoGgAt
         ybgu5/WPBPHnx5B5JSzrvBkM7ul1rAijHii3CnPtbTVTsmG3KusuUk77r+jnTQjq4/yE
         Cr0lARmAiW6UsKVB79u6WSeDMFQoi9kIHBXY2G/JZCkG1d6ry4E+RiP5hQbUXigLIBvd
         GQcoswtdgzqqMipCExT/MQoyeNfGwtPx6Hay9YkWMKntvYpBIAwV6audLpQY/ZKWKLZy
         Z7//JChr8UrR6YZOYNLnHaOX3w+ra/QsJv7BN54g4Q4lQ7ucnOLRhhaq56gqM4TGzsBG
         eSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z8Bv8uQEGi+iHWDFarm7CqCL3hnFrsH8hmYJ5f1Onak=;
        b=H3Y/ktDdkSA6sQEX1Y152yfWvPqtz+I1NDnFS2H0qOWogVtmkqB/27ibOaarMPjtts
         WJlg5en19+f38IZdSqoL5Vt+hO8ddCHXgAPoEhV/Tj0irT8219xGp8QOc1FSws6qkeyF
         i1HmzRQJr4RIY7lH19zwNAKqOEDEKHjwt+Va96HysV7NI75WltvmAk6BKFdtWR8Wh5L3
         mlJaqVoTK1O2Mo42mtOAV57nR8bXp3oyTQ09AGpExBLTxcDCXRuTbb3/YXp9ph0c6TPv
         yKQTyjpaTp3XM3Tm3Wql8r5+Ztc5YoSDbXAMgzHGVxKuWYyqDSBVukCW1ziwIUnoMD5/
         8LEQ==
X-Gm-Message-State: AGi0PubBdBmF825OrzPQnzQqm0CgexoGXzu/QZf+VOzYhR0p66m/bJwE
        JvAJAa1w7a/yLx1W2NNTsh2bO+YclkMPMYTEExPoaKVhZWPO3XpIexkpCEYlzvoi9cmdC53rsom
        2fnc1+H9dD4PsQe1YZ7y4EUZmVLuaOgITiU7wur3Hsy5xeHc5z9EDjQAolKX40QMW+dL+az3TzA
        ==
X-Google-Smtp-Source: APiQypLotT+DDoFZiuC4AN5hUwjy0DVr6S282OA9blbGbWQp/EfuHAvMxW4Z91v/oPgnsTpP0F0v5j0iVUXWn4BAFh8=
X-Received: by 2002:a25:487:: with SMTP id 129mr31942768ybe.439.1586825709380;
 Mon, 13 Apr 2020 17:55:09 -0700 (PDT)
Date:   Mon, 13 Apr 2020 17:54:57 -0700
In-Reply-To: <20200414005457.3505-1-emilyshaffer@google.com>
Message-Id: <20200414005457.3505-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com> <20200414005457.3505-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [RFC PATCH v2 2/2] hook: add --list mode
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach 'git hook --list <hookname>', which checks the known configs in
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

  $ git hook --list pre-commit
  ~/baz/from/hookcmd.sh
  ~/bar.sh

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    | 36 +++++++++++++-
 Makefile                      |  1 +
 builtin/hook.c                | 58 +++++++++++++++++++++-
 hook.c                        | 92 +++++++++++++++++++++++++++++++++++
 hook.h                        | 15 ++++++
 t/t1360-config-based-hooks.sh | 51 ++++++++++++++++++-
 6 files changed, 249 insertions(+), 4 deletions(-)
 create mode 100644 hook.c
 create mode 100644 hook.h

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 2d50c414cc..aafc762ea2 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,12 +8,46 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook'
+'git hook' -l | --list <hook-name>
 
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
+OPTIONS
+-------
+
+-l::
+--list::
+	List the hooks which have been configured for <hook-name>. Hooks appear
+	in the order they should be run.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 7b9670c205..5f170f885b 100644
--- a/Makefile
+++ b/Makefile
@@ -896,6 +896,7 @@ LIB_OBJS += hashmap.o
 LIB_OBJS += linear-assignment.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += interdiff.o
 LIB_OBJS += json-writer.o
diff --git a/builtin/hook.c b/builtin/hook.c
index b2bbc84d4d..60617578fb 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,21 +1,77 @@
 #include "cache.h"
 
 #include "builtin.h"
+#include "config.h"
+#include "hook.h"
 #include "parse-options.h"
+#include "strbuf.h"
 
 static const char * const builtin_hook_usage[] = {
-	N_("git hook"),
+	N_("git hook --list <hookname>"),
 	NULL
 };
 
+enum hook_command {
+	HOOK_NO_COMMAND = 0,
+	HOOK_LIST,
+};
+
+static int print_hook_list(const struct strbuf *hookname)
+{
+	struct list_head *head, *pos;
+	struct hook *item;
+
+	head = hook_list(hookname);
+
+	if (!head) {
+		printf(_("no commands configured for hook '%s'\n"),
+		       hookname->buf);
+		return 0;
+	}
+
+	list_for_each(pos, head) {
+		item = list_entry(pos, struct hook, list);
+		if (item)
+			printf("%s\n",
+			       item->command.buf);
+	}
+
+	return 0;
+}
+
 int cmd_hook(int argc, const char **argv, const char *prefix)
 {
+	enum hook_command command = 0;
+	struct strbuf hookname = STRBUF_INIT;
+
 	struct option builtin_hook_options[] = {
+		OPT_CMDMODE('l', "list", &command,
+			    N_("list scripts which will be run for <hookname>"),
+			    HOOK_LIST),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, builtin_hook_options,
 			     builtin_hook_usage, 0);
 
+	if (argc < 1) {
+		usage_msg_opt("a hookname must be provided to operate on.",
+			      builtin_hook_usage, builtin_hook_options);
+	}
+
+	strbuf_addstr(&hookname, argv[0]);
+
+	switch(command) {
+		case HOOK_LIST:
+			return print_hook_list(&hookname);
+			break;
+		default:
+			usage_msg_opt("no command given.", builtin_hook_usage,
+				      builtin_hook_options);
+	}
+
+	clear_hook_list();
+	strbuf_release(&hookname);
+
 	return 0;
 }
diff --git a/hook.c b/hook.c
new file mode 100644
index 0000000000..a31943a25e
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,92 @@
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
+struct list_head* hook_list(const struct strbuf* hookname)
+{
+	struct strbuf hook_key = STRBUF_INIT;
+	const struct string_list *commands = NULL;
+	struct string_list_item *it = NULL;
+	struct list_head *pos = NULL, *tmp = NULL;
+	struct strbuf hookcmd_name = STRBUF_INIT;
+	struct hook *hook = NULL;
+
+	if (!hookname)
+		return NULL;
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
+
+	commands = git_config_get_value_multi(hook_key.buf);
+
+	if (!commands)
+		return NULL;
+
+	for_each_string_list_item(it, commands) {
+		const char *command = it->string;
+
+		strbuf_reset(&hookcmd_name);
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
+
+		/* If no hookcmd with that name exists, &command is untouched */
+		git_config_get_value(hookcmd_name.buf, &command);
+
+		if (!command)
+			return NULL;
+
+		/*
+		 * TODO: implement an option-getting callback, e.g.
+		 *   get configs by pattern hookcmd.$value.*
+		 *   for each key+value, do_callback(key, value, cb_data)
+		 */
+
+		list_for_each_safe(pos, tmp, &hook_head) {
+			hook = list_entry(pos, struct hook, list);
+			/*
+			 * The list of hooks to run can be reordered by being redeclared
+			 * in the config. Options about hook ordering should be checked
+			 * here.
+			 */
+			if (0 == strcmp(hook->command.buf, command))
+				remove_hook(pos);
+		}
+		emplace_hook(pos, command);
+
+	}
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
index 34b0df5216..2e6a5e09d3 100755
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
+	test_must_fail git hook --list
+'
+
+test_expect_success 'setup hooks in global, and local' '
+	git config --add --local hook.pre-commit.command "/path/ghi" &&
+	git config --add --global hook.pre-commit.command "/path/def"
+'
+
+test_expect_success 'git hook --list orders by config order' '
+	cat >expected <<-\EOF &&
+	/path/def
+	/path/ghi
+	EOF
+
+	git hook --list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook --list dereferences a hookcmd' '
+	git config --add --local hook.pre-commit.command "abc" &&
+	git config --add --global hookcmd.abc.command "/path/abc" &&
+
+	cat >expected <<-\EOF &&
+	/path/def
+	/path/ghi
+	/path/abc
+	EOF
+
+	git hook --list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook --list reorders on duplicate commands' '
+	git config --add --local hook.pre-commit.command "/path/def" &&
+
+	cat >expected <<-\EOF &&
+	/path/ghi
+	/path/abc
+	/path/def
+	EOF
+
+	git hook --list pre-commit >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.26.0.110.g2183baf09c-goog

