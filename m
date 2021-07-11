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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02F6C07E9E
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FE861176
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhGKQdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhGKQds (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6EEC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:31:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g12so1790583wme.2
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3e+4dVxz7m4Dxf32tQc1AXV0BOf72Tt1Pj5m+DiaiY=;
        b=eud5JuPL6B7NqhLjWOYmhdmD9q/KLWfrVdpsKNkKVQRueXPisUZ/T629wN2XWda0r2
         3gBsvuir8s/zOE1ko5cjFX2wCXjFEAnVk2Cd45gDzIz/2UeE/Wg1dCimbrXtm9YNS3WE
         NGAb9vIZtKluWwOOcMh/ZE+3RAs0SVlBXWqGvGNuEmmoCl4uGwB7H7dNeL+R0jl6cosi
         TEA4a9K3yHAJ5t4102paHDSQ/eP2fRM95GpsYG7YE4PDSjyPJC7L990mGxrajR21QZ04
         p+O0Pmezy/uYpb+GGGqqZoFR6fRf3Ux9o+ZsmH1N7LodF5CD84i38JlYt2bjG4xT7+zi
         nyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3e+4dVxz7m4Dxf32tQc1AXV0BOf72Tt1Pj5m+DiaiY=;
        b=H58yFtRqLGaQwCZ5Zy4ZYM3pzXH6k/duVJQQML5qHymrE8W6ER98XVCstRK9EUw2aH
         PWrb3RRsq+9hYXEXhu7jxb2KixM/ld8D3mrzxtvEp7Rs5y+zyIy2B2i20rSWFHL3zrJY
         jZRwnvoymBY/9jMbHZWu9hfztYg/hIzfoAavwf5T0UDm0P2WO7R/TdV0WwXGZtZqunyX
         DWgog6BdKVn8sSLguEPnvncDw2AVM4sVmXEkxbQDP6xpIUQM1Dw1iQZrGxsM0Nqs43Sj
         3/I8HBCn9AUsQcIEPbquyXKLy7lhMo/mDDsStyue/fddg7BMO+xWAFLuAaIeCDj0pBv/
         bmlw==
X-Gm-Message-State: AOAM530mOmzeAiKtTRuohnbB+dmCZwAnDzvYRKcmMv/xSrw+9PRc51VV
        iGPDKeY/u3eTUqbZEdO7DgwnBWBsV1dHHQ==
X-Google-Smtp-Source: ABdhPJyxH02zMmFKmwt9okgEdp4RNx6uPEmj7gqP5Ry8ln5IiblKGfJHdsylIAT6rj3HnxcoJWblMA==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr10020484wma.37.1626021059313;
        Sun, 11 Jul 2021 09:30:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 17/17] refs API: don't leak "errno" in run_transaction_hook()
Date:   Sun, 11 Jul 2021 18:30:41 +0200
Message-Id: <patch-17.17-f914df0bb25-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In run_transaction_hook() we've checked errno since 67541597670 (refs:
implement reference transaction hook, 2020-06-19), let's reset errno
afterwards to make sure nobody using refs.c directly or indirectly
relies on it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 3357ba14e1d..f1477eed27a 100644
--- a/refs.c
+++ b/refs.c
@@ -2108,8 +2108,11 @@ static int run_transaction_hook(struct ref_transaction *transaction,
 			    update->refname);
 
 		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
-			if (errno != EPIPE)
+			if (errno != EPIPE) {
+				/* Don't leak errno outside this API */
+				errno = 0;
 				ret = -1;
+			}
 			break;
 		}
 	}
-- 
2.32.0-dev

