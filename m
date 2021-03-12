Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184C7C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA4664FB9
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 09:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhCLJuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 04:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbhCLJtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 04:49:42 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCEDC061761
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:49:42 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y6so7036630eds.1
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 01:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0cgQid27yW27RfNlxjhQ83Fb1qnjNpXL5QjPRZ0rBZ8=;
        b=MQZeH7/q7EWiu2fz+mDPf/KnZWOXBa+toWhfa2ZcOiDAXietzVU5DLNSabTHnix+iQ
         VwDS6+jRE5l946sO95cUvKDw2qU/SzcTs/FYSBCgLhfXmtreRdc1RyU4jG43aQTZpxbV
         VuLIWPYwimekg/NOc0e0nnMeNn7GZdMeF3GJ2t97XdeREkKTsTAW3wsxOEN0Oii39j8B
         K3/6PqWdIAfxJ4je42sHr1LoV/hxqCPGLeNdvZW8dBhv6U0jscSOoVJRxJEOPoqzG7E8
         +Le+lkYrg+HyyE34hfLYmUC9Qar4Uj3F95xyJLAqlS/KHzvOK4UrmO7PF3IfQI4jOKum
         JxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0cgQid27yW27RfNlxjhQ83Fb1qnjNpXL5QjPRZ0rBZ8=;
        b=XKkKyGkFtxBzmtukbi+IUpHFxHjg2/HERTIRSG/Y2ht8qaIt9J2Xm+cIZ44XXc5Y0z
         I7WhYHgPfuOMMo0LjMzMDi25klsLVKuy+sEg5xGZoRZs9Yray5YZfzDzab8f4IUlwvrX
         kHUc6+Z3mpLDkzOyE4KllnyWpfsvG6uUDDjSZw+bhWTMzcxSkdtC/VGhpVeOFupMljXF
         czLEqa4FD5wBoYdZf+KwtT9LHdLsvKbDuq4ciB24jbjdd+IqpC1f7bmc7wwfYX5RyQxV
         /xoSYd7iFZhyXtWLl5MDRAQ3SefaYuYeUaRHsB39N+VsZBPTzy8RbYxcaXHQDcCATi7k
         7uYg==
X-Gm-Message-State: AOAM532aSbk6Fb3jCe76+SKZm5cJDLleyZY3mX6Qs0SNwYzUK0zG2+hY
        Clvaqe7yUOWATwLM0oNxVooW/nJ+tg8H9g==
X-Google-Smtp-Source: ABdhPJxapELgZIiPYQXt76nJNb1Tj71nQB5OwNuVElA1Mf0wmx2neRhIjRHYK1yUQp+8aA8bZl1l9A==
X-Received: by 2002:a05:6402:51d4:: with SMTP id r20mr13182957edd.112.1615542580326;
        Fri, 12 Mar 2021 01:49:40 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j25sm2724254edy.9.2021.03.12.01.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:49:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v8 00/37] config-based hooks
References: <20210311021037.3001235-1-emilyshaffer@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210311021037.3001235-1-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 10:49:38 +0100
Message-ID: <87pn04g0r1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 11 2021, Emily Shaffer wrote:

> Since v7:
> - Addressed Jonathan Tan's review of part I
> - Addressed Junio's review of part I and II
> - Combined parts I and II
>
> I think the updates to patch 1 between the rest of the work I've been
> doing probably have covered =C3=86var's comments.

A range-diff between iterations of such a large series would be most
useful. Do you have a public repo with tags or whatever the different
versions, for those who'd like an easier way to follow along the
differing versions than scraping the ML archive?

While reading this I came up with the following fixup patches on top,
for discussion, maybe not something you want as-is:
=09
	 Documentation/git-hook.txt |  8 +++++
	 builtin/bugreport.c        |  8 +++--
	 builtin/commit.c           |  3 +-
	 builtin/hook.c             | 79 ++++++++++++++++++++---------------------=
-----
	 builtin/merge.c            |  3 +-
	 builtin/receive-pack.c     | 11 +++----
	 hook.c                     | 21 +++++-------
	 hook.h                     |  5 +--
	 refs.c                     |  4 ++-
	 sequencer.c                |  4 ++-
	 10 files changed, 73 insertions(+), 73 deletions(-)
