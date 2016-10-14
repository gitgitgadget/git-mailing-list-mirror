Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59E51F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbcJNNTM (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:50255 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755871AbcJNNSY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:24 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LrNE4-1cxl3N0mbs-01343I; Fri, 14 Oct 2016 15:18:17
 +0200
Date:   Fri, 14 Oct 2016 15:18:16 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 13/25] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <3ab64411bee7e90e9d4deb47d04709e416c17e9b.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:PoJ1+alaMpVikTiSqrKrA3rhPoMT4t84dZkBI7/QmHH6pI9HGCq
 wPsvVHUT9KDfWllIWI2ZbZ8Jo4ctbFPAtDwR5jpwLgdS6GW2sFv++3Jdb+j7sGpeoH5icSF
 rC0jratP4+fSHapXXIlWrCOiHTOp9Ny4pDZcXFAL0Mn8Uu5ckwncqlTnEGHQCbiQogrkdCk
 Y4wdbyxgxNDjrFDTdtOPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z57gOjcFKYw=:9J1oPsKrlTiYvRIm70/z5O
 PPKzPbLCgBDXvpNwVG2d6Tr2YFwK7TW7TPEAYpPu39fXk0rEi5sMN73m/TqXUHVARsL1cPT2g
 bRG8oU3fzQm8BkQ8P0IoLY4lzE67s7w5xDjho9pBPwUjLMtbXIgg6E+PRlsXCyUfVAz3Xch1J
 cziZBgFRcEk5YX4MmvjNM0efmQVLdTQYeNtfKrroCLzuW5w53n6tpMa94UhS6RvY6zCBf75Gn
 ZQAkkU9lMvoIV7sovRo7WszPyRXr7IYig32E09Sdjk6lucCQBt5Y3R6suSjBvYXiUAnDufT9A
 NnAypqjLRw/4Hr2j7cLK1wJlWPgJCWCv/frYVG9F9lGI/l08jJcgBbl9NhnPCK8tOkoxVHxhv
 XtHK+HLnSkFJkv2WRIghxF6e8ZJmqKsIukaRdNvFLw6iWyitcYY1QUhLSen7x1R1Xg4G+yE56
 IuRvQ1aRYLpqp29gDJn2iBcDmlq4nZRiK8Vn4NAz0BgGmPblBp6JOi07AYhTfZUQXsGiJbE80
 j+mDq37voJBiftHfY+e7pQPW/WqIkKbG7zjN2RD/UJmWeZSHbfiDflCho/p6hH2OW6s8Cv0ZN
 DSlmcQMzKjiO/u40Z9ec/utw930D4mjvgoVhEiP/vnzmU2nMVI5piyd7T95BnJSNVj/JbrDw9
 7HJe+Az47wZhTdetJ9yNQYR7aIFBJCpPB/hiSfKD2oXFN4xWd/l/yjfPVp/DxX3fSbl25YW4L
 +ISHZ1/O1g7qvVg888RwGweFMSA+mnJzWKQoFC8WkDMDBZ0mSbYXG43zAvxViIxNQ+p+xSq7E
 6NX4CQI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In interactive rebases, we commit a little bit differently than the
sequencer did so far: we heed the "author-script", the "message" and the
"amend" files in the .git/rebase-merge/ subdirectory.

Likewise, we may want to edit the commit message *even* when providing a
file containing the suggested commit message. Therefore we change the
code to not even provide a default message when we do not want any, and
to call the editor explicitly.

Also, in "interactive rebase" mode we want to skip reading the options
in the state directory of the cherry-pick/revert commands.

Finally, as interactive rebase's GPG settings are configured differently
from how cherry-pick (and therefore sequencer) handles them, we will
leave support for that to the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index caef51e..99c39fb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,6 +27,19 @@ static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
 static GIT_PATH_FUNC(git_path_opts_file, "sequencer/opts")
 static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
 
