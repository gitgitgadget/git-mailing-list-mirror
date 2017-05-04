Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A8B207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755479AbdEDN7E (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:59:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:52028 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755164AbdEDN5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:57:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMkgl-1d8kEN2QeN-008d5A; Thu, 04
 May 2017 15:57:48 +0200
Date:   Thu, 4 May 2017 15:57:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 17/25] fast-export: avoid leaking memory in handle_tag()
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <ab93a2585d08b972a567351957177049a130a339.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rKqLoMj8U3AwHHcxdkT1WnzoK9uKs0n/mc5RZUtrnr4cA7WQDT7
 WIYJIhL6FxYMQc7y0B9gh1fPi3M8kSmcZSsCjm6Qm3m3V37opS/uggjU3vfXnZa0BZOZsc/
 u71iIV2xis7NOxYnHQeqoaQ9bq414vbYs3zcW3+lflxyguTw+IS82/+lMXxB5KsX/NDJi8P
 ftTs6affQ0Vzf67aD3q7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KCpQccFywIs=:MahFYGsMd2NSycyyBWSuNP
 xeJhqbfPLuSgOkWfnDcnJtSJMTG72jcXN04cnw/HncQob6uobiuSq3301FWjtays63RFlmmF9
 pMpZVVoU9pRS1p2uSocahjc5qVnWAdmCSdEnMxVQI5qEhxKYerCZ1/8ujWXYZknNamWWayUCv
 EfDxEFvomiPjm6/0U8+WeqM/VtQhYDoD5Ucc96DtEiBQy1YD6LgZqb2C2OZtLkPMdpKSecGB6
 yu7q0m/1GhpFq7ozXnFOevx9kmDgJHitMyH/5ocVGOPX7XBZZ/6VzS7NFdSX2ffDsQYwgTwCk
 VFexWwfK7ydniCvzz7O4h9dF2XVVraes29jbAihfX9/DX3tKMxC68P8Z4KSS3l5+JcPd2kOlP
 zyL6UpEregqSmCLeWw1gdgi9fH5JQmkvg6GcgYVSE2Q4uyg+Layn4sukJYgHfLwOukA3PNrn6
 FUfa5ztN8R/lQdADs8bZb8YrN+c2sJYxNV0Z+LLvrZFOsvstV8vNyr0JHJm4CJaXpl4M6hMC6
 2BX6NCZOIhLaSVacCH+jj6BtujVbnVXmqUh4NAqkDc3K2x3k6JOR2qsR4dvLlFZ8nYKaLO1uL
 oJRZMF8unUnotcbov7P78xpkI6vARe9PRivYDkz7fsTGp1mpslpq5T+gJgywZv5DoVLK/IlVy
 isyMH3KMcjzpJrfsNUopgr37WPD0bvb9v7rVk7iJruXskii+SNuRxONovX/bc3DOLyAbkdR2c
 oZvqCwI0pLZrl0ylHx9vLuCxdisYp0bp+duEYCWUGJoPggCk1tiSFMWVk2FHiUXFVEQJXvo5H
 lm7wIV9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by, you guessed it, Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e0220630d00..64617ad8e36 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -734,6 +734,7 @@ static void handle_tag(const char *name, struct tag *tag)
 			     oid_to_hex(&tag->object.oid));
 		case DROP:
 			/* Ignore this tag altogether */
+			free(buf);
 			return;
 		case REWRITE:
 			if (tagged->type != OBJ_COMMIT) {
@@ -765,6 +766,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
+	free(buf);
 }
 
 static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
-- 
2.12.2.windows.2.800.gede8f145e06


