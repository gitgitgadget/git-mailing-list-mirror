Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE686FA3740
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 04:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJaEMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 00:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiJaEL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 00:11:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C5B1C6
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 21:11:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y16so14229775wrt.12
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 21:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2HQeezU5I+c53W/O9XKVz0+N6z0rUo9xfbXthCtRmNU=;
        b=Y8kvfDgLLUg+Wqo4xmoqQrJpXwdGTWzuAZoGtwNby85ou1y2oQ8xmUttLgKNBeK4qw
         pjCfhqSCruU+eI8/6vM2sDe4H64K5gm11p2CPr+JzXVWW+5zKrywm6BwwX4PRzCYb9wG
         hZBICSIFd4sB6ZabHqxRKo18KO0PNRtG01err0aDpFu/9QlA5EoMUL454126LAcbp0+H
         3WhKKNqFqX22B7uKFmHpPyK1SzzVdRMEvhrn2UQpKdu1eocl+/bpjHK1ThYm5R2iPHyb
         fXcdOqHRNcltNnkdpO9vdyMPTntrrkyAZnyL7MTOWGQgZWXixcSVzqyoNqAUjUK9UQua
         NjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HQeezU5I+c53W/O9XKVz0+N6z0rUo9xfbXthCtRmNU=;
        b=4JUizv+DLSR4joJpS11F9h/zEiQrm39ecvjpZq3pHzTFwdqqBi66KEIuiozRoPOmv0
         NYNjw9E1w8sSt2e2ouWJ71+nmWbPYk0PEO38zCEjsGSeRr4XpPRnfZUYAIvD9dT5vIqX
         XZRs5LKrNLxrXAgfX4sa6ojnuV+m4RfwQ5FoOUevZUZ/KXdABegp91S7KpPLIL0ivaWw
         hf8UIeBlew5p27C+8T+4KBb/bFcph6a9GoWLpop3D/VNVvqGb8vtifOXwdaYHWFQrTw7
         H1rCcbIAbOemksYXlywvanYkm3Qa9YoeK2BAapDbPw062c/edA2qPjbm4d67IIGuzEhB
         MN4Q==
X-Gm-Message-State: ACrzQf0yvV02mIL5uIbF5zm1iUCFt2RiTWXXsBa2Ju3AHgaKjd9TjlXH
        8FAQKyOUhkfe4OBPXcCYFbT6Pv4EnKc=
X-Google-Smtp-Source: AMsMyM6xjU16Fzg1/XePuTzzLdc/fHdtq71saV1nITI3gAEzua5k7vx5KjqQ1XZnEaDynJQwQcVkug==
X-Received: by 2002:a05:6000:178e:b0:236:d839:c255 with SMTP id e14-20020a056000178e00b00236d839c255mr163578wrg.447.1667189514302;
        Sun, 30 Oct 2022 21:11:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b003a5f3f5883dsm6141226wmq.17.2022.10.30.21.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 21:11:53 -0700 (PDT)
Message-Id: <pull.1398.git.1667189512579.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 Oct 2022 04:11:52 +0000
Subject: [PATCH] [RFC] diff: introduce scope option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

When we use sparse-checkout, we often want the set of files
that some commands operate on to be restricted to the
sparse-checkout specification.

So introduce the `--scope` option to git diff, which have two
value: "sparse" and "all". "sparse" mean that diff is performed
restrict to paths which matching sparse-checkout specification,
"all" mean that diff is performed regardless of whether the path
meets the sparse-checkout specification. `--no-scope` is the default
option for now.

