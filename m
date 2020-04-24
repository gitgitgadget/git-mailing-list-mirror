Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A017C55199
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F672075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej/tTNeM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgDXPHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727840AbgDXPHr (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:07:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30247C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:47 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id k18so3834550pll.6
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPYz0zycP2foz0E7INOMbi+3tdO5UF5ESfdL7FkXwI4=;
        b=Ej/tTNeMhXOZxwhVnEjpPOE9dx7cbWNMMmCQsIeTZb6E3P2BBu6jzeJKHO8fCc91hx
         JeZeCkYp4sVyviJoW1N0BWqZp+JVyog8kS0Ej+GtI+0sQRzHCKKtavGql7EoDkQBLBxw
         dMNY4C+pXv+MQv/XLKO57wXfgVDmgvI942W4Ppmn1P9MhgJok7vr8/LlDnoV2q30VUDy
         uIkAJLO/B7QQV4kCFfcvXYRpHsNAU5OQm+cw46vtIl0zDra60ZeyAslLD9y4VDyVFfd0
         A0l6dIUekzuW3oFaaZQVhHtPwYmSkouFYtsa0pGM6dfE5V886IbyB+rfzYgXw5A+v8jJ
         VV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPYz0zycP2foz0E7INOMbi+3tdO5UF5ESfdL7FkXwI4=;
        b=FqqcXcC2fu9GBPJuxPW2W2xJ/evQQSOeUBDkoj/Emjvkm+i/UIVnaaXpRonvYounPY
         2+rePDR3v9Ft/n88otRAatu1/qf4wv3CjqNios7MOWgHTJCLLM7qni+nWevcC7fCUgfb
         V7ZXYK3khRlfpXnvV3PGpth/vHO1nZA8+SIZQVhbdelRfFw6x0CUh6BuCPXIab9xd6DI
         +fTp65pvmyM7oSqngqDwbPX1AJNlR5T8CIxc6LugyfJ+395LRjfz/R/y6a8O6RkOip+r
         c3CHn/m8KqxIqk9AV6TImLZjOe5h8pf6x8sUjWM5jup5v4YrAa7uEBjkooYF9+dPCeJY
         zvgQ==
X-Gm-Message-State: AGi0PuYyXI7LWykls7Dllz8uwpO3CokLh+PruvGsp5b/macEiAKlfTzL
        YB8JVZcTp5xLtvlTdN4WRLdGiPrH
X-Google-Smtp-Source: APiQypKJHkTk4mUybaz4YDJTgFhvV0d2MKZeRet4M4f6l2po+UivgQx16knak2WNzyVR24wCwairVA==
X-Received: by 2002:a17:902:9b95:: with SMTP id y21mr9698959plp.101.1587740866411;
        Fri, 24 Apr 2020 08:07:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id c84sm6417052pfb.153.2020.04.24.08.07.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:07:45 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 4/4] date.c: allow compact version of ISO-8601 datetime
Date:   Fri, 24 Apr 2020 22:07:32 +0700
Message-Id: <51aa60c06965e86d30619006f9f431e4f8281104.1587740682.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1587740682.git.congdanhqx@gmail.com>
References: <cover.1586856398.git.congdanhqx@gmail.com> <cover.1587740682.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c          | 14 ++++++++++++++
 t/t0006-date.sh |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/date.c b/date.c
index 2c9071d53f..f9ea807b3a 100644
--- a/date.c
+++ b/date.c
@@ -687,6 +687,20 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 		n++;
 	} while (isdigit(date[n]));
 
+	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
+	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
+	if (n == 8 || n == 6) {
+		unsigned int num1 = num / 10000;
+		unsigned int num2 = (num % 10000) / 100;
+		unsigned int num3 = num % 100;
+		if (n == 8)
+			set_date(num1, num2, num3, NULL, time(NULL), tm);
+		else if (n == 6 && set_time(num1, num2, num3, tm) == 0 &&
+			 *end == '.' && isdigit(end[1]))
+			strtoul(end + 1, &end, 10);
+		return end - date;
+	}
+
 	/* Four-digit year or a timezone? */
 	if (n == 4) {
 		if (num <= 1400 && *offset == -1) {
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 80917c81c3..75ee9a96b8 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -82,6 +82,9 @@ check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
 check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
+check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
+check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
 check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
-- 
2.26.2.384.g435bf60bd5

