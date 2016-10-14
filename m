Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF3D51F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755935AbcJNNTS (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:63844 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754295AbcJNNSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:16 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M8mCe-1c7AP01Kn6-00CD26; Fri, 14 Oct 2016 15:18:10
 +0200
Date:   Fri, 14 Oct 2016 15:18:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 11/25] sequencer: get rid of the subcommand field
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <131c4fa182879f1a20341f67cd0c82c7fe7be84b.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5uD2G64YT7uiursj42Cbru04Vl+NgA/HouK+msoSlqRMwMDqHBN
 +F5C6rwzkyD3g0VCu5k2oThPMs3lgK8vpgUoO0jw6l154/m9ses3x0NTqF553SMAdsV/Z3Y
 dW3OU0m1nMxhR26rPqkr9KVQTznMPgkGP+f1U+fVL32c8q8K6sxOAYTEMGXCRXGo1mCpHqZ
 7zMxjkIXx8uhLTZaVy4nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LcJy1rMzm9Y=:dmmVpLsHex93+g5x1T5nJE
 eih2sISOiWJ2tVy19bbSl3AJ5/kJF/do8R1LJMMp3JU9Y4jvHKGyJLPZ3m7ngboRH7Pu4ZCn9
 IhBVffH1ATwtvCtNo9v2eBPUN/XNPVgCcvriYVsZe/uQqD5nF0FL8r724/l4mb4IGcZgn+CUD
 9Tl2xfvvrmcuFqWNhF7b8boL/EBpZZX4pUKk+ncafLdjpiUTriAkfx/DFI/Zo3Cy4t/CVS5w0
 MhcXMOnTd9HkhfP2U52KSgjrOnyKqqn0qYzVIDe7W1bF0VA9gPI1vwxZI9A7RpniynjtZA13o
 oqU9O/I6k3MnA0g0F066RZXyqXScSeOeeB2vvtf5oMF6+xw8ArVTH6rji+yWApOX9nn4iUHKB
 f9EYefTivzCpU267HChB/bVatIVuH8kE/XDZux42Gvei+36+LQbeUeb1qenrUF+vt2FshBDVT
 CyOL+F1CiU0RZ8tsgttHOQQWRWDx78W1uPedFFbAfdyRHHbx//N+SvqwYy8k0kXKkNzWDH/je
 hKyor9pXdmqyQj2ROhz/IMqRu/tbg0AtYK5HJd8lGyrvm6XiBR3VZUHnnAFS30pej4wHJ4svI
 VnTXyIBvGNuOopUYQM1W/UVTWoAZNzO5eNiPe7DaJdHJkOjFBP3BcwHev4/zCOYGN34NvRLI1
 EUvDUghNyxWdsa0VYk7HCgrYjnZlv3KpBbt6PurKEzRmJ7RQgAUlvRg2JegwpqU5rwF23dZ9Q
 vSJ/AhfMabVaKMOJoNIxpxGH/nSHI+uSbgpQMKMZ8bdiVmeXr2c5P8xQWVScbQk13afW84sx2
 elrLtlkq1UUuja8CWE2jdrYLkvFRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The subcommands are used exactly once, at the very beginning of
sequencer_pick_revisions(), to determine what to do. This is an
unnecessary level of indirection: we can simply call the correct
function to begin with. So let's do that.

While at it, ensure that the subcommands return an error code so that
they do not have to die() all over the place (bad practice for library
functions...).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/revert.c | 36 ++++++++++++++++--------------------
 sequencer.c      | 35 +++++++++++------------------------
 sequencer.h      | 13 ++++---------
 3 files changed, 31 insertions(+), 53 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ba5a88c..4ca5b51 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -71,7 +71,7 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 		die(_("%s: %s cannot be used with %s"), me, this_opt, base_opt);
 }
 
-static void parse_args(int argc, const char **argv, struct replay_opts *opts)
+static int run_sequencer(int argc, const char **argv, struct replay_opts *opts)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage(opts);
 	const char *me = action_name(opts);
@@ -115,25 +115,15 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	if (opts->keep_redundant_commits)
 		opts->allow_empty = 1;
 
-	/* Set the subcommand */
-	if (cmd == 'q')
-		opts->subcommand = REPLAY_REMOVE_STATE;
-	else if (cmd == 'c')
-		opts->subcommand = REPLAY_CONTINUE;
-	else if (cmd == 'a')
-		opts->subcommand = REPLAY_ROLLBACK;
-	else
-		opts->subcommand = REPLAY_NONE;
-
 	/* Check for incompatible command line arguments */
