Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E311F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933718AbcHaIy6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:54:58 -0400
Received: from mout.gmx.net ([212.227.15.19]:53663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753144AbcHaIyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M92ZJ-1bpDsv3HfJ-00CQwL; Wed, 31 Aug 2016 10:54:12
 +0200
Date:   Wed, 31 Aug 2016 10:54:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/34] sequencer (rebase -i): implement the 'edit' command
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <755be5201e9ab12a0cce2bebcdf3ab37dfc368c7.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:LGqBUFhkSRTgFiJ8Wd7XPB3sXVWz2Kr/dPYkpIktT0NB/XnCncB
 Xox6cuv60tEm54Cb94UQRNiupdVBF9ilzLOGx66v5YgaOD0/usCxi5+xYBWJctvGES5bAY5
 rIwLqy6IDxhp7YkML1Xm7ONT6QcLJ9FtPBHi5+wHdun6Mf7dGIiSYYOZlzlPK6hE5nomo5R
 EsJcRVw7C/OHbp5U8IDhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lalgb5Bt/2Q=:UbN2hQWWIRUufrbWYsSyKT
 QsZPBu2+jCM1x9t2TCAm0R7sjNjPuiZOnZo+l2SSt05lMbOluMA17Xz0ZeaEc+mV8DthT3s/S
 tqrhnaBDfk0CoBqW3774lQlxDOIzWEXUp+3jY0RrTQ86Wx1oCPmuiqzbY5cMSNS/GE9R5rQZ0
 C4pdDCjK9EA3R4pFZsvITzrfy7kh2SnTAe4dHsIfB0lnNYJ5uIHxdMOPaKTij/8V0LGkssalW
 70BFXXRa86SuafUY73oGBfEDFOHZT5iu70Hn38Qw2aFSa5RrSBOwQ4DDYmSXr0dw8x25DEPuH
 WjGFLSoHrVrCRLXcXXRPIXEMXD1rbtiKa1F4Oq60OJX9Ndg26Sg7N/7EJjK43Tu98v5A2xOIh
 OaNPewVyWhr+zIB5w595llbizsDM85OPXODc/+0OR+RYAVBVx5UZIed2Lvk9o/wkNFbUUS/CI
 1EGCMWf4ItJPHU8WWEaDNf9osVSB+Md8CmZjb/U2FsvZ+jcsnNmdCDy/CcLfxp6BH0Mn1uAFW
 OR62hiNd3u/Rluw7/mNsJwN8XOGz9KzOvXor9cz9iX2ztz1KCvi7vUTZdO2JioFs6aErprvK2
 zOHv64Blz726bqlnB4xHx2GTGlDHkXX+jenEq++R107sqgjIWzcCc7xQJdGZLENwmU324ShD9
 BRA4VlNvAr44F3Tg766j0FP0rolM+lEIzJ1H4NiszvoxrAuKBun48IWqQYTRgUs5ZN9iLQRBC
 8QVz8eSM3ME7pGbF3S+s4CLOLhMkM/bhSlVZmNhsCttJy0DfbjEajtz91Ug6xPzAHZa7zqfks
 yCMeybX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is a straight-forward reimplementation of the `edit`
operation of the interactive rebase command.

Well, not *quite* straight-forward: when stopping, the `edit`
command wants to write the `patch` file (which is not only the
patch, but includes the commit message and author information). To
that end, this patch requires the earlier work that taught the
log-tree machinery to respect the `file` setting of
rev_info->diffopt to write to a file stream different than stdout.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f85dc9c..fe2f6e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -16,6 +16,7 @@
 #include "refs.h"
 #include "argv-array.h"
 #include "quote.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -43,6 +44,20 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
  */
 static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
 /*
+ * When an "edit" rebase command is being processed, the SHA1 of the
+ * commit to be edited is recorded in this file.  When "git rebase
+ * --continue" is executed, if there are any staged changes then they
+ * will be amended to the HEAD commit, but only provided the HEAD
+ * commit is still the commit to be edited.  When any other rebase
+ * command is processed, this file is deleted.
+ */
+static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
+/*
+ * When we stop at a given patch via the "edit" command, this file contains
+ * the long commit name of the corresponding patch.
+ */
+static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
+/*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
  */