=09
	diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
	index 4ad31ac360a..5c9af30b43e 100644
	--- a/Documentation/git-hook.txt
	+++ b/Documentation/git-hook.txt
	@@ -150,10 +150,18 @@ message body and cannot be parallelized.
=09=20
	 CONFIGURATION
	 -------------
	+
	+The below documentation is the same as what's found in
	+linkgit:git-config[1]:
	+
	 include::config/hook.txt[]
=09=20
	 HOOKS
	 -----
	+
	+The below documentation is the same as what's found in
	+linkgit:githooks[5]:
	+
	 include::native-hooks.txt[]
=09=20
Noted in another reply, including it here for completeness.

	 GIT
	diff --git a/builtin/bugreport.c b/builtin/bugreport.c
	index 04467cd1d3a..b64e53fd625 100644
	--- a/builtin/bugreport.c
	+++ b/builtin/bugreport.c
	@@ -81,9 +81,13 @@ static void get_populated_hooks(struct strbuf *hook_inf=
o, int nongit)
	 		return;
	 	}
=09=20
	-	for (i =3D 0; i < ARRAY_SIZE(hook); i++)
	-		if (hook_exists(hook[i], HOOKDIR_USE_CONFIG))
	+	for (i =3D 0; i < ARRAY_SIZE(hook); i++) {
	+		struct strbuf config;
	+		strbuf_addf(&config, "hook.%s.config", hook[i]);
	+		if (hook_exists(hook[i], config.buf, HOOKDIR_USE_CONFIG))
	 			strbuf_addf(hook_info, "%s\n", hook[i]);
	+		strbuf_release(&config);
	+	}
	 }

