Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4878205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbdABPfC (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:35:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:64999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755749AbdABPfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:35:02 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsCdj-1cVXk015zT-013zQ7; Mon, 02
 Jan 2017 16:34:55 +0100
Date:   Mon, 2 Jan 2017 16:34:39 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 30/38] sequencer (rebase -i): differentiate between comments
 and 'noop'
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <fa764016c4fa4cbb78436eabe1e1bd0ee1766890.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:b2Yd32wlb225r5/H/YG296YXkLFdrf1XBvtSRSoQMpysDhuap3O
 TdH8xcmwf2pEjku0PQMRb1QhvvospzprRdMFeGDVOFjV4+GlM/dNZIaqKF7+KD3WCkMpDMf
 jWt4fJQ1M24xNMLJC6XBz/2MMI/Qz8pmX40pphyJCrF9zCfavXa4HJ7CId1smRJA3iIaX6C
 mpNMmnLPiCnM9WcZbC87Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fnM7SrJ/D/0=:cZc8PamA1BD/0HE4HeJzAV
 zqH7Seiw3GLFBqhmGKqsVUWJrZAhwb13SbvwQuON7tyM30pWSt7jZsqtmlIZQMN3tGBQn4Riy
 EFglDudDtGaKYd9W1+AvhU4Pu7J8ujKGsPGzqNzdmWkN8YbLSha1vKTcjtC3eErpxw+1CFhII
 O5UG296ASak6JwQhWPq/DKOgdbaYzMW9WOUwrSwt9cOIl+/Vw54Xy/NJDCO1/6SN//DcgkR0W
 O8wNJTFVgnQgkuJVmu0psBGZH9MIQzAFwgqgT2WeRR3XKUa09Ddup0kppNVdkWL4lrYRvZFP0
 vao+eHSnzfgumsLCKTSvzUQQSQcpjy/s5irs40E5bA/RzYx9iLr0qRS7SlqmH72iUhCNLdXs8
 cpKYllpzU64g2WrEwgeEFuAPEyeQB/mTr2KsRQ6lLEn3R9ljbkLNGUrmNGQEydjXi0NzBH9fH
 yybA8thcZZ81pFSrxnzEtdzq2TKmYQv0AODBBqiuY5YvZvSzMOTHZ8rNLTAHA7Q4ImwM5I+cG
 dAY4T1D2OauhBGE2USL1BQuIKDPsu1xqQJODMFlzOygNtWIsBaabHq0dnEkf7EcZ/Mh6uzH8+
 o8DUtxYgjOWCCYQgPR6iDZnyDKG73opK59iqfCCFyMKamD654lVB8xRub5EZmULVGkLQ/O3Cr
 Qr2YbeKMM+DJ5tUeV1gCe44kDClyvVYPusoIMJK8rGN2BIGHY8caZAzriVsVqGnXtOuFkAqW4
 x8H5pqzMWrHuAFHP4TQ5yOAIeNpmPstQj+EfJRR+ISx+Yu+eQjvYMjEpl8yGHuv7sq7jWGlfB
 FjQ4ow6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming patch, we will support rebase -i's progress
reporting. The progress skips comments but counts 'noop's.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6e92f186ae..41f80ea2c4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -737,7 +737,9 @@ enum todo_command {
 	TODO_EXEC,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
-	TODO_DROP
+	TODO_DROP,
+	/* comments (not counted for reporting progress) */
+	TODO_COMMENT
 };
 
 static struct {
@@ -752,12 +754,13 @@ static struct {
 	{ 's', "squash" },
 	{ 'x', "exec" },
 	{ 0,   "noop" },
-	{ 'd', "drop" }
+	{ 'd', "drop" },
+	{ 0,   NULL }
 };
 
 static const char *command_to_string(const enum todo_command command)
 {
-	if ((size_t)command < ARRAY_SIZE(todo_command_info))
+	if (command < TODO_COMMENT)
 		return todo_command_info[command].str;
 	die("Unknown command: %d", command);
 }
@@ -1198,14 +1201,14 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	bol += strspn(bol, " \t");
 
 	if (bol == eol || *bol == '\r' || *bol == comment_line_char) {
-		item->command = TODO_NOOP;
+		item->command = TODO_COMMENT;
 		item->commit = NULL;
 		item->arg = bol;
 		item->arg_len = eol - bol;
 		return 0;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(todo_command_info); i++)
+	for (i = 0; i < TODO_COMMENT; i++)
 		if (skip_prefix(bol, todo_command_info[i].str, &bol)) {
 			item->command = i;
 			break;
@@ -1214,7 +1217,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 			item->command = i;
 			break;
 		}
-	if (i >= ARRAY_SIZE(todo_command_info))
+	if (i >= TODO_COMMENT)
 		return -1;
 
 	if (item->command == TODO_NOOP) {
-- 
2.11.0.rc3.windows.1


