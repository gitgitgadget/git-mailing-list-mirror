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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D34C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB0A20706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6y/2E3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgDXPHq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbgDXPHp (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:07:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95418C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w65so4906885pfc.12
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSgIdBrblGujAom4AvXN2fkyFzuwohyV2jwW3Uz01ZA=;
        b=k6y/2E3y/Guutfm3TRjN8+HI3BbbAWYgeF1PhckHAEGv/6SQtSGNPpylI/ZryHFl5j
         +xfUV3vOmcWuth7V8ub+v/LIr1C53xCRpRtFB/jmWkFsCefWNDoz3zkj2qJQvwZ8vBSJ
         1ibmm0HfT7GpN3JeUaNm0B4gWQS2OzuXNiaOfV+dPzSQmk3sTJQ/u2ffkW5BSP/CPxW7
         BXJCoxmwv1Gkre1OnAI4/EMlu8Xnprzx7KLseKeqHka5TRnvJ+YWiqrapf1oZVkAc727
         CGNy1C0+gxM0O0L4qZTfEYDXWMu/V0i4/I9UJ2noWOkbswse+Bu8jHhTYJr5S1SBuFiO
         DByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSgIdBrblGujAom4AvXN2fkyFzuwohyV2jwW3Uz01ZA=;
        b=hEW/rBJuxN8Cm2dYkFN3PozXnVcih4ULmo28SlEElE/qCB9qAfqw56kT1CtSXxmy8Y
         4cdN+1iJHVqPR01VA6LTMff0kczOiOUPjhEAQJIQDgc1KwGcJxEFDeRYBWTYMLe51EPy
         onlZ+UwUit1Lo/FiwAn4ihPvp1vQXKipTRaBpGwC9OZAciAYlkwu1rPfdABM22FJ4lMO
         cOucZqmsKNjoKUntIla44txYSN2uRZYZxFuJHc8nAs7xDRIdGoTcYCTcuHD3glkgTeGf
         zKG1/3NaxIWlljCNmw01PcBb64TddftMMPHuTTDrvSWOX/jmSv4rLuPmNHfnEJad/9A1
         pjzQ==
X-Gm-Message-State: AGi0Pua/X65waX5CJxgQ/UVXnvDVvmKC7tROE4W/b75zGTS5RfqMJYL/
        EYWgS0mJjPkji62dnv0G1v2JFStExlY=
X-Google-Smtp-Source: APiQypLHY37cey7n6jbYONmFsQSkvg+qb1LOARL/gkJF7VX29ZxeAoJj3hT6Inb7s37tfaWtcoYnTg==
X-Received: by 2002:a63:4a59:: with SMTP id j25mr9417432pgl.336.1587740864760;
        Fri, 24 Apr 2020 08:07:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id c84sm6417052pfb.153.2020.04.24.08.07.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:07:44 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 3/4] date.c: skip fractional second part of ISO-8601
Date:   Fri, 24 Apr 2020 22:07:31 +0700
Message-Id: <f21aa2dcf507f9eb13a623b6718a170d2661f15d.1587740682.git.congdanhqx@gmail.com>
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

git-commit(1) says ISO-8601 is one of our supported date format.

ISO-8601 allows timestamps to have a fractional number of seconds.
We represent time only in terms of whole seconds, so we never bothered
parsing fractional seconds. However, it's better for us to parse and
throw away the fractional part than to refuse to parse the timestamp
at all.

And refusing parsing fractional second part may confuse the parse to
think fractional and timezone as day and month in this example:

	2008-02-14 20:30:45.019-04:00

While doing this, make sure that we only interpret the number after the
second and the dot as fractional when and only when the date is known,
since only ISO-8601 allows the fractional part, and we've taught our
users to interpret "12:34:56.7.days.ago" as a way to specify a time
relative to current time.

Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/date-formats.txt |  5 ++++-
 date.c                         | 12 ++++++++++++
 t/t0006-date.sh                |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 6926e0a4c8..7e7eaba643 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -20,7 +20,10 @@ RFC 2822::
 ISO 8601::
 	Time and date specified by the ISO 8601 standard, for example
 	`2005-04-07T22:13:13`. The parser accepts a space instead of the
-	`T` character as well.
+	`T` character as well. Fractional parts of a second will be ignored,
+	for example `2005-04-07T22:13:13.019` will be treated as
+	`2005-04-07T22:13:13`
+
 +
 NOTE: In addition, the date part is accepted in the following formats:
 `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
diff --git a/date.c b/date.c
index fa39e5e8a5..2c9071d53f 100644
--- a/date.c
+++ b/date.c
@@ -553,6 +553,11 @@ static int set_time(long hour, long minute, long second, struct tm *tm)
 	return -1;
 }
 
+static int is_date_known(struct tm *tm)
+{
+	return tm->tm_year != -1 && tm->tm_mon != -1 && tm->tm_mday != -1;
+}
+
 static int match_multi_number(timestamp_t num, char c, const char *date,
 			      char *end, struct tm *tm, time_t now)
 {
@@ -571,6 +576,13 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 		if (num3 < 0)
 			num3 = 0;
 		if (set_time(num, num2, num3, tm) == 0) {
+			/*
+			 * If %H:%M:%S was just parsed followed by: .<num4>
+			 * Consider (& discard) it as fractional second
+			 * if %Y%m%d is parsed before.
+			 */
+			if (*end == '.' && isdigit(end[1]) && is_date_known(tm))
+				strtol(end + 1, &end, 10);
 			break;
 		}
 		return 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index d9fcc829a9..80917c81c3 100755
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
@@ -103,6 +105,7 @@ check_approxidate 5.seconds.ago '2009-08-30 19:19:55'
 check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
 check_approxidate yesterday '2009-08-29 19:20:00'
 check_approxidate 3.days.ago '2009-08-27 19:20:00'
+check_approxidate '12:34:56.3.days.ago' '2009-08-27 12:34:56'
 check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
 check_approxidate 3.months.ago '2009-05-30 19:20:00'
 check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
-- 
2.26.2.384.g435bf60bd5

