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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C7C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912022076C
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwxPnVuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgDWNwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728506AbgDWNwy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:52:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8676CC08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:54 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a7so2533293pju.2
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqDp34wYEx7XQtXTcUgUTfsBDYojN9icFny+gUg4q0Y=;
        b=KwxPnVuYg18ZqFESD00stV9fDLh+uNijaJOAJlNNCn1IgiTVXR6/3ofrO/pAn1ir1Z
         p2uAJ7IohzSq2rsPD/tS4wiA3GVi1EYiyV+JvQr50t5UOcKDSVlku5I3cWQ9DX2K2/5/
         w6mvnVK/cEc69h/HXdBOzfHJALzWfbzksQdNmjKDwcArUV+7xw3bVNcLmza+SY8Yltfm
         50j8tU8RhHVjRRlka36Jv1f15GgjK1Fk0iXbcurbmf6ovrmI6Uswhp2ROSnQ3x/9Hpn0
         n+HSl6seOLCi1T3a4J9TRdEU3nPlBRYuiYqUuC/VUCIwvXmFQa7HNA1xnOiYZldiH6+4
         973w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqDp34wYEx7XQtXTcUgUTfsBDYojN9icFny+gUg4q0Y=;
        b=gnKn7aoTLRnicQzWvg2MVT30PrplfskVetMR0VAO/T4xswrD30Wn48743PE+dXk3to
         oDeq9ucrIznY35ajKO7WRzBsr47mXZaPml+pBgBIfGkQADnH9NYj8/N4IOtcnqo8fhIW
         6FYa9wM8/sOirst1Q8iyTS0K1car/xiVKuv47ZXXQPmSHuZs8IRTmAIoC+K9P1/0PSBC
         XzzniqUFqE0qgCv3JHKSovIJd1Vr1hsrHrzvckgqP/Mr2Ae3qU5/PhrEVtpbVsK+prKW
         Rir0GOovJX4QbJkayMV1mxybl0V40irxaBAVBVlqiKkHlJ1nKcamThqNOHKc6w75lR+u
         pyuQ==
X-Gm-Message-State: AGi0PuYhALduDISkbILuR5D6h6Gm8oH240pkUwHL2kiqupn3E902+hqU
        VPlW8abROzmoNbQUbdrqwPv2eA2h
X-Google-Smtp-Source: APiQypJgfvLNpgxR4Bx571FXaG/TKhohkfntGC7xmFBXCwQ80wqScE1FcLs5ofZ+QEeTe8OQvzhmXw==
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr3743479plo.314.1587649973654;
        Thu, 23 Apr 2020 06:52:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id u15sm2430335pjm.47.2020.04.23.06.52.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:52:53 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 3/4] date.c: skip fractional second part of ISO-8601
Date:   Thu, 23 Apr 2020 20:52:40 +0700
Message-Id: <8b18d0ee5d6f08394e54e16ca7618c687791a509.1587644889.git.congdanhqx@gmail.com>
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
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/date-formats.txt | 5 ++++-
 date.c                         | 8 +++++++-
 t/t0006-date.sh                | 3 +++
 3 files changed, 14 insertions(+), 2 deletions(-)

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
index f5d5a91208..5d635031e0 100644
--- a/date.c
+++ b/date.c
@@ -570,8 +570,14 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
 	/* Time? Date? */
 	switch (c) {
 	case ':':
-		if (num3 < 0)
+		if (num3 < 0) {
 			num3 = 0;
+		} else if (*end == '.' && isdigit(end[1]) &&
+			   tm->tm_year != -1 && tm->tm_mon != -1 && tm->tm_mday != -1 &&
+			   set_time(num, num2, num3, tm) == 0) {
+			/* %Y%m%d is known, ignore fractional <num4> in HHMMSS.<num4> */
+			strtol(end + 1, &end, 10);
+		}
 		if (set_time(num, num2, num3, tm) == 0)
 			break;
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

