Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4DA5205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755901AbdABPey (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:34:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:63471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755749AbdABPex (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:34:53 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvDpe-1cWM9e2kHS-010PUo; Mon, 02
 Jan 2017 16:34:36 +0100
Date:   Mon, 2 Jan 2017 16:34:34 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 29/38] sequencer (rebase -i): implement the 'drop'
 command
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <d9cf36422193fc9bd97fe7a0cccb7bf5eda93002.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tOl0ytxso8kZxSUNcroylzVG3mc5I1SVqVpHKib4NOR0v99Lrrg
 9Bp22slVjfI+Oj+zqiyhkxWBXTFmozQBS4N2wVNPxScPahrKBbEnyvQWikezcw5hayb3LJC
 C5jWcNvPDTitnaw9VnGQs7oRkNjsts8arjJ/kCrW2TyZ+iiYyAGcgzv4f9QCNp/wUHUWKZ8
 Nxie60+pTjSX/s1sP/jgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aNJuEZA9biQ=:xSeVKLRtpjM4xWTmGPtxPl
 ZjletDBpnzNyjKAyXj5rF5WiVa9VXCQqAkKNCha/rMaowu4LGCg5Bq1cSVXSZoIOs3A9ICLKu
 1C3HYAFox1k680268BgdFrygzV9INurpBTBZ8QZBmfP6S4B/mWTN62JthEa1oI8THTtdZBa+c
 y2eu0rtYpV01qH7Du8gte0MreGczkgzKB2hsUjOVPOT2mJg4p6hmjHZBo3LWfsVkcB4BSeDM4
 mKo2/FquYCyjNaQL6DxeWoIkUB/vdzNCZFaMCC46TisIu4sX8mg4Mu26a8kBWxUuhbij2G2j0
 JxJMwyd6/vjZHdJ5lDJcQPd3X8oC9tTdRx3nFDLFb5B59vrJRBTMy56mXmbzVjoX8u/yHJ3l1
 wWbyzauFS0i0lVY3aTu8i9AQhwx0MguGZx9ggol2oFeLZf9GmUJbbUw3I3yHGNDmG8W5ta4WJ
 zTyhN/nJtGzpDdbjO2o7gmnLvmkskmq9livvpgQ1ACGXRtff5t4tFQpfHJcZgqODp0MnWFePH
 dRlLUj7LrxY1SdGYDS+BSysvM0FoGh4vtROzix6VH7UhQp60KqHTJqsOyefyXdrh9pJqT+tWa
 /CWtnhy2qHhDb3RkUWXST/CxU9GYnZ2a3hxfQAYeE06RlYwyhsazx+0Jwd8fmnIqqKw34xZES
 XUyh+0OBOGSIQHCeR16y6Ua0sZ3xZM5a9ITq22onv1nJptCADbJQyFCHin9NB+fr1BJZLYl2a
 w09RvAtBOVmpzz2NvsC1bPC9xIRS3xnxwPu5SnadyE/ZBF4gk8wdY0tCQtQT9iEkiB3CcrdN8
 ytgov1p
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The parsing part of a 'drop' command is almost identical to parsing a
'pick', while the operation is the same as that of a 'noop'.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index dd5b843a84..6e92f186ae 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -736,7 +736,8 @@ enum todo_command {
 	/* commands that do something else than handling a single commit */
 	TODO_EXEC,
 	/* commands that do nothing but are counted for reporting progress */
-	TODO_NOOP
+	TODO_NOOP,
+	TODO_DROP
 };
 
 static struct {
@@ -750,7 +751,8 @@ static struct {
 	{ 'f', "fixup" },
 	{ 's', "squash" },
 	{ 'x', "exec" },
-	{ 0,   "noop" }
+	{ 0,   "noop" },
+	{ 'd', "drop" }
 };
 
 static const char *command_to_string(const enum todo_command command)
@@ -762,7 +764,7 @@ static const char *command_to_string(const enum todo_command command)
 
 static int is_noop(const enum todo_command command)
 {
-	return TODO_NOOP <= (size_t)command;
+	return TODO_NOOP <= command;
 }
 
 static int is_fixup(enum todo_command command)
-- 
2.11.0.rc3.windows.1


