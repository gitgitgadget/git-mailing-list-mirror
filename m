Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8132D20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755468AbcJUMZD (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:63496 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755451AbcJUMZC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:02 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M8leW-1c5I7Y2otY-00C9nT; Fri, 21 Oct 2016 14:24:56
 +0200
Date:   Fri, 21 Oct 2016 14:24:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 11/27] sequencer: get rid of the subcommand field
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <b83fef6d57a766f2d27f86efb8ce1f088ab51ebe.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iRkiRqmqviANTPX+JHI31QlnT0pHrKF5YbSMc4cXrlO0KtZ8nHu
 ljocTjDcbBX9e4NXeYme79NC6tW7wODnV6ZNTGcx/LpJXucidXCxOUvvKKufDtbGmHcYace
 fKgg3lVu89fppLESyCTecwjDMuVE+jFRNYjlg+N9SC+9fHttw5UDWKTHE2e4AFxSYEFoIpj
 pn8OQqfYv0eUqj6ScgXJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1DNeqSVh7wY=:a8wbZIsmzU7NZ/lixA62Q+
 jw2g4OJNLksLjA0rXotbJYiKYkoo1YEEJuFfuZv8KAX6jVDx98wPkhLoa6zq3iLuwTYdvJme3
 4DqYDkP2OdoZ0hTWzKReDnxd+qhV1GkMML54RgnUEvpkUH/rAhr8dXVAwaSFEn0JbWtaQXncO
 kI+KiKvcXYY+K1byWiLSiRciOxuvQGtGrKz6NlWMKAPakC3LBzqYa/R2GvYoAJa5VMtrxhvH3
 TU7TWHeEJFc3adAztY2LShqIkc7VP09q676tYuzET6L92d0ZYD5r8kxEPhrnb33R22W1Rhn6r
 MQMrzWkSiBJRBoJw4dlUe6oyaCVjM5rdbda53Y/w+M452XSa04G/D+hyobpPwFLNhUeT9zCvy
 p3mObCiazyi73MWGp14WHlhMns6sq4cyoUWSUSJ9VltdrYN5Zv7yWgF0kKNI42g/JkwQIWXZx
 GqECRKuzzYhrXLQ9WzKmr57iWM9pe2i8ezwRuDXVToYP8OSBqRhZqXTGeI8bi+7nuXSz+VX5a
 OgJ0kz0e//Lfy6CKIN+uzJrxDwHyJGO5GkkqAxS2zZBOYELnfW+sf0UtM/F7SzlgQwgtVzf7W
 dDLduWNwwKN6XdhDcm+8BK3xOphCPSwNocHSE7nCPHDEeu2SUoUHLfdhwn8963lER990wBbvm
 EwHWrESBXM8Tphx8RhPmfbVTQYv+7o8xq8rcyu1QEHmgT8B5SXdmUrUDeg8tANOyeF32eSDk1
 2mvWtUYnFE+9U64OBIhxZjOofjgAzl8wP3qsBIO4q1zlG1UNy3I51aaZuP6JDguWtGRzV6Jae
 MgJ8vRE
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
index 120a8ee..9f22c5e 100644
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
2.10.1.583.g721a9e0


