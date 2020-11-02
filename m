Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA2DC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C3322268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 23:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGrTsznk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgKBXpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 18:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgKBXpl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 18:45:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4C7C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 15:45:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 205so3342799wma.4
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 15:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=crrilWx3bvKHO/x/02+iz/mTC9rEIdPqTxvt1snKMY0=;
        b=BGrTsznkjGW384sjeJqhmvUKrrTzg8WJ90aZlHwSloR0CveWoXUP61WGm4zq5lTW7s
         YaRinG4yWmxojv8FndSrDcxDAdz979LBecRYEzO97ZtEGnC7ncpWCve0gvSnHz29EOOT
         mY4i51Sz1+0EvNugVJHc8p9QlthEE3y0is9hFo77TBE3jQ8v+c/0pPRfcZ23NmtmjQtt
         5K1VH3E2SdyCwaP1qM+qVF2JDBFApYRSwjTpxcPd3173Zph1w7/4jyqlth43oYMwylsH
         N/kUmdrvRwaq/QTBS5lcPj3DJNJH60eBcUlsJWMEuRftU0ZkWsTKrOc7yHKBRd/Sb+Dw
         69sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=crrilWx3bvKHO/x/02+iz/mTC9rEIdPqTxvt1snKMY0=;
        b=gMj1bv9kbBXiMhkCT1/iX2ym4PlNCGvFW6MvjSXGQw1a3EBFGyxPF3Z6bwJfxbSbmW
         kdN9fKRPFLysEYum5TYyFmnvqwfRZ5p2NMeSAbQtjhe1QrAbv0/slqXFI98DLhNOf5Rv
         cUp/OqCzlkh++QRRVIWEOI1SX0ScwT01OVI7rBq9kALs2DBhVezLlcmxhVGM0UjRI+80
         vB7C0jhAxDRN/uUB0ZjALDi2uSyxKSW8y6J2SsQw0B/b523OyZBsyOCdsEviUqvQZC9N
         0d7OcAzXO2G7AT8HKXDAgV9Ndvg+FzZ+3nvQALGmbDvr9t4SnNQYyhMcCtegIaoLh+5S
         UYjA==
X-Gm-Message-State: AOAM5334JDdtxyMqxy5dGMMj1mr0h+D391MJVXVeRCcR9ZX4PEDfskBc
        kr5KhLiARTJH0fTL9n8Rhg5jY3JIddo=
X-Google-Smtp-Source: ABdhPJztYg1q0sTXgX3BnyvIEdtQmil5eg33IyFhNhBU/9k2d4SVvgBeEdPTlQOVLlP+m9SJUt2Pcw==
X-Received: by 2002:a05:600c:28c1:: with SMTP id h1mr550103wmd.30.1604360739717;
        Mon, 02 Nov 2020 15:45:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b7sm23191139wrp.16.2020.11.02.15.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 15:45:39 -0800 (PST)
Message-Id: <61217a83bd7ff0ce9016eb4df9ded4fdf29a506c.1604360734.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v5.git.git.1604360734.gitgitgadget@gmail.com>
References: <pull.895.v4.git.git.1604003535.gitgitgadget@gmail.com>
        <pull.895.v5.git.git.1604360734.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 02 Nov 2020 23:45:34 +0000
Subject: [PATCH v5 4/4] merge,rebase,revert: select ort or recursive by config
 or environment
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
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
 builtin/merge.c  | 26 +++++++++++++++--
 builtin/rebase.c | 13 ++++++++-
 builtin/revert.c |  7 +++++
 sequencer.c      | 72 ++++++++++++++++++++++++++++++++++++++++--------
 sequencer.h      |  1 +
 5 files changed, 104 insertions(+), 15 deletions(-)

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
index eeca53382f..4ba5295ddf 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -119,6 +119,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	struct replay_opts replay = REPLAY_OPTS_INIT;
 
 	replay.action = REPLAY_INTERACTIVE_REBASE;
+	replay.strategy = NULL;
 	sequencer_init_config(&replay);
 
 	replay.signoff = opts->signoff;
@@ -136,7 +137,12 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 					opts->committer_date_is_author_date;
 	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
-	replay.strategy = opts->strategy;
+	if (opts->strategy)
+		replay.strategy = opts->strategy;
+	else if (!replay.strategy && replay.default_strategy) {
+		replay.strategy = replay.default_strategy;
+		replay.default_strategy = NULL;
+	}
 
 	if (opts->strategy_opts)
 		parse_strategy_opts(&replay, opts->strategy_opts);
@@ -1771,6 +1777,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
index f61cc5d82c..5b01a9baca 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -172,6 +172,11 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 				NULL);
 	}
 
+	if (!opts->strategy && opts->default_strategy) {
+		opts->strategy = opts->default_strategy;
+		opts->default_strategy = NULL;
+	}
+
 	if (opts->allow_ff)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
@@ -202,6 +207,8 @@ static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 	/* These option values will be free()d */
 	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
 	opts->strategy = xstrdup_or_null(opts->strategy);
+	if (!opts->strategy && getenv("GIT_TEST_MERGE_ALGORITHM"))
+		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 
 	if (cmd == 'q') {
 		int ret = sequencer_remove_state(opts);
diff --git a/sequencer.c b/sequencer.c
index 00acb12496..6b6c15c357 100644
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
 
+	if (!opts->default_strategy && !strcmp(k, "pull.twohead")) {
+		int ret = git_config_string((const char**)&opts->default_strategy, k, v);
+		if (ret == 0) {
+			/*
+			 * pull.twohead is allowed to be multi-valued; we only
+			 * care about the first value.
+			 */
+			char *tmp = strchr(opts->default_strategy, ' ');
+			if (tmp)
+				*tmp = '\0';
+		}
+		return ret;
+	}
+
 	status = git_gpg_config(k, v, NULL);
 	if (status)
 		return status;
@@ -317,6 +332,7 @@ int sequencer_remove_state(struct replay_opts *opts)
 	free(opts->committer_name);
 	free(opts->committer_email);
 	free(opts->gpg_sign);
+	free(opts->default_strategy);
 	free(opts->strategy);
 	for (i = 0; i < opts->xopts_nr; i++)
 		free(opts->xopts[i]);
@@ -595,8 +611,9 @@ static int do_recursive_merge(struct repository *r,
 			      struct replay_opts *opts)
 {
 	struct merge_options o;
+	struct merge_result result;
 	struct tree *next_tree, *base_tree, *head_tree;
-	int clean;
+	int clean, show_output;
 	int i;
 	struct lock_file index_lock = LOCK_INIT;
 
@@ -620,12 +637,27 @@ static int do_recursive_merge(struct repository *r,
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
@@ -1991,7 +2023,10 @@ static int do_pick_commit(struct repository *r,
 
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
@@ -3485,7 +3520,9 @@ static int do_merge(struct repository *r,
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
@@ -3722,7 +3759,20 @@ static int do_merge(struct repository *r,
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
diff --git a/sequencer.h b/sequencer.h
index b2a501e445..020b7fa118 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -57,6 +57,7 @@ struct replay_opts {
 	int explicit_cleanup;
 
 	/* Merge strategy */
+	char *default_strategy;  /* from config options */
 	char *strategy;
 	char **xopts;
 	size_t xopts_nr, xopts_alloc;
-- 
gitgitgadget