Add `diff.scope={sparse, all}` config, which can also have the same
capabilities as `--scope`, and it will be covered by `--scope` option.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [RFC] diff: introduce scope option
    
    In [1], we discovered that users working on different sparse-checkout
    specification may download unnecessary blobs from each other's
    specification in collaboration. In [2] Junio suggested that maybe we can
    restrict some git command's filespec in sparse-checkout specification to
    elegantly solve this problem above. In [3]: Newren and Derrick Stolee
    prefer to name the option --scope={sparse, all}.
    
    So this patch is attempt to do this thing on git diff:
    
    v1:
    
     1. add --restrict option to git diff, which restrict diff filespec in
        sparse-checkout specification. [4] v2.
     2. rename --restrict to --scope={sparse, all}, support --no-scope.
     3. add config: diff.scope={sparse,all}.
    
    Unresolved work:
    
     1. how to properly pass this --scope={sparse, all} to other commands
        like git log, git format-patch, etc.
     2. how to set the default value of scope for different diff commands.
    
    [1]:
    https://lore.kernel.org/git/CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com/
    [2]: https://lore.kernel.org/git/xmqqzgeqw0sy.fsf@gitster.g/ [3]:
    https://lore.kernel.org/git/07a25d48-e364-0d9b-6ffa-41a5984eb5db@github.com/
    [4]:
    https://lore.kernel.org/git/pull.1368.git.1664036052741.gitgitgadget@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1398%2Fadlternative%2Fzh%2Fdiff-scope-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1398/adlternative/zh/diff-scope-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1398

 Documentation/config/diff.txt         |  12 +
 Documentation/diff-options.txt        |  18 +
 builtin/diff.c                        |   4 +
 diff-lib.c                            |  36 +-
 diff-no-index.c                       |   4 +
 diff.c                                |  39 +++
 diff.h                                |  11 +
 t/t4070-diff-sparse-checkout-scope.sh | 469 ++++++++++++++++++++++++++
 tree-diff.c                           |   5 +
 9 files changed, 597 insertions(+), 1 deletion(-)
 create mode 100644 t/t4070-diff-sparse-checkout-scope.sh

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 35a7bf86d77..52707e1b2d6 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -201,6 +201,18 @@ diff.algorithm::
 --
 +
 
+diff.scope::
+	Choose diff scope. The variants are as follows:
++
+--
+`sparse`;;
+	Restrict diff paths to those matching sparse-checkout specification.
+`all`;;
+	Without restriction, diff is performed regardless of whether the path
+	meets the sparse-checkout specification.
+--
++
+
 diff.wsErrorHighlight::
 	Highlight whitespace errors in the `context`, `old` or `new`
 	lines of the diff.  Multiple values are separated by comma,
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 3674ac48e92..04bf83e8be1 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -195,6 +195,24 @@ For instance, if you configured the `diff.algorithm` variable to a
 non-default value and want to use the default one, then you
 have to use `--diff-algorithm=default` option.
 
+ifndef::git-format-patch[]
+ifndef::git-log[]
+
+--scope={sparse|all}::
+	Choose diff scope. The variants are as follows:
++
+--
+`--sparse`;;
+	Restrict diff paths to those matching sparse-checkout specification.
+`--all`;;
+	Without restriction, diff is performed regardless of whether the path
+	meets the sparse-checkout specification.
+--
++
+
+endif::git-log[]
+endif::git-format-patch[]
+
 --stat[=<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
diff --git a/builtin/diff.c b/builtin/diff.c
index 854d2c5a5c4..6b450f7184c 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -54,6 +54,10 @@ static void stuff_change(struct diff_options *opt,
 	    oideq(old_oid, new_oid) && (old_mode == new_mode))
 		return;
 
+	if (opt->scope == DIFF_SCOPE_SPARSE &&
+	    !diff_paths_in_sparse_checkout(old_path, new_path))
+		return;
+
 	if (opt->flags.reverse_diff) {
 		SWAP(old_mode, new_mode);
 		SWAP(old_oid, new_oid);
diff --git a/diff-lib.c b/diff-lib.c
index 2edea41a234..a3381f2e0ff 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -88,6 +88,22 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	return changed;
 }
 
+int diff_path_in_sparse_checkout(const char *path) {
+	if (core_sparse_checkout_cone)
+		return path_in_cone_mode_sparse_checkout(path, the_repository->index);
+	else
+		return path_in_sparse_checkout(path, the_repository->index);
+}
+
+int diff_paths_in_sparse_checkout(const char *one, const char*two) {
+	if (one == two || !strcmp(one, two))
+		return diff_path_in_sparse_checkout(one);
+	else
+		return diff_path_in_sparse_checkout(one) &&
+		       diff_path_in_sparse_checkout(two);
+}
+
+
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
 	int entries, i;
@@ -113,6 +129,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 		if (diff_can_quit_early(&revs->diffopt))
 			break;
+		if (revs->diffopt.scope == DIFF_SCOPE_SPARSE &&
+		    !diff_path_in_sparse_checkout(ce->name))
+			continue;
 
 		if (!ce_path_match(istate, ce, &revs->prune_data, NULL))
 			continue;
@@ -202,7 +221,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 
-		if (ce_uptodate(ce) || ce_skip_worktree(ce))
+		if (ce_uptodate(ce) ||
+		    (revs->diffopt.scope != DIFF_SCOPE_ALL && ce_skip_worktree(ce)))
 			continue;
 
 		/*
@@ -439,6 +459,20 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 			return;	/* nothing to diff.. */
 	}
 
