Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF22C2BA80
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD9720747
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRDq/Xk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgDGOLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:11:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34092 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbgDGOLy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:11:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so4108933wrl.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=E7zkGjL3uRBTZiZH80nUxt6jKRpgJkbk5Gy9J1muPT0=;
        b=oRDq/Xk7kCRw3V/fLwGZtlOBDEEs+6nRFkYpxKr7SibsFDrqdrjOp9QBdb/9uqsAhz
         lPaSI2O2iQuUCJs5W2GpVRzTrCZGsTPyl7A12bJRP8xAhR/zxntvLBFuRVgQzjT2rA7J
         KaBcrOS3vpZbtUB2XFseyig8vPSRwvFtZgsmkTIZhgbYX5p7OaEhPMswSKZrcMQCgaxL
         I7Vj6IJzuYaHSWqZZgtBmCaD+sl05VV1Z4ZUmXyMMGIeMOPNifcTRNQu6fZgr4zS1x7k
         yRPNGyaTZQ2CZ40LPZYWSoLaqv3JXUVP4UfEU84Z3G0gDwIKeU+m6FXQypTfdlFVp6os
         K/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=E7zkGjL3uRBTZiZH80nUxt6jKRpgJkbk5Gy9J1muPT0=;
        b=lj7slMLHuJJfqehZoJ48+f+YqSzT1zfvuSLbBvt8CGyV9d+SZHOeCYcHUt3vZbnCGg
         s9pRA2cneeG16c4zL8FEC43ETmIXAZKvAbwZFN9g3myjiSqBln167sTn81tCmlorBZHW
         sRX9onNEXMplhBkqWLeG5sN0t5TS+u+VCJsWiPG8y1PBSkRa54AYn2BBuZ15tcMo4amW
         ReqFnjwcJVjh6rGLVD/FEK79w6Sa5ziumwPukosXlOmieC8dhjRDASaT/LfFAAgSC6a8
         hkMdb4a2rTSPWYMaNQbwdjq7RfoE+/mW66X9MwY+SQi3je1PxEpu19RaQK0axIgy6FLu
         IziA==
X-Gm-Message-State: AGi0PuZtnmMMpGqUUVBm4Au0wP+DswD5PzZw0JfYTlCkr9ypLUpLDFu8
        nR9DKdh9puQ8nQmuEpVdg6Xb96ds
X-Google-Smtp-Source: APiQypJYkxKeET3PFvqhXrqTRhu5FQxzArT3lwIXaiHaJfUynvM4hw6Ba4atDOGasryqh7hrN90WSg==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr3204211wrt.213.1586268708643;
        Tue, 07 Apr 2020 07:11:48 -0700 (PDT)
Received: from localhost.localdomain (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id v16sm2492693wml.30.2020.04.07.07.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:11:47 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/6] Revert "Revert "Merge branch 'ra/rebase-i-more-options'""
Date:   Tue,  7 Apr 2020 15:11:20 +0100
Message-Id: <20200407141125.30872-2-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This reverts commit 4d924528d8bfe947abfc54ee9bd3892ab509c8cd.

This is being reverted to enable some fixups for
ra/rebase-i-more-options to be built on this commit.
---
 Documentation/git-rebase.txt            |  27 ++++-
 builtin/rebase.c                        |  49 ++++++--
 sequencer.c                             | 141 ++++++++++++++++++++++--
 sequencer.h                             |   2 +
 t/t3422-rebase-incompatible-options.sh  |   2 -
 t/t3433-rebase-options-compatibility.sh | 131 ++++++++++++++++++++++
 7 files changed, 327 insertions(+), 28 deletions(-)
 create mode 100755 t/t3433-rebase-options-compatibility.sh

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 0c4f038dd6..1d0e2d27cc 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -393,16 +393,31 @@ your branch contains commits which were dropped, this option can be used
 with `--keep-base` in order to drop those commits from your branch.
 
 --ignore-whitespace::
+	Behaves differently depending on which backend is selected.
++
+'am' backend: When applying a patch, ignore changes in whitespace in
+context lines if necessary.
++
+'interactive' backend: Treat lines with only whitespace changes as
+unchanged for the sake of a three-way merge.
+
 --whitespace=<option>::
-	These flag are passed to the 'git apply' program
+	This flag is passed to the 'git apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
 +
 See also INCOMPATIBLE OPTIONS below.
 
 --committer-date-is-author-date::
+	Instead of recording the time the rebased commits are
+	created as the committer date, reuse the author date
+	as the committer date. This implies --force-rebase.
+
 --ignore-date::
