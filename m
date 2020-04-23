Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE25C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3086A20728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIbB+VqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgDWNwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728506AbgDWNwu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:52:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9588C08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so2973765pfn.5
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E6Pa10RZbqUp9fkgDKJ5iLiLAKb3oXXpq5PDrmLBUk0=;
        b=EIbB+VqUYHZJAfzBBP7fxYxbqwIFZbakL5tSbEnWEkWJBCrSAnlr3u//3yMJstB2z7
         UOz7LXY7Aj/I750wxK80sPucKZr+AsO9r4844aepKP8QiaBrgqHvpeVxqk17m5hdfSBk
         qPwgXrrFdE80BTstj1gigSDBLxPkAr1aFV7vIw6jdtCGmVjv5E8JXqxtIyw6zWMUU+nc
         7ZMGCaag2U8es5fg95ofjj6lHCBDDza43tvaZLZgCwFbUzWH/BHb6u90cpyQmUSMxMje
         SKpJtedg5AxKY4VpKr0WPXjKFZGuW3EG25IzVjQxsgJws78guJG6W0HfnGNV1mfDlY6v
         KmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E6Pa10RZbqUp9fkgDKJ5iLiLAKb3oXXpq5PDrmLBUk0=;
        b=kYpPuGJkxnI70Xcmcx9DqcgNZY/x1SFxV8KYLBvMsaPLwYTQfMM/uN9vhl5f4yzU2i
         EEJWUdH41F40vRdgV3SjvLDjq8XOHTBJaCGDiIPAJ5Nobv2xS4We+vlB5DB6HFxe4h8o
         SAy6qA7MBe2Pj5M1aa4kOUUT+PDmDUJnjPoI32GhZEtEVMZ5Llj74gbUuSQ7VgMP/Yl8
         LvMP8CKlyPC38xe9mBFyR0WHpuTn5Zp46oZxqZc7UCyWNj6DJhos6mo/KLBKwbcghqu2
         ueFf+G/4b080kgg3/SYVXyrW9/pfNCNtxI1nBhmVGLAD8rGiYnIL0FtFR0CYoi6IAB3Z
         x8qw==
X-Gm-Message-State: AGi0PubWij1Q24a4E8wbLtS/XRwkSz9gyhG++0c59O9CTkCQKBSwFh0D
        wxVHNzcjFb0YkoPStHMpRvDM9R81
X-Google-Smtp-Source: APiQypKV51va6TZj2nfRrMi8xpiAoPksV4f1uMbCXElFfKSb71VzsNiJi0uK7HaYuZR1iTQdyRg5+Q==
X-Received: by 2002:a63:4920:: with SMTP id w32mr4174950pga.119.1587649969953;
        Thu, 23 Apr 2020 06:52:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id u15sm2430335pjm.47.2020.04.23.06.52.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:52:49 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 1/4] date.c: s/is_date/set_date/
Date:   Thu, 23 Apr 2020 20:52:38 +0700
Message-Id: <1fe69008fc79e6a74e8613011504bc7e342291ab.1587644889.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587644889.git.congdanhqx@gmail.com>
References: <cover.1586856398.git.congdanhqx@gmail.com> <cover.1587644889.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function is_date, confusingly also set tm_year. tm_mon, and tm_mday
after validating input.

Rename to set_date to reflect its real usage.

Also, change return value is 0 on success and -1 on failure following
our convention on function do some real work.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/date.c b/date.c
index b0d9a8421d..b67c5abe24 100644
--- a/date.c
+++ b/date.c
@@ -497,7 +497,7 @@ static int match_alpha(const char *date, struct tm *tm, int *offset)
 	return skip_alpha(date);
 }
 
-static int is_date(int year, int month, int day, struct tm *now_tm, time_t now, struct tm *tm)
+static int set_date(int year, int month, int day, struct tm *now_tm, time_t now, struct tm *tm)
 {
 	if (month > 0 && month < 13 && day > 0 && day < 32) {
 		struct tm check = *tm;
@@ -518,9 +518,9 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 		else if (year < 38)
 			r->tm_year = year + 100;
 		else
-			return 0;
+			return -1;
 		if (!now_tm)
-			return 1;
+			return 0;
 
 		specified = tm_to_time_t(r);
 
@@ -529,14 +529,14 @@ static int is_date(int year, int month, int day, struct tm *now_tm, time_t now,
 		 * sure it is not later than ten days from now...
 		 */
 		if ((specified != -1) && (now + 10*24*3600 < specified))
-			return 0;
+			return -1;
 		tm->tm_mon = r->tm_mon;
 		tm->tm_mday = r->tm_mday;
 		if (year != -1)
 			tm->tm_year = r->tm_year;
-		return 1;
+		return 0;
 	}
-	return 0;
+	return -1;
 }
 
 static int match_multi_number(timestamp_t num, char c, const char *date,
@@ -575,10 +575,10 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 
 		if (num > 70) {
 			/* yyyy-mm-dd? */
-			if (is_date(num, num2, num3, NULL, now, tm))
+			if (set_date(num, num2, num3, NULL, now, tm) == 0)
 				break;
 			/* yyyy-dd-mm? */
-			if (is_date(num, num3, num2, NULL, now, tm))
+			if (set_date(num, num3, num2, NULL, now, tm) == 0)
 				break;
 		}
 		/* Our eastern European friends say dd.mm.yy[yy]
@@ -586,14 +586,14 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 		 * mm/dd/yy[yy] form only when separator is not '.'
 		 */
 		if (c != '.' &&
-		    is_date(num3, num, num2, refuse_future, now, tm))
+		    set_date(num3, num, num2, refuse_future, now, tm) == 0)
 			break;
 		/* European dd.mm.yy[yy] or funny US dd/mm/yy[yy] */
-		if (is_date(num3, num2, num, refuse_future, now, tm))
+		if (set_date(num3, num2, num, refuse_future, now, tm) == 0)
 			break;
 		/* Funny European mm.dd.yy */
 		if (c == '.' &&
-		    is_date(num3, num, num2, refuse_future, now, tm))
+		    set_date(num3, num, num2, refuse_future, now, tm) == 0)
 			break;
 		return 0;
 	}
-- 
2.26.2.384.g435bf60bd5

