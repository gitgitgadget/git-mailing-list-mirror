Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B003420966
	for <e@80x24.org>; Sun,  2 Apr 2017 19:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbdDBTHU (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Apr 2017 15:07:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:62948 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751724AbdDBTHT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Apr 2017 15:07:19 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVZuV-1ccJ1206MJ-00Z3X7; Sun, 02
 Apr 2017 21:07:15 +0200
Date:   Sun, 2 Apr 2017 21:07:13 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/8] Abort if the system time cannot handle one of our
 timestamps
In-Reply-To: <cover.1491159939.git.johannes.schindelin@gmx.de>
Message-ID: <3b22b3545c38c0026a08aaec43b9a0f16762e5bc.1491159939.git.johannes.schindelin@gmx.de>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <cover.1491159939.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1h3R2pC87IB+2CaAAcQ7aJAaKOOmNcwLJLP8pSrI/ehnDejjPgS
 WGSFEJhCF9itE6r7hEbyC3/TdKlT2L7bV20wdz4Hv/n7nGXNqHnPq83qlAmHdzJBWa9xZ3/
 Q687iImQ8/u/vhdcxpnNaai6s59AzLi/7CFxXbgfwe89ye2XL/BEkptK37O+FzeJjr0Jkbm
 RjQf2zQMNBQ13zoSkFqKw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rkjc//Um7nk=:+FJBlOYKJOWTXxd4IiRgU3
 0YUi2ESju+3ynlXwX3THZfaW0WMMltKlGxBSvzjdgV5azNepiCSt10FBZikMoOEFoc/wzFqly
 T19ck3GLryCIRNwrVwoCmCkCVIQcnloo3p/niV36uTMZtvXPzzjFW9dAsg20NVvKrAfufCg9v
 GNDTu2ZHcaBxgJf2s4LeN2V7GPYI90J8kVMGBJ9d2zBU+tfMxpafrC9RrOPX82NWyNrUTOsLF
 RMv63cwit3ydQaFLhN/3qPIk85YLbbjAWFaGcB0h9o8C6JbV0Sa45sa6RB7fkxo/rRLMZd+Uy
 dfEoP1Ubq8FymkROee4zVreOK+w6wN2tgGRP5zehCRyl4ap+E5gfCDwWuEspA8/SrLMkX9H41
 fOwrTI9X/KmYLUbuKV6kQZ4THhHr3bMOB5f3egXTP3gQpRpptP1yeDtGjRz/oKWW9HPECN6e7
 H7T7zSoOdtgjKtJzmtJIcJqMUgKpwFcexiv9akMOU7mTtipE1ZcVbk8RnLzl1Qls+WKR/j88q
 xLNA8EhOQiS7v/jHjLAk/Zk8J/r7pBrtaqqtZmPhIPBhE/PiHOvfDrYsL2e1yOj4yJQYZTf+E
 fQt4TAW+2QEfNo7V5rIPs6lK98QPCG5afDAahlVbjxiG7VwjKtZ8uB0N+JekNR3PoLU5NmFSA
 IJHMNuv1lkhMGEwFI8xrQ5ib5SLe4ZWGifYuHdotiR/mkJsl0f0qyiHiIv+fj8R8Br8nbou4C
 oQnl0KWAWfX/hT5eg7h+nxnGp75nwSZt38FUyWk7k6UtMsUF+1AIFXUIUT8s8OFmaTldod+6g
 QMNSLb9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are about to switch to a new data type for time stamps that is
definitely not smaller or equal, but larger or equal to time_t.

So before using the system functions to process or format timestamps,
let's make extra certain that they can handle what we feed them.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 date.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index 92ab31aa441..db3435df3e4 100644
--- a/date.c
+++ b/date.c
@@ -43,10 +43,13 @@ static time_t gm_time_t(timestamp_t time, int tz)
 {
 	int minutes;
 
+	if (date_overflows(time))
+		die("Timestamp too large for this system: %"PRItime, time);
+
 	minutes = tz < 0 ? -tz : tz;
 	minutes = (minutes / 100)*60 + (minutes % 100);
 	minutes = tz < 0 ? -minutes : minutes;
-	return time + minutes * 60;
+	return (time_t)time + minutes * 60;
 }
 
 /*
@@ -56,7 +59,12 @@ static time_t gm_time_t(timestamp_t time, int tz)
  */
 static struct tm *time_to_tm(timestamp_t time, int tz)
 {
-	time_t t = gm_time_t(time, tz);
+	time_t t;
+
+	if (date_overflows(time))
+		die("Timestamp too large for this system: %"PRItime, time);
+
+	t = gm_time_t((time_t)time, tz);
 	return gmtime(&t);
 }
 
@@ -70,7 +78,10 @@ static int local_tzoffset(timestamp_t time)
 	struct tm tm;
 	int offset, eastwest;
 
-	t = time;
+	if (date_overflows(time))
+		die("Timestamp too large for this system: %"PRItime, time);
+
+	t = (time_t)time;
 	localtime_r(&t, &tm);
 	t_local = tm_to_time_t(&tm);
 
-- 
2.12.2.windows.1


