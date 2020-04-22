Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F91EC55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 13:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A802084D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 13:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETNSMdUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDVNQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDVNQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 09:16:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0B6C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 06:16:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s10so934112plr.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rb0fRvs8yhOwHtmOBMSJ8BmRzWxoilJq+QXn/eDRMks=;
        b=ETNSMdUyQvvyqCBuI0hLbhyniNJGscLrnkaDyyWc6dgL+KrUcUiyZUDKFTgwIsR0Z5
         ufxDj69nY6j9OdN1iRsMPmv9n/ye8XVDuYOxPFcPJhMXjSLlXiUu/A7d1mLBj+IB8XdC
         BKmYCniBjK6DeIUjV/tNWBRiGVUP3X9Hvlvz5JEX3zrKL4LmpuTHagB5Cj3UeAu1HwZY
         5WV2/77KLDl2MGSOM8fXnrd56t6A/895Hentot0tHRhrpYhVNj6HjMPbCQ4bvltYIgV2
         XdA3YYdd60rzkJBnXlL5jTBzENq0iI1qTfZXLtdYU/fqObqQgw6uoO4SyN5I9Ofl7Kyo
         l3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rb0fRvs8yhOwHtmOBMSJ8BmRzWxoilJq+QXn/eDRMks=;
        b=oPJ+8tT0oOrBCKfkLg0yGBoGUYaTLvk32Xj3XuWHrhQ/eVeC6WVWlCar0GCKuZ7G5V
         lmRCOOIwyb1JOH+GABrU15E+Tuy3c5jhl4cRpJ5xKIDyWJBSnXHVVDag1RicmdGjae3r
         UqDqx6Or/LUuqQ3+ZphWbGSrDctZeJJxMPoYYppkpNI1jbjhycqjuCDtxgHASTLLU8De
         VBbKyece25nW7ZiTkS5BXXe6NeLJKQ88PvWM1814vCzNByhziez5s8X6FrcoDQ+iFGcC
         kGKi0TIyepD8ZWw8G+Dk6QmU01fwTg2WG0CGkAGdFztVGIs0i4GZFWbr6ElsjY0F51tF
         /dXg==
X-Gm-Message-State: AGi0PuboiW1Ur9tVbZqqu+eq4zoXNadxMwD53QdRA8NanzTb7kBw9rVM
        Am6M3oTPI5218hnV5UMJOXgzSpWy
X-Google-Smtp-Source: APiQypKvBjseVh60u17QKt0yG0cmsu0V9vqWsog/OqOFtwjaQaLHF/s4sokRkm2puODKsnllW94PHw==
X-Received: by 2002:a17:90b:155:: with SMTP id em21mr11424228pjb.59.1587561363421;
        Wed, 22 Apr 2020 06:16:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id 192sm5412635pfu.182.2020.04.22.06.16.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 06:16:02 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] More ISO-8601 support
Date:   Wed, 22 Apr 2020 20:15:51 +0700
Message-Id: <cover.1587559135.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a78
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

Changes from v2:
* Add example for fractional parts of second in documentation
* Add/Fix regression test on 12:34:56.7.days.ago

Đoàn Trần Công Danh (2):
  date.c: skip fractional second part of ISO-8601
  date.c: allow compact version of ISO-8601 datetime

 Documentation/date-formats.txt |  5 ++++-
 date.c                         | 32 +++++++++++++++++++++++++++++++-
 t/t0006-date.sh                |  6 ++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

Range-diff against v2:
1:  03f3e9968b ! 1:  c6d42785bb date.c: skip fractional second part of ISO-8601
    @@ Documentation/date-formats.txt: RFC 2822::
      	Time and date specified by the ISO 8601 standard, for example
      	`2005-04-07T22:13:13`. The parser accepts a space instead of the
     -	`T` character as well.
    -+	`T` character as well. The fractional part will be ignored.
    ++	`T` character as well. Fractional parts of a second will be ignored,
    ++	for example `2005-04-07T22:13:13.019` will be treated as
    ++	`2005-04-07T22:13:13`
    ++
      +
      NOTE: In addition, the date part is accepted in the following formats:
      `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
     
      ## date.c ##
     @@ date.c: static int match_multi_number(timestamp_t num, char c, const char *date,
    + 	/* Time? Date? */
    + 	switch (c) {
      	case ':':
    - 		if (num3 < 0)
    +-		if (num3 < 0)
    ++		if (num3 < 0) {
      			num3 = 0;
    -+		else if (*end == '.' && isdigit(end[1]))
    ++		} else if (*end == '.' && isdigit(end[1]) &&
    ++			   tm->tm_year != -1 && tm->tm_mon != -1 &&
    ++			   tm->tm_mday != -1) {
    ++			/* Attempt to guess meaning of <num> in HHMMSS.<num>
    ++			 * only interpret as fractional when %Y %m %d is known.
    ++			 */
     +			strtol(end + 1, &end, 10);
    ++		}
      		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
      			tm->tm_hour = num;
      			tm->tm_min = num2;
    @@ t/t0006-date.sh: check_parse 2008-02 bad
      check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
      check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
      check_parse '2008-02-14 20:30:45 -5:' '2008-02-14 20:30:45 +0000'
    +@@ t/t0006-date.sh: check_approxidate 5.seconds.ago '2009-08-30 19:19:55'
    + check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
    + check_approxidate yesterday '2009-08-29 19:20:00'
    + check_approxidate 3.days.ago '2009-08-27 19:20:00'
    ++check_approxidate '12:34:56.3.days.ago' '2009-08-27 12:34:56'
    + check_approxidate 3.weeks.ago '2009-08-09 19:20:00'
    + check_approxidate 3.months.ago '2009-05-30 19:20:00'
    + check_approxidate 2.years.3.months.ago '2007-05-30 19:20:00'
2:  36517af872 = 2:  225b6401bd date.c: allow compact version of ISO-8601 datetime
-- 
2.26.2.303.gf8c07b1a78

