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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4ABC433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9457161131
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbhIIOUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348640AbhIIOTx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:19:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E564C10DC47
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:42:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x6so2340298wrv.13
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T8JCehz2ndrXmIMuuT2TnO4zX08B5Kp8U9kXu9laL3A=;
        b=UUUemHJNhAOpAlW9UFJWg/U91zIxOd+LgysuzzU3TojXeO2/ZuVN3o1Y9qjRCUvqMy
         ffLRcNfrD5r+Fn9LQn5eWRQMSQF5RVjdzzkWiLN70S+SpHCU3/YbTUy3GCvf45bf319Z
         6jueuSL58+jMrAVFjYG98kqDiqAdcHxMqDVpXMA7AXHr9YvZA98EltJl4VFNDV7WZhGa
         qGb1FGOqC8CDnu4PWqre3iiO6JTxJGRKzCACjDqcj5dFInZhf5AQ34ROwHkpyOZhZcOD
         1YZvqVqZf0hUV27cVP/aagA8sdl/1Q+J7Q8a3PTuAyyOBP2LZps2vK/ee6LgymPcw3BJ
         wQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T8JCehz2ndrXmIMuuT2TnO4zX08B5Kp8U9kXu9laL3A=;
        b=WhamSjj66yoVuaRAkjqO9zmlmwIxNMdtrsqkZz+AswM9fbkGmCjU55iChMt51O1uKl
         KqKhSkqvkzRkU90KqtSc3BKmD8JPt1+iAAtfP09RhpIikFDtc8BQxHooKJ6orfK3JAN9
         KYT5bAZ2S+vbrXT4452cWekG9IxstN3N3ZKhTyhd0ND8ywQVKbZARuvYOMBMpMytbl2v
         mbKvmc90zqbnLq6Hd/68bdWs62P7KRNH1EbF4Fl7dz/OiTQsmxQKmpRcQ7puwrun9zgk
         2cfrhsEr08OvuHZcdAdDQ6OEP+KBWysS5x/6fLJxIRUCsg3EE32z04RHb1Q4YycQU7Au
         /fKA==
X-Gm-Message-State: AOAM531lfD2zEpPljvFIt+XRCgIl/2Ki/fjdGYeIPPttQIxssbNOjofm
        SAFlvq4upKhHVqcpGh3m5SVspZpyqbnSnw==
X-Google-Smtp-Source: ABdhPJz1WCjLVLuoRaWujvFMkRgQfS8PKWheLxDOPRPaG8BJ4zxt6IxEgDl6ZFc29PGMy7v5rd9KhQ==
X-Received: by 2002:a5d:4b4b:: with SMTP id w11mr216322wrs.302.1631191333127;
        Thu, 09 Sep 2021 05:42:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j25sm1742081wrc.12.2021.09.09.05.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:42:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v4 4/5] hook: include hooks from the config
Date:   Thu,  9 Sep 2021 14:42:02 +0200
Message-Id: <patch-v4-4.5-d0f5b30fb27-20210909T122802Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.867.g88ec4638586
In-Reply-To: <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com> <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach the hook.[hc] library to parse configs to populate the list of
hooks to run for a given event.

Multiple commands can be specified for a given hook by providing
multiple "hook.<friendly-name>.command = <path-to-hook>" and
"hook.<friendly-name>.event = <hook-event>" lines. Hooks will be started
in config order of the "hook.<name>.event" lines (but may run in
parallel).

For example:

  $ git config --get-regexp "^hook\."
  hook.bar.command=~/bar.sh
  hook.bar.event=pre-commit

  # Will run ~/bar.sh, then .git/hooks/pre-commit
  $ git hook run pre-commit

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 Documentation/config/hook.txt |  18 ++++
 Documentation/git-hook.txt    | 135 +++++++++++++++++++++++++++-
 builtin/hook.c                |   3 +-
 hook.c                        | 161 +++++++++++++++++++++++++++++----
 hook.h                        |   7 +-
 t/t1800-hook.sh               | 164 +++++++++++++++++++++++++++++++++-
 6 files changed, 465 insertions(+), 23 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 96d3d6572c1..c3947563280 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -1,3 +1,21 @@
