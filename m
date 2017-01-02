Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A02B205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756068AbdABP0u (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:26:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:62429 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752963AbdABP0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:26:48 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEFqW-1cHQf91ZqS-00FRlq; Mon, 02
 Jan 2017 16:26:39 +0100
Date:   Mon, 2 Jan 2017 16:26:38 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 05/38] sequencer (rebase -i): implement the 'noop'
 command
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <39bd6d62017990c1f99ca8438b298ea67197205b.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9a4NOfo4YntbCrz1qgl0aZ+d+TZh0RmD3Wp/+xO6x7swNKaaWLq
 e1S555+kabV6xkWUwrRx1mK/sAvMKuqeXNeaz9cl/GlxFDLssbthf5nIixfD6Vl7ccqvVm4
 XDphGr2nakmA23dWYsj7YfHJK8SSh/OW3aLAKTRCgXTKUjv/2Tgnm8h5VVMSOti1uPrpWtY
 usnxFOjLTCs4Jk8DyCNfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NRFI5Umr3Ig=:sNu29mZ7XbQSdqIHp8T68T
 viwq6QjN2eJa6Y6AM7fwF7BMHKlgJSuUKrkKlv9ab4UPLRFYq2rBzJ84ZzpmYh9d+Ti45Zrhb
 stIMqfViazH4WMX2v2sJnxoVV40WKquNSG+68V0aMG1katxcWTlu0rcsvrzW3W0KwzA1NwIP7
 T9oE8JhfKC1JGgFI2JPVUYT3vER+90XvQj807Nj1QnFFrAgLEK3BhmNouEv6xkzZcOO92Q1wN
 Cfo6bo+ofX4My6KJ+KZfFtZ9F60bv3D4odgPa/UalQqmi4YGy+YQR7PTX6XjfrYmCbmnuh3qk
 Qrv5hSLUMXuE0a9gllk7Qkno68HYL5eWpCihkgzIUFGikYvDmsbaZ1yB8uth2GNrIL0PT7Fh6
 FDem1egp0AAWGHIjk8/EE/1m60Sl0zYJKhfDijC9S4i6UGgn5O4IEPy/Y9taKZn6tzYp9Hb1c
 n0Q6KlWTqT9eOYaC0fGGUlNiOWPRJXS0XJxSVUu+1X73O8Eq8mLdSSg4CUppnT3zN6LS4q6fx
 BPf1uEyyaNFW/tvtQDhE5Gi81sQD9a73rN7aP7NZ+KgjqqkJZePTrEmFVri+GgoqnLwaA3/Eo
 zbprKm5G8cey8UqqMkKKLLW6ApWKM11y3AxIzZyjt59d/CzoFW1/k3TObiJT+08Sn+E8/Dc/I
 iYnbmIw0qJFeMHwNwaqXL5CLHuscHA8xWcmrCBvLmBt9p1y1wAFfitbm9Yx/9S0ChREFB5t0y
 x/jPZVvhylLs5azigqbQqrzESYwIANqMNzxA1QuEx3eM1SQSZ8F+tQFO3IlvOZoeo9/EDUBip
 pgRvellN5GNEpfa1CFuoi71QDos6heYmTeXsA5Roka5jQPkfz1lroK0CIaEVzqstJdzaF/0w7
 AroVowYpJsrlmySzLP6gMk2ApxUIUSiW8TBxxU4RlQUNKBnZ/Yh7uJ5EsQ7g44RgoWvHc8qNX
 Hjn3Imy+E34ACGsSSDCaBKFqhSn+nQoA4oLNix/CHGjBuPGP9+fp/dNWd7/OF5tk/JtRAAZoZ
 AHx8wFskmp7XS3E7aSVAdv4iA/pYQT5ZvzQct1WtX2z4OzEddzZ3doK5G2ghC0cW9g==
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
 sequencer.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 690460bc67..84f18e64e9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -607,14 +607,23 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
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
@@ -624,6 +633,10 @@ static const char *command_to_string(const enum todo_command command)
 	die("Unknown command: %d", command);
 }
 
+static int is_noop(const enum todo_command command)
+{
+	return TODO_NOOP <= (size_t)command;
+}
 
 static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct replay_opts *opts)
@@ -879,6 +892,14 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
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
@@ -887,6 +908,13 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
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
@@ -1289,7 +1317,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		struct todo_item *item = todo_list->items + todo_list->current;
 		if (save_todo(todo_list, opts))
 			return -1;
-		res = do_pick_commit(item->command, item->commit, opts);
+		if (item->command <= TODO_REVERT)
+			res = do_pick_commit(item->command, item->commit,
+					opts);
+		else if (!is_noop(item->command))
+			return error(_("unknown command %d"), item->command);
+
 		todo_list->current++;
 		if (res)
 			return res;
-- 
2.11.0.rc3.windows.1


