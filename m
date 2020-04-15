Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231CBC38A29
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0353920774
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHoKCCOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389589AbgDODcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389586AbgDODcV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 23:32:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9B2C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:32:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r4so889178pgg.4
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlCWALeOKz/HB7KiXE0uAcBp08Kxyn0g1lr2JBoYhAk=;
        b=RHoKCCOElIVOMvJJnyrHiyT0V3U9JR2scYA33BqOdzkHyDP6ONyE6/xmO4uCGXHjZ3
         HXInnwXN5JuDtPs5CPrXWqlqxJ8p36YO7kaZidwzvxIZU+zEe1W7pUFRmUwtJgyfiYT1
         juzTg86wjZ+OMSQWGo0nRmWbs6YvXHG8j7BG4DA3ePLpiUgDNQAEolPkIKN5Wmv+lvpI
         HbkfSCKOeJNfIo/zUwuwFa9Lq45T1BX7RosAnggkskz4PwX0HAOMNlHDwy6LidDrXkZ5
         SzvDh4lMc+Hm1czIANLjFgUE0Lx2MiadS6QP3yElkpXaawtPUNxz2perfaGP3AQ11cCT
         sIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlCWALeOKz/HB7KiXE0uAcBp08Kxyn0g1lr2JBoYhAk=;
        b=d0djwAGx2Q3Z3XEEnHghyRw+HgfhhUA2gBAk7jgoBng5xGgjaSunPxaBjd6LHPoL18
         WnqeO92JbYoAaoVSIYR3Wa5We4Wy9qPDYhdlAEkBMMWaBIZkwYBT0+Q69YUAAbziVnT6
         5aqNSlD1pdk2nF5px3WJroQekd0UzOzDyhzNudrT2NdLmkI/00Fjx1NdiGb7DAFe0/1i
         M0IZOPJ4gB6H5/zBIjGQ9pa4Pidu+LBvdHZqz8sREkWxg0MdTdmiqWD9K5EGPcTaerNC
         R2yVdOnNFN89mA2Est817v3PlOYkyejrO00mXwc9OJyed655Xzn0MVe0OSs6ZmsdBdGv
         sM0w==
X-Gm-Message-State: AGi0PuYOlvRP3jzuqJDZNbPoejlh2Cf5g3PVT0vf0JSsgfZINyZ2OTlr
        NQFv5+trA4Jwh/XoLhRH0LLXTnW8
X-Google-Smtp-Source: APiQypJWARRuBmj4WHy4EQuy/1EZZ4hL5hwT9aRQAA4A+pZbDGFHiUKk9fkyCKNIc548uN3YJNjl2w==
X-Received: by 2002:a63:2c87:: with SMTP id s129mr26497929pgs.406.1586921540934;
        Tue, 14 Apr 2020 20:32:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id f30sm13174056pje.29.2020.04.14.20.32.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 20:32:20 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 2/2] date.c: allow compact version of ISO-8601 datetime
Date:   Wed, 15 Apr 2020 10:31:28 +0700
Message-Id: <36517af87298ebeb714511534bd180983905c67f.1586921235.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.485.g42af89717d
In-Reply-To: <cover.1586921235.git.congdanhqx@gmail.com>
References: <cover.1586856398.git.congdanhqx@gmail.com> <cover.1586921235.git.congdanhqx@gmail.com>
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
index 2f37397beb..fc42382cfa 100644
--- a/date.c
+++ b/date.c
@@ -666,6 +666,28 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
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
index d582dea5c5..1e169c8d15 100755
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
2.26.0.485.g42af89717d

