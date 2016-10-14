Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE13209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbcJNNTG (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:56271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755912AbcJNNS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:29 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MBIAz-1c5FWd3zkb-00ACAD; Fri, 14 Oct 2016 15:18:23
 +0200
Date:   Fri, 14 Oct 2016 15:18:22 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 15/25] sequencer: allow editing the commit message on a
 case-by-case basis
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <344d5d872f32e796d39eb515ff034cfe704eea5a.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:c+PA7/BFhIHonctd6KHy9T7QN/DC3IFGX2H/cZWyCU+8C2g/7YM
 2k5mwVTSWvCcIdvM6ETGCWViVlF+uERoJRvECLCvj73JEg++geKj2vyu1/c53bVdlYxuvw7
 5TF21wddbBfRzrNadHE1akwizYryXLxN7zXH0SNveK43Q1mS3qPQwvOnP0R7UsJGMc7AFXl
 emCAXGCgRsIJTyQBipyIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JxI8OkBR7v8=:Z0HotJXXKGazVj8rycAFwL
 yAXlocjz+2wPnHcrODkjqkDKGEJ6EAjEdVcZM5G1BmJTOkDgIJszQPNY7hOSWkdbcU/FrrBE2
 46WUFmlxZKTlFeDkeKNoTPN5mg7WMskYfBJYrA4aCjaQ+2F4FMB6TVfIRPTHDarAH/U2xWWUG
 Gg3ftqX2ELlWD//qxPMVk5sgBmRNCCuweJT85EhAhePzQmJ7p+LWyl8M8tn63f03xFxIUMzIA
 sljsHaGB7TiMkuGHG5f/fMpyKRypqu/ca7xVO+ckAdh7936Zewznnfko6T0cjm2+Mfnsen/6N
 ztyytd6sXXOdGS6RFIm9g7stUYm2oHF/paqJylD1k2h/XOqNA+hxsPwxgdtem7rdpk2qVTWff
 lyPTWQiDbElMfycMk4ibAJa/1bmwby9BeBBMahr8y9bFGGeHiuqDAh8Dvpr/xb0PzwguYKRk2
 HQdJstd/cqcmPLpAjabHm5HNBfwsLuGMQM/JpCarznPaY5eqMsO9C/7mtJRlGbWlkkyUONs9h
 YAlFHGqdZGzFfh/zFbW/vB6A6GEWcA3Nd6i33yendaJSneU+qG3J4j5HJcEzIX/lY3mSDEwoB
 eSRMqKcaIaHCEDnqPzeOKP/EWpVQru9YSQf522O89CK13H/esl+8nyR1RsFOSNZHe01Dt9uMB
 wb0/KbPdkUNaWuLVgk1E82hIHkI3tKWlorPWeI+r/YfK/+8XKnZPKWz7NfrHcrcBfLDu+3q1D
 ZDOyxn5GxKgoLEU5qwxHLuUn7SJ4XB5uxjfJlAbLiLnfzuACrWe/I6UgFIHsqLczItxuiAPda
 htgPade
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming commits, we will implement more and more of rebase -i's
functionality inside the sequencer. One particular feature of the
commands to come is that some of them allow editing the commit message
while others don't, i.e. we cannot define in the replay_opts whether the
commit message should be edited or not.

Let's add a new parameter to the run_git_commit() function. Previously,
it was the duty of the caller to ensure that the opts->edit setting
indicates whether to let the user edit the commit message or not,
indicating that it is an "all or nothing" setting, i.e. that the
sequencer wants to let the user edit *all* commit message, or none at
all. In the upcoming rebase -i mode, it will depend on the particular
command that is currently executed, though.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index de6b95f..2ef80e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -15,6 +15,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "quote.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -33,6 +34,11 @@ static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
  * being rebased.
  */
 static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
+/*
+ * The following files are written by git-rebase just after parsing the
+ * command-line (and are only consumed, not modified, by the sequencer).
+ */
+static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
@@ -132,6 +138,16 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
+static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
+{
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	if (opts->gpg_sign)
+		sq_quotef(&buf, "-S%s", opts->gpg_sign);
+	return buf.buf;
+}
+
 int sequencer_remove_state(struct replay_opts *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
@@ -465,7 +481,7 @@ static char **read_author_script(void)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty)
+			  int allow_empty, int edit)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -474,17 +490,20 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
 	if (is_rebase_i(opts)) {
 		env = read_author_script();
-		if (!env)
+		if (!env) {
+			const char *gpg_opt = gpg_sign_opt_quoted(opts);
+
 			return error("You have staged changes in your working "
 				"tree. If these changes are meant to be\n"
 				"squashed into the previous commit, run:\n\n"
-				"  git commit --amend $gpg_sign_opt_quoted\n\n"
+				"  git commit --amend %s\n\n"
 				"If they are meant to go into a new commit, "
 				"run:\n\n"
-				"  git commit $gpg_sign_opt_quoted\n\n"
+				"  git commit %s\n\n"
 				"In both cases, once you're done, continue "
 				"with:\n\n"
-				"  git rebase --continue\n");
+				"  git rebase --continue\n", gpg_opt, gpg_opt);
+		}
 	}
 
 	argv_array_init(&array);
@@ -497,7 +516,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "-s");
 	if (defmsg)
 		argv_array_pushl(&array, "-F", defmsg, NULL);
-	if (opts->edit)
+	if (edit)
 		argv_array_push(&array, "-e");
 	else if (!opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
@@ -764,7 +783,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow);
+				     opts, allow, opts->edit);
 
 leave:
 	free_message(commit, &msg);
@@ -986,8 +1005,21 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
-	if (is_rebase_i(opts))
+	if (is_rebase_i(opts)) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+			if (!starts_with(buf.buf, "-S"))
+				strbuf_reset(&buf);
+			else {
+				free(opts->gpg_sign);
+				opts->gpg_sign = xstrdup(buf.buf + 2);
+			}
+		}
+		strbuf_release(&buf);
+
 		return 0;
+	}
 
 	if (!file_exists(git_path_opts_file()))
 		return 0;
-- 
2.10.1.513.g00ef6dd


