Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF25C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347367AbiBBVEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 16:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiBBVEI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 16:04:08 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF62C06173D
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 13:04:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j25so189139wrb.2
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 13:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tncW21K7E/YVLNYhI6wRdZhSkn1YBX1hFNdR4NYOyI=;
        b=g08GWm32kPbTD4If4YEAopKuq9p3JvqyMrjYPWR2j2MIEdGE6N/6IVi9ODE4/76aCp
         77d/B46OIhj7C/Xl6deCeWgiXXSoOSYJMEocxlDEWn2BumQblQYEAe5MkMIjm6WxiyWg
         kFNcysxl1UH7Bvq3uIP9s/ZlRIHFq9Civv5tnRaXsSrVLTnMB2DC7RVbdSOGuiDUzGP6
         Q5CFqqHxdok+K/DaWXAPc9L2P95Uc3nb9heCMQpdZkmLnVWgVON8WRGfisslGpn0Wg7Z
         YmjxxPipWj+slOwwAiqzqLPooHXb/Bky0gvxBjqx5lViuN2PKA/sXs1qE7ubEbCtedY6
         q00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tncW21K7E/YVLNYhI6wRdZhSkn1YBX1hFNdR4NYOyI=;
        b=wdVbQmGS2MAl6zv9AACYXB/OEad3VpGKE2kAQXkRwwI6DEVTJfz9eXljl/P/QPn7kv
         S60/PMetPvB8Uh5nsjrUqZuqpcHY0iwVql3HGO5zp6nt3XaMrDwm2FKIrdpI+4AWZaSA
         kx/yOQX/1Z3qrh3ntRIoQubpUqhmwXhzys4EmmW8WwPUUmUwNK8XNMyTc8dxM8snPr+Y
         UiaxPMVCycZBF6LQgO7c5Zyn9fY7DWfi5v09Titqr7IT/+do9y+KUnvgnd4dCMGliCJy
         WVbB79BEAHNigjqMrFbqoeWLMnG4LkTZBwH2Pmlex+b13vv5BwjJLnDniaKHlRXsn9XA
         QJ4A==
X-Gm-Message-State: AOAM533+wfyVQelX3+sxyCbFCtdpAxq7lYzzJydoTigLzRYKkuugvTLy
        vesQH9CCjtcCZ5iZCMo0U/E4hEMbPYdZ0g==
X-Google-Smtp-Source: ABdhPJy91MVuadgdtTAB0X8vI9FNZklFYwQbsVDd3F4lwLtxJyplU9lWW9UFZ5p3VWWje0MhDtcC6A==
X-Received: by 2002:adf:f046:: with SMTP id t6mr26167065wro.684.1643835846293;
        Wed, 02 Feb 2022 13:04:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm17264592wry.50.2022.02.02.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:04:05 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/5] date API: provide and use a DATE_MODE_INIT
Date:   Wed,  2 Feb 2022 22:03:51 +0100
Message-Id: <patch-3.5-2d5210f9421-20220202T195651Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.920.g34be1f84792
In-Reply-To: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
References: <YZQHEiFnOdyxYX5t@coredump.intra.peff.net> <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com>
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
2.35.0.913.g12b4baa2536

