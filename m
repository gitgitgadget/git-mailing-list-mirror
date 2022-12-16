Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D406AC4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 03:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLPDiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 22:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPDiN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 22:38:13 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD841DA75
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 19:38:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a14so966050pfa.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/YB/bkYiFdPxVuIl3rzDXP8sUy3C6a9Ak5QxMLnwzs=;
        b=Yl+38RK5y1RZqGZO+BK5Q5B0X6WBRo2m07z1NfDm2DfVZQJ3OGZ0Pad1aYVs577hOQ
         yPr/7vnbPJ9o1tsiu1Ak2q18CGOaYW/lq2wlcy9e9fSbIIdmE2RVJOGxjQbkfD1O2zBg
         b5MHv9ZY3EMGera9jaSSZ62YQBOe2rrFp4nPgSP5CSIlNPqHlvyPrUS5mmqSx7ksdKsg
         AgiAsZFJJYt0HKg7O1GD/ApVvL37FjzhNAiBSPHvLCAkqCgSb2P+I5SwEz0PLhk3kFPO
         NzoW119FDAb3/VJ9RhQy9bB/eA1lFn13hjQUuZKCAZZbG9dxkI4cPnAElJC6W/zjp+EC
         39UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/YB/bkYiFdPxVuIl3rzDXP8sUy3C6a9Ak5QxMLnwzs=;
        b=PeF2TGFDgAe5y76IGsR3JsIimfbn0NbJez0TB/GkqqclGptruESwKeeRMjSUuVUt4z
         64SWOVH32lRUrxyJHPj8ey8oBCNDAh3hBz2fscaklby82TFH0dXrEsH4AChuz8Fnp/jd
         lFX2lVegIcvIkBbF1Krz7gahfdYRvUW8OyooZzkzt8aon6GMgj68HXi1Bfh4q09ukp4e
         NiggC451ELUb7B4Um2/Fic8XEi8IZTZnr0adLU+RG+Ejv0IHHgVhxtqFa7pjtYC6SGYP
         1TTanfeMvhGrexdZ6hsexYjKduhaBwlsO7kNkeGPu3xDECk293ZkAwsxe83IlT20MQQ/
         lv4A==
X-Gm-Message-State: ANoB5pkRskix+5rUOib8HzqHgm4+DuTORYWTP2a45PQboZHlMdkPDazI
        j9s9orDXol//WnxWX9QFwN24p+VgGl993A==
X-Google-Smtp-Source: AA0mqf6Y5oRMHfuFgrurxBq4+f2u1ra8jbiNXD27Kmo0bCZGX2tLxM3sxuR+A/hPWNXHz/zh4Hh2Yg==
X-Received: by 2002:a05:6a00:bd8:b0:576:65f5:c60a with SMTP id x24-20020a056a000bd800b0057665f5c60amr27017165pfu.27.1671161892120;
        Thu, 15 Dec 2022 19:38:12 -0800 (PST)
Received: from phord-x1y5.purestorage.com ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id i22-20020aa796f6000000b0057630286100sm106253pfq.164.2022.12.15.19.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 19:38:11 -0800 (PST)
From:   Phil Hord <phil.hord@gmail.com>
X-Google-Original-From: Phil Hord
To:     git@vger.kernel.org
Cc:     congdanhqx@gmail.com, plavarre@purestorage.com,
        Phil Hord <phil.hord@gmail.com>
Subject: [PATCH] date.c: allow ISO 8601 reduced precision times
Date:   Thu, 15 Dec 2022 19:36:39 -0800
Message-Id: <20221216033638.2582956-1-phil.hord@gmail.com>
X-Mailer: git-send-email 2.39.0.56.g57e2c6ebbe
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phil Hord <phil.hord@gmail.com>

ISO 8601 permits "reduced precision" time representations to omit the
seconds value or both the minutes and the seconds values.  The
abbreviate times could look like 17:45 or 1745 to omit the seconds,
or simply as 17 to omit both the minutes and the seconds.

