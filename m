Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ADFC433DB
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F2922525
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgLVADL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLVADK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:03:10 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8584EC061282
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:30 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 26so7473085pgl.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=E63ELr0gZbKJ9atizmHStTPOQsdrLPSX1yQ9VPIzHGQ=;
        b=gVAbPADcJ7eA4JeRLeR5u5/rcPJ7b0Mr2yWk+2dca3eCEKWztL0uovz3dU/xXJv9Ay
         iTJ4UqSz2OcOrPCL/0xa9mIGvPv/rZFS9Mjjm8Bm0cckEwfbs31mvnm7FEuFxtAYCPKq
         YCaFU/WL+aBAXrwmQp6aymmCLkhsH3maN/rnlMy2TpPNeu8AJqKwlyRu1O/QMa9iBp8c
         Oz+07zNoUQXwLtz6M69Dqgrw02LNj9mr+ptFgcsCa1SeekK2NC4qOt0BMia96rs8ydc7
         0afKe8fqOZbSC5f7czOGXw5E7u0mNOcoJ6ONyuXY/k6n803EP3r1oBjAZT/07NKOPfrY
         I3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E63ELr0gZbKJ9atizmHStTPOQsdrLPSX1yQ9VPIzHGQ=;
        b=d5UBAnIbH1oa2AmUrgO5Z8kzFKtJzBmJeT99rEozHMMfO7ZW0BDDmWR8BbX0cpVH0S
         Pax7sWL9ba2LeYLCStARaV9+PZj5lLkiegnV7/BIr/aIgWPmuEct9Qu7MkO4FaJUAw4J
         ua7qmRMXAT55jqx37n3ih66P9KikYmvwAOaGDimoEnZzHwAw19R6JJ4BjKSh4E0WCN83
         1IiLHAtPC+XD3UivEw8o0dWLRrqdIXnA1bMtUAkoP2AVaPGSlVeXrEK7M/zkM9HCxw53
         5p/atqtsFFTIBOLa1uezV0I06D3JfXQLbuMsCIDXPHLOj+j/dwUX/nEASnCvOpNQ8keB
         jMJQ==
X-Gm-Message-State: AOAM531DbY39g/JLDCH6a2FSadNI9scYwpVOpZcU62GyAvbgFuOk2SFc
        CkpnGenEHWGSroMgZLjjEMY2HZRe+HZviZ2g9PUKrxZo6YQlqgSBslIaOnoBqNSoazq+hYd4Pb0
        2EMiPzSG6UEkdB0S1J73JSCUvfjILLwS/Rr+jYbdBzL06N/ZAdCFQULM4ZpyngOz/ZKi3ut7AwQ
        ==
X-Google-Smtp-Source: ABdhPJw8oPKeGANVMDAhPmRnDIjd0DOXI8J4wck9+h5u4IBiyzdXbIZYIMYcEZ/OzcEQdikl12JszuEbXH1tIcOLEio=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a17:902:ba84:b029:dc:f27:dd4e with
 SMTP id k4-20020a170902ba84b02900dc0f27dd4emr18226280pls.61.1608595349973;
 Mon, 21 Dec 2020 16:02:29 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:02:06 -0800
In-Reply-To: <20201222000220.1491091-1-emilyshaffer@google.com>
Message-Id: <20201222000220.1491091-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000220.1491091-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v7 03/17] hook: add list command
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
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
  global: ~/baz/from/hookcmd.sh
  local: ~/bar.sh

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Since v4, updated the sample in the commit message to reflect reality better.
    
    Since v4, more work on the documentation. Also a slight change to the
    output format (space instead of tab).

 Documentation/config/hook.txt |   9 +++
 Documentation/git-hook.txt    |  59 ++++++++++++++++-
 Makefile                      |   1 +
 builtin/hook.c                |  56 +++++++++++++++--
 hook.c                        | 115 ++++++++++++++++++++++++++++++++++
 hook.h                        |  26 ++++++++
 t/t1360-config-based-hooks.sh |  81 +++++++++++++++++++++++-
 7 files changed, 338 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/config/hook.txt
 create mode 100644 hook.c
 create mode 100644 hook.h

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
new file mode 100644
index 0000000000..71449ecbc7
--- /dev/null
+++ b/Documentation/config/hook.txt
@@ -0,0 +1,9 @@
+hook.<command>.command::
+	A command to execute during the <command> hook event. This can be an
+	executable on your device, a oneliner for your shell, or the name of a
+	hookcmd. See linkgit:git-hook[1].
+
+hookcmd.<name>.command::
+	A command to execute during a hook for which <name> has been specified
+	as a command. This can be an executable on your device or a oneliner for
+	your shell. See linkgit:git-hook[1].
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 9eeab0009d..f19875ed68 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,12 +8,65 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook'
+'git hook' list <hook-name>
 
 DESCRIPTION
 -----------
