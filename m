Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652EAC2D0A3
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 02:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A8520872
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 02:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBsn0o2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504372AbgJ0CIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 22:08:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39783 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504361AbgJ0CIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 22:08:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id y12so88092wrp.6
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pyE7JEar/bSn+02XYbIajC3lO1nRr6+UPSJ84nhT10A=;
        b=UBsn0o2XisEHBwTdPNT9bSV5+7+aDqIjriWBsUuDZMwh2hHV/PPTkz7tzEqDMy/aWZ
         IjuQixT5WA8QWkGYQG5+7W3CzPJcP88EQVHOjkWiVdTiHCsAp6G+pLfNknK5vURGVPG1
         Hs4IoJl0oHI7di2e/+jFjhP+fnkwM+S1r22c0+Ki7k1JEA36S/EY5h0SBovNVwCi1fZZ
         dTCs6pLaw+eXaNG5DsgSbktE9GU2AZ2gKj561nL5a968mqf3BYsUB/gS+9Vg8zG38F9l
         63+oWheiDP4doiPTLJ4lRg4Hmq34Q/fcjMCCZ9zKFsLDAFE9BvbTtDEnx5Qv7Uhgim8f
         cUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pyE7JEar/bSn+02XYbIajC3lO1nRr6+UPSJ84nhT10A=;
        b=tLA7Q3KG8pF+CA55rzslf14vvEfn6SjDDrk9IP9cXtIJP7UmfF2ABgrO3k1znYKl0X
         tidss/E5HIUiLOMxfUERm15N/1e9fxFYYqIokqoMdthkND4Vfjh1DgX6L8rAZebBtsW2
         CAAV5dS1O4kfnXXzzyv5EYmMqCX4Nv/Dx0PmMmq9KqPdl4baMWhNAo3fmYOL+5rwCTwe
         1Q4McQlezjdRFDi3KFXWcJByNWDuqyNAaXM4ndALXJ6zwmBxz+XUxqI72HW5rHnc3Cj8
         MLHr02mg9Ieu7ExzfsnfEnRhcuRzcnypzgGHLKEPdpZA3W75UzhTOs55hd8OvtszCZSs
         UCKA==
X-Gm-Message-State: AOAM530naMBBfU9Y6zIXFP8a2+KeZDeqbmh3DnaI+bvu8t3wbw9VGz/W
        JS24kE8eOB1kdnhx1JtuxfoUC9nLJGs=
X-Google-Smtp-Source: ABdhPJyP1kKXfdMNLZt94qlj8G1n1a1DJ2Inelj/CEx/VL3ZUbCZ7SUcCFXqk72UBKcAHhfPCrT91g==
X-Received: by 2002:adf:f007:: with SMTP id j7mr1080409wro.73.1603764495205;
        Mon, 26 Oct 2020 19:08:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v19sm58307wmj.31.2020.10.26.19.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 19:08:14 -0700 (PDT)
Message-Id: <0479d59c33b4bc7543b6a2a5e7c10774f7017dba.1603764490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
References: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
        <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 02:08:10 +0000
Subject: [PATCH v3 4/4] merge,rebase,revert: select ort or recursive by config
 or environment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Allow the testsuite to run where it treats requests for "recursive" or
the default merge algorithm via consulting the environment variable
GIT_TEST_MERGE_ALGORITHM which is expected to either be "recursive" (the
old traditional algorithm) or "ort" (the new algorithm).

Also, allow folks to pick the new algorithm via config setting.  It
turns out builtin/merge.c already had a way to allow users to specify a
different default merge algorithm: pull.twohead.  Rather odd
configuration name (especially to be in the 'pull' namespace rather than
'merge') but it's there.  Add that same configuration to rebase,
cherry-pick, and revert.

This required updating the various callsites that called merge_trees()
or merge_recursive() to conditionally call the new API, so this serves
as another demonstration of what the new API looks and feels like.
There are almost certainly some callsites that have not yet been
modified to work with the new merge algorithm, but this represents the
ones that I have been testing with thus far.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c  | 26 ++++++++++++++++--
 builtin/rebase.c |  9 +++++-
 builtin/revert.c |  2 ++
 sequencer.c      | 71 ++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 93 insertions(+), 15 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9d5359edc2..87dfc9bc06 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "help.h"
 #include "merge-recursive.h"