parse_date_basic accepts the 17:45 format but it rejects the other two.
Fix it to accept 4-digit and 2-digit time values when they follow a
recognized date but no time has yet been parsed.

Add tests for these formats and some others, with and without colons.

Before this change:

$ test-tool date approxidate 2022-12-13T23:00 2022-12-13T2300 2022-12-13T23
2022-12-13T23:00 -> 2022-12-14 07:00:00 +0000
2022-12-13T2300 -> 2022-12-14 03:00:55 +0000
2022-12-13T23 -> 2022-12-14 03:00:55 +0000

After this change:

$ test-tool date approxidate 2022-12-13T23:00 2022-12-13T2300 2022-12-13T23
2022-12-13T23:00 -> 2022-12-14 07:00:00 +0000
2022-12-13T2300 -> 2022-12-14 07:00:00 +0000
2022-12-13T23 -> 2022-12-14 07:00:00 +0000

Note: ISO 8601 also allows reduced precision date strings such as
"2022-12" and "2022". This patch does not attempt to address these.

Reported-by: Pat LaVarre <plavarre@purestorage.com>
Signed-off-by: Phil Hord <phil.hord@gmail.com>
---
 date.c          | 22 +++++++++++++++++++++-
 t/t0006-date.sh |  6 ++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 53bd6a7932..b011b9d6b3 100644
--- a/date.c
+++ b/date.c
@@ -638,6 +638,18 @@ static inline int nodate(struct tm *tm)
 		tm->tm_sec) < 0;
 }
 
+/*
+ * Have we filled in any part of the time yet?
+ * We just do a binary 'and' to see if the sign bit
+ * is set in all the values.
+ */
+static inline int notime(struct tm *tm)
+{
+	return (tm->tm_hour &
+		tm->tm_min &
+		tm->tm_sec) < 0;
+}
+
 /*
  * We've seen a digit. Time? Year? Date?
  */
@@ -689,7 +701,11 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 
 	/* 8 digits, compact style of ISO-8601's date: YYYYmmDD */
 	/* 6 digits, compact style of ISO-8601's time: HHMMSS */
-	if (n == 8 || n == 6) {
+	/* 4 digits, compact style of ISO-8601's time: HHMM */
+	/* 2 digits, compact style of ISO-8601's time: HH */
+	if (n == 8 || n == 6 ||
+		(!nodate(tm) && notime(tm) &&
+		(n == 4 || n == 2))) {
 		unsigned int num1 = num / 10000;
 		unsigned int num2 = (num % 10000) / 100;
 		unsigned int num3 = num % 100;
@@ -698,6 +714,10 @@ static int match_digit(const char *date, struct tm *tm, int *offset, int *tm_gmt
 		else if (n == 6 && set_time(num1, num2, num3, tm) == 0 &&
 			 *end == '.' && isdigit(end[1]))
 			strtoul(end + 1, &end, 10);
+		else if (n == 4)
+			set_time(num2, num3, 0, tm);
+		else if (n == 2)
+			set_time(num3, 0, 0, tm);
 		return end - date;
 	}
 
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 2490162071..16fb0bf4bd 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -88,6 +88,12 @@ check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
 check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '20080214T20:30:45' '2008-02-14 20:30:45 +0000'
+check_parse '20080214T20:30' '2008-02-14 20:30:00 +0000'
+check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
+check_parse '20080214T203045' '2008-02-14 20:30:45 +0000'
+check_parse '20080214T2030' '2008-02-14 20:30:00 +0000'
+check_parse '20080214T20' '2008-02-14 20:00:00 +0000'
 check_parse '20080214T203045-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '20080214T203045 -04:00' '2008-02-14 20:30:45 -0400'
 check_parse '20080214T203045.019-04:00' '2008-02-14 20:30:45 -0400'
-- 
2.39.0.56.g57e2c6ebbe

