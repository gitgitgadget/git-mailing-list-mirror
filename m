Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886A32018E
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbcH2IGM (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:54092 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932679AbcH2IGK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:10 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lr32V-1b8XfO2nad-00efGz; Mon, 29 Aug 2016 10:06:01
 +0200
Date:   Mon, 29 Aug 2016 10:06:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 14/22] sequencer: prepare for rebase -i's commit
 functionality
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <1d83fa095c03eac9abfd1038ff7791bae8ace984.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4j31mgb8zS3Daug3Ho0cotmmpnqlPk1nXqsMQGlPWtnhmmtSoDu
 PW42IzyNz4qR/VWAwbVYeuNtuRNIlBfk3PtduUTZT0eFxNBs9oO3OSJ2EiG6jGPYQjA/7oz
 TjPQ12cuLO7URZJ0oOjZDyKA/CRqa9xGsPUI3rQJNCnnPYI/7As25YvnGfMcg0mT9Abfk5q
 84HK/5jWq0PqwPG+RCotg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p3hodew0tB0=:/DLc7T5Bj2NiX8fCC+j4nZ
 az4yQR4THJ5J9dHbSMarlnSbBzDiumPziwilJyCIbraGJYmeADZnjZfrXmhfvtQphXUS4S3T6
 0Ugtys8RHFTRQWhdNdX1IQpv9TG7NQ9IK288aZk0lTzcfmn4iZSGaVadOtXtlEkBNVA6JPqyA
 hkH4P1/tRzBZjncWfcCR+Ajeayswqf5/f32SCpJxLrR0dBwm7NfjoJwy3aKBE4YFwsMSQUpSC
 EjdpWqPShkFifWacw42YFZWTnNHMOp16KOkTz7rIo+vOG0Jn/mgAg2MXNPBYkTpa+dVSoyXeC
 C5VDrgbTFPuG1Y9QlyLNFrfGJfXk+euLx/dFmVljrmfi0h5cDdpateYSS4fV+Dncdv6pX4/Cm
 ok49lUfQSbKp3SM1+PmLWhPN0A+uX/O3xsZf7dCzLbzIWhLypLX2FLJG98QFDUrS/XEsYK72R
 j/bkxPQQiNQQRsK0V8wt3EuscxS+fju+7IblZ5kFDGvdxDv9yE9u86UTcEBzRaim4gRE3fCxp
 o1dMexkyHOKRIZtSTEtQoBSUZMmZJXZHqwUdWOYSTMYNn490X+H4vcUfciEwGMaqmwtDIFJ2S
 4szR373+OAGO3FwdTHRd7I8fCyJZ68nJSKPhYP63H0AKY99h4cG7V245mqB2Cd4jUw4zy32CN
 EHRFHCGddDr1DeSC2UCMFHVKqZ6aaAc5++BQmHjGEUbqG6yd96yULLVrXsKNyRZK+Z/xiqugH
 uuh0Bzm23/Arde85dRjTp3n9jmB9PTiqb8bVXSd8zBm7O150ijzL3hjrLYsxsQ2M//5yXv8sy
 TXc2NYR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In interactive rebases, we commit a little bit differently than the
sequencer did so far: we heed the "author-script", the "message" and
the "amend" files in the .git/rebase-merge/ subdirectory.

Likewise, we may want to edit the commit message *even* when providing
a file containing the suggested commit message. Therefore we change the
code to not even provide a default message when we do not want any, and
to call the editor explicitly.

As interactive rebase's GPG settings are configured differently from
how cherry-pick (and therefore sequencer) handles them, we will leave
support for that to the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 sequencer.h |  3 ++
 2 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3398774..b124980 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -27,6 +27,16 @@ static GIT_PATH_FUNC(git_path_todo_file, "sequencer/todo")
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
+#define IS_REBASE_I() 0
+
 static const char *get_dir(const struct replay_opts *opts)
 {
 	return git_path_seq_dir();
@@ -377,20 +387,72 @@ static int is_index_unchanged(void)
 	return !hashcmp(active_cache_tree->sha1, head_commit->tree->object.oid.hash);
 }
 
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
 /*
  * If we are cherry-pick, and if the merge did not result in
  * hand-editing, we will hit this commit and inherit the original
  * author date and name.
  * If we are revert, or if our cherry-pick results in a hand merge,
- * we had better say that the current user is responsible for that.
+ * we had better say that the current user is responsible for that
+ * (except, of course, while running an interactive rebase).
  */
-static int run_git_commit(const char *defmsg, struct replay_opts *opts,
+int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 			  int allow_empty)
 {
+	char **env = NULL;
 	struct argv_array array;
 	int rc;
 	const char *value;
 
+	if (IS_REBASE_I()) {
+		env = read_author_script();
+		if (!env)
+			return error("You have staged changes in your working "
+				"tree. If these changes are meant to be\n"
+				"squashed into the previous commit, run:\n\n"
+				"  git commit --amend $gpg_sign_opt_quoted\n\n"
+				"If they are meant to go into a new commit, "
+				"run:\n\n"
+				"  git commit $gpg_sign_opt_quoted\n\n"
+				"In both case, once you're done, continue "
+				"with:\n\n"
+				"  git rebase --continue\n");
+	}
+
 	argv_array_init(&array);
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
@@ -399,14 +461,13 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
@@ -414,8 +475,11 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
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
 
@@ -664,7 +728,8 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
-		res = run_git_commit(git_path_merge_msg(), opts, allow);
+		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
+			opts, allow);
 
 leave:
 	free_message(commit, &msg);
@@ -859,6 +924,9 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
+	if (IS_REBASE_I())
+		return 0;
+
 	if (!file_exists(git_path_opts_file()))
 		return 0;
 	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
diff --git a/sequencer.h b/sequencer.h
index 674f11e..9f63c31 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -49,6 +49,9 @@ int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
+int sequencer_commit(const char *defmsg, struct replay_opts *opts,
+			  int allow_empty);
+
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-- 
2.10.0.rc1.114.g2bd6b38


