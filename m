Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06EAC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC7E060EC0
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhHCPfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236699AbhHCPfk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8423C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso2107905wms.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=H6IE53j+0vixel9VVxy+RBhi0U7Z6sCcxYfDzfDEu8U=;
        b=SEmldSB0mxWZ+2Uh3I+X1MO/6k8GTJ+v6rXYGtpq4fljOqBoUaeAXd0BMxn4zQo38M
         O4lB8fkcJsZFSlvgMKJ4Hk3yizzn2uSL6BlIk6DL1xZ9CtJI2mBfrv87nPIGRHuHmOxR
         o5zLGxTXtjJT1VrT1cHKCFIqcNSHvo19AZDcNL8pB3Ps9GRBP+7jVZpAkMq82P6PaXmw
         wzK3277CE2j1xI6liVHpyEIvDgCA1uIWfeGBjaP09o1fvCqAPQi3mHQobcp9odyzVhGP
         WSG4qId6xq3oryfq56ciDoJQVSdfohVDzuyL0Bg8XfsikSkweOlJLf8lJuWlOYSnr3I9
         xREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=H6IE53j+0vixel9VVxy+RBhi0U7Z6sCcxYfDzfDEu8U=;
        b=Tbm5IlgFvqIpp16mSEwDQKlUb77G9X0z3xNqUT8lTHsTXwIcSl2p+Md9I0TAZfRz30
         vGOViDP5kLAvu7Cz39+EX6Ymdx40d93XUdZNdrBMwSgB1bTXNZYK8DnCls5fMoCI3Gq/
         SqzUdVa4HM43TZ696jTvcwKSCDQ3Y6h69z6sv7NJV72EEU3qHvONJRC49lxjnRVR1H1e
         ah+rpNTe+8KLN3pGNnT04+YOynb+o/k6n++IR94Zjt7WR05IMUXXxT1Wim3elAKHld+c
         bUhz3uMhTL0vGCIv3fko/wNoLOHCezkynhQg8qcBTn4gTbm/tHBSR9egsW7dT/ERK21B
         vYVA==
X-Gm-Message-State: AOAM532m/Ni6J2K1+D6rMQVVyFXIZhI50pTSOPoui4TxV13RD79cfiSa
        zgHzzVFV8aOkmf4f5EFVIEkODLfypeE=
X-Google-Smtp-Source: ABdhPJxkTmNbfRMvszyXM+YtjtxlS8H0wrrzsyVN5KsmWj7mxcxe34HBVmLTflM/KdTvI1qwxYB/Kw==
X-Received: by 2002:a7b:c316:: with SMTP id k22mr4864559wmj.56.1628004927460;
        Tue, 03 Aug 2021 08:35:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u11sm15286674wrt.89.2021.08.03.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:27 -0700 (PDT)
Message-Id: <5f974afe47ce46521f6c51484d1ebd59cd7339dd.1628004920.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:15 +0000
Subject: [PATCH 05/10] merge-strategies.txt: do not imply using copy detection
 is desired
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Stating that the recursive strategy "currently cannot make use of
detected copies" implies that this is a technical shortcoming of the
current algorithm.  I disagree with that.  I don't see how copies could
possibly be used in a sane fashion in a merge algorithm -- would we
propagate changes in one file on one side of history to each copy of
that file when merging?  That makes no sense to me.  I cannot think of
anything else that would make sense either.  Change the wording to
simply state that we ignore any copies.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 6b6017e1cc8..bc82799365a 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -16,9 +16,9 @@ recursive::
 	causing mismerges by tests done on actual merge commits
 	taken from Linux 2.6 kernel development history.
 	Additionally this can detect and handle merges involving
-	renames, but currently cannot make use of detected
-	copies.  This is the default merge strategy when pulling
-	or merging one branch.
+	renames.  It does not make use of detected copies.  This
+	is the default merge strategy when pulling or merging one
+	branch.
 +
 The 'recursive' strategy can take the following options:
 
-- 
gitgitgadget

