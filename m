Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C5C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8686222249
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAIHGFBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438095AbgJUNWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437899AbgJUNWp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:22:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC062C0613D2
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j7so3036436wrt.9
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jmkYhmyUvfR/3eXhLXCQH6Mh3OljUh4huvdx27ffM/k=;
        b=nAIHGFBcKDgtjxrU5wby2VBNLHwBsvHyyvnElpglFAa/cv5Lm82M/u0xTDRxOUMPM+
         q7kDHTQ+BvNzKwDTRNtVUHNKUb/ZeaO+UUaPsXlwVok8YWL88+66wirRdifO3acmy70M
         eXDHkSEeM4618i6WkS3lC/2fc3dHrNzq/ktyD/N7L2WDm/yopeVTwsUb0thn5gvWazH4
         UaD0sCYUhS0hg8CbzgaCuliIsl9urzKnFak+Bb56lLb3CwGg2fTan0pjLzIZGTzRSV1k
         ky/uNXQvXZX1CTQDo/2Fx02RLOUF6EWsWDI+UbGRxCsQTq9V/suXoxQZRpmBGN+rWn/I
         3f2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jmkYhmyUvfR/3eXhLXCQH6Mh3OljUh4huvdx27ffM/k=;
        b=d0wV+WMXZePPT+xhe/swp2ZXq/nGI5v/Vc2dNVe07b63nHC90zmICcgVAJ5yLoFmDi
         rh8qTEuyeCe4Q2FiBl3t5WzhXhpl0d/ODm+g3cEA4a1rGYXahPUKQa2OyhdZ7Xk6o94a
         ChN6PPHRW3SvX53HJMYDvQK9cdDYPoo4XtYSdOvmR62tbUwpNiy6ZmMl+3MMqx1zVxX/
         RhuBeas5F8KflrePMPTchuPx8GayzL8rLS9aD/7484QxDNBOVjEYnShXndZEEprlhVRd
         tJCr8BXk0SUUcnSMFGLyiiE6nKBSytQJhFoM6YCylXsDGSPeeF9n2diH0hgQRnj+GQb2
         Q0KA==
X-Gm-Message-State: AOAM5303HczHwRs4H9Y7Jdbib3dxhnjU77wDjIuFWqiu6ISpa32DGs4b
        DJMkb5qj1fHLVCrStAk7525aiEq3TUg=
X-Google-Smtp-Source: ABdhPJxBnZe3NkfZp/CWOcdNVE7HkXDMCGxqbdNlkOqH+RqaZFPwHrIGZmWpm0+HQDyjxbFTQBqvXQ==
X-Received: by 2002:a5d:488e:: with SMTP id g14mr4889419wrq.203.1603286563096;
        Wed, 21 Oct 2020 06:22:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm4208796wrs.54.2020.10.21.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 06:22:41 -0700 (PDT)
Message-Id: <06ecea215fc8f03fba38acdf6a66b358de3adba5.1603286556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 13:22:35 +0000
Subject: [PATCH 4/4] merge,rebase,revert: select ort or recursive by config or
 environment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
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
index 00acb12496..163475ae31 100644
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
+		merge_inmemory_nonrecursive(&o, base_tree, head_tree, next_tree,
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
+		 * TODO: Should use merge_inmemory_recursive() and
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
