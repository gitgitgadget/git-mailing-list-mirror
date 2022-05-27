Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FA5C433EF
	for <git@archiver.kernel.org>; Fri, 27 May 2022 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354553AbiE0T4g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 15:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiE0T42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 15:56:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909E86347
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t6so7223964wra.4
        for <git@vger.kernel.org>; Fri, 27 May 2022 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OK/u+nYB8Jso0m33dWgenayhg4kdTpKIS44FHyTSv/w=;
        b=T6wwB1jh08xPQHguE4y7v9vcEacBdR0jD47HhG2h6c6bCUvAH7FvwbyESe11SiwtdS
         /OKkbSEEqST2gJio/pS7WgLnfGBYQOlSTd+76QC9aa1g+jel2856ZYmefrngAbtl4/iP
         mCstBukm8H+kY3wwf7ft85oHUEtFeFMygTFc4JadW6cjzpLSLMmxvg+OAWCVKI4D3k2N
         Vsh4+cVxPvtPX9nQbrM7HhyG5XFCCRF5RW4n5ZYlV8P285pP9rku6JOBWGxmR9n7ZQHq
         cR9v6HRm0SkEc/BZxZjF8CbJLDDRSHImh2XLSdk5T3fTQpIqV4k+azGu91Pg9cSj6bzi
         v5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OK/u+nYB8Jso0m33dWgenayhg4kdTpKIS44FHyTSv/w=;
        b=Qg5/xig/88fEAEcQQVJSYOouWte0jUdtazQtotTsyboJq9mM4OwfnNX4skmdTvgb4f
         ocXGx4zh08CadbqXdct47EA8nD6Fi+lXv1NdqhoEyGFm+zJ0SLmCZZauZbQ0QzmSmhf6
         4eQSLrAKQYzWCj8DaBZQStsr4NIseOusJiiaHgm87AglyBuorU6pZlQr6gKYeaQMPGse
         sTJQTInB3xipy9gtfGiWANu1uQn9WW1opgMIfRRelZiAE/hoAlISFfXpO0VhAVZL7ssL
         6XCoP7ocfwMIXiwEp4RyiuGMCKIeTwQtkTtTi4bmQmokKwtrw9+8oSVBCeh/aUI1IXqx
         H+Cw==
X-Gm-Message-State: AOAM533kDCT/U49353mfMsFQKjqZmtQ1aXoUFlk0EmpJP/qPRyjQKiTg
        S+rk5J2CrMF/BgrRWKMeYds=
X-Google-Smtp-Source: ABdhPJxmmaCuFwmYYVexxj3u4PyCwJPFF9L+RSvewopDG2+fGVADeaZl3b3+sReqCdzr1Fp8gWFXUQ==
X-Received: by 2002:a5d:5003:0:b0:20f:fe68:1dc4 with SMTP id e3-20020a5d5003000000b0020ffe681dc4mr12090972wrt.405.1653681382054;
        Fri, 27 May 2022 12:56:22 -0700 (PDT)
Received: from jonathan-ubuntu.univ-lyon1.fr (123.79.195.77.rev.sfr.net. [77.195.79.123])
        by smtp.gmail.com with ESMTPSA id 129-20020a1c0287000000b0039748be12dbsm3041350wmc.47.2022.05.27.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 12:56:21 -0700 (PDT)
From:   Jonathan Bressat <git.jonathan.bressat@gmail.com>
To:     git.jonathan.bressat@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        jonathan.bressat@etu.univ-lyon1.fr
Subject: [PATCH v2 2/4] merge with untracked file that are the same without failure
Date:   Fri, 27 May 2022 21:55:43 +0200
Message-Id: <20220527195545.33984-3-git.jonathan.bressat@gmail.com>
X-Mailer: git-send-email 2.35.1.10.g88248585b1.dirty
In-Reply-To: <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
References: <CANteD_zD9ViBi5woHycU_CR1rJcv7YjKDFDiKTA8de04yrTs5Q@mail.gmail.com>
 <20220527195545.33984-1-git.jonathan.bressat@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep the old behavior as default.

Add the option --overwrite-same-content, when this option is used merge
will overwrite untracked file that have the same content.

It make the merge nicer to the user, usefull for a simple utilisation,
for exemple if you copy and paste files from another project and then
you decide to pull this project, git will not proceed even if you didn't
modify those files.

t7615 tests this new behavior.

