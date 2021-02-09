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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5314FC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0786864E54
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbhBIXHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhBIW2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:28:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5E7C03C060
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u14so23876213wri.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTUrbus+7fU6b/FgX/xfOphNnsBKjv+9IP91do+BagU=;
        b=JGPrMyvF3r6tN92d3+m6aEHPjr4wZ1hkKiZDpmN/PxLoDg8Fyr43aNJ9O6af30h3Vb
         jCjL10psgftOIVNpu8VdK2BhzvfPJRmrEjT6NO0eBWjBMt/DTUEO54jLtZiJoVdjPHFn
         TUOAUR6HC/DRNUb6CQwwL+SlOmvcLdD8FQV4iH38l/ashBi/sblxKlAH8QUDx86eeH6A
         q7zcmYGsa3fU4zGg6XzVBte2Ta25Y9UngLJV2jN80gGuxnFhSAQFnIFMfN9ORjdD88+w
         z1DEpOQPDnYorFgDQOwxABggBe/tj4wZaN5qZuV0r2uMZ3nDYjDmsMVZQ7KP5/mSfAOt
         nLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTUrbus+7fU6b/FgX/xfOphNnsBKjv+9IP91do+BagU=;
        b=C+vT5CjtMMSIah9rvur35YbWP9bTz0k/pswJI+uGuEI8tTvoqBVu3kStAVN6xmO5SO
         84L/QyntiZgMM1rEl1CWEVuI96wnudc1SDoCP6kCUXBPzEinATb8RjCf578U2aDxiEIp
         i4UQhI6CujOVS+ulFfe44Vr0jWe1Mn2ueq7uUMkO75IAfqWloKQXYKEy0+xwnLVPoOqf
         aRhrnbeA7c/mlUAaaAoIc66dVfHC6qUXz3+mDhCypSQgdGz+ts8QBAtXbe0Knvydw4B4
         rU660N4Nw3eoPL1s3A1+EMjiotYM3FOoYpWbmc3mGoD5q0BlU3sGVWGuRMR1YwYQt1Bv
         6J1A==
X-Gm-Message-State: AOAM532H+IqVV3j/LUt0+kBfnKUjvY6Ehn1S4mHKth13BErvwfF35LVF
        AUiNYIa9YwKCwXI90mqVdstmCbmVGIp72Q==
X-Google-Smtp-Source: ABdhPJwdtul70ClBGEit1QA/Qg9XzNbkzcvCnCy9VZDY2c12z2Zuxi5N6K2RqlW0BtgtLTXSqMYC/Q==
X-Received: by 2002:a5d:6181:: with SMTP id j1mr120564wru.11.1612906940663;
        Tue, 09 Feb 2021 13:42:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/12] t/.gitattributes: sort lines
Date:   Tue,  9 Feb 2021 22:41:55 +0100
Message-Id: <20210209214159.22815-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sort the lines starting with "/", the only out-of-place line was added
along with most of the file in 614f4f0f350 (Fix the remaining tests
that failed with core.autocrlf=true, 2017-05-09).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/.gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/.gitattributes b/t/.gitattributes
index df05434d32c..d778bfad052 100644
--- a/t/.gitattributes
+++ b/t/.gitattributes
@@ -5,9 +5,9 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
 /t3206/* eol=lf
 /t3900/*.txt eol=lf
 /t3901/*.txt eol=lf
-/t4034/*/* eol=lf
 /t4013/* eol=lf
 /t4018/* eol=lf
+/t4034/*/* eol=lf
 /t4051/* eol=lf
 /t4100/* eol=lf
 /t4101/* eol=lf
-- 
2.30.0.284.gd98b1dd5eaa7

