Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C79C6377C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119E46121F
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 23:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhGUW7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhGUW7o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 18:59:44 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740FC061757
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o3-20020a05600c5103b029024c0f9e1a5fso215637wms.4
        for <git@vger.kernel.org>; Wed, 21 Jul 2021 16:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1n+ssmJcSqfB74nzNj5hZys7EX39DUF3DOWr+C/NWU=;
        b=GiIWsPtb0wljqiprfteXfbCDy5l/U3HydeH7hsgfK2cq6aYQfst21yMLiNh4vu03p9
         rHwGoJiG5d0imArh1l5YUaIOXyicuAVck445PMWuW/HeRnULaeMxP84woflRfgIfHxNv
         q2NBmfk6C0+DxhsiHP+rcqgNuUr93srKxT2nqEEAf83ZeGt+0QFEmh2P2lrPTiK1qjZz
         RaAM7teNtyLUudpHquX8qKhhZNtnTogV+FXcL9jseUXQhmQHvDTBKCyEErbQ49rYOgJs
         DqCx4JSHMakNxzh4Uw9dCw1qWhQMuxzWvLYy9ylTDeqrR6nb02x3QQUsdthw7jgGo2tR
         8slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1n+ssmJcSqfB74nzNj5hZys7EX39DUF3DOWr+C/NWU=;
        b=Eet9ZV0hRsAiCH3zZ5gFUnLtYoisCwdkkVaTDFOcSQON1yTIdJ2SkwztNIva4OSAWn
         kzv0uE+IVCm56S/2RxKUAs5fhYLACS3F8z0lWlmDag1MO6ixYehwpXUyTbcyAt+n6S8g
         6u7avrFDftp7AL+I7cdIb2e0qkEbVNAl8ML/SNHUw/dP5bzHUSqS0jcm+YnuQ2ShSeJe
         zesTD83kVQgqEjOwyVA2xrpFQhmPHsMS/k82KYS7fA9UHIx+++OdIwFW8LEBZd1ljy/8
         V9RNbkgulIZ2l8U/KV5UCFDw+RVGjezhOSQL/2HxUS7sQIOzvcIxFVjB5NdGwa6dVhNr
         SfhQ==
X-Gm-Message-State: AOAM531eXiv0WV0HOAoPuy22PmWxXqKGgTGzXGZHqOCNCbdq4CMJKuNq
        K48qc+Ewo2ekT+K1jeBLhxT3Ww4DcQ/T+w==
X-Google-Smtp-Source: ABdhPJzLVCOsWUJr37zpKovG+D4bGgb0jdqymxSihjwPrPqzQYdCK9Jp0idijBh8zI/MjQGF/ILS6g==
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr20984994wmj.176.1626910817823;
        Wed, 21 Jul 2021 16:40:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm1145649wmc.12.2021.07.21.16.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 16:40:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/12] serve: mark has_capability() as static
Date:   Thu, 22 Jul 2021 01:40:02 +0200
Message-Id: <patch-01.12-192fb64ef82-20210721T233307Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.955.ge7c5360f7e7
In-Reply-To: <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com> <cover-00.12-00000000000-20210721T233307Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The has_capability() function introduced in ed10cb952d3 (serve:
introduce git-serve, 2018-03-15) has never been used anywhere except
serve.c, so let's mark it as static.

It was later changed from "extern" in 554544276a6 (*.[ch]: remove
extern from function declarations using spatch, 2019-04-29), but we
could have simply marked it as "static" instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 serve.c | 4 ++--
 serve.h | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/serve.c b/serve.c
index aa8209f147e..6748c590b74 100644
--- a/serve.c
+++ b/serve.c
@@ -156,8 +156,8 @@ static int is_command(const char *key, struct protocol_capability **command)
 	return 0;
 }
 
-int has_capability(const struct strvec *keys, const char *capability,
-		   const char **value)
+static int has_capability(const struct strvec *keys, const char *capability,
+			  const char **value)
 {
 	int i;
 	for (i = 0; i < keys->nr; i++) {
diff --git a/serve.h b/serve.h
index fc2683e24d3..56da77a87af 100644
--- a/serve.h
+++ b/serve.h
@@ -1,10 +1,6 @@
 #ifndef SERVE_H
 #define SERVE_H
 
-struct strvec;
-int has_capability(const struct strvec *keys, const char *capability,
-		   const char **value);
-
 struct serve_options {
 	unsigned advertise_capabilities;
 	unsigned stateless_rpc;
-- 
2.32.0.955.ge7c5360f7e7

