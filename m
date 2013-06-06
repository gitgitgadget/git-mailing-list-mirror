From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 8/9] revert/cherry-pick: add --skip option
Date: Thu,  6 Jun 2013 03:59:03 -0500
Message-ID: <1370509144-31974-9-git-send-email-felipe.contreras@gmail.com>
References: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 11:01:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkW4i-0006X8-HM
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 11:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443Ab3FFJBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 05:01:34 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:42116 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433Ab3FFJBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 05:01:21 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so1970789oah.26
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZQ4kgDYNg37bL09dXXZ4vV5wS6j31HMmww/TlHlRtlw=;
        b=KmLhrlwBc9sukQOEjGFxavm2ZV7TF3219RbNFEOCWAg4dBKxrgBBL/k+4CuPBRI6U4
         3zwQDyXFKCCIwPawDNPud4WsPnlZ6k92kwAXSS8ZXhSbSm5ZsRpg4lCgFLrC59ac+KAv
         ZVsXK2zzV+gjzFSJDKT5TA5ZWhmHk1pByaYsaK5439NE/GtqLft8mFeuggXVJB+5+2O7
         IIJJ6HKFafBZyp9OWAG3V/OackCKIkOIj7DlJTAI5w6K7jyQzqZbfTrnTDOISwwIeNRy
         W/yNP3VP0Q3m0TIHd41KB3YdBvn/pLwohjEZCsJ3zv3K1qgVxN7P4jCuW8RUvclE1py+
         USlA==
X-Received: by 10.60.124.195 with SMTP id mk3mr6302389oeb.120.1370509281242;
        Thu, 06 Jun 2013 02:01:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm27617389obz.11.2013.06.06.02.01.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 02:01:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370509144-31974-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226495>

Akin to 'am --skip' and 'rebase --skip'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt |  1 +
 Documentation/git-revert.txt      |  1 +
 Documentation/sequencer.txt       |  3 +++
 builtin/revert.c                  |  6 ++++++
 sequencer.c                       | 32 +++++++++++++++++++++++++++++---
 sequencer.h                       |  3 ++-
 t/t3510-cherry-pick-sequence.sh   | 12 ++++++++++++
 7 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index da0bd81..d95c63c 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git cherry-pick' [-q] [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
 'git cherry-pick' --continue
+'git cherry-pick' --skip
 'git cherry-pick' --quit
 'git cherry-pick' --abort
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 98a8e7a..52e146e 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git revert' [-q] [--[no-]edit] [-n] [-m parent-number] [-s] <commit>...
 'git revert' --continue
+'git revert' --skip
 'git revert' --quit
 'git revert' --abort
 
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 5747f44..df2d355 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -3,6 +3,9 @@
 	'.git/sequencer'.  Can be used to continue after resolving
 	conflicts in a failed cherry-pick or revert.
 
+--skip::
+	Skip the current commit, and then continue.
+
 --quit::
 	Forget about the current operation in progress.  Can be used
 	to clear the sequencer state after a failed cherry-pick or
diff --git a/builtin/revert.c b/builtin/revert.c
index ec83748..d3d5600 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -99,11 +99,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	int remove_state = 0;
 	int contin = 0;
 	int rollback = 0;
+	int skip = 0;
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
 		OPT_BOOLEAN(0, "quit", &remove_state, N_("end revert or cherry-pick sequence")),
 		OPT_BOOLEAN(0, "continue", &contin, N_("resume revert or cherry-pick sequence")),
 		OPT_BOOLEAN(0, "abort", &rollback, N_("cancel revert or cherry-pick sequence")),
+		OPT_BOOLEAN(0, "skip", &skip, N_("skip current commit in the sequence")),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOLEAN('e', "edit", &opts->edit, N_("edit the commit message")),
 		OPT_NOOP_NOARG('r', NULL),
@@ -164,6 +166,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->subcommand = REPLAY_CONTINUE;
 	else if (rollback)
 		opts->subcommand = REPLAY_ROLLBACK;
+	else if (skip)
+		opts->subcommand = REPLAY_SKIP;
 	else
 		opts->subcommand = REPLAY_NONE;
 
@@ -174,6 +178,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			this_operation = "--quit";
 		else if (opts->subcommand == REPLAY_CONTINUE)
 			this_operation = "--continue";
+		else if (opts->subcommand == REPLAY_SKIP)
+			this_operation = "--skip";
 		else {
 			assert(opts->subcommand == REPLAY_ROLLBACK);
 			this_operation = "--abort";
diff --git a/sequencer.c b/sequencer.c
index 4b91bd4..dd9de49 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1181,7 +1181,9 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int sequencer_continue(struct replay_opts *opts)
+static void add_rewritten(unsigned char *from, unsigned char *to);
+
+static int sequencer_continue(struct replay_opts *opts, int skip)
 {
 	struct commit_list *todo_list = NULL;
 
@@ -1201,7 +1203,7 @@ static int sequencer_continue(struct replay_opts *opts)
 	}
 	if (index_differs_from("HEAD", 0))
 		return error_dirty_index(opts);
-	if (opts->action == REPLAY_PICK) {
+	if (opts->action == REPLAY_PICK && !skip) {
 		unsigned char to[20];
 		if (!read_ref("HEAD", to))
 			add_rewritten(todo_list->item->object.sha1, to);
@@ -1210,6 +1212,28 @@ static int sequencer_continue(struct replay_opts *opts)
 	return pick_commits(todo_list, opts);
 }
 
+static int sequencer_skip(struct replay_opts *opts)
+{
+	const char *argv[4]; /* reset --hard HEAD + NULL */
+	struct string_list merge_rr = STRING_LIST_INIT_DUP;
+	int ret;
+
+	if (setup_rerere(&merge_rr, 0) >= 0) {
+		rerere_clear(&merge_rr);
+		string_list_clear(&merge_rr, 1);
+	}
+
+	argv[0] = "reset";
+	argv[1] = "--hard";
+	argv[2] = "HEAD";
+	argv[3] = NULL;
+	ret = run_command_v_opt(argv, RUN_GIT_CMD);
+	if (ret)
+		return ret;
+
+	return sequencer_continue(opts, 1);
+}
+
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
 	int ret;
@@ -1244,7 +1268,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_ROLLBACK)
 		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE)
-		return sequencer_continue(opts);
+		return sequencer_continue(opts, 0);
+	if (opts->subcommand == REPLAY_SKIP)
+		return sequencer_skip(opts);
 
 	for (i = 0; i < opts->revs->pending.nr; i++) {
 		unsigned char sha1[20];
diff --git a/sequencer.h b/sequencer.h
index 6fc416d..efec1b5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -18,7 +18,8 @@ enum replay_subcommand {
 	REPLAY_NONE,
 	REPLAY_REMOVE_STATE,
 	REPLAY_CONTINUE,
-	REPLAY_ROLLBACK
+	REPLAY_ROLLBACK,
+	REPLAY_SKIP
 };
 
 struct replay_opts {
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89d..f58a83d 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -511,4 +511,16 @@ test_expect_success 'commit descriptions in insn sheet are optional' '
 	test_line_count = 4 commits
 '
 
+test_expect_success 'skip' '
+	pristine_detach conflicting &&
+	test_must_fail git cherry-pick initial..picked &&
+
+	git checkout HEAD -- unrelated &&
+	test_must_fail git cherry-pick --continue &&
+	git cherry-pick --skip &&
+
+	git rev-list initial..HEAD >commits &&
+	test_line_count = 3 commits
+'
+
 test_done
-- 
1.8.3.698.g079b096
