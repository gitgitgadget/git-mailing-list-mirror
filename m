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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA3EC432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E2F206F0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 15:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j17L71G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfK0PNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:13:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34940 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0PNn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 10:13:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id q13so11173483pff.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 07:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bi7AbgfHlrAgwe9XedrkOnNY0DTAYXOyG/ZB7iubzdU=;
        b=j17L71G03y0QaAi3j7cTGkudAc6S+Qj5eIjbfsD6TbA1qyM4hrqJAJlyqHspGdr4zm
         BppsKyTtpRIMCO3AF1dvpCVrPDyDC93GH7JvB+LWJQPriEeHAFQ0i+9kRpCUmB3NFwjk
         Mx2jWp86oHbnoY/SFeXsA+Mx5G4L8StP21qEH9TWS5DYsNlXNpxUpMcmsEy2beI4KSsO
         iXvobKaxNe8/48fWKA9nKOO7SSy3qLLa2L4VMPnWwgfcQnswojiihNkhae90jCBxSNI9
         u3p6wqw3skAizVn8WKYqrq6xmR12K4W4WKV/ZcIL+L5EdexEg4PKvIL6PzpKGJJ2jjp3
         JqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bi7AbgfHlrAgwe9XedrkOnNY0DTAYXOyG/ZB7iubzdU=;
        b=ZYr12yQBlWTnCxhI6B9mZXeO0AE/FbSrjbKdzJYHJtN21PQCx2ErEa8AlBeGb7Ad+w
         jWE5MygOAEieyLT/ypo//4JhDsTMfMMasPrcrv1f6vLZWEZa++x0OWXKzEXiSDfoAG8d
         IBbEmp6ujzBQmx46j9v4QngCiGHFIR0qsbYnnjr4kM35B/luPqlPZ/No8/tw4BAQiCv7
         v4neiObXkGwYyBUOT5emgLD26mvP1w2x9IgCt/rD3hTjGZB27y3PhquVYCHb+RV2YhqB
         5UpZk0shUeq/W6Uge5UQwYGax0M/adkZaToptb8tkIoS61/S9JTLTooQ+oKOCadWEhUZ
         RPIg==
X-Gm-Message-State: APjAAAVRnLShSxckvL6n0VVqNQGfPRzs2PXSs8qET21vGexgSbsQZnj4
        zuYlEFHHkgMxZny6c7Xt13le1qqS
X-Google-Smtp-Source: APXvYqyeGMOxzSZebSzs+BXB4kId0ZHZpkpbNRgAK/rVvYfccqlVJieMuoeLPTO+G0HEfpLbWnPOFg==
X-Received: by 2002:a63:97:: with SMTP id 145mr5588541pga.42.1574867621944;
        Wed, 27 Nov 2019 07:13:41 -0800 (PST)
Received: from localhost.localdomain ([2402:800:6375:24ff:b05:3145:6413:309f])
        by smtp.gmail.com with ESMTPSA id g192sm16883674pgc.3.2019.11.27.07.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 07:13:41 -0800 (PST)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 3/5] date.c::time_to_tm: use reentrant gmtime_r(3)
Date:   Wed, 27 Nov 2019 22:13:19 +0700
Message-Id: <ce7fe7bcf363826b8f67c91d7300eb0158091752.1574867409.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.24.0.158.gd77a74f4dd.dirty
In-Reply-To: <cover.1574867409.git.congdanhqx@gmail.com>
References: <cover.1574867409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 date.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/date.c b/date.c
index ca71736a9f..b0d9a8421d 100644
--- a/date.c
+++ b/date.c
@@ -64,10 +64,10 @@ static time_t gm_time_t(timestamp_t time, int tz)
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
 
 static struct tm *time_to_tm_local(timestamp_t time, struct tm *tm)
@@ -321,9 +321,9 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 	if (mode->local)
 		tm = time_to_tm_local(time, &tmbuf);
 	else
-		tm = time_to_tm(time, tz);
+		tm = time_to_tm(time, tz, &tmbuf);
 	if (!tm) {
-		tm = time_to_tm(0, 0);
+		tm = time_to_tm(0, 0, &tmbuf);
 		tz = 0;
 	}
 
-- 
2.24.0.158.gd77a74f4dd.dirty

