Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD653205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756362AbdABP21 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:49859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756356AbdABP20 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:26 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lmr1w-1d0hbR26N2-00h2jk; Mon, 02
 Jan 2017 16:28:17 +0100
Date:   Mon, 2 Jan 2017 16:28:16 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 23/38] sequencer (rebase -i): copy commit notes at end
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <9c687b46a78c8eb4e9b5a6c4b979bbf1ba8269b9.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Gg0fIREFtkOhu5nH5GhVgCN1vqJRRGNy7iH/KfvccQT8gO5oBHK
 7Al01cj/ERTT7/3HvqxdSCV/NsegdlxU/lzolzZP9xCZi/kwCgGS7vXxpPmx2L+AiMNZJpZ
 sySQs7VY5Odes+unhCVfcPA0pwf1o/pbpb7ZprdB8sMDUEtpl9e9ZlJ4Euv/4OQYozSN6Oj
 qKD1uu8ArAT5fUv/pn+5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wKLOWdZyTRo=:WEtyFqTot5o9yhRoODAd30
 iaDVavdxVJ3Xb6v32g5PZurE7GdprH48tfQBUqwFRtjcjB473I3tuiPg6lft0SOqBM/DEsL3h
 zY6tKJeRUX5ya7IbB6dMVWDpUxdh7sHDj2T5xV+d1n5zQ059YWNv0V8FfjAXbQNECstCKeDN6
 nMo6wqpy13FPOFDNc0XXa0n990MVSAsDxpfXsUohHkKXeVOy//9rhEjDnkQNO8Xq7u3QdT9tv
 AseQL1WVjtXf93Th4mfZcVFKCZO3Fqmmlkrrfz7rXNvFd+R/pKMFM2wpogL0SvPPQ7EVEIvz8
 osZLDQ4ceKYNF5g8ey7Cd+MVCdlSsMixwygW5wQXL1DY6IP3VsdRQksHN32JlORqxkHlVlLwF
 AAfjdMeXtON+jvD7ssWzgHH9sz5BuYsLeZ3bEKcMUPiipRMijLg7Q6jDkvjLmLPkh51rnAR5R
 a50Ft5gAoPkRJ8M9NSvUk//fviiR27XQnknnGDO5Em73o65g7JpUNNeTTWeW9XHIYBG1qJsSk
 Xe1Tn4zUyOlhb9Q28UBWsp4lJrMzTS469JSop2k0yj/POM+g8snXXl+J2Tg7aYQEc8zu+Lnby
 jvTdC8T9l3K9ES678iDYx8ozx1H/avzEj1A06MtlGd3R/lBDMshbKED1GP7hn7gBhFksVm6dI
 r45HjKJlKQDlLe1DDEKTnoc/VOJrnc6uGaRJaUJeUvYhgK3S1Kxh//LoYq1khawR4Px6bPWx1
 fz/zAO/2e7SSZDpiwBN1I/6xMyk5Sjax6TgSqKhHwPpmkyyiC0uFMYEK9Bjj+0E//oDTRoFm0
 SgO4mJG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rebasing commits that have commit notes attached, the interactive
rebase rewrites those notes faithfully at the end. The sequencer must
do this, too, if it wishes to do interactive rebase's job.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 95ae4bcd1e..50380a15b8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -96,6 +96,15 @@ static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
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
@@ -850,6 +859,44 @@ static int update_squash_messages(enum todo_command command,
 	return res;
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
+	strbuf_release(&buf);
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
@@ -1743,6 +1790,17 @@ static int is_final_fixup(struct todo_list *todo_list)
 	return 1;
 }
 
+static enum todo_command peek_command(struct todo_list *todo_list, int offset)
+{
+	int i;
+
+	for (i = todo_list->current + offset; i < todo_list->nr; i++)
+		if (!is_noop(todo_list->items[i].command))
+			return todo_list->items[i].command;
+
+	return -1;
+}
+
 static const char *reflog_message(struct replay_opts *opts,
 	const char *sub_action, const char *fmt, ...)
 {
@@ -1801,6 +1859,9 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					item->arg, item->arg_len, opts, res,
 					!res);
 			}
+			if (is_rebase_i(opts) && !res)
+				record_in_rewritten(&item->commit->object.oid,
+					peek_command(todo_list, 1));
 			if (res && is_fixup(item->command)) {
 				if (res == 1)
 					intend_to_amend();
@@ -1827,6 +1888,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 
 	if (is_rebase_i(opts)) {
 		struct strbuf head_ref = STRBUF_INIT, buf = STRBUF_INIT;
+		struct stat st;
 
 		/* Stopped in the middle, as planned? */
 		if (todo_list->current < todo_list->nr)
@@ -1891,6 +1953,20 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 				log_tree_diff_flush(&log_tree_opt);
 			}
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
2.11.0.rc3.windows.1


