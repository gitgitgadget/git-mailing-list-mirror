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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D923C433E4
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1CC619BB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbhCWQkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhCWQk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 12:40:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5EEC061764
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:40:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x16so21445190wrn.4
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 09:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x17BVCmz8stAYPddsIhcR4K+c68IC8YYpHBG1Yw3VKU=;
        b=dP6jZrGmKOz6g4atVlKGXvZ4ixAY1/nlIFxADtS4jeGUWSwbtWtt7gLUmZ7ejZvTDa
         oCzUMfipKtKKjWiSooUZV3nO9efiKLh5ZayG6VZRX7qnflWQdtglwZx1AOvuAgGW3/Q7
         ox1qws89lXRrSk8bu6+N+0CnTHmMKdfTksM3qyhlZGi5ogDr1k0sDdGPyiHvHt2Q0ApC
         nz3n/IF7weHmMq8YscWax6WZZeIK/TSdGEvt0isQU5Onp8bmORK8dqYNPLa+x4zFSGEo
         2u/S28gsaAF0HGWdI+ZAD8IZQssR6xdwqM8vJTP3w1U3S22UUD/2lz1KdGnew4BCdWrP
         qd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x17BVCmz8stAYPddsIhcR4K+c68IC8YYpHBG1Yw3VKU=;
        b=llqJjPeQJJAZl/B/QRKE7XWhdXpDlyomlttOKQPLcgZPkhLVD8eNVarh9PIxcvduKt
         dh6eDKU+mjGyrcfo3jrU49e+8jRpEOZWzhmogv3Dxr1GSus1watCnkoREDv/OGJYs9au
         pnMl/4guzNuHM2i6L5d+aR0lIZbir8OwjYTkpHpxVWZecOa91P/H0yEdRI+ZXIwZALKi
         QlZoQi4+3L9VUyM7jjJSF5ATe/OipkpYP50bWZy2txzSlkJa6y5YztbXk4vSscOmIjSL
         Lx8uqCWxlwqqma9cOCu4ZD2USSlkpDtBIJqFwk0Bdf8x1mlTYOn7Fvho+EHAgUMsRzQE
         wWKg==
X-Gm-Message-State: AOAM532LiOhO0c78c14iY536s3Jk8BEaQ2CiBrxBT0JlF7kT6sn3otbH
        Ddr+eVRoI4yzykx3lbhxfqFCfWAn1Gzh0g==
X-Google-Smtp-Source: ABdhPJxzuXQLZ8BVpXPKblQ7hWGYZn9ZMwCzmBAnjdRu7x6Li3OkL7nxp8aBacgWFIucueUq3nywtQ==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr4969177wrp.252.1616517627201;
        Tue, 23 Mar 2021 09:40:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i3sm25037488wra.66.2021.03.23.09.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 09:40:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/2] diff --no-index tests: add test for --exit-code
Date:   Tue, 23 Mar 2021 17:40:13 +0100
Message-Id: <patch-1.3-7dd5c309a70-20210323T163917Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.366.g871543fb182
In-Reply-To: <cover-0.3-00000000000-20210323T163917Z-avarab@gmail.com>
References: <cover.1616366036.git.avarab@gmail.com> <cover-0.3-00000000000-20210323T163917Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for --exit-code working with --no-index. There's no reason
to suppose it wouldn't, but we weren't testing for it anywhere in our
tests. Let's fix that blind spot.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4053-diff-no-index.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 0168946b639..44b932fbb20 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -16,6 +16,11 @@ test_expect_success 'setup' '
 	echo 1 >non/git/b
 '
 
+test_expect_success 'git diff --no-index --exit-code' '
+	git diff --no-index --exit-code a/1 non/git/a &&
+	test_expect_code 1 git diff --no-index --exit-code a/1 a/2
+'
+
 test_expect_success 'git diff --no-index directories' '
 	test_expect_code 1 git diff --no-index a b >cnt &&
 	test_line_count = 14 cnt
-- 
2.31.0.366.g871543fb182

