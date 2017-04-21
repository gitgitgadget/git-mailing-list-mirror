Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A640F1FE90
	for <e@80x24.org>; Fri, 21 Apr 2017 10:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1037856AbdDUKqJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 06:46:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:51649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1037775AbdDUKqH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 06:46:07 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdYSM-1cJtW10XXW-00imoI; Fri, 21
 Apr 2017 12:45:59 +0200
Date:   Fri, 21 Apr 2017 12:45:53 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v4 7/9] Abort if the system time cannot handle one of our
 timestamps
In-Reply-To: <cover.1492771484.git.johannes.schindelin@gmx.de>
Message-ID: <2b7f90c003a1f60ede39813530617edbbdf29607.1492771484.git.johannes.schindelin@gmx.de>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Yb+gGDpLpe9yJaJ9Ez8ds1Pfo4+xFMm//vGN83o1rEUZVNtOzMq
 fNppyTIlHdfM/ykiD2Qjvxudqcv6yt8ptWGu9KgwEj6wTNgRVFqOQMLCWI5xfBfO3RyrVg1
 7fsESoK1Hnlj4FT4uK/sphhwpU8PtHMmCuTAKatS60t9h76r0zXHD9YCZAbJfz0CluTmEfO
 3JMcQuz6ksHA/Ru1fwDPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JNi2Ao2htBE=:5Ahpa28sCaWIh5rboI7tRj
 fvNMdtTzqZ7l97VgqYxUpUJzR3mwth5q4lcQrsj4rcgP9CtKkaX7PRNCB3P5/9xte8vG99ejI
 pUAXXxz8tERROmlOPcZAAweP764FLnqikLHj670hVQWdlYml2b1zOlqIwjo4hUmaQlZnKfGM3
 APnUBUmHP3qVSGbmlgh5PNv/GFE06abFROh4bVbIH0s8FsV1EtuzEoUyWvquGLwlCjPUxbjwb
 AJVKp4OWp9w8KloTUJEmEtpIcvXGLSkqlMn+KAvIIkdMEpon2AoMtqvnR7vTKl7Lm6uKEd5Z2
 4ChrNRaVHSNbOYIhbM/TzKrV6gYKSVrAPjkQBBxxwaqGidsK87FBebltjX1j+2L45BkMRKURN
 olxPbdcowfrEO+K9gZYeUuUclKDsMY8CRXZ0WfLLQuqoI3Gjmn2Rrg1z/836jFkbbxeWJDRis
 Y7R7g7inj7HF/e5Bvq4D1H40SbcTqgr/TxgNgLVa8zig6x6Z7J6JtjV83jKe/xOyqbRbvdLVa
 UlEK0RWXHd1fVFhN2gSGITqP8GAiXMKPlwHkXRgWAuO/ACT9Cns1TJu07TAqc1P2UgcWj2iUx
 Ra5byhywOMhwQM0hRwMziQAwojQMM34B7ef9JWIccYCNOGt8ogU5ri34N5bgQUQWd9pk/igDw
 Y4CGy7ukGSRnjZFhEHtB6G8eQb84xSQB4EUUv64a30MjqpNhWime1vs8keQ4gB/fs52HxE01Q
 aVKE7lNA4BNUFhl9u1twBfCTJVXc8iMRZwEbX6EtYSaekTNr7yLUPvMOHRbhylkyP6QZPbheY
 7lRv/Tn
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
 date.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 92ab31aa441..75f6335cd09 100644
--- a/date.c
+++ b/date.c
@@ -46,7 +46,10 @@ static time_t gm_time_t(timestamp_t time, int tz)
 	minutes = tz < 0 ? -tz : tz;
 	minutes = (minutes / 100)*60 + (minutes % 100);
 	minutes = tz < 0 ? -minutes : minutes;
-	return time + minutes * 60;
+
+	if (date_overflows(time + minutes * 60))
+		die("Timestamp too large for this system: %"PRItime, time);
+	return (time_t)time + minutes * 60;
 }
 
 /*
@@ -70,7 +73,10 @@ static int local_tzoffset(timestamp_t time)
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


