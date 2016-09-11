Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C2F207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755846AbcIKKyG (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:54:06 -0400
Received: from mout.gmx.net ([212.227.17.20]:55336 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755479AbcIKKyF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:54:05 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MOjMY-1be43b1Z2M-0067eg; Sun, 11 Sep 2016 12:54:01
 +0200
Date:   Sun, 11 Sep 2016 12:53:59 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 10/25] sequencer: get rid of the subcommand field
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <955727a7cf5bd64f1c1106b394095d5449a4a2dc.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7ekRZ+nPUJUP2qrftyivQS0w1p1DAM9mW6KuND8DEKhuuiMRRBm
 UKJhaKfFzmSMgY8caKDq4yhb6xmmlwhSglT/CvzXzlTpHHj4B1QLo5v1Q8BK0k03Lr9nJkZ
 LNBoW+raAJLyt+TomOncNhR56FKqFvkF/moBoxfO39drk9FkvXa2ytWR1sUKMR2jVkQy53x
 z13LmKdr4HZy11FKPOqEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sGvrj/sC9VU=:/rae/GbzcAcp45jjEBkOWN
 28dTE6VxM/pkhc15N+iAqUkg0lEDe4/q6VkKvvgsj9IAyQjzfjxxHVGAQO/ItMvOBkVAZiMrb
 5Cctv2xLhI0RkejZZqZRb12E52cYyxOhbJXFyN3VTLPnRIAbk5iPrXbUL9oVVimVLmMl6t8Qi
 XhUqtnIurhC9vruvSQR0yaO3O0tryBwz0lYmdLNkihrfGCwERKskVwfyIPYAOGQl95Cb9sb6g
 n5mtwFvsZQ+AMicDd2UCtQxwY8+RbY0NUolOSCP6mMH+50qgrePSVWp6TwgzpHhWe4Oqu3Pe0
 4IrG+2lpYCZrgimU5zLTryR88SVpZ1GWsmkyXmmwBoiv8PN4blYyaKgkWdrXHdoAm4XrN8jHq
 giRvbzBaJyx7uiKqjvi+/KQPjts7eCWS6kKijQXOYLb5JND5ID683dY387tI/rSEtl1KjwDos
 04hA6diYLBO6GeMu2I+wPQsONyIM2ohENWwoqTLCogQh/rN/Vvry4UNPSMo0OnEExhh/2NmPC
 hctFjw9+L/yzD5+oy3tIZKHlY+qCPtwfLNlx4SKhL7cuVixpWsY0DfnEaFFTEGyWlfj8nl/sa
 r4AyHWIJERI2Fx7kvPLucQaortm1vw4HLsbviUjRcVHPdD/HHxDSS/9T9lz8/bToayWIwytA8
 2F02eHMoOtseeTbCaOF82HjUm5Gy6QTtvRFG8rWgp/fWyi4cMl8PzacQwkm3SXKWQLJevg7Vl
 o+agvJBW/RtmKU7/x31xVNy8D8A8FUKoAigJTjH1O85w5FREgXFRN2XwBv+Q51fwdVMFsZYMn
 nmHsv/v
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
index 7365559..c9ae4dc 100644
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
@@ -174,6 +164,14 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
 	if (argc > 1)
 		usage_with_options(usage_str, options);
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
@@ -185,8 +183,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 		opts.edit = 1;
 	opts.action = REPLAY_REVERT;
 	git_config(git_default_config, NULL);
-	parse_args(argc, argv, &opts);
-	res = sequencer_pick_revisions(&opts);
+	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("revert failed"));
 	return res;
@@ -199,8 +196,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 
 	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
-	parse_args(argc, argv, &opts);
-	res = sequencer_pick_revisions(&opts);
+	res = run_sequencer(argc, argv, &opts);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
diff --git a/sequencer.c b/sequencer.c
index 7ba932b..053e78c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -127,7 +127,7 @@ void *sequencer_entrust(struct replay_opts *opts, void *to_free)
 	return to_free;
 }
 
-static void remove_sequencer_state(const struct replay_opts *opts)
+int sequencer_remove_state(struct replay_opts *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
 	int i;
@@ -141,6 +141,8 @@ static void remove_sequencer_state(const struct replay_opts *opts)
 	strbuf_addf(&dir, "%s", get_dir(opts));
 	remove_dir_recursively(&dir, 0);
 	strbuf_release(&dir);
+
+	return 0;
 }
 
 static const char *action_name(const struct replay_opts *opts)
@@ -971,7 +973,7 @@ static int rollback_single_pick(void)
 	return reset_for_rollback(head_sha1);
 }
 
-static int sequencer_rollback(struct replay_opts *opts)
+int sequencer_rollback(struct replay_opts *opts)
 {
 	FILE *f;
 	unsigned char sha1[20];
@@ -1006,9 +1008,8 @@ static int sequencer_rollback(struct replay_opts *opts)
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
@@ -1093,8 +1094,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
-	remove_sequencer_state(opts);
-	return 0;
+	return sequencer_remove_state(opts);
 }
 
 static int continue_single_pick(void)
@@ -1107,11 +1107,14 @@ static int continue_single_pick(void)
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
@@ -1150,26 +1153,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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
index 04892a9..0b3950d 100644
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
@@ -48,7 +40,7 @@ struct replay_opts {
 	void **owned;
 	int owned_nr, owned_alloc;
 };
-#define REPLAY_OPTS_INIT { -1, -1 }
+#define REPLAY_OPTS_INIT { -1 }
 
 /*
  * Make it the duty of sequencer_remove_state() to release the memory;
@@ -57,6 +49,9 @@ struct replay_opts {
 void *sequencer_entrust(struct replay_opts *opts, void *to_free);
 
 int sequencer_pick_revisions(struct replay_opts *opts);
+int sequencer_continue(struct replay_opts *opts);
+int sequencer_rollback(struct replay_opts *opts);
+int sequencer_remove_state(struct replay_opts *opts);
 
 extern const char sign_off_header[];
 
-- 
2.10.0.windows.1.10.g803177d


