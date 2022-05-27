Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B6AC433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354410AbiE0T4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiE0T4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:56:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAAF6347
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:20 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t13so7197134wrg.9
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ml9nxLe19SuIVlRfZx0hIsDOgngXr+ulhYqFNkwtq/M=;
        b=jaKrGa7EQRVhHfuhYEUDihrCqoPcQTDYp01gEkUsfBuYJk3Z/MYK2OPNMIZfHF/t0A
         uwfQnNHiTHv7jGjW1QFPCqQfoDlaXdXK8/ccm53wblpGLyf7wFE1w9L0WUKmL/wkBL3f
         Bw+z7w7ePZcQUMIcAtTIS2SFEqmyunLT9PjG/YrBNrj2+9zgLU4SgFbwKi8ZCmADD6qP
         dSOcleORoFylqA7XcsGyFFddk0BtJp/jp0X/BLMIzJp0/aSyv236eOs9paVzaaYJE7AR
         5zzndYPA0jrBQhTnNkKFICgpXAYb4haettZoNQ4LrqWxR2KoegsvhFnfx+xlUdLtfVEP
         aaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ml9nxLe19SuIVlRfZx0hIsDOgngXr+ulhYqFNkwtq/M=;
        b=f/AHbMFsfEumB7V4L7YhhSpdJmYuTXI3bvD14QAVeaIWQ6DkSwlx2ScDMk0PYWk805
         pPFa0n+8RPnsOeh7DRhgaElaj12DsQuDpQrqYpCQEzHZxGquFZlqk6H8e+iLoFg+Jkle
         nFoDJn/uMuUWaYFiI9lhhzy08W+vHwGDzCOwqPhQ0uGRDBl0vAJ4PtLwO+Wwhdujz4Os
         gWDzBNjFb4T852h8nvQsfHzlSbTl39FHnN7D2wW/BN35/tRe3Y9uAFwtlNOQz/lk7PGT
         QeEMFRCZ8C+vkZCE/+jHA7tRLiiOtDcK44TEa812xLJFVE8kd9qAOeFnDEIraEvheSBO
         km9A==
X-Gm-Message-State: AOAM531uJTImwD3mHfLFO10MAzmTera6Mnr+L+XfEPHCqdCq+slbR9b3
        SVxbN/c6yIiXfR6bV+OnprQ=
X-Google-Smtp-Source: ABdhPJxgDsjLMMuPtXlf+dKBWyEjA9M8T3sGV6sWUyxA0ASiYqBHD5qEEwrUFG0xBGIDyA4pMQ/y5w==
X-Received: by 2002:a05:6000:81:b0:20f:ff3d:22b2 with SMTP id m1-20020a056000008100b0020fff3d22b2mr11801041wrx.558.1653681378384;
        Fri, 27 May 2022 12:56:18 -0700 (PDT)
