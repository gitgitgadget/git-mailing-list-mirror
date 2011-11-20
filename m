From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] revert: rename --reset option to --quit
Date: Sun, 20 Nov 2011 03:48:24 -0600
Message-ID: <20111120094824.GC2278@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 10:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS40v-00061p-VX
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 10:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab1KTJsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 04:48:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55606 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162Ab1KTJsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 04:48:35 -0500
Received: by iage36 with SMTP id e36so5854367iag.19
        for <git@vger.kernel.org>; Sun, 20 Nov 2011 01:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZRnHHyOhn04ILToZNtXOxzqQRHZ4lTBZtQZ4NIzf+P0=;
        b=bGY7FoG7hhs0QvqGye5xc2Zp59qM5XcA7bFIDgwEC1gASzsy2GYu0vuoQAR0xMbest
         eKtE5upLlSQDHE/kEeiJQLJjU61HZz7A+1qmRa4vAHip4YBbCAne8F1YReRbcSoeL2C9
         uTQXMmUNhyZ81cu1JH6oH/qx2uQOzGxD4BbEQ=
Received: by 10.50.216.137 with SMTP id oq9mr10093408igc.40.1321782515148;
        Sun, 20 Nov 2011 01:48:35 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id el2sm29608140ibb.10.2011.11.20.01.48.34
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Nov 2011 01:48:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111120094650.GB2278@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185721>

The option to "git cherry-pick" and "git revert" to discard the
sequencer state introduced by v1.7.8-rc0~141^2~6 (revert: Introduce
--reset to remove sequencer state, 2011-08-04) has a confusing name.
Change it now, while we still have the time.

Mechanics:

This commit removes the "git cherry-pick --reset" option.  Hopefully
nobody was using it.  If somebody was, we can add it back again as a
synonym.

The new name for "cherry-pick, please get out of my way, since I've
long forgotten about the sequence of commits I was cherry-picking when
you wrote that old .git/sequencer directory" is --quit.  Mnemonic:
this is analagous to quiting a program the user is no longer using ---
we just want to get out of the multiple-command cherry-pick procedure
and not to reset HEAD or restore any other old state.

Adjust documentation and tests to match.  While at it, let's clarify
the short descriptions of these operations in "-h" output.

Before:

	--reset		forget the current operation
	--continue	continue the current operation

After:

	--quit		end revert or cherry-pick sequence
	--continue	resume revert or cherry-pick sequence

Noticed-by: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-cherry-pick.txt |    2 +-
 Documentation/git-revert.txt      |    2 +-
 Documentation/sequencer.txt       |   10 +++++-----
 builtin/revert.c                  |   22 +++++++++++-----------
 sequencer.h                       |    2 +-
 t/t3510-cherry-pick-sequence.sh   |   10 +++++-----
 t/t7106-reset-sequence.sh         |    2 +-
 7 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 2660a842..21998b82 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff] <commit>...
-'git cherry-pick' --reset
 'git cherry-pick' --continue
+'git cherry-pick' --quit
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index f3519413..b0fcabc8 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -9,8 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <commit>...
-'git revert' --reset
 'git revert' --continue
+'git revert' --quit
 
 DESCRIPTION
 -----------
diff --git a/Documentation/sequencer.txt b/Documentation/sequencer.txt
index 3e6df338..75f8e869 100644
--- a/Documentation/sequencer.txt
+++ b/Documentation/sequencer.txt
@@ -1,9 +1,9 @@
---reset::
-	Forget about the current operation in progress.  Can be used
-	to clear the sequencer state after a failed cherry-pick or
-	revert.
-
 --continue::
 	Continue the operation in progress using the information in
 	'.git/sequencer'.  Can be used to continue after resolving
 	conflicts in a failed cherry-pick or revert.
+
+--quit::
+	Forget about the current operation in progress.  Can be used
+	to clear the sequencer state after a failed cherry-pick or
+	revert.
diff --git a/builtin/revert.c b/builtin/revert.c
index 544e8c30..b59dd68c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -40,7 +40,7 @@ static const char * const cherry_pick_usage[] = {
 };
 
 enum replay_action { REVERT, CHERRY_PICK };
-enum replay_subcommand { REPLAY_NONE, REPLAY_RESET, REPLAY_CONTINUE };
+enum replay_subcommand { REPLAY_NONE, REPLAY_REMOVE_STATE, REPLAY_CONTINUE };
 
 struct replay_opts {
 	enum replay_action action;
@@ -133,11 +133,11 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
-	int reset = 0;
+	int remove_state = 0;
 	int contin = 0;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "reset", &reset, "forget the current operation"),
