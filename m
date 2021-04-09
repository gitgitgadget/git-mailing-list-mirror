Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E46C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F256961007
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhDISLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbhDISLT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:19 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3AEC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id es6so3137834qvb.0
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ePeiUgb5oEGMA/x3BFIaUoin53uoN8y235q0g4j7KVY=;
        b=KlcmcUJN3DrlboHseaPh1+xi2+wXKLH5Bj3k5tZahlfX7Nf6OY0VJ7O5uRDg9Gk9+2
         u8OpQNNP6eDITNMAMblUSmUGyghWtbiDK4H6jhcEpL3+ZyJKLdkQ+o3d195tF/iD3MbV
         0XT3w/lrJ06jwmfydHWRccY2PZhweWjIt9Lqql7aPRCA7SK3QyNeevf8svxXCMml4nb1
         8QYwOasX5Mtvwva7EAGAIHL743eC+47xDder+toaYAZ6pIGPuFbWLwtjR5fA1eNxiu/S
         ouaeqQSRhkKabtkzc32er3lYLwWtj7EctOE4vat1Lk1PrguoQ6gq8NI2kJx3vPWjoOjC
         20qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ePeiUgb5oEGMA/x3BFIaUoin53uoN8y235q0g4j7KVY=;
        b=hTLxcCE9JYgVtbpj2qWShsFn2rR0SBTm38W6GSKTYlHl96cqTXimOClfu6lw+Kn3In
         T2xHnIJLWBLN/p21dQoso2xFpqw+aJ9wBi7F8OZp7+5hNg8R1Bc2HDrbUf7JVGBNY5WE
         SCO/Ea6OVNc2sEI48HjJ+/J8tNyu80FgL31MFvlVqqKZJpxXDHitaNjPZpAAtM1RO4Pq
         vsuVcgNP4kEUPyQalQcJDu9lX6fQqT0bg+RRzCrhG8Q9P6mSa9YCQmrPRDIaXtk1gewT
         hy9PNXgHwU2NRC2NTJfDYnv5Hpc/Dk+w5d8x5hkAIB8nCYKu/GfLWb7L1fPAsAuk03n6
         kfEQ==
X-Gm-Message-State: AOAM533mfR6Yz8nvbtOaCkaD7I3IOnj9pqzsU2G9mr9zIPiuk6z+BVKT
        ugBdNL84Vq3/a7WiHuakR0GFnaBpk7iof1C4
X-Google-Smtp-Source: ABdhPJwU7MrwMlcioBRXz98yLzlmy4ZFTjKYQaReTqgZ43nnjpwtDsz0ycTF+t6Lkn254kCEDNzFKg==
X-Received: by 2002:a0c:8148:: with SMTP id 66mr15523552qvc.55.1617991861971;
        Fri, 09 Apr 2021 11:11:01 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id i12sm2215988qkl.49.2021.04.09.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:01 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:10:59 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 04/22] Documentation: build 'technical/bitmap-format' by
 default
Message-ID: <46de889cd2d5314cede0cb2bf6d570638015235b.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the 'TECH_DOCS' variable was introduced all the way back in
5e00439f0a (Documentation: build html for all files in technical and
howto, 2012-10-23), the 'bitmap-format' document was never added to that
list when it was created.

Prepare for changes to this file by including it in the list of
technical documentation that 'make doc' will build by default.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 874a01d7a8..6d60c8c165 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -83,6 +83,7 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
+TECH_DOCS += technical/bitmap-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
-- 
2.31.1.163.ga65ce7f831

