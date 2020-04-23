Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8258DC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A68520728
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 13:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSgESXpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgDWNwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728506AbgDWNwt (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 09:52:49 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA5CC08E934
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:49 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so1751248pfv.8
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPZlT3WpmFqDBf+Fhs4SbDyM8NE1b/s9eCN1qdqqmk8=;
        b=KSgESXpwFUGDxGrjORa95OItzB57L3lQRb3NRT3Zi7ytENqHfS2nv+P4HGptsLSJz+
         DB3fYcg+nevtgBnJxvu4/2/0kuMxMD0uZSusXUuiWBeP49nRnZ1YpQWcgEO6U7Agkcxf
         jxeakFXhhji++lif+xJQb98GpD5B4j/ta2gK5W+OauTu9gRBcqZmI95G2gNyNAKIi7uz
         0OyN4WF99weNFGWkg3ocbf5f9dv7B8q0TXXaa+Jrh+Qj6cmfhNLwtQw4XwitMP1RZbSR
         KIQD24Arv9IVuBrm5r2LpeyrGcr6ib+ZFS183SQtz3r+rAwyv9IROM/E7crTgmktRtUq
         YhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPZlT3WpmFqDBf+Fhs4SbDyM8NE1b/s9eCN1qdqqmk8=;
        b=WSty8lxkOOKVlO5QCrs0piH8uD+1H0lZleO/0cJFTEaGTiaf5hPKoOSLZYcFTZohhd
         2nAPefu5RFh3Hu+yCvWDzCSV9OsHKhdurqZI03mQbBSPyriEkDrzwWFSB7mksAxbquZv
         4ODD5vg0aG9hgptqgAJjX7J7v1fPNhavv/xcGJCPigG54COoruXoMRg0ZB1Vk87lxFA0
         RJrLUIJ1TmoF/X2UEgj3w95/v7KPyFFwSfWZHA0VRMNdXarcXC8y8aOyejrKH0xx/TMO
         NGGh7mPd565tBwX7ZOlQNTWJYfDS57gxxUY5jaCxBDkDC2gj1BO+DamTK9/Wky7F6giZ
         Exjg==
X-Gm-Message-State: AGi0Puap6EFreYuk4id1VxDgyPDd0G5EL5nLaXI25r9wDxanf9QtURO+
        aJr0NdtpwAL5hs6DugWi8ryx7zab
X-Google-Smtp-Source: APiQypLPy7Nhrl3Ik7TN+XIIq05oNx+Kga6elaWKcQ0Im6J6My/VxHoROCPjy19xQaOlfccbXHptyQ==
X-Received: by 2002:aa7:9ae5:: with SMTP id y5mr3818214pfp.294.1587649968262;
        Thu, 23 Apr 2020 06:52:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id u15sm2430335pjm.47.2020.04.23.06.52.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:52:47 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/4] More ISO-8601 support
Date:   Thu, 23 Apr 2020 20:52:37 +0700
Message-Id: <cover.1587644889.git.congdanhqx@gmail.com>
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

 Documentation/date-formats.txt |  5 ++-
 date.c                         | 66 +++++++++++++++++++++++++---------
 t/t0006-date.sh                |  6 ++++
 3 files changed, 59 insertions(+), 18 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  1fe69008fc date.c: s/is_date/set_date/
-:  ---------- > 2:  0d0e4d8edc date.c: validate and set time in a helper function
1:  c6d42785bb ! 3:  8b18d0ee5d date.c: skip fractional second part of ISO-8601
    @@ Commit message
     
                 2008-02-14 20:30:45.019-04:00
     
    +    While doing this, make sure that we only interpret the number after the
    +    second and the dot as fractional when and only when the date is known,
    +    since only ISO-8601 allows the fractional part, and we've taught our
    +    users to interpret "12:34:56.7.days.ago" as a way to specify a time
    +    relative to current time.
    +
         Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ date.c: static int match_multi_number(timestamp_t num, char c, const char *date,
     +		if (num3 < 0) {
      			num3 = 0;
     +		} else if (*end == '.' && isdigit(end[1]) &&
    -+			   tm->tm_year != -1 && tm->tm_mon != -1 &&
    -+			   tm->tm_mday != -1) {
    -+			/* Attempt to guess meaning of <num> in HHMMSS.<num>
    -+			 * only interpret as fractional when %Y %m %d is known.
    -+			 */
    ++			   tm->tm_year != -1 && tm->tm_mon != -1 && tm->tm_mday != -1 &&
    ++			   set_time(num, num2, num3, tm) == 0) {
    ++			/* %Y%m%d is known, ignore fractional <num4> in HHMMSS.<num4> */
     +			strtol(end + 1, &end, 10);
     +		}
    - 		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
    - 			tm->tm_hour = num;
    - 			tm->tm_min = num2;
    + 		if (set_time(num, num2, num3, tm) == 0)
    + 			break;
    + 		return 0;
     
      ## t/t0006-date.sh ##
     @@ t/t0006-date.sh: check_parse 2008-02 bad
2:  225b6401bd ! 4:  2812439a26 date.c: allow compact version of ISO-8601 datetime
    @@ date.c: static int match_digit(const char *date, struct tm *tm, int *offset, int
     +		unsigned int num1 = num / 10000;
     +		unsigned int num2 = (num % 10000) / 100;
     +		unsigned int num3 = num % 100;
    -+		if (n == 8 && num1 > 1900 &&
    -+		    num2 > 0 && num2 <= 12 &&
    -+		    num3 > 0  && num3 <= 31) {
    -+			tm->tm_year = num1 - 1900;
    -+			tm->tm_mon  = num2 - 1;
    -+			tm->tm_mday = num3;
    -+		} else if (n == 6 && num1 < 60 && num2 < 60 && num3 <= 60) {
    -+			tm->tm_hour = num1;
    -+			tm->tm_min  = num2;
    -+			tm->tm_sec  = num3;
    -+			if (*end == '.' && isdigit(end[1]))
    -+				strtoul(end + 1, &end, 10);
    -+		}
    ++		if (n == 8)
    ++			set_date(num1, num2, num3, NULL, time(NULL), tm);
    ++		else if (n == 6 && set_time(num1, num2, num3, tm) == 0 &&
    ++			 *end == '.' && isdigit(end[1]))
    ++			strtoul(end + 1, &end, 10);
     +		return end - date;
     +	}
     +
-- 
2.26.2.384.g435bf60bd5

