Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE2AC433FE
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8561059
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbhIIOUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbhIIOTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:19:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09816C10DC43
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 05:42:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e26so1268970wmk.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 05:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pH1SX2/ve5m5WQmbfBz+guRJpnO+MiXLeJ2Bw6zz3fk=;
        b=Wk9i9Qp4HDUOOIlQVJN8TqKUNKrhMIRS9YYR/FAB01de+ndzkBOAvN9NQwj775jgTR
         BBCN6NCHst/NrWZ3JA/uzJhluSD7XNwq47WtTjfYaaprGIOhfYgo67PJ/FtADQcvCNtK
         vRvcwnnr+EK8rCVSx+HuUR4vqiT+j0YauRcPdZol3q19CyGM4rmjCF2LB3qVhzdrRatc
         IALmLB4+s4v+WptyaySaK5O82+TtirtVYMVkbgQcg1Rrd57qpt71wOITkEkw/11aTKpq
         CsJqqRaR7DXsxO2Qcfnltjcqigkyq+yMKvRha/pPESg05V94f773lUf6lFsJ7x7AR69N
         oAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pH1SX2/ve5m5WQmbfBz+guRJpnO+MiXLeJ2Bw6zz3fk=;
        b=iYsbXI13MJ5ytkSer5k256v/Pbe5ylFT80dC+riXxhs3E67uwj78QITODkLElVa5+p
         FTxKAvliRIvCweuNSWmaHn2USofEVAfdHpXCct9XP78FqZpi+XRkc80vueZk2QnmOtaa
         b0AQkSvb2t3kJ/S+s/I4pgC0zO/q1LowsgWlWlWlf7Xsj2xQcKYxrOGMW+rQhU64abvx
         lfQ3n/0ELthvRNiUV4A+9Pgggrdqq+X48+sy9Df5FNPNefsYLA+D7qcPaNH6XhiBPYf2
         5LXWSAdjZ3IKBbveSeENpIfWUTZCclCEMLmtm9V657Wn5KBX2MZH9fDsLzDcs3xFdxoV
         yTtg==
X-Gm-Message-State: AOAM5321eRIm8WZP7y8QTztHYkul+uQ7Eyj/3ZVpC4uzSNMo+fIuHm/0
        bjXo7nkJIPkMmkN/nRNrmI0Q60ZmWC9b2Q==
X-Google-Smtp-Source: ABdhPJxwnMgAfwYFq6giqgP5N64NEUq5mvCWLi+Kx8qOKFCuq1A67BWGkO9ZaismwgGy26TXSIfEvA==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr2749751wmh.137.1631191330095;
        Thu, 09 Sep 2021 05:42:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j25sm1742081wrc.12.2021.09.09.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 05:42:09 -0700 (PDT)
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
Subject: [PATCH v4 1/5] hook: run a list of hooks instead
Date:   Thu,  9 Sep 2021 14:41:59 +0200
Message-Id: <patch-v4-1.5-2f0cac14965-20210909T122802Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.867.g88ec4638586
In-Reply-To: <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com> <cover-v4-0.5-00000000000-20210909T122802Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

To prepare for multihook support, teach hook.[hc] to take a list of
hooks at run_hooks and run_found_hooks. Right now the list is always one
entry, but in the future we will allow users to supply more than one
executable for a single hook event.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/hook.c |  14 ++++---
 hook.c         | 109 ++++++++++++++++++++++++++++++++++++-------------
 hook.h         |  22 ++++++++--
 3 files changed, 107 insertions(+), 38 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index fae69068201..398980523aa 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -25,7 +25,7 @@ static int run(int argc, const char **argv, const char *prefix)
 	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
 	int ignore_missing = 0;
 	const char *hook_name;
