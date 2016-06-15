From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 14/36] revert/cherry-pick: add --skip option
Date: Sun,  9 Jun 2013 14:24:28 -0500
Message-ID: <1370805890-3453-15-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllH2-0003Xe-UM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab3FIT10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:26 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:60388 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab3FIT1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:24 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so8892420obb.22
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S8zYBgvU3XWNLpGVcc5CjouNIuKVCMWBifkJRLEoobA=;
        b=LxYjuy2HJR7fD/ZTmFVMkXRWBdWnxScHEMWPmUUtZ2Ilj1YmW7ZGouzceX/ko2yQ/V
         VyCbSd9i+PWJqQJvjJk69NejdShbT7AAnT5/LdIYIwGcIzwazV8UT3tQrhDXAwVbnqBC
         lAikoNIS3c1ZqLXL9RaIqWpZfNsX7GWYoWApUqzLzgs48Xvc6HmQON5ZcpLqQfJaUmvk
         nJrLi1CpKCyOEOYsfwb4TzoBAx+l+ZGcQieAUT63NosupEd7DkiECZa8DfO2VnncrF3O
         ejRaPe3BW5U7sWUDp9TMBrGO0mh87FHyyH03DIbVP3sTAz2exuLDtKwWn+cjLS8jdSDl
         0GNQ==
X-Received: by 10.60.61.11 with SMTP id l11mr5717874oer.95.1370806044273;
        Sun, 09 Jun 2013 12:27:24 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kz3sm15998332obb.6.2013.06.09.12.27.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227122>

Akin to 'am --skip' and 'rebase --skip'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt |  1 +
 Documentation/git-revert.txt      |  1 +
 Documentation/sequencer.txt       |  3 +++
 builtin/revert.c                  |  6 ++++++
 builtin/sequencer.c               | 24 ++++++++++++++++++++++++
 builtin/sequencer.h               |  3 ++-
 t/t3510-cherry-pick-sequence.sh   | 12 ++++++++++++
 7 files changed, 49 insertions(+), 1 deletion(-)

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
diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index 0f50942..2b1b30a 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -961,6 +961,28 @@ static int sequencer_continue(struct replay_opts *opts)
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
+	return sequencer_continue(opts);
+}
+
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
@@ -991,6 +1013,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE)
 		return sequencer_continue(opts);
+	if (opts->subcommand == REPLAY_SKIP)
+		return sequencer_skip(opts);
 
 	for (i = 0; i < opts->revs->pending.nr; i++) {
 		unsigned char sha1[20];
diff --git a/builtin/sequencer.h b/builtin/sequencer.h
index e45411c..e69495a 100644
--- a/builtin/sequencer.h
+++ b/builtin/sequencer.h
@@ -15,7 +15,8 @@ enum replay_subcommand {
 	REPLAY_NONE,
 	REPLAY_REMOVE_STATE,
 	REPLAY_CONTINUE,
-	REPLAY_ROLLBACK
+	REPLAY_ROLLBACK,
+	REPLAY_SKIP
 };
 
 struct replay_opts {
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 33c5512..c43c327 100755
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
