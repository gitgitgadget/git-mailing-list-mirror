Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D815C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05A22177B
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 00:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uZwqGo5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIIAuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 20:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgIIAtz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 20:49:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D90C061756
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 17:49:55 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w126so480951qka.5
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IOZol2PrmgK69ChF9uhS4Q6VJ8s6MAKp9sU06eeanSs=;
        b=uZwqGo5+JtuAxgRjXZId5opboSE7Z4bG5DxXDqDQc7vXaMozlOIkJUqqLKyVDZoXV4
         EOBRn0BubtXPnp9Sy2V5Ei10fCWJM8sCcc/rggIaAHGmaOTWjU7L45zxPnkBgp7pdxyS
         11LBzLt1wF0q+UzMJMuY+x8Iq1FG44Y8b09BzoaFwQUmGhh79576XCur0wwZEgQ4qOrT
         om+h1EYZ61NlFaEr3ulp/aoQ3qS74JC4q8ksxUMYtKv0JZC+qmpFLwpcChscE6QZ31wl
         SR/4unkNcW4lrkfRht7A728DyLRkZhWtsHIHOe2sVcz9i3+k5PqTzB7rE42sPKDQB4b+
         RSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IOZol2PrmgK69ChF9uhS4Q6VJ8s6MAKp9sU06eeanSs=;
        b=jc4FzQU9vbY4klOMxBUfhST/tTjV3otgO3BN4Ky+ToISTK+S8h/i9Koan2R9ZmM/97
         SFafyStjmuAtO84JJ5kVAY0i2XIg8dNUMgEwrUdBS7FJBRTXfGavsL9XmLYiyafDpN7g
         UQUsBQlTGaIvRdy3OTlFLr5zLiq0Lco4Ycmz4gwidkr163yo4DY/tlzAsWPBUFROMy4Y
         14GD4faGaVeoelqXsd2oqg6N4wHdEsOQuJsZNmRy2Cy/DzR5D5PRF50ieT9QCFX6iMMj
         bqAjwqtpL9xN3iFyCeg59eR42eZW3cKnyWdHV/5LL/lGSTcKc0y0TBXk8tJE9MuVqE32
         A/vw==
X-Gm-Message-State: AOAM533x3PXHsvDSvWVU8F5Kv9c7okFt0DhcJLzToiEu77MvWd0FsiF7
        K8XT3QCfOOZo0DiJGdywv2J0Z7AC+IUEdonaVGKUFhBEIaR9WRlf51i7w0PG8ZXeXvfp6JBiGEh
        ka0UwcnD/YpOPYgrmV22Hu7Gg+FcGMpGCIPC6QggRiyuL84UjSOfZPo+lRG8ucvOKL9IkFKP7qg
        ==
X-Google-Smtp-Source: ABdhPJzXhpFzdQSdmQpDNLU1oWWEhTSH7lYPhwopRkHDnAR2FHJJLBcDCerZ5yP26WWxhap9lLAbmF9SenJh9AFFuTY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:90c1:: with SMTP id
 p59mr138267qvp.7.1599612594132; Tue, 08 Sep 2020 17:49:54 -0700 (PDT)
Date:   Tue,  8 Sep 2020 17:49:33 -0700
In-Reply-To: <20200909004939.1942347-1-emilyshaffer@google.com>
Message-Id: <20200909004939.1942347-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20200909004939.1942347-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4 3/9] hook: add list command
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
 Documentation/git-hook.txt    |  37 +++++++++++-
 Makefile                      |   1 +
 builtin/hook.c                |  55 ++++++++++++++++--
 hook.c                        | 102 ++++++++++++++++++++++++++++++++++
 hook.h                        |  15 +++++
 t/t1360-config-based-hooks.sh |  68 ++++++++++++++++++++++-
 6 files changed, 271 insertions(+), 7 deletions(-)
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
index 6eee75555e..804de45b16 100644
--- a/Makefile
+++ b/Makefile
@@ -890,6 +890,7 @@ LIB_OBJS += grep.o
 LIB_OBJS += hashmap.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += interdiff.o
 LIB_OBJS += json-writer.o
diff --git a/builtin/hook.c b/builtin/hook.c
index b2bbc84d4d..a0759a4c26 100644
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
+	if (list_empty(head)) {
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
index 0000000000..b006950eb8
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,102 @@
+#include "cache.h"
+
+#include "hook.h"
+#include "config.h"
+
+/*
+ * NEEDSWORK: a stateful hook_head means we can't run two hook events in the
+ * background at the same time - which might be ok, or might not.
+ *
+ * Maybe it's better to cache a list head per hookname, since we can probably
+ * guess that the hook list won't change during a user-initiated operation. For
+ * now, within list_hooks, call clear_hook_list() at the outset.
+ */
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
+	/* even with use_shell, run_command() needs quotes */
+	strbuf_addf(&to_add->command, "'%s'", command);
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
+	/* hook_head is stateful */
+	clear_hook_list();
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
index 34b0df5216..46d1ed354a 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -4,8 +4,72 @@ test_description='config-managed multihooks, including git-hook command'
 
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
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-EOF &&
+	global:	$ROOT/path/def
+	local:	$ROOT/path/ghi
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
+	global:	$ROOT/path/def
+	local:	$ROOT/path/ghi
+	local:	$ROOT/path/abc
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
+	local:	$ROOT/path/ghi
+	local:	$ROOT/path/def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

