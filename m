Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45358C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DDD60041
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJ1U7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhJ1U7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:59:31 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DCC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:57:03 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id y10so7203854qkp.9
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+IU/3uLCKLMiOa7yVyomSzHwuX8xZh8k9+kTnqCGzY=;
        b=T/LhEdeD/IOFB8NFp3P4Z/QWAE2p18IZtMnLI4cm0rNNoW8WGq7e/gGZnIeOyytyaT
         RZNtdD1L0EtSVwcWL9E0VM8xx+X153blyK3COwVpmM3pPXrFc58Q9VHVvUULCWlZJ7jy
         4+X9tQ3ol6P/c/N807ynIQ06Oet0t8t/u6ZW++su2R/z6Efg3OJwySC/mSEvkJGcoNUR
         fMxyBiSQ5bav/oI0Y5+qrcAWzW9DgZs+2+GeN6hGhphSKGdt524D3g+wfldMcAhksdxK
         YcQjW+wQHT3O1ON/lsmhcSOxesd3TliyxXnfRKWRF3fhqcAag+j8rMvn1mgHn8hfxlIy
         jIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+IU/3uLCKLMiOa7yVyomSzHwuX8xZh8k9+kTnqCGzY=;
        b=hrnzzI0f2a8aUzp2Rf4A12DKMoiz2E2Fw9LXlJ07eOpWePVHqsjOif9/ZXoRpWwasY
         g4r+fOKpyAQUjL+Kf3yWHIE+HXT5PZ2K/4MaerapGHsvx7o7VtEIyfs7Oycu3JEeB9Nf
         GP97s3QPdVGEHUOsTcpcjg2+5xzmGe3TPnM0WGUOxI1rdkjh6TPcNPZZfwUhrIzoe3pC
         38RoqVKSZ89EbHPX2TlzbwkXPS2Rl/Zz2ZkEk0QdNv7erpQlvF9II9zKMjbsVmrmgl0j
         c+wTy9ANjDLPtgxwwZBVtX7DS2ivX2qjkqiExfa13Qgh5uVZhR07hwI0W8QhK4QYc9DH
         maEw==
X-Gm-Message-State: AOAM533CRBnScgDvzOZaTtlIcWTWya19kzsvTVPrjaMRDTyAVURc1+Y5
        O1dW3lOh1o9ppS5u5twCZCJJuLJVIB0=
X-Google-Smtp-Source: ABdhPJxN1rucpWCmhuKgySb2WaEEuS2Il38nbHnLarGP4G47lEVYDRXEPW55B6IGlnySHp9CR3+0rA==
X-Received: by 2002:a05:620a:5ac:: with SMTP id q12mr5637665qkq.333.1635454622889;
        Thu, 28 Oct 2021 13:57:02 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id az12sm2626136qkb.28.2021.10.28.13.57.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 13:57:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, vtbassmatt@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] fixup! clean/smudge: allow clean filters to process extremely large files
Date:   Thu, 28 Oct 2021 13:56:49 -0700
Message-Id: <20211028205649.84036-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1155.gbdb71ac078
In-Reply-To: <20211028205649.84036-1-carenas@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
 <20211028205649.84036-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t1051-large-conversion.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index dd5f270b20..e903570f30 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -97,7 +97,7 @@ test_expect_success EXPENSIVE,IS_64BIT,!LONG_IS_64BIT 'files over 4GB convert on
 
 # This clean filter writes down the size of input it receives. By checking against
 # the actual size, we ensure that cleaning doesn't mangle large files on 64-bit Windows.
-test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on input' '
+test_expect_success EXPENSIVE,IS_64BIT,!LONG_IS_64BIT 'files over 4GB convert on input' '
 	dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) >big &&
 	test_config filter.checklarge.clean "wc -c >big.size" &&
 	echo "big filter=checklarge" >.gitattributes &&
-- 
2.33.0.1155.gbdb71ac078