-		OPT_BOOLEAN(0, "continue", &contin, "continue the current operation"),
+		OPT_BOOLEAN(0, "quit", &remove_state, "end revert or cherry-pick sequence"),
+		OPT_BOOLEAN(0, "continue", &contin, "resume revert or cherry-pick sequence"),
 		OPT_BOOLEAN('n', "no-commit", &opts->no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &opts->edit, "edit the commit message"),
 		OPT_NOOP_NOARG('r', NULL),
@@ -168,13 +168,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
 	/* Check for incompatible subcommands */
 	verify_opt_mutually_compatible(me,
-				"--reset", reset,
+				"--quit", remove_state,
 				"--continue", contin,
 				NULL);
 
 	/* Set the subcommand */
-	if (reset)
-		opts->subcommand = REPLAY_RESET;
+	if (remove_state)
+		opts->subcommand = REPLAY_REMOVE_STATE;
 	else if (contin)
 		opts->subcommand = REPLAY_CONTINUE;
 	else
@@ -183,8 +183,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	/* Check for incompatible command line arguments */
 	if (opts->subcommand != REPLAY_NONE) {
 		char *this_operation;
-		if (opts->subcommand == REPLAY_RESET)
-			this_operation = "--reset";
+		if (opts->subcommand == REPLAY_REMOVE_STATE)
+			this_operation = "--quit";
 		else
 			this_operation = "--continue";
 
@@ -965,7 +965,7 @@ static int pick_revisions(struct replay_opts *opts)
 	 * cherry-pick should be handled differently from an existing
 	 * one that is being continued
 	 */
-	if (opts->subcommand == REPLAY_RESET) {
+	if (opts->subcommand == REPLAY_REMOVE_STATE) {
 		remove_sequencer_state(1);
 		return 0;
 	} else if (opts->subcommand == REPLAY_CONTINUE) {
@@ -988,7 +988,7 @@ static int pick_revisions(struct replay_opts *opts)
 		if (create_seq_dir() < 0) {
 			error(_("A cherry-pick or revert is in progress."));
 			advise(_("Use --continue to continue the operation"));
-			advise(_("or --reset to forget about it"));
+			advise(_("or --quit to forget about it"));
 			return -1;
 		}
 		if (get_sha1("HEAD", sha1)) {
diff --git a/sequencer.h b/sequencer.h
index 905d2950..f435fdb4 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -13,7 +13,7 @@
  *
  * With the aggressive flag, it additionally removes SEQ_OLD_DIR,
  * ignoring any errors.  Inteded to be used by the sequencer's
- * '--reset' subcommand.
+ * '--quit' subcommand.
  */
 void remove_sequencer_state(int aggressive);
 
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 3bca2b3d..913435e2 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -13,7 +13,7 @@ test_description='Test cherry-pick continuation features
 . ./test-lib.sh
 
 pristine_detach () {
-	git cherry-pick --reset &&
+	git cherry-pick --quit &&
 	git checkout -f "$1^0" &&
 	git read-tree -u --reset HEAD &&
 	git clean -d -f -f -q -x
@@ -70,15 +70,15 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
 	test_path_is_missing .git/sequencer
 '
 
-test_expect_success '--reset does not complain when no cherry-pick is in progress' '
+test_expect_success '--quit does not complain when no cherry-pick is in progress' '
 	pristine_detach initial &&
-	git cherry-pick --reset
+	git cherry-pick --quit
 '
 
-test_expect_success '--reset cleans up sequencer state' '
+test_expect_success '--quit cleans up sequencer state' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..picked &&
-	git cherry-pick --reset &&
+	git cherry-pick --quit &&
 	test_path_is_missing .git/sequencer
 '
 
diff --git a/t/t7106-reset-sequence.sh b/t/t7106-reset-sequence.sh
index 4956caaf..3f86e8c5 100755
--- a/t/t7106-reset-sequence.sh
+++ b/t/t7106-reset-sequence.sh
@@ -12,7 +12,7 @@ test_description='Test interaction of reset --hard with sequencer
 . ./test-lib.sh
 
 pristine_detach () {
-	git cherry-pick --reset &&
+	git cherry-pick --quit &&
 	git checkout -f "$1^0" &&
 	git read-tree -u --reset HEAD &&
 	git clean -d -f -f -q -x
-- 
1.7.8.rc3
