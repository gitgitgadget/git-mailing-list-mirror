Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3646C433E1
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B522073E
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 22:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCmAWADw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgHJW31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbgHJW3Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 18:29:25 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62669C06174A
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y3so9633336wrl.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ofr+Hu5Tf6QDtMLwZu0ctJ5oDIF3fKZrk4aVgYXKZ84=;
        b=PCmAWADwyT9aeAPjYJi6ualmytZrXkEPDdl4uM8odKZerFxY8WMKTqaor/tYdf9Txj
         AaGG+y4IDuRlKAOByXTFCGKLkk+g65qP4tgz5k8zdeqr34FUmaSEtyrV++4CLI3m0Oz/
         dffVAWDRxEfRwV/GR0NI5BxHumpGTxzisUW/WqfPGGoLiVf05ZS5O7Qb6vEEwIE9qWsO
         Gmkq2NMfbbdowe2B8fOvZmdtEkp5ZuE/SSvbH2CCl2tqpxXi7kuodMKkZ0aeczV/dkOd
         2+mIOYgLi6Oeb3+8DvnVRIuyay1v+sV7Q7ButaoRKIRdze5Vwf9K/eNefbwHgD0gl6oE
         3pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ofr+Hu5Tf6QDtMLwZu0ctJ5oDIF3fKZrk4aVgYXKZ84=;
        b=FebkgzOEUuhkYeAzP6i+iJMXQRI/g2x7sW0jMUobabu65qznIw9+zfhQCR4DXVY6lG
         sYM7Elox2UgVup7/vOdIcC8h7aEheIOGgpYk/9dugXLZUh6hBc48XaO6HUREnTSEnMeF
         zq7y4F5bLtUWXR72fe4QPRxyawqQs8Nn/AhKF/fG8HyIK82ysT8Aip56XfjrI8Rm8XRz
         3v5t0NWX81pCTyoswkdZOuPjfijzvOIp/l2g9rpJePt56Kczk8YQyc2KTkHKxDYcrTRY
         h5x0HRKjrykiC9aX9Gc9JuIvLgdUQpDAUoGWr3d6JUyIS6sTNqJBCJeS4xBEfkMEssfM
         UYOA==
X-Gm-Message-State: AOAM530TTpy2Jaygkg3a5eyRNH+3D5KnAoTXLi0dZ9CdDeKDA+1S8Msw
        cgxsMdiDqwim6CzL7mDDRhz+rvx/
X-Google-Smtp-Source: ABdhPJzqQtX2+4sqyZD0coNrvrYBT7B83EQ3qOZoUob538De/y5jdoYarwdyyBFnK8uVB7ET/L+Yhw==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr25357200wrq.85.1597098563904;
        Mon, 10 Aug 2020 15:29:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15sm1537030wmj.39.2020.08.10.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 15:29:23 -0700 (PDT)
Message-Id: <d35d4b192245e30b96a08f6ce970ee1f4cff5ddf.1597098559.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
References: <pull.827.v2.git.git.1596906081.gitgitgadget@gmail.com>
        <pull.827.v3.git.git.1597098559.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Aug 2020 22:29:11 +0000
Subject: [PATCH v3 03/11] t6422: fix bad check against missing file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6422-merge-rename-corner-cases.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6422-merge-rename-corner-cases.sh b/t/t6422-merge-rename-corner-cases.sh
index f163893ff9..7da75c1736 100755
--- a/t/t6422-merge-rename-corner-cases.sh
+++ b/t/t6422-merge-rename-corner-cases.sh
@@ -906,7 +906,7 @@ test_expect_failure 'rad-check: rename/add/delete conflict' '
 		git rev-parse >expect \
 			B:bar  A:bar  &&
 
-		test_cmp file_is_missing foo &&
+		test_path_is_missing foo &&
 		# bar should have two-way merged contents of the different
 		# versions of bar; check that content from both sides is
 		# present.
@@ -974,8 +974,8 @@ test_expect_failure 'rrdd-check: rename/rename(2to1)/delete/delete conflict' '
 		git rev-parse >expect \
 			O:foo  O:bar  &&
 
-		test_cmp file_is_missing foo &&
-		test_cmp file_is_missing bar &&
+		test_path_is_missing foo &&
+		test_path_is_missing bar &&
 		# baz should have two-way merged contents of the original
 		# contents of foo and bar; check that content from both sides
 		# is present.
-- 
gitgitgadget

