Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189B2C433EC
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7448206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 17:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdVCwP0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgGWR4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWR4q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 13:56:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD7EC0619DC
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so5998644wmf.5
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=olS31h0DH7u13Xtqz7Dz86pUcZJw5EBVhiIhrGFQSSI=;
        b=AdVCwP0wrGGldhSuVwke1PhohTjx0X63JMko7j6KGRSu9lzGP5hFutUd1byzXzJbBI
         Pwyu8T8BZIprbKherO68WSwHowqXFmA/oPj9Yna7YlCjIYg9Pt6Ysb7XsENmHuk77FP4
         xOZ5oiq16Zz/3R92TJccVGSQOfdoz7QqDG+Fhiu97W+CejaDe45saiK+Pz2QXHfruCOs
         B1HlD+uohJib/Y31RHPzbKLNs4k5sKPvYx6wA8+Z3jXBWuPzgiZ3tVgjFXWj1huKDwfe
         nGJ7ZCAXS5d35Iz7g+nT0A2oOBiNcfnl0AjJzISZ1lYFjphDu4fL3vwnonvNxGm12gdm
         lacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=olS31h0DH7u13Xtqz7Dz86pUcZJw5EBVhiIhrGFQSSI=;
        b=izUWi/Z7sXnrDWuU5yxTJOWAfcTm4lenqmS5SQ17nqMQuvF4eBlf20AUmQndCO5wJ2
         aUBEy2sy9n7S1VRwQzPmDebdae3WH3OKY9BvBfRuTMvlMePyLLRy5p0uf7LF9VgwZW4s
         7UAhfhoTIvVZyjuckTFogJuI6ZSQqqBa14//P8fg/+KnKEqtSXTh34mcSSUN9CrSLzcH
         sN/dtkr/3ELSNoD4ORbUU08jkkR89unnZDU0FnuXK5TtYS5hoSzwB68Ty+2bPjr48c/v
         Ce7rFvb3Iud+RUbRpYqOaFw1q9Y/PUxpmm/IY+8iM6Mi1bpFCXnP1jikh6CWlS2K4NkO
         DXkQ==
X-Gm-Message-State: AOAM533WLK1an0gRZlLp/FBZYOiQca5r+EQA2tzvtdNMOn6i4p1+qeXY
        ID+SBHGULKZ+/Jwazyqwm3aHemIP
X-Google-Smtp-Source: ABdhPJwHUAuK+HNT7V5UX6jxT3vMkqN8gL3zpnMb/LibME77y5dUPeCB+oy/LEnHcCCycVr3UOM3vQ==
X-Received: by 2002:a7b:c244:: with SMTP id b4mr3248782wmj.14.1595527004836;
        Thu, 23 Jul 2020 10:56:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm4882097wro.84.2020.07.23.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:56:44 -0700 (PDT)
Message-Id: <f164d1a0b4363eb6eb174e90e88211829f8a1d55.1595527000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:56:25 +0000
Subject: [PATCH v2 03/18] maintenance: replace run_auto_gc()
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

Since 'git fetch' already allows disabling the 'git gc --auto'
subprocess, add an equivalent option with a different name to be more
descriptive of the new behavior: '--[no-]maintenance'. Update the
documentation to include these options at the same time.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/fetch-options.txt | 5 +++--
 Documentation/git-clone.txt     | 7 ++++---
 builtin/am.c                    | 2 +-
 builtin/commit.c                | 2 +-
 builtin/fetch.c                 | 6 ++++--
 builtin/merge.c                 | 2 +-
 builtin/rebase.c                | 4 ++--
 run-command.c                   | 7 +++++--
 run-command.h                   | 2 +-
 t/t5510-fetch.sh                | 2 +-
 10 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 6e2a160a47..d73224844e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -86,9 +86,10 @@ ifndef::git-pull[]
 	Allow several <repository> and <group> arguments to be
 	specified. No <refspec>s may be specified.
 
+--[no-]maintenance::
 --[no-]auto-gc::
-	Run `git gc --auto` at the end to perform garbage collection
-	if needed. This is enabled by default.
+	Run `git maintenance run --auto` at the end to perform garbage
+	collection if needed. This is enabled by default.
 
 --[no-]write-commit-graph::
 	Write a commit-graph after fetching. This overrides the config
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c898310099..aa25aba7d9 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -78,9 +78,10 @@ repository using this option and then delete branches (or use any
 other Git command that makes any existing commit unreferenced) in the
 source repository, some objects may become unreferenced (or dangling).
 These objects may be removed by normal Git operations (such as `git commit`)
-which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
-If these objects are removed and were referenced by the cloned repository,
-then the cloned repository will become corrupt.
+which automatically call `git maintenance run --auto` and `git gc --auto`.
+(See linkgit:git-maintenance[1] and linkgit:git-gc[1].) If these objects
+are removed and were referenced by the cloned repository, then the cloned
+repository will become corrupt.
 +
 Note that running `git repack` without the `--local` option in a repository
 cloned with `--shared` will copy objects from the source repository into a pack
diff --git a/builtin/am.c b/builtin/am.c
index 69e50de018..ff895125f6 100644
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
index d1b7396052..658b158659 100644
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
index 82ac4be8a5..49a4d727d4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -196,8 +196,10 @@ static struct option builtin_fetch_options[] = {
 	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 			N_("report that we have only objects reachable from this object")),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+	OPT_BOOL(0, "maintenance", &enable_auto_gc,
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
index 37ba76ac3d..0c4ee98f08 100644
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
index 9b3a57d1e3..82ad241638 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1865,14 +1865,17 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
 	return result;
 }
 
-int run_auto_gc(int quiet)
+int run_auto_maintenance(int quiet)
 {
 	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
 	int status;
 
-	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+	argv_array_pushl(&argv_gc_auto, "maintenance", "run", "--auto", NULL);
 	if (quiet)
 		argv_array_push(&argv_gc_auto, "--quiet");
+	else
+		argv_array_push(&argv_gc_auto, "--no-quiet");
+
 	status = run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
 	argv_array_clear(&argv_gc_auto);
 	return status;
diff --git a/run-command.h b/run-command.h
index 191dfcdafe..d9a800e700 100644
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