-A placeholder command. Later, you will be able to list, add, and modify hooks
-with this command.
+You can list configured hooks with this command. Later, you will be able to run,
+add, and modify hooks with this command.
+
+This command parses the default configuration files for sections `hook` and
+`hookcmd`. `hook` is used to describe the commands which will be run during a
+particular hook event; commands are run in the order Git encounters them during
+the configuration parse (see linkgit:git-config[1]). `hookcmd` is used to
+describe attributes of a specific command. If additional attributes don't need
+to be specified, a command to run can be specified directly in the `hook`
+section; if a `hookcmd` by that name isn't found, Git will attempt to run the
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
+With these configs, you'd then see:
+
+----
+$ git hook list "post-commit"
+global: /bin/linter --c
+global: ~/typocheck.sh
+local: python ~/run-test-suite.py
+
+$ git hook list "prepare-commit-msg"
+local: /bin/linter --c
+----
+
+COMMANDS
+--------
+
+list `<hook-name>`::
+
+List the hooks which have been configured for `<hook-name>`. Hooks appear
+in the order they should be run, and print the config scope where the relevant
+`hook.<hook-name>.command` was specified, not the `hookcmd` (if applicable).
+This output is human-readable and the format is subject to change over time.
+
+CONFIGURATION
+-------------
+include::config/hook.txt[]
 
 GIT
 ---
diff --git a/Makefile b/Makefile
index 24cee44400..d9f43dc8fe 100644
--- a/Makefile
+++ b/Makefile
@@ -904,6 +904,7 @@ LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += json-writer.o
 LIB_OBJS += kwset.o
