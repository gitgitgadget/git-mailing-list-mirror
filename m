Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C74C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJQRuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJQRtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACB9178A9
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a3so19681349wrt.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW69Gms6ZCN63XObi08yq0tn7lfTlwTRY0tybCpvj6U=;
        b=gdqszjxrye+H4mHeZS/6VBA5FTikz/kL/cDk3uRbD/oM9rE3aOVcS6ecORqqswpKUM
         +KYkWWMLO7kUq/Nrl5Y9Nvq/oTSzCLyCgWMxXU7CmLHC0En6TBNIga7oZ2dJi3QAl6+1
         0eskz0oqtgYkRUDWwMw1S+MKUIxyFzN4jliE/+NdLUsgZJquv8Id6kj/M+SM6j3Itc0a
         PnAaUklcPqmMd6v596z2qwAJDbQoxYC+ciA+H7KOkyLQqwCItHlH9gOy2bJ1V4efPmvk
         LwoNeq5A1vmt8PwTkY9744cjyG2ySVDQM/uCbpv0b7M1zgJEyc2L0kFqVZyysEV8ryQp
         /GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW69Gms6ZCN63XObi08yq0tn7lfTlwTRY0tybCpvj6U=;
        b=7Vgw4Y5PVcspi5lGiXKl/1G5NFFSqtwgxDubUKuNPPVGFubG/fUo0XKwyimeU8NSee
         FWufqkiC4P52Z9vKKhNXi1Xw3DZrvfDmTbNzF6aERULI4dbxTXsK7orn/vWydhZ+eIxa
         YQ6XFhlxVtsypHYeyOsAEYb8TaXqEWIJHx/NwaQYKETbUem5nq2icXbesFt8ZlFnvO/b
         KCvnUdBjm/GJDeRb8yKE9plCnrQsqDQozPMTZOkDbn/Cds0RaRBAZqocdG3uin8uND2V
         /ikIcBOEludqESxXWuXM5i9mhsYBT3ftWF+O9iB4xC2rEM1HOPLXJbkFv6ZE7dVogdRm
         WHtg==
X-Gm-Message-State: ACrzQf0m/SzM+D/r0l4milljx1P/jAaVvF8Et9mYeuWxt2BVxYyvjO+K
        HFsx99dNYWqcZ66syybcXAn7JbOTclFaqA==
X-Google-Smtp-Source: AMsMyM7dURkj0dGpusTGKYhSsei51qpGiar20QdKU268OsyuTDa8K74QLzqxlVoQwWUIuL5Y7mwzxw==
X-Received: by 2002:a5d:64ee:0:b0:22c:df95:532f with SMTP id g14-20020a5d64ee000000b0022cdf95532fmr6795504wri.61.1666028977697;
        Mon, 17 Oct 2022 10:49:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/10] run-command API: add and use a run_command_sv_opt()
Date:   Mon, 17 Oct 2022 19:49:21 +0200
Message-Id: <patch-v2-10.10-138af632a36-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a run_command_sv_opt() convenience wrapper for
run_command_v_opt(), as noted in the API documentation this is for the
common case of wanting to construct a "struct strvec" to pass to
run_command_v_opt(), and as it's a one-shot to strvec_clear() it
afterwards.

Let's convert those API users that were using a "ret" variable to
carry over to "return" after a "strvec_clear()" to use this new
function instead.

Because we pass the "struct strvec *" to the function we can also
avoid copying the arguments to the "args" member of the "struct
child_process", as we were doing with run_command_v_opt().

Instead we can use memcpy() and strvec_clear() to do the moral
equivalent of a strbuf_{detach,attach}(). The strvec API doesn't have
a strvec_attach(), we could add it here while at it, but let's avoid
generalizing the interface for now and migrate the "struct strvec *"
in the "run_command_sv_opt()" instead.

Let's leave aside the user in "builtin/bisect--helper.c"'s
bisect_visualize(). There's an outstanding topic that's extensively
modifying it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c |  3 +--
 builtin/add.c     |  6 ++----
 builtin/clone.c   |  3 +--
 builtin/gc.c      |  5 +----
 builtin/pull.c    | 15 +++------------
 builtin/remote.c  |  5 +----
 merge.c           |  3 +--
 run-command.c     | 11 +++++++++++
 run-command.h     | 16 +++++++++++++++-
 scalar.c          |  6 +-----
 sequencer.c       | 11 ++---------
 11 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index f071b2a1b4f..9c86f3b9532 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1007,8 +1007,7 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 			if (files->selected[i])
 				strvec_push(&args,
 					    files->items.items[i].string);
-		res = run_command_v_opt(args.v, 0);
-		strvec_clear(&args);
+		res = run_command_sv_opt(&args, 0);
 	}
 
 	putchar('\n');
