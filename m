Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301D5C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE3F613C1
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhDTMWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhDTMWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9425C06138E
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e7so28428035wrs.11
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYeDChtgEsC/IVgoNOfFLY+PHPMRIES1HFPwehZ/UZo=;
        b=ctABP0QGulFH/19XcUyXkAvF6yUCHqarDM1sRjSOhAicQUlujPEi69EMXpyHmGZTbP
         DB/WAVC+8/GK6I1VLQyiatOzzV6GXZ23wH+EryDFzwu9YHs1fsbd+uUyt6wdja9W/Sbl
         hx7SSoyB9TNVL16oVBwMcAKVyLhkvq+nDERgrbLKslKQT0cdn6YCA1OjzniTMOvFtG+k
         uqcq8jQaadRnyUulR3Thy9s134ciOdDXsMwEtOceoG/De6qPy7aC+PMQoM6x5aOAayC8
         fXcgKKBRZkuvc07sSagK2KdKK+TzbykSu3wXGODlIiWXORsZ6tnZlZ+FJR0X3kbOjhPm
         TF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYeDChtgEsC/IVgoNOfFLY+PHPMRIES1HFPwehZ/UZo=;
        b=QHQZVMBLJnjFVJeE2uVAh3x4wsLlYoDDZQdpiCdbU+qVlNbAA7jFpNoRPhvHSMkfrZ
         bSSibqFllsU9F4dSlqQGd/MFxtXEKUb3lSKaG817tcxHmT1/voo9YaICWYpjyHFRZEcr
         5rGOTda2/xx6LrR8QZdfWyUeItT794PuYWTTqo7smW3c/qfv1lP666ye1XwxyDfjx5rM
         49AwxtTNj5Eqq/6DgUXnlZXKvyvIPjXAaEaUs2pmZG0uh4OALkL8/ZPb+N/eXqBfE2CW
         9h5AyPTKNjYrtimmo+m3nsnK1l1Q2J5cOP7eSTzamoMtCl45VZSymnjpKSUxLPwHnYII
         Nx0A==
X-Gm-Message-State: AOAM530QAhB5AtQqVOxENmrOS051A0IYwQPRj3IyzAshBv8ycoRxAmbf
        0qN+nS4Vhvug4J4FP+yzOBWFxLFLDyKygQ==
X-Google-Smtp-Source: ABdhPJzPP5EORz5is96GZl6aR9j+2n85VT71PU4xFf1qY6UoVVRTdDkJSuDBcEmfY4NVn7jkRuHZDg==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr20406531wru.150.1618921335427;
        Tue, 20 Apr 2021 05:22:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:14 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/12] submodule tests: use symbolic-ref --short to discover branch name
Date:   Tue, 20 Apr 2021 14:22:00 +0200
Message-Id: <patch-09.12-90bf55d2d4-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a use of $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME added in
704fed9ea22 (tests: start moving to a different default main branch
name, 2020-10-23) to simply discover the initial branch name of a
repository set up in this function with "symbolic-ref --short".

That's something done in another test in 704fed9ea22, so doing it like
this seems like an omission, or rather an overly eager
search/replacement instead of fixing the test logic.

There are only three uses of the GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
variable in the test suite, this gets rid of one of those.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 4b714e9308..f7c7df0ca4 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -63,6 +63,7 @@ create_lib_submodule_repo () {
 	git init submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
+		branch=$(git symbolic-ref --short HEAD) &&
 		echo "expect" >>.gitignore &&
 		echo "actual" >>.gitignore &&
 		echo "x" >file1 &&
@@ -144,7 +145,7 @@ create_lib_submodule_repo () {
 		git checkout -b valid_sub1 &&
 		git revert HEAD &&
 
-		git checkout "${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME-master}"
+		git checkout "$branch"
 	)
 }
 
-- 
2.31.1.723.gf6bad1b9ba1

