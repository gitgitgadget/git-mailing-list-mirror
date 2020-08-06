Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D3AC433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD45206B2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUnOU+0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgHFR4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHFQRX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B784C002140
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 08:48:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so41498977wrx.9
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=haPdcuSHV4uqg9oVGnsbasRCEzOuPwsFJKkmpIY23OQ=;
        b=kUnOU+0JRbS6XAwYWZw7+V9JxzxmobZeQN8P4unwnyUxJNQk8sgOIA4/DJ53MWv8Hh
         VnUr38A4Ei37OGzbEOl+DBLp8k/zKtp3wFF0uxeNbBeEXbCSAL4zbE3/Ysp291nwfepO
         QPU6FaXQgPxWw3HLnK6wOxyzwp6uzPnDHrHbFotXDdX9NATdC3sRegzZlx+uvtkyQzS9
         Gk47fGnOZYlyX+7f0yuGpWWzqw2YmYEdB0di/E1pMTx29mf1+jk6VkVsnZV7gHHl6y8P
         qx/Q16Bl47UI2DR89rqd8cpKbi/nGOY7gCOi0yGtM536w1hxydnlWKbRYIa7dJ5IZal8
         NBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=haPdcuSHV4uqg9oVGnsbasRCEzOuPwsFJKkmpIY23OQ=;
        b=lHyBhRO3FCesCcGtsudHPgulDsCf/IbyxBYzndYOYcIKF+8y8PEOh/DAV+78WxWbeX
         ZSEU9YcQi7byURgX16PeIeM3E6Cx5olSZ9Gvp9MHP7xNTruFYGhz8Ls4ddi6iC50G7uI
         EV+3o4+WEiP1oD50bLSj8ZkKEZeI9cvu5HvN6PykOrSUPc5gNDDb98QIOoSjzrtqxMUB
         IyRZfROqeWB7Dtysgvii4IxGTBrdxMvMduwP/ak+M75AK172fD/WsLZIKdjMXQeebG0b
         KWf9b4ddG1zCxDB5yg1f+4MXBMUM3Jnuzx9T0zTPSkAE9Bd2UFNCR1WVZeJpA/UC/wi+
         dqCw==
X-Gm-Message-State: AOAM5332oRUlhzw8vDq1tf0OgkrFFknFc6ayxDua8awNtYp6nwgTsCSQ
        NlMuazjQxPFDuDAlQHVLZltgmKvq
X-Google-Smtp-Source: ABdhPJxJtNZd1aH9NDwlsAJDEe6XxMTAC54fPYWoLqeWrQ+KpNux/maC5PEpBIXPYDvj0Sz8tNzNmw==
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr7533334wrc.134.1596728926251;
        Thu, 06 Aug 2020 08:48:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v16sm3928373wmj.14.2020.08.06.08.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:48:45 -0700 (PDT)
Message-Id: <233811310b6536f4287d0ebb0ab869a526dc04c6.1596728921.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.git.1596728921.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Aug 2020 15:48:33 +0000
Subject: [PATCH 03/11] maintenance: replace run_auto_gc()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
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
index dd4e6c2d9b..68e9d17379 100644
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
index 69ac78d5e5..f9b0a0c05d 100644
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
index c49f0e9752..c8b9366d3c 100644
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
index dadb52fa92..9ffba9009d 100644
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
index cc9c3296ba..2ee59acdc8 100644
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
-	status = run_command_v_opt(argv_gc_auto.v, RUN_GIT_CMD);
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