@@ -645,12 +660,14 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 enum todo_command {
 	TODO_PICK,
 	TODO_REVERT,
+	TODO_EDIT,
 	TODO_NOOP
 };
 
 static const char *todo_command_strings[] = {
 	"pick",
 	"revert",
+	"edit",
 	"noop"
 };
 
@@ -1279,9 +1296,85 @@ static int save_opts(struct replay_opts *opts)
 	return res;
 }
 
+static int make_patch(struct commit *commit, struct replay_opts *opts)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct rev_info log_tree_opt;
+	const char *commit_buffer = get_commit_buffer(commit, NULL), *subject;
+	int res = 0;
+
+	if (write_file_gently(rebase_path_stopped_sha(),
+			      short_commit_name(commit), 1) < 0)
+		return -1;
+
+	strbuf_addf(&buf, "%s/patch", get_dir(opts));
+	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
+	init_revisions(&log_tree_opt, NULL);
+	log_tree_opt.abbrev = 0;
+	log_tree_opt.diff = 1;
+	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
+	log_tree_opt.disable_stdin = 1;
+	log_tree_opt.no_commit_id = 1;
+	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
+	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
+	if (!log_tree_opt.diffopt.file)
+		res |= error_errno("could not open '%s'", buf.buf);
+	else {
+		res |= log_tree_commit(&log_tree_opt, commit);
+		fclose(log_tree_opt.diffopt.file);
+	}
+	strbuf_reset(&buf);
+
+	strbuf_addf(&buf, "%s/message", get_dir(opts));
+	if (!file_exists(buf.buf)) {
+		find_commit_subject(commit_buffer, &subject);
+		res |= write_file_gently(buf.buf, subject, 1);
+		unuse_commit_buffer(commit, commit_buffer);
+	}
+	strbuf_release(&buf);
+
+	return res;
+}
+
+static int intend_to_amend(void)
+{
+	unsigned char head[20];
+
+	if (get_sha1("HEAD", head))
+		return error("Cannot read HEAD");
+
+	return write_file_gently(rebase_path_amend(), sha1_to_hex(head), 1);
+}
+
+static int error_with_patch(struct commit *commit,
+	const char *subject, int subject_len,
+	struct replay_opts *opts, int exit_code, int to_amend)
+{
+	if (make_patch(commit, opts))
+		return -1;
+
+	if (to_amend) {
+		if (intend_to_amend())
+			return -1;
+
+		fprintf(stderr, "You can amend the commit now, with\n"
+			"\n"
+			"  git commit --amend %s\n"
+			"\n"
+			"Once you are satisfied with your changes, run\n"
+			"\n"
+			"  git rebase --continue\n", gpg_sign_opt_quoted(opts));
+	}
+	else if (exit_code)
+		fprintf(stderr, "Could not apply %s... %.*s\n",
+			short_commit_name(commit), subject_len, subject);
+
+	return exit_code;
+}
+
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
-	int res;
+	int res = 0;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
 	if (opts->allow_ff)
@@ -1294,9 +1387,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		struct todo_item *item = todo_list->items + todo_list->current;
 		if (save_todo(todo_list, opts))
 			return -1;
-		if (item->command <= TODO_REVERT)
+		if (item->command <= TODO_EDIT) {
 			res = do_pick_commit(item->command, item->commit,
 					opts);
+			if (item->command == TODO_EDIT) {
+				struct commit *commit = item->commit;
+				if (!res)
+					warning("Stopped at %s... %.*s",
+						short_commit_name(commit),
+						item->arg_len, item->arg);
+				return error_with_patch(commit,
+					item->arg, item->arg_len, opts, res,
+					!res);
+			}
+		}
 		else if (item->command != TODO_NOOP)
 			return error("Unknown command %d", item->command);
 
@@ -1305,6 +1409,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			return res;
 	}
 
+	if (is_rebase_i(opts)) {
+		/* Stopped in the middle, as planned? */
+		if (todo_list->current < todo_list->nr)
+			return 0;
+	}
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
-- 
2.10.0.rc2.102.g5c102ec


