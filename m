Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EF6C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 10:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbiEYKF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242154AbiEYKFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 06:05:10 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61D36D970
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f2so29435607wrc.0
        for <git@vger.kernel.org>; Wed, 25 May 2022 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4srXT5BHtJZZxKgsAR5TATfiegFgKI2HbOM+OwQefac=;
        b=Zad+jgWLmXpPRI866JeZiVNuCh/d+uinqHHOo1WX8nKFj44wxeh+9ClLpqhiki65L/
         uAGurOG+Ei7mnvSRI2QKBMEwi1rTqD8Lde2uMxXvfriASzXXTL4eHdeS/Frzn0t11ff6
         1Dly12FjvoZsswwHzCCgCAYKS9Rj09zmG7Q12AUF39TQd+XMalLJkrjaDfvOKSW/m5NM
         52x0sGK+hByEy7DqXxS/MgJsTcQ4exc55GhvcR/2e5658csJTQ3QhqtDR5dGaXT/OXrn
         RtNzmQOUT/ZkB72U8S8KPSainAMTd7bZJmSRdOU7fDLLrhI+4bq5hWJtF2DKB2OtYCxU
         xuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4srXT5BHtJZZxKgsAR5TATfiegFgKI2HbOM+OwQefac=;
        b=i6EIFQl4HYVVG1Tu1wkGa5p1nQMcBA5PLYExg/wooxwwaTbDOT65qFs4F9rrRhCdl+
         fbvKcs8YaaEOrnSGKudqy3kLBWy9Pg+iokdQf0MbkCK5iwv07w+toVpCUhlZFzFTQ634
         jENJeAUVizs9rpFjqJu/avfxmOwKgxAFZ6WYlH5oKisZTdQdFGG7SdULeKme601cqKZO
         zA6yit2+KtPgxs1PvPSP52RZLN0NxFs0UpD48H2VEnkimPB19i7BQe0JkcrpIPIlcojJ
         1oX9Zqzs+62Tt13Ry3GLhJniqHk5GZSuAe1mBK7sfr3E/3/OC3jjb359N6KG0NHBtFU3
         GWPA==
X-Gm-Message-State: AOAM533x1EhYRcLhf41qlIhOASGduw0fqS5D/qkIfkSK5vmfMzWbOkSI
        o64OOMpHcc0GnKYa4L4CaN7PERx31ufr7Q==
X-Google-Smtp-Source: ABdhPJxoyEbXzfhc7U6Rr149CP2Kbvb1Emdewq7KSNdCJaj37bit7wCAm2UUzMfnaN2YulLkiVAgPg==
X-Received: by 2002:adf:f90d:0:b0:20c:de32:4d35 with SMTP id b13-20020adff90d000000b0020cde324d35mr25916294wrr.583.1653473109042;
        Wed, 25 May 2022 03:05:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600002c400b0020d0cdbf7eesm1649452wry.111.2022.05.25.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 03:05:08 -0700 (PDT)
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
Subject: [PATCH v6 26/29] CI: set SANITIZE=leak in MAKEFLAGS directly
Date:   Wed, 25 May 2022 12:04:05 +0200
Message-Id: <patch-v6-26.29-98e320d5e67-20220525T094123Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
References: <cover-v5-00.29-00000000000-20220421T181526Z-avarab@gmail.com> <cover-v6-00.29-00000000000-20220525T094123Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit's change to do likewise for CC, let's not
set SANITIZE in the environment. When I added the "linux-leaks" job in
in 956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in
CI, 2021-09-23) I missed that I could do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 8d19ca5ced8..b6e7a6647bb 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -225,7 +225,7 @@ linux-musl)
 	;;
 linux-leaks)
 	CC=gcc
-	setenv --build SANITIZE leak
+	MAKEFLAGS="$MAKEFLAGS SANITIZE=leak"
 	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
-- 
2.36.1.1045.gf356b5617dd

