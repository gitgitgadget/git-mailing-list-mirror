Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D5C207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755224AbdEDN6f (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:58:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:56175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755187AbdEDN6E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:58:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEFqW-1dHEYW0ddg-00FSYK; Thu, 04
 May 2017 15:57:56 +0200
Date:   Thu, 4 May 2017 15:57:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 18/25] receive-pack: plug memory leak in update()
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <92b72e03dc5d5b0f9609556dddae1ebd871ee26f.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Zd+IYMPK/CUMbUSYsDFp2fMVUa8ndL9nh2GMJbUUy6Np4lb/oQO
 pFFY93YSfAL9KxaJ8mrKvsgGTwdreIS38Nky8IFuLonSRHDQNdw0kxQl8Pn6aIcfirXhL/u
 FEnjUcPQpST6S7+6k6O6afWduEZNlC3IGJ6ksaf1XfkfYOuk4mP/9KGA9fsIImFsqibwj7K
 oLqjQ1GZr8NyizNXj77qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:axUUEpzJQUY=:af9vSiDxqP9lujU9hVkP8o
 7wpayFXss1n3HItgI/W3+OS5dnWteB7srKFsRRD9TNiolb0bYUAKqGgQife13+FbsA1q8ZbpT
 Ihwnb4aadDP8W6FahclseKp8mYBtI2P0wIFo4PnSD5Qk91YwXYoP0z8XzIwXbEx2/kYlFE5OL
 7UrkJd0IsFjS4O6YArLKFIFn+/MnZDfO0kEcI8vNQhluygPi2xehC/RKuehrBBPBjVR+seecW
 YHk+HEjDN3RyCLW185dFcL2oZ/dc1xn9msDg4bgcXrxmDGrNztMGflVsDzSpRSqDVQLjzPRe1
 1a1EoN8OYnsEI3T/FjmztzIaN+srHHPi4U3igIwMBiCuX9Ctvj/ai4J7KLZlcCrY9y0sWPS80
 ST1wWOwut3aJAyrQtI/M8rLm9vNnUOj5QXsX+SmUcUzc2gclCSCUhL4/MtwZKX5OL+KOqWtdq
 ZeJF1UoJa6+XJpdpWvhIQGwnjvry1tLss2wvvAG35Qcb1UMGo0Ff8pa1WAzEH3BehRN/xunvL
 5F86B5RUOCafl10FeTQuk6+TzQwtpNU0PgVn7RaaOSLWhf7ynxP+O0Tg0nol0KJNLOV3jDHzs
 iSxPLk3dBtAgbZHAiMppCEzgzMgOFppOpppKmk6htnlo9fz0W/q7ooKhm+3XYQaRdrY1ZEnsP
 9CabJI70e+Sn8waRMrB9id1Mp+RGWWv4hZ0xxS0EoN+lKrPtrBQ9Spu7sGpq/tZ7e8+xwRrxu
 Swat+nsx/tJ9BO/iMCFE7Fo3ibGxHNW8evGW8Ne+4rS43iUN4JUpX6VV8oR4S2Ts9iZLcaBrt
 b5dcwSY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/receive-pack.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f96834f42c9..48c07ddb659 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -986,7 +986,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
 	struct strbuf namespaced_name_buf = STRBUF_INIT;
-	const char *namespaced_name, *ret;
+	static char *namespaced_name;
+	const char *ret;
 	struct object_id *old_oid = &cmd->old_oid;
 	struct object_id *new_oid = &cmd->new_oid;
 
@@ -997,6 +998,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	}
 
 	strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
+	free(namespaced_name);
 	namespaced_name = strbuf_detach(&namespaced_name_buf, NULL);
 
 	if (is_ref_checked_out(namespaced_name)) {
-- 
2.12.2.windows.2.800.gede8f145e06


