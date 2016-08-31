Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5311A1F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933887AbcHaI4P (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:59307 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758970AbcHaI4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:56:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LvPgd-1awi5L1zf9-010gsM; Wed, 31 Aug 2016 10:56:08
 +0200
Date:   Wed, 31 Aug 2016 10:56:07 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 27/34] sequencer (rebase -i): differentiate between comments
 and 'noop'
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <736bcb8e860c876e32e8f89f68b0b901abedc187.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:z7Dun4l4zc5CJUIWESQ74U7pGMjquGfqIRizkq3iHcRGpcjx2AF
 OoaWJ8aOfuPHtolxqi4kzFncWJbJKJjmMkIlmg/zHMDLSMxqea7gcJl+l4cWeta98epSjDc
 nTUjURXTMlbExbDrSho0u6fvB234Jc1F2EexqF6v7y0HSK9idBKVKltGzJrH7/lLc2B3iRC
 FDj1MksssJmrQqo6HGppg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vax/kHPjYqQ=:tVesPohp3pEsLrF+asa4MU
 CSJ2aMbpu2XgX6J0kr7yNBcBbcVCiDWqSmZrBvfITF7egwJ1byztvimqBcXKNhIrZ3EVdoF5b
 x1zAvVUDTyU4vdemk68EVzRokaFuQPJbmFNV/C5lKMrSvyS+QBwJrVjGrzzOtLM3GJ7Bpl7Ur
 pTQEg5wl5xNT8CcbciGxwb6yjbtbN8vhhwqg2ON7IpZ0SNl9nrrVPpc8uC4YKSezylLb6Cz0f
 aFG2nse5T0NLXfuvR7h2cjeYYwP3K6h3rGcijSoLObfEP939ro6ZThwbbPHf4LFRnYPkDXhAE
 BJpZPWra9nobwvxZ+tUQPkn9BM+9xTnMe8KL1QLxDQwR7/Yl9RyyCVLqDMa8kV58HEMkhxy05
 YIBe19gR6B4aYpJkJ3cD35LNuTzEOOPQY5HZRkgpXxL8ocBaP5SNqbC2vh+nunvRyzKzEO03E
 oPRM4HwuZCOr837ZowTsMlyRA4/ZU4Lc6qZWIRCyQtetQhPHjoxmyia4AhxiaeQt9WRCYIDyI
 XATWZKe/IRO0Z+cb8enGNP77vnRwdAwAy4fL7mNTAYLvWsxDV8fHjUjSDHwg4NapycdfrVZ2q
 MHWMWv01IwXP0rnZZ+SxbyoYlZGgUr/+9lX4PVdP1SUakm2S6cS6mS3YDj9Mx9fKSpl9nKIMA
 S0MSqXpIOtYhQAMVBhubKuLRhQHkgNdGTfihylmh3y9IdZIq2CQw+CpOk3R+LQVdCJuf8Mz9l
 nX8f+9LwsVS9M1lJz1L9Wgqn0G13vR2SjdodRBnkNCrA7IJLAy59WCqqc9GGHqrRNuZfLMmNU
 9KGNYcW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming patch, we will support rebase -i's progress
reporting. The progress skips comments but counts 'noop's.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 51c2f76..4c902e5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -763,7 +763,8 @@ enum todo_command {
 	TODO_SQUASH,
 	TODO_EXEC,
 	TODO_NOOP,
-	TODO_DROP
+	TODO_DROP,
+	TODO_COMMENT
 };
 
 static struct {
@@ -778,12 +779,13 @@ static struct {
 	{ 's', "squash" },
 	{ 'x', "exec" },
 	{ 0,   "noop" },
-	{ 'd', "drop" }
+	{ 'd', "drop" },
+	{ 0,   NULL }
 };
 
 static const char *command_to_string(const enum todo_command command)
 {
-	if (command < ARRAY_SIZE(todo_command_info))
+	if (command < TODO_COMMENT)
 		return todo_command_info[command].str;
 	die("Unknown command: %d", command);
 }
@@ -1235,14 +1237,14 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
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
@@ -1252,7 +1254,7 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 			item->command = i;
 			break;
 		}
-	if (i >= ARRAY_SIZE(todo_command_info))
+	if (i >= TODO_COMMENT)
 		return -1;
 
 	if (item->command == TODO_NOOP) {
-- 
2.10.0.rc2.102.g5c102ec


