Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D753ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 20:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiHaU6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiHaU6J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 16:58:09 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027EEDC090
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:09 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so234004wma.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DrsUosIIpIajqDEOwhBDnv/TgRiUvuDA2kKSf4E3zFk=;
        b=fVgdSJQJu58rCBowtiWFskU3j6hmBfzZaT3JC7t6+BP1hKF4icSg7YVz1a0LYbuXee
         sO9Vela05sd40G+0xVwdx5K00IZpmG3jHZi9EpoLf8m5UyOJZXPlU8akf1bbz8VKj/ot
         1wca+fWvscvrCcJou6iBxO6Tek4AszSxZOrMoji0oILwf8a/psJNa0s13NlH1ZSqaXOR
         VUL6SNUPbsObJ07fkcekuVDawAlZIBHyujT7TOWPCSQVzAP8joY00xUJ3dRW7EcD7sb7
         aMk2CDWwv+Ug0zwzY2ICZmt9sQBvI2pgx1FyPdg22bLq9xmqWuk1TMX0xuWpiCqrDm8l
         w7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DrsUosIIpIajqDEOwhBDnv/TgRiUvuDA2kKSf4E3zFk=;
        b=JRMHLx7fmD/gZRCb6b/ho9J4um722cNE9q/HzArnto9vjPPcy0oCvp+2r09Q5CUh+S
         /NSdtrMx5RKh/TmdCxD9elMG8swdIUGEXo3nrPobeKy1wZGME1KIGqRVc+M4HMrdwThZ
         7l1CAAvmush6Hjd0fBSDAFrAsGHltkz2zzRHQfQnSqp3KJpQoUVdptI8oweDcudAUgqw
         0cxM143eamoqze28VlMmONEmTYWz0Cmozdfzdei4p99/isQlJqQmzKG2VnzhLQhah5U3
         Lwd/AD7U5vFyTSC+UCr84ucSeFz6K9ttYhi1AyRgAfA5Ulh6myjyPH+aPvzHyIrx/jGA
         w8Tg==
X-Gm-Message-State: ACgBeo2kdCYcKlS/Cb90C/F4jARHMZGeqGHJrO8tsdrgNoIXKpVDtbke
        8PU0EV44n354B3e762PqdqD0vumZiDdmCw==
X-Google-Smtp-Source: AA6agR4UxzsICGgAWqXJ9K30So4VcUzzDFN/5xQ1QX14aSbLGnpG/edX918GWfO3SNISWJJkHm9Jhg==
X-Received: by 2002:a7b:c4d5:0:b0:3a6:161b:4d77 with SMTP id g21-20020a7bc4d5000000b003a6161b4d77mr3007288wmk.87.1661979487247;
        Wed, 31 Aug 2022 13:58:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002253af82fa7sm15766955wrr.9.2022.08.31.13.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:58:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
Date:   Wed, 31 Aug 2022 22:57:51 +0200
Message-Id: <patch-v2-4.9-54d6bae3984-20220831T205130Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220825T141212Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split off the "; setting[...]" part of the comment added in In
960154b9c17 (coccicheck: optionally batch spatch invocations,
2019-05-06), and restore what we had before that, which was a comment
indicating that variables for the "coccicheck" target were being set
here.

When 960154b9c17 amended the heading to discuss SPATCH_BATCH_SIZE it
left no natural place to add a new comment about other flags that
preceded it. As subsequent commits will add such comments we need to
split the existing comment up.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 55ae3a2feda..fa2e2193e99 100644
--- a/Makefile
+++ b/Makefile
@@ -1294,10 +1294,11 @@ SP_EXTRA_FLAGS = -Wno-universal-initializer
 SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
-# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
+# For the 'coccicheck' target
+SPATCH_FLAGS = --all-includes
+# Setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_FLAGS = --all-includes
 SPATCH_BATCH_SIZE = 1
 
 # Rebuild 'coccicheck' if $(SPATCH), its flags etc. change
-- 
2.37.3.1420.g76f8a3d556c

