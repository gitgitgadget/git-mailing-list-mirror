Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA31F2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934221AbcLMPc4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:56 -0500
Received: from mout.gmx.net ([212.227.15.15]:50928 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933862AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNZ9u-1cFAMP3p9u-007AEw; Tue, 13
 Dec 2016 16:31:20 +0100
Date:   Tue, 13 Dec 2016 16:31:19 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 17/34] sequencer (rebase -i): allow fast-forwarding for
 edit/reword
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <c629351aababf2188672ae036ecbde4d9631e908.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZTINUGyvg6zjeFSR/LfmqxJK2ModeSqcYzHTuc/u0bhliimUG1Z
 kYkpZYqbpcvRCIjTSS5a6m2iZACE4kEY4Y2CDcaquYNR5gQp3qSfuEq6PfXkytLiI9qgy1t
 g/vbD7a8r7VJDHfhSGVOHVMEHEaEYUkwmebvNMn6rtO+CQCr3VtAlyEQyZFFgqEAL6jT9ZB
 4z3eQYTfT6A3/sp+PSuJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5fjzM4fdeOo=:Cmz5RLjswZ4M7W3rPadBYv
 B0+82E9quWKZwfNorCyeI7r0XQFmYHzICgTr6cEIoUmCXuf1rbRpX9Gx2WP65InRlYi4IStqW
 nBHDmyQhgOR/R29vDAGEIYy+U/661b3vKQPLXPcToEU75Pu1Al8145UbxPlkExiHD7FtCe+pQ
 IFE50gFfPH0D714tjHzM8MgefpiuUANxi1uoujOEe7uGwORo0gxuPiMHxUR6Jbc14pikzUddy
 2fBHZrrwEp1BmNU+mq+QltaiqOARfS/UXQYJLDe3bshdQ0rTTGExf9Z66HebVFBFQD8aAnX5j
 EO39VsPMpUP1juCRAwryAjb/wX2Du/xKtQ/j3nyXPnrIWfBpRZdLhBoRI/pLJivhh6jxoXYd6
 evhi1qnKKYZsrhL5m4x1V1JUdDq2w7kVjdWMnNlQtE5LtbEVgt2mZN6nTgT+b1sQRMc/0g9SY
 K/umLlVRsrb2Om8rH2g9oMQQFzACsMn/ZJkYs1XA+i9GdOBfBxtuwO6oIJ2c4hZKqvCi+rcQH
 aXqSOKo/gb6xcwPA5taLXSHcYlUJVFfqpifyk0AwePDO6ecEDJShwikT4f41gIpMDx9B4If87
 8HundRz45Hm64UakgzQZXReWviQxZN6qDNb7Iay1ahzbHtiPsSUf9VGVA8AfFySiZO1m54Qun
 BlQrlF3t/4lK36rj+eYQ3mzRBRAndZ2WUI62Wx6M5ubBBJ5/iIaVpgb9l6KI/wDpIqUDNwFiZ
 Usk9PM3CqbPJFsnntQGGer3a2H8naR7itT8hAxvcFEpRnm1VUbNZFFRGoHXrUwR8oE6AB4DEY
 dnyCqbE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer already knew how to fast-forward instead of
cherry-picking, if possible.

We want to continue to do this, of course, but in case of the 'reword'
command, we will need to call `git commit` after fast-forwarding.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5a9972fec3..33fb36dcbe 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -893,7 +893,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0, amend = 0, allow;
+	int res, unborn = 0, amend = 0, allow = 0;
 
 	if (opts->no_commit) {
 		/*
@@ -939,11 +939,23 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	else
 		parent = commit->parents->item;
 
+	if (get_message(commit, &msg) != 0)
+		return error(_("cannot get commit message for %s"),
+			oid_to_hex(&commit->object.oid));
+
 	if (opts->allow_ff && !is_fixup(command) &&
 	    ((parent && !hashcmp(parent->object.oid.hash, head)) ||
-	     (!parent && unborn)))
-		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
-
+	     (!parent && unborn))) {
+		if (is_rebase_i(opts))
+			write_author_script(msg.message);
+		res = fast_forward_to(commit->object.oid.hash, head, unborn,
+			opts);
+		if (res || command != TODO_REWORD)
+			goto leave;
+		edit = amend = 1;
+		msg_file = NULL;
+		goto fast_forward_edit;
+	}
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be a "todo" command like
 		   "revert" or "pick", the second %s a SHA1. */
@@ -951,10 +963,6 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			command_to_string(command),
 			oid_to_hex(&parent->object.oid));
 
-	if (get_message(commit, &msg) != 0)
-		return error(_("cannot get commit message for %s"),
-			oid_to_hex(&commit->object.oid));
-
 	/*
 	 * "commit" is an existing commit.  We would want to apply
 	 * the difference it introduces since its first parent "prev"
@@ -1084,6 +1092,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
+fast_forward_edit:
 		res = run_git_commit(msg_file, opts, allow, edit, amend,
 				     cleanup_commit_message);
 
-- 
2.11.0.rc3.windows.1


