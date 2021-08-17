Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1089C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E2F60FE6
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 17:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhHQRud (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbhHQRuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 13:50:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEA5C0613CF
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:49:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj8so24807217edb.2
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk1sojn/+y9yflgFxTiUTD27CdNtHuzfrAvvJ80pNcU=;
        b=MFWFJZLaqk8PtQR6BB4owi1LChOXkeVMsYiEsXtdGPwN8ZRhyqNV5b0akRuuzKZTAr
         9VkSdogbj79umPj3q2Txom2FHkLK3A4VlCbDFwS1M7QK/Fjvie4Vf0cTrqDRiGFBXvP7
         E7JqCWcKug1aXoXO0psArR+SyqjJ8lXoGSVHolpqrQgMsOtw8uoJc9wUaI2ncxoLLMXx
         1tm0PUwXB+u2C6NVy8hqjvfcL2j6/KyhYLZfQUry+acjiT/z7BhBW4C1f6mhwmSOsrdA
         8ky/UVUugMLefLBTugV8ah0m/7v4ChlPZy6MxQAJWgWaekjIwM6UjuCqh0r0BR5xTSaH
         8rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk1sojn/+y9yflgFxTiUTD27CdNtHuzfrAvvJ80pNcU=;
        b=eV3DHc+KzmZo2sIeT4ohGBrpRNVheewOeS+9emX76P7zCX2VpXm0R7L0HEm0XORVWb
         AUWKUtrYAPLed7k0THAH8v636/iRV2FEr/e4TdR2/XhDwaF4r+diS02k758C3Gd4/w70
         q7FiyejZXaqQE4jg2gUnvyFbXos8dvbGpilws1IqftY9KB0vQUsDDHYDjdKpWfHFoJGe
         +VT00a7/hLKjS1easWFFzM58T6f8qkIpfv1cjTwi/zFh6PB/knGX0OOkAULfY9L2jdWp
         Cfsd20gYtX3ZtviaS908bXJ08OCeYc5qjmgLwH2mBTL5MT8tagUNmH+VwgilEKVeTrac
         3P6Q==
X-Gm-Message-State: AOAM533sPjKL4UGOv5agzerEUMDz0EnEAMEKfCQ1xdJmRtut442QxGg2
        KMKdSDjJ6qhYws+ehS0V0jD7NvWhjsI=
X-Google-Smtp-Source: ABdhPJwizXJ3G2lYM+4edubqV97Z6smq9BlSAatIzMePipcpYpWvFhUTOKi1TkoKea/hDYoSEkmhIw==
X-Received: by 2002:aa7:dd0d:: with SMTP id i13mr5478393edv.371.1629222597342;
        Tue, 17 Aug 2021 10:49:57 -0700 (PDT)
Received: from localhost.localdomain (78-131-17-78.pool.digikabel.hu. [78.131.17.78])
        by smtp.gmail.com with ESMTPSA id p23sm1375240edt.71.2021.08.17.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:49:57 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/6] t1600-index: don't run git commands upstream of a pipe
Date:   Tue, 17 Aug 2021 19:49:34 +0200
Message-Id: <20210817174938.3009923-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.453.gc5e41af357
In-Reply-To: <20210817174938.3009923-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1600-index.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 5d10cec67a..aa88fc30ce 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -13,7 +13,8 @@ test_expect_success 'bogus GIT_INDEX_VERSION issues warning' '
 		rm -f .git/index &&
 		GIT_INDEX_VERSION=2bogus &&
 		export GIT_INDEX_VERSION &&
-		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		git add a 2>err &&
+		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: GIT_INDEX_VERSION set, but the value is invalid.
 			Using version Z
@@ -27,7 +28,8 @@ test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
 		rm -f .git/index &&
 		GIT_INDEX_VERSION=1 &&
 		export GIT_INDEX_VERSION &&
-		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		git add a 2>err &&
+		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: GIT_INDEX_VERSION set, but the value is invalid.
 			Using version Z
@@ -50,7 +52,8 @@ test_expect_success 'out of bounds index.version issues warning' '
 		sane_unset GIT_INDEX_VERSION &&
 		rm -f .git/index &&
 		git config --add index.version 1 &&
-		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		git add a 2>err &&
+		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: index.version set, but the value is invalid.
 			Using version Z
-- 
2.33.0.453.gc5e41af357

