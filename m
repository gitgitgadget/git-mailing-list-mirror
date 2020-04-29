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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3846C83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7092B2082E
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 10:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtwZAhD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgD2K04 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgD2K0u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 06:26:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC4FC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so1416505wma.4
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=sWmBWonnVlstbq4q3FTCSHbb6Zw9XMusvrvq/NZXr/w=;
        b=FtwZAhD51HpyJbajGpOgcj5WIwc1Yx5OTdMIXukwmj1j4QG/aRXZUtJXAgvEKJ066P
         Du62u23NKsS8iJHdeeehkJoN7bKcFRctrqm6SCabmQbz7HqnaFVMpnvkoufkSUGsH+K6
         QZL5xz9qEtdnK/8ahfl6TdmRK7qlbEM23IoKLvK1l3YUVado1OFh1/+VzLCvwA5e8dzw
         cbwT46HVg4N+E7Gv/DRhe7spzoXLiKrZHS/s+UF36QwbebHjw2EuLvuZ66hcrjB82a5+
         o+C/srXOd1y5d4Co1AmixUL8b01fxX65L3XLXuO3KvkMK5D5yz75Dm/+6590bk0HP0Fw
         B2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=sWmBWonnVlstbq4q3FTCSHbb6Zw9XMusvrvq/NZXr/w=;
        b=RW2ISzdRxva+jEjFvJCzgpTuC11sraEumrxaPcYH+zTWexn9leMATpr8bkOpstpNst
         VAhZxqxPLVwNXdTzm4G7jsMloM4wrbsx2NnJOvPKqGUPTamRgUo/36R8ZKe1dFiCDg6c
         P6VyM3uLlxQxu+CDezp7dXq79LGfmtSH1669TfvwZO8M0mDq6NPEsAxhujTx2EwdN63L
         GGTbLj9phstNkofwmXaiyLb5lXMT6KEPLuzoNvFD5CkdptzILr5bHYA8bBFYzMs6UC05
         iCEdLYXMEXczxaMaPp7m7VpwzzYQap6On9KnJKh0Mh9isWHr351xPRFvfl14604OTkFv
         Cuqw==
X-Gm-Message-State: AGi0PuZpRBe+IysakEWlAsmS3kpT22PL2m0tjZZGKW3KbLFS/W3PIQsA
        j7YNbgydPD+UylmXskmzl74=
X-Google-Smtp-Source: APiQypJ6lTUc317qIKRhITb67yz1NK0T8BoLNizpxuOMotfHxWEfOJD6rD0+x9OfEE9kY9C9qqcfdQ==
X-Received: by 2002:a1c:6344:: with SMTP id x65mr2502759wmb.56.1588156009077;
        Wed, 29 Apr 2020 03:26:49 -0700 (PDT)
Received: from localhost.localdomain (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id c1sm30718196wrc.4.2020.04.29.03.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 03:26:48 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 4/5] rebase -i: support --ignore-date
Date:   Wed, 29 Apr 2020 11:25:20 +0100
Message-Id: <20200429102521.47995-5-phillip.wood123@gmail.com>
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

As part of the on-going effort to retire the apply rebase backend
teach the merge backend how to handle --ignore-date. We take care to
handle the combination of --ignore-date and
--committer-date-is-author-date in the same way as the apply backend.

Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-rebase.txt   |  7 +++--
 builtin/rebase.c               | 13 +++++---
 sequencer.c                    | 49 +++++++++++++++++++++++++++--
 sequencer.h                    |  1 +
 t/t3436-rebase-more-options.sh | 57 ++++++++++++++++++++++++++++++++++
 5 files changed, 117 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 8c62645b8c..96c7125791 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -443,8 +443,9 @@ See also INCOMPATIBLE OPTIONS below.
 	date. This option implies --force-rebase.
 
 --ignore-date::
-	This flag is passed to 'git am' to change the author date
-	of each rebased commit (see linkgit:git-am[1]).
+	Instead of using the author date of the original commit, use
+	the current time as the	author date of the rebased commit.  This
+	option implies `--force-rebase`.
 +
 See also INCOMPATIBLE OPTIONS below.
 
@@ -582,7 +583,6 @@ INCOMPATIBLE OPTIONS
 The following options:
 
  * --apply
- * --ignore-date
  * --whitespace
  * -C
 
@@ -610,6 +610,7 @@ In addition, the following pairs of options are incompatible:
  * --preserve-merges and --empty=
  * --preserve-merges and --ignore-whitespace
  * --preserve-merges and --committer-date-is-author-date
