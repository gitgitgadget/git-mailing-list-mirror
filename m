Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928B9C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3E56023F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhG0VWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbhG0VVf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C3C061367
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:14 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a14so680066ila.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2021 14:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QA6urUWCpbAiRBEZ742+N7KEWTKsPkPBK/kej7S+Hsc=;
        b=tWsr+cvPXTvRtqTolsU2W4r76dTM5XIyoE06xGH5YhHqxgEO7FHCQX8ODAvdH3auwp
         HSL64c3XCax7/Mxvr6Gz4qvD5/hSmDcAgA1k4pD2hVy7eERZM+m0y/07A2d2BLnT6E8d
         h6MLrWqLyTqTQRdr4h2pgAoMkxWsQS7B1NrvDjr7gLnmiGc03ds+trt+6RCCdOBw7lrk
         c2wvf6pPeuP8L3CXjCIfdWigGR+LMHCeeJ1eA8zLJf8/uU5WkbPoGGmauJektVx+68e6
         sHAXm5Nh96EMPPbCvsh/gJoByCXxFZF4Ug27aJBSFK0aw9KUdQdMKL3PNp61Y1lroPT3
         +SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QA6urUWCpbAiRBEZ742+N7KEWTKsPkPBK/kej7S+Hsc=;
        b=kH4y1BunVQZnGMgI5WFVzCrqPzLOCyZhEE85RSZ+M7dKyFEbUGM8EzAD+UN7nP2nB9
         nuTpMcjBihk0KGr41MBEM7WEfeynUbasQhTggiusEZVuNmtG6GR5WZZFikKnI3cVcptg
         lv5pWMgdpRL/5Yr4hKPWpItZngekj3AeWB/52eHjrO3hblBCYvcwb83wpTLteVKyRXE3
         tPeYJxXpn6O9houiJfDdn8k3h5VfLR6lK+zW9cVPxozcFnTvhnIAUIPmXzyAOoj/2aco
         SWuDa1eucFW6+7xcujb0Y2/aYb6zZ/MiP0p9wgZ761UTurzA/IQE0NnGeo5bICG+CvAl
         B1vw==
X-Gm-Message-State: AOAM531UMwaAedgvMK1IxsvpwjZa66eR8z+Ij2q7IJYBDRTWfF98S2gh
        /yAId0Ys+SSAjc1W+zvs+mjaoHA3qacLv9Gg
X-Google-Smtp-Source: ABdhPJy6JY/ILF5xX3/odBRn6rLnwGMGeusT49kNetEGjDy32VdGJ+19UKhODo01eqQtYdLaBy3FVg==
X-Received: by 2002:a05:6e02:e44:: with SMTP id l4mr3603456ilk.58.1627420813847;
        Tue, 27 Jul 2021 14:20:13 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:6813:d625:75e6:4f64])
        by smtp.gmail.com with ESMTPSA id r8sm3155314iov.39.2021.07.27.14.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:20:13 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:20:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v3 19/25] t0410: disable
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <47c7e6bb9bb7dd959e68214823cc1636c8576503.1627420428.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Generating a MIDX bitmap causes tests which repack in a partial clone to
fail because they are missing objects. Missing objects is an expected
component of tests in t0410, so disable this knob altogether. Graceful
degradation when writing a bitmap with missing objects is tested in
t5326.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t0410-partial-clone.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index bbcc51ee8e..bba679685f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -4,6 +4,9 @@ test_description='partial clone'
 
 . ./test-lib.sh
 
+# missing promisor objects cause repacks which write bitmaps to fail
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
 delete_object () {
 	rm $1/.git/objects/$(echo $2 | sed -e 's|^..|&/|')
 }
-- 
2.31.1.163.ga65ce7f831

