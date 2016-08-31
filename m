Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5251F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759213AbcHaIzy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:62649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933733AbcHaIzv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:51 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M9b4B-1bofhG1l1z-00D1gi; Wed, 31 Aug 2016 10:55:45
 +0200
Date:   Wed, 31 Aug 2016 10:55:44 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 20/34] sequencer (rebase -i): copy commit notes at end
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <7427d5a9e76264252540c72c5a70e71c3d470667.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iuZqNd2vQSc9v47EcKBaGTjE8K1kyhunfZwyE/4QaicgKFq4Rdw
 XcG/RlDX34BrqQ3gz4zgxB/GSoJLSoSHxFgL6b3Fxkyi1edbtuQxBoA+5366d0oOgD9Wc9V
 vlJIMV/cdymx8zYZZGS6NIw221k/t62bnVjf5MAUoO65KwJXCakPPZ1tV20laX65s02cP6N
 a5n5p95CTXLnjAvS5AeWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1xrSqheDsps=:7cezh+KXuWCFTkoAIV5cFR
 kKbUvlp564E41KyGTiGU+L3PYnSGbFg7PTczxfGxiuOFWHhhhuGnuTLVHHyICl9lR/7sxgtvc
 aHCEvOHwGnj0b3SLrk0iGpseHwHDqVHF5iQwHeYed3Z1EBPsmXwBCZ7cAg8cO2HT/KLamY/sG
 kqPM1/YSijdnjXWi6jy63gfsxNiqm3MmU18oY8ZAJ5OfE+LGS8i92hRGvLerWjomErr7g3Js8
 YVJ2++viDXgo2xAC5ujd9PVAjG4Lz7ATS0bUWNBymcJK97Cr5gKmIkGk2CzAd87SnPC+uYk7N
 EbcwdSe+LABcNRiJ4b0WYJDhacnbIc9PV4bg4BLPScN7V+lAMhudZZzP4Lg8412Dhc3Is0/25
 ZDOwMG2bhbXtMtvSrNtJOkTIn0XIVWjHoaqf/rDDb5mwccxIvnASbxgY8fVdbq/gtbhJ6lkz+
 TviA8BnNk+PMKlmPPVdCBeq+kxsaTjTwoPQrtqXLZfbp6L+GF0CmxH0TAJc8fjjIgN3zlQHjY
 esXv5ZV4e9I6QyKXjZSbE7IHTBDvmNTbPuoX6dQhrGSkttP+FolvC3y+/Mz14fUTo20PqPJcv
 B/wuu61W8U1j+i8vI+bgrBbgiAmxS0qiIvKwDLboH+fszF1GOzC2T24zJz4OATT+xJ8+pFbxd
 DHiyGB1NlfoWSarTkC8CUNxTWu6FBjVKLvoMejP6D+vn3y7GUI5fepXqF+eTYaRJ7Rg83npr+
 JGCWQ/CLAQg63zsvPwqyM3NbqnahrllyWDuO+cOcAxIPRP3BrsNBY6MAJ61clTGoFDBXW7Ani
 7ovVjOg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing commits that have commit notes attached, the interactive
rebase rewrites those notes faithfully at the end. The sequencer must
do this, too, if it wishes to do interactive rebase's job.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 54f654c..a5e18f3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -94,6 +94,15 @@ static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
  */
 static GIT_PATH_FUNC(rebase_path_stopped_sha, "rebase-merge/stopped-sha")
 /*
+ * For the post-rewrite hook, we make a list of rewritten commits and
+ * their new sha1s.  The rewritten-pending list keeps the sha1s of
+ * commits that have been processed, but not committed yet,
+ * e.g. because they are waiting for a 'squash' command.
+ */
+static GIT_PATH_FUNC(rebase_path_rewritten_list, "rebase-merge/rewritten-list")
+static GIT_PATH_FUNC(rebase_path_rewritten_pending,
+	"rebase-merge/rewritten-pending")
+/*
  * The following files are written by git-rebase just after parsing the
  * command-line (and are only consumed, not modified, by the sequencer).
  */
@@ -886,6 +895,43 @@ static int update_squash_messages(enum todo_command command,
 	return write_message(&buf, rebase_path_squash_msg());
 }
 
+static void flush_rewritten_pending(void) {
+	struct strbuf buf = STRBUF_INIT;
+	unsigned char newsha1[20];
+	FILE *out;
+
+	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), 82) > 0 &&
+			!get_sha1("HEAD", newsha1) &&
+			(out = fopen(rebase_path_rewritten_list(), "a"))) {
+		char *bol = buf.buf, *eol;
+
+		while (*bol) {
+			eol = strchrnul(bol, '\n');
+			fprintf(out, "%.*s %s\n", (int)(eol - bol),
+					bol, sha1_to_hex(newsha1));
+			if (!*eol)
+				break;
+			bol = eol + 1;
+		}
+		fclose(out);
+		unlink(rebase_path_rewritten_pending());
+	}
+}
+
+static void record_in_rewritten(struct object_id *oid,
+		enum todo_command next_command) {
+	FILE *out = fopen(rebase_path_rewritten_pending(), "a");
+
+	if (!out)
+		return;
+
+	fprintf(out, "%s\n", oid_to_hex(oid));
+	fclose(out);
+
+	if (!is_fixup(next_command))
+		flush_rewritten_pending();
+}
+
 static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct replay_opts *opts, int final_fixup)
 {
@@ -1726,6 +1772,17 @@ static int is_final_fixup(struct todo_list *todo_list)
 	return 1;
 }
 
+static enum todo_command peek_command(struct todo_list *todo_list, int offset)
+{
+	int i;
+
+	for (i = todo_list->current + offset; i < todo_list->nr; i++)
+		if (todo_list->items[i].command != TODO_NOOP)
+			return todo_list->items[i].command;
+
+	return -1;
+}
+
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
@@ -1784,6 +1841,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					item->arg, item->arg_len, opts, res,
 					!res);
 			}
+			if (is_rebase_i(opts) && !res)
+				record_in_rewritten(&item->commit->object.oid,
+					peek_command(todo_list, 1));
 			if (res && is_fixup(item->command)) {
 				if (res == 1)
 					intend_to_amend();
@@ -1813,6 +1873,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 
 	if (is_rebase_i(opts)) {
 		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
+		struct stat st;
 
 		/* Stopped in the middle, as planned? */
 		if (todo_list->current < todo_list->nr)
@@ -1857,6 +1918,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			run_command_v_opt(argv, RUN_GIT_CMD);
 			strbuf_reset(&buf);
 		}
+		flush_rewritten_pending();
+		if (!stat(rebase_path_rewritten_list(), &st) &&
+				st.st_size > 0) {
+			struct child_process child = CHILD_PROCESS_INIT;
+
+			child.in = open(rebase_path_rewritten_list(), O_RDONLY);
+			child.git_cmd = 1;
+			argv_array_push(&child.args, "notes");
+			argv_array_push(&child.args, "copy");
+			argv_array_push(&child.args, "--for-rewrite=rebase");
+			/* we don't care if this copying failed */
+			run_command(&child);
+		}
+
 		strbuf_release(&buf);
 		strbuf_release(&head_ref);
 	}
-- 
2.10.0.rc2.102.g5c102ec


