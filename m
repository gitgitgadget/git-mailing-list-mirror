Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24F5C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbiGAKnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbiGAKnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C651F7B34C
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l68so1042095wml.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZAoXgoQNAwPYW3YVHRnrscdpyPkMlNh4+/s1eMnixw=;
        b=BgME/HPjVrbi4W6JTmOEIuhe3Tesync3DeLW3JSx31u/6u/zOq5jNUJuY4Ymx2a2lD
         qgcM9A2cQSGS7cBmxw9VbQNdpoHEDOFOeiWHAdU35SwxNEMWMujdsKekyA6UOhVCmQ4H
         a+4J7g4gJCb8T7iy8048XCcBDSmrY2vd8JWroIp7rndJ13tNwzzfkL23qDBhRsE0eFUP
         mvxv5m8n+dX+TmEsWwVRrqidsZpWTrtzVAWeM11b4ybh1AbH2aqsAQyX9Q6iuZ8eAjHl
         LPrPbym7QgpID5+lF4o2WrfWuhYXH3y0o76Dr4fV55K0NwjFwZqVHXm0AZrD+UJO9fhz
         wvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZAoXgoQNAwPYW3YVHRnrscdpyPkMlNh4+/s1eMnixw=;
        b=ujuB93RQ+EPJQRdxcvYdo+qRZBNZeLbsm0nEsCBMCy45KaASLPdjz+wMxdNosTnSFJ
         QIfLBbr1pB/e1lLA130MfyPfFY9GhIM3VXNvN3eGWnPyt9jEPEO7olzbh2P6kgLK1vHH
         9dhFmS9RrLvzodpmH6gnagMpTI4WpHgecnKApD7NF6WzuUx/HZDxU1TZAuhjGaGp8YfH
         kWEnggq6P449CRaxYTGSNn9hOqRiUE98LayvuaBUlPtIGR1hrHrU+jdnfH39fBd1xK9Z
         4RykPk7L4XDQS2jGhcAxy0xkJBM2akmvtO5KvyxypOnKiKHRERqukUDazNwWf8MBVX9M
         K/Jw==
X-Gm-Message-State: AJIora8LGMKeCLqOPOfB72agLeDcxkByfVRbpa2PD78hPBor5JqW/Ja7
        GdaG8i/igMpdrtX5kgtjHPEo9DpAPwqgBQ==
X-Google-Smtp-Source: AGRyM1ucPXalk9plYDfXn4XoOWLurWgn37BHzdiuYhJn3mEM23RAQ5vXMc/CRipFVzfFGZG+8yKkxA==
X-Received: by 2002:a05:600c:c5:b0:3a0:3ef3:838a with SMTP id u5-20020a05600c00c500b003a03ef3838amr17673559wmm.50.1656672184101;
        Fri, 01 Jul 2022 03:43:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/11] check-ref-format: fix trivial memory leak
Date:   Fri,  1 Jul 2022 12:42:50 +0200
Message-Id: <patch-v2-01.11-f35cf7c6ee9-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "git check-ref-format" that's been present in the
code in one form or another since 38eedc634bc (git check-ref-format
--print, 2009-10-12), the code got substantially refactored in
cfbe22f03f9 (check-ref-format: handle subcommands in separate
functions, 2010-08-05).

As a result we can mark a test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/check-ref-format.c  | 11 ++++++++---
 t/t1402-check-ref-format.sh |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index bc67d3f0a83..fd0e5f86832 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -57,6 +57,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	int normalize = 0;
 	int flags = 0;
 	const char *refname;
+	char *to_free = NULL;
+	int ret = 1;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
@@ -81,11 +83,14 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 
 	refname = argv[i];
 	if (normalize)
-		refname = collapse_slashes(refname);
+		refname = to_free = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))
-		return 1;
+		goto cleanup;
 	if (normalize)
 		printf("%s\n", refname);
 
-	return 0;
+	ret = 0;
+cleanup:
+	free(to_free);
+	return ret;
 }
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index cabc516ae9a..5ed9d7318e0 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -2,6 +2,7 @@
 
 test_description='Test git check-ref-format'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 valid_ref() {
-- 
2.37.0.900.g4d0de1cceb2

