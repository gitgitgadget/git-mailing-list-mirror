Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1F7C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D97217BC
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 12:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnd1Mkf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfK1MZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 07:25:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45228 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1MZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 07:25:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id k1so12816255pgg.12
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 04:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iH8ljWWJopy53yf42suTTw5wsATC0P7LThnOXE+SEVQ=;
        b=Nnd1Mkf/JRHpMAGZXSDNDRaGk2ohgxc36NnXQoEhNxyHLPM7RNqzy0u+VoQUyoWSfT
         Qx7b5zezdvWgoqr/wxUrdvx44Y6gFmJlxqis/7suPRl8ibBcZfIJj5mDnpZB0gLRPkgu
         GmZoKEcx10J/2i07zzbdALC8diNaxSIuCzlNsWawneo5g/KtT1lVCvBGGghjMJMlGWLo
         toJmLh1uJ3TOO/durGh+FaWYXayEKua0n2S3OsGV5VXC2XDY8V8gCp8awJA8G1WRAu/a
         Tm4s+By9jQdTdWvyF6Wy3bZ9cGwhOwcxOg2NmTmGcQZ3V+N8kd0Y7BKGD2MaJG0ZhteO
         Xn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iH8ljWWJopy53yf42suTTw5wsATC0P7LThnOXE+SEVQ=;
        b=t2KHuzovA1+/ESi61w4h1swwgEy57k2HhMHaluFUE6llxzbZN+DfcC5rbTCN9s8HZA
         h6S/X33Y8ORQappexkRaJ/CPHSJknq8QNrbAYWQtQ1fjTxb4W0iDgH7PYOTF83g8manQ
         sEQLMxj+9A/fa4c3aB2RtevCeNn2RAbE8mzOso5sM0wL0DHp+X8OLvlMWMZZIKhVg0rq
         ZUy90T54DelQWaY7p8Bf6L0i+O+yv6AZfgMyoW5NQCFQD9GJ8HuE8jphqdLBN2XYJ1hI
         wKgfY+X56FAdkkAPkZ9C1z8ti+UdRaCBo4u2jRNcdbpLJmtlDRTTivW5gv2zU3h/kkhj
         TeVQ==
X-Gm-Message-State: APjAAAUKOjjMkO5hIOgXteHUtw4lmJ7f7tSqX0WxUlbJp8hPosNeRSnD
        VvDwsC1/+cT6jl061N3CKDsY7LQI
X-Google-Smtp-Source: APXvYqx6G5Y3bbABFeBhppr42E5EYxvwtPTxTTWImXXbxwBW6XkaEJn+B3NYruW0fMW7oznV3cA4Nw==
X-Received: by 2002:a62:76c6:: with SMTP id r189mr53626803pfc.48.1574943930235;
        Thu, 28 Nov 2019 04:25:30 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id r28sm18849448pgk.75.2019.11.28.04.25.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 04:25:29 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH v2 1/3] date.c: switch to reentrant {gm,local}time_r
Date:   Thu, 28 Nov 2019 19:25:03 +0700
Message-Id: <71de738864d273c925ed8a9a93fe1a85fa8b81b6.1574943677.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.615.g37f5bfbdea
In-Reply-To: <cover.1574943677.git.congdanhqx@gmail.com>
References: <cover.1574943677.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, git was intended to be single-thread executable.
`gmtime(3)' and `localtime(3)' can be used in such codebase
for cleaner code.

Overtime, we're employing multithread in our code base.

Let's phase out `gmtime(3)' and `localtime(3)' in favour of
`gmtime_r(3)' and `localtime_r(3)'.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 date.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/date.c b/date.c
index 041db7db4e..b0d9a8421d 100644
--- a/date.c
+++ b/date.c
@@ -64,16 +64,16 @@ static time_t gm_time_t(timestamp_t time, int tz)
  * thing, which means that tz -0100 is passed in as the integer -100,
  * even though it means "sixty minutes off"
  */
-static struct tm *time_to_tm(timestamp_t time, int tz)
+static struct tm *time_to_tm(timestamp_t time, int tz, struct tm *tm)
 {
 	time_t t = gm_time_t(time, tz);
-	return gmtime(&t);
+	return gmtime_r(&t, tm);
 }
 
-static struct tm *time_to_tm_local(timestamp_t time)
+static struct tm *time_to_tm_local(timestamp_t time, struct tm *tm)
 {
 	time_t t = time;
-	return localtime(&t);
+	return localtime_r(&t, tm);
 }
 
 /*
@@ -283,6 +283,7 @@ static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm
 const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 {
 	struct tm *tm;
+	struct tm tmbuf = { 0 };
 	struct tm human_tm = { 0 };
 	int human_tz = -1;
 	static struct strbuf timebuf = STRBUF_INIT;
@@ -318,11 +319,11 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 	}
 
 	if (mode->local)
-		tm = time_to_tm_local(time);
+		tm = time_to_tm_local(time, &tmbuf);
 	else
-		tm = time_to_tm(time, tz);
+		tm = time_to_tm(time, tz, &tmbuf);
 	if (!tm) {
-		tm = time_to_tm(0, 0);
+		tm = time_to_tm(0, 0, &tmbuf);
 		tz = 0;
 	}
 
@@ -959,10 +960,11 @@ void datestamp(struct strbuf *out)
 {
 	time_t now;
 	int offset;
+	struct tm tm = { 0 };
 
 	time(&now);
 
-	offset = tm_to_time_t(localtime(&now)) - now;
+	offset = tm_to_time_t(localtime_r(&now, &tm)) - now;
 	offset /= 60;
 
 	date_string(now, offset, out);
-- 
2.24.0.615.g37f5bfbdea

