Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E29C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3858122259
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 01:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qk2wj5Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732449AbgJOByu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 21:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbgJOByi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE38C08EAC1
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:04 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id w78so504793pfc.15
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 16:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=x1230MfiafhTEHlMUxwGcwVR7XUFArfqKELjukUYBMo=;
        b=qk2wj5UkKvk4BmwjRAXJGteu1yZS4CB92Rqj423btSnDNl4bK1r7tIlqkegI+7uwoH
         9iP2PsHeuS6Eq4lUxMpOJH7Jwr3I1gZvquLqeS6bomuuK4dDD9c6j2LxwFfyKJL7sejh
         YcWWZzNUWbvIddm5DIrkfbCl8teBRjMQIq2PCSQfPHtEkhAaPtyrDsBtr0uuIo1MWSah
         dg2KQS7JlS+Jeov9tCquAUZHzT5JMUZSwxJLHqgPEISrHWU1IdBTx2Sjt+23skSJC0K9
         QxZzybbbUZa2ObbeSnmOU1VTROjxtTuU7XjSoMXRAC3HIHS8qCYwDgqcQb5ySMTixGNV
         1KSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x1230MfiafhTEHlMUxwGcwVR7XUFArfqKELjukUYBMo=;
        b=WQ30vESrfV3uSzsEadjlXHNLW/gfHkPbsWMino7Xudb0DjZ/LfJeKZnYCe2Rws1Xs6
         e/leZEYxuaTbMLgellyBSgoY9k757U4INptP8dDsPaRjN/ZKyh0yG9vbI6bZ5NLFz/de
         Sdqk27co0vn1kK0KyiupUUq/lIwaBRgM/aAxhpRn+16z3qOFpnQrL8HPXOMybJbRZLM7
         CSgnwGyCQSVxg2LPGnJGUCrTIeD7N9pDcqyuGsx3qY1v4Oxqy6aPtLwWIu7s0TBVa8+R
         7WNRNvgsLl+71Q9LYav3WAPwf4qqm/iB81qrM6vY6FofYtkWmgRqEWfwxWPo/AwgwoLa
         KgFQ==
X-Gm-Message-State: AOAM531/TrWxwxRbGIoRQk4+A1QaGOu+oKvHr9DkLs2SBsqL9pig/ujn
        7K4AQ7bTgLLeBA1rDkWtUsUD6gWv9m8VDCigx8uU0wCYNMI9iA+JSHV9ayPC+0ssBO5pNpc+E/e
        gCxdsWoh/5i8D6IM+qLu8w9tXQqyHdBUYqoEoeT0LzhjrXYfefKqW8qaW4NL6SzFHG5qA9TClAw
        ==
X-Google-Smtp-Source: ABdhPJyFw0/ghkbMElbW2kG/g7P4xIDnqkqML5Nny4ejKzIJbEeU1ZDs8SfONzzFSZHVFVEHotI8fIBfrGGvwikRsyU=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:aa7:9501:0:b029:155:3b11:d5c4 with
 SMTP id b1-20020aa795010000b02901553b11d5c4mr1506192pfp.76.1602717903273;
 Wed, 14 Oct 2020 16:25:03 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:24:43 -0700
In-Reply-To: <20201014232447.3050579-1-emilyshaffer@google.com>
Message-Id: <20201014232447.3050579-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201014232447.3050579-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH v5 4/8] hook: include hookdir hook in list
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Historically, hooks are declared by placing an executable into
$GIT_DIR/hooks/$HOOKNAME (or $HOOKDIR/$HOOKNAME). Although hooks taken
from the config are more featureful than hooks placed in the $HOOKDIR,
those hooks should not stop working for users who already have them.

When we add hooks from $HOOKDIR to the list of all hooks to run, to
support paths with spaces in them, quote legacy hook paths.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Newly split into its own commit since v4, and taking place much sooner.
    
    An unfortunate side effect of adding this support *before* the
    hook.runHookDir support is that the labels on the list are not clear -
    because we aren't yet flagging which hooks are from the hookdir versus
    the config. I suppose we could move the addition of that field to the
    struct hook up to this patch, but it didn't make a lot of sense to me to
    do it just for cosmetic purposes.

 Documentation/config/hook.txt |  5 +++
 builtin/hook.c                | 70 +++++++++++++++++++++++++++++++----
 hook.c                        | 36 ++++++++++++++++++
 hook.h                        | 16 ++++++++
 t/t1360-config-based-hooks.sh | 62 +++++++++++++++++++++++++++++++
 5 files changed, 182 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/hook.txt b/Documentation/config/hook.txt
