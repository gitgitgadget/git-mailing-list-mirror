Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBE3A206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 15:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934223AbcLMPc6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:32:58 -0500
Received: from mout.gmx.net ([212.227.15.18]:52633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933848AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MA9Yv-1cS8nF1F3x-00BKPO; Tue, 13
 Dec 2016 16:31:16 +0100
Date:   Tue, 13 Dec 2016 16:31:15 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 16/34] sequencer (rebase -i): implement the 'reword'
 command
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <61b34aad6bd063957afc974f3f484cfaf24a3213.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:TL9v/otWvYIVhjPj52lTTT7K8ntaasXOjzYULxEWZdSQnjsGDA1
 35dMH60EAavjP2kGkm6X4XLCD8tS1Vh3XXxdVMupQ3Lfo5r+HQZr4jjjeCBjz5k8IjUKCTx
 o9ufcMVAk6ErkElQctnzAcVgbgUesb9EOsFobzOdDVeHImLyfvYdGufZBGtJzjMYBIpTxdK
 pKJodFmByzxEFWrOpmZmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T1lOggIcc1E=:Dkq9mPaCweXTHbO1hfRYXS
 HpRlbxZQd7E/Vm85tybWjPcME+4S7SpxJw/iCaKtqZdL9XAc8dde5u2lQboS5hZleoi2U1bzl
 Up2J3ROwdgiOc8fISR/HtAdY+hjElhIpSvrrL0c5/JfW8HSGKbUxZ+SOpTvFOExe3A8ru0uD/
 F1nzXjLKI0mzkWVStrxvHRJSOuThZTkRURC3DHt3yoMMUuZUfB75XDIBONJ6L9FXf1W5t1eMZ
 pFYxW/6z6QYYdjkrAXpJKQp9wN55UDl5MCUz0WO1DDpeRdOieHmYoG6azDueByk9ZvLaz7MB4
 +ZhXxHhkp9XqvdHib0j8evhqF/xjEjFnd5IU+h2KglEunEKrH38tY4Kd0lxI5BqcuIdZyRk1F
 sxGRIVK+QMGqiv0Vyoc2y+RF49TXapc/rADtFWiVTPo4hiFZ2ultIetT/Yq2qkKKRyv8dfoqq
 fExs0abTkTQLBmw9XW+7MprpqJNre24ncK6EQdkvLTU9fzUat/nWRkdQ1u49KtNPmzwfizZX8
 Yg3TBNGh85r1+pymDzL/kiOR8cw4bnDeVlYCcLsbwrJ+uGQxRHPYOX6ZrZOlN921IPxDCjZIk
 NxBzGHkKnHzQRiNxwMdUSvoNF3kPB3dd7uOHYDW6gTzcl7g/Wz31JJ+BzJfB5Wfy7IISlqra7
 CPw4Y/r72XxGfCE4k27I9IOWRg2bvQPKS0jN8DM/OHW8JYoW/FFjJiJRe8eIssQRAxeSEgO22
 jk5ab7aKB4Rh0l1rFrC3rxIMMirgvbCPjbyPHCwhfBQyp8GXbZIcCp3FSjsQjFBzSsvvBptUY
 kr1c7ae
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
index 4361fe0e94..5a9972fec3 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -751,6 +751,7 @@ enum todo_command {
 	TODO_PICK = 0,
 	TODO_REVERT,
 	TODO_EDIT,
+	TODO_REWORD,
 	TODO_FIXUP,
 	TODO_SQUASH,
 	/* commands that do something else than handling a single commit */
@@ -766,6 +767,7 @@ static struct {
 	{ 'p', "pick" },
 	{ 0,   "revert" },
 	{ 'e', "edit" },
+	{ 'r', "reword" },
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
@@ -1001,7 +1003,9 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		}
 	}
 
-	if (is_fixup(command)) {
+	if (command == TODO_REWORD)
+		edit = 1;
+	else if (is_fixup(command)) {
 		if (update_squash_messages(command, commit, opts))
 			return -1;
 		amend = 1;
@@ -1779,7 +1783,8 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			}
 			else if (res && is_rebase_i(opts))
 				return res | error_with_patch(item->commit,
-					item->arg, item->arg_len, opts, res, 0);
+					item->arg, item->arg_len, opts, res,
+					item->command == TODO_REWORD);
 		}
 		else if (item->command == TODO_EXEC) {
 			char *end_of_arg = (char *)(item->arg + item->arg_len);
-- 
2.11.0.rc3.windows.1


