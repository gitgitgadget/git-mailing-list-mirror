Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA60DC432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE75F206F0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZTn0e4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfK0PNj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:13:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44505 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfK0PNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:13:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id d199so6520092pfd.11
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 07:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yar8rjdSUkz4HY+Sgp0iz8+alyJFQfuDl7R6GKm67Z8=;
        b=WZTn0e4IzAQk0VijfeuNu/JqtEYpoNHf/DOKMu+Jq17GSIkXEGJ9xNLRMtSTsD6e5k
         DrnnXgozw+0abbGKriG10ZR9Ap/Pe/QQdnd3a/zxAyZa/7S7U43a/0PQfd3JqGml9QU6
         sCjnuP2NgTXL4P4yolE18vzCtbGI2R2+sK0lj3NAINAvk38Z4RJZDqzO+TiTo87oClKQ
         xEWFlLYfTFJJKJ2XcR2R8CX9hgrJ0lVQhCnzhhs/cIli3VrQvUkMGU9ierWq4hv92hF5
         x6J0V99qhwX2RZh5Cei1K6+nhpHyi4a9yOjGVvluFrCdzvHHeX/bBl1iUohhkC6JyWJV
         8Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yar8rjdSUkz4HY+Sgp0iz8+alyJFQfuDl7R6GKm67Z8=;
        b=pBfrJGdCjdAQpTENYrMtMih8AXEbDrgU/G8J89BOwdR7c+zcNDIPL5lYeCw1xquNXP
         34TpJzX7+aIBGqNirxcLefgEhzWjR0eNEarQDjfPm24BFQRUMsY3CAYikeD6vargAg1t
         CVHR2rgrOz6y40jkhxegejdztt4QPxv/JYh2Rd6SBeMSJ56LlatQG2VWsyUHmlg5VZeF
         Dcjf/bhTb23AHLro+x/YvPzPT5j2KlkbebroQLmKetmlUaFdYaRyxhKH+u7fqIBew/G4
         IMe9otjdOxouMRJAOQhSb7Hs9c1GMMUDuy79M25LWlHGgnxxX0BSABQYlK2wvAvp/NrW
         9XHg==
X-Gm-Message-State: APjAAAVfzkLvgcm0O3DPUj31KRSQPf610o2OAA4Umd6xPBJwNxQoAMvn
        OnXnmhoUQ4RZwiwhaHJ/Z+JpsOd4
X-Google-Smtp-Source: APXvYqwnzbYL+OzXRtUgduM48DT/1rct3/ncmoDrZs6Dn0aDqPD0s70y9+juS6s+xaEOJxIFuDAQJg==
X-Received: by 2002:a63:e20:: with SMTP id d32mr5771271pgl.59.1574867617073;
        Wed, 27 Nov 2019 07:13:37 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id g192sm16883674pgc.3.2019.11.27.07.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 07:13:36 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 2/5] date.c::time_to_tm_local: use reentrant localtime_r(3)
Date:   Wed, 27 Nov 2019 22:13:18 +0700
Message-Id: <130eba77db3c953c53bd80c9721b4d0fe0f6bee0.1574867409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.158.gd77a74f4dd.dirty
In-Reply-To: <cover.1574867409.git.congdanhqx@gmail.com>
References: <cover.1574867409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phase out `localtime(3)' in favour of reentrant `localtime_r(3)'

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 date.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/date.c b/date.c
index 553f8e79a2..ca71736a9f 100644
--- a/date.c
+++ b/date.c
@@ -70,10 +70,10 @@ static struct tm *time_to_tm(timestamp_t time, int tz)
 	return gmtime(&t);
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
@@ -318,7 +319,7 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 	}
 
 	if (mode->local)
-		tm = time_to_tm_local(time);
+		tm = time_to_tm_local(time, &tmbuf);
 	else
 		tm = time_to_tm(time, tz);
 	if (!tm) {
-- 
2.24.0.158.gd77a74f4dd.dirty

