Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12DE7207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 13:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1171932AbdDXN6p (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:58:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:57865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1171926AbdDXN6f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:58:35 -0400
Received: from virtualbox ([95.208.59.55]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MOTRh-1cxRRq3g6H-005mVF; Mon, 24
 Apr 2017 15:58:32 +0200
Date:   Mon, 24 Apr 2017 15:58:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v5 7/8] Abort if the system time cannot handle one of our
 timestamps
In-Reply-To: <cover.1493042239.git.johannes.schindelin@gmx.de>
Message-ID: <65d90090b7cf8046771879e2ebc881a055083d82.1493042239.git.johannes.schindelin@gmx.de>
References: <cover.1492771484.git.johannes.schindelin@gmx.de> <cover.1493042239.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bJTXV0vKsQvhIFeVL6hBITpvONXuCF4kygxLMLMeQIG/HsJeF/H
 VsJRFd7jejbRG/qasuEmXVf50DC1G3pmDN+G5UcfKoipT5GlJbYNtO6hqSW9U3xGpd/hP0Z
 8O9AaVlBkOY7U8HrW8rQf0FpO5Zmz3xMqohInhNZGFNzbaL2+hqtCqlQSWk3wHE6Dpzsjt9
 s4zgAiHC47cc3s7ElQeBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZMKzV8MDv70=:s/UbAFqILH54zzpm7sDwcy
 btEOkMYb3qjT90gWZGFR8tqHaMK//fKGaqnYwtGXCOkuqNWGtPAu7lqFSnnGDS7FMUtB2BYl9
 WealMQXh+0X/LpVz22njlkiHIB9BMiMofhaZidTdRZugI8haU+TPkGjNiLHlgbRhUmvJkT124
 vh3ubdlVRelTRSTyjaSMH/TkSM+CJoIom8MtPWBb8jykZHoWyN6NdJfTTRuaIspz6diW6KpZO
 1VCvLkO2KYEMRcIgdFT+FFlgkV849C5dUt3gS9jm5KKOX66xKXWX8HguMdwjPhffA9wuAx7Bm
 ssnjW2QGbPsby541nZhWLmaOUwnq6a/eqb0SOBP8J/8rq6763nwB1QvlU1S8nO+SXRPNX11F3
 YVhUOHqtuYpIuVZHTLCkjuB6LzQIwyb6o05kQsPWCUlc1DNRH02UdROsSMVgKpjKLCgO0jmcR
 jl1mgERu73Rth2hwf+keOk2T17SquP2RgSreabtYR4INCqZpb9kH5yqulQk/Q5ZyOtFCs9h2E
 5Fo751pQyiLmW5kzPzZe+PK+j6scjxREG2VSzM4VehcydB7a4vx3CoAECTTRZs1Vp8X2Zy+qj
 IwDtNRfEtDqBAxtqHe8NWPM/FNpETND4D4xPKfrYz9a8p/ujiTK4CYyo7mhRYJn45PCnwVUh+
 2k/wgcfVxaC7cCiaHM+l2RuZMcOd9MBRbn/FJ45GGlETCqsjrTT0v4nBPEz1bgVceD6LrtjX5
 efDEtJME2jTCplT+d4V3EMFNBkqT5ObZBPoDdPXLA6KxEkJLdQMdERAgVKmPJLPYlBUwWpbjX
 p8g8gjs
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
 date.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 92ab31aa441..63fa99685e2 100644
--- a/date.c
+++ b/date.c
@@ -46,7 +46,17 @@ static time_t gm_time_t(timestamp_t time, int tz)
 	minutes = tz < 0 ? -tz : tz;
 	minutes = (minutes / 100)*60 + (minutes % 100);
 	minutes = tz < 0 ? -minutes : minutes;
-	return time + minutes * 60;
+
+	if (minutes > 0) {
+		if (unsigned_add_overflows(time, minutes * 60))
+			die("Timestamp+tz too large: %"PRItime" +%04d",
+			    time, tz);
+	} else if (time < -minutes * 60)
+		die("Timestamp before Unix epoch: %"PRItime" %04d", time, tz);
+	time += minutes * 60;
+	if (date_overflows(time))
+		die("Timestamp too large for this system: %"PRItime, time);
+	return (time_t)time;
 }
 
 /*
@@ -70,7 +80,10 @@ static int local_tzoffset(timestamp_t time)
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


