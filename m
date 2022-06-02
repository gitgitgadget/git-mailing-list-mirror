Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531FEC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 09:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiFBJKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiFBJKU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 05:10:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAE62A90F3
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 02:10:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t13so5595483wrg.9
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/RcnvNaQW+LrKcB4QZKfs0Y9eo6/tgibFzyl7fvGpnA=;
        b=dxKHSMaRpJKijUWSBKuOvDEadcx6BP65EsrLYqpWGKoCDU6pM5a675BcRg4LS+PByS
         wOE4fSaFdCmW7GzjH/v5ES+pJgQHMd8YtGoKaZr7oY9kLhqUTIcLpiwUTCg4Nx9z/aNS
         BWydcoPKFFW0huWwegBOUB9hgXa+pxWcbg/DcyvIwJBTUke+aV2HwQXiI2np9Bq3fhbv
         nK3or2+dHqiXLf1DbyWpsNuTtCZDXPJ53KHpoulUfcHicD1vWo7+nivCrcuJoxPqVaBh
         qryc8ADineCiT3gTQqK00uuY0Pmu9FSx62j5OyH+eLik+0OmGFFGArcel+YEBVKbO1PV
         a8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RcnvNaQW+LrKcB4QZKfs0Y9eo6/tgibFzyl7fvGpnA=;
        b=k8FXmE8WEIXZd7oUBVjVqeu4eEhc5ePE9S/Niaqn69uTUt5PkS8Gf+HlMIYMVpXtgN
         mYMWRm3MSmoNeWeInSv2wJ90HHZ33l0RETe1Ehxi3lv7oW5BPtEspukkbMrRgXJQr/2z
         oi6l4Wr3mUQxCFL7E7hA8YXmAmsi+iN65kPu0tWFivv6NY4SJjNbbbpRhNpYZO0w2lPT
         E58a+Di0X9akjKQklYV4CwXSIvv8lnMFU4w2nErVjMEWQz0LamKpfUqKLsjsUlxReQxC
         IpqzFXPQiZ9l1W7BMs9+K8QiN6g9V6e0kNczbhlzn88m/wvq9t+nvlXDns7kXk2DG3ja
         WnwQ==
X-Gm-Message-State: AOAM531zthQNe349i4kStPMqNW/8VkMPxbHirLz6h3dT0Ok+LNZ9WKjS
        phlpJtElhbUIC6MNiQz4jxK/KUrqIG2OSw==
X-Google-Smtp-Source: ABdhPJwehCJDYKTgzgToOXPK/A2+JbFMI5QNg1pApzK0bX/mFMFlgmOASc2I+qNMORUOzIlyyW0ZJw==
X-Received: by 2002:a05:6000:1548:b0:20f:c4bb:defd with SMTP id 8-20020a056000154800b0020fc4bbdefdmr2788735wry.210.1654161014675;
        Thu, 02 Jun 2022 02:10:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h42-20020a05600c49aa00b003973d425a7fsm4833088wmp.41.2022.06.02.02.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 02:10:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] run-command API: rename "env_array" to "env"
Date:   Thu,  2 Jun 2022 11:09:50 +0200
Message-Id: <patch-v3-1.2-80ef05d5b0a-20220602T090745Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v3-0.2-00000000000-20220602T090745Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com> <cover-v3-0.2-00000000000-20220602T090745Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Start following-up on the rename mentioned in c7c4bdeccf3 (run-command
API: remove "env" member, always use "env_array", 2021-11-25) of
"env_array" to "env".

The "env_array" name was picked in 19a583dc39e (run-command: add
env_array, an optional argv_array for env, 2014-10-19) because "env"
was taken. Let's not forever keep the oddity of "*_array" for this
"struct strvec", but not for its "args" sibling.

This commit is almost entirely made with a coccinelle rule[1]. The
only manual change here is in run-command.h to rename the struct
member itself and to change "env_array" to "env" in the
CHILD_PROCESS_INIT initializer.

The rest of this is all a result of applying [1]:

 * make contrib/coccinelle/run_command.cocci.patch
 * patch -p1 <contrib/coccinelle/run_command.cocci.patch
 * git add -u

1. cat contrib/coccinelle/run_command.pending.cocci
   @@
   struct child_process E;
   @@
   - E.env_array
   + E.env

   @@
   struct child_process *E;
   @@
   - E->env_array
   + E->env

