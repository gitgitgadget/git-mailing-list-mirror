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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ECDC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29B761059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242188AbhIIOT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346703AbhIIOTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:19:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4793C10DC42
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:42:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso1297306wmc.1
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQoqKhPuQ+ZkU0s4Z1vyskfxutKgklrrY5j5hKb335o=;
        b=WZ1T/iyIoIxSwx6KknQdnF/E+6JACI9Azd6LxfgxuA9tPO+AtFM0Zv/z7InJyCb5JJ
         THpyPe4ea4C5UsZC+zNSiyrNDLpJaQe27WGxYDFs1Np9ngOy4rjeTOzeBWBpq5LZEgA8
         DEj1qFtST7Ol55bGHcKj9JKAjYJ5eYGA56kXODg+eMY0SxL25Wx8ro8oUD/2rSNBdz+T
         tqBT+55fcCACEq1M4GQQ4JuhKNK/U4G1a+TfBxAIKiT0ohPEtMBnnYhYPPCW8vFAeOhA
         TChmG+cWkgS8JRKCC7lvH2H9Gi4xauRNA3H48vf9DUCXPmvewRhYKPVP7RDbnjMajJ3P
         UqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQoqKhPuQ+ZkU0s4Z1vyskfxutKgklrrY5j5hKb335o=;
        b=nQlPnPG2UXdiPgqH0+ud2LCk/s32ulfn0MjE9GljEX8FCb6UiiU7moWAPSIE+6jAhX
         kCIdqoJm2hpShsBnSLNym4rjgF/LXKuS9REAbaLZPRh6mpTIDb33OuoDaLeuiJA8lkXw
         3mGT+zJ57cF92C1zR2QXrZh2+opTfAret597XH0I4mp4ydRgSJSrvVtAUviNSZPX/HWM
         OBQrkk3P70jOqkSt4TkJdzMYw/x6ldcrmU+iJPfKL7E33+MWSH/3GXh8gwFp8OpK7Lsv
         nwcwsx1BCjvaxxdu4NUE9/tTCSa0v7tPHF1pt+PH8zoOX0Nn66RtRHI++9w0ifowUsYl
         gTWQ==
X-Gm-Message-State: AOAM533dPkcg1EbIK28hV891B2VZK+4hTEa5leq+rSSVJJ8A/hmpCzmM
        QS5MDmjrQT9i3bLAMIQETWnNOy50Q2xlbw==
X-Google-Smtp-Source: ABdhPJyGYy1Pd53ZaYNycfAr+H5WY2jb4HQH64dEKJmFAQsXuqKOUXeGr9mbvyVIpH64rBrq1PvDeg==
X-Received: by 2002:a1c:8096:: with SMTP id b144mr2712731wmd.189.1631191329326;
        Thu, 09 Sep 2021 05:42:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j25sm1742081wrc.12.2021.09.09.05.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:42:08 -0700 (PDT)
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
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/5] config-based hooks restarted
Date:   Thu,  9 Sep 2021 14:41:58 +0200
Message-Id: <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.867.g88ec4638586
In-Reply-To: <20210819033450.3382652-1-emilyshaffer@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of Emily's es/config-based-hooks topic that goes on
top of the v5 of my ab/config-based-hooks-base, and which doesn't have
errors under SANITIZE=leak.

Emily: Sorry, I've got no intention to steal this one too, hopefully
you can get around to your own re-roll.