Less strbuf, see below.
=09=20
	 static const char * const bugreport_usage[] =3D {
	diff --git a/builtin/commit.c b/builtin/commit.c
	index 31df571f123..fc9f1f5ee58 100644
	--- a/builtin/commit.c
	+++ b/builtin/commit.c
	@@ -984,7 +984,8 @@ static int prepare_to_commit(const char *index_file, c=
onst char *prefix,
	 		return 0;
	 	}
=09=20
	-	if (!no_verify && hook_exists("pre-commit", HOOKDIR_USE_CONFIG)) {
	+	if (!no_verify && hook_exists("pre-commit", "hook.pre-commit.command",
	+				      HOOKDIR_USE_CONFIG)) {
	 		/*
	 		 * Re-read the index as pre-commit hook could have updated it,
	 		 * and write it out as a tree.  We must do this before we invoke


..ditto.

	diff --git a/builtin/hook.c b/builtin/hook.c
	index b4f4adb1dea..d0b56ee47f8 100644
	--- a/builtin/hook.c
	+++ b/builtin/hook.c
	@@ -18,8 +18,6 @@ static enum hookdir_opt should_run_hookdir;
	 static int list(int argc, const char **argv, const char *prefix)
	 {
	 	struct list_head *head, *pos;
	-	struct strbuf hookname =3D STRBUF_INIT;
	-	struct strbuf hookdir_annotation =3D STRBUF_INIT;
=09=20
	 	struct option list_options[] =3D {
	 		OPT_END(),
	@@ -33,67 +31,60 @@ static int list(int argc, const char **argv, const cha=
r *prefix)
	 			      builtin_hook_usage, list_options);
	 	}
=09=20
	-	strbuf_addstr(&hookname, argv[0]);
	-
	-	head =3D hook_list(&hookname);
	+	head =3D hook_list(argv[0]);
=09=20
	 	if (list_empty(head)) {
	 		printf(_("no commands configured for hook '%s'\n"),
	-		       hookname.buf);
	-		strbuf_release(&hookname);
	+		       argv[0]);
	 		return 0;
	 	}
=09=20
	-	switch (should_run_hookdir) {
	-		case HOOKDIR_NO:
	-			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
	-			break;
	-		case HOOKDIR_ERROR:
	-			strbuf_addstr(&hookdir_annotation, _(" (will error and not run)"));
	-			break;
	-		case HOOKDIR_INTERACTIVE:
	-			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
	-			break;
	-		case HOOKDIR_WARN:
	-			strbuf_addstr(&hookdir_annotation, _(" (will warn but run)"));
	-			break;
	-		case HOOKDIR_YES:
	-		/*
	-		 * The default behavior should agree with
	-		 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
	-		 * do the default behavior.
	-		 */
	-		case HOOKDIR_UNKNOWN:
	-		default:
	-			break;
	-	}
	-
	 	list_for_each(pos, head) {
	 		struct hook *item =3D list_entry(pos, struct hook, list);
	 		item =3D list_entry(pos, struct hook, list);
	 		if (item) {
	-			/* Don't translate 'hookdir' - it matches the config */
	-			printf("%s: %s%s\n",
	-			       (item->from_hookdir
	+			const char *scope =3D item->from_hookdir
	 				? "hookdir"
	-				: config_scope_name(item->origin)),
	-			       item->command.buf,
	-			       (item->from_hookdir
	-				? hookdir_annotation.buf
	-				: ""));
	+				: config_scope_name(item->origin);
	+			switch (should_run_hookdir) {
	+			case HOOKDIR_NO:
	+				printf(_("%s: %s (will not run)\n"),
	+				       scope, item->command.buf);
	+				break;
	+			case HOOKDIR_ERROR:
	+				printf(_("%s: %s (will error and not run)\n"),
	+				       scope, item->command.buf);
	+				break;
	+			case HOOKDIR_INTERACTIVE:
	+				printf(_("%s: %s (will prompt)\n"),
	+				       scope, item->command.buf);
	+				break;
	+			case HOOKDIR_WARN:
	+				printf(_("%s: %s (will warn but run)\n"),
	+				       scope, item->command.buf);
	+				break;
	+			case HOOKDIR_YES:
	+				/*
	+				 * The default behavior should agree with
	+				 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
	+				 * do the default behavior.
	+				 */
	+			case HOOKDIR_UNKNOWN:
	+			default:
	+				printf(_("%s: %s\n"),
	+				       scope, item->command.buf);
	+				break;
	+			}
	 		}
	 	}
=09=20
	 	clear_hook_list(head);
	-	strbuf_release(&hookdir_annotation);
	-	strbuf_release(&hookname);
=09=20
	 	return 0;
	 }

I think this is better to avoid i18n lego, as noted in another reply
(but I didn't include the patch).

More on strbuf below:
=09=20
	 static int run(int argc, const char **argv, const char *prefix)
	 {
	-	struct strbuf hookname =3D STRBUF_INIT;
	 	struct run_hooks_opt opt;
	 	int rc =3D 0;
=09=20
	@@ -118,12 +109,10 @@ static int run(int argc, const char **argv, const ch=
ar *prefix)
	 		usage_msg_opt(_("You must specify a hook event to run."),
	 			      builtin_hook_usage, run_options);
=09=20
	-	strbuf_addstr(&hookname, argv[0]);
	 	opt.run_hookdir =3D should_run_hookdir;
=09=20
	-	rc =3D run_hooks(hookname.buf, &opt);
	+	rc =3D run_hooks(argv[0], &opt);
=09=20
	-	strbuf_release(&hookname);
	 	run_hooks_opt_clear(&opt);
=09=20
	 	return rc;
	diff --git a/builtin/merge.c b/builtin/merge.c
	index 3a2af257a6b..df4ff72fbc7 100644
	--- a/builtin/merge.c
	+++ b/builtin/merge.c
	@@ -848,7 +848,8 @@ static void prepare_to_commit(struct commit_list *remo=
teheads)
	 	 * and write it out as a tree.  We must do this before we invoke
	 	 * the editor and after we invoke run_status above.
	 	 */
	-	if (hook_exists("pre-merge-commit", HOOKDIR_USE_CONFIG))
	+	if (hook_exists("pre-merge-commit", "hook.pre-merge-commit.command",
	+			HOOKDIR_USE_CONFIG))
	 		discard_cache();
	 	read_cache_from(index_file);
	 	strbuf_addbuf(&msg, &merge_msg);
	diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
	index eaedeeb1e8b..a76069ea592 100644
	--- a/builtin/receive-pack.c
	+++ b/builtin/receive-pack.c
	@@ -1123,12 +1123,10 @@ static int run_proc_receive_hook(struct command *c=
ommands,
	 	int version =3D 0;
	 	int code;
=09=20
	-	struct strbuf hookname =3D STRBUF_INIT;
	 	struct hook *proc_receive =3D NULL;
	 	struct list_head *pos, *hooks;
=09=20
	-	strbuf_addstr(&hookname, "proc-receive");
	-	hooks =3D hook_list(&hookname);
	+	hooks =3D hook_list("proc-receive");
=09=20
	 	list_for_each(pos, hooks) {
	 		if (proc_receive) {
	@@ -1460,8 +1458,6 @@ static const char *push_to_deploy(unsigned char *sha=
1,
	 	return NULL;
	 }
=09=20
	-static const char *push_to_checkout_hook =3D "push-to-checkout";
	-
	 static const char *push_to_checkout(unsigned char *hash,
	 				    struct strvec *env,
	 				    const char *work_tree)
	@@ -1472,7 +1468,7 @@ static const char *push_to_checkout(unsigned char *h=
ash,
	 	strvec_pushf(env, "GIT_WORK_TREE=3D%s", absolute_path(work_tree));
	 	strvec_pushv(&opt.env, env->v);
	 	strvec_push(&opt.args, hash_to_hex(hash));
	-	if (run_hooks(push_to_checkout_hook, &opt)) {
	+	if (run_hooks("push-to-checkout", &opt)) {
	 		run_hooks_opt_clear(&opt);
	 		return "push-to-checkout hook declined";
	 	} else {
	@@ -1502,7 +1498,8 @@ static const char *update_worktree(unsigned char *sh=
a1, const struct worktree *w
=09=20
	 	strvec_pushf(&env, "GIT_DIR=3D%s", absolute_path(git_dir));
=09=20
	-	if (!hook_exists(push_to_checkout_hook, HOOKDIR_USE_CONFIG))
	+	if (!hook_exists("push-to-checkout", "hook.push-to-checkout.command",
	+			 HOOKDIR_USE_CONFIG))
	 		retval =3D push_to_deploy(sha1, &env, work_tree);
	 	else
	 		retval =3D push_to_checkout(sha1, &env, work_tree);
	diff --git a/hook.c b/hook.c
	index 7f6f3b9a616..49c3861ce00 100644
	--- a/hook.c
	+++ b/hook.c
	@@ -247,7 +247,7 @@ static const char *find_legacy_hook(const char *name)
	 }
=09=20
=09=20
	-struct list_head* hook_list(const struct strbuf* hookname)
	+struct list_head* hook_list(const char *hookname)
	 {
	 	struct strbuf hook_key =3D STRBUF_INIT;
	 	struct list_head *hook_head =3D xmalloc(sizeof(struct list_head));
	@@ -256,14 +256,14 @@ struct list_head* hook_list(const struct strbuf* hoo=
kname)
	 	INIT_LIST_HEAD(hook_head);
=09=20
	 	if (!hookname)
	-		return NULL;
	+		BUG("???");;
=09=20
	-	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
	+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
=09=20
	 	git_config(hook_config_lookup, &cb_data);
=09=20
	 	if (have_git_dir()) {
	-		const char *legacy_hook_path =3D find_legacy_hook(hookname->buf);
	+		const char *legacy_hook_path =3D find_legacy_hook(hookname);
=09=20
	 		/* Unconditionally add legacy hook, but annotate it. */
	 		if (legacy_hook_path) {
	@@ -300,10 +300,10 @@ void run_hooks_opt_init_async(struct run_hooks_opt *=
o)
	 	o->jobs =3D configured_hook_jobs();
	 }
=09=20
	-int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
	+int hook_exists(const char *hookname, const char *hook_config,
	+		enum hookdir_opt should_run_hookdir)
	 {
	 	const char *value =3D NULL; /* throwaway */
	-	struct strbuf hook_key =3D STRBUF_INIT;
	 	int could_run_hookdir;
=09=20
	 	if (should_run_hookdir =3D=3D HOOKDIR_USE_CONFIG)
	@@ -314,9 +314,7 @@ int hook_exists(const char *hookname, enum hookdir_opt=
 should_run_hookdir)
	 				should_run_hookdir =3D=3D HOOKDIR_YES)
	 				&& !!find_legacy_hook(hookname);
=09=20
	-	strbuf_addf(&hook_key, "hook.%s.command", hookname);
	-
	-	return (!git_config_get_value(hook_key.buf, &value)) || could_run_hookdi=
r;
	+	return (!git_config_get_value(hook_config, &value)) || could_run_hookdir;
	 }
=09=20
	 void run_hooks_opt_clear(struct run_hooks_opt *o)
	@@ -438,7 +436,6 @@ static int notify_hook_finished(int result,
=09=20
	 int run_hooks(const char *hookname, struct run_hooks_opt *options)
	 {
	-	struct strbuf hookname_str =3D STRBUF_INIT;
	 	struct list_head *to_run, *pos =3D NULL, *tmp =3D NULL;
	 	struct hook_cb_data cb_data =3D { 0, NULL, NULL, options };
=09=20
	@@ -448,9 +445,7 @@ int run_hooks(const char *hookname, struct run_hooks_o=
pt *options)
	 	if (options->path_to_stdin && options->feed_pipe)
	 		BUG("choose only one method to populate stdin");
=09=20
	-	strbuf_addstr(&hookname_str, hookname);
	-
	-	to_run =3D hook_list(&hookname_str);
	+	to_run =3D hook_list(hookname);
=09=20
	 	list_for_each_safe(pos, tmp, to_run) {
	 		struct hook *hook =3D list_entry(pos, struct hook, list);
	diff --git a/hook.h b/hook.h
	index 4ff9999b049..bfbbf36882d 100644
	--- a/hook.h
	+++ b/hook.h
	@@ -26,7 +26,7 @@ struct hook {
	  * Provides a linked list of 'struct hook' detailing commands which shoul=
d run
	  * in response to the 'hookname' event, in execution order.
	  */
	-struct list_head* hook_list(const struct strbuf *hookname);
	+struct list_head* hook_list(const char *hookname);
=09=20
	 enum hookdir_opt
	 {
	@@ -123,7 +123,8 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
	  * Like with run_hooks, if you take a --run-hookdir flag, reflect that
	  * user-specified behavior here instead.
	  */
	-int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir=
);
	+int hook_exists(const char *hookname, const char *hook_config,
	+		enum hookdir_opt should_run_hookdir);
=09=20
	 /*
	  * Runs all hooks associated to the 'hookname' event in order. Each hook =
will be
	diff --git a/refs.c b/refs.c
	index 334fdd9103c..f01995fe64f 100644
	--- a/refs.c
	+++ b/refs.c
	@@ -1966,7 +1966,9 @@ static int run_transaction_hook(struct ref_transacti=
on *transaction,
=09=20
	 	run_hooks_opt_init_async(&opt);
=09=20
	-	if (!hook_exists("reference-transaction", HOOKDIR_USE_CONFIG))
	+	if (!hook_exists("reference-transaction",
	+			 "hook.reference-transaction.command",
	+			 HOOKDIR_USE_CONFIG))
	 		return ret;
=09=20
	 	strvec_push(&opt.args, state);
	diff --git a/sequencer.c b/sequencer.c
	index 34ff275f0d1..52c067c1688 100644
	--- a/sequencer.c
	+++ b/sequencer.c
	@@ -1436,7 +1436,9 @@ static int try_to_commit(struct repository *r,
	 		}
	 	}
=09=20
	-	if (hook_exists("prepare-commit-msg", HOOKDIR_USE_CONFIG)) {
	+	if (hook_exists("prepare-commit-msg",
	+			"hook.prepare-commit-msg.command",
	+			HOOKDIR_USE_CONFIG)) {
	 		res =3D run_prepare_commit_msg_hook(r, msg, hook_commit);
	 		if (res)
	 			goto out;

There was another reply (from JT I believe, but didn't go back and look
it up) about the over use of strbuf.

I tend to agree, as much as I love the API it's really not better to
write C with it if all you need is a const char* that's never modified,
particularly if you get it from elsewhere.

So it's really not meant for or good for "everything we need a const
char*", but to avoid verbose realloc() dances all over the place, and
for things like getline() loops without a hardcoded buffer size.

E.g. in the first hunk here we're creating a strbuf just to copy argv[0]
to it, and then throwing it away, let's just pass down argv[0].

For hook_exists I think just having the code more grep-able and having
the config value inline is better, but I admit that's a matter of taste.

I didn't try to find all such strbuf() occurrences, anyway, in the
overall scheme of things it's a relatively small nit.

I'm hoping to do some deeper diving into this series, in particular the
parallelism, but just sending the shallow-ish comments I have for now.

Thanks for working on this!
