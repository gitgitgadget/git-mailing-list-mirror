Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09AE12042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933502AbcLMPg4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:36:56 -0500
Received: from mout.gmx.net ([212.227.15.18]:60580 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933362AbcLMPgz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:36:55 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUYnD-1c8wmL47MJ-00RLxU; Tue, 13
 Dec 2016 16:30:07 +0100
Date:   Tue, 13 Dec 2016 16:30:06 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 08/34] sequencer (rebase -i): implement the short
 commands
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <42d43763075f3f2daa2cc06a8afc9bcfd8b20ac2.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:p1ksKdiaQbhjwzAEDiFapdocgtx9i7wVqwNFmSLZijzDwyz4RXY
 j2fq9sWuLRSQRCHMb6O570YBQkftbMThP/fzKXQ+Cp8HTRsfpjIZaW/7shWYQeE7oCXyJmM
 CyqVGn+Zq53QhxfLcktMo/JyCe3fVrxFINZM36woMjnNBQBgH1ylygt/vDsZN86mDM05uay
 j8atiNkqArb+3U/jqLtsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZD2tu2t8xq8=:ZBRWoZpK5ad0jD8zHSSkYb
 hdFDbli/8JpinudB8fqWLIk5P5t8mHMcenc8NOOBX8TIda++/8gBQM66pRJHZ885RMjfW6gzx
 yerFlsPTFnrdvdPdvsooa1TJ0dhJQBFkfKGiAo4VQDOsbKhTx/ii2MwgW51TNqlN059sUCJi0
 10NuHpajUBbf8dqMPlws6Ezrkz+dr0ff0D0Ru8JTy3PtKJPts0ECN3F6TNCfa0PT05tuc+f9F
 VjvX27ZhmxKTJv+t7mNwEBRxVkmSo89aLe1Isu76oZqUNtOlK4FIG0y8e4xA5yu/xtbiaL9/N
 LAwFBZJNhxrTVF9kCyPDTrDzbeKEWQg3Zwwp6F9tDASWeQ9wUqyfztY93PTsHYQgKjkWJbCuD
 B1YI+gfne1SGmA0H1+0wr7W4POp4MdwO7fsg0IjGuf0GsqhwWXhjfP6Qr+LUl9moYNbwenQLP
 YAW2sccTTnTAKsvH+D+DvWaQQhbSTZzcqPlTVR07E2TvLLgjal52oEm4Zw+xKjXUGWNLwNVat
 2nNik3rXUzqS0mF/7Sdt/cv6DFzq3zH7gOqK/GmIVze6krhpbb0PSdWiigDaIdjufcZ+BZ9U7
 zkGWl0NNKVwFKAfbheE0vz6xGnYLPtY7lFp9hKOnSrVHzbMDXaOYnwQApJGTC5Sk0c9tvU2mE
 nAhYnZfFqBH0ap35JOV2wqSl5ycE/jZdoFXsoT9H0utDZzUNnvnowprwKQL6rF1i7vYk4z/mM
 H4UNzfsMxmvGumd64C1JASnnjNegbvHYLXsZ9r7riPY+LwEVjodkewwssau046djVElNGg3CM
 YDktn3W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For users' convenience, most rebase commands can be abbreviated, e.g.
'p' instead of 'pick' and 'x' instead of 'exec'. Let's teach the
sequencer to handle those abbreviated commands just fine.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 271c21581d..e443f4765d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -710,20 +710,23 @@ enum todo_command {
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
 
@@ -1125,12 +1128,17 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 		return 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
-		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
+	for (i = 0; i < ARRAY_SIZE(todo_command_info); i++)
+		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
 			item->command = i;
 			break;
 		}
-	if (i >= ARRAY_SIZE(todo_command_strings))
+		else if (bol[1] == ' ' && *bol == todo_command_info[i].c) {
+			bol++;
+			item->command = i;
+			break;
+		}
+	if (i >= ARRAY_SIZE(todo_command_info))
 		return -1;
 
 	if (item->command == TODO_NOOP) {
@@ -1325,7 +1333,7 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 {
 	enum todo_command command = opts->action == REPLAY_PICK ?
 		TODO_PICK : TODO_REVERT;
-	const char *command_string = todo_command_strings[command];
+	const char *command_string = todo_command_info[command].str;
 	struct commit *commit;
 
 	if (prepare_revs(opts))
-- 
2.11.0.rc3.windows.1


