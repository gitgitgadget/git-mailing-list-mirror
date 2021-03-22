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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A2C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5911F6199F
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCVMMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhCVMMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 08:12:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A84C061756
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v4so16427146wrp.13
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 05:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTDHPW9pwc7PH1eEbY2UkaSZBT3P2v2obZRdFvPqz/Q=;
        b=b+Bz3+ihpgcpcIDPzkkF6+7C2D2vRTWNXPx/WUFzDmuyyiar9g2ltO7qjo/JIgAO5K
         Fo6CWWxZTLjdpzheKoxTJmuBJAlEjubEre+SozhFjJc8ld/fmOqPtC5kMSRAfSeGAUYh
         TNhGQRELHLk14RDLSMEawBtqGl1GACm7Wsxqb2DAAog/W3R5vCu3/FYTOFbPl4X88y8z
         025RkKRorw1TH2j9/Xc4H+wRnnaQTIZnfTeY97XChY9ARodeSrEP95Ama9C5WBTiyjQT
         S1lXECD9H0qPSnGsZ5zTEERN4cZ2gb0qA5rsVbRgtRKN3svaqyXRYCm9XGCdkaDalQ+9
         YWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTDHPW9pwc7PH1eEbY2UkaSZBT3P2v2obZRdFvPqz/Q=;
        b=umNARxsV1DYVdJQzKLBfTIbAUBI5B7fYqZjGE/iUWrn1JhhycVB85Lc+gICxjH8TwL
         fXXo2fQn7Uy+g4tsDZ3/xOUBsbi/4dqc3wguzIWvqUBxr5/Hx/IPAsl0OLuDbJWiJRfx
         E2HOxV3cK79qcHkBRFNCJgP1BoaB+5V5vHkoZ5ExfZv99jtnZRmqg6t/kaa8ayFTl8D4
         JX5JtoBZne27O2cSzJYDL3n9q9jzQmVNf2SkUE9IjdzANFroY/4JQpskZDY6B/KPyl59
         L78n4Yook0ljtz3Kl8RNOpGkYe7IcGYHyCEoVQ3YFHJqkVTVvK+c0nIvt3ptUVJFPApo
         36GQ==
X-Gm-Message-State: AOAM5328TFvLtmzkM55gksk6IYL1ZjnsQfpYTydpqgFRxgrBk1WgsswS
        u6nfzHCPOnKLPg3jbSYzwc5PLw9XqMsg3A==
X-Google-Smtp-Source: ABdhPJw5Bjf85jBU658KmGev472LOWAMLdQcev6F2fj3vZ64I+RpHtaCKS4wkj2QhBYtIUacqylNdQ==
X-Received: by 2002:adf:a1ce:: with SMTP id v14mr18244159wrv.228.1616415127502;
        Mon, 22 Mar 2021 05:12:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j20sm15621142wmp.30.2021.03.22.05.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:12:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/4] Makefile/coccicheck: add comment heading for all SPATCH flags
Date:   Mon, 22 Mar 2021 13:11:47 +0100
Message-Id: <d8c6efd2464782b1c313d0bb5c8e3dbde86a673d.1616414951.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.285.gb40d23e604f
In-Reply-To: <cover.1616414951.git.avarab@gmail.com>
References: <20210306192525.15197-1-avarab@gmail.com> <cover.1616414951.git.avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 960154b9c17 (coccicheck: optionally batch spatch invocations,
2019-05-06) the comment being re-added here was amended and reworded
to apply to the SPATCH_BATCH_SIZE variable.

If we'd like a separate comment on SPATCH_FLAGS now the diff to
introduce it will need to also move the comment. So add this heading
back to make subsequent diffs smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f3dc2178324..eef99b4705d 100644
--- a/Makefile
+++ b/Makefile
@@ -1198,10 +1198,11 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS = -Wno-universal-initializer
 
+# For the 'coccicheck' target
+SPATCH_FLAGS = --all-includes --patch .
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
 # Setting it to 0 will feed all files in a single spatch invocation.
-SPATCH_FLAGS = --all-includes --patch .
 SPATCH_BATCH_SIZE = 1
 
 include config.mak.uname
-- 
2.31.0.285.gb40d23e604f

