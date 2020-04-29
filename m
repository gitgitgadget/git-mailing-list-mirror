Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4130EC8300A
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFF62073E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/FgFACn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgD2K0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgD2K0s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 06:26:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95CC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:48 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so1808576wrm.13
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=C/UZL7sBn5IcFJpbk9akCl8ZkNNifvClL+yBP98vi6w=;
        b=U/FgFACngmyKDV8p90xbPH7PUPx0AZrF+QaFB3ryhZLA7rstOI6Cf1U0V522bGm7dE
         W3iAVzx4uiXrbJvcx9UO4T77zNlhROgphmNJH3UdZ72vE1xF+q/1OO922bn8/XAfcvpj
         P6XAjske/5Kq5jJs0FjMh0yhHWoRJfFsUPXoscCADiHW1rXesM3pnjpvd1Iba3B9eEo0
         9i1zhU6fAYR0gZ/bGBhHqulJSalwTytK0iokSGXMufPcZ13CCI7rm/cAVrISKg21z0h1
         FrFocjjSM9ItYTFP3grFb6eM7vUhDz/Vlb23b8/xRtclXlD2w936zmBb7M5Yo9LVz8NR
         OqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=C/UZL7sBn5IcFJpbk9akCl8ZkNNifvClL+yBP98vi6w=;
        b=gsp/A7x/E7lESyll4eWhUUmLrnMZlLkjHsQJ+HJ3X6k8IO6OTIlEhTSwtgwXEyAnIR
         uRWvT8zu3mexmL7ENnmygVo9nOSM1KnU/3DjuTg5vxhjPjq1gb0Gf1LdBjpmqw3liFA1
         jgBRbZsjA8Y/tZ4CbdVsKDuMONgkaC4kbRzmxhs/7XXnTvwAia8ijd6g7UiakQu2HYG/
         Jc4wAPucZ7pvAODzMlES0Z6JEi8JU/jkbfh0c9cOYxC6G4a3Xpma+UO4NLe7J0OCM0P8
         U9y6MXtH2+cvdDlLxgnV4XphUT2NSKPKQPQJCBRKvrUQSA/u+02NVHOniPdNOjQ7lxSk
         ytwg==
X-Gm-Message-State: AGi0PuZ0fFEX6jBIJ6osnFOMGnFd+vsC/O2NEJL10KjNSGHWr6skxSjp
        xxAdxM9DZRw+pFcpeFPEgRI=
X-Google-Smtp-Source: APiQypJgu2BHPlcrXl+Yw/k2UVwgHiHWmUt9yTOB/+mmo8jyrg3pa5lyZlHum20Ol2I9X32D7C5VBQ==
X-Received: by 2002:adf:cd12:: with SMTP id w18mr38878939wrm.177.1588156006941;
        Wed, 29 Apr 2020 03:26:46 -0700 (PDT)
Received: from localhost.localdomain (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id c1sm30718196wrc.4.2020.04.29.03.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:26:46 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/5] rebase -i: support --committer-date-is-author-date
Date:   Wed, 29 Apr 2020 11:25:18 +0100
Message-Id: <20200429102521.47995-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429102521.47995-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As part of the on-going effort to retire the apply rebase backend teach
the merge backend how to handle --committer-date-is-author-date.

Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt           | 10 +++--
 builtin/rebase.c                       | 16 ++++---
 sequencer.c                            | 60 +++++++++++++++++++++++++-
 sequencer.h                            |  1 +
 t/t3422-rebase-incompatible-options.sh |  1 -
 t/t3436-rebase-more-options.sh         | 56 ++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index d060c143e6..8c62645b8c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -438,9 +438,13 @@ when merging.
 See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
+	Instead of using the current time as the committer date, use
+	the author date of the commit being rebased as the committer
+	date. This option implies --force-rebase.
+
 --ignore-date::
-	These flags are passed to 'git am' to easily change the dates
-	of the rebased commits (see linkgit:git-am[1]).
+	This flag is passed to 'git am' to change the author date
+	of each rebased commit (see linkgit:git-am[1]).
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -578,7 +582,6 @@ INCOMPATIBLE OPTIONS
 The following options:
 
  * --apply
- * --committer-date-is-author-date
  * --ignore-date
  * --whitespace
  * -C
@@ -606,6 +609,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --empty=
  * --preserve-merges and --ignore-whitespace
+ * --preserve-merges and --committer-date-is-author-date
  * --keep-base and --onto
  * --keep-base and --root
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5d8e117276..357cd6acf3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -89,6 +89,7 @@ struct rebase_options {
 	int ignore_whitespace;
 	char *gpg_sign_opt;
 	int autostash;
+	int committer_date_is_author_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -126,6 +127,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
+	replay.committer_date_is_author_date =
+					opts->committer_date_is_author_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -1003,6 +1006,8 @@ static int run_am(struct rebase_options *opts)
 
 	if (opts->ignore_whitespace)
 		argv_array_push(&am.args, "--ignore-whitespace");
+	if (opts->committer_date_is_author_date)
+		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1507,9 +1512,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
-				  &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			 &options.committer_date_is_author_date,
+			 N_("make committer date match author date")),
 		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
 				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
@@ -1804,11 +1809,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	    options.autosquash) {
 		allow_preemptive_ff = 0;
 	}
