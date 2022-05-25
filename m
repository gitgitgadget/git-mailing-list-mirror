Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6290C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241463AbiEYKFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbiEYKEy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:04:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECE46E8C3
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so29435607wrc.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+G96LJNZc5E4Mv+6QJTtQVuzM5ldVC5qI9hZ7L2MoZA=;
        b=lCDNbUsBD5v54KC0x7oFE8UlaPayAlVKL9xMCdv9duA4htzl6gbS7037bi6AJpfcSv
         TbkEKiCNIU2dSfYgxd656Tdewxv290IPKbXNiGVSNIt7Bb307XK0xxSrG6NQ+FEzGq02
         scE5UX0gQMgoA8dpPI0EsGOc8RFexGjewv3qMpwQ9X3ULDxbDuxkirFtDWmhW2DKYlum
         PQF6yhFjOVJpNE6o+dhLyEh0hv8YiAp13q7JRRhrkBOyGjfMZZROaMVGsOsN4cHzo+G1
         6PFdhHAo3b2ZPHlT0L53Uc+l5bcmTXwtePASfo2crFVNJ+lAmYXGFOn+GEKKSU6YAvn3
         6dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+G96LJNZc5E4Mv+6QJTtQVuzM5ldVC5qI9hZ7L2MoZA=;
        b=AORt9PRk3pdqRtoq3pCVSqb0sI8N4FPntuD8Rl7ZmASPWHOT++h0WWfy6wtmU3TUGl
         hUIvZUD+R39MJWLjIgD9y80Ipp1yICANrKCOmR1+fV1YIZ/rccpPUppH2hwRadX1rsbj
         Gz2dN6XPPCi0nSHA7w3ri7CXniK0fjwCXqcCfEz9Zqf0r/eAHmPLGhfdVtbK0OV4T2y2
         AFJBhWlCoFNQ0COsoQkR+t7IZGSlr6AfUZEcy0XzUrDCeNNXKYuiot8tQHgHVN3NR5gn
         F/BAwlY+/GrHCHuYMao+szOBpiz2EbJwR+2+SP8lU+JKaCIfgbfc/MPdA3SN/OAdqOZY
         fPYg==
X-Gm-Message-State: AOAM531ZLF+fLZ6SqtU+vc6x2+hgGMZvf7yoqkR9dKDoDtvS1SyZIyAs
        nPhTbToHqU/qy36Z9vlUht7PHZOcvta16w==
X-Google-Smtp-Source: ABdhPJw0gWcAaThwxiK8+H4mVRLMu+d6l0oFrzFSd/7Gz92lvHYu0vOpmZcANsdjGi+QeRCc3WOILw==
X-Received: by 2002:a05:6000:354:b0:20f:fe61:88fd with SMTP id e20-20020a056000035400b0020ffe6188fdmr1968415wre.339.1653473091287;
        Wed, 25 May 2022 03:04:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:04:50 -0700 (PDT)
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
Subject: [PATCH v6 09/29] CI: have "static-analysis" run "check-builtins", not "documentation"
Date:   Wed, 25 May 2022 12:03:48 +0200
Message-Id: <patch-v6-09.29-1a9c98b909c-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
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
index 9ae7e1a373e..3398d3f2e56 100644
--- a/Makefile
+++ b/Makefile
@@ -3405,7 +3405,7 @@ check-docs::
 ### Make sure built-ins do not have dups and listed in git.c
 #
 check-builtins::
-	./check-builtins.sh
+	$(QUIET_CHECK)./check-builtins.sh
 
 ### Test suite coverage testing
 #
@@ -3495,5 +3495,6 @@ ci-check-directional-formatting:
 
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
2.36.1.1045.gf356b5617dd

