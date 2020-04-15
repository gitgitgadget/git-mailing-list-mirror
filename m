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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95411C352BE
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B3320774
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE3JWT55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbgDODcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389523AbgDODcU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 23:32:20 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F5C061A0E
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:32:19 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a22so1741645pjk.5
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBb9N2XcN/6HN4tixp4R7duMqWAHjS9bFMltyr1EAaU=;
        b=gE3JWT55bJx9gpNDNpBaS8widMCG2RtgfkURaU5TEKR6siHR0ur+xzo0rhLqPOamg+
         rcvzZgEoJwbY9xvGRtRcf2RNo0oiB21QdCMMAoEcwz8+rrF55Kp2Ark6mX26nrYTbX2K
         3Ovsf/qA5lNUsuObqZGEj55OYfG9gPcQ9i4yQSi+p/dCrLFc/mbtvKIplno3Zma3Zm99
         iGrR2t9Ha2sorB3FPlSwlXPXlc4NQ3z/rgs5yge5MXJlhwqhwPoX9UizTZtE2xD4ApQU
         xY/rZi0gxc1lHF0/ZjfK60dY7Du2rUU9Ti/B73+c+Erzabf3cr8gnQzjyjPr0Zvpz5Mb
         6/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBb9N2XcN/6HN4tixp4R7duMqWAHjS9bFMltyr1EAaU=;
        b=dSdiE+lNuo/Dfd3OypUeeAx22COMbNSfWTgwV1ra20pvOcMHP5uAXj9w5GQMuwfZz3
         UFN1oa+nmch/DHYlvxHD0MVF/xSgFSB87uvXQImo7kFbeDUpqKraKv/7IQuH5+X9yR9Q
         XWpKAn6F4SOZl7fnM6mOG3U4udxGDc8o9k3d3X0r7MXY6vSXt0SRyWEtIr6iUoOk13IO
         cKdEZBzQl9yS6HZGHFxnsstIm9eTI8rfebilT5TuaZuR9HiDwfQrImdkddFhzFbYZbb0
         vlpYPVDtjX3VduKn7e3AdS192axvX1T0fUQHnl3XAFX7Sa7j68iohIxVkFov4xIvmSh8
         2xpg==
X-Gm-Message-State: AGi0Pua348OEMPsH7ddABBWygOnM2zzX6EEj0SSyfqTE7BwrtFBafRHt
        yAwIRalrgRAm963kaej4H6KipcCe
X-Google-Smtp-Source: APiQypKVOFlQERG9NMmVHEyJMEe9OexFuZBrUfVIT/t8vznCn2h+D0AZU6NvTWCmHAitOrs+lM7T1g==
X-Received: by 2002:a17:902:8682:: with SMTP id g2mr2951347plo.93.1586921539223;
        Tue, 14 Apr 2020 20:32:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id f30sm13174056pje.29.2020.04.14.20.32.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 20:32:18 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/2] date.c: skip fractional second part of ISO-8601
Date:   Wed, 15 Apr 2020 10:31:27 +0700
Message-Id: <03f3e9968bc29b758f2dd32434c9e8d19f624fdd.1586921235.git.congdanhqx@gmail.com>
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

git-commit(1) says ISO-8601 is one of our supported date format.

ISO-8601 allows timestamps to have a fractional number of seconds.
We represent time only in terms of whole seconds, so we never bothered
parsing fractional seconds. However, it's better for us to parse and
throw away the fractional part than to refuse to parse the timestamp
at all.

And refusing parsing fractional second part may confuse the parse to
think fractional and timezone as day and month in this example:

	2008-02-14 20:30:45.019-04:00

Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/date-formats.txt | 2 +-
 date.c                         | 2 ++
 t/t0006-date.sh                | 2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 6926e0a4c8..6f69ba2ddd 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -20,7 +20,7 @@ RFC 2822::
 ISO 8601::
 	Time and date specified by the ISO 8601 standard, for example
 	`2005-04-07T22:13:13`. The parser accepts a space instead of the
-	`T` character as well.
+	`T` character as well. The fractional part will be ignored.
 +
 NOTE: In addition, the date part is accepted in the following formats:
 `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
diff --git a/date.c b/date.c
index b0d9a8421d..2f37397beb 100644
--- a/date.c
+++ b/date.c
@@ -556,6 +556,8 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 	case ':':
 		if (num3 < 0)
 			num3 = 0;
+		else if (*end == '.' && isdigit(end[1]))
+			strtol(end + 1, &end, 10);
 		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
 			tm->tm_hour = num;
 			tm->tm_min = num2;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index d9fcc829a9..d582dea5c5 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -81,6 +81,8 @@ check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
 check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
 check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
-- 
2.26.0.485.g42af89717d

