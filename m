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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E191C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B7D20728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjgYMFgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgDWNwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728506AbgDWNwx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:52:53 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5F5C08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a31so646598pje.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rH6kH/tz9sHgN6M255BbLTntiUtcudBE99s4fQjBjsc=;
        b=gjgYMFgX2Vh8sSJ5ZV6E+xn7Kx2vyOfQBevpqbofUCyjfrg+9ScOeZJ2A13FCklcMT
         sKBDV0rksKqVWz9q74ml4Zei5x7DXjZYOQzsGfuKwKNmabtX9Wdu6KIpVpqzQMSvvrAk
         IvFx7c182p8a7M1W0rPwfl3Nb8jLFqa08vAK9IgIej8JAKk5JBbDXWfeuJeAWQ37SUaQ
         wy0rGwls1GmFyFBcev+gJl/YRA2WeFRCXt73ctuYuCIz46Zc5ZnKW2bW9g+7J73f2LMv
         JBp+AQQRvleghyzDOgQVDkDO7wyDfF91UsNMt/+ssWHCLhle2edpvXAurPotndIbnxQ6
         pJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rH6kH/tz9sHgN6M255BbLTntiUtcudBE99s4fQjBjsc=;
        b=hzvTNgMQjLVIqwxkDAOnamZ8YhxWOoHMK8vl0y2JQBKxiUbboyy+BAiDtyd20bMy0A
         D86sp8ByFuypuLgKUu3zm85/UDZ7D3rBqV7Rg8ik7Wu510ZsgQ9hM/Oljp0NWaCU6HX4
         98+60j9v+dNMo1LHmH3zibzoVVCGT5IlMT6cKCQu2MeFfjf/CQGuljCGfO38mIqZh1d7
         4oIiyYlzK4FU7sebng6JfI2ULcy6wpU/zyN9CGb2JzlRkKjzc7syVm7O+opMJxbh0Oci
         xsTwHYMoHZjVm96bIkk5NSyA+uATfylfgxvvMFDV+WzRn0gJDmXIRVz/+N5VEYyz1im+
         dMIA==
X-Gm-Message-State: AGi0Pub1i2i3PUCyGZ9CBPRuVRSt5Q7EL4ZnNZG0XY2c/WnuP+5O6kxR
        exmYtBsGBz6D0gsRqVSfhPlHvHgd
X-Google-Smtp-Source: APiQypKTc8LWuIqccjgWQaGZuowmTz51jVpZJlkDJ0tzGM4NIwC1buox54K7IobsS7GG/x1w6rtfeQ==
X-Received: by 2002:a17:902:ea8a:: with SMTP id x10mr4119347plb.166.1587649971774;
        Thu, 23 Apr 2020 06:52:51 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id u15sm2430335pjm.47.2020.04.23.06.52.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:52:51 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 2/4] date.c: validate and set time in a helper function
Date:   Thu, 23 Apr 2020 20:52:39 +0700
Message-Id: <0d0e4d8edce37dfef13e573588f0c043ddf07f6a.1587644889.git.congdanhqx@gmail.com>
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

In a later patch, we will reuse this logic, move it to a helper, now.

While we're at it, explicit states that we intentionally ignore
old-and-defective 2nd leap second.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/date.c b/date.c
index b67c5abe24..f5d5a91208 100644
--- a/date.c
+++ b/date.c
@@ -539,6 +539,22 @@ static int set_date(int year, int month, int day, struct tm *now_tm, time_t now,
 	return -1;
 }
 
+static int set_time(long hour, long minute, long second, struct tm *tm)
+{
+	/* C90 and old POSIX accepts 2 leap seconds, it's a defect,
+	 * ignore second number 61
+	 */
+	if (0 <= hour && hour <= 24 &&
+	    0 <= minute && minute < 60 &&
+	    0 <= second && second <= 60) {
+		tm->tm_hour = hour;
+		tm->tm_min = minute;
+		tm->tm_sec = second;
+		return 0;
+	}
+	return -1;
+}
+
 static int match_multi_number(timestamp_t num, char c, const char *date,
 			      char *end, struct tm *tm, time_t now)
 {
@@ -556,12 +572,8 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 	case ':':
 		if (num3 < 0)
 			num3 = 0;
-		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
-			tm->tm_hour = num;
-			tm->tm_min = num2;
-			tm->tm_sec = num3;
+		if (set_time(num, num2, num3, tm) == 0)
 			break;
-		}
 		return 0;
 
 	case '-':
-- 
2.26.2.384.g435bf60bd5

