Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46722C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B16A20706
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adhLHR18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgDXPHk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbgDXPHj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 11:07:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B621EC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j7so4738814pgj.13
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSnRW6mPN1aestSMpDxR/PPAzRVtbanyrTq+bP+TnfE=;
        b=adhLHR18v2Xg22Rzd4jw5w5II75m8n3yCS1jPXJvQc5wrwmreC8DpbNgt9M5skeQ0P
         tZRKDnrD0NeO4ipkYVJhcLwj2GcJ2r7vy+YrltxXmBX8aLzGRT/QMASDf2pi6tIP0qLK
         RgEcBSV50eaLJdvoF/y3Uslj7cgjnVGTMChBCcKRpMGko4kXsfZw+2IJ10/y2zYb4YU4
         S6bAHFVFISIu0MngjKnwfrSXLeVYCs9nXae6QnmkPo568MOON9hFTDkPfFWITCGE8MF1
         C2NGMapjiA9kJ0nytAdVlubY4ZYZxmwm342D/5j9U/Q3eQthcVzqj3oIZiHNhO90kP3Q
         MJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSnRW6mPN1aestSMpDxR/PPAzRVtbanyrTq+bP+TnfE=;
        b=Aoxi32UEayb+GiEXYr4EbTIYTtU0hAYBzYDFVcoNHDHDbrSKsxEtQVSzI15h+yI3n2
         DdcXqAUVd0rQ03xP9Ni8LQalNmbq4PvxQrdHpCVMD0tHhkZrOoIOrSmXbXWohEqiUoBM
         CBiVu7P1jpUKlfW+YcjSzHV6YvtEAlMZzp75UE9XYeKhwVWyBBswbeUYAU8XhNPdYfSS
         0beZZ093bsnGoYFmnzSu3+Xop7YO5eJOTPDw5rCNrfKq2ZIE0/tlaYzTPeN736qxRVSD
         TzjM2YPI8chb+AVv2rfKqvs937C/T7m9NA0Ko1tiSqK4gOiyZDFcJEUDfDrwIsML36Fz
         kwtQ==
X-Gm-Message-State: AGi0PuaymdD1uu7b9EleUmX5CU4mrdwg0WvK1byTxygemfVys9ZOfxlT
        JT5gEifFfkhzH1FXRQFyORyjF4Bg42w=
X-Google-Smtp-Source: APiQypKIfj+itDyewqhNwiQqm5sOk0wViC67LPwKMmhs2RNKFDxhj1g1HcbQh58mIIyavGo0PzgMIQ==
X-Received: by 2002:a63:40f:: with SMTP id 15mr9652574pge.57.1587740858855;
        Fri, 24 Apr 2020 08:07:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id c84sm6417052pfb.153.2020.04.24.08.07.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:07:37 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/4] More ISO-8601 support
Date:   Fri, 24 Apr 2020 22:07:28 +0700
Message-Id: <cover.1587740682.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.384.g435bf60bd5
In-Reply-To: <cover.1586856398.git.congdanhqx@gmail.com>
References: <cover.1586856398.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims to extend support for ISO-8601 datetime format
to allow compact version, and fractional part of ISO-8601.

Change in v5 from v4:
* cleanup [3/4] following Junio's suggestion.

Changes in v4 from v3:
* s/is_date/set_date/ the function's name suggest it only does validation,
  but it does more than that. Junio suggested to me to use it for validation,
  When I looked more into it, I think it's better to not use it, and rename
  the function to reduce the confusion
* Extract the validate and set time to its own function
* Correct a check for time in compact ISO-8601

Changes in v3 from v2:
* Add example for fractional parts of second in documentation
* Add/Fix regression test on 12:34:56.7.days.ago

Đoàn Trần Công Danh (4):
  date.c: s/is_date/set_date/
  date.c: validate and set time in a helper function
  date.c: skip fractional second part of ISO-8601
  date.c: allow compact version of ISO-8601 datetime

