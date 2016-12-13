Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79D12042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933394AbcLMPg2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:36:28 -0500
Received: from mout.gmx.net ([212.227.15.15]:54428 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932390AbcLMPg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:36:27 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQ2Wx-1cDE7n3cIt-005Egc; Tue, 13
 Dec 2016 16:29:37 +0100
Date:   Tue, 13 Dec 2016 16:29:34 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 02/34] sequencer (rebase -i): implement the 'noop'
 command
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <934c8e420cc4a75b1f3e4489fa4a4135c48f78ae.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nRb0uGJSiYMlWbmebrimgSu1dIqg36iQtm1CthQvnhCrD2Jzbic
 PRUjY/Jp/dZPTsFALqvDzQnteLzW52C5oUuZvVjfLugKGM9odBIpHQ0JWGC12YnkEc965KG
 4HghUwr/JOOt1z8a325NMiVXuoGlq+pD5VWxchHWXFc40eqDKVHT3MqThvsMbT0TlcX9MUQ
 kDz2dyN/+3Ig1LsQW9ZjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EkQbA0ymE0Q=:uWGSpHewVrOj6WrsheXCKF
 J3NXIzBRUreQIYoEK9q1tpdoJw5Ltv7nlkH7CBnQ3mu3LNzfQCsok/17uzBzoNbJx8OIIUvUm
 6fEQLHj1zY3+TM2gXHSoqnBpnvnYYfUrbsmXrjkdXpgwfajOGmMKyvELDLM4cxHxBz0O4j22H
 C/eh/VMw+lOxLHQIX0MhoShz/0ltEQIuszq4GCYb13eRZ57DFWwazr6niSfpMYhX/W6aYII+O
 6Bkbr9EMilQnRLSpGWvEds5vZVBExJX06ezS3pyf1IYNEY5NPCCNlf4pZ1K5rYVFqWsW6f5Sr
 CWtdVqCyGNEoCcJR6EUfwd88nNxbfSM9YE3d5t0V2w36kfenxO9dV8R/O3yh0kmXzWdnnx2O3
 o4WSsaWGqo3V+Xyu0lWlf3Hm43yL23pLjw2WiWmzUZpV/M4WgZj1G2PjQIJKM3og89fOrrbM0
 7QHgEsqmawIAKah/NrSPuUglmH7xvadMzGi3kCHWtel9TkZ7EmmVOeGrmh7WTRMPhKWmcJkgP
 hOiMjpki9krBM3mzq4772wt7eqpKgopKyw++dCcEzQwx4d6ij9QUxXlY3pkiSgi++8a8a1Aw3
 PTJjPBYaAN8U+/cm48/036PwBIoXBxQHgCjlQIgvNHruw3dk6vcA3/0PkvKf6D0MjRpykgoYC
 FcVg7YLe3r7V0FxA3Lmzcacb8EoMy0tuNSmDToKjWYt46v3L6bFAyJe3IzD5FzYpYUQLT2SCa
 82EGKtiL0rKUyvZ70J+mbODedarnUBY1jtPSZQqiTzNDXFHf0DFENTKISsilp6pMTI8tvJvAJ
 oI2K+P6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'noop' command is probably the most boring of all rebase -i commands
to support in the sequencer.

Which makes it an excellent candidate for this first stab to add support
for rebase -i's commands to the sequencer.

For the moment, let's also treat empty lines and commented-out lines as
'noop'; We will refine that handling later in this patch series.

To make it easier to identify "classes" of todo_commands (such as:
determine whether a command is pick-like, i.e. handles a single commit),
let's enforce a certain order of said commands.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 21cfdacd06..1224799286 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -639,14 +639,23 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 		return 1;
 }
 
+/*
+ * Note that ordering matters in this enum. Not only must it match the mapping
+ * below, it is also divided into several sections that matter.  When adding
+ * new commands, make sure you add it in the right section.
+ */
 enum todo_command {
+	/* commands that handle commits */
 	TODO_PICK = 0,
-	TODO_REVERT
+	TODO_REVERT,
+	/* commands that do nothing but are counted for reporting progress */
+	TODO_NOOP
 };
 
 static const char *todo_command_strings[] = {
 	"pick",
-	"revert"
+	"revert",
+	"noop"
 };
 
 static const char *command_to_string(const enum todo_command command)
@@ -916,6 +925,14 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	/* left-trim */
 	bol += strspn(bol, " \t");
 
+	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
+		item->command = TODO_NOOP;
+		item->commit = NULL;
+		item->arg = bol;
+		item->arg_len = eol - bol;
+		return 0;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
 		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
 			item->command = i;
@@ -924,6 +941,13 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	if (i >= ARRAY_SIZE(todo_command_strings))
 		return -1;
 
+	if (item->command == TODO_NOOP) {
+		item->commit = NULL;
+		item->arg = bol;
+		item->arg_len = eol - bol;
+		return 0;
+	}
+
 	/* Eat up extra spaces/ tabs before object name */
 	padding = strspn(bol, " \t");
 	if (!padding)
@@ -1292,7 +1316,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		struct todo_item *item = todo_list->items + todo_list->current;
 		if (save_todo(todo_list, opts))
 			return -1;
-		res = do_pick_commit(item->command, item->commit, opts);
+		if (item->command <= TODO_REVERT)
+			res = do_pick_commit(item->command, item->commit,
+					opts);
+		else if (item->command != TODO_NOOP)
+			return error(_("unknown command %d"), item->command);
+
 		todo_list->current++;
 		if (res)
 			return res;
-- 
2.11.0.rc3.windows.1


