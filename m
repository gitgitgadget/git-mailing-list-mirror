Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518F4C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C76820829
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0KWrxOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgG3WYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgG3WYn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:43 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2118C061575
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id p14so7023560wmg.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OWrG73JUxOZ0/0m7jgFoeinUrGnyoOyxkJTUEiq2Q3I=;
        b=L0KWrxOXdsWDJn6HVEHjNN/m7Lma1MujnZXlXzamIHrHlx23m8v20kiCzQuXUgTEm/
         GI1JduBKsahGVBaLg8TFXBRMLRpaipmLWwJ24Oyq2MCqotS6rfIqsVf2ju+qHfHpCMiZ
         vnKcJjnQwu9kdchm3EOET2/u/120Ri+e3vEr3lOO/ayywRAqNqqTWzeuXEkRvo0ocRNQ
         0Sdv9a/d1+iIAZ3/QtQyj+pBZ1ioSNc86e2HYzRRBGXbCZZ8RGGymfHdTO/yjy9I4kVe
         olUhfQ5OnTUtnU2T+7srA/vT/JVq378HsxcbzrsclRTb4orV36Um6tiHn5evA8JCgcJB
         rH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OWrG73JUxOZ0/0m7jgFoeinUrGnyoOyxkJTUEiq2Q3I=;
        b=t+Cyrx+EqHqTPqs0/VpMGVcBfDZeZLuaPwT68F46joeheZEI3Vk1+D8Isk6GD4gDKK
         mGiBHJP0Bs/fWgbwMJeAjGczFEtZzXnFWy904XFA26DBIDT+XIfjkOHgc/HPP8bBjeEF
         TppvIggjzmNMnUR9rJq0IaSwUZOq0BjL2D3pQBmKEB1ScJf8qKeJuyEFwzcQ33dTfmIx
         R6uBmeyJbPrhRmDvlF3na0WFDTWJ+YnpBV8F3TLM4tgL9pPIwuKnSrmNCJv6tNMQSkG3
         DLAgn+KsIdygn+eMC9oTguTp6zteVKSvBiwxqZn9Ikq0NdxHRXtTKFGNYIaniTTDHdTh
         s8zw==
X-Gm-Message-State: AOAM533IZNauBerYuz8gtQb2jnvVRWtot7so0bu93k7q1Qv9YjLBDLl1
        mNQAYWrXBK7VYzWCQ+YbTi3hae8k
X-Google-Smtp-Source: ABdhPJx7C/B2WAz9ea+LMXayiGhqkH6lyZG4kGmZ5oT09aWMfKEyZYBTNihRHpHqolHM+gOYb6tJbA==
X-Received: by 2002:a7b:cf22:: with SMTP id m2mr1183421wmg.46.1596147880861;
        Thu, 30 Jul 2020 15:24:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7sm11284681wrq.58.2020.07.30.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:40 -0700 (PDT)
Message-Id: <c4674fc211da51f729d76ca40756479216164b10.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:09 +0000
Subject: [PATCH v3 03/20] maintenance: replace run_auto_gc()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The run_auto_gc() method is used in several places to trigger a check
for repo maintenance after some Git commands, such as 'git commit' or
'git fetch'.

To allow for extra customization of this maintenance activity, replace
the 'git gc --auto [--quiet]' call with one to 'git maintenance run
--auto [--quiet]'. As we extend the maintenance builtin with other
steps, users will be able to select different maintenance activities.

Rename run_auto_gc() to run_auto_maintenance() to be clearer what is
happening on this call, and to expose all callers in the current diff.
Rewrite the method to use a struct child_process to simplify the calls
slightly.

Since 'git fetch' already allows disabling the 'git gc --auto'
subprocess, add an equivalent option with a different name to be more
descriptive of the new behavior: '--[no-]maintenance'. Update the
documentation to include these options at the same time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/fetch-options.txt |  6 ++++--
 Documentation/git-clone.txt     |  6 +++---
 builtin/am.c                    |  2 +-
 builtin/commit.c                |  2 +-
 builtin/fetch.c                 |  6 ++++--
 builtin/merge.c                 |  2 +-
 builtin/rebase.c                |  4 ++--
 run-command.c                   | 16 +++++++---------
 run-command.h                   |  2 +-
 t/t5510-fetch.sh                |  2 +-
 10 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 6e2a160a47..495bc8ab5a 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -86,9 +86,11 @@ ifndef::git-pull[]
 	Allow several <repository> and <group> arguments to be
 	specified. No <refspec>s may be specified.
 
+--[no-]auto-maintenance::
 --[no-]auto-gc::
-	Run `git gc --auto` at the end to perform garbage collection
-	if needed. This is enabled by default.
+	Run `git maintenance run --auto` at the end to perform automatic
+	repository maintenance if needed. (`--[no-]auto-gc` is a synonym.)
+	This is enabled by default.
 
 --[no-]write-commit-graph::
 	Write a commit-graph after fetching. This overrides the config
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c898310099..097e6a86c5 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -78,9 +78,9 @@ repository using this option and then delete branches (or use any
 other Git command that makes any existing commit unreferenced) in the
 source repository, some objects may become unreferenced (or dangling).
 These objects may be removed by normal Git operations (such as `git commit`)
