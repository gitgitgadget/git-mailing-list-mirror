Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C133205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756271AbdABP1Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:27:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:50188 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755641AbdABP1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:27:24 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVNDK-1c0Jm145tu-00YkxN; Mon, 02
 Jan 2017 16:27:16 +0100
Date:   Mon, 2 Jan 2017 16:27:15 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 11/38] sequencer (rebase -i): implement the short
 commands
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <58cf9377b8df966d05feab3113e83ee07113a891.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NbWFElT1D+EVHnVQBhMjjOZUy+dMn7vwin4VdSq0Km5Ea2vnL1r
 LbnivTjuZWcDqTzt42fFICFsWr9K8U40vOFjQ0/5oZLrEYwChrCFrICeiBL+42XBVZOSPcS
 fcnHubaxiZTyJHCesbnM6P08TXgY2JUSq45zRNkTIudwP10/VMfqY+N9CSj2sQPuq3+z5WS
 Cg/S7AF0tRS2uH0L3r0lA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cg8XSyGiffc=:zCZ1dAqUlz8Kd8CjYXkWqk
 Cjs1da7mI+4P4XDwFA73flBiCuN4uY+safVF3bn6/iC8ZNtG4TB8HtFmWaU4DXMZArFphVsIT
 ACd/O1D1RINgCI2jEAQzZj27YxLAigmfTKXN19DiBPmZ1g4wRdYfUOHADZlkggROpSMMxtnYZ
 A27S3uXW2n7BbmIfNB4UajZ9HPwRwN7YhGcyTmHJPIbnI5ZM1CLfkQPqiv5XJo1PqMDU1iWrk
 ZgfHQmsKJsn20rA5TrAEqP3SB1Z+5Nl8a835FayrBNIJrbRygAy4SpJDQhq/0iadnu1zJG2Lk
 OmK75xslEkkpcjkgQxq39ED00mAsi9ThuUtcxP/0EssenvHDj124HTf/awcKK+IsfFAhmtQ6D
 1rBtZVLvY0qJVJn7NCuNAxxMAL+tF2mtufJIJKEyv88fOdIwL4UGxk6CGnOhmnRcZ/ZJa+YYG
 wOZ11erc5JvG7J7Qlgsaw6XkQwpPuVFAuvvskw2bWFW3qhmzsZt2q4rSUZj9uOVkeV8wXGbcQ
 ryEpNJvG1d7Tk40Cmbq+l4gBIM5I3UO7byfxsmXRUOQptjzllWBx9k6VC9Fw1ZedFVwWyAanl
 jycBvWYQK/qwojRnj6+Db4sSTUT0M+NvayZvf6jujqWXolFlKS6JM2EYWVFj3Itv8ixFC8gLE
 kRXwOGZ+9Vo0rhEt7s00fcnS0xkR5tjlZmslSi5LWKX+typFvOWAc3tt1SfJ3jlEqEFBkVVyo
 lm0+Cz8bASBI36FOl488W3GEMLqo0xeQUEZZHJbfd74ahlZZt60hNzDDVXXZPHOu1gzZ1r/Hn
 WQbbrzI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For users' convenience, most rebase commands can be abbreviated, e.g.
'p' instead of 'pick' and 'x' instead of 'exec'. Let's teach the
sequencer to handle those abbreviated commands just fine.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6a939a10bd..29b944d724 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -678,20 +678,23 @@ enum todo_command {
 	TODO_NOOP
 };
 
-static const char *todo_command_strings[] = {
-	"pick",
-	"revert",
-	"edit",
-	"fixup",
-	"squash",
-	"exec",
-	"noop"
+static struct {
+	char c;
+	const char *str;
+} todo_command_info[] = {
+	{ 'p', "pick" },
+	{ 0,   "revert" },
+	{ 'e', "edit" },
+	{ 'f', "fixup" },
+	{ 's', "squash" },
+	{ 'x', "exec" },
+	{ 0,   "noop" }
 };
 
 static const char *command_to_string(const enum todo_command command)
 {
-	if ((size_t)command < ARRAY_SIZE(todo_command_strings))
-		return todo_command_strings[command];
+	if ((size_t)command < ARRAY_SIZE(todo_command_info))
+		return todo_command_info[command].str;
 	die("Unknown command: %d", command);
 }
 
@@ -1087,12 +1090,16 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
-		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
+	for (i = 0; i < ARRAY_SIZE(todo_command_info); i++)
+		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
+			item->command = i;
+			break;
+		} else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
+			bol++;
 			item->command = i;
 			break;
 		}
-	if (i >= ARRAY_SIZE(todo_command_strings))
+	if (i >= ARRAY_SIZE(todo_command_info))
 		return -1;
 
 	if (item->command == TODO_NOOP) {
@@ -1287,7 +1294,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 {
 	enum todo_command command = opts->action == REPLAY_PICK ?
 		TODO_PICK : TODO_REVERT;
-	const char *command_string = todo_command_strings[command];
+	const char *command_string = todo_command_info[command].str;
 	struct commit *commit;
 
 	if (prepare_revs(opts))
-- 
2.11.0.rc3.windows.1


