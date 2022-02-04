Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05FC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 23:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378367AbiBDXxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 18:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378336AbiBDXxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C8C103DFB
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 15:53:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j16so13986965wrd.8
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 15:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJmrKbf5WfVLWO420q6rwPxscLSQ0M9xIx8W2MU2E3o=;
        b=aIqiNn8n/ubUNods4rf3ooqst+IgvN5DoIvZg+W5CRe1BHx3i1LBZrlsIWS4Qx9G/R
         O+vPelbNJkynoDHUEZ7Pdkr/EigUnAfUZAeuH7k4vfek6obihO0neW9uxo1PNO5zZ4Lf
         QOyxhIBnyQfVjBE0EFgDNYiZShzYETvTRAxGBBhqgHXyJsFqTABLgRic1ZpQXfIksFLL
         rllG6vmijZzfAMW5W30vJJc/H0vPI7duAgYIpx8nKcXptTmHt498rrXDHicyGqTZkNjG
         8mdZrVISgLeeTZ0sRRVFPU0UWNeA/Y47NnFiOsPdWCwz4pdUbiwrADOwWGY+6XE0ELkJ
         0o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJmrKbf5WfVLWO420q6rwPxscLSQ0M9xIx8W2MU2E3o=;
        b=uagGJo4kkf3PCyRLELnjZ0eGp+azn0WDn4ad8UWwXm4bPls9lYVOjiqLM6Ji02zml/
         CR6G/aE0H+PiaHgqlg26iBTj9+7gqDYbDY4dr5z1sznO2Z59W5uV1Wlq+03XY91OvcKS
         6/NTdjTMao1YlBgc/3a5cxwLgLz/4Y7N5PRU/1mppwsKYW+II6rMnAKjVnG7CVM5bhBi
         3KxyibsrgOdtajjJ5YFuNsAPYPllslhphuVJtjWWbMOTa4L8pOlLy8YHsZhH8uomhvDT
         8hTcY/65zQI6E18LOQzoRGBJAf2tFoLGkx9q/G/pR29HYxN/MzmrkivUnQo7LNzn5oHp
         jDRw==
X-Gm-Message-State: AOAM531RR2F/uxBcUUzH3y9B2AfOVfqN4zP5ppukSBqg62d7jX+uRJFD
        FHpgynjpUngiw40USxY/CUuMp9SBeyiufQ==
X-Google-Smtp-Source: ABdhPJyL4Nm28/JuHv8OBpu45tNRtwGSlvNEwtBarEYU2Hbt/QmRilwwrhgp+FGsI/lx0sfPBEtViA==
X-Received: by 2002:a05:6000:1d88:: with SMTP id bk8mr993491wrb.508.1644018791966;
        Fri, 04 Feb 2022 15:53:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm3304507wrw.5.2022.02.04.15.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:53:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] date API: provide and use a DATE_MODE_INIT
Date:   Sat,  5 Feb 2022 00:53:04 +0100
Message-Id: <patch-v2-3.5-9ef003a83bd-20220204T235143Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220202T195651Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20220204T235143Z-avarab@gmail.com>
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
2.35.1.940.ge7a5b4b05f2