+hook.<name>.command::
+	A command to execute whenever `hook.<name>` is invoked. `<name>` should
+	be a unique "friendly" name which you can use to identify this hook
+	command. (You can specify when to invoke this command with
+	`hook.<name>.event`.) The value can be an executable on your device or a
+	oneliner for your shell. If more than one value is specified for the
+	same `<name>`, the last value parsed will be the only command executed.
+	See linkgit:git-hook[1].
+
+hook.<name>.event::
+	The hook events which should invoke `hook.<name>`. `<name>` should be a
+	unique "friendly" name which you can use to identify this hook. The
+	value should be the name of a hook event, like "pre-commit" or "update".
+	(See linkgit:githooks[5] for a complete list of hooks Git knows about.)
+	On the specified event, the associated `hook.<name>.command` will be
+	executed. More than one event can be specified if you wish for
+	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
+
 hook.jobs::
 	Specifies how many hooks can be run simultaneously during parallelized
 	hook execution. If unspecified, defaults to the number of processors on
diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
index 88588b38143..51bda42fb83 100644
--- a/Documentation/git-hook.txt
+++ b/Documentation/git-hook.txt
@@ -19,12 +19,102 @@ This command is an interface to git hooks (see linkgit:githooks[5]).
 Currently it only provides a convenience wrapper for running hooks for
 use by git itself. In the future it might gain other functionality.
 
