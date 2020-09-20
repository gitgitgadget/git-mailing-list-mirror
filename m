Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24983C43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F36216C4
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 11:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX3sKBs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgITLWj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITLWi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 07:22:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A603EC061755
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so5698996pjh.5
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyBVAH6DELM7zI4yYqDifCKWGj58OkgJ6OU86uSCDcs=;
        b=hX3sKBs51CVOUPyAEOxQ6pTegvdh5+N6suCDJtInovlqbsWI5LZ/iODvZsVG5KLvbi
         wf47KOEr0X5qKSi0LpGkGJF9yYDNUDCOY/Z7e/JshqAyYwTSrGqFgzZlq16mDorN8L52
         MvtgotfZhA+Tens14D4TxH6rEcOhhPER9dEnnNFU2FQrFxgzwFG5sN+mkDNCacpPUBAO
         9M9ZiFpg7WXnsVfVpoG7ji2eBy/aFDzStPcglB/XgK8PvyQF3hCwLrwfilGnFrzlLh+v
         YQNAqprZzJXciH+rrXG39XCLqosNZvAWK4cS1faurzN1QQubtrGeKGja2bR3bYtriKt2
         aPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyBVAH6DELM7zI4yYqDifCKWGj58OkgJ6OU86uSCDcs=;
        b=uj09KaCLxTbwn+yrv/vdNGBdNWiafoskLJgtxFUaMROENnS4x1Errrj7KgSCdEw5d/
         v8/xHMFd0Pi5PTIZoSkk+qF3/wtpWpBNRS8/zjP2PghzwvKC84kNlKpzw9RPPDrx5VmQ
         eT7gTg6y3Dfz677xEbyOJj3LLNW1p7uR5Qb+a2pnfkrUk/Z+UguZBIwGsZ9B5IJh+LkY
         ogHcFFQsQFpuKbUOVxbKSGQEOb+QM9gAvra0h10bizqdvuZ9B+Yat/22tdjyvfD4ShvJ
         ySljimlvIk1v1HM7MlB4/zrsjJ/7BpqhnJJSZQ8ZQmk8HaX7vGFOO52OFlg27jH6Y4YT
         XHFQ==
X-Gm-Message-State: AOAM533jX/lvxuMgGSjY+CIe66edsK3dHjm+SrLcMNci4w8qj4dLNTOz
        +OdEgj/8XJ/ktlDZAXMrwec9COTrWG8=
X-Google-Smtp-Source: ABdhPJyPMxVz2yt1id1HoTDYMRd4nzifo3S/3bMBlCTjYhSq0oDStvc3hj0+N2tbVplwd5AWw1mudg==
X-Received: by 2002:a17:90a:d914:: with SMTP id c20mr21188337pjv.34.1600600958054;
        Sun, 20 Sep 2020 04:22:38 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id y79sm9550737pfb.45.2020.09.20.04.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 04:22:37 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 02/10] git-diff-index.txt: make --cached description a proper sentence
Date:   Sun, 20 Sep 2020 04:22:19 -0700
Message-Id: <21b20281e6a1fa265d4853fa04cc71ba7e843267.1600600823.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600600823.git.liu.denton@gmail.com>
References: <cover.1600328335.git.liu.denton@gmail.com> <cover.1600600823.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-diff-index.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index f4bd8155c0..25fe165f00 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -27,7 +27,7 @@ include::diff-options.txt[]
 	The id of a tree object to diff against.
 
 --cached::
-	do not consider the on-disk file at all
+	Do not consider the on-disk file at all.
 
 -m::
 	By default, files recorded in the index but not checked
-- 
2.28.0.760.g8d73e04208

