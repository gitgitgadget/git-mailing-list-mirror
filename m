From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] revert/cherry-pick: add --skip option
Date: Tue, 28 May 2013 07:59:07 -0500
Message-ID: <1369745947-19416-4-git-send-email-felipe.contreras@gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 28 15:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJWn-00060n-GS
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 15:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933990Ab3E1NBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 09:01:00 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:51419 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933906Ab3E1NA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 09:00:58 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so8834097obc.40
        for <git@vger.kernel.org>; Tue, 28 May 2013 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IaX3N1ikgV9sz+MrFDlej0qXNZewnmuEW+WZprxVTwE=;
        b=hraVARxDV/UpOA5I0L8udaVX6xCDKRIJoMULpcwSU3w+35InlIJOWIz+lWnAhHTeO0
         cEKYJKuUmFX3uYLqARGA5lNHKu2IxOhjeBjatsHiYe2TGB/yCaBPG6O7hudVyoebhj6u
         cB/xXj787ewzTfTPOjQgAuT97N0L1XoDRkx9cg6mRetC3e+ar/KCD+JVhWtmD1rYFz2u
         PgWBXkXCXU94Y/f0T5erZnfjMOVaeFcVPclfDGnWcL83aAiW4hUG03sr7+gzkQFGk9yd
         1Cg7dWrWNgH+scQtfAAxja0VhWKnTwHzR51ubNyOAGBZavveO2v7W0KbChku2p+imgZz
         C9YA==
X-Received: by 10.182.138.4 with SMTP id qm4mr20973391obb.101.1369746058234;
        Tue, 28 May 2013 06:00:58 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id zn5sm34477887obc.10.2013.05.28.06.00.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 06:00:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225643>

Akin to 'am --skip' and 'rebase --skip'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt |  1 +
 Documentation/git-revert.txt      |  1 +
 Documentation/sequencer.txt       |  3 +++
 builtin/revert.c                  |  6 ++++++
 sequencer.c                       | 24 ++++++++++++++++++++++++
 sequencer.h                       |  3 ++-
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
index d63b4a6..6afd990 100644
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
@@ -160,6 +162,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->subcommand = REPLAY_CONTINUE;
 	else if (rollback)
 		opts->subcommand = REPLAY_ROLLBACK;
+	else if (skip)
+		opts->subcommand = REPLAY_SKIP;
 	else
 		opts->subcommand = REPLAY_NONE;
 
@@ -170,6 +174,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			this_operation = "--quit";
 		else if (opts->subcommand == REPLAY_CONTINUE)
 			this_operation = "--continue";
+		else if (opts->subcommand == REPLAY_SKIP)
+			this_operation = "--skip";
 		else {
 			assert(opts->subcommand == REPLAY_ROLLBACK);
 			this_operation = "--abort";
diff --git a/sequencer.c b/sequencer.c
index b4e395a..971cab2 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1173,6 +1173,28 @@ static int sequencer_continue(struct replay_opts *opts)
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
 	int ret;
@@ -1209,6 +1231,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return sequencer_rollback(opts);
 	if (opts->subcommand == REPLAY_CONTINUE)
 		return sequencer_continue(opts);
+	if (opts->subcommand == REPLAY_SKIP)
+		return sequencer_skip(opts);
 
 	for (i = 0; i < opts->revs->pending.nr; i++) {
 		unsigned char sha1[20];
diff --git a/sequencer.h b/sequencer.h
index 41e19d0..b9e09ac 100644
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
1.8.3.rc3.312.g47657de
