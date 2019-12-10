Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B7AC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BC020726
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 02:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a4gNJTKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfLJCd7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:33:59 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40744 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfLJCd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 21:33:58 -0500
Received: by mail-pf1-f202.google.com with SMTP id d127so10479231pfa.7
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 18:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ggZF69UtlBPHcYM+6WWl8faTyBeVGaBUKV8FevVyN8w=;
        b=a4gNJTKC3LvZpXtDpvE2mJ8EnYWm83+cPq/vuBz1ZD2aIAxOZohFTLDjmycU0h/6jl
         VZSc+aGeIUq6yWOFbrOHnDWB884U3oT9K7B62josFfHV7Rqt/lqbujdDDjQB7+y0pur0
         QQrZ/TZBs4CE6GVyrPafOBQlYvdxvaRVkSCLf+S4pJuPW2qZZWEuDxTTZ/gF3ZcbrKS2
         sptLajOk+MY7mAK9CIS3C+L5kUSU/Cqg88dUoZKcgTnsi9L/ekzLxOO4lXdUoWt+pxZQ
         v/v6yKv8jO04hINE8jspOFJg4FYvH7tPDNPTSUnl+48Rrsz2thMuGjCAZHcMK9MaClZt
         mjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ggZF69UtlBPHcYM+6WWl8faTyBeVGaBUKV8FevVyN8w=;
        b=ZU5sSycGUI+1j1VlQLzhm9L8ns0A6gIojgdFKIExgBwpCtfAAecgkOOQrZeCYsDMRu
         EXGEdEqI2y2hfolk9Xk+5O6P8LzvsxZ8E9Y1jlwLWZ64/n87u2syT58d/+8jfP/KyfEK
         wH5vrJsI6KvTiD8vRabbCm8ESxYc+S8+lal5L366URUY8l7B+diCCIRpRYz9EfWdxeSQ
         WBa5IobscxLL99FEMPmKlzXNGFkahgbhBdoIxHLkApAyZRrFAeCN1ke0rMl1IpTMQcV8
         z1lfZLl0xRtIoyoaFZpDfiSJkCArfkqnJkCX+Jt3A/xKc+I1tkjNIZvejFWFLagA4L/v
         zN2w==
X-Gm-Message-State: APjAAAWHE6onsAw6vuYeWOj2vyamrxHj6kySQzwr4qwDYqvVx+LzffwF
        LQ58rGpqkkEAA59/c+P2zuqUUSqhdgwZaprfGQhVI3kIWShg58V2Fu0wtsBh91XHvT5FBfzvh8B
        tEqvkhYRle0UQ8wNOaedD6af6uIO9U7hzvMEnKgKykRnw1HlrNPG1Xgwl/0G4oCWWlScMU8aobg
        ==
X-Google-Smtp-Source: APXvYqzaZ7fFR6mo4rs0BvlePBRpw7NIVLDHp/i0qiAwCXlNWJrZgwQd36w5i3WrEOqjzKjoHD2JqmN1SpsnhWn2x60=
X-Received: by 2002:a63:b26:: with SMTP id 38mr21914487pgl.116.1575945237982;
 Mon, 09 Dec 2019 18:33:57 -0800 (PST)
Date:   Mon,  9 Dec 2019 18:33:32 -0800
In-Reply-To: <20191210023335.49987-1-emilyshaffer@google.com>
Message-Id: <20191210023335.49987-4-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20191210023335.49987-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH 3/6] hook: add --list mode
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

The hook config format is "hook.<hookname> = <order>:<path-to-hook>".
This paves the way for multiple hook support; hooks should be run in the
order specified by the user in the config, and in the case of an order
number collision, configuration order should be used (e.g. global hook
004 will run before repo hook 004).

For example:

  $ grep -A2 "\[hook\]" ~/.gitconfig
  [hook]
          pre-commit = 001:~/test.sh
          pre-commit = 999:~/baz.sh

  $ grep -A1 "\[hook\]" ~/git/.git/config
  [hook]
          pre-commit = 900:~/bar.sh

  $ ./bin-wrappers/git hook --list pre-commit
  001     global  ~/test.sh
  900     repo    ~/bar.sh
  999     global  ~/baz.sh

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/git-hook.txt    | 17 +++++++-
 Makefile                      |  1 +
 builtin/hook.c                | 54 ++++++++++++++++++++++-
 hook.c                        | 81 +++++++++++++++++++++++++++++++++++
 hook.h                        | 14 ++++++
 t/t1360-config-based-hooks.sh | 43 ++++++++++++++++++-
 6 files changed, 206 insertions(+), 4 deletions(-)
 create mode 100644 hook.c
 create mode 100644 hook.h

diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 2d50c414cc..a141884239 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -8,12 +8,27 @@ git-hook - Manage configured hooks
 SYNOPSIS
 --------
 [verse]
