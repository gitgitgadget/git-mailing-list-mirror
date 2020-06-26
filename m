Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A56C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7800520679
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRLREkzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgFZJzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFZJzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 05:55:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D15AC08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:55:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so8865012wrv.9
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=WEuNaFYfQP4rrBbqMYsDzhggjuY0TsBsMUq//rNhwvA=;
        b=FRLREkzrmidBXZCcslcOg9aSm08Y92sbvlfPZn32ws8h2RVmoQGPhR6jqgdc1nDGcf
         7smExjqEXG1abNRmc4jerFoKGTUtmh3u0fKruGEE8UOx158DhgBM16UPpXfnPabRB876
         kNZPw8f35CAACYhMtL/6nVMAIkCdjXm94v+PF8yx+YlFLuDh1z7C931M/JyloNZZ8e0z
         eu/1H7ycCwGfq8Hdtn89uKJo4rNR5Y0FmWNCKwPpJZp/6qzJp4TMWxEJE31ULhISFnI5
         jshXzjhsKdKFsEraa9dGxKIm0hCdfmncJfKbbgPFjiTzHspdIs/zZfFw/EXKxsyA4Y0p
         nTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=WEuNaFYfQP4rrBbqMYsDzhggjuY0TsBsMUq//rNhwvA=;
        b=D/0iZOqz2QKggs/NZqmwD0s2CPQiDHaVyRodBTsw3iS3vYH+f7GpaqbSOThOuCHMbh
         lTfE8p/ukvp4wyKDqE652fo6nTPaO0rRFBXnXyFRoFV4LQHEoCdAUXNmvWRNkGTBGuMm
         0dytJp7+3g1OUAa9sZrlvo0+BpvZX24Kn3EuE0kUY4DWWJxaypKpc1uhgzIyk5CwnpgT
         ljEezDtWBXd4bY8nsRQs/Z1BGZzARMsljtR3I05ke6gght5LpX7hQnyHJSBGpQ92FM/x
         Ki3csFvr1YvczoHUo6zzolPHRLKMmFERtSH6iVosp/lR/CabpsNsJwmerM4t3GAwTCal
         f4Dg==
X-Gm-Message-State: AOAM530MhRqRhPlDmQhQzHUJcavCgXQLsw8tTFQZi1o1pIqox/KesYzz
        7YtPCPx5NYsrfhtJS/rrroZ40DVI
X-Google-Smtp-Source: ABdhPJwFnsUFqe+BTBJr5Nk9u9sx1/eBjKkxHgE3fGnFtX9tGc0ETn/bbm4+OKs48eK1+qIaif0YQA==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr2825312wru.200.1593165342904;
        Fri, 26 Jun 2020 02:55:42 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id n14sm14327755wro.81.2020.06.26.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 02:55:42 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 4/5] rebase -i: support --ignore-date
Date:   Fri, 26 Jun 2020 10:55:27 +0100
Message-Id: <20200626095528.117524-5-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626095528.117524-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200626095528.117524-1-phillip.wood123@gmail.com>
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
 Documentation/git-rebase.txt   |  7 +++--
 builtin/rebase.c               | 13 +++++---
 sequencer.c                    | 50 ++++++++++++++++++++++++++++--
 sequencer.h                    |  1 +
 t/t3436-rebase-more-options.sh | 56 ++++++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index dfa70263e6..e2717e20e6 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -450,8 +450,9 @@ See also INCOMPATIBLE OPTIONS below.
 	date. This option implies --force-rebase.
 
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
index a7c3d5c92b..890dd4c588 100644
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
+			 "ignore author date and use current date"),
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
 	} else if (ignore_whitespace) {
 			string_list_append (&strategy_options,
 					    "ignore-space-change");
diff --git a/sequencer.c b/sequencer.c
index 29f6d1bc39..f8e1e38623 100644
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
@@ -889,6 +890,24 @@ static const char *author_date_from_env_array(const struct argv_array *env)
 	BUG("GIT_AUTHOR_DATE missing from author script");
 }
 
+/* Construct a free()able author string with current time as the author date */
+static char *ignore_author_date(const char *author)
+{
+	int len = strlen(author);
+	struct ident_split ident;
+	struct strbuf new_author = STRBUF_INIT;
+
+	if (split_ident_line(&ident, author, len) < 0) {
+		error(_("malformed ident line '%s'"), author);
+		return NULL;
+	}
+
+	len = ident.mail_end - ident.name_begin + 1;
+	strbuf_addf(&new_author, "%.*s ", len, ident.name_begin);
+	datestamp(&new_author);
+	return strbuf_detach(&new_author, NULL);
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -957,7 +976,11 @@ static int run_git_commit(struct repository *r,
 
 	if (opts->committer_date_is_author_date)
 		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+				 opts->ignore_date ?
+				 "" :
 				 author_date_from_env_array(&cmd.env_array));
+	if (opts->ignore_date)
+		argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
 
 	argv_array_push(&cmd.args, "commit");
 
@@ -1388,7 +1411,8 @@ static int try_to_commit(struct repository *r,
 			    ident.date_begin,
 			    (int)(ident.tz_end - ident.tz_begin),
 			    ident.tz_begin);
-		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
+		res = setenv("GIT_COMMITTER_DATE",
+			     opts->ignore_date ? "" : date.buf, 1);
 		strbuf_release(&date);
 
 		if (res)
@@ -1454,6 +1478,16 @@ static int try_to_commit(struct repository *r,
 
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
+
 	if (commit_tree_extended(msg->buf, msg->len, &tree, parents,
 				 oid, author, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
@@ -2583,6 +2617,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->committer_date_is_author_date = 1;
 		}
 
+		if (file_exists(rebase_path_ignore_date())) {
+			opts->allow_ff = 0;
+			opts->ignore_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2675,6 +2714,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_keep_redundant_commits(), "%s", "");
 	if (opts->committer_date_is_author_date)
 		write_file(rebase_path_cdate_is_adate(), "%s", "");
+	if (opts->ignore_date)
+		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3597,7 +3638,11 @@ static int do_merge(struct repository *r,
 
 		if (opts->committer_date_is_author_date)
 			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+					 opts->ignore_date ?
+					 "" :
 					 author_date_from_env_array(&cmd.env_array));
+		if (opts->ignore_date)
+			argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
 
 		cmd.git_cmd = 1;
 		argv_array_push(&cmd.args, "merge");
@@ -3877,7 +3922,8 @@ static int pick_commits(struct repository *r,
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit ||
-				opts->committer_date_is_author_date));
+				opts->committer_date_is_author_date ||
+				opts->ignore_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 4ab94119ae..3587878e3b 100644
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
2.27.0