diff --git a/builtin/hook.c b/builtin/hook.c
index b2bbc84d4d..4d36de52f8 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,21 +1,69 @@
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
+		usage_msg_opt(_("You must specify a hook event name to list."),
+			      builtin_hook_usage, list_options);
+	}
+
+	strbuf_addstr(&hookname, argv[0]);
+
+	head = hook_list(&hookname);
+
+	if (list_empty(head)) {
+		printf(_("no commands configured for hook '%s'\n"),
+		       hookname.buf);
+		strbuf_release(&hookname);
+		return 0;
+	}
+
+	list_for_each(pos, head) {
+		item = list_entry(pos, struct hook, list);
+		if (item)
+			printf("%s: %s\n",
+			       config_scope_name(item->origin),
+			       item->command.buf);
+	}
+
+	clear_hook_list(head);
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
index 0000000000..937dc768c8
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,115 @@
+#include "cache.h"
+
+#include "hook.h"
+#include "config.h"
+
+void free_hook(struct hook *ptr)
+{
+	if (ptr) {
+		strbuf_release(&ptr->command);
+		free(ptr);
+	}
+}
+
+static void append_or_move_hook(struct list_head *head, const char *command)
+{
+	struct list_head *pos = NULL, *tmp = NULL;
+	struct hook *to_add = NULL;
+
+	/*
+	 * remove the prior entry with this command; we'll replace it at the
+	 * end.
+	 */
+	list_for_each_safe(pos, tmp, head) {
+		struct hook *it = list_entry(pos, struct hook, list);
+		if (!strcmp(it->command.buf, command)) {
+		    list_del(pos);
+		    /* we'll simply move the hook to the end */
+		    to_add = it;
+		}
+	}
+
+	if (!to_add) {
+		/* adding a new hook, not moving an old one */
+		to_add = xmalloc(sizeof(struct hook));
+		strbuf_init(&to_add->command, 0);
+		strbuf_addstr(&to_add->command, command);
+	}
+
+	/* re-set the scope so we show where an override was specified */
+	to_add->origin = current_config_scope();
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
+void clear_hook_list(struct list_head *head)
+{
+	struct list_head *pos, *tmp;
+	list_for_each_safe(pos, tmp, head)
+		remove_hook(pos);
+}
+
+struct hook_config_cb
+{
+	struct strbuf *hookname;
+	struct list_head *list;
+};
+
+static int hook_config_lookup(const char *key, const char *value, void *cb_data)
+{
+	struct hook_config_cb *data = cb_data;
+	const char *hook_key = data->hookname->buf;
+	struct list_head *head = data->list;
+
+	if (!strcmp(key, hook_key)) {
+		const char *command = value;
+		struct strbuf hookcmd_name = STRBUF_INIT;
+
+		/* Check if a hookcmd with that name exists. */
+		strbuf_addf(&hookcmd_name, "hookcmd.%s.command", command);
+		git_config_get_value(hookcmd_name.buf, &command);
+
+		if (!command) {
+			strbuf_release(&hookcmd_name);
+			BUG("git_config_get_value overwrote a string it shouldn't have");
+		}
+
+		/*
+		 * TODO: implement an option-getting callback, e.g.
+		 *   get configs by pattern hookcmd.$value.*
+		 *   for each key+value, do_callback(key, value, cb_data)
+		 */
+
+		append_or_move_hook(head, command);
+
+		strbuf_release(&hookcmd_name);
+	}
+
+	return 0;
+}
+
+struct list_head* hook_list(const struct strbuf* hookname)
+{
+	struct strbuf hook_key = STRBUF_INIT;
+	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+	struct hook_config_cb cb_data = { &hook_key, hook_head };
+
+	INIT_LIST_HEAD(hook_head);
+
+	if (!hookname)
+		return NULL;
+
+	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
+
+	git_config(hook_config_lookup, (void*)&cb_data);
+
+	strbuf_release(&hook_key);
+	return hook_head;
+}
diff --git a/hook.h b/hook.h
new file mode 100644
index 0000000000..8ffc4f14b6
--- /dev/null
+++ b/hook.h
@@ -0,0 +1,26 @@
+#include "config.h"
+#include "list.h"
+#include "strbuf.h"
+
+struct hook
+{
+	struct list_head list;
+	/*
+	 * Config file which holds the hook.*.command definition.
+	 * (This has nothing to do with the hookcmd.<name>.* configs.)
+	 */
+	enum config_scope origin;
+	/* The literal command to run. */
+	struct strbuf command;
+};
+
+/*
+ * Provides a linked list of 'struct hook' detailing commands which should run
+ * in response to the 'hookname' event, in execution order.
+ */
+struct list_head* hook_list(const struct strbuf *hookname);
+
+/* Free memory associated with a 'struct hook' */
+void free_hook(struct hook *ptr);
+/* Empties the list at 'head', calling 'free_hook()' on each entry */
+void clear_hook_list(struct list_head *head);
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 34b0df5216..6e4a3e763f 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -4,8 +4,85 @@ test_description='config-managed multihooks, including git-hook command'
 
 . ./test-lib.sh
 
-test_expect_success 'git hook command does not crash' '
-	git hook
+ROOT=
+if test_have_prereq MINGW
+then
+	# In Git for Windows, Unix-like paths work only in shell scripts;
+	# `git.exe`, however, will prefix them with the pseudo root directory
+	# (of the Unix shell). Let's accommodate for that.
+	ROOT="$(cd / && pwd)"
+fi
+
+setup_hooks () {
+	test_config hook.pre-commit.command "/path/ghi" --add
+	test_config_global hook.pre-commit.command "/path/def" --add
+}
+
+setup_hookcmd () {
+	test_config hook.pre-commit.command "abc" --add
+	test_config_global hookcmd.abc.command "/path/abc" --add
+}
+
+test_expect_success 'git hook rejects commands without a mode' '
+	test_must_fail git hook pre-commit
+'
+
+
+test_expect_success 'git hook rejects commands without a hookname' '
+	test_must_fail git hook list
+'
+
+test_expect_success 'git hook runs outside of a repo' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	EOF
+
+	nongit git config --list --global &&
+
+	nongit git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	local: $ROOT/path/ghi
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list dereferences a hookcmd' '
+	setup_hooks &&
+	setup_hookcmd &&
+
+	cat >expected <<-EOF &&
+	global: $ROOT/path/def
+	local: $ROOT/path/ghi
+	local: $ROOT/path/abc
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list reorders on duplicate commands' '
+	setup_hooks &&
+
+	test_config hook.pre-commit.command "/path/def" --add &&
+
+	cat >expected <<-EOF &&
+	local: $ROOT/path/ghi
+	local: $ROOT/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

