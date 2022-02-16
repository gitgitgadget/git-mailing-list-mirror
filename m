Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A650C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiBPIOg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:14:36 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiBPIOa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:14:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AE324CDFC
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:17 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u2so951001wrw.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4/ysCaEmPMDyG5UxSTyeW4/KIwH4WVlNh0PLg0FfK4=;
        b=on3aHySw+cadFR+5RgVHe/PgOdmzd7FkKx58yT7TpujXUo0e3Ny/sK2lp6mDVrncvn
         jL+4K9XFHLWRzF7dExyWw/ieqaPoSVKEAdz5t7BeeNJCSg7PwT8skZWrnoprDNP5ggoD
         u1z3F9Fg32Auu1xXtU3Uws5PFzPwuBQHKIbc4EAxuW1KFULUtHAFbqutNL4bM2mdYn6H
         DAnMiHeu6nD+R/uQlNtUp7QgqqxZZqXLFuC+jab4MU5CcosQWq2w+KEQNm4A/fzDkuH5
         WBqbjZuBSl7hPDHEbgaDiUNkmKZEJrEKx2fqwLPUcHGtjrSdPafAkvT54Kf4QOLv9VlI
         WZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4/ysCaEmPMDyG5UxSTyeW4/KIwH4WVlNh0PLg0FfK4=;
        b=if8aGJzeWBCTDafEyrP4+yqaxOPW5FHCG9CpVEzTHpOgrVxn4er43oDyavuZoX6VGg
         wATLs6k2ghYdlVHTNlIww+5ivE7SYyPRBCqyDWfaUw/76ZLQYIZM1eAbmcfuQMbgzwr3
         X1k2le9xrlLRWtP3nrck04xIrQLAVI011ZDnVkYTOh/PhWz0AY376wK/SfSGjiVOVB1W
         V5la7jCzCCHjLIrGYRwgsnUwd3O6Xil9iq7duNeL3loxUDzaovFOPZYI9dgtNf7E9Kx7
         yhrVeoGl+HQCx04iHQJEgcRxqCi8Wj1/p6oOYto/MSpGLYcKKhbnZUx8CPf5Xs5ji0AP
         DOiw==
X-Gm-Message-State: AOAM530HaIv5+P6jcpYNwDYr277p59K33yYslda3WJ8LTPX/rpoQ+fPo
        lL8FhAKimBb6yEJq3WtTq6ycNKREsKBgyA==
X-Google-Smtp-Source: ABdhPJwzvmJ2kKmKKl6XfO+j21Q2Bz/dKRVHirtmvbj22UhvF65VINMRzl0i4z/xCPXj0MVBJkhm3Q==
X-Received: by 2002:a5d:5701:0:b0:1e4:ab98:74c5 with SMTP id a1-20020a5d5701000000b001e4ab9874c5mr1301194wrv.704.1644999255939;
        Wed, 16 Feb 2022 00:14:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b16sm26173443wrj.26.2022.02.16.00.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:14:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/5] date API: provide and use a DATE_MODE_INIT
Date:   Wed, 16 Feb 2022 09:14:03 +0100
Message-Id: <patch-v3-3.5-764147e90e1-20220216T081203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20220216T081203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Provide and use a DATE_MODE_INIT macro. Most of the users of struct
date_mode" use it via pretty.h's "struct pretty_print_context" which
doesn't have an initialization macro, so we're still bound to being
initialized to "{ 0 }" by default.

But we can change the couple of callers that directly declared a
variable on the stack to instead use the initializer, and thus do away
with the "mode.local = 0" added in add00ba2de9 (date: make "local"
orthogonal to date format, 2015-09-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 date.c               | 3 +--
 date.h               | 4 ++++
 ref-filter.c         | 2 +-
 t/helper/test-date.c | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/date.c b/date.c
index 863b07e9e63..54c709e4a08 100644
--- a/date.c
+++ b/date.c
@@ -206,11 +206,10 @@ void show_date_relative(timestamp_t time, struct strbuf *timebuf)
 
 struct date_mode *date_mode_from_type(enum date_mode_type type)
 {
-	static struct date_mode mode;
+	static struct date_mode mode = DATE_MODE_INIT;
 	if (type == DATE_STRFTIME)
 		BUG("cannot create anonymous strftime date_mode struct");
 	mode.type = type;
-	mode.local = 0;
 	return &mode;
 }
 
diff --git a/date.h b/date.h
index 5db9ec8dd29..c3a00d08ed6 100644
--- a/date.h
+++ b/date.h
@@ -20,6 +20,10 @@ struct date_mode {
 	int local;
 };
 
+#define DATE_MODE_INIT { \
+	.type = DATE_NORMAL, \
+}
+
 /*
  * Convenience helper for passing a constant type, like:
  *
diff --git a/ref-filter.c b/ref-filter.c
index f7a2f17bfd9..3399bde932f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1251,7 +1251,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	char *zone;
 	timestamp_t timestamp;
 	long tz;
-	struct date_mode date_mode = { DATE_NORMAL };
+	struct date_mode date_mode = DATE_MODE_INIT;
 	const char *formatp;
 
 	/*
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index ded3d059f56..111071e1dd1 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -35,7 +35,7 @@ static void show_human_dates(const char **argv)
 
 static void show_dates(const char **argv, const char *format)
 {
-	struct date_mode mode;
+	struct date_mode mode = DATE_MODE_INIT;
 
 	parse_date_format(format, &mode);
 	for (; *argv; argv++) {
-- 
2.35.1.1028.g2d2d4be19de