index 71449ecbc7..75312754ae 100644
--- a/Documentation/config/hook.txt
+++ b/Documentation/config/hook.txt
@@ -7,3 +7,8 @@ hookcmd.<name>.command::
 	A command to execute during a hook for which <name> has been specified
 	as a command. This can be an executable on your device or a oneliner for
 	your shell. See linkgit:git-hook[1].
+
+hook.runHookDir::
+	Controls how hooks contained in your hookdir are executed. Can be any of
+	"yes", "warn", "interactive", or "no". Defaults to "yes". See
+	linkgit:git-hook[1] and linkgit:git-config[1] "core.hooksPath").
diff --git a/builtin/hook.c b/builtin/hook.c
index 4d36de52f8..16324d4195 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -11,11 +11,14 @@ static const char * const builtin_hook_usage[] = {
 	NULL
 };
 
+static enum hookdir_opt should_run_hookdir;
+
 static int list(int argc, const char **argv, const char *prefix)
 {
 	struct list_head *head, *pos;
 	struct hook *item;
 	struct strbuf hookname = STRBUF_INIT;
+	struct strbuf hookdir_annotation = STRBUF_INIT;
 
 	struct option list_options[] = {
 		OPT_END(),
@@ -40,12 +43,39 @@ static int list(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	switch (should_run_hookdir) {
+		case hookdir_no:
+			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
+			break;
+		case hookdir_interactive:
+			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
+			break;
+		case hookdir_warn:
+		case hookdir_unknown:
+			strbuf_addstr(&hookdir_annotation, _(" (will warn)"));
+			break;
+		case hookdir_yes:
+		/*
+		 * The default behavior should agree with
+		 * hook.c:configured_hookdir_opt().
+		 */
+		default:
+			break;
+	}
+
 	list_for_each(pos, head) {
 		item = list_entry(pos, struct hook, list);
-		if (item)
-			printf("%s: %s\n",
-			       config_scope_name(item->origin),
-			       item->command.buf);
+		if (item) {
+			/* Don't translate 'hookdir' - it matches the config */
+			printf("%s: %s%s\n",
+			       (item->from_hookdir
+				? "hookdir"
+				: config_scope_name(item->origin)),
+			       item->command.buf,
+			       (item->from_hookdir
+				? hookdir_annotation.buf
+				: ""));
+		}
 	}
 
 	clear_hook_list(head);
@@ -56,14 +86,40 @@ static int list(int argc, const char **argv, const char *prefix)
 
 int cmd_hook(int argc, const char **argv, const char *prefix)
 {
+	const char *run_hookdir = NULL;
+
 	struct option builtin_hook_options[] = {
+		OPT_STRING(0, "run-hookdir", &run_hookdir, N_("option"),
+			   N_("what to do with hooks found in the hookdir")),
 		OPT_END(),
 	};
-	if (argc < 2)
+
+	argc = parse_options(argc, argv, prefix, builtin_hook_options,
+			     builtin_hook_usage, 0);
+
+	/* after the parse, we should have "<command> <hookname> <args...>" */
+	if (argc < 1)
 		usage_with_options(builtin_hook_usage, builtin_hook_options);
 
-	if (!strcmp(argv[1], "list"))
-		return list(argc - 1, argv + 1, prefix);
+
+	/* argument > config */
+	if (run_hookdir)
+		if (!strcmp(run_hookdir, "no"))
+			should_run_hookdir = hookdir_no;
+		else if (!strcmp(run_hookdir, "yes"))
+			should_run_hookdir = hookdir_yes;
+		else if (!strcmp(run_hookdir, "warn"))
+			should_run_hookdir = hookdir_warn;
+		else if (!strcmp(run_hookdir, "interactive"))
+			should_run_hookdir = hookdir_interactive;
+		else
+			die(_("'%s' is not a valid option for --run-hookdir "
+			      "(yes, warn, interactive, no)"), run_hookdir);
+	else
+		should_run_hookdir = configured_hookdir_opt();
+
+	if (!strcmp(argv[0], "list"))
+		return list(argc, argv, prefix);
 
 	usage_with_options(builtin_hook_usage, builtin_hook_options);
 }
diff --git a/hook.c b/hook.c
index 937dc768c8..340e5a35c8 100644
--- a/hook.c
+++ b/hook.c
@@ -2,6 +2,7 @@
 
 #include "hook.h"
 #include "config.h"
+#include "run-command.h"
 
 void free_hook(struct hook *ptr)
 {
@@ -34,6 +35,7 @@ static void append_or_move_hook(struct list_head *head, const char *command)
 		to_add = xmalloc(sizeof(struct hook));
 		strbuf_init(&to_add->command, 0);
 		strbuf_addstr(&to_add->command, command);
+		to_add->from_hookdir = 0;
 	}
 
 	/* re-set the scope so we show where an override was specified */
@@ -95,11 +97,33 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
 	return 0;
 }
 
+enum hookdir_opt configured_hookdir_opt(void)
+{
+	const char *key;
+	if (git_config_get_value("hook.runhookdir", &key))
+		return hookdir_yes; /* by default, just run it. */
+
+	if (!strcmp(key, "no"))
+		return hookdir_no;
+
+	if (!strcmp(key, "yes"))
+		return hookdir_yes;
+
+	if (!strcmp(key, "warn"))
+		return hookdir_warn;
+
+	if (!strcmp(key, "interactive"))
+		return hookdir_interactive;
+
+	return hookdir_unknown;
+}
+
 struct list_head* hook_list(const struct strbuf* hookname)
 {
 	struct strbuf hook_key = STRBUF_INIT;
 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
 	struct hook_config_cb cb_data = { &hook_key, hook_head };
+	const char *legacy_hook_path = NULL;
 
 	INIT_LIST_HEAD(hook_head);
 
@@ -110,6 +134,18 @@ struct list_head* hook_list(const struct strbuf* hookname)
 
 	git_config(hook_config_lookup, (void*)&cb_data);
 
+	if (have_git_dir())
+		legacy_hook_path = find_hook(hookname->buf);
+
+	/* Unconditionally add legacy hook, but annotate it. */
+	if (legacy_hook_path) {
+		struct hook *legacy_hook;
+
+		append_or_move_hook(hook_head, absolute_path(legacy_hook_path));
+		legacy_hook = list_entry(hook_head->prev, struct hook, list);
+		legacy_hook->from_hookdir = 1;
+	}
+
 	strbuf_release(&hook_key);
 	return hook_head;
 }
diff --git a/hook.h b/hook.h
index 8ffc4f14b6..ca45d388d3 100644
--- a/hook.h
+++ b/hook.h
@@ -12,6 +12,7 @@ struct hook
 	enum config_scope origin;
 	/* The literal command to run. */
 	struct strbuf command;
+	int from_hookdir;
 };
 
 /*
@@ -20,6 +21,21 @@ struct hook
  */
 struct list_head* hook_list(const struct strbuf *hookname);
 
+enum hookdir_opt
+{
+	hookdir_no,
+	hookdir_warn,
+	hookdir_interactive,
+	hookdir_yes,
+	hookdir_unknown,
+};
+
+/*
+ * Provides the hookdir_opt specified in the config without consulting any
+ * command line arguments.
+ */
+enum hookdir_opt configured_hookdir_opt(void);
+
 /* Free memory associated with a 'struct hook' */
 void free_hook(struct hook *ptr);
 /* Empties the list at 'head', calling 'free_hook()' on each entry */
diff --git a/t/t1360-config-based-hooks.sh b/t/t1360-config-based-hooks.sh
index 6e4a3e763f..91127a50a4 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -23,6 +23,14 @@ setup_hookcmd () {
 	test_config_global hookcmd.abc.command "/path/abc" --add
 }
 
+setup_hookdir () {
+	mkdir .git/hooks
+	write_script .git/hooks/pre-commit <<-EOF
+	echo \"Legacy Hook\"
+	EOF
+	test_when_finished rm -rf .git/hooks
+}
+
 test_expect_success 'git hook rejects commands without a mode' '
 	test_must_fail git hook pre-commit
 '
@@ -85,4 +93,58 @@ test_expect_success 'git hook list reorders on duplicate commands' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list shows hooks from the hookdir' '
+	setup_hookdir &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit
+	EOF
+
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'hook.runHookDir = no is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "no" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will not run)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_i18ncmp expected actual
+'
+
+test_expect_success 'hook.runHookDir = warn is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "warn" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will warn)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_i18ncmp expected actual
+'
+
+
+test_expect_success 'hook.runHookDir = interactive is respected by list' '
+	setup_hookdir &&
+
+	test_config hook.runHookDir "interactive" &&
+
+	cat >expected <<-EOF &&
+	hookdir: $(pwd)/.git/hooks/pre-commit (will prompt)
+	EOF
+
+	git hook list pre-commit >actual &&
+	# the hookdir annotation is translated
+	test_i18ncmp expected actual
+'
+
 test_done
-- 
2.28.0.rc0.142.g3c755180ce-goog