Đoàn Trần Công Danh (4):
  date.c: s/is_date/set_date/
  date.c: validate and set time in a helper function
  date.c: skip fractional second part of ISO-8601
  date.c: allow compact version of ISO-8601 datetime

 Documentation/date-formats.txt |  5 ++-
 date.c                         | 67 ++++++++++++++++++++++++++--------
 t/t0006-date.sh                |  6 +++
 3 files changed, 62 insertions(+), 16 deletions(-)

Range-diff against v4:
1:  1fe69008fc = 1:  1fe69008fc date.c: s/is_date/set_date/
2:  0d0e4d8edc ! 2:  a6b97b19f2 date.c: validate and set time in a helper function
    @@ Commit message
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    +
    + ## Notes ##
    +    I intentionally leave a pair of bracket around if (set_time(...))
    +    to reduce the noise in next patch
    +
      ## date.c ##
     @@ date.c: static int set_date(int year, int month, int day, struct tm *now_tm, time_t now,
      	return -1;
    @@ date.c: static int set_date(int year, int month, int day, struct tm *now_tm, tim
      
     +static int set_time(long hour, long minute, long second, struct tm *tm)
     +{
    -+	/* C90 and old POSIX accepts 2 leap seconds, it's a defect,
    -+	 * ignore second number 61
    -+	 */
    ++	/* We accept 61st second because of leap second */
     +	if (0 <= hour && hour <= 24 &&
     +	    0 <= minute && minute < 60 &&
     +	    0 <= second && second <= 60) {
    @@ date.c: static int match_multi_number(timestamp_t num, char c, const char *date,
     -			tm->tm_hour = num;
     -			tm->tm_min = num2;
     -			tm->tm_sec = num3;
    -+		if (set_time(num, num2, num3, tm) == 0)
    ++		if (set_time(num, num2, num3, tm) == 0) {
      			break;
    --		}
    + 		}
      		return 0;
    - 
    - 	case '-':
3:  8b18d0ee5d ! 3:  f21aa2dcf5 date.c: skip fractional second part of ISO-8601
    @@ Commit message
         relative to current time.
     
         Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Documentation/date-formats.txt ##
    @@ Documentation/date-formats.txt: RFC 2822::
      `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
     
      ## date.c ##
    +@@ date.c: static int set_time(long hour, long minute, long second, struct tm *tm)
    + 	return -1;
    + }
    + 
    ++static int is_date_known(struct tm *tm)
    ++{
    ++	return tm->tm_year != -1 && tm->tm_mon != -1 && tm->tm_mday != -1;
    ++}
    ++
    + static int match_multi_number(timestamp_t num, char c, const char *date,
    + 			      char *end, struct tm *tm, time_t now)
    + {
     @@ date.c: static int match_multi_number(timestamp_t num, char c, const char *date,
    - 	/* Time? Date? */
    - 	switch (c) {
    - 	case ':':
    --		if (num3 < 0)
    -+		if (num3 < 0) {
    + 		if (num3 < 0)
      			num3 = 0;
    -+		} else if (*end == '.' && isdigit(end[1]) &&
    -+			   tm->tm_year != -1 && tm->tm_mon != -1 && tm->tm_mday != -1 &&
    -+			   set_time(num, num2, num3, tm) == 0) {
    -+			/* %Y%m%d is known, ignore fractional <num4> in HHMMSS.<num4> */
    -+			strtol(end + 1, &end, 10);
    -+		}
    - 		if (set_time(num, num2, num3, tm) == 0)
    + 		if (set_time(num, num2, num3, tm) == 0) {
    ++			/*
    ++			 * If %H:%M:%S was just parsed followed by: .<num4>
    ++			 * Consider (& discard) it as fractional second
    ++			 * if %Y%m%d is parsed before.
    ++			 */
    ++			if (*end == '.' && isdigit(end[1]) && is_date_known(tm))
    ++				strtol(end + 1, &end, 10);
      			break;
    + 		}
      		return 0;
     
      ## t/t0006-date.sh ##
4:  2812439a26 = 4:  51aa60c069 date.c: allow compact version of ISO-8601 datetime
-- 
2.26.2.384.g435bf60bd5