diff --git a/builtin/add.c b/builtin/add.c
index f84372964c8..7c783eebc0e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -240,7 +240,7 @@ static int refresh(int verbose, const struct pathspec *pathspec)
 int run_add_interactive(const char *revision, const char *patch_mode,
 			const struct pathspec *pathspec)
 {
-	int status, i;
+	int i;
 	struct strvec argv = STRVEC_INIT;
 	int use_builtin_add_i =
 		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
@@ -282,9 +282,7 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 		/* pass original pathspec, to be re-parsed */
 		strvec_push(&argv, pathspec->items[i].original);
 
-	status = run_command_v_opt(argv.v, RUN_GIT_CMD);
-	strvec_clear(&argv);
-	return status;
+	return run_command_sv_opt(&argv, RUN_GIT_CMD);
 }
 
 int interactive_add(const char **argv, const char *prefix, int patch)
diff --git a/builtin/clone.c b/builtin/clone.c
index a1514363190..8e43781e147 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -756,8 +756,7 @@ static int checkout(int submodule_progress, int filter_submodules)
 					       "--single-branch" :
 					       "--no-single-branch");
 
-		err = run_command_v_opt(args.v, RUN_GIT_CMD);
-		strvec_clear(&args);
+		return run_command_sv_opt(&args, RUN_GIT_CMD);
 	}
 
 	return err;
diff --git a/builtin/gc.c b/builtin/gc.c
index 519e64e86ee..8393e19b504 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1899,7 +1899,6 @@ static int is_schtasks_available(void)
 static int schtasks_remove_task(enum schedule_priority schedule)
 {
 	const char *cmd = "schtasks";
-	int result;
 	struct strvec args = STRVEC_INIT;
 	const char *frequency = get_frequency(schedule);
 
@@ -1909,9 +1908,7 @@ static int schtasks_remove_task(enum schedule_priority schedule)
 	strvec_pushf(&args, SCHTASKS_NAME_FMT, frequency);
 	strvec_pushl(&args, "/f", NULL);
 
-	result = run_command_v_opt(args.v, 0);
-	strvec_clear(&args);
-	return result;
+	return run_command_sv_opt(&args, 0);
 }
 
 static int schtasks_remove_tasks(void)
diff --git a/builtin/pull.c b/builtin/pull.c
index 403a24d7ca6..2f36823c97e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -516,7 +516,6 @@ static void parse_repo_refspecs(int argc, const char **argv, const char **repo,
 static int run_fetch(const char *repo, const char **refspecs)
 {
 	struct strvec args = STRVEC_INIT;
-	int ret;
 
 	strvec_pushl(&args, "fetch", "--update-head-ok", NULL);
 
@@ -582,9 +581,7 @@ static int run_fetch(const char *repo, const char **refspecs)
 		strvec_pushv(&args, refspecs);
 	} else if (*refspecs)
 		BUG("refspecs without repo?");
-	ret = run_command_v_opt(args.v, RUN_GIT_CMD | RUN_CLOSE_OBJECT_STORE);
-	strvec_clear(&args);
-	return ret;
+	return run_command_sv_opt(&args, RUN_GIT_CMD | RUN_CLOSE_OBJECT_STORE);
 }
 
 /**
@@ -653,7 +650,6 @@ static int update_submodules(void)
  */
 static int run_merge(void)
 {
-	int ret;
 	struct strvec args = STRVEC_INIT;
 
 	strvec_pushl(&args, "merge", NULL);
@@ -696,9 +692,7 @@ static int run_merge(void)
 		strvec_push(&args, "--allow-unrelated-histories");
 
 	strvec_push(&args, "FETCH_HEAD");
-	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
-	return ret;
+	return run_command_sv_opt(&args, RUN_GIT_CMD);
 }
 
 /**
@@ -879,7 +873,6 @@ static int get_rebase_newbase_and_upstream(struct object_id *newbase,
 static int run_rebase(const struct object_id *newbase,
 		const struct object_id *upstream)
 {
-	int ret;
 	struct strvec args = STRVEC_INIT;
 
 	strvec_push(&args, "rebase");
@@ -913,9 +906,7 @@ static int run_rebase(const struct object_id *newbase,
 
 	strvec_push(&args, oid_to_hex(upstream));
 
-	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
-	return ret;
+	return run_command_sv_opt(&args, RUN_GIT_CMD);
 }
 
 static int get_can_ff(struct object_id *orig_head,
diff --git a/builtin/remote.c b/builtin/remote.c
index 910f7b9316a..5d3534db19c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1510,7 +1510,6 @@ static int update(int argc, const char **argv, const char *prefix)
 	};
 	struct strvec fetch_argv = STRVEC_INIT;
 	int default_defined = 0;
-	int retval;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_update_usage,
@@ -1536,9 +1535,7 @@ static int update(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	retval = run_command_v_opt(fetch_argv.v, RUN_GIT_CMD);
-	strvec_clear(&fetch_argv);
-	return retval;
+	return run_command_sv_opt(&fetch_argv, RUN_GIT_CMD);
 }
 
 static int remove_all_fetch_refspecs(const char *key)
diff --git a/merge.c b/merge.c
index 2382ff66d35..487debacecb 100644
--- a/merge.c
+++ b/merge.c
@@ -33,8 +33,7 @@ int try_merge_command(struct repository *r,
 	for (j = remotes; j; j = j->next)
 		strvec_push(&args, merge_argument(j->item));
 
-	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
-	strvec_clear(&args);
+	ret = run_command_sv_opt(&args, RUN_GIT_CMD);
 
 	discard_index(r->index);
 	if (repo_read_index(r) < 0)
diff --git a/run-command.c b/run-command.c
index 0066ace85fa..724fc581c89 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1038,6 +1038,17 @@ int run_command_v_opt(const char **argv, int opt)
 	return run_command(&cmd);
 }
 
+int run_command_sv_opt(struct strvec *args, int opt)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	/* TODO: We could encapsulate this with a strvec_attach() */
+	memcpy(&cmd.args, args, sizeof(*args));
+	strvec_init(args);
+	run_command_set_opts(&cmd, opt);
+	return run_command(&cmd);
+}
+
 #ifndef NO_PTHREADS
 static pthread_t main_thread;
 static int main_thread_set;
