Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9045CC64E75
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4209824655
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 16:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyLEzoC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgKQQMl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 11:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgKQQMl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 11:12:41 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79882C0613CF
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:40 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so16518347wrt.0
        for <git@vger.kernel.org>; Tue, 17 Nov 2020 08:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/oHpHFtiq2DyR3lbemvvL4wbcNDQbIuM8EyPYLU0XPc=;
        b=RyLEzoC5MBYoqa47XFkdcyiK+mnVSQrv6lXDrZcY6t4hyZZ4S3QyBkemvHAWmV3hbo
         bGBdJBdrz7/PHRgRmAg4Dc+jhFTCmwnwMO293QbghoSEJcc3/7iNbtKKWRQ1Pmctn7pd
         1tQ5WPNz4V8fMciz0grRNg7aGi7GSy5ZK8s5QzFgb38OExHSgitKazqljCp0DqAoFdFk
         LaRcfrX2JvbW0Y2shkRiyOdl69UrlEKFiGEENR3C/VKniuHlDHs4zbFk2autUsEvhci3
         h1ns+vYQRVrdy1mRMsky1Amlcwgh9Tl6lYLlgl6O+QUfVkEQhVmlZN3jFwnSzdo1mUGx
         8mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/oHpHFtiq2DyR3lbemvvL4wbcNDQbIuM8EyPYLU0XPc=;
        b=XKjp0+5uhq808aCgr1KekBAxM/SxQxHT9cd9X2rNiX6pAwxDIEho2yBewqMvr/cRyr
         RQUX3rNxOImJBy20XFgdDtXv4bC49sp9QHZomoNhCmJGGIMW6rrRRYtzYa0TMnwCe5fu
         6hOL3jcqgQ1LhV4S6/6rGSS/MrmSiILWcTMnGpyqXb0zXTCKPOxp8c2XHJOtXNTy+9Iv
         W/tgxXIxia/9JArg+FWPY+/Tam+5L+q1zaV+NOHJJ/Gn0CeW7ynyEelinn9TGLSdqCcU
         OE2CoRSdwt9nDnqxynWpyz63Id3wFwS8PJiacJFboeHJy4OoUcgCsBeAWKbTqLJQSjDH
         a2Fw==
X-Gm-Message-State: AOAM533ToK65GbCkKKT6e6wFaGj98EckHOAUEHwSwbwv7p4krUfLwfVV
        xh7Rx3KvpelIbLSWZtrvGR4Vn10LwQg=
X-Google-Smtp-Source: ABdhPJy2DKUUu/PrX2OQ5YWYcn3G0IItVrvIEIe/MUdq+14yvSoEeBU/v4LtvrhEB7ADPCVNEviN1A==
X-Received: by 2002:adf:c452:: with SMTP id a18mr237168wrg.189.1605629559120;
        Tue, 17 Nov 2020 08:12:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x63sm4533972wmb.48.2020.11.17.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 08:12:38 -0800 (PST)
Message-Id: <6ff4594a28f6b7d5b31d6f0eaa4af814c7e85ce4.1605629548.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <pull.762.v2.git.1605629547.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 16:12:09 +0000
Subject: [PATCH v2 09/27] t5323: prepare centered comment for `master` ->
 `main`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are about to search-and-replace all mentions of `master` in t5323 by
`main`, which is two characters shorter. To prepare for that, let's add
padding to centered lines that will make them briefly uncentered, but
will be re-centered in the commit that performs that rename.

Doing it this way (instead of padding after replacing) makes it easier
to verify the validity of the patch that replaces `master` by `main`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5323-pack-redundant.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
index 6b4d1ca353..3903148926 100755
--- a/t/t5323-pack-redundant.sh
+++ b/t/t5323-pack-redundant.sh
@@ -312,7 +312,7 @@ test_expect_success 'shared: all packs are redundant, but no output without --al
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================ master.git ===============
+#     ================= master.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------+
 #     ----+--------------------------------------             |
 #     P1  | x x x x x x x                       x             |
@@ -394,7 +394,7 @@ test_expect_success 'shared: no redundant without --alt-odb' '
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================ master.git ===============
+#     ================= master.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------------+
 #     ----+--------------------------------------                   |
 #     P1  | x x x x x x x                       x                   |
@@ -426,7 +426,7 @@ test_expect_success 'shared: one pack is redundant with --alt-odb' '
 #############################################################################
 # Chart of packs and objects for this test case
 #
-#     ================ master.git ===============
+#     ================= master.git ================
 #         | T A B C D E F G H I J K L M N O P Q R  <----------------+
 #     ----+--------------------------------------                   |
 #     P1  | x x x x x x x                       x                   |
-- 
gitgitgadget

