Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1082EC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D601722DBF
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgLEBri (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLEBri (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:38 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F8BC061A54
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id q22so4892310pfj.20
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6FkmMIv8T+hhh07ee5LfB9fHE709Ji9MhlDFZfbBFKc=;
        b=ceBUSwid3oQzBdGynjf39MLwqsga3UYOfJ+2vjWfovVWTo5PQMjBVR26y1531joAea
         rAcbgQoK304qBcT/R/vTAi7d1lnn8zUsfHiVwq2hzIkolXrETKdeFYvwWzeZmHoCdD31
         aTyFvvagJnajvwT7cvJAnBRu95C6V3kAHGddSdL6yuWeo3RmaDU7TtwsVN4gfGPH9yhH
         +jzYg3CeDokfLlYtXBUbKpWKUh9EQ8POa9Z6xUo4+SDcbOaUiIH9L8MNzKM9COGqKLKC
         96KnNHuGQJnQmrIHpaUuof6CTwBpzI2yZB9ivgSJDJ0MotEyxmsLUXQsF6oBO6pVntnZ
         Qp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6FkmMIv8T+hhh07ee5LfB9fHE709Ji9MhlDFZfbBFKc=;
        b=W44WP9hmxCKVPm9z2azPTIbHtZDyy4DOXbzuzGix6bBH/MoOM406NXP2XSnkHntVli
         yREAL4oin89+uo2q4GB55tq+dwIEjYJ+99AgRiecSZADUpncU2LWuO6OFoyw+Ik6k+3E
         vclwD1tdOAAxtFYVOKkaZwf35Wei1jsDXxIjXYCR9wcTkK21ZSMvZBfKkxVMQt2HHk6m
         wruc8WkxyufQCJ58ZE5uqEIPbmF1sn65h4cegVgkqJWNfdb5fXGqlcd51j09bOSE/wKr
         xljdlcVoPzM+hua1/OoM3jNxjPOm2MwsNL1NqwZOlftEzWidBYadnuYnEY+oQDBsNMq4
         6psg==
X-Gm-Message-State: AOAM532Ifs7azmBfS9HyKIUxBWFgud8Rjlmj5pWV62yhWHKhs33mAECw
        7dwReMcnWsEf7MxNVmcQK7xdz0m506OpbNC28WwRs9HqG/tY3rewcg0fE13kavzBn+14YK48Mfp
        1of9b401CrFtr3Dpz0DEPU4NJAVGP3eYKGicEYY7IKaIufZfq4M4b/RoKj+2bWp7JhFDtZm3xfA
        ==
X-Google-Smtp-Source: ABdhPJzUFYiELTmW6fWVDfPj9DKtTC6AH7efnxvjEUc37d+dDA6ZMKOOyMFb5YuJz3Rkoh1tuI2D1+wQtmMm6F4MCfw=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a63:5f07:: with SMTP id
 t7mr9739238pgb.144.1607132784182; Fri, 04 Dec 2020 17:46:24 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:45:55 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-6-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 05/17] hook: respect hook.runHookDir
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Include hooks specified in the hook directory in the list of hooks to
run. These hooks do need to be treated differently from config-specified
ones - they do not need to run in a shell, and later on may be disabled
or warned about based on a config setting.

Because they are at least as local as the local config, we'll run them
last - to keep the hook execution order from global to local.

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

 Documentation/config/hook.txt |  5 ++++
 builtin/hook.c                | 54 +++++++++++++++++++++++++++++++++--
 hook.c                        | 21 ++++++++++++++
 hook.h                        | 15 ++++++++++
 t/t1360-config-based-hooks.sh | 43 ++++++++++++++++++++++++++++
 5 files changed, 135 insertions(+), 3 deletions(-)

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
index 45bbc83b2b..16324d4195 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -11,6 +11,8 @@ static const char * const builtin_hook_usage[] = {
 	NULL
 };
 
+static enum hookdir_opt should_run_hookdir;
+
 static int list(int argc, const char **argv, const char *prefix)
 {
 	struct list_head *head, *pos;
@@ -41,6 +43,26 @@ static int list(int argc, const char **argv, const char *prefix)
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
 		if (item) {
@@ -64,14 +86,40 @@ static int list(int argc, const char **argv, const char *prefix)
 
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
index ffbdcfd987..340e5a35c8 100644
--- a/hook.c
+++ b/hook.c
@@ -97,6 +97,27 @@ static int hook_config_lookup(const char *key, const char *value, void *cb_data)
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
diff --git a/hook.h b/hook.h
index 5750634c83..ca45d388d3 100644
--- a/hook.h
+++ b/hook.h
@@ -21,6 +21,21 @@ struct hook
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
index 0f12af4659..91127a50a4 100755
--- a/t/t1360-config-based-hooks.sh
+++ b/t/t1360-config-based-hooks.sh
@@ -104,4 +104,47 @@ test_expect_success 'git hook list shows hooks from the hookdir' '
 	test_cmp expected actual
 '
 
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

