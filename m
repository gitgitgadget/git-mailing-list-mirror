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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61B6C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CE76113E
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 00:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbhILARd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 20:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhILARZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 20:17:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C45C06175F
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so3968489wmq.0
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 17:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8rW8iJmsCkigfQpcMTzE9IDkfyIJ2dOb7VEkRPVGmI=;
        b=ZHyY71G+RKa4FFwYUCuC5ztgejAHln3DGAzzuA7Jfjd5VK959dUNCxPCPUFzxA8NK9
         MaOyxKmL3cxj5ulKw4P9XLKG1G3rxfrVqcDWgP6i0b/gaOPnrYNcUiytk2dNW/kwUfi9
         qWokKyVXcJlezaXmUxA8g9GVrbbYfr2btVhA61hXCuuFEPADvOPvcWXiLeJbMutcqwTv
         4oQ4EqSLe6dKuieqOv59yS1zc5KjD5ufoHUaCLDURgrWT9k0xNG76rJL5PP9x3prNfF8
         tgdByoiOHy3RISfT3LI7Ub9Kd2ndel+5txCib5EYBTEEUcrZcKQlbmf+ISfp6F0yPpbv
         oc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8rW8iJmsCkigfQpcMTzE9IDkfyIJ2dOb7VEkRPVGmI=;
        b=G4D6iRgnlu+5uBNxYFZfJtf3YOmqZeRr8S51aINIwy8yX050vMtc2bmpoG4FD8jTS/
         MrWH01zy0gEryegAkR+na5Pqjnxh95WzM144Po1jgdjeCzPbg9R6EhJp8AJ9ESGHuQ+t
         RuC8beBZTzgjXoqAoak4Rbw4EKvCDG51eYNsbSAMCsA5gbyv0KSFrIbRHqGDXsNEjYIP
         UfDEKHzVOy+A3jXaI7mB6L9x4WeIw7uqxf37gEqk9tvZcOGeyHzhssGF3xuYEXRfwRMs
         BLI7lW1xdbID7K+bCMSWPbuA/im4SgsYi9HsUiI5N06cj5B/d8lDq0DtR6nQCBPFTWuU
         4Haw==
X-Gm-Message-State: AOAM533V5m86YGbDsTn3OWlJmzH47zdcR9Cok/+udiHuKK+1DXnknY/H
        uLbp+V2OisKzcqU3aaeILC3I6F0dsKa6zA==
X-Google-Smtp-Source: ABdhPJxg793Y2mTRfFcmCJEj6YR2E0+QYq6kAoCNE0ppEC+ofEE/EYR5vjHPHGHEMgPfpPvYrlwwKw==
X-Received: by 2002:a05:600c:4fc8:: with SMTP id o8mr4422001wmq.106.1631405769916;
        Sat, 11 Sep 2021 17:16:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p5sm3301078wrd.25.2021.09.11.17.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 17:16:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/7] strvec: use size_t to store nr and alloc
Date:   Sun, 12 Sep 2021 02:15:54 +0200
Message-Id: <patch-v2-6.7-ba17290852c-20210912T001420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.998.ga4d44345d43
In-Reply-To: <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
References: <5e5e7fd9-83d7-87f7-b1ef-1292912b6c00@iee.email> <cover-v2-0.7-00000000000-20210912T001420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We converted argv_array (which later became strvec) to use size_t in
819f0e76b1 (argv-array: use size_t for count and alloc, 2020-07-28) in
order to avoid the possibility of integer overflow. But later, commit
d70a9eb611 (strvec: rename struct fields, 2020-07-28) accidentally
converted these back to ints!

Those two commits were part of the same patch series. I'm pretty sure
what happened is that they were originally written in the opposite order
and then cleaned up and re-ordered during an interactive rebase. And
when resolving the inevitable conflict, I mistakenly took the "rename"
patch completely, accidentally dropping the type change.

We can correct it now; better late than never.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 strvec.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/strvec.h b/strvec.h
index fdcad75b45b..6b3cbd67589 100644
--- a/strvec.h
+++ b/strvec.h
@@ -29,8 +29,8 @@ extern const char *empty_strvec[];
  */
 struct strvec {
 	const char **v;
-	int nr;
-	int alloc;
+	size_t nr;
+	size_t alloc;
 };
 
 #define STRVEC_INIT { empty_strvec, 0, 0 }
-- 
2.33.0.998.ga4d44345d43