-	if (opts->subcommand != REPLAY_NONE) {
+	if (cmd) {
 		char *this_operation;
-		if (opts->subcommand == REPLAY_REMOVE_STATE)
+		if (cmd == 'q')
 			this_operation = "--quit";
-		else if (opts->subcommand == REPLAY_CONTINUE)
+		else if (cmd == 'c')
 			this_operation = "--continue";
 		else {
-			assert(opts->subcommand == REPLAY_ROLLBACK);
+			assert(cmd == 'a');
 			this_operation = "--abort";
 		}
 
@@ -156,7 +146,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 				"--edit", opts->edit,
 				NULL);
 
-	if (opts->subcommand != REPLAY_NONE) {
+	if (cmd) {
 		opts->revs = NULL;
 	} else {
 		struct setup_revision_opt s_r_opt;
@@ -178,6 +168,14 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 	/* These option values will be free()d */
 	opts->gpg_sign = xstrdup_or_null(opts->gpg_sign);
 	opts->strategy = xstrdup_or_null(opts->strategy);
+
+	if (cmd == 'q')
+		return sequencer_remove_state(opts);
+	if (cmd == 'c')
+		return sequencer_continue(opts);
+	if (cmd == 'a')
+		return sequencer_rollback(opts);
+	return sequencer_pick_revisions(opts);
 }
 
 int cmd_revert(int argc, const char **argv, const char *prefix)
@@ -189,8 +187,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
-	parse_args(argc, argv, &opts);
-	res = sequencer_pick_revisions(&opts);
+	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
 	return res;
@@ -203,8 +200,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
-	parse_args(argc, argv, &opts);
-	res = sequencer_pick_revisions(&opts);
+	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
diff --git a/sequencer.c b/sequencer.c
index 9bca056..5e4bf23 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -119,7 +119,7 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
-static void remove_sequencer_state(const struct replay_opts *opts)
+int sequencer_remove_state(struct replay_opts *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
 	int i;
@@ -133,6 +133,8 @@ static void remove_sequencer_state(const struct replay_opts *opts)
 	strbuf_addf(&dir, "%s", get_dir(opts));
 	remove_dir_recursively(&dir, 0);
 	strbuf_release(&dir);
+
+	return 0;
 }
 
 static const char *action_name(const struct replay_opts *opts)
@@ -975,7 +977,7 @@ static int rollback_single_pick(void)
 	return reset_for_rollback(head_sha1);
 }
 
-static int sequencer_rollback(struct replay_opts *opts)
+int sequencer_rollback(struct replay_opts *opts)
 {
 	FILE *f;
 	unsigned char sha1[20];
@@ -1010,9 +1012,8 @@ static int sequencer_rollback(struct replay_opts *opts)
 	}
 	if (reset_for_rollback(sha1))
 		goto fail;
-	remove_sequencer_state(opts);
 	strbuf_release(&buf);
-	return 0;
+	return sequencer_remove_state(opts);
 fail:
 	strbuf_release(&buf);
 	return -1;
@@ -1097,8 +1098,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	remove_sequencer_state(opts);
-	return 0;
+	return sequencer_remove_state(opts);
 }
 
 static int continue_single_pick(void)
@@ -1111,11 +1111,14 @@ static int continue_single_pick(void)
 	return run_command_v_opt(argv, RUN_GIT_CMD);
 }
 
-static int sequencer_continue(struct replay_opts *opts)
+int sequencer_continue(struct replay_opts *opts)
 {
 	struct todo_list todo_list = TODO_LIST_INIT;
 	int res;
 
+	if (read_and_refresh_cache(opts))
+		return -1;
+
 	if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts))
@@ -1154,26 +1157,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	unsigned char sha1[20];
 	int i, res;
 
-	if (opts->subcommand == REPLAY_NONE)
-		assert(opts->revs);
-
+	assert(opts->revs);
 	if (read_and_refresh_cache(opts))
 		return -1;
 
-	/*
-	 * Decide what to do depending on the arguments; a fresh
-	 * cherry-pick should be handled differently from an existing
-	 * one that is being continued
-	 */
-	if (opts->subcommand == REPLAY_REMOVE_STATE) {
-		remove_sequencer_state(opts);
-		return 0;
-	}
-	if (opts->subcommand == REPLAY_ROLLBACK)
-		return sequencer_rollback(opts);
-	if (opts->subcommand == REPLAY_CONTINUE)
-		return sequencer_continue(opts);
-
 	for (i = 0; i < opts->revs->pending.nr; i++) {
 		unsigned char sha1[20];
 		const char *name = opts->revs->pending.objects[i].name;
diff --git a/sequencer.h b/sequencer.h
index 8453669..7a513c5 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -10,16 +10,8 @@ enum replay_action {
 	REPLAY_PICK
 };
 
-enum replay_subcommand {
-	REPLAY_NONE,
-	REPLAY_REMOVE_STATE,
-	REPLAY_CONTINUE,
-	REPLAY_ROLLBACK
-};
-
 struct replay_opts {
 	enum replay_action action;
-	enum replay_subcommand subcommand;
 
 	/* Boolean options */
 	int edit;
@@ -44,9 +36,12 @@ struct replay_opts {
 	/* Only used by REPLAY_NONE */
 	struct rev_info *revs;
 };
-#define REPLAY_OPTS_INIT { -1, -1 }
+#define REPLAY_OPTS_INIT { -1 }
 
 int sequencer_pick_revisions(struct replay_opts *opts);
+int sequencer_continue(struct replay_opts *opts);
+int sequencer_rollback(struct replay_opts *opts);
+int sequencer_remove_state(struct replay_opts *opts);
 
 extern const char sign_off_header[];
 
-- 
2.10.1.513.g00ef6dd


