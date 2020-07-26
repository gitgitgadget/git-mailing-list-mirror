Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47063C433E3
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207162065F
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDEWeUqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGZO0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGZO0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 10:26:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAA0C0619D2
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so7975903pgf.7
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CzQP0fpTEenofZBakSUNThJaAXN5CPnFNEIP1yxLOdU=;
        b=hDEWeUqenThsKdGayjAIPv1tbxkGPIj0XxSNVBSV1U1t5dumPXE/i41p6AFexEPuz1
         lAKmtuvi3Mzkf0Gov9nCTlz2cWX0ExQFzUY/SNTlTVQzQ9neAHfWQq9/G54AKlOwRaDQ
         UhzRpdeb5Cg5uAJ+EolB+PHkAwuJs4O357drWhO/2UVxTTkmzFwvTPc0gp7ZVDoWBSQd
         NSZq8ijHskgZ78hyFmGuW/Zkdf7tQ6gknsv+QTOOSwTq/kZtIYwa3qMEWQHIyAcdZH5J
         Oy+YdbXpW/ON0GaE1q7cRWk7aloiIGQE4Pz76GKWKigmmh5RLSzzjwzlTj9s2Wr6/JUE
         MBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CzQP0fpTEenofZBakSUNThJaAXN5CPnFNEIP1yxLOdU=;
        b=tXVSEMl40hs+/CADRlR/MuOA1XuNyAuSDBAZgdSkUcsyGCTdFoUOKWqIszb8rIOFBS
         yhwRElf+gjY0T7fZA8bEnrOZaiXXGx5/nvdsFMpkaEuQokCSgjVLzl8UUozmhV+G/Ts5
         IL9nFVs8W/tjzMlTYVez5RGsTDs/S0s3rX9HKb/aWNPqTt7YFXRlR7RfVeWIiZt4C27u
         20gommQVMhLPEmqCyhfTYfB22JTPEhGyqS8Ewai63APvqvRB2oZPAesNBytC5InENJNL
         9yheQqACra4Jjcub1IS5m/TxfXlpElswE+Fd14kXHvi/LGlItLrjwT5hgxE/T/7zU3Lz
         bKbQ==
X-Gm-Message-State: AOAM530Ar+mWOX48agGfVOQGICEk2HDKOCaRVcdr3uA4W6kGQ+V/1C50
        r3XxEDk5Yp/FYcRP6kj0tMyk72kpbEY=
X-Google-Smtp-Source: ABdhPJxW+dCVCLg3dSX2oVZlLiyR0p8YfpLr1iTMg9S/BwK1/G6Q45E6Gwz7p/aM7hn7lZnX1uxZSQ==
X-Received: by 2002:a62:7bc9:: with SMTP id w192mr16861862pfc.255.1595773584008;
        Sun, 26 Jul 2020 07:26:24 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.48])
        by smtp.gmail.com with ESMTPSA id p11sm11278908pjb.3.2020.07.26.07.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:26:23 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [PATCH 4/4] t7401: add a WARNING and a NEEDSWORK
Date:   Sun, 26 Jul 2020 19:55:53 +0530
Message-Id: <20200726142553.42545-5-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
References: <20200726142553.42545-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a WARNING regarding the usage of 'git add' instead of 'git
submodule add' to add submodules to the superproject. Also add a
NEEDSWORK regarding the outdated syntax and working of the test, which
may need to be improved to obtain better and desired results.

While at it, change the word 'test' to 'test script' in the test
description to avoid ambiguity.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 145914cd5a..2db4cf5cbf 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -5,8 +5,13 @@
 
 test_description='Summary support for submodules
 
-This test tries to verify the sanity of summary subcommand of git submodule.
+This test script tries to verify the sanity of summary subcommand of git submodule.
 '
+# WARNING: This test script uses 'git add' instead of 'git submodule add' to add
+# submodules to the superproject. Some submodule subcommands such as init and
+# deinit might not work as expected in this script.
+
+# NEEDSWORK: This test script is old fashioned and may need a big cleanup.
 
 . ./test-lib.sh
 
-- 
2.27.0