-	These flags are passed to 'git am' to easily change the dates
-	of the rebased commits (see linkgit:git-am[1]).
+--reset-author-date::
+	By default, the author date of the original commit is used
+	as the author date for the resulting commit.  This option
+	tells Git to use the current timestamp instead and implies
+	`--force-rebase`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -539,10 +554,7 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --committer-date-is-author-date
- * --ignore-date
  * --whitespace
- * --ignore-whitespace
  * -C
 
 are incompatible with the following options:
@@ -565,6 +577,9 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --interactive
  * --preserve-merges and --signoff
  * --preserve-merges and --rebase-merges
+ * --preserve-merges and --ignore-whitespace
+ * --preserve-merges and --committer-date-is-author-date
+ * --preserve-merges and --ignore-date
  * --keep-base and --onto
  * --keep-base and --root
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 8081741f8a..e354ec84bb 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -79,8 +79,11 @@ struct rebase_options {
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
+	int ignore_whitespace;
 	char *gpg_sign_opt;
 	int autostash;
+	int committer_date_is_author_date;
+	int ignore_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -99,6 +102,7 @@ struct rebase_options {
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 {
+	struct strbuf strategy_buf = STRBUF_INIT;
 	struct replay_opts replay = REPLAY_OPTS_INIT;
 
 	replay.action = REPLAY_INTERACTIVE_REBASE;
@@ -112,10 +116,20 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.allow_empty_message = opts->allow_empty_message;
 	replay.verbose = opts->flags & REBASE_VERBOSE;
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
+	replay.committer_date_is_author_date =
+					opts->committer_date_is_author_date;
+	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
+
 	if (opts->strategy_opts)
-		parse_strategy_opts(&replay, opts->strategy_opts);
+		strbuf_addstr(&strategy_buf, opts->strategy_opts);
+	if (opts->ignore_whitespace)
+		strbuf_addstr(&strategy_buf, " --ignore-space-change");
+	if (strategy_buf.len)
+		parse_strategy_opts(&replay, strategy_buf.buf);
+
+	strbuf_release(&strategy_buf);
 
 	if (opts->squash_onto) {
 		oidcpy(&replay.squash_onto, opts->squash_onto);
@@ -517,6 +531,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
 
+	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
+
 	if (!is_null_oid(&squash_onto))
 		opts.squash_onto = &squash_onto;
 
@@ -970,6 +986,12 @@ static int run_am(struct rebase_options *opts)
 	am.git_cmd = 1;
 	argv_array_push(&am.args, "am");
 
+	if (opts->ignore_whitespace)
+		argv_array_push(&am.args, "--ignore-whitespace");
+	if (opts->committer_date_is_author_date)
+		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
+	if (opts->ignore_date)
+		argv_array_push(&opts->git_am_opts, "--ignore-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1437,16 +1459,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by: line to each commit")),
-		OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
-				  NULL, N_("passed to 'git am'"),
-				  PARSE_OPT_NOARG),
-		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
-				  &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
-		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_BOOL(0, "committer-date-is-author-date",
+			 &options.committer_date_is_author_date,
+			 N_("make committer date match author date")),
+		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
+			 N_("ignore author date and use current date")),
+		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
+				N_("synonym of --reset-author-date")),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
+		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
+			 N_("ignore changes in whitespace")),
 		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
 				  N_("action"), N_("passed to 'git apply'"), 0),
 		OPT_BIT('f', "force-rebase", &options.flags,
@@ -1719,11 +1742,13 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
+	if (options.committer_date_is_author_date ||
+	    options.ignore_date)
+		options.flags |= REBASE_FORCE;
+
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
-		if (!strcmp(option, "--committer-date-is-author-date") ||
-		    !strcmp(option, "--ignore-date") ||
-		    !strcmp(option, "--whitespace=fix") ||
+		if (!strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			options.flags |= REBASE_FORCE;
 		else if (skip_prefix(option, "-C", &p)) {
diff --git a/sequencer.c b/sequencer.c
index b9dbf1adb0..763ccbbc45 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -147,6 +147,8 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  * command-line.
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
+static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
+static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -823,9 +825,19 @@ int read_author_script(const char *path, char **name, char **email, char **date,
 		error(_("missing 'GIT_AUTHOR_DATE'"));
 	if (date_i < 0 || email_i < 0 || date_i < 0 || err)
 		goto finish;
-	*name = kv.items[name_i].util;
-	*email = kv.items[email_i].util;
-	*date = kv.items[date_i].util;
+
+	if (name)
+		*name = kv.items[name_i].util;
+	else
+		free(kv.items[name_i].util);
+	if (email)
+		*email = kv.items[email_i].util;
+	else
+		free(kv.items[email_i].util);
+	if (date)
+		*date = kv.items[date_i].util;
+	else
+		free(kv.items[date_i].util);
 	retval = 0;
 finish:
 	string_list_clear(&kv, !!retval);
@@ -868,6 +880,47 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
+/* Returns a "date" string that needs to be free()'d by the caller */
+static char *read_author_date_or_null(void)
+{
+	char *date;
+
+	if (read_author_script(rebase_path_author_script(),
+			       NULL, NULL, &date, 0))
+		return NULL;
+	return date;
+}
+
+/* Construct a free()able author string with current time as the author date */
+static char *ignore_author_date(const char *author)
+{
+	int len = strlen(author);
+	struct ident_split ident;
+	struct strbuf new_author = STRBUF_INIT;
+
+	if (split_ident_line(&ident, author, len) < 0) {
+		error(_("malformed ident line"));
+		return NULL;
+	}
+	len = ident.mail_end - ident.name_begin + 1;
+
+	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
+	datestamp(&new_author);
+	return strbuf_detach(&new_author, NULL);
+}
+
+static void push_dates(struct child_process *child, int change_committer_date)
+{
+	time_t now = time(NULL);
+	struct strbuf date = STRBUF_INIT;
+
+	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
+	argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
+	if (change_committer_date)
+		argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
+	strbuf_release(&date);
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -927,6 +980,25 @@ static int run_git_commit(struct repository *r,
 
 	cmd.git_cmd = 1;
 
+	if (opts->committer_date_is_author_date) {
+		int res = -1;
+		struct strbuf datebuf = STRBUF_INIT;
+		char *date = read_author_date_or_null();
+
+		if (!date)
+			return -1;
+
+		strbuf_addf(&datebuf, "@%s", date);
+		res = setenv("GIT_COMMITTER_DATE",
+			     opts->ignore_date ? "" : datebuf.buf, 1);
+
+		strbuf_release(&datebuf);
+		free(date);
+
+		if (res)
+			return -1;
+	}
+
 	if (is_rebase_i(opts) && read_env_script(&cmd.env_array)) {
 		const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
@@ -942,6 +1014,8 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+	if (opts->ignore_date)
+		push_dates(&cmd, opts->committer_date_is_author_date);
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
@@ -1310,14 +1384,13 @@ static int try_to_commit(struct repository *r,
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf commit_msg = STRBUF_INIT;
-	char *amend_author = NULL;
+	char *author_to_free = NULL;
 	const char *hook_commit = NULL;
 	enum commit_msg_cleanup_mode cleanup;
 	int res = 0;
 
 	if (parse_head(r, &current_head))
 		return -1;
-
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", NULL };
 		const char *out_enc = get_commit_output_encoding();
@@ -1332,7 +1405,7 @@ static int try_to_commit(struct repository *r,
 			strbuf_addstr(msg, orig_message);
 			hook_commit = "HEAD";
 		}
-		author = amend_author = get_author(message);
+		author = author_to_free = get_author(message);
 		unuse_commit_buffer(current_head, message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
@@ -1345,6 +1418,31 @@ static int try_to_commit(struct repository *r,
 		commit_list_insert(current_head, &parents);
 	}
 
+	if (opts->committer_date_is_author_date) {
+		int len = strlen(author);
+		struct ident_split ident;
+		struct strbuf date = STRBUF_INIT;
+
+		if (split_ident_line(&ident, author, len) < 0) {
+			res = error(_("malformed ident line"));
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
+		res = setenv("GIT_COMMITTER_DATE",
+			     opts->ignore_date ? "" : date.buf, 1);
+		strbuf_release(&date);
+
+		if (res)
+			goto out;
+	}
+
 	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
 		res = error(_("git write-tree failed to write a tree"));
 		goto out;
@@ -1404,6 +1502,15 @@ static int try_to_commit(struct repository *r,
 
 	reset_ident_date();
 
+	if (opts->ignore_date) {
+		author = ignore_author_date(author);
+		if (!author) {
+			res = -1;
+			goto out;
+		}
+		free(author_to_free);
+		author_to_free = (char *)author;
+	}
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
 				 oid, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
@@ -1424,7 +1531,7 @@ static int try_to_commit(struct repository *r,
 	free_commit_extra_headers(extra);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
-	free(amend_author);
+	free(author_to_free);
 
 	return res;
 }
@@ -2492,6 +2599,16 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->signoff = 1;
 		}
 
+		if (file_exists(rebase_path_cdate_is_adate())) {
+			opts->allow_ff = 0;
+			opts->committer_date_is_author_date = 1;
+		}
+
+		if (file_exists(rebase_path_ignore_date())) {
+			opts->allow_ff = 0;
+			opts->ignore_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2574,6 +2691,10 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
 	if (opts->signoff)
 		write_file(rebase_path_signoff(), "--signoff\n");
+	if (opts->committer_date_is_author_date)
+		write_file(rebase_path_cdate_is_adate(), "%s", "");
+	if (opts->ignore_date)
+		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3514,6 +3635,8 @@ static int do_merge(struct repository *r,
 		argv_array_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			argv_array_push(&cmd.args, opts->gpg_sign);
+		if (opts->ignore_date)
+			push_dates(&cmd, opts->committer_date_is_author_date);
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
@@ -3786,7 +3909,9 @@ static int pick_commits(struct repository *r,
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
-				opts->record_origin || opts->edit));
+				opts->record_origin || opts->edit ||
+				opts->committer_date_is_author_date ||
+				opts->ignore_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 9f9ae291e3..e9a0e03ea2 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -43,6 +43,8 @@ struct replay_opts {
 	int verbose;
 	int quiet;
 	int reschedule_failed_exec;
+	int committer_date_is_author_date;
+	int ignore_date;
 
 	int mainline;
 
diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
index 50e7960702..c8234062c6 100755
--- a/t/t3422-rebase-incompatible-options.sh
+++ b/t/t3422-rebase-incompatible-options.sh
@@ -61,8 +61,6 @@ test_rebase_am_only () {
 }
 
 test_rebase_am_only --whitespace=fix
-test_rebase_am_only --ignore-whitespace
-test_rebase_am_only --committer-date-is-author-date
 test_rebase_am_only -C4
 
 test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
new file mode 100755
index 0000000000..5166f158dd
--- /dev/null
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -0,0 +1,131 @@
+#!/bin/sh
+#
+# Copyright (c) 2019 Rohit Ashiwal
+#
+
+test_description='tests to ensure compatibility between am and interactive backends'
+
+. ./test-lib.sh
+
+GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
+export GIT_AUTHOR_DATE
+
+# This is a special case in which both am and interactive backends
+# provide the same output. It was done intentionally because
+# both the backends fall short of optimal behaviour.
+test_expect_success 'setup' '
+	git checkout -b topic &&
+	q_to_tab >file <<-\EOF &&
+	line 1
+	Qline 2
+	line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	cat >file <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	git commit -am "update file" &&
+	git tag side &&
+	test_commit commit1 foo foo1 &&
+	test_commit commit2 foo foo2 &&
+	test_commit commit3 foo foo3 &&
+
+	git checkout --orphan master &&
+	git rm --cached foo &&
+	rm foo &&
+	sed -e "s/^|//" >file <<-\EOF &&
+	|line 1
+	|        line 2
+	|line 3
+	EOF
+	git add file &&
+	git commit -m "add file" &&
+	git tag main
+'
+
+test_expect_success '--ignore-whitespace works with am backend' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	test_must_fail git rebase main side &&
+	git rebase --abort &&
+	git rebase --ignore-whitespace main side &&
+	test_cmp expect file
+'
+
+test_expect_success '--ignore-whitespace works with interactive backend' '
+	cat >expect <<-\EOF &&
+	line 1
+	new line 2
+	line 3
+	EOF
+	test_must_fail git rebase --merge main side &&
+	git rebase --abort &&
+	git rebase --merge --ignore-whitespace main side &&
+	test_cmp expect file
+'
+
+test_expect_success '--committer-date-is-author-date works with am backend' '
+	git commit --amend &&
+	git rebase --committer-date-is-author-date HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	git show HEAD --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works with interactive backend' '
+	git commit --amend &&
+	git rebase -i --committer-date-is-author-date HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	git show HEAD --pretty="format:%ci" >committertime &&
+	test_cmp authortime committertime
+'
+
+test_expect_success '--committer-date-is-author-date works with rebase -r' '
+	git checkout side &&
+	git merge --no-ff commit3 &&
+	git rebase -r --root --committer-date-is-author-date &&
+	git rev-list HEAD >rev_list &&
+	while read HASH
+	do
+		git show $HASH --pretty="format:%ai" >authortime
+		git show $HASH --pretty="format:%ci" >committertime
+		test_cmp authortime committertime
+	done <rev_list
+'
+
+# Checking for +0000 in author time is enough since default
+# timezone is UTC, but the timezone used while committing
+# sets to +0530.
+test_expect_success '--ignore-date works with am backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --ignore-date HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime
+'
+
+test_expect_success '--ignore-date works with interactive backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --ignore-date -i HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime
+'
+
+test_expect_success '--ignore-date works with rebase -r' '
+	git checkout side &&
+	git merge --no-ff commit3 &&
+	git rebase -r --root --ignore-date &&
+	git rev-list HEAD >rev_list &&
+	while read HASH
+	do
+		git show $HASH --pretty="format:%ai" >authortime
+		grep "+0000" authortime
+	done <rev_list
+'
+
+test_done
-- 
2.26.0

