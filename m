Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D70C433FE
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B35761B54
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 18:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbhKPSeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 13:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbhKPSeP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 13:34:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF09FC061764
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:31:17 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w29so39341991wra.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 10:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRtsGcynlmhIM+9obMOwwTX5aHee9zBY4jmgPwOHQxk=;
        b=UiIwB5PE+/UIBvQ3kSiSDhM7K71VoF68Ah7h9QhzN1f7KU+JZgLqsPM4k19hRlbbD3
         yD5TFcuJ2Qbm/LLsApnYo6CF1U02CWQw+mru/6jbldM1/svo63jriwr0hR6Mr3svPeY7
         e+rQKjZ7WXQJCNO9+q71f8bDcMmwRnion8UIwf/9Quv0R47Ye5O3/j63l3jPectudbqk
         vuOw257Orvpp0JhDtlpaJwAQYVEj7ry9YqyE+uZHEyW09Kd3AEi2Iz1QFtKE7nWy4yhN
         4fzTzrZzcuDlRxjfF7OUO86wdjAp72WlIIo2ryEIJUTrMnQ6YCDn5uO3C/IjxFDEedi5
         ZF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRtsGcynlmhIM+9obMOwwTX5aHee9zBY4jmgPwOHQxk=;
        b=b+ZGzsywXZJDkqs3r6pvxzC5gIFdqhivdfIIrzj/GN1tQd/TzWMc7GrOPoqYS7X4J9
         H/WG451OwdWVrTCsEt641QiDLfaoFIATaGXSzavixyzete93NJ6/8dA+Te6XEaAkIsqP
         ZOCec/DZieVrH3NLjP7AciPLVSvFQLmK8Qn/dbkvSlVyqE1Li5iLoUkTu9AOGnGJ55Oc
         t+lL9XDnOH9SElcbtbnReBD8SULu6JtCIU+Mn3OV/TV9thXwXVTYXTHt+OLC0NefjSql
         g2nJ1FnCQwrcMqB+EA5+Ga0LBKgjssr+V3n7Yv8Pf/tX7z7f6Vzt442woYmd/zYKlYJH
         /5Cw==
X-Gm-Message-State: AOAM531LY7ojqwZKEXFTotrOZh1RWcd0SG2wha9+BJ3ixjP2iUeapyA5
        Szl3l/lpb2oEsHhKEEHO50y0brcoTjTLSg==
X-Google-Smtp-Source: ABdhPJwnQI4AHsml15V6WTUoChmV48jghde9Z1p3eQcrNT79C0tQw0rJXfhIPULipLLRdGrGHA2BFA==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr11659611wri.381.1637087475774;
        Tue, 16 Nov 2021 10:31:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm18289677wru.51.2021.11.16.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 10:31:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] t0006: date_mode can leak .strftime_fmt member
Date:   Tue, 16 Nov 2021 19:31:12 +0100
Message-Id: <patch-1.1-15f5bd3e4f4-20211116T183025Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.795.g1e9501ab396
In-Reply-To: <211104.86mtmki5ol.gmgdl@evledraar.gmail.com>
References: <211104.86mtmki5ol.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

As there is no date_mode_release() API function, and given the
set of current callers it probably is not worth adding one, let's
release the .strftime_fmt member that is obtained from strdup()
before the caller of show_date() is done with it.

This allows us to mark t0006 as passing under the leak sanitizer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

A trivial leak test from Junio that fell between the cracks. Submitted
with my suggested fix-up in
https://lore.kernel.org/git/211104.86mtmki5ol.gmgdl@evledraar.gmail.com/

 t/helper/test-date.c | 4 +++-
 t/t0006-date.sh      | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 099eff4f0fc..27a36a5c5fe 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -34,7 +34,7 @@ static void show_human_dates(const char **argv)
 
 static void show_dates(const char **argv, const char *format)
 {
-	struct date_mode mode;
+	struct date_mode mode = { 0 };
 
 	parse_date_format(format, &mode);
 	for (; *argv; argv++) {
@@ -53,6 +53,8 @@ static void show_dates(const char **argv, const char *format)
 
 		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
 	}
+
+	free((void *)mode.strftime_fmt);
 }
 
 static void parse_dates(const char **argv)
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 6b757d71692..5d01f57b270 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test date parsing and printing'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # arbitrary reference time: 2009-08-30 19:20:00
-- 
2.34.0.795.g1e9501ab396