But per my
https://lore.kernel.org/git/87sfyfgtfh.fsf@evledraar.gmail.com/ the
lack of this re-roll is is currently blocking the pick-up of my
re-rolled v5 of ab/config-based-hooks-base at [1], as well as causing
a failure in "seen" when combined with my ab/sanitize-leak-ci (and
hn/reftable, but that's another issue...).

Junio: So hopefully you can pick up the v5[1] of the base topic now &
this preliminary v4 of es/config-based-hooks.

The range-diff below is against Emily's 30ffe98601e, i.e. her v3 at
[2].

This version is based on Emily's preliminary cf1f8e34a34
(nasamuffin/config-based-hooks-restart), which appeared to be her
August 31 rebasing addressing of many outstanding points in the v3
series.

My own changes on top of that were twofold: Adjustments to changes in
the base topic (many done to make the overall diff/changes here
smaller), and memory leak fixes to get this to pass under
SANITIZE=leak, there's various other minor but not-notable changes
here and there, see the range-diff.

1. https://lore.kernel.org/git/cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com/
2. https://lore.kernel.org/git/20210819033450.3382652-1-emilyshaffer@google.com/

Emily Shaffer (5):
  hook: run a list of hooks instead
  hook: allow parallel hook execution
  hook: introduce "git hook list"
  hook: include hooks from the config
  hook: allow out-of-repo 'git hook' invocations

 Documentation/config.txt      |   2 +
 Documentation/config/hook.txt |  22 +++
 Documentation/git-hook.txt    | 157 ++++++++++++++++++-
 builtin/am.c                  |   4 +-
 builtin/checkout.c            |   2 +-
 builtin/clone.c               |   2 +-
 builtin/hook.c                |  71 ++++++++-
 builtin/merge.c               |   2 +-
 builtin/rebase.c              |   2 +-
 builtin/receive-pack.c        |   9 +-
 builtin/worktree.c            |   2 +-
 commit.c                      |   2 +-
 git.c                         |   2 +-
 hook.c                        | 277 +++++++++++++++++++++++++++++-----
 hook.h                        |  45 +++++-
 read-cache.c                  |   2 +-
 refs.c                        |   2 +-
 reset.c                       |   3 +-
 sequencer.c                   |   4 +-
 t/t1800-hook.sh               | 194 +++++++++++++++++++++++-
 transport.c                   |   2 +-
 21 files changed, 734 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/config/hook.txt

Range-diff against v3:
1:  6d6400329cd ! 1:  2f0cac14965 hook: run a list of hooks instead
    @@ Commit message
         executable for a single hook event.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/hook.c ##
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
      	const char *hook_name;
     -	const char *hook_path;
     +	struct list_head *hooks;
    -+
      	struct option run_options[] = {
      		OPT_BOOL(0, "ignore-missing", &ignore_missing,
      			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
     @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
    - 	git_config(git_default_config, NULL);
    - 
    + 	 * run_hooks() instead...
    + 	 */
      	hook_name = argv[0];
     -	if (ignore_missing)
    ++	hooks = list_hooks(hook_name);
    ++	if (list_empty(hooks)) {
    ++		clear_hook_list(hooks);
    ++
    + 		/* ... act like a plain run_hooks() under --ignore-missing */
     -		return run_hooks_oneshot(hook_name, &opt);
     -	hook_path = find_hook(hook_name);
     -	if (!hook_path) {
    -+	hooks = list_hooks(hook_name);
    -+	if (list_empty(hooks)) {
    -+		/* ... act like run_hooks_oneshot() under --ignore-missing */
     +		if (ignore_missing)
     +			return 0;
      		error("cannot find a hook named %s", hook_name);
    @@ builtin/hook.c: static int run(int argc, const char **argv, const char *prefix)
     
      ## hook.c ##
     @@
    - #include "hook-list.h"
    + #include "run-command.h"
      #include "config.h"
      
     +static void free_hook(struct hook *ptr)
     +{
    -+	if (ptr)
    -+		free(ptr->feed_pipe_cb_data);
    ++	if (!ptr)
    ++		return;
    ++
    ++	free(ptr->feed_pipe_cb_data);
     +	free(ptr);
     +}
     +
    @@ hook.c
     +	struct list_head *pos, *tmp;
     +	list_for_each_safe(pos, tmp, head)
     +		remove_hook(pos);
    ++	free(head);
     +}
     +
    - static int known_hook(const char *name)
    + const char *find_hook(const char *name)
      {
    - 	const char **p;
    + 	static struct strbuf path = STRBUF_INIT;
     @@ hook.c: const char *find_hook(const char *name)
      
      int hook_exists(const char *name)
      {
     -	return !!find_hook(name);
    -+	return !list_empty(list_hooks(name));
    ++	struct list_head *hooks;
    ++	int exists;
    ++
    ++	hooks = list_hooks(name);
    ++	exists = !list_empty(hooks);
    ++	clear_hook_list(hooks);
    ++
    ++	return exists;
     +}
     +
     +struct list_head *list_hooks(const char *hookname)
    @@ hook.c: static int notify_hook_finished(int result,
      }
      
     -int run_hooks(const char *hook_name, const char *hook_path,
    --	      struct run_hooks_opt *options)
     +int run_hooks(const char *hook_name, struct list_head *hooks,
    -+		    struct run_hooks_opt *options)
    + 	      struct run_hooks_opt *options)
      {
     -	struct strbuf abs_path = STRBUF_INIT;
     -	struct hook my_hook = {
    @@ hook.c: int run_hooks(const char *hook_name, const char *hook_path,
     -		my_hook.hook_path = abs_path.buf;
     -	}
     -	cb_data.run_me = &my_hook;
    -+
     +	cb_data.head = hooks;
     +	cb_data.run_me = list_first_entry(hooks, struct hook, list);
      
    @@ hook.c: int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *optio
      
     -	ret = run_hooks(hook_name, hook_path, options);
     +	ret = run_hooks(hook_name, hooks, options);
    -+
    + 
      cleanup:
      	run_hooks_opt_clear(options);
    -+	clear_hook_list(hooks);
    - 	return ret;
    - }
     
      ## hook.h ##
     @@
    @@ hook.h
      #include "run-command.h"
     +#include "list.h"
      
    - /*
    -  * Returns the path to the hook file, or NULL if the hook is missing
    -@@ hook.h: const char *find_hook(const char *name);
    - int hook_exists(const char *hookname);
    - 
      struct hook {
     +	struct list_head list;
      	/* The path to the hook */
      	const char *hook_path;
      
    -@@ hook.h: struct hook {
    - 	void *feed_pipe_cb_data;
    - };
    - 
    -+/*
    -+ * Provides a linked list of 'struct hook' detailing commands which should run
    -+ * in response to the 'hookname' event, in execution order.
    -+ */
    -+struct list_head *list_hooks(const char *hookname);
    -+
    - struct run_hooks_opt
    - {
    - 	/* Environment vars to be set for each hook */
     @@ hook.h: struct hook_cb_data {
      	/* rc reflects the cumulative failure state */
      	int rc;
    @@ hook.h: struct hook_cb_data {
      	struct hook *run_me;
      	struct run_hooks_opt *options;
      	int *invoked_hook;
    +@@ hook.h: struct hook_cb_data {
    + const char *find_hook(const char *name);
    + 
    + /**
    +- * A boolean version of find_hook()
    ++ * Provides a linked list of 'struct hook' detailing commands which should run
    ++ * in response to the 'hookname' event, in execution order.
    ++ */
    ++struct list_head *list_hooks(const char *hookname);
    ++
    ++/**
    ++ * A boolean version of list_hooks()
    +  */
    + int hook_exists(const char *hookname);
    + 
     @@ hook.h: void run_hooks_opt_clear(struct run_hooks_opt *o);
    + 
    + /**
    +  * Takes an already resolved hook found via find_hook() and runs
    +- * it. Does not call run_hooks_opt_clear() for you.
    ++ * it. Does not call run_hooks_opt_clear() for you, but does call
    ++ * clear_hook_list().
       *
       * See run_hooks_oneshot() for the simpler one-shot API.
       */
     -int run_hooks(const char *hookname, const char *hook_path,
    --	      struct run_hooks_opt *options);
     +int run_hooks(const char *hookname, struct list_head *hooks,
    -+		    struct run_hooks_opt *options);
    - 
    - /**
    -  * Calls find_hook() on your "hook_name" and runs the hooks (if any)
    -@@ hook.h: int run_hooks(const char *hookname, const char *hook_path,
    -  */
    - int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options);
    + 	      struct run_hooks_opt *options);
      
    -+/* Empties the list at 'head', calling 'free_hook()' on each entry */
    ++/**
    ++ * Empties the list at 'head', calling 'free_hook()' on each
    ++ * entry. Called implicitly by run_hooks() (and run_hooks_oneshot()).
    ++ */
     +void clear_hook_list(struct list_head *head);
     +
    - #endif
    + /**
    +  * Calls find_hook() on your "hook_name" and runs the hooks (if any)
    +  * with run_hooks().
2:  dfb995ce4d4 ! 2:  b03e70c805e hook: allow parallel hook execution
    @@ Commit message
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    + ## Documentation/config.txt ##
    +@@ Documentation/config.txt: include::config/guitool.txt[]
    + 
    + include::config/help.txt[]
    + 
    ++include::config/hook.txt[]
    ++
    + include::config/http.txt[]
    + 
    + include::config/i18n.txt[]
    +
      ## Documentation/config/hook.txt (new) ##
     @@
     +hook.jobs::
    @@ Documentation/git-hook.txt: OPTIONS
     +--jobs::
     +	Only valid for `run`.
     ++
    -+Specify how many hooks to run simultaneously. If this flag is not specified, use
    -+the value of the `hook.jobs` config. If the config is not specified, use the
    -+number of CPUs on the current system. Some hooks may be ineligible for
    -+parallelization: for example, 'commit-msg' intends hooks modify the commit
    -+message body and cannot be parallelized.
    ++Specify how many hooks to run simultaneously. If this flag is not specified,
    ++uses the value of the `hook.jobs` config, see linkgit:git-config[1]. If the
    ++config is not specified, uses the number of CPUs on the current system. Some
    ++hooks may be ineligible for parallelization: for example, 'commit-msg' intends
    ++hooks modify the commit message body and cannot be parallelized.
     +
     +CONFIGURATION
     +-------------
    @@ hook.c: static int notify_hook_finished(int result,
     +}
     +
      int run_hooks(const char *hook_name, struct list_head *hooks,
    - 		    struct run_hooks_opt *options)
    + 	      struct run_hooks_opt *options)
      {
     @@ hook.c: int run_hooks(const char *hook_name, struct list_head *hooks,
      		.options = options,
    @@ hook.c: int run_hooks(const char *hook_name, struct list_head *hooks,
      
      	if (!options)
      		BUG("a struct run_hooks_opt must be provided to run_hooks");
    - 
    --
    +@@ hook.c: int run_hooks(const char *hook_name, struct list_head *hooks,
      	cb_data.head = hooks;
      	cb_data.run_me = list_first_entry(hooks, struct hook, list);
      
    @@ hook.h: struct run_hooks_opt
     +	 */
     +	int jobs;
     +
    - 	/* Resolve and run the "absolute_path(hook)" instead of
    + 	/*
    + 	 * Resolve and run the "absolute_path(hook)" instead of
      	 * "hook". Used for "git worktree" hooks
    - 	 */
     @@ hook.h: struct run_hooks_opt
      	int *invoked_hook;
      };
      
     -#define RUN_HOOKS_OPT_INIT { \
    --	.env = STRVEC_INIT, \
    --	.args = STRVEC_INIT, \
    --}
    --
    - /*
    -  * To specify a 'struct string_list', set 'run_hooks_opt.feed_pipe_ctx' to the
    -  * string_list and set 'run_hooks_opt.feed_pipe' to 'pipe_from_string_list()'.
    -@@ hook.h: struct hook_cb_data {
    - 	int *invoked_hook;
    - };
    - 
     +#define RUN_HOOKS_OPT_INIT_SERIAL { \
     +	.jobs = 1, \
     +	.env = STRVEC_INIT, \
    @@ hook.h: struct hook_cb_data {
     +
     +#define RUN_HOOKS_OPT_INIT_PARALLEL { \
     +	.jobs = 0, \
    -+	.env = STRVEC_INIT, \
    -+	.args = STRVEC_INIT, \
    -+}
    -+
    - void run_hooks_opt_clear(struct run_hooks_opt *o);
    - 
    - /**
    + 	.env = STRVEC_INIT, \
    + 	.args = STRVEC_INIT, \
    + }
     
      ## read-cache.c ##
     @@ read-cache.c: static int do_write_locked_index(struct index_state *istate, struct lock_file *l
3:  c8a04306e90 ! 3:  3e647b8dba7 hook: introduce "git hook list"
    @@ Commit message
         hooks were configured and whether or not they will run.
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Documentation/git-hook.txt ##
     @@ Documentation/git-hook.txt: SYNOPSIS
    @@ builtin/hook.c: static const char * const builtin_hook_run_usage[] = {
     +
     +static int list(int argc, const char **argv, const char *prefix)
     +{
    -+	struct list_head *head, *pos;
    ++	struct list_head *hooks;
    ++	struct list_head *pos;
     +	const char *hookname = NULL;
    -+	struct strbuf hookdir_annotation = STRBUF_INIT;
    -+
     +	struct option list_options[] = {
     +		OPT_END(),
     +	};
    ++	int ret = 0;
     +
     +	argc = parse_options(argc, argv, prefix, list_options,
     +			     builtin_hook_list_usage, 0);
     +
    -+	if (argc < 1)
    ++	/*
    ++	 * The only unnamed argument provided should be the hook-name; if we add
    ++	 * arguments later they probably should be caught by parse_options.
    ++	 */
    ++	if (argc != 1)
     +		usage_msg_opt(_("You must specify a hook event name to list."),
     +			      builtin_hook_list_usage, list_options);
     +
     +	hookname = argv[0];
     +
    -+	head = hook_list(hookname);
    ++	hooks = list_hooks(hookname);
     +
    -+	if (list_empty(head))
    -+		return 1;
    ++	if (list_empty(hooks)) {
    ++		ret = 1;
    ++		goto cleanup;
    ++	}
     +
    -+	list_for_each(pos, head) {
    ++	list_for_each(pos, hooks) {
     +		struct hook *item = list_entry(pos, struct hook, list);
     +		item = list_entry(pos, struct hook, list);
     +		if (item)
     +			printf("%s\n", item->hook_path);
     +	}
     +
    -+	clear_hook_list(head);
    -+	strbuf_release(&hookdir_annotation);
    ++cleanup:
    ++	clear_hook_list(hooks);
     +
    -+	return 0;
    ++	return ret;
     +}
      static int run(int argc, const char **argv, const char *prefix)
      {
    @@ builtin/hook.c: int cmd_hook(int argc, const char **argv, const char *prefix)
      		return run(argc, argv, prefix);
      
     
    - ## hook.c ##
    -@@ hook.c: struct list_head *list_hooks(const char *hookname)
    - {
    - 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
    + ## t/t1800-hook.sh ##
    +@@ t/t1800-hook.sh: test_expect_success 'git hook usage' '
    + 	test_expect_code 129 git hook run &&
    + 	test_expect_code 129 git hook run -h &&
    + 	test_expect_code 129 git hook run --unknown 2>err &&
    ++	test_expect_code 129 git hook list &&
    ++	test_expect_code 129 git hook list -h &&
    + 	grep "unknown option" err
    + '
      
    -+
    - 	INIT_LIST_HEAD(hook_head);
    +@@ t/t1800-hook.sh: test_expect_success 'git hook run -- pass arguments' '
    + 	test_cmp expect actual
    + '
      
    - 	if (!hookname)
    -@@ hook.c: struct list_head *list_hooks(const char *hookname)
    - 
    - 	if (have_git_dir()) {
    - 		const char *hook_path = find_hook(hookname);
    --
    --		/* Add the hook from the hookdir */
    - 		if (hook_path) {
    - 			struct hook *to_add = xmalloc(sizeof(*to_add));
    - 			to_add->hook_path = hook_path;
    ++test_expect_success 'git hook list: does-not-exist hook' '
    ++	test_expect_code 1 git hook list does-not-exist
    ++'
    ++
    ++test_expect_success 'git hook list: existing hook' '
    ++	cat >expect <<-\EOF &&
    ++	.git/hooks/test-hook
    ++	EOF
    ++	git hook list test-hook >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    + test_expect_success 'git hook run -- out-of-repo runs excluded' '
    + 	write_script .git/hooks/test-hook <<-EOF &&
    + 	echo Test hook
4:  af14116d0fa < -:  ----------- hook: allow running non-native hooks
5:  2bbb179962e ! 4:  d0f5b30fb27 hook: include hooks from the config
    @@ Metadata
      ## Commit message ##
         hook: include hooks from the config
     
    -    Teach the hook.[hc] library to parse configs to populare the list of
    +    Teach the hook.[hc] library to parse configs to populate the list of
         hooks to run for a given event.
     
         Multiple commands can be specified for a given hook by providing
         multiple "hook.<friendly-name>.command = <path-to-hook>" and
    -    "hook.<friendly-name>.event = <hook-event>" lines. Hooks will be run in
    -    config order of the "hook.<name>.event" lines.
    +    "hook.<friendly-name>.event = <hook-event>" lines. Hooks will be started
    +    in config order of the "hook.<name>.event" lines (but may run in
    +    parallel).
     
         For example:
     
    -      $ git config --list | grep ^hook
    +      $ git config --get-regexp "^hook\."
           hook.bar.command=~/bar.sh
           hook.bar.event=pre-commit
     
    -      $ git hook run
    -      # Runs ~/bar.sh
    -      # Runs .git/hooks/pre-commit
    +      # Will run ~/bar.sh, then .git/hooks/pre-commit
    +      $ git hook run pre-commit
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
     
    @@ Documentation/config/hook.txt
      	hook execution. If unspecified, defaults to the number of processors on
     
      ## Documentation/git-hook.txt ##
    -@@ Documentation/git-hook.txt: Git is unlikely to use for a native hook later on. For example, Git is much less
    - likely to create a `mytool-validate-commit` hook than it is to create a
    - `validate-commit` hook.
    +@@ Documentation/git-hook.txt: This command is an interface to git hooks (see linkgit:githooks[5]).
    + Currently it only provides a convenience wrapper for running hooks for
    + use by git itself. In the future it might gain other functionality.
      
    -+This command parses the default configuration files for pairs of configs like
    ++It's possible to use this command to refer to hooks which are not native to Git,
    ++for example if a wrapper around Git wishes to expose hooks into its own
    ++operation in a way which is already familiar to Git users. However, wrappers
    ++invoking such hooks should be careful to name their hook events something which
    ++Git is unlikely to use for a native hook later on. For example, Git is much less
    ++likely to create a `mytool-validate-commit` hook than it is to create a
    ++`validate-commit` hook.
    ++
    ++This command parses the default configuration files for sets of configs like
     +so:
     +
     +  [hook "linter"]
     +    event = pre-commit
    -+    command = ~/bin/linter --c
    ++    command = ~/bin/linter --cpp20
     +
    -+In this example, `[hook "linter"]` represents one script - `~/bin/linter --c` -
    -+which can be shared by many repos, and even by many hook events, if appropriate.
    ++In this example, `[hook "linter"]` represents one script - `~/bin/linter
    ++--cpp20` - which can be shared by many repos, and even by many hook events, if
    ++appropriate.
    ++
    ++To add an unrelated hook which runs on a different event, for example a
    ++spell-checker for your commit messages, you would write a configuration like so:
    ++
    ++  [hook "linter"]
    ++    event = pre-commit
    ++    command = ~/bin/linter --cpp20
    ++  [hook "spellcheck"]
    ++    event = commit-msg
    ++    command = ~/bin/spellchecker
    ++
    ++With this config, when you run 'git commit', first `~/bin/linter --cpp20` will
    ++have a chance to check your files to be committed (during the `pre-commit` hook
    ++event`), and then `~/bin/spellchecker` will have a chance to check your commit
    ++message (during the `commit-msg` hook event).
     +
     +Commands are run in the order Git encounters their associated
     +`hook.<name>.event` configs during the configuration parse (see
    @@ Documentation/git-hook.txt: Git is unlikely to use for a native hook later on. F
     +  [hook "linter"]
     +    event = pre-commit
     +    event = pre-push
    -+    command = ~/bin/linter --c
    ++    command = ~/bin/linter --cpp20
     +
    -+With this config, `~/bin/linter --c` would be run by Git before a commit is
    ++With this config, `~/bin/linter --cpp20` would be run by Git before a commit is
     +generated (during `pre-commit`) as well as before a push is performed (during
     +`pre-push`).
     +
    @@ Documentation/git-hook.txt: Git is unlikely to use for a native hook later on. F
     +
     +  [hook "linter"]
     +    event = pre-commit
    -+    command = ~/bin/linter --c
    ++    command = ~/bin/linter --cpp20
     +  [hook "no-leaks"]
     +    event = pre-commit
     +    command = ~/bin/leak-detector
     +
     +With this config, before a commit is generated (during `pre-commit`), Git would
    -+first start `~/bin/linter --c` and second start `~/bin/leak-detector`. It would
    -+evaluate the output of each when deciding whether to proceed with the commit.
    ++first start `~/bin/linter --cpp20` and second start `~/bin/leak-detector`. It
    ++would evaluate the output of each when deciding whether to proceed with the
    ++commit.
     +
     +For a full list of hook events which you can set your `hook.<name>.event` to,
     +and how hooks are invoked during those events, see linkgit:githooks[5].
     +
    ++Git will ignore any `hook.<name>.event` that specifies an event it doesn't
    ++recognize. This is intended so that tools which wrap Git can use the hook
    ++infrastructure to run their own hooks; see <<WRAPPERS>> for more guidance.
    ++
     +In general, when instructions suggest adding a script to
    -+`.git/hooks/<hook-event>`, you can specify it in the config instead by running
    -+`git config --add hook.<some-name>.command <path-to-script> && git config --add
    -+hook.<some-name>.event <hook-event>` - this way you can share the script between
    -+multiple repos. That is, `cp ~/my-script.sh ~/project/.git/hooks/pre-commit`
    -+would become `git config --add hook.my-script.command ~/my-script.sh && git
    -+config --add hook.my-script.event pre-commit`.
    ++`.git/hooks/<hook-event>`, you can specify it in the config instead by running:
    ++
    ++----
    ++git config hook.<some-name>.command <path-to-script>
    ++git config --add hook.<some-name>.event <hook-event>
    ++----
    ++
    ++This way you can share the script between multiple repos. That is, `cp
    ++~/my-script.sh ~/project/.git/hooks/pre-commit` would become:
    ++
    ++----
    ++git config hook.my-script.command ~/my-script.sh
    ++git config --add hook.my-script.event pre-commit
    ++----
     +
      SUBCOMMANDS
      -----------
    @@ Documentation/git-hook.txt: Git is unlikely to use for a native hook later on. F
      +
      Any positional arguments to the hook should be passed after an
      optional `--` (or `--end-of-options`, see linkgit:gitcli[7]). The
    +@@ Documentation/git-hook.txt: config is not specified, uses the number of CPUs on the current system. Some
    + hooks may be ineligible for parallelization: for example, 'commit-msg' intends
    + hooks modify the commit message body and cannot be parallelized.
    + 
    ++[[WRAPPERS]]
    ++WRAPPERS
    ++--------
    ++
    ++`git hook run` has been designed to make it easy for tools which wrap Git to
    ++configure and execute hooks using the Git hook infrastructure. It is possible to
    ++provide arguments, environment variables (TODO this is missing from reroll TODO),
    ++and stdin via the command line, as well as specifying parallel or series
    ++execution if the user has provided multiple hooks.
    ++
    ++Assuming your wrapper wants to support a hook named "mywrapper-start-tests", you
    ++can have your users specify their hooks like so:
    ++
    ++  [hook "setup-test-dashboard"]
    ++    event = mywrapper-start-tests
    ++    command = ~/mywrapper/setup-dashboard.py --tap
    ++
    ++Then, in your 'mywrapper' tool, you can invoke any users' configured hooks by
    ++running:
    ++
    ++----
    ++git hook run mywrapper-start-tests \
    ++  # providing something to stdin
    ++  --stdin some-tempfile-123 \
    ++  # setting an env var (TODO THIS IS MISSING TODO)
    ++  --env MYWRAPPER_EXECUTION_MODE=foo \
    ++  # execute hooks in serial
    ++  --jobs 1 \
    ++  # plus some arguments of your own...
    ++  -- \
    ++  --testname bar \
    ++  baz
    ++----
    ++
    ++Take care to name your wrapper's hook events in a way which is unlikely to
    ++overlap with Git's native hooks (see linkgit:githooks[5]) - a hook event named
    ++`mywrappertool-validate-commit` is much less likely to be added to native Git
    ++than a hook event named `validate-commit`. If Git begins to use a hook event
    ++named the same thing as your wrapper hook, it may invoke your users' hooks in
    ++unintended and unsupported ways.
    ++
    + CONFIGURATION
    + -------------
    + include::config/hook.txt[]
     
      ## builtin/hook.c ##
     @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
    @@ builtin/hook.c: static int list(int argc, const char **argv, const char *prefix)
     +						  : _("hook from hookdir"));
      	}
      
    - 	clear_hook_list(head);
    + cleanup:
     
      ## hook.c ##
     @@ hook.c: static void free_hook(struct hook *ptr)
    + 	if (!ptr)
    + 		return;
    + 
    ++	free(ptr->name);
    + 	free(ptr->feed_pipe_cb_data);
      	free(ptr);
      }
      
    @@ hook.c: static void free_hook(struct hook *ptr)
     +
     +	if (!to_add) {
     +		/* adding a new hook, not moving an old one */
    -+		to_add = xmalloc(sizeof(*to_add));
    -+		to_add->name = name;
    -+		to_add->feed_pipe_cb_data = NULL;
    ++		to_add = xcalloc(1, sizeof(*to_add));
    ++		to_add->name = xstrdup_or_null(name);
     +	}
     +
     +	list_add_tail(&to_add->list, head);
    @@ hook.c: static void free_hook(struct hook *ptr)
      {
      	struct hook *hook_to_remove = list_entry(to_remove, struct hook, list);
     @@ hook.c: int hook_exists(const char *name)
    + 	return exists;
    + }
      
    - struct hook_config_cb
    - {
    --	struct strbuf *hook_key;
    ++struct hook_config_cb
    ++{
     +	const char *hook_event;
    - 	struct list_head *list;
    - };
    - 
    ++	struct list_head *list;
    ++};
    ++
     +/*
     + * Callback for git_config which adds configured hooks to a hook list.  Hooks
     + * can be configured by specifying both hook.<friend-name>.command = <path> and
    @@ hook.c: int hook_exists(const char *name)
     +	 */
     +	strbuf_add(&subsection_cpy, subsection, subsection_len);
     +
    -+	append_or_move_hook(data->list, strbuf_detach(&subsection_cpy, NULL));
    -+
    ++	append_or_move_hook(data->list, subsection_cpy.buf);
    ++	strbuf_release(&subsection_cpy);
     +
     +	return 0;
     +}
     +
      struct list_head *list_hooks(const char *hookname)
    - {
    - 	if (!known_hook(hookname))
    -@@ hook.c: struct list_head *list_hooks(const char *hookname)
    - struct list_head *list_hooks_gently(const char *hookname)
      {
      	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
     +	struct hook_config_cb cb_data = {
    @@ hook.c: struct list_head *list_hooks(const char *hookname)
      		BUG("null hookname was provided to hook_list()!");
      
     -	if (have_git_dir()) {
    --		const char *hook_path = find_hook_gently(hookname);
    +-		const char *hook_path = find_hook(hookname);
    ++	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
    ++	git_config(hook_config_lookup, &cb_data);
    + 
    +-		/* Add the hook from the hookdir */
     -		if (hook_path) {
     -			struct hook *to_add = xmalloc(sizeof(*to_add));
     -			to_add->hook_path = hook_path;
    @@ hook.c: struct list_head *list_hooks(const char *hookname)
     -			list_add_tail(&to_add->list, hook_head);
     -		}
     -	}
    -+	/* Add the hooks from the config, e.g. hook.myhook.event = pre-commit */
    -+	git_config(hook_config_lookup, &cb_data);
    -+
     +	/* Add the hook from the hookdir. The placeholder makes it easier to
     +	 * allocate work in pick_next_hook. */
    -+	if (find_hook_gently(hookname))
    ++	if (find_hook(hookname))
     +		append_or_move_hook(hook_head, NULL);
      
      	return hook_head;
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
      	cp->trace2_hook_name = hook_cb->hook_name;
      	cp->dir = hook_cb->options->dir;
      
    -+	/* to enable oneliners, let config-specified hooks run in shell.
    -+	 * config-specified hooks have a name. */
    ++	/*
    ++	 * to enable oneliners, let config-specified hooks run in shell.
    ++	 * config-specified hooks have a name.
    ++	 */
     +	cp->use_shell = !!run_me->name;
     +
      	/* add command */
    @@ hook.c: static int pick_next_hook(struct child_process *cp,
     +		}
     +
     +		strvec_push(&cp->args, command);
    ++		free(command);
    ++		strbuf_release(&cmd_key);
     +	} else {
     +		/* ...from hookdir. */
     +		const char *hook_path = NULL;
     +		/*
    -+		 *
     +		 * At this point we are already running, so don't validate
    -+		 * whether the hook name is known or not.
    ++		 * whether the hook name is known or not. Validation was
    ++		 * performed earlier in list_hooks().
     +		 */
    -+		hook_path = find_hook_gently(hook_cb->hook_name);
    ++		hook_path = find_hook(hook_cb->hook_name);
     +		if (!hook_path)
     +			BUG("hookdir hook in hook list but no hookdir hook present in filesystem");
     +
    @@ hook.c: static int notify_start_failure(struct strbuf *out,
      }
     
      ## hook.h ##
    -@@ hook.h: int hook_exists(const char *hookname);
    +@@
      
      struct hook {
      	struct list_head list;
    @@ hook.h: int hook_exists(const char *hookname);
     +	 * The friendly name of the hook. NULL indicates the hook is from the
     +	 * hookdir.
     +	 */
    -+	const char *name;
    ++	char *name;
      
      	/*
      	 * Use this to keep state for your feed_pipe_fn if you are using
     
      ## t/t1800-hook.sh ##
     @@
    - #!/bin/bash
    + #!/bin/sh
      
     -test_description='git-hook command'
     +test_description='git-hook command and config-managed multihooks'
    @@ t/t1800-hook.sh
      . ./test-lib.sh
      
     +setup_hooks () {
    ++	test_config hook.ghi.command "/path/ghi"
     +	test_config hook.ghi.event pre-commit --add
    -+	test_config hook.ghi.command "/path/ghi" --add
    ++	test_config hook.ghi.event test-hook --add
    ++	test_config_global hook.def.command "/path/def"
     +	test_config_global hook.def.event pre-commit --add
    -+	test_config_global hook.def.command "/path/def" --add
     +}
     +
     +setup_hookdir () {
    @@ t/t1800-hook.sh
      	test_expect_code 129 git hook run -h &&
     +	test_expect_code 129 git hook list -h &&
      	test_expect_code 129 git hook run --unknown 2>err &&
    - 	grep "unknown option" err
    - '
    + 	test_expect_code 129 git hook list &&
    + 	test_expect_code 129 git hook list -h &&
    +@@ t/t1800-hook.sh: test_expect_success 'git hook list: does-not-exist hook' '
    + 
    + test_expect_success 'git hook list: existing hook' '
    + 	cat >expect <<-\EOF &&
    +-	.git/hooks/test-hook
    ++	hook from hookdir
    + 	EOF
    + 	git hook list test-hook >actual &&
    + 	test_cmp expect actual
     @@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
      	test_cmp expect actual
      '
    @@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
     +test_expect_success 'git hook list orders by config order' '
     +	setup_hooks &&
     +
    -+	cat >expected <<-EOF &&
    ++	cat >expected <<-\EOF &&
     +	def
     +	ghi
     +	EOF
    @@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
     +	# configuring it locally.
     +	test_config hook.def.event "pre-commit" --add &&
     +
    -+	cat >expected <<-EOF &&
    ++	cat >expected <<-\EOF &&
     +	ghi
     +	def
     +	EOF
    @@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
     +	test_cmp expected actual
     +'
     +
    ++test_expect_success 'hook can be configured for multiple events' '
    ++	setup_hooks &&
    ++
    ++	# 'ghi' should be included in both 'pre-commit' and 'test-hook'
    ++	git hook list pre-commit >actual &&
    ++	grep "ghi" actual &&
    ++	git hook list test-hook >actual &&
    ++	grep "ghi" actual
    ++'
    ++
     +test_expect_success 'git hook list shows hooks from the hookdir' '
     +	setup_hookdir &&
     +
    -+	cat >expected <<-EOF &&
    ++	cat >expected <<-\EOF &&
     +	hook from hookdir
     +	EOF
     +
    @@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
     +'
     +
     +test_expect_success 'inline hook definitions resolve paths' '
    -+	write_script sample-hook.sh <<-EOF &&
    ++	write_script sample-hook.sh <<-\EOF &&
     +	echo \"Sample Hook\"
     +	EOF
     +
    @@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
     +	test_config hook.stdin-b.event "test-hook" --add &&
     +	test_config hook.stdin-b.command "xargs -P1 -I% echo b%" --add &&
     +
    -+	cat >input <<-EOF &&
    ++	cat >input <<-\EOF &&
     +	1
     +	2
     +	3
     +	EOF
     +
    -+	cat >expected <<-EOF &&
    ++	cat >expected <<-\EOF &&
     +	a1
     +	a2
     +	a3
    @@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
     +	echo 3
     +	EOF
     +
    -+	cat >expected <<-EOF &&
    ++	cat >expected <<-\EOF &&
     +	1
     +	2
     +	3
    @@ t/t1800-hook.sh: test_expect_success 'stdin to hooks' '
     +
     +	rm -rf .git/hooks
     +'
    ++
    ++test_expect_success 'rejects hooks with no commands configured' '
    ++	test_config hook.broken.event "test-hook" &&
    ++
    ++	echo broken >expected &&
    ++	git hook list test-hook >actual &&
    ++	test_cmp expected actual &&
    ++	test_must_fail git hook run test-hook
    ++'
    ++
      test_done
6:  30ffe98601e ! 5:  5d5e9726fd8 hook: allow out-of-repo 'git hook' invocations
    @@ git.c: static struct cmd_struct commands[] = {
      	{ "init-db", cmd_init_db },
     
      ## hook.c ##
    -@@ hook.c: struct list_head *list_hooks_gently(const char *hookname)
    +@@ hook.c: struct list_head *list_hooks(const char *hookname)
      
      	/* Add the hook from the hookdir. The placeholder makes it easier to
      	 * allocate work in pick_next_hook. */
    --	if (find_hook_gently(hookname))
    -+	if (have_git_dir() && find_hook_gently(hookname))
    +-	if (find_hook(hookname))
    ++	if (have_git_dir() && find_hook(hookname))
      		append_or_move_hook(hook_head, NULL);
      
      	return hook_head;
     
      ## t/t1800-hook.sh ##
    -@@ t/t1800-hook.sh: test_expect_success 'git hook run -- pass arguments' '
    +@@ t/t1800-hook.sh: test_expect_success 'git hook list: existing hook' '
      	test_cmp expect actual
      '
      
-- 
2.33.0.867.g88ec4638586

