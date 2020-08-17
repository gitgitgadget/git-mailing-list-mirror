Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB13C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 548A320716
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsiSVgXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgHQRkv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387577AbgHQRk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:40:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE888C061346
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so15826442wrl.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=0HIfpqz8TGDXfTqiYtDnkRU+4hv4345NDcfO9HT4vJ8=;
        b=BsiSVgXBRxJv/B3J3CQlGVkpGSde+5ADb55loJBxtzmpLTSAf62kcwkfdglNYJ5EF+
         +lYYhxjXGQGF98jtBCj5zPtjYGOSzrFsztUz4yQ9vvXsIpaWsjT2UduCQrC151I4NhJP
         p6YWRvOPVX+Zr546efR2QTyGMsIv0xjoe3PMKkF+wVfW+e+4jDjgR+8TCPZJ8fgWRdHY
         k7IjpHH5+wgNoH7vOXOHQc9X6OK6NSMMEzlJPJ9XsBnIx2s68+jBUDal1Yy+SSCy78Xl
         0cUFCN7h0eXDcZrEFqMm8LQAde8VXceggZBmO0728U6DLt2RsBmY/e7c2vKd6HneznAj
         zGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=0HIfpqz8TGDXfTqiYtDnkRU+4hv4345NDcfO9HT4vJ8=;
        b=OR6ERDg0qbMIMyvrtVREngMCVNIO12jcVntzErjeSgD6+cosDPlkEXzOFlFD59IFCU
         zHwbXE1w+o8s48nXah7VHMYv38rRJxhmZ0uX6X8uzUZerHrco5PdsDloF0/c5EKnyUnX
         1w+f7/ZQaP2rFYXF6AukXZloeq1mbWXUulWV7nyG/upyMJ0uN+8i9vj8LZCbToyjFta6
         TLyZM6HzwdN4QLpDp/bOAaJ7qaXrZuSUxpcroxg3lJd09IAQES5AZlK9FiPTlLRM0of5
         mXi2zwyIuV28yEtDQkMMylarsoG2R5xi121YiJ9MdGpCDhHTIRRLyrBmhcotmynlhHcC
         g+Dw==
X-Gm-Message-State: AOAM530XCWt7HzalA/sEP8xliiG/2pDEzj3oRQelUuY/gv12GfHAw2te
        ZPXnwropAQAMEiSH5tUHn+E=
X-Google-Smtp-Source: ABdhPJzFIs3EHV3B952nd36wWI81ciwghxNcJ47i0D4tEMn0GaZQI0kq1fRPpQsQTLNRbpYgnIgK9w==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr17810331wrp.198.1597686018183;
        Mon, 17 Aug 2020 10:40:18 -0700 (PDT)
Received: from localhost.localdomain (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id l10sm31252058wru.3.2020.08.17.10.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 10:40:17 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v8 4/5] rebase -i: support --ignore-date
Date:   Mon, 17 Aug 2020 18:40:03 +0100
Message-Id: <20200817174004.92455-5-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817174004.92455-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200817174004.92455-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Rebase is implemented with two different backends - 'apply' and
'merge' each of which support a different set of options. In
particular the apply backend supports a number of options implemented
by 'git am' that are not implemented in the merge backend. This means
that the available options are different depending on which backend is
used which is confusing. This patch adds support for the --ignore-date
option to the merge backend. This option uses the current time as the
author date rather than reusing the original author date when
rewriting commits. We take care to handle the combination of
--ignore-date and --committer-date-is-author-date in the same way as
the apply backend.

Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt   |  7 ++--
 builtin/rebase.c               | 13 ++++---
 sequencer.c                    | 66 +++++++++++++++++++++++++++-------
 sequencer.h                    |  1 +
 t/t3436-rebase-more-options.sh | 56 +++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f9ddfe2e77..79cecd2929 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -450,8 +450,9 @@ See also INCOMPATIBLE OPTIONS below.
 	date. This option implies `--force-rebase`.
 
 --ignore-date::
