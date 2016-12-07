Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E6311FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbcLGVwD (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:52:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:49245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932987AbcLGVwC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:52:02 -0500
Received: from fermat.fritz.box ([92.76.239.239]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvhC4-1ciQc43mge-017Y0U; Wed, 07
 Dec 2016 22:51:57 +0100
From:   Stephan Beyer <s-beyer@gmx.net>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] am: Change safe_to_abort()'s not rewinding error into a warning
Date:   Wed,  7 Dec 2016 22:51:30 +0100
Message-Id: <20161207215133.13433-2-s-beyer@gmx.net>
X-Mailer: git-send-email 2.11.0.27.g4eed97c
In-Reply-To: <20161207215133.13433-1-s-beyer@gmx.net>
References: <20161207215133.13433-1-s-beyer@gmx.net>
In-Reply-To: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:mKB38JLN+41OF+x1IHo5u1gPjzZT3Zle0FIrFMUbT7mumnte9aL
 vhPDTI99iXvBXmPRX9tofWfnOffT51GpI81FaIRdxPxbgrJOQO6AQt+msy+OYR0pq+9Pqvo
 Rx43LRGyzRbRpHFQGDcwLcjuhWGj8k5FW4e+FRA8sD243f2CsxbumdZDy8QZee5cUdUK+hU
 DUiQVN+dgfetDA2CN5wow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iRi0id3Xs9E=:MBpowAwqglELrnuqZthuib
 +Ty+/ukD+m36rGTRHJ5nV1zHHYONifFDw33uvN9jnXJ3zD2irVHUIoA5l9HmanhWBEnuEmkhF
 WXe/5XIEmcHpGLYwk57eVJRupjEKSLQYbtGUwK7RSKxwvHGM7PBLwl0S6UIejFIk5v45pb0nv
 ZmYiEtcOMF7hD3Yo27IaRPjfsBLIw2J74jxinNcTUPcQ0z8Torrt2HE/gKk87Lxw3trS2yXdS
 v/tvgfBLuDvfLs8ew0DpWoZJ3nC5ZiYAwSIEdUdcMqoOd7tP9M95RhUCXQNsLA9SryZvi+cKT
 evovqhZ0rPOrtoS6hcg0ZbxmBuHkExIf5sFpIjQnVaItxiNJS7+etF1qzrq+Xr/dQ1ziE1lOK
 zvLaZbQdjWVGJSSYR88DsvHkP6FM3gXazmzhmh9Pk6nN1HNxruDHssUTRRLIltEBJunU+X7TA
 Swwk4XnjzBr4rP6jmEsklu2sEeYZn3ikjp3fW6BXKYThpuY7fsnFmY6MjNO74yXqCjNJJdYsX
 KUOwnk09Waq5fkkFrLApu6qkBH6wtLynhYFn92LLyDVsn2giFhE7rLVbyQMgFhvtFChOUyn/8
 dnHNGeftXTFaofhjPed8y50jjd4lsAQ99xYdVm9YyHcWqWugMGHnx2gv46OW8hKjyu7XUt5XA
 O6gc/M3siR8k/XE9NA4AXr9GIIk3zenFJtRyRWfvBiVlngva4fmVbrSrBeua7TtnWOVZCwE7w
 WhsDID+FodWKjSUNjIq6FySpHTy3zTZe0+N/CGLPx+8F2z+HWAbk9USkDMc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error message tells the user that something went terribly wrong
and the --abort could not be performed. But the --abort is performed,
only without rewinding. By simply changing the error into a warning,
we indicate the user that she must not try something like
"git am --abort --force", instead she just has to check the HEAD.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 builtin/am.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 7cf40e6f2..826f18ba1 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2134,7 +2134,7 @@ static int safe_to_abort(const struct am_state *state)
 	if (!oidcmp(&head, &abort_safety))
 		return 1;
 
-	error(_("You seem to have moved HEAD since the last 'am' failure.\n"
+	warning(_("You seem to have moved HEAD since the last 'am' failure.\n"
 		"Not rewinding to ORIG_HEAD"));
 
 	return 0;
-- 
2.11.0.27.g4eed97c

