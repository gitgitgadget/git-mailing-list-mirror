Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F84AC433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiEYL03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiEYL0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8230D9AE73
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o29-20020a05600c511d00b00397697f172dso954807wms.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=je6OJ96oelNs9vB0ASUeL0IdSQZy/0cGa8Vh4ggtMFg=;
        b=G7inlS8D5oxvQJC9XaA0gbCIhwrBPYxraCEBkfdRU6EWdDocBD//vtrYor9Ex5ZiYL
         O6wVKytdrgCsfTjfan6d1MpFn5sl3xToqvEW6ziL8v4jL0wDV0lpYTvPgx70UZR3Vr84
         OAVy8mKCjT5uEzfGH0c0FtIL5uokrQtZ/W4HJVJhmsQ8RnPMPuoqZdy17sMG5pV81huT
         KoL7L6WZmW5G+Wijp8ROjnpA78h2AVDsWjDHJcdNJLeEDLVriKFJK1T0dIzs3NAfXzeu
         C757EuzoeXeAmO1N+SowfO1g408dFjMCsCMlnM/CMbxiYrVfbDMBvxKKmQYxTb+uAvLC
         x8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=je6OJ96oelNs9vB0ASUeL0IdSQZy/0cGa8Vh4ggtMFg=;
        b=nQYWfoUt8Z+I/Bb6L46dM3brXigNgaJYKYC/1Gz5mpRljFDhJHTVaSje7QTBHAdJt6
         O3MZxPU2SWX0iPb8rZHQVhL+s+C30OkxnogCfqxqJmgR+GsQlWVkmlrnanMwjj8DRhP3
         sZ6HA0HtT8tH7EltM/PjxqI3KhyjKQ74CTO4Ex0NEbu+yoLZxWw0n7j1SY+qZd2q2nfp
         WO4PVZA5bAPz9Y+4lTX3kp2tP098RI9QBqvZGuE9qxoOyNqopJXur1T7NIkbBdmHFMKq
         bvFRS1+lmHUfouPQlC96lfMAaW4uQEXNEf+skx+oGR31nrHXz8TKna0GlcsE2UnjAGNi
         +flQ==
X-Gm-Message-State: AOAM533MEVK21ZL7kQMpDEMTlfpTB/Vz/W0GOsydkq4nkbYuhX2o+VJq
        6s++FL+T+8HH/g6yppUoYjb7Q6MIf+whIg==
X-Google-Smtp-Source: ABdhPJwMzyp2RNbKKMIsHw6asDF5BW0/GFi3J8TCCadeQmSAfolFTpuF+uMgDmWC3E/15hARFHtBeg==
X-Received: by 2002:a1c:f40a:0:b0:397:306b:caec with SMTP id z10-20020a1cf40a000000b00397306bcaecmr7797983wma.22.1653477981823;
        Wed, 25 May 2022 04:26:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:21 -0700 (PDT)
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
Subject: [PATCH v6 02/14] CI: don't include "test-results/" in ci/print-test-failures.sh output
Date:   Wed, 25 May 2022 13:25:51 +0200
Message-Id: <patch-v6-02.14-1d07ca58322-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the ci/print-test-failures.sh output introduced in
657343a602e (travis-ci: move Travis CI code into dedicated scripts,
2017-09-10) to stop including "test-results/" in the heading, it was
more of an artifact of how the iteration was being done in that
initial version than anything else.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/print-test-failures.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index f6736f424e0..1249bb0c0cf 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -24,7 +24,7 @@ do
 		TEST_MARKUP="${TEST_NAME}.markup"
 
 		echo "------------------------------------------------------------------------"
-		echo "$(tput setaf 1)test-results/${TEST_OUT}...$(tput sgr0)"
+		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
 		echo "------------------------------------------------------------------------"
 		cat "t/test-results/${TEST_OUT}"
 
-- 
2.36.1.1045.gf356b5617dd

