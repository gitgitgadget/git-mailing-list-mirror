Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 554982042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbcLMPcJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:49248 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933976AbcLMPcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:32:03 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MW9TR-1c6C3T0mBF-00XON5; Tue, 13
 Dec 2016 16:31:58 +0100
Date:   Tue, 13 Dec 2016 16:31:57 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 27/34] sequencer (rebase -i): differentiate between comments
 and 'noop'
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <b82347c627fd3b8a74827bc773a5df2d16c6dded.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VLvKUPoy3XkCYdO4Aus5BXkGNV+NrO05C7BOnb3IVRg+lTMwb19
 eG19MozcWhEqEgf4eTjEZivb1JSASNmGI7uSSgfDFQCXDLaxvigOH+CU0ejtSdosdFf+Eo0
 D+RixC12aaKA6Dg6jgHPcSa+esgbVF84+WU4MeZTFNbq+BFTqomtOwcwJs2iYko9uGY2W3K
 Rho/q17pvbAFQwUGfOy7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8tWxc8LmemM=:opIwIKpdOLnZiC2mDBZ5O/
 mlD+zJ43Rgy5sqASfvLC3/zFyH/LzN7FgvG3ka3mG9KGJ1S/L7rvH6LNSs0cg2xxbPKhku+Sf
 Zx/OLZSavUpjb0F4MlLUEA6lLRRtabX7BEchEDj1y7mWdtxq0QIFHy2A6oZhatJ6GzLAS98FI
 1Zvef8O5j107hB3SKOg5311qonNmX1FtQT8LrkeB6VaMNUzgYJjWUYKb6SiJJrXZ4PpvPOnsQ
 /p5eeItE6IYykwXv5c9t7rQmqBtize80v3Hhx0OoNydVUxgLkWqRmhj1BW9tlO3/kOJL6T5xp
 IQWeBvED3EgCfWDPjabDf3zmKOI3581tBrCtTt1DCF5QROh4JuYwu9ATYXQNuakjUKMRs2uxv
 kjbx9CVehSON0kbKpj5rCTt3UcOx2EJtCFsN3/Mp3dmIg3iKOIWb2GgR50Rw7WmYA3sVFNSrT
 F3DFlZWgcajZlmb5m6nC2eJu63s7wssd1uFUHpbgv1Q0PJcAxaUGOxic/PBzbE11t/0S09TGM
 N2V3P3ru3dehVoJCApcDAAWjYY6pmGRA5fbFdS7pLj/IUFCeFl31/lWLLLSON5J1F+/+SHPgm
 mv99Uj8H2QXyHaY+RghdKH1wMJ6/f7X1khMXVvFyfeBsuZYWgUYDPBs6nh7EsR0Fk0qGOAzgP
 lzCZkidJVuQaab5m0VBNqnBeY4R2Fv0XcOVgyyDydriSDtG6uZf3RKDiGUdjtJj2xwCdcMBuQ
 Q5pRVVR7n2vMwwm8/trCBuMNgkm4f2Slr56X7Zk5QPfT3w/sCPzWyNi5Ntq5yL09YL+SQTxiR
 BVUllb3
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
index 1f314b2743..63f6f25ced 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -770,7 +770,9 @@ enum todo_command {
 	TODO_EXEC,
 	/* commands that do nothing but are counted for reporting progress */
 	TODO_NOOP,
-	TODO_DROP
+	TODO_DROP,
+	/* comments (not counted for reporting progress) */
+	TODO_COMMENT
 };
 
 static struct {
@@ -785,12 +787,13 @@ static struct {
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
@@ -1237,14 +1240,14 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
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
@@ -1254,7 +1257,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 			item->command = i;
 			break;
 		}
-	if (i >= ARRAY_SIZE(todo_command_info))
+	if (i >= TODO_COMMENT)
 		return -1;
 
 	if (item->command == TODO_NOOP) {
-- 
2.11.0.rc3.windows.1