I've avoided changing any comments and derived variable names here,
that will all be done in the next commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-patch.c                 |  2 +-
 branch.c                    |  2 +-
 builtin/difftool.c          |  6 +++---
 builtin/receive-pack.c      | 32 ++++++++++++++--------------
 builtin/stash.c             | 16 +++++++-------
 builtin/submodule--helper.c | 42 ++++++++++++++++++-------------------
 builtin/worktree.c          |  8 +++----
 connect.c                   |  9 ++++----
 connected.c                 |  2 +-
 daemon.c                    | 14 ++++++-------
 editor.c                    |  2 +-
 hook.c                      |  2 +-
 http-backend.c              |  4 ++--
 object-file.c               |  2 +-
 pager.c                     |  4 ++--
 promisor-remote.c           |  2 +-
 run-command.c               | 13 ++++++------
 run-command.h               |  4 ++--
 sequencer.c                 | 16 +++++++-------
 submodule.c                 | 38 ++++++++++++++++-----------------
 t/helper/test-run-command.c |  2 +-
 trailer.c                   |  2 +-
 transport-helper.c          |  2 +-
 wt-status.c                 |  2 +-
 24 files changed, 115 insertions(+), 113 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 55d719f7845..509ca04456b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -305,7 +305,7 @@ static void setup_child_process(struct add_p_state *s,
 	va_end(ap);
 
 	cp->git_cmd = 1;
-	strvec_pushf(&cp->env_array,
+	strvec_pushf(&cp->env,
 		     INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
 }
 
diff --git a/branch.c b/branch.c
index 2d6569b0c62..4c8523c66ad 100644
--- a/branch.c
+++ b/branch.c
@@ -587,7 +587,7 @@ static int submodule_create_branch(struct repository *r,
 	child.err = -1;
 	child.stdout_to_stderr = 1;
 
-	prepare_other_repo_env(&child.env_array, r->gitdir);
+	prepare_other_repo_env(&child.env, r->gitdir);
 	/*
 	 * submodule_create_branch() is indirectly invoked by "git
 	 * branch", but we cannot invoke "git branch" in the child
diff --git a/builtin/difftool.c b/builtin/difftool.c
index faa3507369a..b3c509b8de3 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -217,7 +217,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	update_index.use_shell = 0;
 	update_index.clean_on_exit = 1;
 	update_index.dir = workdir;
-	strvec_pushf(&update_index.env_array, "GIT_INDEX_FILE=%s", index_path);
+	strvec_pushf(&update_index.env, "GIT_INDEX_FILE=%s", index_path);
 	/* Ignore any errors of update-index */
 	run_command(&update_index);
 
@@ -230,7 +230,7 @@ static void changed_files(struct hashmap *result, const char *index_path,
 	diff_files.clean_on_exit = 1;
 	diff_files.out = -1;
 	diff_files.dir = workdir;
-	strvec_pushf(&diff_files.env_array, "GIT_INDEX_FILE=%s", index_path);
+	strvec_pushf(&diff_files.env, "GIT_INDEX_FILE=%s", index_path);
 	if (start_command(&diff_files))
 		die("could not obtain raw diff");
 	fp = xfdopen(diff_files.out, "r");
@@ -675,7 +675,7 @@ static int run_file_diff(int prompt, const char *prefix,
 
 	child->git_cmd = 1;
 	child->dir = prefix;
-	strvec_pushv(&child->env_array, env);
+	strvec_pushv(&child->env, env);
 
 	return run_command(child);
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index daa153d0446..e6e1d636f9c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -764,23 +764,23 @@ static void prepare_push_cert_sha1(struct child_process *proc)
 		nonce_status = check_nonce(push_cert.buf, bogs);
 	}
 	if (!is_null_oid(&push_cert_oid)) {
-		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT=%s",
+		strvec_pushf(&proc->env, "GIT_PUSH_CERT=%s",
 			     oid_to_hex(&push_cert_oid));
-		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_SIGNER=%s",
+		strvec_pushf(&proc->env, "GIT_PUSH_CERT_SIGNER=%s",
 			     sigcheck.signer ? sigcheck.signer : "");
-		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_KEY=%s",
+		strvec_pushf(&proc->env, "GIT_PUSH_CERT_KEY=%s",
 			     sigcheck.key ? sigcheck.key : "");
-		strvec_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
+		strvec_pushf(&proc->env, "GIT_PUSH_CERT_STATUS=%c",
 			     sigcheck.result);
 		if (push_cert_nonce) {
-			strvec_pushf(&proc->env_array,
+			strvec_pushf(&proc->env,
 				     "GIT_PUSH_CERT_NONCE=%s",
 				     push_cert_nonce);
-			strvec_pushf(&proc->env_array,
+			strvec_pushf(&proc->env,
 				     "GIT_PUSH_CERT_NONCE_STATUS=%s",
 				     nonce_status);
 			if (nonce_status == NONCE_SLOP)
-				strvec_pushf(&proc->env_array,
+				strvec_pushf(&proc->env,
 					     "GIT_PUSH_CERT_NONCE_SLOP=%ld",
 					     nonce_stamp_slop);
 		}
@@ -815,17 +815,17 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed,
 	if (feed_state->push_options) {
 		size_t i;
 		for (i = 0; i < feed_state->push_options->nr; i++)
-			strvec_pushf(&proc.env_array,
+			strvec_pushf(&proc.env,
 				     "GIT_PUSH_OPTION_%"PRIuMAX"=%s",
 				     (uintmax_t)i,
 				     feed_state->push_options->items[i].string);
-		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
+		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT=%"PRIuMAX"",
 			     (uintmax_t)feed_state->push_options->nr);
 	} else
-		strvec_pushf(&proc.env_array, "GIT_PUSH_OPTION_COUNT");
+		strvec_pushf(&proc.env, "GIT_PUSH_OPTION_COUNT");
 
 	if (tmp_objdir)
-		strvec_pushv(&proc.env_array, tmp_objdir_env(tmp_objdir));
+		strvec_pushv(&proc.env, tmp_objdir_env(tmp_objdir));
 
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
@@ -1357,7 +1357,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 
 	strvec_pushl(&child.args, "update-index", "-q", "--ignore-submodules",
 		     "--refresh", NULL);
-	strvec_pushv(&child.env_array, env->v);
+	strvec_pushv(&child.env, env->v);
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
@@ -1369,7 +1369,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	child_process_init(&child);
 	strvec_pushl(&child.args, "diff-files", "--quiet",
 		     "--ignore-submodules", "--", NULL);
-	strvec_pushv(&child.env_array, env->v);
+	strvec_pushv(&child.env, env->v);
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
@@ -1383,7 +1383,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 		     /* diff-index with either HEAD or an empty tree */
 		     head_has_history() ? "HEAD" : empty_tree_oid_hex(),
 		     "--", NULL);
-	strvec_pushv(&child.env_array, env->v);
+	strvec_pushv(&child.env, env->v);
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
@@ -1394,7 +1394,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	child_process_init(&child);
 	strvec_pushl(&child.args, "read-tree", "-u", "-m", hash_to_hex(sha1),
 		     NULL);
-	strvec_pushv(&child.env_array, env->v);
+	strvec_pushv(&child.env, env->v);
 	child.dir = work_tree;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
@@ -2214,7 +2214,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 			close(err_fd);
 		return "unable to create temporary object directory";
 	}
-	strvec_pushv(&child.env_array, tmp_objdir_env(tmp_objdir));
+	strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
 
 	/*
 	 * Normally we just pass the tmp_objdir environment to the child
diff --git a/builtin/stash.c b/builtin/stash.c
index 3fe549f7d3c..ca8f962e9bc 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -357,7 +357,7 @@ static int restore_untracked(struct object_id *u_tree)
 	cp.git_cmd = 1;
 	strvec_push(&cp.args, "read-tree");
 	strvec_push(&cp.args, oid_to_hex(u_tree));
-	strvec_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushf(&cp.env, "GIT_INDEX_FILE=%s",
 		     stash_index_path.buf);
 	if (run_command(&cp)) {
 		remove_path(stash_index_path.buf);
@@ -367,7 +367,7 @@ static int restore_untracked(struct object_id *u_tree)
 	child_process_init(&cp);
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "checkout-index", "--all", NULL);
-	strvec_pushf(&cp.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushf(&cp.env, "GIT_INDEX_FILE=%s",
 		     stash_index_path.buf);
 
 	res = run_command(&cp);
@@ -603,9 +603,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 		 */
 		cp.git_cmd = 1;
 		cp.dir = prefix;
-		strvec_pushf(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT"=%s",
+		strvec_pushf(&cp.env, GIT_WORK_TREE_ENVIRONMENT"=%s",
 			     absolute_path(get_git_work_tree()));
-		strvec_pushf(&cp.env_array, GIT_DIR_ENVIRONMENT"=%s",
+		strvec_pushf(&cp.env, GIT_DIR_ENVIRONMENT"=%s",
 			     absolute_path(get_git_dir()));
 		strvec_push(&cp.args, "status");
 		run_command(&cp);
@@ -1106,7 +1106,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 	cp_upd_index.git_cmd = 1;
 	strvec_pushl(&cp_upd_index.args, "update-index", "-z", "--add",
 		     "--remove", "--stdin", NULL);
-	strvec_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushf(&cp_upd_index.env, "GIT_INDEX_FILE=%s",
 			 stash_index_path.buf);
 
 	strbuf_addf(&untracked_msg, "untracked files on %s\n", msg->buf);
@@ -1180,7 +1180,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 
 	cp_read_tree.git_cmd = 1;
 	strvec_pushl(&cp_read_tree.args, "read-tree", "HEAD", NULL);
-	strvec_pushf(&cp_read_tree.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushf(&cp_read_tree.env, "GIT_INDEX_FILE=%s",
 		     stash_index_path.buf);
 	if (run_command(&cp_read_tree)) {
 		ret = -1;
@@ -1267,7 +1267,7 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 	strvec_pushl(&cp_upd_index.args, "update-index",
 		     "--ignore-skip-worktree-entries",
 		     "-z", "--add", "--remove", "--stdin", NULL);
-	strvec_pushf(&cp_upd_index.env_array, "GIT_INDEX_FILE=%s",
+	strvec_pushf(&cp_upd_index.env, "GIT_INDEX_FILE=%s",
 		     stash_index_path.buf);
 
 	if (pipe_command(&cp_upd_index, diff_output.buf, diff_output.len,
@@ -1543,7 +1543,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			cp.git_cmd = 1;
 			if (startup_info->original_cwd) {
 				cp.dir = startup_info->original_cwd;
-				strvec_pushf(&cp.env_array, "%s=%s",
+				strvec_pushf(&cp.env, "%s=%s",
 					     GIT_WORK_TREE_ENVIRONMENT,
 					     the_repository->worktree);
 			}
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a8e5d06214..b855e544bd6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -292,7 +292,7 @@ static char *compute_rev_name(const char *sub_path, const char* object_id)
 
 	for (d = describe_argv; *d; d++) {
 		struct child_process cp = CHILD_PROCESS_INIT;
-		prepare_submodule_repo_env(&cp.env_array);
+		prepare_submodule_repo_env(&cp.env);
 		cp.dir = sub_path;
 		cp.git_cmd = 1;
 		cp.no_stderr = 1;
@@ -479,7 +479,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 	if (!is_submodule_populated_gently(path, NULL))
 		goto cleanup;
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 
 	/*
 	 * For the purpose of executing <command> in the submodule,
@@ -499,12 +499,12 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		char *toplevel = xgetcwd();
 		struct strbuf sb = STRBUF_INIT;
 
-		strvec_pushf(&cp.env_array, "name=%s", sub->name);
-		strvec_pushf(&cp.env_array, "sm_path=%s", path);
-		strvec_pushf(&cp.env_array, "displaypath=%s", displaypath);
-		strvec_pushf(&cp.env_array, "sha1=%s",
+		strvec_pushf(&cp.env, "name=%s", sub->name);
+		strvec_pushf(&cp.env, "sm_path=%s", path);
+		strvec_pushf(&cp.env, "displaypath=%s", displaypath);
+		strvec_pushf(&cp.env, "sha1=%s",
 			     oid_to_hex(ce_oid));
-		strvec_pushf(&cp.env_array, "toplevel=%s", toplevel);
+		strvec_pushf(&cp.env, "toplevel=%s", toplevel);
 
 		/*
 		 * Since the path variable was accessible from the script
@@ -536,7 +536,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 
 		cpr.git_cmd = 1;
 		cpr.dir = path;
-		prepare_submodule_repo_env(&cpr.env_array);
+		prepare_submodule_repo_env(&cpr.env);
 
 		strvec_pushl(&cpr.args, "--super-prefix", NULL);
 		strvec_pushf(&cpr.args, "%s/", displaypath);
@@ -833,7 +833,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 
 		cpr.git_cmd = 1;
 		cpr.dir = path;
-		prepare_submodule_repo_env(&cpr.env_array);
+		prepare_submodule_repo_env(&cpr.env);
 
 		strvec_push(&cpr.args, "--super-prefix");
 		strvec_pushf(&cpr.args, "%s/", displaypath);
@@ -955,7 +955,7 @@ static char *verify_submodule_committish(const char *sm_path,
 
 	cp_rev_parse.git_cmd = 1;
 	cp_rev_parse.dir = sm_path;
-	prepare_submodule_repo_env(&cp_rev_parse.env_array);
+	prepare_submodule_repo_env(&cp_rev_parse.env);
 	strvec_pushl(&cp_rev_parse.args, "rev-parse", "-q", "--short", NULL);
 	strvec_pushf(&cp_rev_parse.args, "%s^0", committish);
 	strvec_push(&cp_rev_parse.args, "--");
@@ -996,7 +996,7 @@ static void print_submodule_summary(struct summary_cb *info, char *errmsg,
 
 		cp_log.git_cmd = 1;
 		cp_log.dir = p->sm_path;
-		prepare_submodule_repo_env(&cp_log.env_array);
+		prepare_submodule_repo_env(&cp_log.env);
 		strvec_pushl(&cp_log.args, "log", NULL);
 
 		if (S_ISGITLINK(p->mod_src) && S_ISGITLINK(p->mod_dst)) {
@@ -1113,7 +1113,7 @@ static void generate_submodule_summary(struct summary_cb *info,
 
 		cp_rev_list.git_cmd = 1;
 		cp_rev_list.dir = p->sm_path;
-		prepare_submodule_repo_env(&cp_rev_list.env_array);
+		prepare_submodule_repo_env(&cp_rev_list.env);
 
 		if (!capture_command(&cp_rev_list, &sb_rev_list, 0))
 			total_commits = atoi(sb_rev_list.buf);
@@ -1414,7 +1414,7 @@ static void sync_submodule(const char *path, const char *prefix,
 
 		cpr.git_cmd = 1;
 		cpr.dir = path;
-		prepare_submodule_repo_env(&cpr.env_array);
+		prepare_submodule_repo_env(&cpr.env);
 
 		strvec_push(&cpr.args, "--super-prefix");
 		strvec_pushf(&cpr.args, "%s/", displaypath);
@@ -1819,7 +1819,7 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		strvec_push(&cp.args, clone_data->path);
 
 		cp.git_cmd = 1;
-		prepare_submodule_repo_env(&cp.env_array);
+		prepare_submodule_repo_env(&cp.env);
 		cp.no_stdin = 1;
 
 		if(run_command(&cp))
@@ -2294,7 +2294,7 @@ static int is_tip_reachable(const char *path, struct object_id *oid)
 	cp.no_stderr = 1;
 	strvec_pushl(&cp.args, "rev-list", "-n", "1", hex, "--not", "--all", NULL);
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 
 	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
 		return 0;
@@ -2306,7 +2306,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
 	cp.dir = xstrdup(module_path);
 
@@ -2363,7 +2363,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 	strvec_push(&cp.args, oid);
 
 	cp.dir = xstrdup(ud->sm_path);
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
@@ -2629,7 +2629,7 @@ static int update_submodule(struct update_data *update_data)
 
 		cp.dir = update_data->sm_path;
 		cp.git_cmd = 1;
-		prepare_submodule_repo_env(&cp.env_array);
+		prepare_submodule_repo_env(&cp.env);
 		update_data_to_args(&next, &cp.args);
 
 		/* die() if child process die()'d */
@@ -3122,9 +3122,9 @@ static void append_fetch_remotes(struct strbuf *msg, const char *git_dir_path)
 	struct strbuf sb_remote_out = STRBUF_INIT;
 
 	cp_remote.git_cmd = 1;
-	strvec_pushf(&cp_remote.env_array,
+	strvec_pushf(&cp_remote.env,
 		     "GIT_DIR=%s", git_dir_path);
-	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=.");
+	strvec_push(&cp_remote.env, "GIT_WORK_TREE=.");
 	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
 	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
 		char *next_line;
@@ -3208,7 +3208,7 @@ static int add_submodule(const struct add_data *add_data)
 		if (clone_submodule(&clone_data))
 			return -1;
 
-		prepare_submodule_repo_env(&cp.env_array);
+		prepare_submodule_repo_env(&cp.env);
 		cp.git_cmd = 1;
 		cp.dir = add_data->sm_path;
 		/*
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 8b32cd16515..cd62eef240e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -301,7 +301,7 @@ static int checkout_worktree(const struct add_opts *opts,
 	strvec_pushl(&cp.args, "reset", "--hard", "--no-recurse-submodules", NULL);
 	if (opts->quiet)
 		strvec_push(&cp.args, "--quiet");
-	strvec_pushv(&cp.env_array, child_env->v);
+	strvec_pushv(&cp.env, child_env->v);
 	return run_command(&cp);
 }
 
@@ -433,7 +433,7 @@ static int add_worktree(const char *path, const char *refname,
 			strvec_push(&cp.args, "--quiet");
 	}
 
-	strvec_pushv(&cp.env_array, child_env.v);
+	strvec_pushv(&cp.env, child_env.v);
 	ret = run_command(&cp);
 	if (ret)
 		goto done;
@@ -989,9 +989,9 @@ static void check_clean_worktree(struct worktree *wt,
 	validate_no_submodules(wt);
 
 	child_process_init(&cp);
-	strvec_pushf(&cp.env_array, "%s=%s/.git",
+	strvec_pushf(&cp.env, "%s=%s/.git",
 		     GIT_DIR_ENVIRONMENT, wt->path);
-	strvec_pushf(&cp.env_array, "%s=%s",
+	strvec_pushf(&cp.env, "%s=%s",
 		     GIT_WORK_TREE_ENVIRONMENT, wt->path);
 	strvec_pushl(&cp.args, "status",
 		     "--porcelain", "--ignore-submodules=none",
diff --git a/connect.c b/connect.c
index afc79a6236e..37b56067358 100644
--- a/connect.c
+++ b/connect.c
@@ -1327,7 +1327,7 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 
 		strvec_push(&detect.args, ssh);
 		strvec_push(&detect.args, "-G");
-		push_ssh_options(&detect.args, &detect.env_array,
+		push_ssh_options(&detect.args, &detect.env,
 				 VARIANT_SSH, port, version, flags);
 		strvec_push(&detect.args, ssh_host);
 
@@ -1335,7 +1335,8 @@ static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
 	}
 
 	strvec_push(&conn->args, ssh);
-	push_ssh_options(&conn->args, &conn->env_array, variant, port, version, flags);
+	push_ssh_options(&conn->args, &conn->env, variant, port, version,
+			 flags);
 	strvec_push(&conn->args, ssh_host);
 }
 
@@ -1397,7 +1398,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		/* remove repo-local variables from the environment */
 		for (var = local_repo_env; *var; var++)
-			strvec_push(&conn->env_array, *var);
+			strvec_push(&conn->env, *var);
 
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
@@ -1429,7 +1430,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 			transport_check_allowed("file");
 			conn->trace2_child_class = "transport/file";
 			if (version > 0) {
-				strvec_pushf(&conn->env_array,
+				strvec_pushf(&conn->env,
 					     GIT_PROTOCOL_ENVIRONMENT "=version=%d",
 					     version);
 			}
diff --git a/connected.c b/connected.c
index ed3025e7a2a..74a20cb32e7 100644
--- a/connected.c
+++ b/connected.c
@@ -110,7 +110,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 
 	rev_list.git_cmd = 1;
 	if (opt->env)
-		strvec_pushv(&rev_list.env_array, opt->env);
+		strvec_pushv(&rev_list.env, opt->env);
 	rev_list.in = -1;
 	rev_list.no_stdout = 1;
 	if (opt->err_fd)
diff --git a/daemon.c b/daemon.c
index aeda6966f05..58f1077885c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -484,7 +484,7 @@ static int upload_pack(const struct strvec *env)
 	strvec_pushl(&cld.args, "upload-pack", "--strict", NULL);
 	strvec_pushf(&cld.args, "--timeout=%u", timeout);
 
-	strvec_pushv(&cld.env_array, env->v);
+	strvec_pushv(&cld.env, env->v);
 
 	return run_service_command(&cld);
 }
@@ -494,7 +494,7 @@ static int upload_archive(const struct strvec *env)
 	struct child_process cld = CHILD_PROCESS_INIT;
 	strvec_push(&cld.args, "upload-archive");
 
-	strvec_pushv(&cld.env_array, env->v);
+	strvec_pushv(&cld.env, env->v);
 
 	return run_service_command(&cld);
 }
@@ -504,7 +504,7 @@ static int receive_pack(const struct strvec *env)
 	struct child_process cld = CHILD_PROCESS_INIT;
 	strvec_push(&cld.args, "receive-pack");
 
-	strvec_pushv(&cld.env_array, env->v);
+	strvec_pushv(&cld.env, env->v);
 
 	return run_service_command(&cld);
 }
@@ -904,16 +904,16 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		char buf[128] = "";
 		struct sockaddr_in *sin_addr = (void *) addr;
 		inet_ntop(addr->sa_family, &sin_addr->sin_addr, buf, sizeof(buf));
-		strvec_pushf(&cld.env_array, "REMOTE_ADDR=%s", buf);
-		strvec_pushf(&cld.env_array, "REMOTE_PORT=%d",
+		strvec_pushf(&cld.env, "REMOTE_ADDR=%s", buf);
+		strvec_pushf(&cld.env, "REMOTE_PORT=%d",
 			     ntohs(sin_addr->sin_port));
 #ifndef NO_IPV6
 	} else if (addr->sa_family == AF_INET6) {
 		char buf[128] = "";
 		struct sockaddr_in6 *sin6_addr = (void *) addr;
 		inet_ntop(AF_INET6, &sin6_addr->sin6_addr, buf, sizeof(buf));
-		strvec_pushf(&cld.env_array, "REMOTE_ADDR=[%s]", buf);
-		strvec_pushf(&cld.env_array, "REMOTE_PORT=%d",
+		strvec_pushf(&cld.env, "REMOTE_ADDR=[%s]", buf);
+		strvec_pushf(&cld.env, "REMOTE_PORT=%d",
 			     ntohs(sin6_addr->sin6_port));
 #endif
 	}
diff --git a/editor.c b/editor.c
index 8b9648281d7..008c04fe2f6 100644
--- a/editor.c
+++ b/editor.c
@@ -80,7 +80,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 
 		strvec_pushl(&p.args, editor, realpath.buf, NULL);
 		if (env)
-			strvec_pushv(&p.env_array, (const char **)env);
+			strvec_pushv(&p.env, (const char **)env);
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
 		if (start_command(&p) < 0) {
diff --git a/hook.c b/hook.c
index 1d51be3b77a..2b47bdf5ef0 100644
--- a/hook.c
+++ b/hook.c
@@ -54,7 +54,7 @@ static int pick_next_hook(struct child_process *cp,
 		return 0;
 
 	cp->no_stdin = 1;
-	strvec_pushv(&cp->env_array, hook_cb->options->env.v);
+	strvec_pushv(&cp->env, hook_cb->options->env.v);
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
diff --git a/http-backend.c b/http-backend.c
index 81a7229ece0..58b83a9f66b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -476,9 +476,9 @@ static void run_service(const char **argv, int buffer_input)
 		host = "(none)";
 
 	if (!getenv("GIT_COMMITTER_NAME"))
-		strvec_pushf(&cld.env_array, "GIT_COMMITTER_NAME=%s", user);
+		strvec_pushf(&cld.env, "GIT_COMMITTER_NAME=%s", user);
 	if (!getenv("GIT_COMMITTER_EMAIL"))
-		strvec_pushf(&cld.env_array,
+		strvec_pushf(&cld.env,
 			     "GIT_COMMITTER_EMAIL=%s@http.%s", user, host);
 
 	strvec_pushv(&cld.args, argv);
diff --git a/object-file.c b/object-file.c
index d35c1820e7a..5a045d424df 100644
--- a/object-file.c
+++ b/object-file.c
@@ -838,7 +838,7 @@ static void fill_alternate_refs_command(struct child_process *cmd,
 		}
 	}
 
-	strvec_pushv(&cmd->env_array, (const char **)local_repo_env);
+	strvec_pushv(&cmd->env, (const char **)local_repo_env);
 	cmd->out = -1;
 }
 
diff --git a/pager.c b/pager.c
index 27877f8ebbc..5cfe23b025c 100644
--- a/pager.c
+++ b/pager.c
@@ -99,7 +99,7 @@ void prepare_pager_args(struct child_process *pager_process, const char *pager)
 {
 	strvec_push(&pager_process->args, pager);
 	pager_process->use_shell = 1;
-	setup_pager_env(&pager_process->env_array);
+	setup_pager_env(&pager_process->env);
 	pager_process->trace2_child_class = "pager";
 }
 
@@ -129,7 +129,7 @@ void setup_pager(void)
 	/* spawn the pager */
 	prepare_pager_args(&pager_process, pager);
 	pager_process.in = -1;
-	strvec_push(&pager_process.env_array, "GIT_PAGER_IN_USE");
+	strvec_push(&pager_process.env, "GIT_PAGER_IN_USE");
 	if (start_command(&pager_process))
 		return;
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 8d6695681c1..5b33f88bca1 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -22,7 +22,7 @@ static int fetch_objects(struct repository *repo,
 	child.git_cmd = 1;
 	child.in = -1;
 	if (repo != the_repository)
-		prepare_other_repo_env(&child.env_array, repo->gitdir);
+		prepare_other_repo_env(&child.env, repo->gitdir);
 	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
diff --git a/run-command.c b/run-command.c
index a8501e38ceb..5f7ea713f06 100644
--- a/run-command.c
+++ b/run-command.c
@@ -20,7 +20,7 @@ void child_process_init(struct child_process *child)
 void child_process_clear(struct child_process *child)
 {
 	strvec_clear(&child->args);
-	strvec_clear(&child->env_array);
+	strvec_clear(&child->env);
 }
 
 struct child_to_clean {
@@ -646,7 +646,7 @@ static void trace_run_command(const struct child_process *cp)
 		sq_quote_buf_pretty(&buf, cp->dir);
 		strbuf_addch(&buf, ';');
 	}
-	trace_add_env(&buf, cp->env_array.v);
+	trace_add_env(&buf, cp->env.v);
 	if (cp->git_cmd)
 		strbuf_addstr(&buf, " git");
 	sq_quote_argv_pretty(&buf, cp->args.v);
@@ -751,7 +751,7 @@ int start_command(struct child_process *cmd)
 		set_cloexec(null_fd);
 	}
 
-	childenv = prep_childenv(cmd->env_array.v);
+	childenv = prep_childenv(cmd->env.v);
 	atfork_prepare(&as);
 
 	/*
@@ -914,8 +914,9 @@ int start_command(struct child_process *cmd)
 	else if (cmd->use_shell)
 		cmd->args.v = prepare_shell_cmd(&nargv, sargv);
 
-	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v, (char**) cmd->env_array.v,
-			cmd->dir, fhin, fhout, fherr);
+	cmd->pid = mingw_spawnvpe(cmd->args.v[0], cmd->args.v,
+				  (char**) cmd->env.v,
+				  cmd->dir, fhin, fhout, fherr);
 	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
 		error_errno("cannot spawn %s", cmd->args.v[0]);
@@ -1031,7 +1032,7 @@ int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 	cmd.close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
 	cmd.dir = dir;
 	if (env)
-		strvec_pushv(&cmd.env_array, (const char **)env);
+		strvec_pushv(&cmd.env, (const char **)env);
 	cmd.trace2_child_class = tr2_class;
 	return run_command(&cmd);
 }
diff --git a/run-command.h b/run-command.h
index 5bd0c933e80..d52ebc42b97 100644
--- a/run-command.h
+++ b/run-command.h
@@ -73,7 +73,7 @@ struct child_process {
 	 * The memory in .env_array will be cleaned up automatically during
 	 * `finish_command` (or during `start_command` when it is unsuccessful).
 	 */
-	struct strvec env_array;
+	struct strvec env;
 	pid_t pid;
 
 	int trace2_child_id;
@@ -146,7 +146,7 @@ struct child_process {
 
 #define CHILD_PROCESS_INIT { \
 	.args = STRVEC_INIT, \
-	.env_array = STRVEC_INIT, \
+	.env = STRVEC_INIT, \
 }
 
 /**
diff --git a/sequencer.c b/sequencer.c
index 8c3ed3532ac..701e420cddd 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1000,7 +1000,7 @@ static int run_git_commit(const char *defmsg,
 	if (is_rebase_i(opts) &&
 	    ((opts->committer_date_is_author_date && !opts->ignore_date) ||
 	     !(!defmsg && (flags & AMEND_MSG))) &&
-	    read_env_script(&cmd.env_array)) {
+	    read_env_script(&cmd.env)) {
 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
 		return error(_(staged_changes_advice),
@@ -1008,12 +1008,12 @@ static int run_git_commit(const char *defmsg,
 	}
 
 	if (opts->committer_date_is_author_date)
-		strvec_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+		strvec_pushf(&cmd.env, "GIT_COMMITTER_DATE=%s",
 			     opts->ignore_date ?
 			     "" :
-			     author_date_from_env_array(&cmd.env_array));
+			     author_date_from_env_array(&cmd.env));
 	if (opts->ignore_date)
-		strvec_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
+		strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
 
 	strvec_push(&cmd.args, "commit");
 
@@ -3911,7 +3911,7 @@ static int do_merge(struct repository *r,
 		/* Octopus merge */
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
-		if (read_env_script(&cmd.env_array)) {
+		if (read_env_script(&cmd.env)) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
 			ret = error(_(staged_changes_advice), gpg_opt, gpg_opt);
@@ -3919,12 +3919,12 @@ static int do_merge(struct repository *r,
 		}
 
 		if (opts->committer_date_is_author_date)
-			strvec_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+			strvec_pushf(&cmd.env, "GIT_COMMITTER_DATE=%s",
 				     opts->ignore_date ?
 				     "" :
-				     author_date_from_env_array(&cmd.env_array));
+				     author_date_from_env_array(&cmd.env));
 		if (opts->ignore_date)
-			strvec_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
+			strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
 
 		cmd.git_cmd = 1;
 		strvec_push(&cmd.args, "merge");
diff --git a/submodule.c b/submodule.c
index 86c8f0f89db..1229660f02c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -711,15 +711,15 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	if (!(dirty_submodule & DIRTY_SUBMODULE_MODIFIED))
 		strvec_push(&cp.args, oid_to_hex(new_oid));
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 
 	if (!is_directory(path)) {
 		/* fall back to absorbed git dir, if any */
 		if (!sub)
 			goto done;
 		cp.dir = sub->gitdir;
-		strvec_push(&cp.env_array, GIT_DIR_ENVIRONMENT "=.");
-		strvec_push(&cp.env_array, GIT_WORK_TREE_ENVIRONMENT "=.");
+		strvec_push(&cp.env, GIT_DIR_ENVIRONMENT "=.");
+		strvec_push(&cp.env, GIT_WORK_TREE_ENVIRONMENT "=.");
 	}
 
 	if (start_command(&cp)) {
@@ -1019,7 +1019,7 @@ static int submodule_has_commits(struct repository *r,
 		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
 		strvec_pushl(&cp.args, "--not", "--all", NULL);
 
-		prepare_submodule_repo_env(&cp.env_array);
+		prepare_submodule_repo_env(&cp.env);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		cp.dir = path;
@@ -1060,7 +1060,7 @@ static int submodule_needs_pushing(struct repository *r,
 		oid_array_for_each_unique(commits, append_oid_to_argv, &cp.args);
 		strvec_pushl(&cp.args, "--not", "--remotes", "-n", "1" , NULL);
 
-		prepare_submodule_repo_env(&cp.env_array);
+		prepare_submodule_repo_env(&cp.env);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		cp.out = -1;
@@ -1146,7 +1146,7 @@ static int push_submodule(const char *path,
 				strvec_push(&cp.args, rs->raw[i]);
 		}
 
-		prepare_submodule_repo_env(&cp.env_array);
+		prepare_submodule_repo_env(&cp.env);
 		cp.git_cmd = 1;
 		cp.no_stdin = 1;
 		cp.dir = path;
@@ -1177,7 +1177,7 @@ static void submodule_push_check(const char *path, const char *head,
 	for (i = 0; i < rs->raw_nr; i++)
 		strvec_push(&cp.args, rs->raw[i]);
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.no_stdout = 1;
@@ -1678,7 +1678,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 
 		child_process_init(cp);
 		cp->dir = task->repo->gitdir;
-		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		prepare_submodule_repo_env_in_gitdir(&cp->env);
 		cp->git_cmd = 1;
 		strvec_init(&cp->args);
 		if (task->git_args.nr)
@@ -1708,7 +1708,7 @@ static int get_next_submodule(struct child_process *cp, struct strbuf *err,
 			    spf->prefix, task->sub->path);
 
 		child_process_init(cp);
-		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		prepare_submodule_repo_env_in_gitdir(&cp->env);
 		cp->git_cmd = 1;
 		cp->dir = task->repo->gitdir;
 
@@ -1882,7 +1882,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 	if (ignore_untracked)
 		strvec_push(&cp.args, "-uno");
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
@@ -1954,7 +1954,7 @@ int submodule_uses_gitfile(const char *path)
 		     "submodule", "foreach", "--quiet",	"--recursive",
 		     "test -f .git", NULL);
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.no_stderr = 1;
@@ -1997,7 +1997,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	if (!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED))
 		strvec_push(&cp.args, "--ignored");
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
@@ -2052,7 +2052,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 
 	cp.git_cmd = 1;
 	strvec_pushl(&cp.args, "diff-index", "--quiet",
@@ -2069,7 +2069,7 @@ static int submodule_has_dirty_index(const struct submodule *sub)
 static void submodule_reset_index(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
@@ -2153,7 +2153,7 @@ int submodule_move_head(const char *path,
 		}
 	}
 
-	prepare_submodule_repo_env(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
 
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
@@ -2191,7 +2191,7 @@ int submodule_move_head(const char *path,
 			cp.no_stdin = 1;
 			cp.dir = path;
 
-			prepare_submodule_repo_env(&cp.env_array);
+			prepare_submodule_repo_env(&cp.env);
 			strvec_pushl(&cp.args, "update-ref", "HEAD",
 				     "--no-deref", new_head, NULL);
 
@@ -2374,7 +2374,7 @@ void absorb_git_dir_into_superproject(const char *path,
 		strvec_pushl(&cp.args, "--super-prefix", sb.buf,
 			     "submodule--helper",
 			     "absorb-git-dirs", NULL);
-		prepare_submodule_repo_env(&cp.env_array);
+		prepare_submodule_repo_env(&cp.env);
 		if (run_command(&cp))
 			die(_("could not recurse into submodule '%s'"), path);
 
@@ -2407,8 +2407,8 @@ int get_superproject_working_tree(struct strbuf *buf)
 	subpath = relative_path(cwd, one_up.buf, &sb);
 	strbuf_release(&one_up);
 
-	prepare_submodule_repo_env(&cp.env_array);
-	strvec_pop(&cp.env_array);
+	prepare_submodule_repo_env(&cp.env);
+	strvec_pop(&cp.env);
 
 	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
 		     "ls-files", "-z", "--stage", "--full-name", "--",
diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index f3b90aa834a..9050e3113c5 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -390,7 +390,7 @@ int cmd__run_command(int argc, const char **argv)
 	while (!strcmp(argv[1], "env")) {
 		if (!argv[2])
 			die("env specifier without a value");
-		strvec_push(&proc.env_array, argv[2]);
+		strvec_push(&proc.env, argv[2]);
 		argv += 2;
 		argc -= 2;
 	}
diff --git a/trailer.c b/trailer.c
index 926a3729df5..d419c20735e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -236,7 +236,7 @@ static char *apply_command(struct conf_info *conf, const char *arg)
 			strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
 		strvec_push(&cp.args, cmd.buf);
 	}
-	strvec_pushv(&cp.env_array, (const char **)local_repo_env);
+	strvec_pushv(&cp.env, (const char **)local_repo_env);
 	cp.no_stdin = 1;
 	cp.use_shell = 1;
 
diff --git a/transport-helper.c b/transport-helper.c
index b4dbbabb0c2..322c7224782 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -135,7 +135,7 @@ static struct child_process *get_helper(struct transport *transport)
 	helper->silent_exec_failure = 1;
 
 	if (have_git_dir())
-		strvec_pushf(&helper->env_array, "%s=%s",
+		strvec_pushf(&helper->env, "%s=%s",
 			     GIT_DIR_ENVIRONMENT, get_git_dir());
 
 	helper->trace2_child_class = helper->args.v[0]; /* "remote-<name>" */
diff --git a/wt-status.c b/wt-status.c
index d33f9272b72..62fadc0c93d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -982,7 +982,7 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	struct strbuf summary = STRBUF_INIT;
 	char *summary_content;
 
-	strvec_pushf(&sm_summary.env_array, "GIT_INDEX_FILE=%s", s->index_file);
+	strvec_pushf(&sm_summary.env, "GIT_INDEX_FILE=%s", s->index_file);
 
 	strvec_push(&sm_summary.args, "submodule");
 	strvec_push(&sm_summary.args, "summary");
-- 
2.36.1.1103.gb3ecdfb3e6a

