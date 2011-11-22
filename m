From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] revert: rename --reset option to --quit
Date: Tue, 22 Nov 2011 05:14:29 -0600
Message-ID: <20111122111429.GB7399@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:14:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSoJA-0001QZ-Qj
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab1KVLOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 06:14:35 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51698 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab1KVLOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 06:14:33 -0500
Received: by ggnr5 with SMTP id r5so70068ggn.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 03:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Z5Z2ytFje1l1Shw4kvYtoBrRo3gehhPRswrKFvwv//w=;
        b=dozWO1dpHnbXQflpjwzfHug3DkBFLBJoHw+gErDGIJ/KeiKnxUhYVxudoIlGv5PoM9
         sCsB19Fsdba+CXO0/N/QMO23jKysPqsMcewOjRsh+Qxy07JDywohXaLaqASiJnZupLSB
         ffc5GwnpkFBaRyBLe0ECYosp0v4qs3JkMWnWs=
Received: by 10.50.216.134 with SMTP id oq6mr21635474igc.11.1321960473022;
        Tue, 22 Nov 2011 03:14:33 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id bu33sm58697764ibb.11.2011.11.22.03.14.31
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 03:14:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111122111207.GA7399@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185782>

The option to "git cherry-pick" and "git revert" to discard the
sequencer state introduced by v1.7.8-rc0~141^2~6 (revert: Introduce
--reset to remove sequencer state, 2011-08-04) has a confusing name.
Change it now, while we still have the time.

The new name for "cherry-pick, please get out of my way, since I've
long forgotten about the sequence of commits I was cherry-picking when
you wrote that old .git/sequencer directory" is --quit.  Mnemonic:
this is analagous to quiting a program the user is no longer using ---
we just want to get out of the multiple-command cherry-pick procedure
and not to reset HEAD or rewind any other old state.

The "--reset" option is kept as a synonym to minimize the impact.  We
might consider dropping it for simplicity in a separate patch, though.

Adjust documentation and tests to use the newly preferred name (--quit)
instead of --reset.  While at it, let's clarify the short descriptions
of these operations in "-h" output.

Before:

	--reset		forget the current operation
	--continue	continue the current operation

After:

	--quit		end revert or cherry-pick sequence
	--continue	resume revert or cherry-pick sequence

Noticed-by: Phil Hord <phil.hord@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-cherry-pick.txt |    2 +-
 Documentation/git-revert.txt      |    2 +-
 Documentation/sequencer.txt       |   10 +++++-----
 builtin/revert.c                  |   25 ++++++++++++++-----------
 sequencer.h                       |    2 +-
 t/t3510-cherry-pick-sequence.sh   |   31 ++++++++++++++++++++++++++-----
 t/t7106-reset-sequence.sh         |    2 +-
 7 files changed, 49 insertions(+), 25 deletions(-)

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
index 544e8c30..e109fb11 100644
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
@@ -147,6 +147,9 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_STRING(0, "strategy", &opts->strategy, "strategy", "merge strategy"),
 		OPT_CALLBACK('X', "strategy-option", &opts, "option",
 			"option for merge strategy", option_parse_x),
+		{ OPTION_BOOLEAN, 0, "reset", &remove_state, NULL,
+			"alias for --quit (deprecated)",
+			PARSE_OPT_HIDDEN | PARSE_OPT_NOARG },
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
@@ -168,13 +171,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
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
@@ -183,8 +186,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	/* Check for incompatible command line arguments */
 	if (opts->subcommand != REPLAY_NONE) {
 		char *this_operation;
-		if (opts->subcommand == REPLAY_RESET)
-			this_operation = "--reset";
+		if (opts->subcommand == REPLAY_REMOVE_STATE)
+			this_operation = "--quit";
 		else
 			this_operation = "--continue";
 
@@ -965,7 +968,7 @@ static int pick_revisions(struct replay_opts *opts)
 	 * cherry-pick should be handled differently from an existing
 	 * one that is being continued
 	 */
-	if (opts->subcommand == REPLAY_RESET) {
+	if (opts->subcommand == REPLAY_REMOVE_STATE) {
 		remove_sequencer_state(1);
 		return 0;
 	} else if (opts->subcommand == REPLAY_CONTINUE) {
@@ -988,7 +991,7 @@ static int pick_revisions(struct replay_opts *opts)
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
index 3bca2b3d..bb67cdcb 100755
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
@@ -70,18 +70,39 @@ test_expect_success 'cherry-pick cleans up sequencer state upon success' '
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
 
+test_expect_success 'cherry-pick --reset (another name for --quit)' '
+	pristine_detach initial &&
+	cat >expect <<-\EOF &&
+	OBJID
+	:100644 100644 OBJID OBJID M	unrelated
+	OBJID
+	:000000 100644 OBJID OBJID A	foo
+	:000000 100644 OBJID OBJID A	unrelated
+	EOF
+	test_must_fail git cherry-pick base..picked &&
+	git cherry-pick --reset &&
+	test_path_is_missing .git/sequencer &&
+	test_must_fail git update-index --refresh &&
+	{
+		git rev-list HEAD |
+		git diff-tree --root --stdin |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick cleans up sequencer state when one commit is left' '
 	pristine_detach initial &&
 	test_must_fail git cherry-pick base..picked &&
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