+#include "merge-ort-wrappers.h"
 #include "resolve-undo.h"
 #include "remote.h"
 #include "fmt-merge-msg.h"
@@ -88,6 +89,7 @@ static int no_verify;
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
 	{ "octopus",    DEFAULT_OCTOPUS },
+	{ "ort",        NO_TRIVIAL },
 	{ "resolve",    0 },
 	{ "ours",       NO_FAST_FORWARD | NO_TRIVIAL },
 	{ "subtree",    NO_FAST_FORWARD | NO_TRIVIAL },
@@ -159,10 +161,17 @@ static struct strategy *get_strategy(const char *name)
 	struct strategy *ret;
 	static struct cmdnames main_cmds, other_cmds;
 	static int loaded;
+	char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
 
 	if (!name)
 		return NULL;
 
+	if (default_strategy &&
+	    !strcmp(default_strategy, "ort") &&
+	    !strcmp(name, "recursive")) {
+		name = "ort";
+	}
+
 	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
 		if (!strcmp(name, all_strategy[i].name))
 			return &all_strategy[i];
@@ -701,7 +710,8 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (refresh_and_write_cache(REFRESH_QUIET, SKIP_IF_UNCHANGED, 0) < 0)
 		return error(_("Unable to write index."));
 
-	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
+	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree") ||
+	    !strcmp(strategy, "ort")) {
 		struct lock_file lock = LOCK_INIT;
 		int clean, x;
 		struct commit *result;
@@ -732,8 +742,12 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			commit_list_insert(j->item, &reversed);
 
 		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
-		clean = merge_recursive(&o, head,
-				remoteheads->item, reversed, &result);
+		if (!strcmp(strategy, "ort"))
+			clean = merge_ort_recursive(&o, head, remoteheads->item,
+						    reversed, &result);
+		else
+			clean = merge_recursive(&o, head, remoteheads->item,
+						reversed, &result);
 		if (clean < 0)
 			exit(128);
 		if (write_locked_index(&the_index, &lock,
@@ -1264,6 +1278,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (branch)
 		skip_prefix(branch, "refs/heads/", &branch);
 
+	if (!pull_twohead) {
+		char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
+		if (default_strategy && !strcmp(default_strategy, "ort"))
+			pull_twohead = "ort";
+	}
+
 	init_diff_ui_defaults();
 	git_config(git_merge_config, NULL);
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index eeca53382f..9719aa25da 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -119,6 +119,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	struct replay_opts replay = REPLAY_OPTS_INIT;
 
 	replay.action = REPLAY_INTERACTIVE_REBASE;
+	replay.strategy = NULL;
 	sequencer_init_config(&replay);
 
 	replay.signoff = opts->signoff;
@@ -136,7 +137,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 					opts->committer_date_is_author_date;
 	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
-	replay.strategy = opts->strategy;
+	if (opts->strategy)
+		replay.strategy = opts->strategy;
 
 	if (opts->strategy_opts)
 		parse_strategy_opts(&replay, opts->strategy_opts);
@@ -1771,6 +1773,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			    options.default_backend);
 	}
 
+	if (options.type == REBASE_MERGE &&
+	    !options.strategy &&
+	    getenv("GIT_TEST_MERGE_ALGORITHM"))
+		options.strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
+
 	switch (options.type) {
 	case REBASE_MERGE:
 	case REBASE_PRESERVE_MERGES:
diff --git a/builtin/revert.c b/builtin/revert.c
index f61cc5d82c..c7cb0c1a18 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -202,6 +202,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	/* These option values will be free()d */
 	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
 	opts->strategy = xstrdup_or_null(opts->strategy);
+	if (!opts->strategy && getenv("GIT_TEST_MERGE_ALGORITHM"))
+		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 
 	if (cmd == 'q') {
 		int ret = sequencer_remove_state(opts);
diff --git a/sequencer.c b/sequencer.c
index 00acb12496..e16d85380c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -14,7 +14,8 @@
 #include "diff.h"
 #include "revision.h"
 #include "rerere.h"
-#include "merge-recursive.h"
+#include "merge-ort.h"
+#include "merge-ort-wrappers.h"
 #include "refs.h"
 #include "strvec.h"
 #include "quote.h"
@@ -204,6 +205,20 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!opts->strategy && !strcmp(k, "pull.twohead")) {
+		int ret = git_config_string((const char**)&opts->strategy, k, v);
+		if (ret == 0) {
+			/*
+			 * pull.twohead is allowed to be multi-valued; we only
+			 * care about the first value.
+			 */
+			char *tmp = strchr(opts->strategy, ' ');
+			if (tmp)
+				*tmp = '\0';
+		}
+		return ret;
+	}
+
 	status = git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
@@ -595,8 +610,9 @@ static int do_recursive_merge(struct repository *r,
 			      struct replay_opts *opts)
 {
 	struct merge_options o;
+	struct merge_result result;
 	struct tree *next_tree, *base_tree, *head_tree;
-	int clean;
+	int clean, show_output;
 	int i;
 	struct lock_file index_lock = LOCK_INIT;
 
@@ -620,12 +636,27 @@ static int do_recursive_merge(struct repository *r,
 	for (i = 0; i < opts->xopts_nr; i++)
 		parse_merge_opt(&o, opts->xopts[i]);
 
-	clean = merge_trees(&o,
-			    head_tree,
-			    next_tree, base_tree);
-	if (is_rebase_i(opts) && clean <= 0)
-		fputs(o.obuf.buf, stdout);
-	strbuf_release(&o.obuf);
+	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
+		memset(&result, 0, sizeof(result));
+		merge_incore_nonrecursive(&o, base_tree, head_tree, next_tree,
+					    &result);
+		show_output = !is_rebase_i(opts) || !result.clean;
+		/*
+		 * TODO: merge_switch_to_result will update index/working tree;
+		 * we only really want to do that if !result.clean || this is
+		 * the final patch to be picked.  But determining this is the
+		 * final patch would take some work, and "head_tree" would need
+		 * to be replace with the tree the index matched before we
+		 * started doing any picks.
+		 */
+		merge_switch_to_result(&o, head_tree, &result, 1, show_output);
+		clean = result.clean;
+	} else {
+		clean = merge_trees(&o, head_tree, next_tree, base_tree);
+		if (is_rebase_i(opts) && clean <= 0)
+			fputs(o.obuf.buf, stdout);
+		strbuf_release(&o.obuf);
+	}
 	if (clean < 0) {
 		rollback_lock_file(&index_lock);
 		return clean;
@@ -1991,7 +2022,10 @@ static int do_pick_commit(struct repository *r,
 
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
-	else if (!opts->strategy || !strcmp(opts->strategy, "recursive") || command == TODO_REVERT) {
+	else if (!opts->strategy ||
+		 !strcmp(opts->strategy, "recursive") ||
+		 !strcmp(opts->strategy, "ort") ||
+		 command == TODO_REVERT) {
 		res = do_recursive_merge(r, base, next, base_label, next_label,
 					 &head, &msgbuf, opts);
 		if (res < 0)
@@ -3485,7 +3519,9 @@ static int do_merge(struct repository *r,
 	struct commit_list *bases, *j, *reversed = NULL;
 	struct commit_list *to_merge = NULL, **tail = &to_merge;
 	const char *strategy = !opts->xopts_nr &&
-		(!opts->strategy || !strcmp(opts->strategy, "recursive")) ?
+		(!opts->strategy ||
+		 !strcmp(opts->strategy, "recursive") ||
+		 !strcmp(opts->strategy, "ort")) ?
 		NULL : opts->strategy;
 	struct merge_options o;
 	int merge_arg_len, oneline_offset, can_fast_forward, ret, k;
@@ -3722,7 +3758,20 @@ static int do_merge(struct repository *r,
 	o.branch2 = ref_name.buf;
 	o.buffer_output = 2;
 
-	ret = merge_recursive(&o, head_commit, merge_commit, reversed, &i);
+	if (opts->strategy && !strcmp(opts->strategy, "ort")) {
+		/*
+		 * TODO: Should use merge_incore_recursive() and
+		 * merge_switch_to_result(), skipping the call to
+		 * merge_switch_to_result() when we don't actually need to
+		 * update the index and working copy immediately.
+		 */
+		ret = merge_ort_recursive(&o,
+					  head_commit, merge_commit, reversed,
+					  &i);
+	} else {
+		ret = merge_recursive(&o, head_commit, merge_commit, reversed,
+				      &i);
+	}
 	if (ret <= 0)
 		fputs(o.obuf.buf, stdout);
 	strbuf_release(&o.obuf);
-- 
gitgitgadget