Signed-off-by: Jonathan Bressat <git.jonathan.bressat@gmail.com>
Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
---
 Documentation/git-merge.txt |  4 +++
 builtin/merge.c             |  7 ++++-
 builtin/pull.c              |  8 +++--
 cache.h                     |  3 +-
 merge-ort.c                 |  1 +
 merge-recursive.h           |  1 +
 merge.c                     |  4 ++-
 sequencer.c                 |  2 +-
 t/t7615-merge-untracked.sh  | 63 +++++++++++++++++++++++++++++++++++++
 unpack-trees.c              |  7 ++++-
 unpack-trees.h              |  1 +
 11 files changed, 94 insertions(+), 7 deletions(-)
 create mode 100755 t/t7615-merge-untracked.sh

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
diff --git a/builtin/merge.c b/builtin/merge.c
index 74e53cf20a..fffae81068 100644
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
 
@@ -684,6 +686,7 @@ static int read_tree_trivial(struct object_id *common, struct object_id *head,
 	opts.trivial_merges_only = 1;
 	opts.merge = 1;
 	opts.preserve_ignored = 0; /* FIXME: !overwrite_ignore */
+	opts.overwrite_same_content = overwrite_same_content;
 	trees[nr_trees] = parse_tree_indirect(common);
 	if (!trees[nr_trees++])
 		return -1;
@@ -746,6 +749,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 
 		o.branch1 = head_arg;
 		o.branch2 = merge_remote_util(remoteheads->item)->name;
+		o.overwrite_same_content = overwrite_same_content;
 
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
@@ -1573,7 +1577,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
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
diff --git a/t/t7615-merge-untracked.sh b/t/t7615-merge-untracked.sh
new file mode 100755
index 0000000000..05a34cf03f
--- /dev/null
+++ b/t/t7615-merge-untracked.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+test_description='test when merge with untracked files and the option --overwrite-same-content'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit "init" README.md "content" &&
+	git checkout -b A
+'
+
+test_expect_success 'fastforward overwrite untracked file that has the same content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git checkout A &&
+	echo content >file &&
+	git merge --overwrite-same-content B
+'
+
+test_expect_success 'fastforward fail when untracked file has different content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" &&
+	git switch A &&
+	echo other >file &&
+	test_must_fail git merge --overwrite-same-content B
+'
+
+test_expect_success 'normal merge overwrite untracked file that has the same content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git switch A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo content >file &&
+	git merge --overwrite-same-content B
+'
+
+test_expect_success 'normal merge fail when untracked file has different content' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	git checkout -b B &&
+	test_commit --no-tag "tracked" file "content" fileB "content" &&
+	git switch A &&
+	test_commit --no-tag "exA" fileA "content" &&
+	echo dif >file &&
+	test_must_fail git merge --overwrite-same-content B
+'
+
+test_expect_success 'merge fail when tracked file modification is unstaged' '
+	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
+	test_commit --no-tag "unstaged" file "other" &&
+	git checkout -b B &&
+	test_commit --no-tag "staged" file "content" &&
+	git switch A &&
+	echo content >file &&
+	test_must_fail git merge --overwrite-same-content B
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 360844bda3..1a52be723e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2257,6 +2257,10 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 	if (result) {
 		if (result->ce_flags & CE_REMOVE)
 			return 0;
+	} else if (ce && !ie_modified(o->src_index, ce, st, 0)) {
+		if(o->overwrite_same_content) {
+			return 0;
+		}
 	}
 
 	return add_rejected_path(o, error_type, name);
@@ -2264,7 +2268,8 @@ static int check_ok_to_remove(const char *name, int len, int dtype,
 
 /*
  * We do not want to remove or overwrite a working tree file that
- * is not tracked, unless it is ignored.
+ * is not tracked, unless it is ignored or it has the same content
+ * than the merged file with the option --overwrite_same_content.
  */
 static int verify_absent_1(const struct cache_entry *ce,
 			   enum unpack_trees_error_types error_type,
diff --git a/unpack-trees.h b/unpack-trees.h
index efb9edfbb2..ebe4be0b35 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -71,6 +71,7 @@ struct unpack_trees_options {
 		     quiet,
 		     exiting_early,
 		     show_all_errors,
+		     overwrite_same_content,
 		     dry_run;
 	enum unpack_trees_reset_type reset;
 	const char *prefix;
-- 
2.35.1.10.g88248585b1.dirty

