Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C318C2BB1D
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7541D20787
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 03:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYYiSpEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389531AbgDODcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 23:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727892AbgDODcS (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 23:32:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579C3C061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:32:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so6110066pjb.3
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 20:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VegK0jonEWonPjb0UFmEioz24qzLn/ihgmu7N1WuZAk=;
        b=sYYiSpEMZN8qo/Sn6BGrLQJNoo6nL6bps4GWP2Yz7Egw5V9R4yI+ubGy77p5H2QYu0
         r8TehndGawvDslrF8sBnWTGh1QoiWi0qGANHtdrmHhuSRsGPTNaR/9fgTC4+KakH31OA
         Ofg/3iexiZdDJxo5+sqISPMS4PhFZK/FOgpgqydPzVtYcjdJH0JTaXF6AOSJwGoNGPWr
         7703d+JoCxTemRs2LM2x93S268xnHKTPa1oHPJnGgTGGC10RKVMg8x3ccz+lVlITsYtp
         SeI8WxatVjAq1dpcopySi8MbsJwnNt7YzpfsEOEu9hPxrorrSk9tWzaeECrXSA8cG1mS
         hzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VegK0jonEWonPjb0UFmEioz24qzLn/ihgmu7N1WuZAk=;
        b=kz4IWXPo+TlGZvFnmKMg6c/2qngZVd6Eymr88yZWxNk+nl7Ynk/nU30nZyrgqmUh/A
         qnjqCmKMIXzlmgt9iXyRti7qh4tEAaRUOKOg3O8UBtRUbIzrOig/aAfdsA1t031c40I4
         umwiW3KMljMLVj3pGiBuI5jYzZdgUjo6ffzhTEigpNRvMLvP7rpNNh/z1Kh1b04nNU8x
         1FLA8vfLatywRUrei0Hi9IBgSp6HqmQx72iIgZKI0Ok8XuyP5s9Tiyv7mGg5px7ZuEt9
         NuSfANybFsN3TO3pNZb+jW/U1tjKuSfOaSkw+Kp1tGf22f1myprGgPEbcuESFsMFEm7N
         o93w==
X-Gm-Message-State: AGi0PuYr5kdPYbq9sJTHHF8a7cdSzQj/V0Lsbvh7oPDSsqPgln+ftdcT
        1Iz8vGMcL0EfeNBU3UUWdvpyolpN
X-Google-Smtp-Source: APiQypKY0yDcg4Y91Di/5WHYTTya7ssHjW3/qbI5OR106Ilu2OhwzERD+bq6BTdwY1QaPpQe7gHyPA==
X-Received: by 2002:a17:90b:3556:: with SMTP id lt22mr3725754pjb.138.1586921537348;
        Tue, 14 Apr 2020 20:32:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id f30sm13174056pje.29.2020.04.14.20.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 20:32:16 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] More ISO-8601 support
Date:   Wed, 15 Apr 2020 10:31:26 +0700
Message-Id: <cover.1586921235.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.485.g42af89717d
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

Đoàn Trần Công Danh (2):
  date.c: skip fractional second part of ISO-8601
  date.c: allow compact version of ISO-8601 datetime

 Documentation/date-formats.txt |  2 +-
 date.c                         | 24 ++++++++++++++++++++++++
 t/t0006-date.sh                |  5 +++++
 3 files changed, 30 insertions(+), 1 deletion(-)

Range-diff against v1:
1:  d7d74b03cc ! 1:  03f3e9968b date.c: allow fractional second part of ISO-8601
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    date.c: allow fractional second part of ISO-8601
    +    date.c: skip fractional second part of ISO-8601
     
         git-commit(1) says ISO-8601 is one of our supported date format.
    -    However, we only support RFC-3339 date format.
     
    -    We can either:
    -    - Update documentation from ISO-8601 to RFC-3339
    -    - Add full support for ISO-8601
    +    ISO-8601 allows timestamps to have a fractional number of seconds.
    +    We represent time only in terms of whole seconds, so we never bothered
    +    parsing fractional seconds. However, it's better for us to parse and
    +    throw away the fractional part than to refuse to parse the timestamp
    +    at all.
     
    -    This series will try to add full support for ISO-8601.
    +    And refusing parsing fractional second part may confuse the parse to
    +    think fractional and timezone as day and month in this example:
    +
    +            2008-02-14 20:30:45.019-04:00
     
         Reported-by: Brian M. Carlson <sandals@crustytoothpaste.net>
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    + ## Documentation/date-formats.txt ##
    +@@ Documentation/date-formats.txt: RFC 2822::
    + ISO 8601::
    + 	Time and date specified by the ISO 8601 standard, for example
    + 	`2005-04-07T22:13:13`. The parser accepts a space instead of the
    +-	`T` character as well.
    ++	`T` character as well. The fractional part will be ignored.
    + +
    + NOTE: In addition, the date part is accepted in the following formats:
    + `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
    +
      ## date.c ##
     @@ date.c: static int match_multi_number(timestamp_t num, char c, const char *date,
      	case ':':
    @@ t/t0006-date.sh: check_parse 2008-02 bad
      check_parse 2008-02-14 bad
      check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
      check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
    ++check_parse '2008.02.14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
     +check_parse '2008-02-14 20:30:45.019-04:00' '2008-02-14 20:30:45 -0400'
      check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
      check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 +0000'
2:  48284386c9 < -:  ---------- date.c: allow compact version of ISO-8601 datetime
-:  ---------- > 2:  36517af872 date.c: allow compact version of ISO-8601 datetime
-- 
2.26.0.485.g42af89717d