+It's possible to use this command to refer to hooks which are not native to Git,
+for example if a wrapper around Git wishes to expose hooks into its own
+operation in a way which is already familiar to Git users. However, wrappers
+invoking such hooks should be careful to name their hook events something which
+Git is unlikely to use for a native hook later on. For example, Git is much less
+likely to create a `mytool-validate-commit` hook than it is to create a
+`validate-commit` hook.
+
+This command parses the default configuration files for sets of configs like
+so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --cpp20
+
+In this example, `[hook "linter"]` represents one script - `~/bin/linter
+--cpp20` - which can be shared by many repos, and even by many hook events, if
+appropriate.
+
+To add an unrelated hook which runs on a different event, for example a
+spell-checker for your commit messages, you would write a configuration like so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --cpp20
+  [hook "spellcheck"]
+    event = commit-msg
+    command = ~/bin/spellchecker
+
+With this config, when you run 'git commit', first `~/bin/linter --cpp20` will
+have a chance to check your files to be committed (during the `pre-commit` hook
+event`), and then `~/bin/spellchecker` will have a chance to check your commit
+message (during the `commit-msg` hook event).
+
+Commands are run in the order Git encounters their associated
+`hook.<name>.event` configs during the configuration parse (see
+linkgit:git-config[1]). Although multiple `hook.linter.event` configs can be
+added, only one `hook.linter.command` event is valid - Git uses "last-one-wins"
+to determine which command to run.
+
+So if you wanted your linter to run when you commit as well as when you push,
+you would configure it like so:
+
+  [hook "linter"]
+    event = pre-commit
+    event = pre-push
+    command = ~/bin/linter --cpp20
+
+With this config, `~/bin/linter --cpp20` would be run by Git before a commit is
+generated (during `pre-commit`) as well as before a push is performed (during
+`pre-push`).
+
+And if you wanted to run your linter as well as a secret-leak detector during
+only the "pre-commit" hook event, you would configure it instead like so:
+
+  [hook "linter"]
+    event = pre-commit
+    command = ~/bin/linter --cpp20
+  [hook "no-leaks"]
+    event = pre-commit
+    command = ~/bin/leak-detector
+
+With this config, before a commit is generated (during `pre-commit`), Git would
+first start `~/bin/linter --cpp20` and second start `~/bin/leak-detector`. It
+would evaluate the output of each when deciding whether to proceed with the
+commit.
+
+For a full list of hook events which you can set your `hook.<name>.event` to,
+and how hooks are invoked during those events, see linkgit:githooks[5].
+
+Git will ignore any `hook.<name>.event` that specifies an event it doesn't
+recognize. This is intended so that tools which wrap Git can use the hook
+infrastructure to run their own hooks; see <<WRAPPERS>> for more guidance.
+
+In general, when instructions suggest adding a script to
+`.git/hooks/<hook-event>`, you can specify it in the config instead by running:
+
+----
+git config hook.<some-name>.command <path-to-script>
+git config --add hook.<some-name>.event <hook-event>
+----
+
+This way you can share the script between multiple repos. That is, `cp
+~/my-script.sh ~/project/.git/hooks/pre-commit` would become:
+
+----
+git config hook.my-script.command ~/my-script.sh
+git config --add hook.my-script.event pre-commit
+----
+
 SUBCOMMANDS
 -----------
 
 run::
-	Run the `<hook-name>` hook. See linkgit:githooks[5] for
-	the hook names we support.
+	Runs hooks configured for `<hook-name>`, in the order they are
+	discovered during the config parse.
 +
 Any positional arguments to the hook should be passed after an
 optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
@@ -58,6 +148,47 @@ config is not specified, uses the number of CPUs on the current system. Some
 hooks may be ineligible for parallelization: for example, 'commit-msg' intends
 hooks modify the commit message body and cannot be parallelized.
 
+[[WRAPPERS]]
+WRAPPERS
+--------
+
+`git hook run` has been designed to make it easy for tools which wrap Git to
+configure and execute hooks using the Git hook infrastructure. It is possible to
+provide arguments, environment variables (TODO this is missing from reroll TODO),
+and stdin via the command line, as well as specifying parallel or series
+execution if the user has provided multiple hooks.
+
+Assuming your wrapper wants to support a hook named "mywrapper-start-tests", you
+can have your users specify their hooks like so:
+
+  [hook "setup-test-dashboard"]
+    event = mywrapper-start-tests
+    command = ~/mywrapper/setup-dashboard.py --tap
+
+Then, in your 'mywrapper' tool, you can invoke any users' configured hooks by
+running:
+
+----
+git hook run mywrapper-start-tests \
+  # providing something to stdin
+  --stdin some-tempfile-123 \
+  # setting an env var (TODO THIS IS MISSING TODO)
+  --env MYWRAPPER_EXECUTION_MODE=foo \
+  # execute hooks in serial
+  --jobs 1 \
+  # plus some arguments of your own...
+  -- \
+  --testname bar \
+  baz
+----
+
+Take care to name your wrapper's hook events in a way which is unlikely to
+overlap with Git's native hooks (see linkgit:githooks[5]) - a hook event named
+`mywrappertool-validate-commit` is much less likely to be added to native Git
+than a hook event named `validate-commit`. If Git begins to use a hook event
+named the same thing as your wrapper hook, it may invoke your users' hooks in
+unintended and unsupported ways.
+
 CONFIGURATION
 -------------
 include::config/hook.txt[]
diff --git a/builtin/hook.c b/builtin/hook.c
index 1e6b15d565a..bb8fdde6bad 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -61,7 +61,8 @@ static int list(int argc, const char **argv, const char *prefix)
 		struct hook *item = list_entry(pos, struct hook, list);
 		item = list_entry(pos, struct hook, list);
 		if (item)
-			printf("%s\n", item->hook_path);
+			printf("%s\n", item->name ? item->name
+						  : _("hook from hookdir"));
 	}
 
 cleanup:
diff --git a/hook.c b/hook.c
index 600030c59ec..b825fa7c7ae 100644
--- a/hook.c
+++ b/hook.c
@@ -8,10 +8,54 @@ static void free_hook(struct hook *ptr)
 	if (!ptr)
 		return;
 
+	free(ptr->name);
 	free(ptr->feed_pipe_cb_data);
 	free(ptr);
 }
 
+/*
+ * Walks the linked list at 'head' to check if any hook named 'name'
+ * already exists. Returns a pointer to that hook if so, otherwise returns NULL.
+ */
+static struct hook *find_hook_by_name(struct list_head *head,
+					 const char *name)
+{
+	struct list_head *pos = NULL, *tmp = NULL;
+	struct hook *found = NULL;
+
+	list_for_each_safe(pos, tmp, head) {
+		struct hook *it = list_entry(pos, struct hook, list);
+		if (!strcmp(it->name, name)) {
+			list_del(pos);
+			found = it;
+			break;
+		}
+	}
+	return found;
+}
+
+/*
+ * Adds a hook if it's not already in the list, or moves it to the tail of the
+ * list if it was already there. name == NULL indicates it's from the hookdir;
+ * just append it in this case.
+ */
+static void append_or_move_hook(struct list_head *head, const char *name)
+{
+	struct hook *to_add = NULL;
+
+	/* if it's not from hookdir, check if the hook is already in the list */
+	if (name)
+		to_add = find_hook_by_name(head, name);
+
+	if (!to_add) {
+		/* adding a new hook, not moving an old one */
+		to_add = xcalloc(1, sizeof(*to_add));
+		to_add->name = xstrdup_or_null(name);
+	}
+
+	list_add_tail(&to_add->list, head);
+}
+
 static void remove_hook(struct list_head *to_remove)
 {
 	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
@@ -73,26 +117,72 @@ int hook_exists(const char *name)
 	return exists;
 }
 
+struct hook_config_cb
+{
+	const char *hook_event;
+	struct list_head *list;
+};
+
+/*
+ * Callback for git_config which adds configured hooks to a hook list.  Hooks
+ * can be configured by specifying both hook.<friend-name>.command = <path> and
+ * hook.<friendly-name>.event = <hook-event>.
+ */
+static int hook_config_lookup(const char *key, const char *value, void *cb_data)
+{
+	struct hook_config_cb *data = cb_data;
+	const char *subsection, *parsed_key;
+	size_t subsection_len = 0;
+	struct strbuf subsection_cpy = STRBUF_INIT;
+
+	/*
+	 * Don't bother doing the expensive parse if there's no
+	 * chance that the config matches 'hook.myhook.event = hook_event'.
+	 */
+	if (!value || strcmp(value, data->hook_event))
+		return 0;
+
+	/* Looking for "hook.friendlyname.event = hook_event" */
+	if (parse_config_key(key,
+			    "hook",
+			    &subsection,
+			    &subsection_len,
+			    &parsed_key) ||
+	    strcmp(parsed_key, "event"))
+		return 0;
+
+	/*
+	 * 'subsection' is a pointer to the internals of 'key', which we don't
+	 * own the memory for. Copy it away to the hook list.
+	 */
+	strbuf_add(&subsection_cpy, subsection, subsection_len);
+
+	append_or_move_hook(data->list, subsection_cpy.buf);
+	strbuf_release(&subsection_cpy);
+
+	return 0;
+}
+
 struct list_head *list_hooks(const char *hookname)
 {
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+	struct hook_config_cb cb_data = {
+		.hook_event = hookname,
+		.list = hook_head,
+	};
 
 	INIT_LIST_HEAD(hook_head);
 
 	if (!hookname)
 		BUG("null hookname was provided to hook_list()!");
 
-	if (have_git_dir()) {
-		const char *hook_path = find_hook(hookname);
+	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
+	git_config(hook_config_lookup, &cb_data);
 
-		/* Add the hook from the hookdir */
-		if (hook_path) {
-			struct hook *to_add = xmalloc(sizeof(*to_add));
-			to_add->hook_path = hook_path;
-			to_add->feed_pipe_cb_data = NULL;
-			list_add_tail(&to_add->list, hook_head);
-		}
-	}
+	/* Add the hook from the hookdir. The placeholder makes it easier to
+	 * allocate work in pick_next_hook. */
+	if (find_hook(hookname))
+		append_or_move_hook(hook_head, NULL);
 
 	return hook_head;
 }
@@ -153,11 +243,47 @@ static int pick_next_hook(struct child_process *cp,
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
+	/*
+	 * to enable oneliners, let config-specified hooks run in shell.
+	 * config-specified hooks have a name.
+	 */
+	cp->use_shell = !!run_me->name;
+
 	/* add command */
-	if (hook_cb->options->absolute_path)
-		strvec_push(&cp->args, absolute_path(run_me->hook_path));
-	else
-		strvec_push(&cp->args, run_me->hook_path);
+	if (run_me->name) {
+		/* ...from config */
+		struct strbuf cmd_key = STRBUF_INIT;
+		char *command = NULL;
+
+		strbuf_addf(&cmd_key, "hook.%s.command", run_me->name);
+		if (git_config_get_string(cmd_key.buf, &command)) {
+			/* TODO test me! */
+			die(_("'hook.%s.command' must be configured "
+			      "or 'hook.%s.event' must be removed; aborting.\n"),
+			    run_me->name, run_me->name);
+		}
+
+		strvec_push(&cp->args, command);
+		free(command);
+		strbuf_release(&cmd_key);
+	} else {
+		/* ...from hookdir. */
+		const char *hook_path = NULL;
+		/*
+		 * At this point we are already running, so don't validate
+		 * whether the hook name is known or not. Validation was
+		 * performed earlier in list_hooks().
+		 */
+		hook_path = find_hook(hook_cb->hook_name);
+		if (!hook_path)
+			BUG("hookdir hook in hook list but no hookdir hook present in filesystem");
+
+		if (hook_cb->options->absolute_path)
+			hook_path = absolute_path(hook_path);
+
+		strvec_push(&cp->args, hook_path);
+	}
+
 
 	/*
 	 * add passed-in argv, without expanding - let the user get back
@@ -187,8 +313,11 @@ static int notify_start_failure(struct strbuf *out,
 
 	hook_cb->rc |= 1;
 
-	strbuf_addf(out, _("Couldn't start hook '%s'\n"),
-		    attempted->hook_path);
+	if (attempted->name)
+		strbuf_addf(out, _("Couldn't start hook '%s'\n"),
+		    attempted->name);
+	else
+		strbuf_addstr(out, _("Couldn't start hook from hooks directory\n"));
 
 	return 1;
 }
diff --git a/hook.h b/hook.h
index fe16ab35028..4b728991089 100644
--- a/hook.h
+++ b/hook.h
@@ -7,8 +7,11 @@
 
 struct hook {
 	struct list_head list;
-	/* The path to the hook */
-	const char *hook_path;
+	/*
+	 * The friendly name of the hook. NULL indicates the hook is from the
+	 * hookdir.
+	 */
+	char *name;
 
 	/*
 	 * Use this to keep state for your feed_pipe_fn if you are using
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 7a1dae4e95e..68e7ff7de7e 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -1,13 +1,30 @@
 #!/bin/sh
 
-test_description='git-hook command'
+test_description='git-hook command and config-managed multihooks'
 
 . ./test-lib.sh
 
+setup_hooks () {
+	test_config hook.ghi.command "/path/ghi"
+	test_config hook.ghi.event pre-commit --add
+	test_config hook.ghi.event test-hook --add
+	test_config_global hook.def.command "/path/def"
+	test_config_global hook.def.event pre-commit --add
+}
+
+setup_hookdir () {
+	mkdir .git/hooks
+	write_script .git/hooks/pre-commit <<-EOF
+	echo \"Legacy Hook\"
+	EOF
+	test_when_finished rm -rf .git/hooks
+}
+
 test_expect_success 'git hook usage' '
 	test_expect_code 129 git hook &&
 	test_expect_code 129 git hook run &&
 	test_expect_code 129 git hook run -h &&
+	test_expect_code 129 git hook list -h &&
 	test_expect_code 129 git hook run --unknown 2>err &&
 	test_expect_code 129 git hook list &&
 	test_expect_code 129 git hook list -h &&
@@ -105,7 +122,7 @@ test_expect_success 'git hook list: does-not-exist hook' '
 
 test_expect_success 'git hook list: existing hook' '
 	cat >expect <<-\EOF &&
-	.git/hooks/test-hook
+	hook from hookdir
 	EOF
 	git hook list test-hook >actual &&
 	test_cmp expect actual
@@ -162,4 +179,147 @@ test_expect_success 'stdin to hooks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git hook list orders by config order' '
+	setup_hooks &&
+
+	cat >expected <<-\EOF &&
+	def
+	ghi
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git hook list reorders on duplicate event declarations' '
+	setup_hooks &&
+
+	# 'def' is usually configured globally; move it to the end by
+	# configuring it locally.
+	test_config hook.def.event "pre-commit" --add &&
+
+	cat >expected <<-\EOF &&
+	ghi
+	def
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hook can be configured for multiple events' '
+	setup_hooks &&
+
+	# 'ghi' should be included in both 'pre-commit' and 'test-hook'
+	git hook list pre-commit >actual &&
+	grep "ghi" actual &&
+	git hook list test-hook >actual &&
+	grep "ghi" actual
+'
+
+test_expect_success 'git hook list shows hooks from the hookdir' '
+	setup_hookdir &&
+
+	cat >expected <<-\EOF &&
+	hook from hookdir
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'inline hook definitions execute oneliners' '
+	test_config hook.oneliner.event "pre-commit" &&
+	test_config hook.oneliner.command "echo \"Hello World\"" &&
+
+	echo "Hello World" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'inline hook definitions resolve paths' '
+	write_script sample-hook.sh <<-\EOF &&
+	echo \"Sample Hook\"
+	EOF
+
+	test_when_finished "rm sample-hook.sh" &&
+
+	test_config hook.sample-hook.event pre-commit &&
+	test_config hook.sample-hook.command "\"$(pwd)/sample-hook.sh\"" &&
+
+	echo \"Sample Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hookdir hook included in git hook run' '
+	setup_hookdir &&
+
+	echo \"Legacy Hook\" >expected &&
+
+	# hooks are run with stdout_to_stderr = 1
+	git hook run pre-commit 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'stdin to multiple hooks' '
+	test_config hook.stdin-a.event "test-hook" --add &&
+	test_config hook.stdin-a.command "xargs -P1 -I% echo a%" --add &&
+	test_config hook.stdin-b.event "test-hook" --add &&
+	test_config hook.stdin-b.command "xargs -P1 -I% echo b%" --add &&
+
+	cat >input <<-\EOF &&
+	1
+	2
+	3
+	EOF
+
+	cat >expected <<-\EOF &&
+	a1
+	a2
+	a3
+	b1
+	b2
+	b3
+	EOF
+
+	git hook run --to-stdin=input test-hook 2>actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'multiple hooks in series' '
+	test_config hook.series-1.event "test-hook" &&
+	test_config hook.series-1.command "echo 1" --add &&
+	test_config hook.series-2.event "test-hook" &&
+	test_config hook.series-2.command "echo 2" --add &&
+	mkdir .git/hooks &&
+	write_script .git/hooks/test-hook <<-EOF &&
+	echo 3
+	EOF
+
+	cat >expected <<-\EOF &&
+	1
+	2
+	3
+	EOF
+
+	git hook run -j1 test-hook 2>actual &&
+	test_cmp expected actual &&
+
+	rm -rf .git/hooks
+'
+
+test_expect_success 'rejects hooks with no commands configured' '
+	test_config hook.broken.event "test-hook" &&
+
+	echo broken >expected &&
+	git hook list test-hook >actual &&
+	test_cmp expected actual &&
+	test_must_fail git hook run test-hook
+'
+
 test_done
-- 
2.33.0.867.g88ec4638586

