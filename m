Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D1EC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC62164F51
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhCQSmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhCQSmH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:42:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354FEC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:42:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v8so18264plz.10
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+hxP03J/fugs1C6YeGYOg1m/NHf02gbWULsgzMKwYaY=;
        b=p4x+dkgBK5yGoAmC8UGmKnr+hw0zfGuMW1U4P9aScCQM6Khb9mtMphif2GauPNj3WY
         Tgj3IVyKSixI7hhJouOytTGsm+UDK2kHwpvQq/jpqgu+tes15lTM15V8ztsUjRtovCr/
         0c8c8iipFM4DdpJZ9nzWk0abwMoD+y+nqgZJDnWvYaw2c/85E5w6aHrwNU9EKVr2oal9
         IgUYnsVG7BiUZTUB3J1cpovIhHmpeWdMrZ1EkEdkupywlyG31yY6fuM3u689YIR+pVMV
         fooTfwVH4iAJplgmlIFou1RNpsF3wlWtx6e6xfBldmI0uTP1CmMmFVEztye6KeIxPS3j
         hfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+hxP03J/fugs1C6YeGYOg1m/NHf02gbWULsgzMKwYaY=;
        b=GB0t6tHzQVDIAyo0Hj9SJRNHm1hr4sgyGSbiCBcVcJsjrVOQCp/tD1SW6pco05KK0l
         JhiwZ+Bk4JN8OhCZGexYaUsItoAtw+iFcVT5BynpbYnpSSK82g7df6S3HZPZB5lIqxxE
         JDov4bsVkAxe28J/ZF4wypXbZebSlDKzUUiY7l/Fl820Mx9q1VNNVf3xIJYnyDsJfKz5
         rFIi6Z2lr4vn8PFfyY+0NKbI4uZvDKGomAuT585tkNbvH/gnCkQ3Z84IE3ej2BbeyPqC
         zWCD7ek9h34TGkmQyMTVbeyRADV0Qtzahh742UpQAKjmpBNU2dtFwgWg5ZHRPvDi0kKs
         etnQ==
X-Gm-Message-State: AOAM532RbBHcj4ciG1B7Gx8RRzciC/u9Y/TqBaP4dvCTYxemBmaPtxZ1
        WSFIct/MFAO1teU8nd0L8fJJVQ==
X-Google-Smtp-Source: ABdhPJzHh1gpvX6xBDM/nb51ngdUldV19Eh4ezdJq6oKKQPBGS/s5V1RI7Ow8iI+BKPsrlLMMbIAhw==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr242532pjt.30.1616006526293;
        Wed, 17 Mar 2021 11:42:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:51f7:2133:700b:3769])
        by smtp.gmail.com with ESMTPSA id d14sm3808385pji.22.2021.03.17.11.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:42:05 -0700 (PDT)
Date:   Wed, 17 Mar 2021 11:41:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
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
Message-ID: <YFJNd6an0eGRC4/p@google.com>
References: <20210311021037.3001235-1-emilyshaffer@google.com>
 <87pn04g0r1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pn04g0r1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 10:49:38AM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Thu, Mar 11 2021, Emily Shaffer wrote:
> 
> > Since v7:
> > - Addressed Jonathan Tan's review of part I
> > - Addressed Junio's review of part I and II
> > - Combined parts I and II
> >
> > I think the updates to patch 1 between the rest of the work I've been
> > doing probably have covered Ævar's comments.
> 
> A range-diff between iterations of such a large series would be most
> useful. Do you have a public repo with tags or whatever the different
> versions, for those who'd like an easier way to follow along the
> differing versions than scraping the ML archive?

I am really embarrassed to say that I don't have the
branches/tags/whatever up. I have not succeeded in building that habit
yet. I'll generate one from my local patches today and send it here.

> 
> While reading this I came up with the following fixup patches on top,
> for discussion, maybe not something you want as-is:

I was a little bit confused reading this fixup without seeing the rest of your
review, so I'll revisit this once I get through what else you wrote.