-which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
-If these objects are removed and were referenced by the cloned repository,
-then the cloned repository will become corrupt.
+which automatically call `git maintenance run --auto`. (See
+linkgit:git-maintenance[1].) If these objects are removed and were referenced
+by the cloned repository, then the cloned repository will become corrupt.
 +
 Note that running `git repack` without the `--local` option in a repository
 cloned with `--shared` will copy objects from the source repository into a pack
diff --git a/builtin/am.c b/builtin/am.c
index 3f2adb3822..2ca363f72e 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1795,7 +1795,7 @@ static void am_run(struct am_state *state, int resume)
 	if (!state->rebasing) {
 		am_destroy(state);
 		close_object_store(the_repository->objects);
-		run_auto_gc(state->quiet);
+		run_auto_maintenance(state->quiet);
 	}
 }
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 01105ce8b0..9705bfb0cf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1702,7 +1702,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	git_test_write_commit_graph_or_die();
 
 	repo_rerere(the_repository, 0);
-	run_auto_gc(quiet);
+	run_auto_maintenance(quiet);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7953a1a25b..c7c8ac0861 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -196,8 +196,10 @@ static struct option builtin_fetch_options[] = {
 	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 			N_("report that we have only objects reachable from this object")),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+	OPT_BOOL(0, "auto-maintenance", &enable_auto_gc,
+		 N_("run 'maintenance --auto' after fetching")),
 	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
-		 N_("run 'gc --auto' after fetching")),
+		 N_("run 'maintenance --auto' after fetching")),
 	OPT_BOOL(0, "show-forced-updates", &fetch_show_forced_updates,
 		 N_("check for forced-updates on all updated branches")),
 	OPT_BOOL(0, "write-commit-graph", &fetch_write_commit_graph,
@@ -1882,7 +1884,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	close_object_store(the_repository->objects);
 
 	if (enable_auto_gc)
-		run_auto_gc(verbosity < 0);
+		run_auto_maintenance(verbosity < 0);
 
 	return result;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index 7da707bf55..c068e73037 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -457,7 +457,7 @@ static void finish(struct commit *head_commit,
 			 * user should see them.
 			 */
 			close_object_store(the_repository->objects);
-			run_auto_gc(verbosity < 0);
+			run_auto_maintenance(verbosity < 0);
 		}
 	}
 	if (new_head && show_diffstat) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 494107a648..d14d18191b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -728,10 +728,10 @@ static int finish_rebase(struct rebase_options *opts)
 	apply_autostash(state_dir_path("autostash", opts));
 	close_object_store(the_repository->objects);
 	/*
-	 * We ignore errors in 'gc --auto', since the
+	 * We ignore errors in 'git maintenance run --auto', since the
 	 * user should see them.
 	 */
-	run_auto_gc(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
+	run_auto_maintenance(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
 	if (opts->type == REBASE_MERGE) {
 		struct replay_opts replay = REPLAY_OPTS_INIT;
 
diff --git a/run-command.c b/run-command.c
index 30104a4ee1..b7e1f1dd5a 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1866,15 +1866,13 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 	return result;
 }
 
-int run_auto_gc(int quiet)
+int run_auto_maintenance(int quiet)
 {
-	struct strvec argv_gc_auto = STRVEC_INIT;
-	int status;
+	struct child_process maint = CHILD_PROCESS_INIT;
 
-	strvec_pushl(&argv_gc_auto, "gc", "--auto", NULL);
-	if (quiet)
-		strvec_push(&argv_gc_auto, "--quiet");
-	status = run_command_v_opt(argv_gc_auto.items, RUN_GIT_CMD);
-	strvec_clear(&argv_gc_auto);
-	return status;
+	maint.git_cmd = 1;
+	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
+	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");
+
+	return run_command(&maint);
 }
diff --git a/run-command.h b/run-command.h
index 8b9bfaef16..6472b38bde 100644
--- a/run-command.h
+++ b/run-command.h
@@ -221,7 +221,7 @@ int run_hook_ve(const char *const *env, const char *name, va_list args);
 /*
  * Trigger an auto-gc
  */
-int run_auto_gc(int quiet);
+int run_auto_maintenance(int quiet);
 
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a66dbe0bde..9850ecde5d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -919,7 +919,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 		git config fetch.unpackLimit 1 &&
 		git config gc.autoPackLimit 1 &&
 		git config gc.autoDetach false &&
-		GIT_ASK_YESNO="$D/askyesno" git fetch >fetch.out 2>&1 &&
+		GIT_ASK_YESNO="$D/askyesno" git fetch --verbose >fetch.out 2>&1 &&
 		test_i18ngrep "Auto packing the repository" fetch.out &&
 		! grep "Should I try again" fetch.out
 	)
-- 
gitgitgadget