Received: from jonathan-ubuntu.univ-lyon1.fr (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c0287000000b0039748be12dbsm3041350wmc.47.2022.05.27.12.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:56:17 -0700 (PDT)
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
To:     git.jonathan.bressat@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        jonathan.bressat@etu.univ-lyon1.fr
Subject: [PATCH v2 0/4] Be nicer to the user on tracked/untracked merge conflicts
Date:   Fri, 27 May 2022 21:55:41 +0200
Message-Id: <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
X-Mailer: git-send-email 2.35.1.10.g88248585b1.dirty
In-Reply-To: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We improve our last patch with adding an option to merge and pull command and a
configuration variable.
This make the user able to modify the behavior of merge when it meet untracked files
that have the same content than files in merged branch.

We kept the old behavior as default.

thanks

Jonathan Bressat and 
Guillaume Cogoni

Jonathan Bressat (4):
  t6436: tests how merge behave when there is untracked file with the
    same content
  merge with untracked file that are the same without failure
  add configuration variable corresponding to --overwrite-same-content
  error message now advice to use the new option

 Documentation/config/merge.txt |  5 ++
 Documentation/git-merge.txt    |  4 ++
 builtin/checkout.c             |  1 +
 builtin/merge.c                |  9 +++-
 builtin/pull.c                 |  8 +++-
 cache.h                        |  3 +-
 merge-ort.c                    |  1 +
 merge-recursive.h              |  1 +
 merge.c                        |  4 +-
 sequencer.c                    |  2 +-
 t/t6436-merge-overwrite.sh     | 34 ++++++++++++++
 t/t7615-merge-untracked.sh     | 84 ++++++++++++++++++++++++++++++++++
 unpack-trees.c                 | 27 +++++++++--
 unpack-trees.h                 |  2 +
 14 files changed, 174 insertions(+), 11 deletions(-)
 create mode 100755 t/t7615-merge-untracked.sh

Interdiff contre v1 :
diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 99e83dd36e..2824dd19c7 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -89,6 +89,11 @@ merge.autoStash::
 	`--autostash` options of linkgit:git-merge[1].
 	Defaults to false.
 
+merge.overwritesamecontent::
+    When set to true, it will modify the behavior of git merge 
+    to overwrite untracked files that have the same name and 
+    content than files in the merged commit.	
+
 merge.tool::
 	Controls which merge tool is used by linkgit:git-mergetool[1].
 	The list below shows the valid built-in values.
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 3125473cc1..ceda0271c2 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -100,6 +100,10 @@ will be appended to the specified message.
 	Silently overwrite ignored files from the merge result. This
 	is the default behavior. Use `--no-overwrite-ignore` to abort.
 
+--overwrite-same-content::
+       Silently overwrite untracked files that have the same content 
+       and name than files in the merged commit from the merge result.
+
 --abort::
 	Abort the current conflict resolution process, and
 	try to reconstruct the pre-merge state. If an autostash entry is
diff --git a/builtin/checkout.c b/builtin/checkout.c
index cc804ba8e1..1b1d1813c7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -760,6 +760,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 				       &new_branch_info->commit->object.oid :
 				       &new_branch_info->oid, NULL);
 		topts.preserve_ignored = !opts->overwrite_ignore;
+		topts.overwrite_same_content = 0;/* FIXME: opts->overwrite_same_content */
 		tree = parse_tree_indirect(old_branch_info->commit ?
 					   &old_branch_info->commit->object.oid :
 					   the_hash_algo->empty_tree);
diff --git a/builtin/merge.c b/builtin/merge.c
index 74e53cf20a..936cb8480d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -68,6 +68,7 @@ static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
 static int check_trust_level = 1;
 static int overwrite_ignore = 1;
+static int overwrite_same_content;
 static struct strbuf merge_msg = STRBUF_INIT;
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
@@ -305,6 +306,7 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_BOOL(0, "signoff", &signoff, N_("add a Signed-off-by trailer")),
 	OPT_BOOL(0, "no-verify", &no_verify, N_("bypass pre-merge-commit and commit-msg hooks")),
+	OPT_BOOL(0, "overwrite-same-content", &overwrite_same_content, N_("overwrite untracked file with the same content and name")),
 	OPT_END()
 };
 
@@ -656,6 +658,8 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	} else if (!strcmp(k, "merge.autostash")) {
 		autostash = git_config_bool(k, v);
 		return 0;
+	} else if (!strcmp(k,"merge.overwritesamecontent")) {
+		overwrite_same_content = git_config_bool(k, v);
 	}
 
 	status = fmt_merge_msg_config(k, v, cb);
@@ -684,6 +688,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
 	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	opts.overwrite_same_content = overwrite_same_content;
 	trees[nr_trees] = parse_tree_indirect(common);
 	if (!trees[nr_trees++])
 		return -1;
@@ -746,6 +751,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		o.branch1 = head_arg;
 		o.branch2 = merge_remote_util(remoteheads->item)->name;
