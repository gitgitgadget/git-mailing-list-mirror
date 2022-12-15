Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90A5C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 09:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiLOJtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 04:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiLOJsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 04:48:21 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907681573E
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r26so26228326edc.10
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 01:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnI2cH4O3a3tNirB2lYT/fFM72fZeXH2zRp5TYQlzaM=;
        b=fsekMkKrU16k7NQs3tStawLOEXF9mXLjW9pgU7uaFOOSgR3FIEnTlJbhPVTqElPS06
         XvPg2dGhhmGea/D8y1g91ra00P2U3ectBeLZQT4ynVidaNf1bM2Q+y21LYq3o7CO/jAZ
         T/Cyl69uXEFGUhpmZzhtyDLNPdQgdeyant0/lU49AWg+HgvoAacZ97yk9LqH+SuYF8Sy
         5GaKSWpL4B9B5CBOMkE5sdmYbwIfFzVthuAolOoQQXfYMGsOryt2fXIDA/UT9+8xa3xX
         UJTg9eOW8bnuS7oI1wGsxpMJFcPbZRXTG5ipTqHfoFeJN0KfKjP2E5cYyb2wnLuLoX9s
         X4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnI2cH4O3a3tNirB2lYT/fFM72fZeXH2zRp5TYQlzaM=;
        b=WX+C01D4XI7kNj3NZ76kti9hPPezIvpBrQrNgOQzrRIDwYS58LqzU/dVz1fu5zQWEG
         pHsPTLVwp52AbJhWQlLkdoKa0feOxbETzrRFzrzsY8hjVvYIDK8kiX6FPxaG1qjN+arK
         Vctm1ZVXS20Ai6tkFLBv2bbJA44cKL3sHCL//9FjQ5L/hg9Pg7C8u3ovJlasqwVMfrLc
         cBsz37PvNVdROf0HHpDrowh4vMvbOTv59EtfMxJ8P/oN9zpNXJ/EDMbB0JBkmgCOBAHF
         VB9kK2ZjToL/NnbYN6+ed83kVwVZnMClDZw6kDVWZU6qFAvXo0buv/NeFZe78oiUK0iQ
         iIag==
X-Gm-Message-State: ANoB5pkCk4NBqj38PJzhQPZFUmqsu2j54AIW/NFA1wZFxLJi5xQ7k44U
        1x5uVlUTgdBQTyiZh/A4A3t7mcP3XhF2BQ==
X-Google-Smtp-Source: AA0mqf5o3AcKb8g3RwX3pBFLu8tQOU63SdGYK6Fe20iL74b0kW2+r2EfEtrkICWmvHtOcPnKCWIduw==
X-Received: by 2002:aa7:c40c:0:b0:46c:a1f7:d9c5 with SMTP id j12-20020aa7c40c000000b0046ca1f7d9c5mr24945166edq.38.1671097673867;
        Thu, 15 Dec 2022 01:47:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0046b4e0fae75sm7189155eds.40.2022.12.15.01.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:47:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] bisect--helper: simplify exit code computation
Date:   Thu, 15 Dec 2022 10:47:44 +0100
Message-Id: <patch-1.6-c8c648e4b8c-20221215T094038Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20221215T094038Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We _already_ have a function to determine whether a given `enum
bisect_error` value is non-zero but still _actually_ indicates success.

Let's use it instead of duplicating the logic.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bisect.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect.c b/builtin/bisect.c
index cc9483e8515..09505fc4dce 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1440,12 +1440,5 @@ int cmd_bisect(int argc, const char **argv, const char *prefix)
 		res = fn(argc, argv, prefix);
 	}
 
-	/*
-	 * Handle early success
-	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
-	 */
-	if ((res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
-		res = BISECT_OK;
-
-	return -res;
+	return is_bisect_success(res) ? 0 : -res;
 }
-- 
2.39.0.rc2.1048.g0e5493b8d5b

