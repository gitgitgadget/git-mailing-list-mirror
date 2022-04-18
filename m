Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DC0C433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbiDRQco (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346231AbiDRQcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8157030568
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r187-20020a1c44c4000000b0038ccb70e239so1408619wma.3
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5yYq9Sza2mXepk2gcmSyq+HRnpWK5emZy7d4DufRM2E=;
        b=KJjKearcRrlEnnN2K06pglYOxqksetnRuuH5OGq8TDaxyRLPM+ZojVgejt1og3KRy2
         UIj6HbcuFuiZE6TDcMgG2AlSz1FeDPjcRnFv78ssu3ms367IkaUggPpBPmq6vNcoAgda
         7R+mGcCuO/6y2FDGe3xVypOsh3l3Lvd9UydSb+R/IVSHgkSD0z9C9yWi/iIHa3Qn/7F0
         HmY/049Zq//w5BqgkJwMRHuh0FzRcmak2p2hORbkmcv0KMYx8ypHot3s8MngLjJ53GBh
         RQyxsY/D4yxbGzbRdZA/7+tu3bCe3QSh7UefXT4GqoLvv/6paeHiw0swtMCeS5Av00EG
         P2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yYq9Sza2mXepk2gcmSyq+HRnpWK5emZy7d4DufRM2E=;
        b=XTNGP9MDyUmO+qkdNOtEMB/140Tyxty05iuJgW7cjVT8lSnXIKDATXa7Z/6B9sRZWV
         1prK434sXNJExbSpGlSUA3wAfZglpMa2RBdUjbeKeeXgkiSEkDzrnKA/yeHYsChtE7qB
         2N4GBrPUXOZw2UOdv0KW7aAbb8w8WYoP5h3dL7U6hnz1jIe3Z/H5NR9i0SfKBAR1jPWH
         Fdjy1xlxtOzf7c3aTVcPrCzzvhOytjKJwasQklrHIg/Po6i4AXz6X2CZC8X6Cx6rg+0t
         CGZxdAPXGDaY0bGUVogXEDwzf4Gz2i+RSc4mLVFo9rJioYHCiu58CHuF4IsPN7LtY+gs
         vkEg==
X-Gm-Message-State: AOAM5338HpEF/JWwJ75GKhV7aP+BFL/b1LHg942yMFsl+YBgnJ/cN1a9
        FqRJeGxgrxvbK8WcTDDmXCnj19gfhq8bSA==
X-Google-Smtp-Source: ABdhPJzdv8NOBCcq+g1X9YzGXJyqy658K5sPi1xggc8OJZ+lyy2YWZ4OYNWPMsBJUd7Uf2SxTxQidQ==
X-Received: by 2002:a05:600c:54e:b0:38e:bbef:9115 with SMTP id k14-20020a05600c054e00b0038ebbef9115mr15843363wmc.60.1650299360890;
        Mon, 18 Apr 2022 09:29:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:20 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/31] CI: have "static-analysis" run "check-builtins", not "documentation"
Date:   Mon, 18 Apr 2022 18:28:46 +0200
Message-Id: <patch-v4-09.31-0f780bf9e3c-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "make check-builtins" check from the "documentation" job to
the "static-analysis" job.

The "check-builtins" target added in c74390e4a1d (cherry is built-in,
do not ship git-cherry.sh, 2006-11-05) is unrelated to the
documentation, so it's odd that b98712b9aa9 (travis-ci: build
documentation, 2016-05-04) added it to the "documentation" job.

Let's just move it to the "ci-static-analysis" target, and while we're
at it improve the output with $(QUIET_CHECK).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile                 | 3 ++-
 ci/test-documentation.sh | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8717ea7e745..2e1ae6c6067 100644
--- a/Makefile
+++ b/Makefile
@@ -3402,7 +3402,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	$(QUIET_CHECK)./check-builtins.sh
 
 ### Test suite coverage testing
 #
@@ -3492,5 +3492,6 @@ ci-check-directional-formatting:
 
 .PHONY: ci-static-analysis
 ci-static-analysis: ci-check-directional-formatting
+ci-static-analysis: check-builtins
 ci-static-analysis: check-coccicheck
 ci-static-analysis: hdr-check
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 9e0652c30dd..41e2b126311 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -14,7 +14,6 @@ filter_log () {
 	    "$1"
 }
 
-make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-- 
2.36.0.rc2.898.gdf6bbac50ff

