Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF7EC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637D520855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFHe6n5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHNOya (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgHNOya (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:54:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5486FC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:54:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 128so4654815pgd.5
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7VFdedRpl/z7VnSOSKVhxz8DvKkrlo1AXhEPagx2zs=;
        b=LFHe6n5MV6x8kEKM5kgebPaSAUC325+dkpB/J1ZY+8mgJpIroLSMZkC1Nq1tqZ6K3f
         698tw+PsA3FR8A7fKO6S5nF5QP58AF0eK5fY2MXiii0o7gtcyqko77wSyfBvGRazzcus
         1GprFk+KEC8ai2XVJWYRoIdYvn/NO9S6JGzczWsNtJkw5JrSXLGB8jdPl3GoQknUYPu1
         oIuoQqZRnMtsNvOv99f7OIqFEGGrrlNhwKSP4XF1ZW1xA+t9oMb4HDNn3JfBThE2zwMR
         4yWm8Ij3vZayjE1EEvzwmyYbCeo/z8mqQZh9PGuPzpy7uTvEID7L0TeymfQUhyTxMP00
         O2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m7VFdedRpl/z7VnSOSKVhxz8DvKkrlo1AXhEPagx2zs=;
        b=casKqF665+sb7ptLNtvycvN07XKYUWqtJ+q0OnAvgQ6ZQXZBRP5pXR74djxZDbsrZW
         DrvogsUTxqSeSP4SA6xPK+LJSGH/YoI7Wqr9CPG17QYElKWENoVdXEfaTjMd1X30GVxv
         9typdkkq9bl6TDLn4PT/28VsT0q/RmV9DJ432odTs/uCFnVWcymTxVkHkjcblEFL2smJ
         9FVQCGpVxBdN8vr6s7If7MN0sWxUftJhI3Otv6sFgo+MXjeWHNGGpFEz5NLP0mtavbng
         jr1Rr7cv7AGZFQdj8jLGU8oNNTrXpNAIk9VMvxobPDlYZsCMsy/5cOIOVx2GWuTwtgWA
         ydTA==
X-Gm-Message-State: AOAM530TS43xqQvj3Mi0ZrBhZUksJdYP/GYKytk6VtgxAwMQRURcn74F
        tNMlIr2AMvJPsiuOVIw4o9I=
X-Google-Smtp-Source: ABdhPJyYR4dlTsQSFMTpYt5F33CDanPr1DeU7D9Bx2Hj8s0oDF8wYXlfzIBWQiWCnszTo0cyRtwzuQ==
X-Received: by 2002:a65:558d:: with SMTP id j13mr2085757pgs.48.1597416869698;
        Fri, 14 Aug 2020 07:54:29 -0700 (PDT)
Received: from localhost.localdomain (36-225-225-45.dynamic-ip.hinet.net. [36.225.225.45])
        by smtp.gmail.com with ESMTPSA id n18sm8307569pgd.91.2020.08.14.07.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 07:54:29 -0700 (PDT)
From:   Danny Lin <danny0838@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git develop <git@vger.kernel.org>, Danny Lin <danny0838@gmail.com>
Subject: [PATCH] Remove "unsure" for --message in subtree doc.
Date:   Fri, 14 Aug 2020 22:53:45 +0800
Message-Id: <20200814145344.2413-1-danny0838@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is definitely clear that --message is valid for add, merge and pull.

Signed-off-by: Danny Lin <danny0838@gmail.com>
---
 contrib/subtree/git-subtree.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index 352deda69d..47e2c611fe 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -139,7 +139,7 @@ OPTIONS
 
 -m <message>::
 --message=<message>::
-	This option is only valid for add, merge and pull (unsure).
+	This option is only valid for add, merge and pull.
 	Specify <message> as the commit message for the merge commit.
 
 
-- 
2.28.0.windows.1