-	This flag is passed to 'git am' to change the author date
-	of each rebased commit (see linkgit:git-am[1]).
+	Instead of using the author date of the original commit, use
+	the current time as the	author date of the rebased commit.  This
+	option implies `--force-rebase`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -589,7 +590,6 @@ INCOMPATIBLE OPTIONS
 The following options:
 
  * --apply
- * --ignore-date
  * --whitespace
  * -C
 
@@ -617,6 +617,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --empty=
  * --preserve-merges and --ignore-whitespace
  * --preserve-merges and --committer-date-is-author-date
+ * --preserve-merges and --ignore-date
  * --keep-base and --onto
  * --keep-base and --root
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2579380729..583ac96fc7 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -89,6 +89,7 @@ struct rebase_options {
 	char *gpg_sign_opt;
 	int autostash;
 	int committer_date_is_author_date;
+	int ignore_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -127,6 +128,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.committer_date_is_author_date =
 					opts->committer_date_is_author_date;
+	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -1503,8 +1505,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
-		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_BOOL(0, "ignore-date", &options.ignore_date,
+			 N_("ignore author date and use current date")),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
@@ -1797,13 +1799,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	    options.autosquash) {
 		allow_preemptive_ff = 0;
 	}
-	if (options.committer_date_is_author_date)
+	if (options.committer_date_is_author_date || options.ignore_date)
 		options.flags |= REBASE_FORCE;
 
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
-		if (!strcmp(option, "--ignore-date") ||
-		    !strcmp(option, "--whitespace=fix") ||
+		if (!strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			allow_preemptive_ff = 0;
 		else if (skip_prefix(option, "-C", &p)) {
@@ -1862,6 +1863,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		if (options.committer_date_is_author_date)
 			argv_array_push(&options.git_am_opts,
 					"--committer-date-is-author-date");
+		if (options.ignore_date)
+			argv_array_push(&options.git_am_opts, "--ignore-date");
 	} else {
 		/* REBASE_MERGE and PRESERVE_MERGES */
 		if (ignore_whitespace) {
diff --git a/sequencer.c b/sequencer.c
index 78d09f9252..4ccb5451a9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -150,6 +150,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
+static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -959,7 +960,11 @@ static int run_git_commit(struct repository *r,
 
 	if (opts->committer_date_is_author_date)
 		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+				 opts->ignore_date ?
+				 "" :
 				 author_date_from_env_array(&cmd.env_array));
+	if (opts->ignore_date)
+		argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
 
 	argv_array_push(&cmd.args, "commit");
 
@@ -1434,26 +1439,51 @@ static int try_to_commit(struct repository *r,
 		struct ident_split id;
 		struct strbuf date = STRBUF_INIT;
 
-		if (split_ident_line(&id, author, (int)strlen(author)) < 0) {
-			res = error(_("invalid author identity '%s'"), author);
-			goto out;
+		if (!opts->ignore_date) {
+			if (split_ident_line(&id, author, (int)strlen(author)) < 0) {
+				res = error(_("invalid author identity '%s'"),
+					    author);
+				goto out;
+			}
+			if (!id.date_begin) {
+				res = error(_(
+					"corrupt author: missing date information"));
+				goto out;
+			}
+			strbuf_addf(&date, "@%.*s %.*s",
+				    (int)(id.date_end - id.date_begin),
+				    id.date_begin,
+				    (int)(id.tz_end - id.tz_begin),
+				    id.tz_begin);
+		} else {
+			reset_ident_date();
 		}
-		if (!id.date_begin) {
-			res = error(_("corrupt author: missing date information"));
-			goto out;
-		}
-		strbuf_addf(&date, "@%.*s %.*s",
-			    (int)(id.date_end - id.date_begin), id.date_begin,
-			    (int)(id.tz_end - id.tz_begin), id.tz_begin);
 		committer = fmt_ident(opts->committer_name,
 				      opts->committer_email,
-				      WANT_COMMITTER_IDENT, date.buf,
+				      WANT_COMMITTER_IDENT,
+				      opts->ignore_date ? NULL : date.buf,
 				      IDENT_STRICT);
 		strbuf_release(&date);
 	} else {
 		reset_ident_date();
 	}
 
+	if (opts->ignore_date) {
+		struct ident_split id;
+		char *name, *email;
+
+		if (split_ident_line(&id, author, strlen(author)) < 0) {
+			error(_("invalid author identity '%s'"), author);
+			goto out;
+		}
+		name = xmemdupz(id.name_begin, id.name_end - id.name_begin);
+		email = xmemdupz(id.mail_begin, id.mail_end - id.mail_begin);
+		author = fmt_ident(name, email, WANT_AUTHOR_IDENT, NULL,
+				   IDENT_STRICT);
+		free(name);
+		free(email);
+	}
+
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents, oid,
 				 author, committer, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
@@ -2583,6 +2613,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->committer_date_is_author_date = 1;
 		}
 
+		if (file_exists(rebase_path_ignore_date())) {
+			opts->allow_ff = 0;
+			opts->ignore_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2675,6 +2710,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_keep_redundant_commits(), "%s", "");
 	if (opts->committer_date_is_author_date)
 		write_file(rebase_path_cdate_is_adate(), "%s", "");
+	if (opts->ignore_date)
+		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3597,7 +3634,11 @@ static int do_merge(struct repository *r,
 
 		if (opts->committer_date_is_author_date)
 			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+					 opts->ignore_date ?
+					 "" :
 					 author_date_from_env_array(&cmd.env_array));
+		if (opts->ignore_date)
+			argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
 
 		cmd.git_cmd = 1;
 		argv_array_push(&cmd.args, "merge");
@@ -3877,7 +3918,8 @@ static int pick_commits(struct repository *r,
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || opts->edit ||
-			 opts->committer_date_is_author_date));
+			 opts->committer_date_is_author_date ||
+			 opts->ignore_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 7ca657fe2c..20493a2be2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -46,6 +46,7 @@ struct replay_opts {
 	int quiet;
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
+	int ignore_date;
 
 	int mainline;
 
diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
index 50a63d8ebe..0ede2b8900 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -108,6 +108,62 @@ test_expect_success '--committer-date-is-author-date works when committing confl
 	test_ctime_is_atime -1
 '
 
+# Checking for +0000 in the author date is sufficient since the
+# default timezone is UTC but the timezone used while committing is
+# +0530. The inverted logic in the grep is necessary to check all the
+# author dates in the file.
+test_ctime_is_ignored () {
+	git log $1 --format=%ai >authortime &&
+	! grep -v +0000 authortime
+}
+
+test_expect_success '--ignore-date works with apply backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --apply --ignore-date HEAD^ &&
+	test_ctime_is_ignored -1
+'
+
+test_expect_success '--ignore-date works with merge backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --ignore-date -m HEAD^ &&
+	test_ctime_is_ignored -1
+'
+
+test_expect_success '--ignore-date works after conflict resolution' '
+	test_must_fail git rebase --ignore-date -m \
+		--onto commit2^^ commit2^ commit2 &&
+	echo resolved >foo &&
+	git add foo &&
+	git rebase --continue &&
+	test_ctime_is_ignored -1
+'
+
+test_expect_success '--ignore-date works with rebase -r' '
+	git checkout side &&
+	git merge --no-ff commit3 &&
+	git rebase -r --root --ignore-date &&
+	test_ctime_is_ignored
+'
+
+test_expect_success '--ignore-date with --committer-date-is-author-date works' '
+	test_must_fail git rebase -m --committer-date-is-author-date \
+		--ignore-date --onto commit2^^ commit2^ commit3 &&
+	git checkout --theirs foo &&
+	git add foo &&
+	git rebase --continue &&
+	test_ctime_is_atime -2 &&
+	test_ctime_is_ignored -2
+'
+
+test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
+	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
+		PATH="./test-bin:$PATH" git rebase -i --strategy=test \
+				--ignore-date --committer-date-is-author-date \
+				side side &&
+	test_ctime_is_atime -1 &&
+	test_ctime_is_ignored -1
+ '
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.28.0