-	const char *hook_path;
+	struct list_head *hooks;
 	struct option run_options[] = {
 		OPT_BOOL(0, "ignore-missing", &ignore_missing,
 			 N_("exit quietly with a zero exit code if the requested hook cannot be found")),
@@ -63,16 +63,18 @@ static int run(int argc, const char **argv, const char *prefix)
 	 * run_hooks() instead...
 	 */
 	hook_name = argv[0];
-	if (ignore_missing)
+	hooks = list_hooks(hook_name);
+	if (list_empty(hooks)) {
+		clear_hook_list(hooks);
+
 		/* ... act like a plain run_hooks() under --ignore-missing */
-		return run_hooks_oneshot(hook_name, &opt);
-	hook_path = find_hook(hook_name);
-	if (!hook_path) {
+		if (ignore_missing)
+			return 0;
 		error("cannot find a hook named %s", hook_name);
 		return 1;
 	}
 
-	ret = run_hooks(hook_name, hook_path, &opt);
+	ret = run_hooks(hook_name, hooks, &opt);
 	run_hooks_opt_clear(&opt);
 	return ret;
 usage:
diff --git a/hook.c b/hook.c
index d045379ade8..2b2c16a9095 100644
--- a/hook.c
+++ b/hook.c
@@ -3,6 +3,30 @@
 #include "run-command.h"
 #include "config.h"
 
+static void free_hook(struct hook *ptr)
+{
+	if (!ptr)
+		return;
+
+	free(ptr->feed_pipe_cb_data);
+	free(ptr);
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
+	free(head);
+}
+
 const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
@@ -39,7 +63,38 @@ const char *find_hook(const char *name)
 
 int hook_exists(const char *name)
 {
-	return !!find_hook(name);
+	struct list_head *hooks;
+	int exists;
+
+	hooks = list_hooks(name);
+	exists = !list_empty(hooks);
+	clear_hook_list(hooks);
+
+	return exists;
+}
+
+struct list_head *list_hooks(const char *hookname)
+{
+	struct list_head *hook_head = xmalloc(sizeof(struct list_head));
+
+	INIT_LIST_HEAD(hook_head);
+
+	if (!hookname)
+		BUG("null hookname was provided to hook_list()!");
+
+	if (have_git_dir()) {
+		const char *hook_path = find_hook(hookname);
+
+		/* Add the hook from the hookdir */
+		if (hook_path) {
+			struct hook *to_add = xmalloc(sizeof(*to_add));
+			to_add->hook_path = hook_path;
+			to_add->feed_pipe_cb_data = NULL;
+			list_add_tail(&to_add->list, hook_head);
+		}
+	}
+
+	return hook_head;
 }
 
 void run_hooks_opt_clear(struct run_hooks_opt *o)
@@ -99,7 +154,10 @@ static int pick_next_hook(struct child_process *cp,
 	cp->dir = hook_cb->options->dir;
 
 	/* add command */
-	strvec_push(&cp->args, run_me->hook_path);
+	if (hook_cb->options->absolute_path)
+		strvec_push(&cp->args, absolute_path(run_me->hook_path));
+	else
+		strvec_push(&cp->args, run_me->hook_path);
 
 	/*
 	 * add passed-in argv, without expanding - let the user get back
@@ -110,12 +168,12 @@ static int pick_next_hook(struct child_process *cp,
 	/* Provide context for errors if necessary */
 	*pp_task_cb = run_me;
 
-	/*
-	 * This pick_next_hook() will be called again, we're only
-	 * running one hook, so indicate that no more work will be
-	 * done.
-	 */
-	hook_cb->run_me = NULL;
+	/* Get the next entry ready */
+	if (hook_cb->run_me->list.next == hook_cb->head)
+		hook_cb->run_me = NULL;
+	else
+		hook_cb->run_me = list_entry(hook_cb->run_me->list.next,
+					     struct hook, list);
 
 	return 1;
 }
@@ -150,13 +208,9 @@ static int notify_hook_finished(int result,
 	return 0;
 }
 
-int run_hooks(const char *hook_name, const char *hook_path,
+int run_hooks(const char *hook_name, struct list_head *hooks,
 	      struct run_hooks_opt *options)
 {
-	struct strbuf abs_path = STRBUF_INIT;
-	struct hook my_hook = {
-		.hook_path = hook_path,
-	};
 	struct hook_cb_data cb_data = {
 		.rc = 0,
 		.hook_name = hook_name,
@@ -168,11 +222,8 @@ int run_hooks(const char *hook_name, const char *hook_path,
 	if (!options)
 		BUG("a struct run_hooks_opt must be provided to run_hooks");
 
-	if (options->absolute_path) {
-		strbuf_add_absolute_path(&abs_path, hook_path);
-		my_hook.hook_path = abs_path.buf;
-	}
-	cb_data.run_me = &my_hook;
+	cb_data.head = hooks;
+	cb_data.run_me = list_first_entry(hooks, struct hook, list);
 
 	run_processes_parallel_tr2(jobs,
 				   pick_next_hook,
@@ -184,18 +235,15 @@ int run_hooks(const char *hook_name, const char *hook_path,
 				   "hook",
 				   hook_name);
 
-
-	if (options->absolute_path)
-		strbuf_release(&abs_path);
-	free(my_hook.feed_pipe_cb_data);
+	clear_hook_list(hooks);
 
 	return cb_data.rc;
 }
 
 int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 {
-	const char *hook_path;
-	int ret;
+	struct list_head *hooks;
+	int ret = 0;
 	struct run_hooks_opt hook_opt_scratch = RUN_HOOKS_OPT_INIT;
 
 	if (!options)
@@ -204,13 +252,16 @@ int run_hooks_oneshot(const char *hook_name, struct run_hooks_opt *options)
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("choose only one method to populate stdin");
 
-	hook_path = find_hook(hook_name);
-	if (!hook_path) {
-		ret = 0;
+	hooks = list_hooks(hook_name);
+
+	/*
+	 * If you need to act on a missing hook, use run_found_hooks()
+	 * instead
+	 */
+	if (list_empty(hooks))
 		goto cleanup;
-	}
 
-	ret = run_hooks(hook_name, hook_path, options);
+	ret = run_hooks(hook_name, hooks, options);
 
 cleanup:
 	run_hooks_opt_clear(options);
diff --git a/hook.h b/hook.h
index f6dac75f1cc..49b4c335f86 100644
--- a/hook.h
+++ b/hook.h
@@ -3,8 +3,10 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
+#include "list.h"
 
 struct hook {
+	struct list_head list;
 	/* The path to the hook */
 	const char *hook_path;
 
@@ -75,6 +77,7 @@ struct hook_cb_data {
 	/* rc reflects the cumulative failure state */
 	int rc;
 	const char *hook_name;
+	struct list_head *head;
 	struct hook *run_me;
 	struct run_hooks_opt *options;
 	int *invoked_hook;
@@ -88,7 +91,13 @@ struct hook_cb_data {
 const char *find_hook(const char *name);
 
 /**
- * A boolean version of find_hook()
+ * Provides a linked list of 'struct hook' detailing commands which should run
+ * in response to the 'hookname' event, in execution order.
+ */
+struct list_head *list_hooks(const char *hookname);
+
+/**
+ * A boolean version of list_hooks()
  */
 int hook_exists(const char *hookname);
 
@@ -99,13 +108,20 @@ void run_hooks_opt_clear(struct run_hooks_opt *o);
 
 /**
  * Takes an already resolved hook found via find_hook() and runs
- * it. Does not call run_hooks_opt_clear() for you.
+ * it. Does not call run_hooks_opt_clear() for you, but does call
+ * clear_hook_list().
  *
  * See run_hooks_oneshot() for the simpler one-shot API.
  */
-int run_hooks(const char *hookname, const char *hook_path,
+int run_hooks(const char *hookname, struct list_head *hooks,
 	      struct run_hooks_opt *options);
 
+/**
+ * Empties the list at 'head', calling 'free_hook()' on each
+ * entry. Called implicitly by run_hooks() (and run_hooks_oneshot()).
+ */
+void clear_hook_list(struct list_head *head);
+
 /**
  * Calls find_hook() on your "hook_name" and runs the hooks (if any)
  * with run_hooks().
-- 
2.33.0.867.g88ec4638586

