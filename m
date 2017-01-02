Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F03205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756346AbdABP2S (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:28:18 -0500
Received: from mout.gmx.net ([212.227.17.22]:57965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756337AbdABP2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:28:16 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJngW-1cPAzW3XEq-0017l8; Mon, 02
 Jan 2017 16:28:03 +0100
Date:   Mon, 2 Jan 2017 16:28:00 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 19/38] sequencer (rebase -i): implement the 'reword'
 command
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <ee15745b9c587de8816e3bdfebcf89e7962ee113.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IbxukaqOEOrVrOLBQ7t+Vzu84FmxbxLqtWPGfVYXzpX466S0lTG
 6iCZO/2Y9dkeUCmHLnPNqSGo3HZ4eLGiPopzK7dkOYx3qRnaMFRp3umzvRFx1nVSSZZVWE2
 5krqPywxBDVIAIxagCvI9Hdasl1e82sxg78BeELdyN36v/t+8Mfy3lZ1RxD3eYfkPk5GQD6
 dGpRNMEX/gTjkUlgFN7YA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DQ6UBPXmcYg=:hmOjgDn+SI8SabPlJKodGn
 8rzfBxPv64vRCPKQMb1idIFCQduIKa7hMs5h8xzp20/S9mkuXwsDy3Inh33ZID/SreZC5nmRO
 pF3Bz4l+LUyku2KRoBk/cNzP9TANscxvWt5h1l6wg60wZnQADMmHeLf2Y2Q0BtU6pQBDnGheo
 yT4VyNqJ/q2rNbtQvV4IFztBh6lWrxV4QkU6NZU2J8kgMQehDE2U92vG/MvBqW6vOk/njK1/6
 LJa8FbNWWKtb6sfWysVTubdFE0db4H7d4BD8c2nl2l4Yb4EHTHtUQb9ScJqp/bQ4GTgszs+DY
 i0hh6lGk3mOQSu/rPdJByKak9OxHssDMOkqD6KPjvLNRVpqe/Bou4JSL0o4Q0oqBkt31HTTR7
 mYj41KByZV1Pf55cNgJpq0Oubz8JN2VacD0gAqhn6DFuEZg2yaH3wgH56RUrFy4r+1+Ba+lmj
 6epJm/3RCZgIRoezQIAKV0YRoUsEKh6syCCd7hQx9QzifnCMZxJxlvstCNsK2Upk0Uvz0jyKv
 1i/9XpaQlEf5IyrRJ4knLR93SeJlQuU1FHk0yHekSKRsUfmwhKOx8FiwChFVp+tT3lsf2v7W7
 LTgFptgudslBZz2apeGTiHs+sNw6FDTcAs5kmhaXyLOh/b8zjQgVhZ8+lCTtQ+UMuo+bUGTAt
 1gSZSiYh9MXPyEis5gVtvOMzxEcKLZl9SCuVlAKqthP+uXr6oviUMbVAutWpVsD3fEFgD8Xef
 /LzcKMrMhf024KDJ7MRAGDIkVr9fIFltGU7UnaZ6gFVh8moJcnRCJn/TjCG/+MO3VbSwqcCin
 uQxnoZlJRV1L8mzA6qiHnaHa1kf5Ae/i/ahMqpCGY3yafBKYiAyHKdaEFId4xGO5CMN6xZjJH
 DuNfVBLrrtQcM6UAieP3GZWMiod+ebn43Igv5Efqzus/Jy/h1OC+xcVTaIW3Q8z2NodyrMlK4
 I0O3FVpq7Fio4XZ2OmY5NYK1zt0U643IGkYdQTOzy5L8lVO7HQ462A8LJpM86wOsquv2Dr6/9
 q2OgMY5kkEFAAZjVHn9UDy4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is now trivial, as all the building blocks are in place: all we need
to do is to flip the "edit" switch when committing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a2002f1c12..50e998acc4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -718,6 +718,7 @@ enum todo_command {
 	TODO_PICK = 0,
 	TODO_REVERT,
 	TODO_EDIT,
+	TODO_REWORD,
 	TODO_FIXUP,
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
@@ -733,6 +734,7 @@ static struct {
 	{ 'p', "pick" },
 	{ 0,   "revert" },
 	{ 'e', "edit" },
+	{ 'r', "reword" },
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
@@ -962,7 +964,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
-	if (is_fixup(command)) {
+	if (command == TODO_REWORD)
+		edit = 1;
+	else if (is_fixup(command)) {
 		if (update_squash_messages(command, commit, opts))
 			return -1;
 		amend = 1;
@@ -1771,7 +1775,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 					item->arg_len, item->arg);
 			} else if (res && is_rebase_i(opts))
 				return res | error_with_patch(item->commit,
-					item->arg, item->arg_len, opts, res, 0);
+					item->arg, item->arg_len, opts, res,
+					item->command == TODO_REWORD);
 		} else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
 			int saved = *end_of_arg;
-- 
2.11.0.rc3.windows.1


