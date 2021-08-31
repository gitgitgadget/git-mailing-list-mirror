Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C6C4320A
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D421C61026
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 20:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241350AbhHaUxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 16:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbhHaUxd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 16:53:33 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94CAC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:37 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id z1so779067ioh.7
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n6qnx6eeG0uYPYB1EanAtySI9p8uXGfLDW6fS1AT9ks=;
        b=ELX4iEhxKOni/PW/FbUd3/XmKj9+e5X9m+XHCI38Nff6D3Ua9HqLckJnUkxXXl5Gb+
         S26kNxPG1TlZX2AElKox6CCjbZ0TL+C+ZWb2du5u1KSqmHGa6xn4ENfAmzx+kqZffxnO
         tYWrMYOVMfHnxL2JKIPvbkwqPrx1iv+TVVrGsY12iqITJLMv084KlWIyNzV11ud4Drim
         ko2bAAkOD3U8a581KzMxq5LohlUJJ2jftWoDMJpJSQWq4qv18CD0Uy2n1cBPSSNDkT5f
         b/9qNclVwp7WqkJHUyyqIVrdUw8mr4ijNlaf7BWOaV0vx0zdPYIFjJXhDsjNnlwKzvtJ
         vDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6qnx6eeG0uYPYB1EanAtySI9p8uXGfLDW6fS1AT9ks=;
        b=PtzpGbb2OAjKwyAXxrEvXP8Gi0SDDSHSka4jGwKjOZ/19kKi2TpauN1ExusOp+BNT/
         tU4mkf2rQ/SkpABtRd8BWSQ9gFZP1OE+JMRmPf4w3Y08TJsieq2gtkN1f5WU2DMvgULu
         Q19kkRTuFsqEMGMSM34ER+4K3OFuzvLtznWRf6B9ypgRSIEUVTPhNIhCph8n3YTtZqfa
         UulY5hlqwrWn7tUPYqKm5n9YmW+XaIfptSC/ly84DCsMG60WiByZHO4voFA0UapgBdF9
         xUtvGa1hOtvpzVD6PyeNuimKVf1t1AFEApS2bUQPvLxYUNgocp4/+cZHMRzBw9feVLmz
         S3jQ==
X-Gm-Message-State: AOAM533a3WkzmfB3on2Sz9XUpMQA46I5dbG9VroaU+BY0pDxPF1d7/GL
        hJaBhLUD5KBtwS4BNEewIJRDUKFSwbenuPQ6
X-Google-Smtp-Source: ABdhPJy9CjYXeb5IN3EvtDyhWaL8NKKG9Hp2r2N4lIRG44j5+0nx9cItbINjzWY6qL7Wxpq4pZJn1A==
X-Received: by 2002:a02:cc59:: with SMTP id i25mr4613933jaq.125.1630443157143;
        Tue, 31 Aug 2021 13:52:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y12sm10805306ilm.81.2021.08.31.13.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:52:36 -0700 (PDT)
Date:   Tue, 31 Aug 2021 16:52:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v5 22/27] t5310: disable
 GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP
Message-ID: <a4f4d90bba48bbf9cc6f150cdb61310b7678c3c8.1630443072.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1630443072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1630443072.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Generating a MIDX bitmap confuses many of the tests in t5310, which
expect to control whether and how bitmaps are written. Since the
relevant MIDX-bitmap tests here are covered already in t5326, let's just
disable the flag for the whole t5310 script.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5310-pack-bitmaps.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 4318f84d53..673baa5c3c 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -8,6 +8,10 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . "$TEST_DIRECTORY"/lib-bundle.sh
 . "$TEST_DIRECTORY"/lib-bitmap.sh
 
+# t5310 deals only with single-pack bitmaps, so don't write MIDX bitmaps in
+# their place.
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+
 objpath () {
 	echo ".git/objects/$(echo "$1" | sed -e 's|\(..\)|\1/|')"
 }
-- 
2.33.0.96.g73915697e6