+	if (revs->diffopt.scope == DIFF_SCOPE_SPARSE) {
+		if (idx && tree) {
+			if (!diff_paths_in_sparse_checkout(idx->name, tree->name))
+				return;
+		} else if (idx) {
+			if (!diff_path_in_sparse_checkout(idx->name))
+				return;
+		} else if (tree) {
+			if (!diff_path_in_sparse_checkout(tree->name))
+				return;
+		} else
+			return;
+	}
+
 	/* if the entry is not checked out, don't examine work tree */
 	cached = o->index_only ||
 		(idx && ((idx->ce_flags & CE_VALID) || ce_skip_worktree(idx)));
diff --git a/diff-no-index.c b/diff-no-index.c
index 18edbdf4b59..ea94a104ea4 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -281,6 +281,10 @@ int diff_no_index(struct rev_info *revs,
 
 	fixup_paths(paths, &replacement);
 
+	if (revs->diffopt.scope == DIFF_SCOPE_SPARSE &&
+	    !diff_paths_in_sparse_checkout(paths[0], paths[1]))
+		goto out;
+
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
diff --git a/diff.c b/diff.c
index 285d6e2d575..9de4044ae05 100644
--- a/diff.c
+++ b/diff.c
@@ -48,6 +48,7 @@ static int diff_interhunk_context_default;
 static const char *diff_word_regex_cfg;
 static const char *external_diff_cmd_cfg;
 static const char *diff_order_file_cfg;
+static const char *external_diff_scope_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
@@ -57,6 +58,7 @@ static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 static long diff_algorithm;
 static unsigned ws_error_highlight_default = WSEH_NEW;
+static enum diff_scope external_diff_scope;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -423,6 +425,16 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.scope")) {
+		git_config_string(&external_diff_scope_cfg, var, value);
+		if (!strcmp(value, "all"))
+			external_diff_scope = DIFF_SCOPE_ALL;
+		else if (!strcmp(value, "sparse"))
+			external_diff_scope = DIFF_SCOPE_SPARSE;
+		else
+			return -1;
+	}
+
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -4663,6 +4675,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 
 	options->color_moved = diff_color_moved_default;
 	options->color_moved_ws_handling = diff_color_moved_ws_default;
+	options->scope = external_diff_scope;
 
 	prep_parse_options(options);
 }
@@ -4914,6 +4927,29 @@ static int parse_dirstat_opt(struct diff_options *options, const char *params)
 	return 1;
 }
 
+static int diff_opt_diff_scope(const struct option *option,
+				const char *optarg, int unset)
+{
+	struct diff_options *opt = option->value;
+
+	if (unset) {
+		opt->scope = DIFF_SCOPE_NONE;
+	} else if (optarg) {
+		if (!strcmp(optarg, "all")) {
+			if (core_apply_sparse_checkout) {
+				opt->scope = DIFF_SCOPE_ALL;
+			}
+		} else if (!strcmp(optarg, "sparse")) {
+			if (core_apply_sparse_checkout) {
+				opt->scope = DIFF_SCOPE_SPARSE;
+			}
+		} else
+			return error(_("invalid --scope value: %s"), optarg);
+	}
+
+	return 0;
+}
+
 static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
