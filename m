Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C25E201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424394AbdKRSH3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:07:29 -0500
Received: from mout.web.de ([212.227.17.11]:50962 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423099AbdKRSH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:07:28 -0500
Received: from [192.168.178.36] ([91.20.49.242]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MHowb-1eJhUX1BvR-003dtv; Sat, 18
 Nov 2017 19:07:16 +0100
Subject: [PATCH 5/6] grep: update boundary variable for pre-context
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <265400ac-ff2a-4a3f-795c-53f0274e8c7a@web.de>
Date:   Sat, 18 Nov 2017 19:07:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <790c2344-a71e-7089-9000-f9b37a4a5cd9@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hehwkzSiUGe99SKC/cDuSjOZHzMkqXkcSjB0L3jRMm3N5vqvH/m
 Ze2Yv9XKNwVQmM0BIqd3nye0bxqFkGPO4Gbp6Zu8UAINnvTxYgGCV15ZZd5zAn1sT7ZEPw0
 7Fp6hJOn766WjHji5qEfWW932yRD5+7ihgsQZoiI7BCjKSQG+QBhFWDf5RI8GNZPrmheTqP
 lM9RE/a5jxkhJo2YM/fbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Tup3WEMKSWM=:XNarxVUeJgzgVbnN0xXhEx
 EX5NLbFZ/8IjfryAgxneqqBhITw68R/HwAju+ISgChfzM8ZCfqHJeS+0zSG8YqzcffVk1oCF7
 +rEhpBAGz7yheyl6CZg0k76++T/3EzKnpoJ/5u/bfoLUHqCibiC0a+WtjObfFF+asd6gM1pJk
 xxe1a7CHA07hLAtJaRRyouYN3IigVFGNxNJpyp9IK8eSr0hhoabdt0vwxxafQS28U9sJY5qMa
 IaUR4bK15KUNTzoh86hLLzhGgTLSvpo9KBWuzlhepqgJ9GAuL+9+y7OBxnlltgisb1toYLChe
 ZaQqRTTu2oBT4Xm5OVYpurDJmoNF5w1l3WfHWc92Fejk51wV7Q1JWSS7vIu3H3pm2+oaQY7mt
 kyAR+giIkJFo7+ulCmdiaQrihIt5TXKInPRtdhfPHJpjxlePQoo6mu465kecY/GH6dL81riWg
 zhTMMGGsceR6VEGeaWqpLddYsbrB/uzkkFaeVAf0/jup9d1wHNQ1nbbb0EacRJ8Hqkb1w7FUj
 KEEmhFg804bVV+gL6J2qTt0CXw8MlkBEpOE2m0UlW+27bvr3k/GUWW9HPcmjsiPwG/1ab73sz
 qZjP5AFVMcu3xulbO46RMMEqRfPfwMvzDkHjrUJ3kFtdynbvGM9xUExUCNZ+fivoySVk/zJIY
 Ia6F8yKDNDOKhekIBIQv5GkS/jZD7L/DJyICTFxAiZYsZELFelPOQMcROTsGE/Ri0lbQmq+gI
 cZn8707CPopSp2VgBN1R+LvAAehJQlvSrEnUM8Fsut4qm1GZuzpEmnT5FCY4erpmCpd4CdBnK
 yd9sG9NKwJWAylhC1n4/OyHQRMdYuhYg/PnnSo7kIuR9b2Kbj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Function context can be bigger than -A/-B/-C context.  To find the
beginning of the combined context we search backwards.  Currently we
check at each loop iteration what we're looking for and determine the
effective upper boundary based on that.

Simplify this a bit by setting the variable "from" to the lowest unshown
line number up front if we're looking for a function line and set it
back to the required -B/-C context line number when we find one.  This
prepares the ground for the next patch; no functional change intended.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 grep.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/grep.c b/grep.c
index d0b9b6cdfa..2c55d10c55 100644
--- a/grep.c
+++ b/grep.c
@@ -1479,20 +1479,21 @@ static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
 static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 			     char *bol, char *end, unsigned lno)
 {
-	unsigned cur = lno, from = 1, funcname_lno = 0;
+	unsigned cur = lno, from = 1, funcname_lno = 0, orig_from;
 	int funcname_needed = !!opt->funcname;
 
-	if (opt->funcbody && !match_funcname(opt, gs, bol, end))
-		funcname_needed = 2;
-
 	if (opt->pre_context < lno)
 		from = lno - opt->pre_context;
 	if (from <= opt->last_shown)
 		from = opt->last_shown + 1;
+	orig_from = from;
+	if (opt->funcbody && !match_funcname(opt, gs, bol, end)) {
+		funcname_needed = 1;
+		from = opt->last_shown + 1;
+	}
 
 	/* Rewind. */
-	while (bol > gs->buf &&
-	       cur > (funcname_needed == 2 ? opt->last_shown + 1 : from)) {
+	while (bol > gs->buf && cur > from) {
 		char *eol = --bol;
 
 		while (bol > gs->buf && bol[-1] != '\n')
@@ -1501,6 +1502,7 @@ static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 		if (funcname_needed && match_funcname(opt, gs, bol, eol)) {
 			funcname_lno = cur;
 			funcname_needed = 0;
+			from = orig_from;
 		}
 	}
 
-- 
2.15.0