+		o.overwrite_same_content = overwrite_same_content;
 
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
@@ -1573,7 +1579,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
-					  overwrite_ignore)) {
+					  overwrite_ignore,
+					  overwrite_same_content)) {
 			apply_autostash(git_path_merge_autostash(the_repository));
 			ret = 1;
 			goto done;
diff --git a/builtin/pull.c b/builtin/pull.c
index 100cbf9fb8..46ef68e721 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -92,6 +92,7 @@ static struct strvec opt_strategies = STRVEC_INIT;
 static struct strvec opt_strategy_opts = STRVEC_INIT;
 static char *opt_gpg_sign;
 static int opt_allow_unrelated_histories;
+static int opt_overwrite_same_content;
 
 /* Options passed to git-fetch */
 static char *opt_all;
@@ -182,6 +183,7 @@ static struct option pull_options[] = {
 	OPT_SET_INT(0, "allow-unrelated-histories",
 		    &opt_allow_unrelated_histories,
 		    N_("allow merging unrelated histories"), 1),
+	OPT_BOOL(0, "overwrite-same-content", &opt_overwrite_same_content, N_("overwrite untracked file with the same content and name")),
 
 	/* Options passed to git-fetch */
 	OPT_GROUP(N_("Options related to fetching")),
@@ -612,7 +614,7 @@ static int pull_into_void(const struct object_id *merge_head,
 	 */
 	if (checkout_fast_forward(the_repository,
 				  the_hash_algo->empty_tree,
-				  merge_head, 0))
+				  merge_head, 0, opt_overwrite_same_content))
 		return 1;
 
 	if (update_ref("initial pull", "HEAD", merge_head, curr_head, 0, UPDATE_REFS_DIE_ON_ERR))
@@ -679,6 +681,8 @@ static int run_merge(void)
 		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
 	if (opt_ff)
 		strvec_push(&args, opt_ff);
+	if (opt_overwrite_same_content)
+		strvec_push(&args, "--overwrite-same-content");
 	if (opt_verify)
 		strvec_push(&args, opt_verify);
 	if (opt_verify_signatures)
@@ -1078,7 +1082,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"commit %s."), oid_to_hex(&orig_head));
 
 		if (checkout_fast_forward(the_repository, &orig_head,
-					  &curr_head, 0))
+					  &curr_head, 0, opt_overwrite_same_content))
 			die(_("Cannot fast-forward your working tree.\n"
 				"After making sure that you saved anything precious from\n"
 				"$ git diff %s\n"
diff --git a/cache.h b/cache.h
index 281f00ab1b..163367ab41 100644
--- a/cache.h
+++ b/cache.h
@@ -1858,7 +1858,8 @@ int try_merge_command(struct repository *r,
 int checkout_fast_forward(struct repository *r,
 			  const struct object_id *from,
 			  const struct object_id *to,
-			  int overwrite_ignore);
+			  int overwrite_ignore,
+			  int overwrite_same_content);
 
 
 int sane_execvp(const char *file, char *const argv[]);
diff --git a/merge-ort.c b/merge-ort.c
index c319797021..a8d1496b4a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4066,6 +4066,7 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.verbose_update = (opt->verbosity > 2);
 	unpack_opts.fn = twoway_merge;
 	unpack_opts.preserve_ignored = 0; /* FIXME: !opts->overwrite_ignore */
+	unpack_opts.overwrite_same_content = opt->overwrite_same_content;
 	parse_tree(prev);
 	init_tree_desc(&trees[0], prev->buffer, prev->size);
 	parse_tree(next);
diff --git a/merge-recursive.h b/merge-recursive.h
index 0795a1d3ec..6f8c5678e0 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -46,6 +46,7 @@ struct merge_options {
 	/* miscellaneous control options */
 	const char *subtree_shift;
 	unsigned renormalize : 1;
+	int overwrite_same_content;
 
 	/* internal fields used by the implementation */
 	struct merge_options_internal *priv;
diff --git a/merge.c b/merge.c
index 2382ff66d3..410c92d235 100644
--- a/merge.c
+++ b/merge.c
@@ -47,7 +47,8 @@ int try_merge_command(struct repository *r,
 int checkout_fast_forward(struct repository *r,
 			  const struct object_id *head,
 			  const struct object_id *remote,
-			  int overwrite_ignore)
+			  int overwrite_ignore,
+			  int overwrite_same_content)
 {
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
@@ -80,6 +81,7 @@ int checkout_fast_forward(struct repository *r,
 
 	memset(&opts, 0, sizeof(opts));
 	opts.preserve_ignored = !overwrite_ignore;
+	opts.overwrite_same_content = overwrite_same_content;
 
 	opts.head_idx = 1;
 	opts.src_index = r->index;
diff --git a/sequencer.c b/sequencer.c
index 5213d16e97..d11802c542 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -529,7 +529,7 @@ static int fast_forward_to(struct repository *r,
 	struct strbuf err = STRBUF_INIT;
 
 	repo_read_index(r);
-	if (checkout_fast_forward(r, from, to, 1))
+	if (checkout_fast_forward(r, from, to, 1, 0))
 		return -1; /* the callee should have complained already */
 
 	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index c0b7bd7c3f..bb323b1ee3 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -204,4 +204,38 @@ test_expect_success 'will not clobber WT/index when merging into unborn' '
 	grep bar untracked-file
 '
 
+test_expect_success 'create branch A' '
+	git reset --hard c0 &&
+	git checkout -b A
+'
+
+test_expect_success 'fastforward will not overwrite untracked file with the same content' '
+	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
+test_expect_success 'will not overwrite untracked file with the same content' '
+	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git checkout A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
+test_expect_success 'will not overwrite unstaged file with the same content' '
+	test_when_finished "git branch -D B && git reset --hard c0 && git clean --force" &&
+	test_commit --no-tag "unstaged" file "other" &&
+	git checkout -b B &&
+	test_commit --no-tag "staged" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	test_must_fail git merge B
+'
+
 test_done
diff --git a/t/t7615-merge-untracked.sh b/t/t7615-merge-untracked.sh
index 99f8bae4c0..cfefd8f473 100755
--- a/t/t7615-merge-untracked.sh
+++ b/t/t7615-merge-untracked.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='test when merge with untracked file'
+test_description='test when merge with untracked files and the option --overwrite-same-content'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -18,7 +18,7 @@ test_expect_success 'fastforward overwrite untracked file that has the same cont
 	test_commit --no-tag "tracked" file "content" &&
 	git checkout A &&
 	echo content >file &&
-	git merge B
+	git merge --overwrite-same-content B
 '
 
 test_expect_success 'fastforward fail when untracked file has different content' '
@@ -27,7 +27,7 @@ test_expect_success 'fastforward fail when untracked file has different content'
 	test_commit --no-tag "tracked" file "content" &&
 	git switch A &&
 	echo other >file &&
-	test_must_fail git merge B
+	test_must_fail git merge --overwrite-same-content B
 '
 
 test_expect_success 'normal merge overwrite untracked file that has the same content' '
@@ -37,7 +37,7 @@ test_expect_success 'normal merge overwrite untracked file that has the same con
 	git switch A &&
 	test_commit --no-tag "exA" fileA "content" &&
 	echo content >file &&
-	git merge B
+	git merge --overwrite-same-content B
 '
 
 test_expect_success 'normal merge fail when untracked file has different content' '
@@ -47,7 +47,7 @@ test_expect_success 'normal merge fail when untracked file has different content
 	git switch A &&
 	test_commit --no-tag "exA" fileA "content" &&
 	echo dif >file &&
-	test_must_fail git merge B
+	test_must_fail git merge --overwrite-same-content B
 '
 
 test_expect_success 'merge fail when tracked file modification is unstaged' '
@@ -57,7 +57,28 @@ test_expect_success 'merge fail when tracked file modification is unstaged' '
 	test_commit --no-tag "staged" file "content" &&
 	git switch A &&
 	echo content >file &&
-	test_must_fail git merge B
+	test_must_fail git merge --overwrite-same-content B
+'
+
+test_expect_success 'fastforward overwrite untracked file that has the same content with the configuration variable' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	test_config merge.overwritesamecontent true &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	git merge B
+'
+
+test_expect_success 'normal merge overwrite untracked file that has the same content with the configuration variable' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	test_config merge.overwritesamecontent true &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git switch A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo content >file &&
+	git merge B
 '
 
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 61e06c04be..6c660b084b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -158,17 +158,17 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	if (!strcmp(cmd, "checkout"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by checkout:\n%%s"
-			  "Please move or remove them before you switch branches.")
+			  "Please move or remove them before you switch branches.%%s")
 		      : _("The following untracked working tree files would be overwritten by checkout:\n%%s");
 	else if (!strcmp(cmd, "merge"))
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by merge:\n%%s"
-			  "Please move or remove them before you merge.")
+			  "Please move or remove them before you merge.%%s")
 		      : _("The following untracked working tree files would be overwritten by merge:\n%%s");
 	else
 		msg = advice_enabled(ADVICE_COMMIT_BEFORE_MERGE)
 		      ? _("The following untracked working tree files would be overwritten by %s:\n%%s"
-			  "Please move or remove them before you %s.")
+			  "Please move or remove them before you %s.%%s")
 		      : _("The following untracked working tree files would be overwritten by %s:\n%%s");
 	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] =
 		strvec_pushf(&opts->msgs_to_free, msg, cmd, cmd);
@@ -251,6 +251,14 @@ static void display_error_msgs(struct unpack_trees_options *o)
 {
 	int e;
 	unsigned error_displayed = 0;
+	const char *can_overwrite_msg;
+
+	if (o->can_overwrite) {
+		can_overwrite_msg = _("\nYou can also rerun the command with --overwrite-same-content to overwrite files with same content.");
+	} else {
+		can_overwrite_msg = "";
+	}
+
 	for (e = 0; e < NB_UNPACK_TREES_ERROR_TYPES; e++) {
 		struct string_list *rejects = &o->unpack_rejects[e];
 
@@ -261,7 +269,8 @@ static void display_error_msgs(struct unpack_trees_options *o)
 			error_displayed = 1;
 			for (i = 0; i < rejects->nr; i++)
 				strbuf_addf(&path, "\t%s\n", rejects->items[i].string);
-			error(ERRORMSG(o, e), super_prefixed(path.buf));
+
+			error(ERRORMSG(o, e), super_prefixed(path.buf), can_overwrite_msg);
 			strbuf_release(&path);
 		}
 		string_list_clear(rejects, 0);
@@ -1711,6 +1720,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	struct pattern_list pl;
 	int free_pattern_list = 0;
 	struct dir_struct dir = DIR_INIT;
+	o->can_overwrite = 1;
 
 	if (o->reset == UNPACK_RESET_INVALID)
 		BUG("o->reset had a value of 1; should be UNPACK_TREES_*_UNTRACKED");
@@ -2257,8 +2267,12 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (result) {
 		if (result->ce_flags & CE_REMOVE)
 			return 0;
-	} else if (!ie_modified(&o->result, ce, st, 0)) {
-		return 0;
+	} else if (ce && !ie_modified(o->src_index, ce, st, 0)) {
+		if(o->overwrite_same_content) {
+			return 0;
+		}
+	} else {
+		o->can_overwrite = 0;
 	}
 
 	return add_rejected_path(o, error_type, name);
@@ -2266,8 +2280,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 
 /*
  * We do not want to remove or overwrite a working tree file that
- * is not tracked, unless it is ignored and unless it has the same
- * content than the merged file.
+ * is not tracked, unless it is ignored or it has the same content
+ * than the merged file with the option --overwrite_same_content.
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
diff --git a/unpack-trees.h b/unpack-trees.h
index efb9edfbb2..2be74ce5bf 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -71,6 +71,8 @@ struct unpack_trees_options {
 		     quiet,
 		     exiting_early,
 		     show_all_errors,
+		     overwrite_same_content,
+		     can_overwrite,
 		     dry_run;
 	enum unpack_trees_reset_type reset;
 	const char *prefix;
-- 
2.35.1.10.g88248585b1.dirty

