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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C43C433ED
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B13D61442
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 10:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238543AbhDUKPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhDUKPz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 06:15:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D084C06138B
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so37032998wrt.5
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDkCLJEGMLKZ6/HHL+PGaGgb5kW5Kdlah+G/hRfY3BA=;
        b=BUcKgqxb8OiNmMSqSpvCp4fMQ6DDCFs3kOcPtd0LU/+FNHt70WQorbMuJldV3H+FXu
         tDIDHbMF7jbq/kq3+uO3tqZyvGL45k0OvH5i9LAbtLox70XsbbPDcXf6VN6EtmupcG3d
         7bYIX2rRCmVkNMz7Y5rkEpBSO/7u/zpbrTMZC9Disl0nzukTT2+DtEmHL6E1PBfapEam
         ZVPeWoMTmxe4Ay+Py98IRrdsbd4gxmHG9w7E7tjxJtIpu3KY6iwROq86aktPv+rxVm1+
         dY1Le4nXOiMaPHl4oiQazH5adm4g5HCgiXLejvbsiB3jxiKrO4IQu358t65ASTZwD5jj
         AUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDkCLJEGMLKZ6/HHL+PGaGgb5kW5Kdlah+G/hRfY3BA=;
        b=KkzADwFZHN4cVoWPkDkuYIDT25edmV/1/WMwfkrgE8cahDKUsT1pymZqQTebT5UtWP
         0RkSeoih7oxmI60y1pWQ6HpT1NJu988b6dvwaUKYQjWJLcuT+cvHvWTLcZnEeDl1M6AA
         uQa93Cf62NCTBKdg/8rVdAQvA/hcblHnyBT7ioRLtZZe1cKaXa+50WCmJIpuHan8uIbe
         hc1aam54OO0Z1RuKwwN5mckl6O0hd01d2OYJahJAZiUgU/xaorjKh+vkLPjjtJaW+LGP
         Abtcg3ShyVVvsoV7cocPY1sNDo9wnjgzgl3zQJ1++ChAAYoLqlgMyOonRaTVqVgG8Ndb
         PpDQ==
X-Gm-Message-State: AOAM533bt4UawGs6rbqAgm0rJvIkf3IttU3k3soV2MxWvOxzCcP33MEY
        dZHQL4fvZKzhMw+mp/+yQQ/ePSYzRp+SOQ==
X-Google-Smtp-Source: ABdhPJyXomvkO1EZrryc58HKFk0Ylj6HBWC0W2t0JEui1KrLaD66Dhhj2W/l7DRm4TND0rslTIAnuQ==
X-Received: by 2002:adf:ba54:: with SMTP id t20mr26588298wrg.353.1619000120960;
        Wed, 21 Apr 2021 03:15:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i9sm1843084wmg.2.2021.04.21.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 03:15:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/11] test-lib tests: remove dead GIT_TEST_FRAMEWORK_SELFTEST variable
Date:   Wed, 21 Apr 2021 12:15:07 +0200
Message-Id: <patch-02.11-de7be7844e-20210421T101156Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.721.gbeb6a21927
In-Reply-To: <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
References: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com> <cover-00.11-0000000000-20210421T101156Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop setting the GIT_TEST_FRAMEWORK_SELFTEST variable. This was originally needed
back in 4231d1ba99 (t0000: do not get self-test disrupted by
environment warnings, 2018-09-20).

It hasn't been needed since I deleted the relevant code in test-lib.sh
in c0eedbc009 (test-lib: remove check_var_migration, 2021-02-09), I
just didn't notice that it was set here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0000-basic.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 705d62cc27..2c6e34b947 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -84,10 +84,6 @@ _run_sub_test_lib_test_common () {
 		passing metrics
 		'
 
-		# Tell the framework that we are self-testing to make sure
-		# it yields a stable result.
-		GIT_TEST_FRAMEWORK_SELFTEST=t &&
-
 		# Point to the t/test-lib.sh, which isn't in ../ as usual
 		. "\$TEST_DIRECTORY"/test-lib.sh
 		EOF
-- 
2.31.1.721.gbeb6a21927

