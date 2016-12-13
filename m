Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452C72042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934200AbcLMPcY (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:54821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934077AbcLMPcA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:32:00 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXqV1-1c5dIC0HXr-00WpS5; Tue, 13
 Dec 2016 16:31:55 +0100
Date:   Tue, 13 Dec 2016 16:31:54 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 26/34] sequencer (rebase -i): implement the 'drop'
 command
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <ed2df6cecd9a53681d2fead4ae5b4839d653afc3.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pKniW2CmEABWhmekO05pujb50VhoHBELC5WVVRmXAkNDfS7xpH9
 j9gibW8GCSL+UFVa+V2MXzxwrAAivZBuLWJnIkZrH+Zl9HBuF7s1NuzhB1AqRQJBWmHCthc
 8xLmeCDPiTcSD/rqyxD4434oNZw2Yj9wx9R55t2LFI2Z0AeX+DiwrndsvF44zG3P8+YfADw
 tpUY8oC4VSCkg3d4gp6Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a/gaYlfe/dM=:3gmVwgEu0m425IgzmMVJlK
 xpUuzIgJkwKXD2GJeUz7t8G6Bw8xiXEBGc/k23j2EnNjN5EifhRhOouOYB/kI6R8+kHd3rLyB
 IFp1mDP4rTRpJm8KnIe4CmJG7G+SWZXEoL/1WsYPKfg3Yh3n306LSK+3Jq6lMQIX4fREAxgkh
 5oaFZ2FJ82d5QqSqrUq9ejLlltvdULienXk+REO/fYDyhR3VOhHzBrPcYzvgDHVicl5ZPV4Rg
 6qCd2UaeQHOI5FOMrlNy8wHAsLYMainfBVwa2hWeIBnPxAYmUZH0J/inO85aBig9XbxD6WRkA
 YLyDary73iEhjbRjogh2MxckfzkG/IkcKWl5xMu6QUGPwxFMX3brLXVBZxd71jqReY6BLajnt
 v7RsDndXJycdy+s6Uxa3ifjnWUR9u0GfvZUSWnwfznCaWGNgasoKoe1yvadfZMPcfnzKIw9mG
 ncUtKdQJH3Icq7NptMG8ptgrRP2T21iUDujj3xFlDhgUl7/saPPkzSqW1/3+PBIAqGqlzwYu7
 aWzX+qp/j/0+4Hk0Cx67fGieb5yYi2PGoYL1xhxxpXCeNsxPS9hTi5EhJ6tVVT52Dcszlu/f4
 Th/x+Sdh+mwFGoD2bNnmdPy8d+xS3oOiTiEwlrVLUTdgXBgEmaq1cec3fUrEL7QtlI7WxF88n
 nF+XtzLRmogdOFWzkiF7Twk9YEVQi7one8liFZdIbFhexiJ+IHxtTbAyPh92Eij2prZdKo+Xz
 drJC5WvDft99mQjq+6MgyeRVi+CBl398nUeB4emQXjD6GPnPnYPnAh5spBGHpjNLm/BGojKO/
 MMqeHgk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parsing part of a 'drop' command is almost identical to parsing a
'pick', while the operation is the same as that of a 'noop'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 03256b5b1d..1f314b2743 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -769,7 +769,8 @@ enum todo_command {
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
 	/* commands that do nothing but are counted for reporting progress */
-	TODO_NOOP
+	TODO_NOOP,
+	TODO_DROP
 };
 
 static struct {
@@ -783,7 +784,8 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
-	{ 0,   "noop" }
+	{ 0,   "noop" },
+	{ 'd', "drop" }
 };
 
 static const char *command_to_string(const enum todo_command command)
@@ -1317,7 +1319,7 @@ static int parse_insn_buffer(char *buf, struct todo_list *todo_list)
 		else if (is_fixup(item->command))
 			return error(_("cannot '%s' without a previous commit"),
 				command_to_string(item->command));
-		else if (item->command != TODO_NOOP)
+		else if (item->command < TODO_NOOP)
 			fixup_okay = 1;
 	}
 
@@ -1827,7 +1829,7 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	int i;
 
 	for (i = todo_list->current + offset; i < todo_list->nr; i++)
-		if (todo_list->items[i].command != TODO_NOOP)
+		if (todo_list->items[i].command < TODO_NOOP)
 			return todo_list->items[i].command;
 
 	return -1;
@@ -1960,7 +1962,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			res = do_exec(item->arg);
 			*end_of_arg = saved;
 		}
-		else if (item->command != TODO_NOOP)
+		else if (item->command < TODO_NOOP)
 			return error(_("unknown command %d"), item->command);
 
 		todo_list->current++;
-- 
2.11.0.rc3.windows.1


