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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F96C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9288D22D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbhAEToy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbhAETox (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF03C0617A2
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r3so364451wrt.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBLe2w700Hho5dXh2nJ14muBzt5gSm+uefTx9cznLSg=;
        b=gphMtgyB5B9xRyTTcqZGPKuAqr0e0IuiaT7sl6trE9cc2dv7gmWwKoErSiT1bSjHhT
         J7YrdScGX7AQ9hn1rEy1Hhzer3liwgxsSypmMRFxCLRCKH/SGWycjv0qkT1eVa03Qyzp
         l3cYFvjCabaJialhB1LqfUpo+BdthKCb+XmHsQsclsBdRhHbxjQ1ZVgI+36cNOdTQ3VI
         ewmZjQkUJaEal7EoSoygn9zNhGtRmn+DVNDS+NctU5Jc4LKX6+xQ48pH5rVc1Ht60caO
         tmDiSfcnHUI/bQBy217EAjjTNs9ccwtOnL1y0rlxxi3xG00sR+stdyFV13Q9sKliPksq
         Ir6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBLe2w700Hho5dXh2nJ14muBzt5gSm+uefTx9cznLSg=;
        b=tdjxhxTEzMnNEKhq+r/9LGrhynhexL651xkmO4jJ/byVXz0lgUb3+uzKPJWa3Q8J2k
         NjRSO6fbQWvN5wA+Q3I1HEZHhgeCQ7g3uS8MXNtHFOsPN0ATo22rQoyR3xQCAy71EFnk
         BjVqDnxBeU2pHQzvR6HvUvuRk6ta53dncucKdmgfrDTDKf9HQ/C3UrJlBoMPvSk9HYAr
         fS2y42bM3eo+wm1HXeUFNB6Tkhm1tawP/AxHRBZhWSSAZ+7m2zNCNgMPHPhnNUILcA/J
         FXIFmqM/hzVJeqT24i3Zhcrb6xCzjoAv6/uEoVTXkH4gSsTp8/eHm+tpdI/ZCOfmxmwa
         kULA==
X-Gm-Message-State: AOAM533H3nEpy+ONUXQMSY8kf221ehKu+hck3uYkvOPCQTwXEMRMLOc4
        +IG0FSCQ+glsidAcZBfmQgUdKAhjLMvgnQ==
X-Google-Smtp-Source: ABdhPJxD36wd4d2o+12DPRH2YpPoDHvGw9qDTchf0ZOxNBucXTUNHZnIOZkjU1wASN5gIfE0syh0qg==
X-Received: by 2002:adf:dc8b:: with SMTP id r11mr1077946wrj.131.1609875816442;
        Tue, 05 Jan 2021 11:43:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/23] mktag tests: run "fsck" after creating "mytag"
Date:   Tue,  5 Jan 2021 20:42:38 +0100
Message-Id: <20210105194252.627-10-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the last test in the file to run an "fsck --strict" after
creating the tag at the end.

We're just doing this for good measure to check that fsck behaves as
expected now that there's finally a reference for our valid tag. Other
tests going to be checking this elsewhere, but it's nice to cover all
the edge cases in this test to make it as self-contained as possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index bb300d567db..048000cda9a 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -350,7 +350,8 @@ EOF
 
 test_expect_success 'create valid tag' '
 	git mktag <tag.sig >hash &&
-	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero)
+	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero) &&
+	git fsck --strict
 '
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

