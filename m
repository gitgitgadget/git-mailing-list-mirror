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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A981AC43461
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 09:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F95E613BF
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 09:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhDYJMU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 05:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhDYJMU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 05:12:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E56CC061756
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 02:11:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l2so361112wrm.9
        for <git@vger.kernel.org>; Sun, 25 Apr 2021 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gjr4DU0zbF+rIbCdNWfCo8NEZUf1XQhs9k47krFmJ2A=;
        b=chXMNUDZYSbPP6iihmKAwHE+3kPoQHDAuueEJHg1+0ewM5B2afVu8DUBGh6EjAqf5E
         iIZAqDMYSLjy+7Hi6qeiJa1g1BiPBOKoYMFo9JznTgSNRwtQQLpJ++YmeowraRit8MiX
         0BFJ+rR80/oCLK8xxwriDa7CD+KcQOqnAc2vs+y/OHeMEnL16lJcG23KYtlMag7xheOX
         5+ZoPD2mqkU4f+5JPSKiF5bwmkbrTQ2WSqsvX7/2Si7psjmYl39pTIwyZ4yzsjvDVDMQ
         l81gxF9lX7B1oAy1z330FIp1RUdHKoej/+JmaP0CuZmoAwpuItIkHNikutFMXHSFGQIm
         8GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gjr4DU0zbF+rIbCdNWfCo8NEZUf1XQhs9k47krFmJ2A=;
        b=h99pLvERI8byg9ZQ7TYVvYeO3zWJf9NZBkKPJIk03rEGqjFLARY4tGusuPg2AlYZeE
         rBGGBXRuVG7gYz4hPlve5MKPNrdeq2Giy2ClKDayyE1IQlFrk5HEjkg0SPtiRoGjFI91
         39LGeWoPoOtnxKnKqiSTSnQR3ba2Yf+Q3q0t4DHhF4bxyVvv8b0mh0LvSyjwT8Q+/HNF
         RogWGOB6qcspOt8AF9dkRStSMG7A8PVsMt6c3+FbNbdLI03uA0559DAWqXJGT3Sk1M4v
         fYGeD3hwWYIbP4ETo8abaAoWKgzTlcYZ16XSG108aaNcZjJztQQ9wEXDNHE7b45pVabb
         ACcQ==
X-Gm-Message-State: AOAM532sSrtN6MGzCiOv5YDvd3HrCIDaJA8tZuxVmCWj2ObmwXQ2B4Bz
        sW6VwBJ9ZSWjzL4E/CU+X8bEQUEF3Kn+Kg==
X-Google-Smtp-Source: ABdhPJxL+0cAVHFzHu61OWEQr5SEHXt76uOnK7tMfJipsLAWl1UEIk0UrYHTaXho/iPB4XKH/h9NNw==
X-Received: by 2002:adf:f6c5:: with SMTP id y5mr16146373wrp.121.1619341897737;
        Sun, 25 Apr 2021 02:11:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f11sm15693707wmc.6.2021.04.25.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 02:11:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu <adlternative@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, Beat Bolli <bbolli@ewanet.ch>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] pretty tests: give --date/format tests a better description
Date:   Sun, 25 Apr 2021 11:11:33 +0200
Message-Id: <patch-2.2-6a17343b23b-20210425T090506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.734.g8d26f61af32
In-Reply-To: <cover-0.2-00000000000-20210425T090506Z-avarab@gmail.com>
References: <pull.939.v2.git.1619275340051.gitgitgadget@gmail.com> <cover-0.2-00000000000-20210425T090506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the description for the --date/format equivalency tests added
in 466fb6742d7 (pretty: provide a strict ISO 8601 date format,
2014-08-29) and 0df621172d8 (pretty: provide short date format,
2019-11-19) to be more meaningful.

This allows us to reword the comment added in the former commit to
refer to both tests, and any other future test, such as the in-flight
--date=human format being proposed in [1].

1. http://lore.kernel.org/git/pull.939.v2.git.1619275340051.gitgitgadget@gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 0462115ac5c..bcb558ef4d7 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -525,14 +525,14 @@ test_expect_success 'strbuf_utf8_replace() not producing NUL' '
 	! grep Q actual
 '
 
-# ISO strict date format
-test_expect_success 'ISO and ISO-strict date formats display the same values' '
+# --date=[XXX] and corresponding %a[X] %c[X] format equivalency
+test_expect_success '--date=iso-strict %ad%cd is the same as %aI%cI' '
 	git log --format=%ad%n%cd --date=iso-strict >expected &&
 	git log --format=%aI%n%cI >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success 'short date' '
+test_expect_success '--date=short %ad%cd is the same as %as%cs' '
 	git log --format=%ad%n%cd --date=short >expected &&
 	git log --format=%as%n%cs >actual &&
 	test_cmp expected actual
-- 
2.31.1.734.g8d26f61af32