+ * --preserve-merges and --ignore-date
  * --keep-base and --onto
  * --keep-base and --root
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 357cd6acf3..cf86240bc8 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -90,6 +90,7 @@ struct rebase_options {
 	char *gpg_sign_opt;
 	int autostash;
 	int committer_date_is_author_date;
+	int ignore_date;
 	char *cmd;
 	int allow_empty_message;
 	int rebase_merges, rebase_cousins;
@@ -129,6 +130,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
 	replay.committer_date_is_author_date =
 					opts->committer_date_is_author_date;
+	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.strategy = opts->strategy;
 
@@ -1008,6 +1010,8 @@ static int run_am(struct rebase_options *opts)
 		argv_array_push(&am.args, "--ignore-whitespace");
 	if (opts->committer_date_is_author_date)
 		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
+	if (opts->ignore_date)
+		argv_array_push(&opts->git_am_opts, "--ignore-date");
 	if (opts->action && !strcmp("continue", opts->action)) {
 		argv_array_push(&am.args, "--resolved");
 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
@@ -1515,8 +1519,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
@@ -1809,13 +1813,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
diff --git a/sequencer.c b/sequencer.c
index 8dff8b9b95..339dbf4a59 100644
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
+	len = ident.mail_end - ident.name_begin + 1;
+
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
 
@@ -1386,7 +1409,8 @@ static int try_to_commit(struct repository *r,
 		strbuf_addf(&date, "@%.*s %.*s",
 			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
 			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
-		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
+		res = setenv("GIT_COMMITTER_DATE",
+			     opts->ignore_date ? "" : date.buf, 1);
 		strbuf_release(&date);
 
 		if (res)
@@ -1452,6 +1476,15 @@ static int try_to_commit(struct repository *r,
 
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
@@ -2581,6 +2614,11 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->committer_date_is_author_date = 1;
 		}
 
+		if (file_exists(rebase_path_ignore_date())) {
+			opts->allow_ff = 0;
+			opts->ignore_date = 1;
+		}
+
 		if (file_exists(rebase_path_reschedule_failed_exec()))
 			opts->reschedule_failed_exec = 1;
 
@@ -2673,6 +2711,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_keep_redundant_commits(), "%s", "");
 	if (opts->committer_date_is_author_date)
 		write_file(rebase_path_cdate_is_adate(), "%s", "");
+	if (opts->ignore_date)
+		write_file(rebase_path_ignore_date(), "%s", "");
 	if (opts->reschedule_failed_exec)
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 
@@ -3595,7 +3635,11 @@ static int do_merge(struct repository *r,
 
 		if (opts->committer_date_is_author_date)
 			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
+					 opts->ignore_date ?
+					 "" :
 					 author_date_from_env_array(&cmd.env_array));
+		if (opts->ignore_date)
+			argv_array_push(&cmd.env_array, "GIT_AUTHOR_DATE=");
 
 		cmd.git_cmd = 1;
 		argv_array_push(&cmd.args, "merge");
@@ -3875,7 +3919,8 @@ static int pick_commits(struct repository *r,
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
index 84b9d5d37f..6cd3848689 100755
--- a/t/t3436-rebase-more-options.sh
+++ b/t/t3436-rebase-more-options.sh
@@ -134,6 +134,63 @@ test_expect_success '--committer-date-is-author-date works when committing confl
 	test_cmp expect actual
 '
 
+# Checking for +0000 in author time is enough since default
+# timezone is UTC, but the timezone used while committing
+# sets to +0530.
+test_expect_success '--ignore-date works with apply backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --apply --ignore-date HEAD^ &&
+	git log -1 --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime
+'
+
+test_expect_success '--ignore-date works with merge backend' '
+	git commit --amend --date="$GIT_AUTHOR_DATE" &&
+	git rebase --ignore-date -m HEAD^ &&
+	git log -1 --pretty="format:%ai" >authortime &&
+	grep "+0000" authortime
+'
+
+test_expect_success '--ignore-date works after conflict resolution' '
+	test_must_fail git rebase --ignore-date -m \
+		--onto commit2^^ commit2^ commit2 &&
+	echo resolved >foo &&
+	git add foo &&
+	git rebase --continue &&
+	git log --pretty=%ai >authortime &&
+	grep +0000 authortime
+'
+
+test_expect_success '--ignore-date works with rebase -r' '
+	git checkout side &&
+	git merge --no-ff commit3 &&
+	git rebase -r --root --ignore-date &&
+	git log --pretty=%ai >authortime &&
+	! grep -v "+0000" authortime
+'
+
+test_expect_success '--ignore-date with --committer-date-is-author-date works' '
+	test_must_fail git rebase -m --committer-date-is-author-date \
+		--ignore-date --onto commit2^^ commit2^ commit3 &&
+	git checkout --theirs foo &&
+	git add foo &&
+	git rebase --continue &&
+	git log -2 --pretty=%ai >authortime &&
+	git log -2 --pretty=%ci >committertime &&
+	test_cmp authortime committertime &&
+	! grep -v "+0000" authortime
+'
+
+test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
+	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
+		git rebase -i --strategy=resolve --ignore-date \
+		--committer-date-is-author-date side side &&
+	git log -1 --pretty=%ai >authortime &&
+	git log -1 --pretty=%ci >committertime &&
+	test_cmp authortime committertime &&
+	grep "+0000" authortime
+ '
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
2.26.2