diff --git a/run-command.h b/run-command.h
index 2b1fe3cde5c..8e8403f3bb3 100644
--- a/run-command.h
+++ b/run-command.h
@@ -151,7 +151,7 @@ struct child_process {
 
 /**
  * The functions: child_process_init, start_command, finish_command,
- * run_command, run_command_l_opt, run_command_v_opt,
+ * run_command, run_command_l_opt, run_command_v_opt, run_command_sv_opt,
  * child_process_clear do the following:
  *
  * - If a system call failed, errno is set and -1 is returned. A diagnostic
@@ -262,6 +262,20 @@ int run_command_v_opt(const char **argv, int opt);
 LAST_ARG_MUST_BE_NULL
 int run_command_l_opt(int opt, ...);
 
+/**
+ * The run_command_sv_opt() function is a wrapper for
+ * run_command_v_opt(). It takes a "struct strvec *args" which
+ * similarly will be strvec_clear()'d before returning.
+ *
+ * Use it for the common case of constructing a "struct strvec" for a
+ * one-shot run_command_v_opt() invocation.
+ *
+ * The "args" will migrated the "cmd.args" member of an underlying
+ * "struct child_process", in a way that avoids making an extra copy.
+ */
+RESULT_MUST_BE_USED
+int run_command_sv_opt(struct strvec *args, int opt);
+
 /**
  * Execute the given command, sending "in" to its stdin, and capturing its
  * stdout and stderr in the "out" and "err" strbufs. Any of the three may
diff --git a/scalar.c b/scalar.c
index 6de9c0ee523..3480bf73cbd 100644
--- a/scalar.c
+++ b/scalar.c
@@ -72,7 +72,6 @@ static int run_git(const char *arg, ...)
 	struct strvec argv = STRVEC_INIT;
 	va_list args;
 	const char *p;
-	int res;
 
 	va_start(args, arg);
 	strvec_push(&argv, arg);
@@ -80,10 +79,7 @@ static int run_git(const char *arg, ...)
 		strvec_push(&argv, p);
 	va_end(args);
 
-	res = run_command_v_opt(argv.v, RUN_GIT_CMD);
-
-	strvec_clear(&argv);
-	return res;
+	return run_command_sv_opt(&argv, RUN_GIT_CMD);
 }
 
 struct scalar_config {
diff --git a/sequencer.c b/sequencer.c
index 20495db9de2..7ee0e05512c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3183,7 +3183,6 @@ static int rollback_is_safe(void)
 
 static int reset_merge(const struct object_id *oid)
 {
-	int ret;
 	struct strvec argv = STRVEC_INIT;
 
 	strvec_pushl(&argv, "reset", "--merge", NULL);
@@ -3191,10 +3190,7 @@ static int reset_merge(const struct object_id *oid)
 	if (!is_null_oid(oid))
 		strvec_push(&argv, oid_to_hex(oid));
 
-	ret = run_command_v_opt(argv.v, RUN_GIT_CMD);
-	strvec_clear(&argv);
-
-	return ret;
+	return run_command_sv_opt(&argv, RUN_GIT_CMD);
 }
 
 static int rollback_single_pick(struct repository *r)
@@ -4866,7 +4862,6 @@ static int pick_commits(struct repository *r,
 static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 {
 	struct strvec argv = STRVEC_INIT;
-	int ret;
 
 	if (!refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
 	    !refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
@@ -4887,9 +4882,7 @@ static int continue_single_pick(struct repository *r, struct replay_opts *opts)
 		 */
 		strvec_pushl(&argv, "--no-edit", "--cleanup=strip", NULL);
 
-	ret = run_command_v_opt(argv.v, RUN_GIT_CMD);
-	strvec_clear(&argv);
-	return ret;
+	return run_command_sv_opt(&argv, RUN_GIT_CMD);
 }
 
 static int commit_staged_changes(struct repository *r,
-- 
2.38.0.1091.gf9d18265e59