@@ -5683,6 +5719,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
 			       N_("select files by diff type"),
 			       PARSE_OPT_NONEG, diff_opt_diff_filter),
+		OPT_CALLBACK_F(0, "scope", options, N_("[sparse|all]"),
+			       N_("choose diff scope"),
+			       PARSE_OPT_OPTARG, diff_opt_diff_scope),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
diff --git a/diff.h b/diff.h
index 8ae18e5ab1e..90f7512034c 100644
--- a/diff.h
+++ b/diff.h
@@ -230,6 +230,12 @@ enum diff_submodule_format {
 	DIFF_SUBMODULE_INLINE_DIFF
 };
 
+enum diff_scope {
+	DIFF_SCOPE_NONE = 0,
+	DIFF_SCOPE_ALL,
+	DIFF_SCOPE_SPARSE,
+};
+
 /**
  * the set of options the calling program wants to affect the operation of
  * diffcore library with.
@@ -285,6 +291,9 @@ struct diff_options {
 	/* diff-filter bits */
 	unsigned int filter, filter_not;
 
+	/* diff sparse-checkout scope */
+	enum diff_scope scope;
+
 	int use_color;
 
 	/* Number of context lines to generate in patch output. */
@@ -696,4 +705,6 @@ void print_stat_summary(FILE *fp, int files,
 			int insertions, int deletions);
 void setup_diff_pager(struct diff_options *);
 
+int diff_path_in_sparse_checkout(const char *path);
+int diff_paths_in_sparse_checkout(const char *one, const char *two);
 #endif /* DIFF_H */
