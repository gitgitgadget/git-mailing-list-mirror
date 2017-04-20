Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB191207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947377AbdDTU7K (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:59:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:50361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947233AbdDTU7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:59:09 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lt1S6-1c0FIW1bp4-012bp6; Thu, 20
 Apr 2017 22:58:58 +0200
Date:   Thu, 20 Apr 2017 22:58:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 7/8] Abort if the system time cannot handle one of our
 timestamps
In-Reply-To: <cover.1492721487.git.johannes.schindelin@gmx.de>
Message-ID: <31e6035de94c95660003575edffe8a96714ef519.1492721487.git.johannes.schindelin@gmx.de>
References: <cover.1491159939.git.johannes.schindelin@gmx.de> <cover.1492721487.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:eK3aIpFdDvTKSd1LAOqcpQE+aLayKtc9yzuelgTDsIIS6/Z0a4k
 iaabdT4nxbJIiv8wmii1i1TsndMkyfB3OUCo5k6lMS3Tz2zQeCi+80gwpiiFz11qev29Z/k
 Q6x316gwb8OUpLkI4GTvUdUp+9K8epGSTFih6ZEhL3+wXliwl+1F8n+gt83FVcH1vaFQMtj
 CLumjuCJpM21CDvVKzZrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wFb+r08SbKI=:vKM+p1LLYKU00rRkK4gk80
 xuS0rZrKqe7Fej/mOen1KFbHafD7AeGoMrrJAdKTTHfpkTTOzEHZaHJxj+hRjRvfEsXyyjKeB
 TUUGura3Rs2xCh8mRGfHwZx66t//K8yBAOSGbg6v9g8LGcdBCs5DOLDA63MarZBJbO2BBv0ds
 i/8RJlGUD4/xDuGTiEyYfJrdEsadEtdDL/A9e+Bop2h14wqw+WytfphIXcB6hmUZaeLDlIrWZ
 Xuy4Uq1VTNBjiEU6XbXiZLt/p3C8AB3N8vr6La0Fn210sNcR1ZTQNbm9UXrXkiFulFPcYUqZw
 1LVKfatgc2xCE/VqghOYAqcUiOp7NMFsfc+j4LkHl9dyu0qrTBEAymgMIfbbcQOPMnOmFFYVU
 K/CSXE+sGchKfqIhkPZSX4cLPsCLNnQKqPBElG5TAIY+SRUZE/pcAUessUriv+0YXRS5pACGZ
 M+6TMnMe8+JqISJdmcp9fqTkDFD625gWcC1yWdq4ErLI50wBHv6BAcg1T2DlEMfWPB5H2eKIs
 mZYh3s2ZpIU652MTyjTySoI8LGp3wQJH2XOYYjNy41TLDhFagT5/CaJugNZYGzEbPsDqNaq1W
 PG4WHI4YDaaQOPZlLze+NIhk69mqw3FTuw0D3netaepmEfeFuObfVUsHZ82U2xtzUuOarmlPy
 gOWCF5WCJ4kja1DJXavcGHK3uuXHrrwf01Hgn1QlFbT5AZY3m0nEp3ynzQWbHCynuhTTNn0Hy
 3gPObdyPWgMimu66gHKz7GLPMhobQMHX90JELzwYwhb6g1a2Z6CWFBjGHy7Pv0SSzqOYk3rEQ
 NalQ4+j
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
2.12.2.windows.2.406.gd14a8f8640f


