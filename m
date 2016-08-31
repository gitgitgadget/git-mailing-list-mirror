Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36F41F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933658AbcHaIy5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:54:57 -0400
Received: from mout.gmx.net ([212.227.17.22]:52661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756381AbcHaIyV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:54:21 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M5IdH-1atM4t1qGt-00zXHg; Wed, 31 Aug 2016 10:54:08
 +0200
Date:   Wed, 31 Aug 2016 10:54:06 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/34] sequencer (rebase -i): implement the 'noop' command
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <3a08b4173a95f1321d5d17dfec278ae7f7dfa070.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0wDGJ3mg0Fnicw9WskGIFdeLKWQdzC8t9edOoqmDfysXVgcwuOG
 2dxOHbBFYOIs1BZxsBWGyHewATzcxZh63FeJjx6Awob3+L8vkcxVy2l3WnoB/MCbD2kGwK/
 IhHD4JI3TsCmSsYVy2jTofKnFCH0Z15j4pg+XPkWPA3HL1kUDwn7sskQWJ8ODFdYR/Bjqqp
 8LLkQpHVFzdv8+I6mLsFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:y8R0N6y49nM=:7oCjCgGbXLGG1pDkdl1dMC
 iIg9I8+xvgu4n2u6Pl2yLmh0OYotOyByX/ck7PtlHscQ/IL/nuoaBkCowC21CUkLYDd+sVSmk
 DNSUu/UNaGzIySRX+yHIaAzVB02tPsddbQ0+imuM7LQ4QGkk2Wb6oy+XK3Wys8UpvoQbD4u+H
 CzTLil+Ck6plCiMFGhhBRQLzah4yuhyey31LN/oweWu4TjRiPFbWr33xltuuXtJ0R5hTv+tI6
 cy0PJqeiJeTVPjDywOdjeJ0uKr3FJWWraBn+aTYXpZHxyhf54GJ1Q6XDL+i6p8N+WvLbRdUms
 vyFKa11H1IHDNUoTmvK9wJ/guf5AtB0g8KXIgLDQal4H2yFZjXJUBpTb9uC2rwkZzRgZqeMQH
 ATdC10bqqsaQJY+Zhfm0IfzUVNu0O8ZzBaB4Hb00i1X3XU+8R/y5MM8FoxjXOF3bDdcyfA6QN
 qgpl0DOVfAD37dhYhxGZEZoi8Xs3rAdOz4F87lJjT6Z/qdaoz8C5zNjb5UsA6vLdMxKWvIeCL
 YMtumu/OSSvJKrEOsRHpYTMjxNznftMbisqjqjY47vyyFLRLX42KGNG/scEsZ3AnN21umE6Ez
 FfghqvWItFFpd7op1p46SKWhdd/moHFihgzstYVLz3kM2Fex/U4dNrvrkoBYINqNJJOQQrg8D
 LRZGhw0hlwNBmEUMzafcbN8ceShPrkaGgOkG3bmWQ2+I0kTyXxCWhpjqZo7lOJ5Ex5Jx7OvXC
 Mp7yYFAT/rNnHx6cTaZo5Wi02v8pBl7JRxG1udGxHlXZlvH0fraXLIKI/kPXlTFvaEjRz6oNW
 u4zdp6S
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5598534..f85dc9c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -644,12 +644,14 @@ static int allow_empty(struct replay_opts *opts, struct commit *commit)
 
 enum todo_command {
 	TODO_PICK,
-	TODO_REVERT
+	TODO_REVERT,
+	TODO_NOOP
 };
 
 static const char *todo_command_strings[] = {
 	"pick",
-	"revert"
+	"revert",
+	"noop"
 };
 
 static const char *command_to_string(const enum todo_command command)
@@ -916,6 +918,14 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
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
@@ -924,6 +934,13 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
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
@@ -1277,7 +1294,12 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 		struct todo_item *item = todo_list->items + todo_list->current;
 		if (save_todo(todo_list, opts))
 			return -1;
-		res = do_pick_commit(item->command, item->commit, opts);
+		if (item->command <= TODO_REVERT)
+			res = do_pick_commit(item->command, item->commit,
+					opts);
+		else if (item->command != TODO_NOOP)
+			return error("Unknown command %d", item->command);
+
 		todo_list->current++;
 		if (res)
 			return res;
-- 
2.10.0.rc2.102.g5c102ec


