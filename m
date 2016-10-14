Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 769851F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932554AbcJNNS5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:18:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:49241 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932432AbcJNNSl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:41 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MPlsg-1bzy49058E-004xpO; Fri, 14 Oct 2016 15:18:35
 +0200
Date:   Fri, 14 Oct 2016 15:18:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 19/25] sequencer: left-trim lines read from the script
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <fab86d51e987682061bdeec75d1fcff832f970eb.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Y5bdm9AzA1Hwt7GFrYt3nz7Y2+mfqwNUeUbr4eCGaGKgr9pQ1G6
 vW4UvO1aRW9jBSsngV+SXdcJ3iv4OFbXhnPhYCKbv95+gQ6hVbbtT6HeAQ9XKiZiYs2xo0k
 x5F8L5QUiDviXLgYWEY6we9yl6px6H5qpscBr2cUVf6D3CXTeqvXOLkKJXVxrOmtpTRCYUn
 IG/f279krnEM4QLeZEcEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WeP/JaAM7WA=:8idB1EI7minH4KomA/Cgih
 669vtwekkA0ajWawBplLjBqxVIOp87IpoSXRbtKuJFS1b4CFh8T+cRzx//hWerObQ/NCp1j13
 +64bryZUGRqcbgCDNTTfAeGnQtTpQZ42n2ZaoGTRdtnAn9+C6qvOIibPSwDSevT2C8RCGYfYv
 40ZGJS/8kCLOpIcJBx/gE4OiPv23ZnYFin2ZE65Xt/BKQUsJGJQs/4q4oDSfIb7orKKofjc9Q
 NFp7fKCJjIijPqutfQgWUf3z1PTF3SQPLHo6tSVZdrtimldyU/7/HPjFD+rfLLw392zVZDgxT
 m+EjSe37dERp8HWX8AowgqkqQUS1E2U0tQsUIoX8gcgYnNhyoelNJ0Zxlw4gouxgM+Jokffzt
 S5Sl/5y+wpIkOC4/cmffZiLTZkqgu0YCpKRtRu+VaS7UEuHhmmhmUxEBwnt4aoTVQXDaZTV8w
 XGc8gWpmDumQiqIkBEFNicafIYmbkeDCNomrxloC9MXtSdiLpzzZ5yz7PNAZ6Yebu5FhRHZqg
 6L73K6fuRevYMv4k9OhCTkNd0Re569QybGQ6XYw5TzioRSy/aBSRDddMlL0X9BKp99rBQaTnt
 iQikf2KcLXd9lNyov1TDdf0Tm75Q/XmtO/Z9F2btgsj95V8H6b96hvuY7AhQXti34IBzZTm0+
 LRO66mi80dh1bzrXrAz5E3rLJ395RfB5b0M1Dj9GCjsePkx8P+S676LdEL0qc8frVrCuMHBJA
 Qe1Z/xV1fA4iSfa2wlqHCbroX3sAtK/FYPzbQcZDMT9G8QQl+juGvtLnm4OZvisqGrVK2hZx5
 vDt99xJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interactive rebase's scripts may be indented; we need to handle this
case, too, now that we prepare the sequencer to process interactive
rebases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 9ffc090..914a576 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -871,6 +871,9 @@ static int parse_insn_line(struct todo_item *item, const char *bol, char *eol)
 	char *end_of_object_name;
 	int i, saved, status, padding;
 
+	/* left-trim */
+	bol += strspn(bol, " \t");
+
 	for (i = 0; i < ARRAY_SIZE(todo_command_strings); i++)
 		if (skip_prefix(bol, todo_command_strings[i], &bol)) {
 			item->command = i;
-- 
2.10.1.513.g00ef6dd


