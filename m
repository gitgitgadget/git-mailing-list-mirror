Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA85FC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiBPIO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:14:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiBPIO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:14:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854D62503AB
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:15 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so971282wmq.3
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FhEc+YlMw+SDx6rzPsXWqcBAIYaqydANiL45K/IQxg0=;
        b=WFUu681qpps330HChUt/W0JhZi8M5fzssLBdRadSYRqPHfaQVy+DzT5AEHBB7JhiXY
         ZmNAXNYE6RtOv5GvxE2BMr6ndPHa/Ry9NHK1xPRcFWMP3w9C/t0UHUF5ml3m2G+BGeHT
         YO6Wpos2gtNTNAgeZCqBNicN2cMC39XEYXhuJU7tc/xrlU3c/EqW5zraflFcQhYRdrxk
         4Ieccg8/U3WTdRQGUFs/plk72VWBqenvhGjbdJbvjPQ5M+VB302CeDGgg6Spfqtt+zwB
         JM0/o2Mu3db+15jouRfJ4PJu0easxc+D9enYIaRd95xTGWR2I7xju8UX8BrPxsHYaJxU
         P9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FhEc+YlMw+SDx6rzPsXWqcBAIYaqydANiL45K/IQxg0=;
        b=tQm3CGRND7K5LYKpIyad5kS38FIM8cZI6J0wv+zB20nprnZyaVoXqgxWq+CZaTe+Lw
         7hYQAs5dFqXW2LES9zT0pZNBQVAUGcVzmQIFnL4oONSW2e3ha9GRQt0YAG/6hbSGS37Z
         EX2l0JUiQDlYmH4F2OVy9xHyRBuHLcvd61xkV3P5i+BiXGwcNkEW1cV8wbv9hxOUpWGQ
         uBBkhuIm6DVlzuXurDks17tTNyE1X6S4o+4zgvUNm5ccch8NoKUnTfVL37OzTEKaYaE+
         9cHJL7myvHFWOvCdKenrCLsL4tyI4X3wwOSCpsajbesgYNfXUK5Mhg5cSkWnvQGDyJJ7
         InHw==
X-Gm-Message-State: AOAM530X2kgTGwnNmMw08BrhvPBjH/StNbYlySUdl4HoONnfboSmOyNN
        1tQBr145MemFDhT5odR6/2/xuLzRij5fEg==
X-Google-Smtp-Source: ABdhPJwtnB+DQKqVl8Y+iJPRvHZFNWSUjHsKAsMldVrJMy4wi5ju1kK63mVYZl3rQe8r6DKQCOqygg==
X-Received: by 2002:a1c:7c07:0:b0:37b:b973:bd3f with SMTP id x7-20020a1c7c07000000b0037bb973bd3fmr423517wmc.87.1644999253749;
        Wed, 16 Feb 2022 00:14:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b16sm26173443wrj.26.2022.02.16.00.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:14:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] cache.h: remove always unused show_date_human() declaration
Date:   Wed, 16 Feb 2022 09:14:01 +0100
Message-Id: <patch-v3-1.5-97746d97810-20220216T081203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has never been a show_date_human() function on the "master"
branch in git.git. This declaration was added in b841d4ff438 (Add
`human` format to test-tool, 2019-01-28).

A look at the ML history reveals that it was leftover cruft from an
earlier version of that commit[1].

1. https://lore.kernel.org/git/20190118061805.19086-5-ischis2@cox.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cache.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/cache.h b/cache.h
index 4148b6322d5..703a474e5a7 100644
--- a/cache.h
+++ b/cache.h
@@ -1588,8 +1588,6 @@ struct date_mode *date_mode_from_type(enum date_mode_type type);
 
 const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
 void show_date_relative(timestamp_t time, struct strbuf *timebuf);
-void show_date_human(timestamp_t time, int tz, const struct timeval *now,
-			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
 int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
 int parse_expiry_date(const char *date, timestamp_t *timestamp);
-- 
2.35.1.1028.g2d2d4be19de