+/*
+ * A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
+ * GIT_AUTHOR_DATE that will be used for the commit that is currently
+ * being rebased.
+ */
+static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
+
+/* We will introduce the 'interactive rebase' mode later */
+static inline int is_rebase_i(const struct replay_opts *opts)
+{
+	return 0;
+}
+
 static const char *get_dir(const struct replay_opts *opts)
 {
 	return git_path_seq_dir();
@@ -370,19 +383,79 @@ static int is_index_unchanged(void)
 }
 
 /*
+ * Read the author-script file into an environment block, ready for use in
+ * run_command(), that can be free()d afterwards.
+ */
+static char **read_author_script(void)
+{
+	struct strbuf script = STRBUF_INIT;
+	int i, count = 0;
+	char *p, *p2, **env;
+	size_t env_size;
+
+	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
+		return NULL;
+
+	for (p = script.buf; *p; p++)
+		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
+			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
+		else if (*p == '\'')
+			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
+		else if (*p == '\n') {
+			*p = '\0';
+			count++;
+		}
+
+	env_size = (count + 1) * sizeof(*env);
+	strbuf_grow(&script, env_size);
+	memmove(script.buf + env_size, script.buf, script.len);
+	p = script.buf + env_size;
+	env = (char **)strbuf_detach(&script, NULL);
+
+	for (i = 0; i < count; i++) {
+		env[i] = p;
+		p += strlen(p) + 1;
+	}
+	env[count] = NULL;
+
+	return env;
+}
+
+/*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
  * author date and name.
+ *
  * If we are revert, or if our cherry-pick results in a hand merge,
  * we had better say that the current user is responsible for that.
+ *
+ * An exception is when run_git_commit() is called during an
+ * interactive rebase: in that case, we will want to retain the
+ * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 			  int allow_empty)
 {
+	char **env = NULL;
 	struct argv_array array;
 	int rc;
 	const char *value;
 
+	if (is_rebase_i(opts)) {
+		env = read_author_script();
+		if (!env)
+			return error("You have staged changes in your working "
+				"tree. If these changes are meant to be\n"
+				"squashed into the previous commit, run:\n\n"
+				"  git commit --amend $gpg_sign_opt_quoted\n\n"
+				"If they are meant to go into a new commit, "
+				"run:\n\n"
+				"  git commit $gpg_sign_opt_quoted\n\n"
+				"In both cases, once you're done, continue "
+				"with:\n\n"
+				"  git rebase --continue\n");
+	}
+
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
@@ -391,14 +464,13 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
 		argv_array_push(&array, "-s");
-	if (!opts->edit) {
-		argv_array_push(&array, "-F");
-		argv_array_push(&array, defmsg);
-		if (!opts->signoff &&
-		    !opts->record_origin &&
-		    git_config_get_value("commit.cleanup", &value))
-			argv_array_push(&array, "--cleanup=verbatim");
-	}
+	if (defmsg)
+		argv_array_pushl(&array, "-F", defmsg, NULL);
+	if (opts->edit)
+		argv_array_push(&array, "-e");
+	else if (!opts->signoff && !opts->record_origin &&
+		 git_config_get_value("commit.cleanup", &value))
+		argv_array_push(&array, "--cleanup=verbatim");
 
 	if (allow_empty)
 		argv_array_push(&array, "--allow-empty");
@@ -406,8 +478,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 	if (opts->allow_empty_message)
 		argv_array_push(&array, "--allow-empty-message");
 
-	rc = run_command_v_opt(array.argv, RUN_GIT_CMD);
+	rc = run_command_v_opt_cd_env(array.argv, RUN_GIT_CMD, NULL,
+			(const char *const *)env);
 	argv_array_clear(&array);
+	free(env);
+
 	return rc;
 }
 
@@ -657,7 +732,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = run_git_commit(git_path_merge_msg(), opts, allow);
+		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
+				     opts, allow);
 
 leave:
 	free_message(commit, &msg);
@@ -879,6 +955,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
+	if (is_rebase_i(opts))
+		return 0;
+
 	if (!file_exists(git_path_opts_file()))
 		return 0;
 	/*
-- 
2.10.1.513.g00ef6dd


