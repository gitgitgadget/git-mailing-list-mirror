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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26853C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC98B61285
	for <git@archiver.kernel.org>; Thu, 13 May 2021 07:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEMHR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhEMHRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 03:17:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED87C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:16:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 69so9277252plc.5
        for <git@vger.kernel.org>; Thu, 13 May 2021 00:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YQbsaryA7xNdpDmQq6uT2PrWEMKmxMvXbnEkebxOdtU=;
        b=GjK6BySnm9uGgSQj2y7ePqJQhpJpJus4UacuLucb3FLl5Zx2JcWwm8VfBm4HVj2bvX
         1VG3Ymx4EqDl4MSv408ussArR9QOdTsNlRUivoQY/tsInbyGek7ZOGoRoxm9K/g11btV
         LWjUuZq9uIq6TsnsAi5g1oHdfLiQgzwsZb4dZg2wPUUzx9WXCT6eTgU5pKs5A4Gu6soG
         kVqWCS1ze9O1mDMzJ6xFLsUxXIEEAkQ3HBhuqBhdQa4t9p3Yy40BxZwbar1sGuMDFLry
         ded6eL6th65NF21wQi8VBxibn24KKF6DCen9hAOZ4A5F6fCIgHPGF9swTbcN/oIYmYe4
         Q2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YQbsaryA7xNdpDmQq6uT2PrWEMKmxMvXbnEkebxOdtU=;
        b=kWjjIF/5VDv+gOi22DWHpdgrqRoLp7haQslzjc5DNcIKH1Wagc084DRGNTVtWaylyp
         PV8mPHpFL+BOQ6HUdofjwQPO9C7s+zQthuYvm30khRzH2n5KI2yA23qgsIaq+FrwGKdH
         ZUqhc5doDDiROP/uCgMUCVZNbv+AnEweyQYsE8xZF7HD63OPaYamV0HpRPPbGfcBLg/9
         UV6LSfXFgH9rEDSzOWmyXRbApz6IHnvAcd6U45mZ9ka5McFy3gTHvjG2/ZCuHS1O9pvT
         ETqCvQH1EyIvXqY207JTHcnvzyLirJqZ83fF09ku/DyhWPreT3fZKyzGRvufpdyjpS+m
         kKwA==
X-Gm-Message-State: AOAM533xEIt20lPLOVa2gsWVjM5nceDCqhqSStJ9m8kxBCK7UitrXcSG
        6pSDtq+GP7HIXnEA0AmOq2Y1j1dEdUBbx3BKea6k9w==
X-Google-Smtp-Source: ABdhPJyqxX7hwUGM+5tfSnXuBw+Q65Nd3e0Y6JwXAWLpbVQeKD0Rv1THuZrt/laZ2ToqDX7DWRxm7w==
X-Received: by 2002:a17:902:7402:b029:ef:7d5c:62c1 with SMTP id g2-20020a1709027402b02900ef7d5c62c1mr8016219pll.4.1620890175665;
        Thu, 13 May 2021 00:16:15 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.94])
        by smtp.gmail.com with ESMTPSA id f6sm1346007pfe.74.2021.05.13.00.16.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 00:16:15 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: packfile-uri.txt: fix blobPackfileUri description
Date:   Thu, 13 May 2021 15:15:47 +0800
Message-Id: <20210513071547.64367-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g2f6b6330e7.dirty
In-Reply-To: <20210506073354.27833-1-dyroneteng@gmail.com>
References: <20210506073354.27833-1-dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix the 'uploadpack.blobPackfileUri' description in packfile-uri.txt
and the correct format also can be seen in t5702.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/packfile-uri.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/packfile-uri.txt b/Documentation/technical/packfile-uri.txt
index f7eabc6c76..1eb525fe76 100644
--- a/Documentation/technical/packfile-uri.txt
+++ b/Documentation/technical/packfile-uri.txt
@@ -35,13 +35,14 @@ include some sort of non-trivial implementation in the Minimum Viable Product,
 at least so that we can test the client.
 
 This is the implementation: a feature, marked experimental, that allows the
-server to be configured by one or more `uploadpack.blobPackfileUri=<sha1>
-<uri>` entries. Whenever the list of objects to be sent is assembled, all such
-blobs are excluded, replaced with URIs. As noted in "Future work" below, the
-server can evolve in the future to support excluding other objects (or other
-implementations of servers could be made that support excluding other objects)
-without needing a protocol change, so clients should not expect that packfiles
-downloaded in this way only contain single blobs.
+server to be configured by one or more `uploadpack.blobPackfileUri=
+<object-hash> <pack-hash> <uri>` entries. Whenever the list of objects to be
+sent is assembled, all such blobs are excluded, replaced with URIs. As noted
+in "Future work" below, the server can evolve in the future to support
+excluding other objects (or other implementations of servers could be made
+that support excluding other objects) without needing a protocol change, so
+clients should not expect that packfiles downloaded in this way only contain
+single blobs.
 
 Client design
 -------------
-- 
2.31.1.443.g2f6b6330e7.dirty

