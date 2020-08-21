Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7949C433DF
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7E620748
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkWYLWAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgHURDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbgHURAl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:00:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43850C06179B
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so1362860pfn.5
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=epu8VIcxRGdHWW6sjJKuiHPpzM9PxL8de3hGutwVKuU=;
        b=bkWYLWAY1XVTnRI128yQmDmVibphiCVF5HtUjACyDiiFrKzlqa9mHMLMVuIApTrlWw
         fV+vfWbZ+9+iBWJVFnzA7oL7AmziHek19bVId1b3u3SWFzPpF/SiOPcfcSl5o3l8tppS
         DyJygWBd3D4ivnvN4q2Mua6QG4bMeMaq+GKKSi92sSJN4QkeepJhDtqXdYkyiBlY032Z
         cAR9Ivcy6j7grOWS8XW9B9l6afL9qLubcpxBduJ7Hzhw/F/I3UlXKLO8oCKFPqlcPACg
         lc+rkl6+0Uh5Q+yY3VaSNS/Vd/mSovHEHv9XjT9Ro8BIpMbcdCZyntK1IzqT28RN/xHL
         4oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epu8VIcxRGdHWW6sjJKuiHPpzM9PxL8de3hGutwVKuU=;
        b=fT4Z4AIG/QitIG+mpNO8H4jNalCHFFFTOtkR37BEjEDZqbZBJBWLCReMIxg+ZbHl3Q
         9CJarv9T6qgxzorehZXBDzs+gl8oSQOU7ixBQE38oN66a6mLHWhJtn6d8Kie76fHYBYS
         EEczsIsUE482L2tYCHtEyMOQdDMl3IUJeB0hicFg7ek7c1n5cE47khsBy2N1AgxBN90/
         DwfkBwW0dCFNgwNCHN+3crJkZjugn6/5odEfVwEdzm23u5PILyCv3FuyOUVAiu0qfa9Q
         K2mhkDrRiHB4ws9jgniaGEOuZf9dsg+9qiId4xmlr9AklWsZTHRCoJRPYT9QaEB4RhDB
         Cbfw==
X-Gm-Message-State: AOAM531YeRyhxRN7IGT1uOkp6WLfIb9PXKBscnTUdkereuxGxmEMf8eK
        m2aQZvvFIkVBpjGKNvedcaA84FGgrGzklw==
X-Google-Smtp-Source: ABdhPJzyt7197CqRP41Qz5jcdOeCvL7DxHg/UQ1U+xqGgyWX9WrJ5eonlgZMPrVX7Lb1BwIe+U05jQ==
X-Received: by 2002:a62:31c7:: with SMTP id x190mr3320842pfx.100.1598029222311;
        Fri, 21 Aug 2020 10:00:22 -0700 (PDT)
Received: from localhost.localdomain ([125.99.204.38])
        by smtp.gmail.com with ESMTPSA id q7sm3043505pfu.133.2020.08.21.10.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:00:21 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, me@ttaylorr.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 5/5] t7401: add a NEEDSWORK
Date:   Fri, 21 Aug 2020 22:29:52 +0530
Message-Id: <20200821165952.14376-6-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
References: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a NEEDSWORK regarding the outdated syntax and working of the test,
which may need to be improved to obtain better and desired results.

While at it, change the word 'test' to 'test script' in the test
description to avoid ambiguity.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 1491ab6448..cc87d26619 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -5,8 +5,11 @@
 
 test_description='Summary support for submodules
 
-This test tries to verify the sanity of summary subcommand of git submodule.
+This test script tries to verify the sanity of summary subcommand of git submodule.
 '
+# NEEDSWORK: This test script is old fashioned and may need a big cleanup due to
+# various reasons, one of them being that there are lots of commands taking place
+# outside of 'test_expect_success' block, which is no longer in good-style.
 
 . ./test-lib.sh
 
-- 
2.28.0

