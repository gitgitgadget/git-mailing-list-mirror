Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D247DC55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 13:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8372077D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 13:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rE2SYTHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgDVNQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgDVNQH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 09:16:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF81C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 06:16:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id p8so1068689pgi.5
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mj8ovKNmLxHDqTOptWCIr5bRocgOGuSr3i+eWf94Uug=;
        b=rE2SYTHvU+LX0Xrd+40Bku4jYPw5ZwwWJKpPUfDW5N0HznF+0GYoH9sR+nz9YFRADF
         T14XsBJ9UqkBiKZaS6HxJySRqmgwBRxQu1VGNeiWcwuxrMIpkQcBjeGYQ82ObEV5dQ/j
         nv39q8q/9uz2BbqvlJesniomatPMCZWrwDie0inbGdFmvlWpVxN6yzuHFVzfehJipTgh
         iphTLVPpruJLCJFWc2QsJKDMAIflR8FdGxdNM9B01vAX64SnMNer3qt7VK/ZGQxCnCVG
         q74Mr/zQ2M5H9R7j3DDzrybutSgZDdwre5bo7qSN3/C2TplH3cj/Zg0TlogP0531rRTN
         6O/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mj8ovKNmLxHDqTOptWCIr5bRocgOGuSr3i+eWf94Uug=;
        b=jp5B4qbJeFV/OGfDk4U0J2IVl4F59Cx43zyP4vTfYHSi3MvbPlijsqq90b6l2e/eWz
         P/rPAOcj0CAke4lvDlLm+u7BmxDafp1/VH5Sfp4ey8YQmzQaOBakE8ljbO6AuLzBFGjR
         l+6K2NA81/4Mxooqd0MLwd+1QU3ZOID5o197YlFmq2nIb9aiIkWxbfGjiQQszyS05uVn
         pvkqhpx1hTpPCLnePRklGoZkREw5DIl8dwwPzKKgd7XmMSWpMgqpSWufd7Aog6vuekJB
         YEdB5KC0sQyIk5+9w+fOtwIOFSTnpymTFQks/jU8/OkNxDFfhmBJthidx2dEpGGME5Ys
         +dxg==
X-Gm-Message-State: AGi0PuYzDJBMYx/mffl/Xmnac6Y1K2d8p9iJ2kzdHhB/4BMAYN/JD5Vd
        VQ9QmK3AN7wPygbo9z9yXOG8zk3/
X-Google-Smtp-Source: APiQypKlIHO0riThdtSQ1aEZRpLMJf++DD9Z4Xs4CLC+D59MAHLY0FD2cr7OFtbAoKLOTZaBDG6wsQ==
X-Received: by 2002:a63:ef4b:: with SMTP id c11mr24571186pgk.400.1587561367077;
        Wed, 22 Apr 2020 06:16:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id 192sm5412635pfu.182.2020.04.22.06.16.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 06:16:06 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 2/2] date.c: allow compact version of ISO-8601 datetime
Date:   Wed, 22 Apr 2020 20:15:53 +0700
Message-Id: <225b6401bd1f7eddc245acfd2c4b37c50c978491.1587559135.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a78
In-Reply-To: <cover.1587559135.git.congdanhqx@gmail.com>
References: <cover.1586856398.git.congdanhqx@gmail.com> <cover.1587559135.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 date.c          | 22 ++++++++++++++++++++++
 t/t0006-date.sh |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/date.c b/date.c
index 62f23b4702..882242c2db 100644
--- a/date.c
+++ b/date.c
@@ -672,6 +672,28 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 		n++;
 	} while (isdigit(date[n]));
 
+	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
+	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
+	if (n == 8 || n == 6) {
+		unsigned int num1 = num / 10000;
+		unsigned int num2 = (num % 10000) / 100;
+		unsigned int num3 = num % 100;
+		if (n == 8 && num1 > 1900 &&
+		    num2 > 0 && num2 <= 12 &&
+		    num3 > 0  && num3 <= 31) {
+			tm->tm_year = num1 - 1900;
+			tm->tm_mon  = num2 - 1;
+			tm->tm_mday = num3;
+		} else if (n == 6 && num1 < 60 && num2 < 60 && num3 <= 60) {
+			tm->tm_hour = num1;
+			tm->tm_min  = num2;
+			tm->tm_sec  = num3;
+			if (*end == '.' && isdigit(end[1]))
+				strtoul(end + 1, &end, 10);
+		}
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
2.26.2.303.gf8c07b1a78

