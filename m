Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B1BC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56676613B2
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbhD0KkN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbhD0KjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:19 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65535C061761
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q9so4774727wrs.6
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=algQ1aErS+lLlLPZ3mA8qMJLPQJXrWgJAe1xDKA+riI=;
        b=Fg8EKpXuPcWlZQ4HcyPfnaQ/yKiYi3c7wzIBkdyghoUwPukCBgRIkrXTwEOFe61EoY
         vtnont/n0/AcyLmB1E5scevAiCIM7bxNS7WU96g6tam00FerPZOpyIZYSF5ZXo0LjFh/
         QGDUlbgYqbZug9GHh195TJpzgPVvgNbQC1EZzCi4+luK4d83WmF/50KDNDmmiJkabPg7
         zhpjHK4H+XiNPfC6dFBTA1pVrBgdj3zMIe9LgxPvKe1eKdUd+H4Y6bnQxUpOGVHsM/wE
         fMuqpNwJ9b4i00bFA6KQw2pzgJzuA/SBRKiKUf44Ay8tdYOGt13d9XDbX2IdH5ioBbh1
         nl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=algQ1aErS+lLlLPZ3mA8qMJLPQJXrWgJAe1xDKA+riI=;
        b=msyzkmREfWJ/kE0kO8uRH1h8pxUHuuZCIGFcMj1s2btgtnP8NWT0T8cml6pHTLx207
         vbsowulL64yAy7tkM/yrYpdFZElKn6Oe8xAdJov3NtH0CacGsi9+7FtVDd/7B/UUh5VF
         w+GQ91fXN+sABiksjmtCZ5g9uhOw7Hkx/qdZus1R/beOZKgJIWuRpmt69uF1eVov4WFI
         vKJR7b27FAQiWTrQCFAs8KgZfd3mxE1ukYz9Oiko3WvYILraZQZjknu/ysmLmohZgIzq
         hQv9hYag/fFe7JcYw/FIJlDqAINzBf+cg38Dygex/XSdFN37JfGHXUcUxoDtd+NgK9cm
         5Uug==
X-Gm-Message-State: AOAM5301lNUExShVbSYaa6dssc0RukRiv+CKGiQJvVvHnYHOLIk1E5jy
        uBdoBexvI6jID+62uuO8b+oOq/r5OLw=
X-Google-Smtp-Source: ABdhPJw9rRxTac9P/3bvt3QOSRxKVmCZy7Ge3RZkCVh5UxM3sWkqBrg49lFef7crCSWnrisUwFHUDQ==
X-Received: by 2002:adf:efce:: with SMTP id i14mr1626672wrp.317.1619519913269;
        Tue, 27 Apr 2021 03:38:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm11052690wmi.39.2021.04.27.03.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:33 -0700 (PDT)
Message-Id: <b64e3e7ade1583f5ff669cfb6510f5d7402be028.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:17 +0000
Subject: [PATCH v2 16/21] t2017: mark --orphan/logAllRefUpdates=false test as
 REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

In reftable, there is no notion of a per-ref 'existence' of a reflog. Each
reflog entry has its own key, so it is not possible to distinguish between
{reflog doesn't exist,reflog exists but is empty}. This makes the logic
in log_ref_setup() (file refs/files-backend.c), which depends on the existence
of the reflog file infeasible.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t2017-checkout-orphan.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index c7adbdd39ab9..88d6992a5e1f 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -76,7 +76,7 @@ test_expect_success '--orphan makes reflog by default' '
 	git rev-parse --verify delta@{0}
 '
 
-test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
+test_expect_success REFFILES '--orphan does not make reflog when core.logAllRefUpdates = false' '
 	git checkout main &&
 	git config core.logAllRefUpdates false &&
 	git checkout --orphan epsilon &&
-- 
gitgitgadget