> 	
> 	 Documentation/git-hook.txt |  8 +++++
> 	 builtin/bugreport.c        |  8 +++--
> 	 builtin/commit.c           |  3 +-
> 	 builtin/hook.c             | 79 ++++++++++++++++++++--------------------------
> 	 builtin/merge.c            |  3 +-
> 	 builtin/receive-pack.c     | 11 +++----
> 	 hook.c                     | 21 +++++-------
> 	 hook.h                     |  5 +--
> 	 refs.c                     |  4 ++-
> 	 sequencer.c                |  4 ++-
> 	 10 files changed, 73 insertions(+), 73 deletions(-)
> 	
> 	diff --git a/Documentation/git-hook.txt b/Documentation/git-hook.txt
> 	index 4ad31ac360a..5c9af30b43e 100644
> 	--- a/Documentation/git-hook.txt
> 	+++ b/Documentation/git-hook.txt
> 	@@ -150,10 +150,18 @@ message body and cannot be parallelized.
> 	 
> 	 CONFIGURATION
> 	 -------------
> 	+
> 	+The below documentation is the same as what's found in
> 	+linkgit:git-config[1]:
> 	+
> 	 include::config/hook.txt[]
> 	 
> 	 HOOKS
> 	 -----
> 	+
> 	+The below documentation is the same as what's found in
> 	+linkgit:githooks[5]:
> 	+
> 	 include::native-hooks.txt[]
> 	 
> Noted in another reply, including it here for completeness.
> 
> 	 GIT
> 	diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> 	index 04467cd1d3a..b64e53fd625 100644
> 	--- a/builtin/bugreport.c
> 	+++ b/builtin/bugreport.c
> 	@@ -81,9 +81,13 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> 	 		return;
> 	 	}
> 	 
> 	-	for (i = 0; i < ARRAY_SIZE(hook); i++)
> 	-		if (hook_exists(hook[i], HOOKDIR_USE_CONFIG))
> 	+	for (i = 0; i < ARRAY_SIZE(hook); i++) {
> 	+		struct strbuf config;
> 	+		strbuf_addf(&config, "hook.%s.config", hook[i]);
> 	+		if (hook_exists(hook[i], config.buf, HOOKDIR_USE_CONFIG))
> 	 			strbuf_addf(hook_info, "%s\n", hook[i]);
> 	+		strbuf_release(&config);
> 	+	}
> 	 }
> 
> Less strbuf, see below.
> 	 
> 	 static const char * const bugreport_usage[] = {
> 	diff --git a/builtin/commit.c b/builtin/commit.c
> 	index 31df571f123..fc9f1f5ee58 100644
> 	--- a/builtin/commit.c
> 	+++ b/builtin/commit.c
> 	@@ -984,7 +984,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> 	 		return 0;
> 	 	}
> 	 
> 	-	if (!no_verify && hook_exists("pre-commit", HOOKDIR_USE_CONFIG)) {
> 	+	if (!no_verify && hook_exists("pre-commit", "hook.pre-commit.command",
> 	+				      HOOKDIR_USE_CONFIG)) {
> 	 		/*
> 	 		 * Re-read the index as pre-commit hook could have updated it,
> 	 		 * and write it out as a tree.  We must do this before we invoke
> 
> 
> ..ditto.
> 
> 	diff --git a/builtin/hook.c b/builtin/hook.c
> 	index b4f4adb1dea..d0b56ee47f8 100644
> 	--- a/builtin/hook.c
> 	+++ b/builtin/hook.c
> 	@@ -18,8 +18,6 @@ static enum hookdir_opt should_run_hookdir;
> 	 static int list(int argc, const char **argv, const char *prefix)
> 	 {
> 	 	struct list_head *head, *pos;
> 	-	struct strbuf hookname = STRBUF_INIT;
> 	-	struct strbuf hookdir_annotation = STRBUF_INIT;
> 	 
> 	 	struct option list_options[] = {
> 	 		OPT_END(),
> 	@@ -33,67 +31,60 @@ static int list(int argc, const char **argv, const char *prefix)
> 	 			      builtin_hook_usage, list_options);
> 	 	}
> 	 
> 	-	strbuf_addstr(&hookname, argv[0]);
> 	-
> 	-	head = hook_list(&hookname);
> 	+	head = hook_list(argv[0]);
> 	 
> 	 	if (list_empty(head)) {
> 	 		printf(_("no commands configured for hook '%s'\n"),
> 	-		       hookname.buf);
> 	-		strbuf_release(&hookname);
> 	+		       argv[0]);
> 	 		return 0;
> 	 	}
> 	 
> 	-	switch (should_run_hookdir) {
> 	-		case HOOKDIR_NO:
> 	-			strbuf_addstr(&hookdir_annotation, _(" (will not run)"));
> 	-			break;
> 	-		case HOOKDIR_ERROR:
> 	-			strbuf_addstr(&hookdir_annotation, _(" (will error and not run)"));
> 	-			break;
> 	-		case HOOKDIR_INTERACTIVE:
> 	-			strbuf_addstr(&hookdir_annotation, _(" (will prompt)"));
> 	-			break;
> 	-		case HOOKDIR_WARN:
> 	-			strbuf_addstr(&hookdir_annotation, _(" (will warn but run)"));
> 	-			break;
> 	-		case HOOKDIR_YES:
> 	-		/*
> 	-		 * The default behavior should agree with
> 	-		 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
> 	-		 * do the default behavior.
> 	-		 */
> 	-		case HOOKDIR_UNKNOWN:
> 	-		default:
> 	-			break;
> 	-	}
> 	-
> 	 	list_for_each(pos, head) {
> 	 		struct hook *item = list_entry(pos, struct hook, list);
> 	 		item = list_entry(pos, struct hook, list);
> 	 		if (item) {
> 	-			/* Don't translate 'hookdir' - it matches the config */
> 	-			printf("%s: %s%s\n",
> 	-			       (item->from_hookdir
> 	+			const char *scope = item->from_hookdir
> 	 				? "hookdir"
> 	-				: config_scope_name(item->origin)),
> 	-			       item->command.buf,
> 	-			       (item->from_hookdir
> 	-				? hookdir_annotation.buf
> 	-				: ""));
> 	+				: config_scope_name(item->origin);
> 	+			switch (should_run_hookdir) {
> 	+			case HOOKDIR_NO:
> 	+				printf(_("%s: %s (will not run)\n"),
> 	+				       scope, item->command.buf);
> 	+				break;
> 	+			case HOOKDIR_ERROR:
> 	+				printf(_("%s: %s (will error and not run)\n"),
> 	+				       scope, item->command.buf);
> 	+				break;
> 	+			case HOOKDIR_INTERACTIVE:
> 	+				printf(_("%s: %s (will prompt)\n"),
> 	+				       scope, item->command.buf);
> 	+				break;
> 	+			case HOOKDIR_WARN:
> 	+				printf(_("%s: %s (will warn but run)\n"),
> 	+				       scope, item->command.buf);
> 	+				break;
> 	+			case HOOKDIR_YES:
> 	+				/*
> 	+				 * The default behavior should agree with
> 	+				 * hook.c:configured_hookdir_opt(). HOOKDIR_UNKNOWN should just
> 	+				 * do the default behavior.
> 	+				 */
> 	+			case HOOKDIR_UNKNOWN:
> 	+			default:
> 	+				printf(_("%s: %s\n"),
> 	+				       scope, item->command.buf);
> 	+				break;
> 	+			}
> 	 		}
> 	 	}
> 	 
> 	 	clear_hook_list(head);
> 	-	strbuf_release(&hookdir_annotation);
> 	-	strbuf_release(&hookname);
> 	 
> 	 	return 0;
> 	 }
> 
> I think this is better to avoid i18n lego, as noted in another reply
> (but I didn't include the patch).
> 
> More on strbuf below:
> 	 
> 	 static int run(int argc, const char **argv, const char *prefix)
> 	 {
> 	-	struct strbuf hookname = STRBUF_INIT;
> 	 	struct run_hooks_opt opt;
> 	 	int rc = 0;
> 	 
> 	@@ -118,12 +109,10 @@ static int run(int argc, const char **argv, const char *prefix)
> 	 		usage_msg_opt(_("You must specify a hook event to run."),
> 	 			      builtin_hook_usage, run_options);
> 	 
> 	-	strbuf_addstr(&hookname, argv[0]);
> 	 	opt.run_hookdir = should_run_hookdir;
> 	 
> 	-	rc = run_hooks(hookname.buf, &opt);
> 	+	rc = run_hooks(argv[0], &opt);
> 	 
> 	-	strbuf_release(&hookname);
> 	 	run_hooks_opt_clear(&opt);
> 	 
> 	 	return rc;
> 	diff --git a/builtin/merge.c b/builtin/merge.c
> 	index 3a2af257a6b..df4ff72fbc7 100644
> 	--- a/builtin/merge.c
> 	+++ b/builtin/merge.c
> 	@@ -848,7 +848,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
> 	 	 * and write it out as a tree.  We must do this before we invoke
> 	 	 * the editor and after we invoke run_status above.
> 	 	 */
> 	-	if (hook_exists("pre-merge-commit", HOOKDIR_USE_CONFIG))
> 	+	if (hook_exists("pre-merge-commit", "hook.pre-merge-commit.command",
> 	+			HOOKDIR_USE_CONFIG))
> 	 		discard_cache();
> 	 	read_cache_from(index_file);
> 	 	strbuf_addbuf(&msg, &merge_msg);
> 	diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> 	index eaedeeb1e8b..a76069ea592 100644
> 	--- a/builtin/receive-pack.c
> 	+++ b/builtin/receive-pack.c
> 	@@ -1123,12 +1123,10 @@ static int run_proc_receive_hook(struct command *commands,
> 	 	int version = 0;
> 	 	int code;
> 	 
> 	-	struct strbuf hookname = STRBUF_INIT;
> 	 	struct hook *proc_receive = NULL;
> 	 	struct list_head *pos, *hooks;
> 	 
> 	-	strbuf_addstr(&hookname, "proc-receive");
> 	-	hooks = hook_list(&hookname);
> 	+	hooks = hook_list("proc-receive");
> 	 
> 	 	list_for_each(pos, hooks) {
> 	 		if (proc_receive) {
> 	@@ -1460,8 +1458,6 @@ static const char *push_to_deploy(unsigned char *sha1,
> 	 	return NULL;
> 	 }
> 	 
> 	-static const char *push_to_checkout_hook = "push-to-checkout";
> 	-
> 	 static const char *push_to_checkout(unsigned char *hash,
> 	 				    struct strvec *env,
> 	 				    const char *work_tree)
> 	@@ -1472,7 +1468,7 @@ static const char *push_to_checkout(unsigned char *hash,
> 	 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
> 	 	strvec_pushv(&opt.env, env->v);
> 	 	strvec_push(&opt.args, hash_to_hex(hash));
> 	-	if (run_hooks(push_to_checkout_hook, &opt)) {
> 	+	if (run_hooks("push-to-checkout", &opt)) {
> 	 		run_hooks_opt_clear(&opt);
> 	 		return "push-to-checkout hook declined";
> 	 	} else {
> 	@@ -1502,7 +1498,8 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
> 	 
> 	 	strvec_pushf(&env, "GIT_DIR=%s", absolute_path(git_dir));
> 	 
> 	-	if (!hook_exists(push_to_checkout_hook, HOOKDIR_USE_CONFIG))
> 	+	if (!hook_exists("push-to-checkout", "hook.push-to-checkout.command",
> 	+			 HOOKDIR_USE_CONFIG))
> 	 		retval = push_to_deploy(sha1, &env, work_tree);
> 	 	else
> 	 		retval = push_to_checkout(sha1, &env, work_tree);
> 	diff --git a/hook.c b/hook.c
> 	index 7f6f3b9a616..49c3861ce00 100644
> 	--- a/hook.c
> 	+++ b/hook.c
> 	@@ -247,7 +247,7 @@ static const char *find_legacy_hook(const char *name)
> 	 }
> 	 
> 	 
> 	-struct list_head* hook_list(const struct strbuf* hookname)
> 	+struct list_head* hook_list(const char *hookname)
> 	 {
> 	 	struct strbuf hook_key = STRBUF_INIT;
> 	 	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
> 	@@ -256,14 +256,14 @@ struct list_head* hook_list(const struct strbuf* hookname)
> 	 	INIT_LIST_HEAD(hook_head);
> 	 
> 	 	if (!hookname)
> 	-		return NULL;
> 	+		BUG("???");;
> 	 
> 	-	strbuf_addf(&hook_key, "hook.%s.command", hookname->buf);
> 	+	strbuf_addf(&hook_key, "hook.%s.command", hookname);
> 	 
> 	 	git_config(hook_config_lookup, &cb_data);
> 	 
> 	 	if (have_git_dir()) {
> 	-		const char *legacy_hook_path = find_legacy_hook(hookname->buf);
> 	+		const char *legacy_hook_path = find_legacy_hook(hookname);
> 	 
> 	 		/* Unconditionally add legacy hook, but annotate it. */
> 	 		if (legacy_hook_path) {
> 	@@ -300,10 +300,10 @@ void run_hooks_opt_init_async(struct run_hooks_opt *o)
> 	 	o->jobs = configured_hook_jobs();
> 	 }
> 	 
> 	-int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
> 	+int hook_exists(const char *hookname, const char *hook_config,
> 	+		enum hookdir_opt should_run_hookdir)
> 	 {
> 	 	const char *value = NULL; /* throwaway */
> 	-	struct strbuf hook_key = STRBUF_INIT;
> 	 	int could_run_hookdir;
> 	 
> 	 	if (should_run_hookdir == HOOKDIR_USE_CONFIG)
> 	@@ -314,9 +314,7 @@ int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir)
> 	 				should_run_hookdir == HOOKDIR_YES)
> 	 				&& !!find_legacy_hook(hookname);
> 	 
> 	-	strbuf_addf(&hook_key, "hook.%s.command", hookname);
> 	-
> 	-	return (!git_config_get_value(hook_key.buf, &value)) || could_run_hookdir;
> 	+	return (!git_config_get_value(hook_config, &value)) || could_run_hookdir;
> 	 }
> 	 
> 	 void run_hooks_opt_clear(struct run_hooks_opt *o)
> 	@@ -438,7 +436,6 @@ static int notify_hook_finished(int result,
> 	 
> 	 int run_hooks(const char *hookname, struct run_hooks_opt *options)
> 	 {
> 	-	struct strbuf hookname_str = STRBUF_INIT;
> 	 	struct list_head *to_run, *pos = NULL, *tmp = NULL;
> 	 	struct hook_cb_data cb_data = { 0, NULL, NULL, options };
> 	 
> 	@@ -448,9 +445,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
> 	 	if (options->path_to_stdin && options->feed_pipe)
> 	 		BUG("choose only one method to populate stdin");
> 	 
> 	-	strbuf_addstr(&hookname_str, hookname);
> 	-
> 	-	to_run = hook_list(&hookname_str);
> 	+	to_run = hook_list(hookname);
> 	 
> 	 	list_for_each_safe(pos, tmp, to_run) {
> 	 		struct hook *hook = list_entry(pos, struct hook, list);
> 	diff --git a/hook.h b/hook.h
> 	index 4ff9999b049..bfbbf36882d 100644
> 	--- a/hook.h
> 	+++ b/hook.h
> 	@@ -26,7 +26,7 @@ struct hook {
> 	  * Provides a linked list of 'struct hook' detailing commands which should run
> 	  * in response to the 'hookname' event, in execution order.
> 	  */
> 	-struct list_head* hook_list(const struct strbuf *hookname);
> 	+struct list_head* hook_list(const char *hookname);
> 	 
> 	 enum hookdir_opt
> 	 {
> 	@@ -123,7 +123,8 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
> 	  * Like with run_hooks, if you take a --run-hookdir flag, reflect that
> 	  * user-specified behavior here instead.
> 	  */
> 	-int hook_exists(const char *hookname, enum hookdir_opt should_run_hookdir);
> 	+int hook_exists(const char *hookname, const char *hook_config,
> 	+		enum hookdir_opt should_run_hookdir);
> 	 
> 	 /*
> 	  * Runs all hooks associated to the 'hookname' event in order. Each hook will be
> 	diff --git a/refs.c b/refs.c
> 	index 334fdd9103c..f01995fe64f 100644
> 	--- a/refs.c
> 	+++ b/refs.c
> 	@@ -1966,7 +1966,9 @@ static int run_transaction_hook(struct ref_transaction *transaction,
> 	 
> 	 	run_hooks_opt_init_async(&opt);
> 	 
> 	-	if (!hook_exists("reference-transaction", HOOKDIR_USE_CONFIG))
> 	+	if (!hook_exists("reference-transaction",
> 	+			 "hook.reference-transaction.command",
> 	+			 HOOKDIR_USE_CONFIG))
> 	 		return ret;
> 	 
> 	 	strvec_push(&opt.args, state);
> 	diff --git a/sequencer.c b/sequencer.c
> 	index 34ff275f0d1..52c067c1688 100644
> 	--- a/sequencer.c
> 	+++ b/sequencer.c
> 	@@ -1436,7 +1436,9 @@ static int try_to_commit(struct repository *r,
> 	 		}
> 	 	}
> 	 
> 	-	if (hook_exists("prepare-commit-msg", HOOKDIR_USE_CONFIG)) {
> 	+	if (hook_exists("prepare-commit-msg",
> 	+			"hook.prepare-commit-msg.command",
> 	+			HOOKDIR_USE_CONFIG)) {
> 	 		res = run_prepare_commit_msg_hook(r, msg, hook_commit);
> 	 		if (res)
> 	 			goto out;
> 
> There was another reply (from JT I believe, but didn't go back and look
> it up) about the over use of strbuf.
> 
> I tend to agree, as much as I love the API it's really not better to
> write C with it if all you need is a const char* that's never modified,
> particularly if you get it from elsewhere.
> 
> So it's really not meant for or good for "everything we need a const
> char*", but to avoid verbose realloc() dances all over the place, and
> for things like getline() loops without a hardcoded buffer size.
> 
> E.g. in the first hunk here we're creating a strbuf just to copy argv[0]
> to it, and then throwing it away, let's just pass down argv[0].
> 
> For hook_exists I think just having the code more grep-able and having
> the config value inline is better, but I admit that's a matter of taste.
> 
> I didn't try to find all such strbuf() occurrences, anyway, in the
> overall scheme of things it's a relatively small nit.
> 
> I'm hoping to do some deeper diving into this series, in particular the
> parallelism, but just sending the shallow-ish comments I have for now.
> 
> Thanks for working on this!
