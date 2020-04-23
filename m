Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9905C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C557820728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW5wQ6JM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgDWNw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728653AbgDWNw5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:52:57 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D387C08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id o15so2932898pgi.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=empvCX3u642Njh8JgYcw/Sl4jNFokXmJsZFZd0Nzdmk=;
        b=KW5wQ6JM/k16VEIbID47pA1EX8ioTbhRzo3VH+JtLgal2C53o8J/Hp0jomv5FuKZSY
         p0YdEYnEMulzucHjhk7VOMeSinzri9BLMq86YKFevIn2fHuiA97Ch9I0lSWHe4QukSlz
         h2pf2/uVwX2gtyGCaf+csfoHPMOH1sJH/XHk8+DBxorKRrxeO71jykYqd4/eE4PSh8rT
         ne5YKb0rVXgXqPI6lLncqgE6TdPGwi42iYQDi3+5HJccKo4vZ1tN0GeWFBEhD8BrsPEt
         +C02yFT7l9ElNfqSnReFWA/hNHxJ9Ig5RePNBmUP2PJUYd0e+eNDGbeShLuiU2l9Gcvu
         FApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=empvCX3u642Njh8JgYcw/Sl4jNFokXmJsZFZd0Nzdmk=;
        b=h7f9r5AgXoFaDVxIjgBRp9aarrqLVXkkSE2c+x3Ab71RowClWSRySxIlXZ3O+m6wml
         ycqi37UVPJKtbCpuu6w17YJJOmsCuQtDY8293qHssBW1fWTIK9PRzivr1kdz0HRyl8JY
         meqy7Sk2v6nxEd9wSeu75rC68DVRDQlk3P85b0X2in2jQjs75Y8aAhDS1xWZYCSICNgg
         j0PYCB80erWgrcznLmvIBtAgf4Ey0eGEl3p+iojSHwdKeHP1VHAru1Tp7p7hd+x+YW7w
         I38CrqNRxe3MQ+9lFgThP/UUq1iQQAiAQiGvwqMWVAud5fnMWCvA+P7bRJdy0HDCRbYb
         ADTw==
X-Gm-Message-State: AGi0PuZhJcJzzBCGJiFuELyHhD5ew0+PbftG9V7TJTNFPde5cdYv6nrc
        RGxF0eo408eiQzTeWeEDtGxyNFrR
X-Google-Smtp-Source: APiQypJqFM/h1RmmrQMNKet4AXgHns36t/R8ljxw+mQ1vhJMYzWQyDtv15q4QmoyPuYTXuDUj+/AeQ==
X-Received: by 2002:a63:8d43:: with SMTP id z64mr3932027pgd.77.1587649975502;
        Thu, 23 Apr 2020 06:52:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id u15sm2430335pjm.47.2020.04.23.06.52.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:52:54 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 4/4] date.c: allow compact version of ISO-8601 datetime
Date:   Thu, 23 Apr 2020 20:52:41 +0700
Message-Id: <2812439a26c3c98150bb7be3c6e603e2ed95fab3.1587644889.git.congdanhqx@gmail.com>
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

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c          | 14 ++++++++++++++
 t/t0006-date.sh |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/date.c b/date.c
index 5d635031e0..0c66e5a5ae 100644
--- a/date.c
+++ b/date.c
@@ -682,6 +682,20 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
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

