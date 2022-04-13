Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD71C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238505AbiDMTye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238480AbiDMTyY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:54:24 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EFD424A7
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so4153199wrd.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrxN0Vogdsk0Cdc8ZI8CjlHpPUqJD2QXpwX7utfRL+o=;
        b=TGF1P8sxbPMOqmpzX0UMNE1yuWP/ZzY1mtXYOloJ+HPyz75zSIQDB7pxHgnCjnqsyk
         tb6nsmOJ/mgKR0wgckhkd6YSJfd7pI8GfYdnWgYSVps57SwSGl5AOwxLLLr52dxEfg8m
         s1faOnZJCTGGGd/DpL17AlOFdnh9nnDbmlgZyeKMKGerNVf2/L3CKDf1kRcBzt4xLX5O
         SYn5Oh/jesP4zJdo0bP5NkIL5wNy/ZfSWWeOlE8bxHnS2R/TY9Q9TvQo0JpEOGLrpPJP
         TV4wsgli0ZseT9uv+yTWxc4BoPpVLMaBXtKGWKrSfeAMV9RIiwP8B3nfflRq/yo+hdl7
         82tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrxN0Vogdsk0Cdc8ZI8CjlHpPUqJD2QXpwX7utfRL+o=;
        b=XXbpAT49xryV/dHd1CInnDWtl8hPdBIVK0Y7g3J1ri/1Jdlzdj/tiC+s5+AfU7dBe8
         srKZW5gqjm6gNftV/bxNKUYswpCPH5enhDS0UWkvfgukGzjFbeCyS4W8l8W4pUBlT5dH
         VfezsXZXcYA4ij0YXveOhq/XTQyqYHJRHQZCC598SPlLXVMaOwpjoR6KJJI4jWg7OTuR
         aOkfDCBFij2Y1wrr3Bq7F6Uh3UCThqROSUILlkE2uwFRpGoPfu90KitkiqP1eP+p8oqf
         lBda7lnQucRo2Kuix0lJq8f0bu+D51wQfVnQLjoUtbiWepvpbnEOstcsp4cAQDY3hB+2
         Se9g==
X-Gm-Message-State: AOAM532oHv564TjPYb5Nx2RTJrxXvGfsLxEgmSmXN7rI/t+yI/gb13gC
        2N3A3qOptJ5gwLOuZuNrxHPwVuKH+mu9Zw==
X-Google-Smtp-Source: ABdhPJzA/xFoGnsl1c/34qGvReWz9o3yEict1bW2kwyNw+qAlkUHlZR7H+DWoIrzY7f4MxBbKxNMxw==
X-Received: by 2002:adf:c14d:0:b0:207:a28f:f5dd with SMTP id w13-20020adfc14d000000b00207a28ff5ddmr307002wre.679.1649879520538;
        Wed, 13 Apr 2022 12:52:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:51:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/29] CI: don't have "git grep" invoke a pager in tree content check
Date:   Wed, 13 Apr 2022 21:51:20 +0200
Message-Id: <patch-v3-07.29-cc81b9fe37e-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the omission of not adding "-P" (a.k.a. "--no-pager") to the "git"
invocation that spaws "git grep", added in 0e7696c64db (ci: disallow
directional formatting, 2021-11-04).

This didn't matter for the GitHub CI, but does when running the check
locally. A subsequent commit will start invoking it via a new check
from the top-level Makefile, and without this we'd visibly spawn a
pager when doing so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/check-directional-formatting.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/check-directional-formatting.bash b/ci/check-directional-formatting.bash
index e6211b141aa..de8e6e486f0 100755
--- a/ci/check-directional-formatting.bash
+++ b/ci/check-directional-formatting.bash
@@ -23,5 +23,5 @@
 # U+2066..U+2069: LRI, RLI, FSI and PDI
 regex='(\u202a|\u202b|\u202c|\u202d|\u202e|\u2066|\u2067|\u2068|\u2069)'
 
-! LC_CTYPE=C git grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
+! LC_CTYPE=C git -P grep -El "$(LC_CTYPE=C.UTF-8 printf "$regex")" \
 	-- ':(exclude,attr:binary)' ':(exclude)*.po'
-- 
2.36.0.rc2.843.g193535c2aa7

