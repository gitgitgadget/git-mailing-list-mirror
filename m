Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE5D1F461
	for <e@80x24.org>; Sat,  7 Sep 2019 11:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392111AbfIGLvQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 07:51:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35194 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbfIGLvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 07:51:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so6301242pfw.2
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/+S74DLvkdk6hSG5fBHlIiIhC/yhFiROv+hfd7mykY=;
        b=ARuc7wNYNT+n8QCHCyzKgPigALZoX7o5410P7q+4Opfgle0HdXR22fdnUPo6DgWoeq
         cACI5ts0oDkbs68aPyqjN9Q868e067XeCZRQ99caUCqJs788L4KzJj9J9XA8VV1QJytl
         wfj2KmEzkwsRai5IojCoDLfbMI2ZtgA3aHrjJYTSzDlpt5W4y7bEUsDjaAbUfnFvoM3A
         AoOcFGZpJvVLZuPzi1x7rMXC7r0dGNWGHIs8e7RE3H0gAfGhecS1JUNr2eyFkBi5rQ2v
         yhPY4cr7NBct5pHUMuvANE+w9pWH7AyHta0Vl1sROhG10agYW4jjz083Lg5++xDMnYDn
         SYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/+S74DLvkdk6hSG5fBHlIiIhC/yhFiROv+hfd7mykY=;
        b=uYhqSqBcsBNvMNFd753HxKSBii31psA/RQWSjcWds/4wJfSu8ZPAzroxfkCSt8m7zA
         uTHyUwmL3rC9V9dWtDc49PgmNLClJYJEhVMNkX5Awkf8nNhRB5GULlD5vINNqDTi1OFM
         ++dBrIUpanGiTiIMr2zVXcBCKuIo7XZMNRnM0FdhlF5SgPNoKJc3H4QHJIFfisGQnVuR
         ZKLiiesen9tIfQkHFiA8hFqskY01V1gd2C7HxKl6jnUNf1P2uRAs/ntF1rUv2ouX1RgO
         VGnMhB5KDYyLwRW/lC1EG6XKDtTgDdohHTxJf5JDOd/gWa58DQzAiT+OULzEbtjdLILx
         FeKA==
X-Gm-Message-State: APjAAAUKLM+nRDSfc9jBsiY6AK71t00m1hyodI89H6pUjGUEJNbY3FV+
        r2AjJoqtGjVjy5h4bbBLSE6ZnsOK4Uw=
X-Google-Smtp-Source: APXvYqxQ6Xd/Jy6PQtzxcskF+KV0SVkk5j55M6hP+q7CVidkl7/2igGYhPAIeBM6dl9Ed1BXbxMQcg==
X-Received: by 2002:a17:90a:fa89:: with SMTP id cu9mr14520718pjb.139.1567857075318;
        Sat, 07 Sep 2019 04:51:15 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.225])
        by smtp.gmail.com with ESMTPSA id a11sm18134792pfg.94.2019.09.07.04.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 04:51:14 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v4 5/6] rebase -i: support --ignore-date
Date:   Sat,  7 Sep 2019 17:20:33 +0530
Message-Id: <20190907115034.14933-6-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase am already has this flag to "lie" about the author date
by changing it to the committer (current) date. Let's add the same
for interactive machinery.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt            |  6 +--
 builtin/rebase.c                        | 18 ++++++---
 sequencer.c                             | 53 ++++++++++++++++++++++++-
 sequencer.h                             |  1 +
 t/t3433-rebase-options-compatibility.sh | 35 ++++++++++++++++
 5 files changed, 104 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index e7c0eac18c..e7ac9fae0b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -391,8 +391,8 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
-	This flag is passed to 'git am' to change the author date
-	of each rebased commit (see linkgit:git-am[1]).
+	Instead of using the given author date, reset it to the value
+	same as the current time. This implies --force-rebase.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -529,7 +529,6 @@ INCOMPATIBLE OPTIONS
 
 The following options:
 
- * --ignore-date
  * --whitespace
  * -C
 
@@ -555,6 +554,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --rebase-merges
  * --preserve-merges and --ignore-whitespace
  * --preserve-merges and --committer-date-is-author-date
+ * --preserve-merges and --ignore-date
  * --rebase-merges and --ignore-whitespace
  * --rebase-merges and --strategy
  * --rebase-merges and --strategy-option
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 656bc7d7e9..e6f90f61dd 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -83,6 +83,7 @@ struct rebase_options {
 	char *gpg_sign_opt;
 	int autostash;
 	int committer_date_is_author_date;
+	int ignore_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -117,6 +118,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.committer_date_is_author_date =
 					opts->committer_date_is_author_date;
+	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -981,6 +983,8 @@ static int run_am(struct rebase_options *opts)
 		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->committer_date_is_author_date)
 		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
+	if (opts->ignore_date)
+		argv_array_push(&opts->git_am_opts, "--ignore-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1427,8 +1431,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
-		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
-				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
+		OPT_BOOL(0, "ignore-date", &options.ignore_date,
+			 "ignore author date and use current date"),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
 				  N_("passed to 'git apply'"), 0),
 		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
