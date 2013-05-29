From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 8/8] revert/cherry-pick: add --skip option
Date: Tue, 28 May 2013 22:56:28 -0500
Message-ID: <1369799788-24803-9-git-send-email-felipe.contreras@gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXX5-00035O-0D
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935004Ab3E2D6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:35 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:58054 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934944Ab3E2D6c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:32 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so768953obc.12
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=upI/mmoWUbKI3rLkzZ88vsZrwOwGIFVjHEuz8qwdptg=;
        b=ANtCLcW1VIGsWls1nNB7WouEyWXTreW5kwVbo2j+juH+vEUNueZM68zXVhwCIzmblt
         kOMnA3Fp6FevoTSxrP6tjqGW6RJ+NSrbAL32YFYPK8urFbAfs1gdq4fltwKDbSwX1abf
         NSsaZ/w1WylZGaz12JyoJWCLCkA72UneEgoldec5xdFPDwFfXQEl11SYScUjdr2naUNS
         KWIXhKYzsvlPsFm9Hb+Oh5ojfcqGxz/VQplzOmPQ5RWX5RFwCDuBXclKOObtOIa9BPgy
         BphAFJN3BANfY4/+2CkiaFqB0Vro5bt/visxYtWbYy55IU+9ero2Y0xgTUexHnS8Etsn
         ybIg==
X-Received: by 10.60.84.35 with SMTP id v3mr505095oey.36.1369799911958;
        Tue, 28 May 2013 20:58:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm8633728obz.11.2013.05.28.20.58.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225722>

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
index b7391d6..46bbe29 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1182,7 +1182,9 @@ static int continue_single_pick(void)
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
-	{
+	if (!skip) {
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
@@ -1246,7 +1270,9 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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