-'git hook'
+'git hook' -l | --list <hook-name>
 
 DESCRIPTION
 -----------
 You can list, add, and modify hooks with this command.
 
+This command parses the default configuration files for lines which look like
+"hook.<hook-name> = <order number>:<hook command>", e.g. "hook.pre-commit =
+010:/path/to/script.sh". In this way, multiple scripts can be run during a
+single hook. Hooks are sorted in ascending order by order number; in the event
+of an order number conflict, they are sorted in configuration order.
+
+OPTIONS
+-------
+
+-l::
+--list::
+	List the hooks which have been configured for <hook-name>. Hooks appear
+	in the order they should be run. Output of this command follows the
+	format '<order number> <origin config> <hook command>'.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 83263505c0..21b3a82208 100644
--- a/Makefile
+++ b/Makefile
@@ -892,6 +892,7 @@ LIB_OBJS += hashmap.o
 LIB_OBJS += linear-assignment.o
 LIB_OBJS += help.o
 LIB_OBJS += hex.o
+LIB_OBJS += hook.o
 LIB_OBJS += ident.o
 LIB_OBJS += interdiff.o
 LIB_OBJS += json-writer.o
diff --git a/builtin/hook.c b/builtin/hook.c
index b2bbc84d4d..8261302b27 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,21 +1,73 @@
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
+	list_for_each(pos, head) {
+		item = list_entry(pos, struct hook, list);
+		if (item)
+			printf("%.3d\t%s\t%s\n", item->order,
+			       config_scope_to_string(item->origin),
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
+	strbuf_addstr(&hookname, "hook.");
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
index 0000000000..f8d1109084
--- /dev/null
+++ b/hook.c
@@ -0,0 +1,81 @@
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
+static void emplace_hook(struct list_head *pos, int order, const char *command)
+{
+	struct hook *to_add = malloc(sizeof(struct hook));
+	to_add->order = order;
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
+void clear_hook_list()
+{
+	struct list_head *pos, *tmp;
+	list_for_each_safe(pos, tmp, &hook_head)
+		remove_hook(pos);
+}
+
+static int check_config_for_hooks(const char *var, const char *value, void *hookname)
+{
+	struct list_head *pos, *p;
+	struct hook *item;
+	const struct strbuf *hookname_strbuf = hookname;
+
+	if (!strcmp(var, hookname_strbuf->buf)) {
+		int order = 0;
+		// TODO this is bad - open to overflows
+		char command[256];
+		int added = 0;
+		if (!sscanf(value, "%d:%s", &order, command))
+			die(_("hook config '%s' doesn't match expected format"),
+			    value);
+
+		list_for_each_safe(pos, p, &hook_head) {
+			item = list_entry(pos, struct hook, list);
+
+			/*
+			 * the new entry should go just before the first entry
+			 * which has a higher order number than it.
+			 */
+			if (item->order > order && !added) {
+				emplace_hook(pos, order, command);
+				added = 1;
+			}
+		}
+
+		if (!added)
+			emplace_hook(pos, order, command);
+	}
+
+	return 0;
+}
+
+struct list_head* hook_list(const struct strbuf* hookname)
+{
+	git_config(check_config_for_hooks, (void*)hookname);
+
+	return &hook_head;
+}
diff --git a/hook.h b/hook.h
new file mode 100644
index 0000000000..104df4c088
--- /dev/null
+++ b/hook.h
@@ -0,0 +1,14 @@
+#include "config.h"
+
+struct hook
+{
+	struct list_head list;
+	int order;
+	enum config_scope origin;
+	struct strbuf command;
+};
+
+struct list_head* hook_list(const struct strbuf *hookname);
+
+void free_hook(struct hook *ptr);
+void clear_hook_list();
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 34b0df5216..1434051db3 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -4,8 +4,47 @@ test_description='config-managed multihooks, including git-hook command'
 
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
+test_expect_success 'setup hooks in system, global, and local' '
+	git config --add --global hook.pre-commit "010:/path/def" &&
+	git config --add --global hook.pre-commit "999:/path/uvw" &&
+
+	git config --add --local hook.pre-commit "100:/path/ghi" &&
+	git config --add --local hook.pre-commit "990:/path/rst"
+'
+
+test_expect_success 'git hook --list orders by order number' '
+	cat >expected <<-\EOF &&
+	010	global	/path/def
+	100	repo	/path/ghi
+	990	repo	/path/rst
+	999	global	/path/uvw
+	EOF
+
+	git hook --list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'order number collisions resolved in config order' '
+	cat >expected <<-\EOF &&
+	010	global	/path/def
+	010	repo	/path/abc
+	100	repo	/path/ghi
+	990	repo	/path/rst
+	999	global	/path/uvw
+	EOF
+
+	git config --add --local hook.pre-commit "010:/path/abc" &&
+	git hook --list pre-commit >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.24.0.393.g34dc348eaf-goog