@@ -1697,13 +1701,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		    state_dir_base, cmd_live_rebase, buf.buf);
 	}
 
-	if (options.committer_date_is_author_date)
+	if (options.ignore_date) {
+		options.committer_date_is_author_date = 0;
+		setenv("GIT_COMMITTER_DATE", "", 1);
+	}
+	if (options.committer_date_is_author_date ||
+	    options.ignore_date)
 		options.flags |= REBASE_FORCE;
 
 	for (i = 0; i < options.git_am_opts.argc; i++) {
 		const char *option = options.git_am_opts.argv[i], *p;
-		if (!strcmp(option, "--ignore-date") ||
-		    !strcmp(option, "--whitespace=fix") ||
+		if (!strcmp(option, "--whitespace=fix") ||
 		    !strcmp(option, "--whitespace=strip"))
 			options.flags |= REBASE_FORCE;
 		else if (skip_prefix(option, "-C", &p)) {
diff --git a/sequencer.c b/sequencer.c
index 0d78abeec8..188499190f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -148,6 +148,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
  */
 static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
+static GIT_PATH_FUNC(rebase_path_ignore_date, "rebase-merge/ignore_date")
 static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
@@ -891,6 +892,35 @@ static char *read_author_date_or_null(void)
 	return date;
 }
 
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
+	strbuf_addf(&new_author, "%.*s ", len, author);
+	datestamp(&new_author);
+	return strbuf_detach(&new_author, NULL);
+}
+
+static void push_dates(struct child_process *child)
+{
+	time_t now = time(NULL);
+	struct strbuf date = STRBUF_INIT;
+
+	strbuf_addf(&date, "@%"PRIuMAX, (uintmax_t)now);
+	argv_array_pushf(&child->env_array, "GIT_AUTHOR_DATE=%s", date.buf);
+	argv_array_pushf(&child->env_array, "GIT_COMMITTER_DATE=%s", date.buf);
+	strbuf_release(&date);
+}
+
 static const char staged_changes_advice[] =
 N_("you have staged changes in your working tree\n"
 "If these changes are meant to be squashed into the previous commit, run:\n"
@@ -983,6 +1013,8 @@ static int run_git_commit(struct repository *r,
 		argv_array_push(&cmd.args, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
+	if (opts->ignore_date)
+		push_dates(&cmd);
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
 	else if (!(flags & EDIT_MSG))
@@ -1451,6 +1483,15 @@ static int try_to_commit(struct repository *r,
 
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
@@ -2527,6 +2568,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->committer_date_is_author_date = 1;
 		}
 
+		if (file_exists(rebase_path_ignore_date())) {
+			opts->allow_ff = 0;
+			opts->ignore_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2611,6 +2657,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_signoff(), "--signoff\n");
 	if (opts->committer_date_is_author_date)
 		write_file(rebase_path_cdate_is_adate(), "%s", "");
+	if (opts->ignore_date)
+		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3536,6 +3584,8 @@ static int do_merge(struct repository *r,
 		argv_array_push(&cmd.args, git_path_merge_msg(r));
 		if (opts->gpg_sign)
 			argv_array_push(&cmd.args, opts->gpg_sign);
+		if (opts->ignore_date)
+			push_dates(&cmd);
 
 		/* Add the tips to be merged */
 		for (j = to_merge; j; j = j->next)
@@ -3809,7 +3859,8 @@ static int pick_commits(struct repository *r,
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit ||
-				opts->committer_date_is_author_date));
+				opts->committer_date_is_author_date ||
+				opts->ignore_date));
 	if (read_and_refresh_cache(r, opts))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index e3881e9275..bf5a79afdb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -44,6 +44,7 @@ struct replay_opts {
 	int quiet;
 	int reschedule_failed_exec;
 	int committer_date_is_author_date;
+	int ignore_date;
 
 	int mainline;
 
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index 6c1fbab4d8..0ad7bfc6a0 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -99,4 +99,39 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
 	done <rev_list
 '
 
+# Checking for +0000 in author time is enough since default
+# timezone is UTC, but the timezone used while committing
+# sets to +0530.
+test_expect_success '--ignore-date works with am backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --ignore-date HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	git show HEAD --pretty="format:%ci" >committertime &&
+	grep "+0000" authortime &&
+	grep "+0000" committertime
+'
+
+test_expect_success '--ignore-date works with interactive backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --ignore-date -i HEAD^ &&
+	git show HEAD --pretty="format:%ai" >authortime &&
+	git show HEAD --pretty="format:%ci" >committertime &&
+	grep "+0000" authortime &&
+	grep "+0000" committertime
+'
+
+test_expect_success '--ignore-date works with rebase -r' '
+	git checkout side &&
+	git merge commit3 &&
+	git rebase -r --root --ignore-date &&
+	git rev-list HEAD >rev_list &&
+	while read HASH
+	do
+		git show $HASH --pretty="format:%ai" >authortime
+		git show $HASH --pretty="format:%ci" >committertime
+		grep "+0000" authortime
+		grep "+0000" committertime
+	done <rev_list
+'
+
 test_done
-- 
2.21.0