+	if (options.committer_date_is_author_date)
+		options.flags |= REBASE_FORCE;
 
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
-		if (!strcmp(option, "--committer-date-is-author-date") ||
-		    !strcmp(option, "--ignore-date") ||
+		if (!strcmp(option, "--ignore-date") ||
 		    !strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			allow_preemptive_ff = 0;
diff --git a/sequencer.c b/sequencer.c
index 6fd2674632..3bb80d7414 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -149,6 +149,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  * command-line.
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
+static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -872,6 +873,22 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+static const char *author_date_from_env_array(const struct argv_array *env)
+{
+	int i;
+	const char *date;
+
+	for (i = 0; i < env->argc; i++)
+		if (skip_prefix(env->argv[i],
+				"GIT_AUTHOR_DATE=", &date))
+			return date;
+	/*
+	 * If GIT_AUTHOR_DATE is missing we should have already errored out when
+	 * reading the script
+	 */
+	BUG("GIT_AUTHOR_DATE missing from author script");
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -938,6 +955,10 @@ static int run_git_commit(struct repository *r,
 			     gpg_opt, gpg_opt);
 	}
 
+	if (opts->committer_date_is_author_date)
+		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+				 author_date_from_env_array(&cmd.env_array));
+
 	argv_array_push(&cmd.args, "commit");
 
 	if (!(flags & VERIFY_MSG))
@@ -1321,7 +1342,6 @@ static int try_to_commit(struct repository *r,
 
 	if (parse_head(r, &current_head))
 		return -1;
-
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
 		const char *out_enc = get_commit_output_encoding();
@@ -1349,6 +1369,30 @@ static int try_to_commit(struct repository *r,
 		commit_list_insert(current_head, &parents);
 	}
 
+	if (opts->committer_date_is_author_date) {
+		int len = strlen(author);
+		struct ident_split ident;
+		struct strbuf date = STRBUF_INIT;
+
+		if (split_ident_line(&ident, author, len) < 0) {
+			res = error(_("malformed ident line '%s'"), author);
+			goto out;
+		}
+		if (!ident.date_begin) {
+			res = error(_("corrupted author without date information"));
+			goto out;
+		}
+
+		strbuf_addf(&date, "@%.*s %.*s",
+			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
+			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
+		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
+		strbuf_release(&date);
+
+		if (res)
+			goto out;
+	}
+
 	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
@@ -2532,6 +2576,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->signoff = 1;
 		}
 
+		if (file_exists(rebase_path_cdate_is_adate())) {
+			opts->allow_ff = 0;
+			opts->committer_date_is_author_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2622,6 +2671,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_drop_redundant_commits(), "%s", "");
 	if (opts->keep_redundant_commits)
 		write_file(rebase_path_keep_redundant_commits(), "%s", "");
+	if (opts->committer_date_is_author_date)
+		write_file(rebase_path_cdate_is_adate(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3542,6 +3593,10 @@ static int do_merge(struct repository *r,
 			goto leave_merge;
 		}
 
+		if (opts->committer_date_is_author_date)
+			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+					 author_date_from_env_array(&cmd.env_array));
+
 		cmd.git_cmd = 1;
 		argv_array_push(&cmd.args, "merge");
 		argv_array_push(&cmd.args, "-s");
@@ -3819,7 +3874,8 @@ static int pick_commits(struct repository *r,
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
-				opts->record_origin || opts->edit));
+				opts->record_origin || opts->edit ||
+				opts->committer_date_is_author_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 0bee85093e..4ab94119ae 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -45,6 +45,7 @@ struct replay_opts {
 	int verbose;
 	int quiet;
 	int reschedule_failed_exec;
+	int committer_date_is_author_date;
 
 	int mainline;
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 55ca46786d..c8234062c6 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,7 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
 test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index fb5e747e86..84b9d5d37f 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -9,6 +9,9 @@ test_description='tests to ensure compatibility between am and interactive backe
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
+export GIT_AUTHOR_DATE
+
 # This is a special case in which both am and interactive backends
 # provide the same output. It was done intentionally because
 # both the backends fall short of optimal behaviour.
@@ -28,8 +31,13 @@ test_expect_success 'setup' '
 	EOF
 	git commit -am "update file" &&
 	git tag side &&
+	test_commit commit1 foo foo1 &&
+	test_commit commit2 foo foo2 &&
+	test_commit commit3 foo foo3 &&
 
 	git checkout --orphan master &&
+	git rm --cached foo &&
+	rm foo &&
 	sed -e "s/^|//" >file <<-\EOF &&
 	|line 1
 	|        line 2
@@ -78,6 +86,54 @@ test_expect_success '--ignore-whitespace is remembered when continuing' '
 	test_cmp expect file
 '
 
+test_expect_success '--committer-date-is-author-date works with apply backend' '
+	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
+	git rebase --apply --committer-date-is-author-date HEAD^ &&
+	git log -1 --pretty="format:%ai" >authortime &&
+	git log -1 --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works with merge backend' '
+	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
+	git rebase -m --committer-date-is-author-date HEAD^ &&
+	git log -1 --pretty="format:%ai" >authortime &&
+	git log -1 --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works with rebase -r' '
+	git checkout side &&
+	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
+	git rebase -r --root --committer-date-is-author-date &&
+	git log --pretty="format:%ai" >authortime &&
+	git log --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works when forking merge' '
+	git checkout side &&
+	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
+	git rebase -r --root --strategy=resolve --committer-date-is-author-date &&
+	git log --pretty="format:%ai" >authortime &&
+	git log --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
+
+'
+
+test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
+	git checkout commit2 &&
+	GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
+	git log -1 --format=%at HEAD >expect &&
+	test_must_fail git rebase -m --committer-date-is-author-date \
+		--onto HEAD^^ HEAD^ &&
+	echo resolved > foo &&
+	git add foo &&
+	git rebase --continue &&
+	git log -1 --format=%ct HEAD >actual &&
+	test_cmp expect actual
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.26.2

