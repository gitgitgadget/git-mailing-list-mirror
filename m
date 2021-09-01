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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4C9C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0197F60F90
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 09:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbhIAJV4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 05:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243625AbhIAJVf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 05:21:35 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB567C0611C2
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 02:20:33 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x10-20020a056830408a00b004f26cead745so2621960ott.10
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 02:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=etJZiSw6zzJuMMDYOyvb0rqKUHA9zBpe5BY0FDvA+ng=;
        b=QTMUOK/v/48PGG+fyeofzFagPUTK2bLvwNyNr7XUMcXT4WkuHqHXLcV1EWAAC/ofzY
         Q5cCj6WyNPHGxROBnLDo7T5tpb0xuwSVyjMaIRc/DXHQ5RDXKw6MI2sS1E2Ru0pHh1HF
         SFo5ZfVNqpGcURaAc3H8MFxEOA18DFi3BaULDlEY/I2nspPcRNiqGbKZMxZ3DWvvkjnp
         mfTpvY/v4ngIUExxyqKww46m6dQ4NzuNDp44al3mcv1BdgfOLjJWLZOnhzdvxhoLy3u7
         xj10nx0P1s/3gXoGo3aznifNgfoan+rAaIGyRvngPJUJOmM/GMaPQWMoZVLiE6ibhdEf
         EAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=etJZiSw6zzJuMMDYOyvb0rqKUHA9zBpe5BY0FDvA+ng=;
        b=ITfJku10IE5zINh/wHIj7GP/9YhIH8Zt+OaRJ4IiFru75s+UnPEsiC4CfgM16BvGHc
         u1yRtYAC2yoxzwh7aUFXsbZBCGRLfoKuzhkDg4I1/Npks2O873MpjGwRzUWyOki/h/1T
         IIXTKZXfzLG6g55ENadyuR3EeqHQJI5Hwo5E3fuBZXc71vIPpy1shGl9QLf2MbnTqWxx
         mDabasePunVifWvW1BRQkL5dsFpj0NbFf+rqiybrjSNSpSUw4VcmIxdnzWxDu1i9wYr/
         KD38XZ88TYOq8KbrNle9vG381GGsnjZL9v6nSgBEu5E3iUcxxelL/+yVDOdDpCtG2+La
         F74g==
X-Gm-Message-State: AOAM533yoUhp4NSCH3uX0i1J49E/KQciJadtNS3QHj+avzGdF2C+a8Z8
        vuNdltOuZ+DTCqiwRsuS+s5bDltoRLg=
X-Google-Smtp-Source: ABdhPJxKPjFQO4s17x6tr7r+PFSSMATSm7cdmi4+1gOFgvJzZIbkuyBYAnH1Rrts4N510sPvK4wAbQ==
X-Received: by 2002:a9d:1469:: with SMTP id h96mr26925227oth.82.1630488032828;
        Wed, 01 Sep 2021 02:20:32 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s206sm4161597oif.44.2021.09.01.02.20.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Sep 2021 02:20:32 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, phillip.wood@dunelm.org.uk,
        gitster@pobox.com, mackyle@gmail.com, sunshine@sunshineco.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [RFC PATCH v2 4/4] developer: move detect-compiler out of the main directory
Date:   Wed,  1 Sep 2021 02:19:41 -0700
Message-Id: <20210901091941.34886-5-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210901091941.34886-1-carenas@gmail.com>
References: <20210809013833.58110-4-carenas@gmail.com>
 <20210901091941.34886-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

as suggested by Junio[1], and using the newly created subdirectory for
dev helpers that was introduced in a previous patch.

[1] https://lore.kernel.org/git/xmqqva4gpits.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 config.mak.dev                              | 2 +-
 detect-compiler => devtools/detect-compiler | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename detect-compiler => devtools/detect-compiler (100%)

diff --git a/config.mak.dev b/config.mak.dev
index 76f43dea3f..e382c65aff 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -18,7 +18,7 @@ DEVELOPER_CFLAGS += -Wvla
 DEVELOPER_CFLAGS += -fno-common
 
 ifndef COMPILER_FEATURES
-COMPILER_FEATURES := $(shell ./detect-compiler $(CC))
+COMPILER_FEATURES := $(shell ./devtools/detect-compiler $(CC))
 endif
 
 ifneq ($(filter clang4,$(COMPILER_FEATURES)),)
diff --git a/detect-compiler b/devtools/detect-compiler
similarity index 100%
rename from detect-compiler
rename to devtools/detect-compiler
-- 
2.33.0.481.g26d3bed244

