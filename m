Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A028AC43334
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 11:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbiGNLt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbiGNLt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 07:49:26 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8ED2A267
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 04:49:23 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10bf634bc50so2095802fac.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jAvZEo9jS5mhmx3aD1wxL2tal6HFvG02OIsEx1Q64Rs=;
        b=gIPIGt7/eF2azO5j8RJQeM9jDV0f/9p+0SLIjJs4XGRj3KqRvG7R2kt52/vtmUGR0Q
         PY5qLqvQwa+ZP9QHChKZjJCiax9OJgt2ACGB3AUUU11WMHzECguWj1ZMniWek36yKlV0
         +Up1D+mLN7IXWFU8OU9pk0Rio9yu8aj0Pbj3auz5bx3vQ27puYr/tsZniHNxVriNWaBQ
         2sT9sfhBsCYx45qoqOg1YVUL9ReuDSiPT4gGvpGISwZ6SYPj8tPApCMB1/aRErp6h5Y1
         wKNsmX46rLUf+Tz2Ivkq2ZYIKhObedY5hzbMAl0e9qiVHv7EyuE5yEmiZkua8+8eBwNI
         B57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jAvZEo9jS5mhmx3aD1wxL2tal6HFvG02OIsEx1Q64Rs=;
        b=fD6UBx8FIKEuc2y0rmo3Kq94rm8/M/Vmp4S3dFF+RFCrXTNTxzgXrZCbCncYztGpaJ
         raD+5aV8F9t0pHtiESk5fWr9pWrnjivJ9YYLG81esVg34T7xMB7CUua2NT91Mm5pIRrE
         tR7JgCHbpRJ7uHlU1R+HIz5EvaIxa1kkbVz6TrTo34ssgTqg8BHQLJUxiqy9HOKJi3MI
         nnCqLpPgiYpYldFRkzWd0Bsulz40xbGAoKF4a5JwUk/X4IGrQQ1fQY9nx7bxS54GGtuk
         qZbRvv9+KTndXM3J64k0cLvDifaRfzmBmU69Rwxf2D2blmZcxMGhsFF6IAX0S7RxBC4L
         Y27g==
X-Gm-Message-State: AJIora86e4RZ6wKgafu2/mrOC4r93PiwUOJv+7HyNWnNSP68giNj2pM6
        nvQrWyyDKu4GqNYkZ66EAp2oBChVtCFUFQ==
X-Google-Smtp-Source: AGRyM1tSo5A7vsfX8Xh9ojkWZ5S+7X+mNhZQmVn5NRJRNAevkovYcFAcyXYzOzvRUOtXZl0P5018og==
X-Received: by 2002:a05:6870:538a:b0:10c:3db7:c5fc with SMTP id h10-20020a056870538a00b0010c3db7c5fcmr4318066oan.71.1657799363037;
        Thu, 14 Jul 2022 04:49:23 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id o23-20020a9d4117000000b00616c5ce1d83sm548035ote.68.2022.07.14.04.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:49:22 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: [PATCH v2 0/3] checkout: fix two bugs on count of updated entries
Date:   Thu, 14 Jul 2022 08:49:09 -0300
Message-Id: <cover.1657799213.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657685948.git.matheus.bernardino@usp.br>
References: <cover.1657685948.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changed since v1: small simplification at test t2080, to use
test_oid_to_path and test_stdout_line_count.


v1 cover letter:

This fixes two issues at the "Updated %d path from the index" report at
the end of a `git checkout <paths>` operation:

  - Delayed checkout entries being counted twice.
  - Failed entries being included in the count.

The first two patches add tests and the third implements the fix. I came
across this while working at parallel checkout, but only managed to get
back to it now.

Matheus Tavares (3):
  checkout: document bug where delayed checkout counts entries twice
  checkout: show bug about failed entries being included in final report
  checkout: fix two bugs on the final count of updated entries

 builtin/checkout.c                  |  2 +-
 convert.h                           |  6 +++-
 entry.c                             | 34 +++++++++++---------
 entry.h                             |  3 +-
 parallel-checkout.c                 | 10 ++++--
 parallel-checkout.h                 |  4 ++-
 t/lib-parallel-checkout.sh          |  6 +++-
 t/t0021-conversion.sh               | 22 +++++++++++++
 t/t2080-parallel-checkout-basics.sh | 48 +++++++++++++++++++++++++++++
 unpack-trees.c                      |  2 +-
 10 files changed, 113 insertions(+), 24 deletions(-)

Range-diff against v1:
1:  694aeb19f5 = 1:  694aeb19f5 checkout: document bug where delayed checkout counts entries twice
2:  8da18a0a8c ! 2:  4541e90224 checkout: show bug about failed entries being included in final report
    @@ t/t2080-parallel-checkout-basics.sh: test_expect_success SYMLINKS 'parallel chec
     +		git commit -m files &&
     +
     +		a_blob="$(git rev-parse :parallel-ineligible.a)" &&
    -+		dir="$(echo "$a_blob" | cut -c 1-2)" &&
    -+		file="$(echo "$a_blob" | cut -c 3-)" &&
    -+		rm ".git/objects/$dir/$file" &&
    ++		rm .git/objects/$(test_oid_to_path $a_blob) &&
     +		rm *.a *.b &&
     +
     +		test_checkout_workers 2 test_must_fail git checkout . 2>err &&
    @@ t/t2080-parallel-checkout-basics.sh: test_expect_success SYMLINKS 'parallel chec
     +		#  - parallel-*.a: the blob will be missing
     +		#
     +		grep "Updated 3 paths from the index" err &&
    -+		test "$(ls *.b | wc -l)" -eq 3 &&
    -+		test "$(ls *.a | wc -l)" -eq 0
    ++		test_stdout_line_count = 3 ls *.b &&
    ++		! ls *.a
     +	)
     +'
     +
3:  5e9452be66 = 3:  b182d74e96 checkout: fix two bugs on the final count of updated entries
-- 
2.37.0