diff --git a/t/t4070-diff-sparse-checkout-scope.sh b/t/t4070-diff-sparse-checkout-scope.sh
new file mode 100644
index 00000000000..dca75a3308b
--- /dev/null
+++ b/t/t4070-diff-sparse-checkout-scope.sh
@@ -0,0 +1,469 @@
+#!/bin/sh
+
+test_description='diff sparse-checkout scope'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+
+test_expect_success 'setup' '
+	git init temp &&
+	(
+		cd temp &&
+		mkdir sub1 &&
+		mkdir sub2 &&
+		echo sub1/file1 >sub1/file1 &&
+		echo sub2/file2 >sub2/file2 &&
+		echo file1 >file1 &&
+		echo file2 >file2 &&
+		git add --all &&
+		git commit -m init &&
+		echo sub1/file1 >>sub1/file1 &&
+		echo sub1/file2 >>sub1/file2 &&
+		echo sub2/file1 >>sub2/file1 &&
+		echo sub2/file2 >>sub2/file2 &&
+		echo file1 >>file1 &&
+		echo file2 >>file2 &&
+		git add --all &&
+		git commit -m change1 &&
+		echo sub1/file1 >>sub1/file1 &&
+		echo sub1/file2 >>sub1/file2 &&
+		echo sub2/file1 >>sub2/file1 &&
+		echo sub2/file2 >>sub2/file2 &&
+		echo file1 >>file1 &&
+		echo file2 >>file2 &&
+		git add --all &&
+		git commit -m change2
+	)
+'
+
+reset_repo () {
+	rm -rf repo &&
+	git clone --no-checkout temp repo
+}
+
+reset_with_sparse_checkout() {
+	reset_repo &&
+	git -C repo sparse-checkout set $1 sub1 &&
+	git -C repo checkout
+}
+
+change_worktree_and_index() {
+	(
+		cd repo &&
+		mkdir sub2 sub3 &&
+		echo sub1/file3 >sub1/file3 &&
+		echo sub2/file3 >sub2/file3 &&
+		echo sub3/file3 >sub3/file3 &&
+		echo file3 >file3 &&
+		git add --all --sparse &&
+		echo sub1/file3 >>sub1/file3 &&
+		echo sub2/file3 >>sub2/file3 &&
+		echo sub3/file3 >>sub3/file3 &&
+		echo file3 >>file3
+	)
+}
+
+diff_scope() {
+	title=$1
+	need_change_worktree_and_index=$2
+	sparse_checkout_option=$3
+	scope_option=$4
+	expect=$5
+	shift 5
+	args=("$@")
+
+	test_expect_success "$title $sparse_checkout_option $scope_option" "
+		reset_with_sparse_checkout $sparse_checkout_option &&
+		if test \"$need_change_worktree_and_index\" = \"true\" ; then
+			change_worktree_and_index
+		fi &&
+		git -C repo diff $scope_option ${args[*]} >actual &&
+		if test -z \"$expect\" ; then
+			>expect
+		else
+			cat > expect <<-EOF
+$expect
+			EOF
+		fi &&
+		test_cmp expect actual
+	"
+}
+
+args=("--name-only" "HEAD" "HEAD~")
+diff_scope builtin_diff_tree false "--no-cone" "--scope=sparse" \
+"sub1/file1
+sub1/file2" "${args[@]}"
+
+diff_scope builtin_diff_tree false "--no-cone" "--scope=all" \
+"file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2" "${args[@]}"
+
+diff_scope builtin_diff_tree false "--no-cone" "--no-scope" \
+"file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2" "${args[@]}"
+
+diff_scope builtin_diff_tree false "--cone" "--scope=sparse" \
+"file1
+file2
+sub1/file1
+sub1/file2" "${args[@]}"
+
+diff_scope builtin_diff_tree false "--cone" "--scope=all" \
+"file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2" "${args[@]}"
+
+diff_scope builtin_diff_tree false "--cone" "--no-scope" \
+"file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2" "${args[@]}"
+
+args=("--name-only" "HEAD~")
+diff_scope builtin_diff_index true "--no-cone" "--scope=sparse" \
+"sub1/file1
+sub1/file2
+sub1/file3" "${args[@]}"
+
+diff_scope builtin_diff_index true "--no-cone" "--scope=all" \
+"file1
+file2
+file3
+sub1/file1
+sub1/file2
+sub1/file3
+sub2/file1
+sub2/file2
+sub2/file3
+sub3/file3" "${args[@]}"
+
+diff_scope builtin_diff_index true "--no-cone" "--no-scope" \
+"file1
+file2
+file3
+sub1/file1
+sub1/file2
+sub1/file3
+sub2/file1
+sub2/file2
+sub2/file3
+sub3/file3" "${args[@]}"
+
+diff_scope builtin_diff_index true "--cone" "--scope=sparse" \
+"file1
+file2
+file3
+sub1/file1
+sub1/file2
+sub1/file3" "${args[@]}"
+
+diff_scope builtin_diff_index true "--cone" "--scope=all" \
+"file1
+file2
+file3
+sub1/file1
+sub1/file2
+sub1/file3
+sub2/file1
+sub2/file2
+sub2/file3
+sub3/file3" "${args[@]}"
+
+diff_scope builtin_diff_index true "--cone" "--no-scope" \
+"file1
+file2
+file3
+sub1/file1
+sub1/file2
+sub1/file3
+sub2/file1
+sub2/file2
+sub2/file3
+sub3/file3" "${args[@]}"
+
+args=("--name-only" "file3" "sub1/" "sub2/")
+
+diff_scope builtin_diff_files true "--no-cone" "--scope=sparse" \
+"sub1/file3" "${args[@]}"
+
+diff_scope builtin_diff_files true "--no-cone" "--scope=all" \
+"file3
+sub1/file3
+sub2/file1
+sub2/file2
+sub2/file3" "${args[@]}"
+
+diff_scope builtin_diff_files true "--no-cone" "--no-scope" \
+"file3
+sub1/file3
+sub2/file3" "${args[@]}"
+
+diff_scope builtin_diff_files true "--cone" "--scope=sparse" \
+"file3
+sub1/file3" "${args[@]}"
+
+diff_scope builtin_diff_files true "--cone" "--scope=all" \
+"file3
+sub1/file3
+sub2/file1
+sub2/file2
+sub2/file3" "${args[@]}"
+
+diff_scope builtin_diff_files true "--cone" "--no-scope" \
+"file3
+sub1/file3
+sub2/file3" "${args[@]}"
+
+
+args=("--name-only" "HEAD~:sub2/file2" "sub1/file2")
+
+diff_scope builtin_diff_b_f true "--no-cone" "--scope=sparse" \
+"" "${args[@]}"
+
+diff_scope builtin_diff_b_f true "--no-cone" "--scope=all" \
+"sub1/file2" "${args[@]}"
+
+diff_scope builtin_diff_b_f true "--no-cone" "--no-scope" \
+"sub1/file2" "${args[@]}"
+
+args=("--name-only" "HEAD~:sub1/file1" "file3")
+
+diff_scope builtin_diff_b_f true "--cone" "--scope=sparse" \
+"file3" "${args[@]}"
+
+diff_scope builtin_diff_b_f true "--cone" "--scope=all" \
+"file3" "${args[@]}"
+
+diff_scope builtin_diff_b_f true "--cone" "--no-scope" \
+"file3" "${args[@]}"
+
+args=("--name-only" HEAD~:sub2/file2 HEAD:sub1/file2)
+
+diff_scope builtin_diff_blobs true "--no-cone" "--scope=sparse" \
+"" "${args[@]}"
+
+diff_scope builtin_diff_blobs true "--no-cone" "--scope=all" \
+"sub1/file2" "${args[@]}"
+
+diff_scope builtin_diff_blobs true "--no-cone" "--no-scope" \
+"sub1/file2" "${args[@]}"
+
+args=("--name-only" HEAD~:sub1/file1 HEAD:file2)
+
+diff_scope builtin_diff_blobs false "--cone" "--scope=sparse" \
+"file2" "${args[@]}"
+
+diff_scope builtin_diff_blobs false "--cone" "--scope=all" \
+"file2" "${args[@]}"
+
+diff_scope builtin_diff_blobs false "--cone" "--no-scope" \
+"file2" "${args[@]}"
+
+args=("--name-only" HEAD~2 HEAD~ HEAD)
+
+diff_scope builtin_diff_combined false "--no-cone" "--scope=sparse" \
+"sub1/file1
+sub1/file2" "${args[@]}"
+
+diff_scope builtin_diff_combined false "--no-cone" "--scope=all" \
+"file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2" "${args[@]}"
+
+diff_scope builtin_diff_combined false "--no-cone" "--no-scope" \
+"file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2" "${args[@]}"
+
+diff_scope builtin_diff_combined false "--cone" "--scope=sparse" \
+"file1
+file2
+sub1/file1
+sub1/file2" "${args[@]}"
+
+diff_scope builtin_diff_combined false "--cone" "--scope=all" \
+"file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2" "${args[@]}"
+
+diff_scope builtin_diff_combined false "--cone" "--no-scope" \
+"file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2" "${args[@]}"
+
+test_expect_success 'diff_no_index --no-cone, --scope=sparse' '
+	reset_with_sparse_checkout --no-cone &&
+	(
+		cd repo &&
+		mkdir sub3 &&
+		echo sub3/file3 >sub3/file3
+	) &&
+	test_expect_code 1 git -C repo diff --no-index --name-only --scope=sparse sub1/file1 sub1/file2 >actual &&
+	cat > expect <<-EOF &&
+sub1/file2
+	EOF
+	test_expect_code 1 git -C repo diff --no-index --name-only --scope=sparse sub1/file1 sub3/file3 >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff_no_index --no-cone, --scope=all' '
+	reset_with_sparse_checkout --no-cone &&
+	(
+		cd repo &&
+		mkdir sub3 &&
+		echo sub3/file3 >sub3/file3
+	) &&
+	test_expect_code 1 git -C repo diff --no-index --name-only --scope=all sub1/file1 sub1/file2 >actual &&
+	cat > expect <<-EOF &&
+sub1/file2
+	EOF
+	test_expect_code 1 git -C repo diff --no-index --name-only --scope=all sub1/file1 sub3/file3 >actual &&
+	cat > expect <<-EOF &&
+sub3/file3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff_no_index --no-cone, --no-scope' '
+	reset_with_sparse_checkout --no-cone &&
+	(
+		cd repo &&
+		mkdir sub3 &&
+		echo sub3/file3 >sub3/file3
+	) &&
+	test_expect_code 1 git -C repo diff --no-index --name-only --no-scope sub1/file1 sub1/file2 >actual &&
+	cat > expect <<-EOF &&
+sub1/file2
+	EOF
+	test_expect_code 1 git -C repo diff --no-index --name-only --no-scope sub1/file1 sub3/file3 >actual &&
+	cat > expect <<-EOF &&
+sub3/file3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff_no_index --cone, --scope=sparse' '
+	reset_with_sparse_checkout --cone &&
+	(
+		cd repo &&
+		echo file3 >file3 &&
+		mkdir sub3 &&
+		echo sub3/file3 >sub3/file3
+	) &&
+	test_expect_code 1 git -C repo diff --no-index --name-only --scope=sparse sub1/file1 file3 >actual &&
+	cat > expect <<-EOF &&
+file3
+	EOF
+	test_expect_code 1 git -C repo diff --no-index --name-only --scope=sparse sub1/file1 sub3/file3 >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff_no_index --cone, --scope=all' '
+	reset_with_sparse_checkout --cone &&
+	(
+		cd repo &&
+		echo file3 >file3 &&
+		mkdir sub3 &&
+		echo sub3/file3 >sub3/file3
+	) &&
+	test_expect_code 1 git -C repo diff --no-index --name-only --scope=all sub1/file1 file3 >actual &&
+	cat > expect <<-EOF &&
+file3
+	EOF
+	test_expect_code 1 git -C repo diff --no-index --name-only --scope=all sub1/file1 sub3/file3 >actual &&
+	cat > expect <<-EOF &&
+sub3/file3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff_no_index --cone, --no-scope' '
+	reset_with_sparse_checkout --cone &&
+	(
+		cd repo &&
+		echo file3 >file3 &&
+		mkdir sub3 &&
+		echo sub3/file3 >sub3/file3
+	) &&
+	test_expect_code 1 git -C repo diff --no-index --name-only --no-scope sub1/file1 file3 >actual &&
+	cat > expect <<-EOF &&
+file3
+	EOF
+	test_expect_code 1 git -C repo diff --no-index --name-only --no-scope sub1/file1 sub3/file3 >actual &&
+	cat > expect <<-EOF &&
+sub3/file3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff scope config sparse' '
+	reset_with_sparse_checkout --cone &&
+	git -C repo -c diff.scope=sparse diff --name-only HEAD~ >actual &&
+	cat > expect <<-EOF &&
+file1
+file2
+sub1/file1
+sub1/file2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff scope config all' '
+	reset_with_sparse_checkout --cone &&
+	git -C repo -c diff.scope=all diff --name-only HEAD~ >actual &&
+	cat > expect <<-EOF &&
+file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff scope config override by option' '
+	reset_with_sparse_checkout --cone &&
+	git -C repo -c diff.scope=sparse diff --name-only --scope=all HEAD~ >actual &&
+	cat > expect <<-EOF &&
+file1
+file2
+sub1/file1
+sub1/file2
+sub2/file1
+sub2/file2
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/tree-diff.c b/tree-diff.c
index 69031d7cbae..67f99c8e4df 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -76,6 +76,11 @@ static int tree_entry_pathcmp(struct tree_desc *t1, struct tree_desc *t2)
 static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_diff_path *p)
 {
 	struct combine_diff_parent *p0 = &p->parent[0];
+
+	if (opt->scope == DIFF_SCOPE_SPARSE &&
+	    !diff_path_in_sparse_checkout(p->path))
+		return 0;
+
 	if (p->mode && p0->mode) {
 		opt->change(opt, p0->mode, p->mode, &p0->oid, &p->oid,
 			1, 1, p->path, 0, 0);

base-commit: 63bba4fdd86d80ef061c449daa97a981a9be0792
-- 
gitgitgadget
