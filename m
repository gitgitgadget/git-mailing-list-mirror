Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6E9207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966101AbdDZTSA (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:18:00 -0400
Received: from mout.gmx.net ([212.227.15.19]:51736 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965051AbdDZTR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:17:58 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8OH-1e9gG330w5-016h1n; Wed, 26
 Apr 2017 21:17:46 +0200
Date:   Wed, 26 Apr 2017 21:17:40 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Stephen Hicks <sdh@google.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] rebase -i: reread the todo list if `exec` touched it
Message-ID: <ffb8b1ddb7a8a22643d569565e1a4929b883fba5.1493234134.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TFBn4km56saCpulpyfGCLl9EdgwFBjuAKcqufZ0ysMc4vxGk/uO
 lsEpRiJyZDrYUhMfpR6H1vLEyVyA3wjq0sCzEf7AHEt4RnTbNQTn9nZbQfvwRb1gZuEKd9G
 fvgUuqA/KpTs0pKXFo9y5lM5YuKSYzr0dAukSTLvLpe19QDU3mx5jrxRXC+1In2Bkopdn6G
 CSiGeWBEPNZWh/5MBeXFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gcU0SfYsYdY=:ETHdSNedeX7/tL118ZOhu1
 hKIkx15FBFbRbb0PEiIvxvcmPJiZRVHRe+KGayexxaVhMa48bSJ54lyus5e79fmRObbQhld32
 7NPKLp/jj0vlEKTo6ZkCg81n6gvPnmdSThDQMRlG+gKQ29+3ZGo0GyvMI2cEa9vH0CijgC+m2
 LWOK21gqPkBwZa1RNuAPThjtnCJ3562f98ncCRVcb8yUmOkv/EHjohAUgfIomBK6HsxPv37az
 WODLc95oxbl3ke7uEvg1BA81REUVG3tSzpmCb/QzzZJJlf5v0mbEqlQB+u/himwdB2HZHKfjo
 M0aPWTFFW62K8r5XHCc++F1L1IzGaxTyaFbQPXz+Kg/k6+1TAq0b7meegywsy7TMQ3tYxaWj7
 IlnFVh5nQH+QRkZmxWl6A3dHplyx5UtdZw+7iNZ4kik7A1UEdondTU8AGosIGCnjb9eyBkNK4
 ETk44z3Hmv9RE9kvYKRKqAwFVOICXZL2+D/52dJ8aJat1BwXW1YHHMi53m9u1CsI1ThaCxlxd
 mOPgm4f5M5WnbAspPVg7OmsbxYZYL7dYxL2ts4Dh+oO/BwWrmdgi7cDU+LjdU70iBb3DngcQ2
 J1e5sSOUXPK4IL3BNKZhm+KhuHhGXdcxXXe7C6V/SR0VvY2E3/Pnb+V/nVFgAFAUwml97EgPi
 b/koM6OkqEUfv4RmqyOCi9qQ7hWdR4f6c9CsyhU9eqBag1YRxjJedpM2z1FLTbwtvn/CokIEU
 5yOisk5+IFHmctyXZnPuh3dVXiiiDoZ7auYf4EoeX/AsX/M7ZDWN3oAedQsrUasucQtoN6W/N
 YiG5H4x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephen Hicks <sdh@google.com>

In the scripted version of the interactive rebase, there was no internal
representation of the todo list; it was re-read before every command.
That allowed the hack that an `exec` command could append (or even
completely rewrite) the todo list.

This hack was broken by the partial conversion of the interactive rebase
to C, and this patch reinstates it.

We also add a small test to verify that this fix does not regress in the
future.

Signed-off-by: Stephen Hicks <sdh@google.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/rebase-reread-todo-v1
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-reread-todo-v1

	Based on https://github.com/git/git/pull/343

 sequencer.c                 | 22 ++++++++++++++++++++++
 t/t3428-rebase-edit-todo.sh | 14 ++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100755 t/t3428-rebase-edit-todo.sh

diff --git a/sequencer.c b/sequencer.c
index 77afecaebf0..3fe9fcdab72 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1200,6 +1200,7 @@ struct todo_list {
 	struct todo_item *items;
 	int nr, alloc, current;
 	int done_nr, total_nr;
+	struct stat_data stat;
 };
 
 #define TODO_LIST_INIT { STRBUF_INIT }
@@ -1330,6 +1331,7 @@ static int count_commands(struct todo_list *todo_list)
 static int read_populate_todo(struct todo_list *todo_list,
 			struct replay_opts *opts)
 {
+	struct stat st;
 	const char *todo_file = get_todo_path(opts);
 	int fd, res;
 
@@ -1343,6 +1345,11 @@ static int read_populate_todo(struct todo_list *todo_list,
 	}
 	close(fd);
 
+	res = stat(todo_file, &st);
+	if (res)
+		return error(_("could not stat '%s'"), todo_file);
+	fill_stat_data(&todo_list->stat, &st);
+
 	res = parse_insn_buffer(todo_list->buf.buf, todo_list);
 	if (res) {
 		if (is_rebase_i(opts))
@@ -2028,10 +2035,25 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		} else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
 			int saved = *end_of_arg;
+			struct stat st;
 
 			*end_of_arg = '\0';
 			res = do_exec(item->arg);
 			*end_of_arg = saved;
+
+			/* Reread the todo file if it has changed. */
+			if (res)
+				; /* fall through */
+			else if (stat(get_todo_path(opts), &st))
+				res = error_errno(_("could not stat '%s'"),
+						  get_todo_path(opts));
+			else if (match_stat_data(&todo_list->stat, &st)) {
+				todo_list_release(todo_list);
+				if (read_populate_todo(todo_list, opts))
+					res = -1; /* message was printed */
+				/* `current` will be incremented below */
+				todo_list->current = -1;
+			}
 		} else if (!is_noop(item->command))
 			return error(_("unknown command %d"), item->command);
 
diff --git a/t/t3428-rebase-edit-todo.sh b/t/t3428-rebase-edit-todo.sh
new file mode 100755
index 00000000000..b9292dfc2a3
--- /dev/null
+++ b/t/t3428-rebase-edit-todo.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+
+test_description='rebase should reread the todo file if an exec modifies it'
+
+. ./test-lib.sh
+
+test_expect_success 'rebase exec modifies rebase-todo' '
+	test_commit initial &&
+	todo=.git/rebase-merge/git-rebase-todo &&
+	git rebase HEAD -x "echo exec touch F >>$todo" &&
+	test -e F
+'
+
+test_done

base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
-- 
2.12.2.windows.2.406.gd14a8f8640f
