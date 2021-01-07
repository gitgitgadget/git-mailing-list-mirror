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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE632C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE692313B
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 10:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbhAGKn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 05:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbhAGKn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 05:43:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2990C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 02:43:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z12so1215744pjn.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 02:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uc3Llvu52b8dmLGd+187rDrw+S5tlFRNYqVDyXfp1Zc=;
        b=FAmFJ797Fl3mLGrUO5tjdMXvkPkdxmB2V3lRAxWIpBO9YmvNu+odxVekjwK2vV9Kvj
         xGYfjozuCd9bFUCol3WVLBmAUUtmgof+K9eRdDjrjVtw9d5dgmREQ1UFs/T5PastdNKV
         kU0NhY5FgLSwps1PUSaTsXn6uoEZaoag5gEN/IEbV3deMc/g6Sr6qjZYm6AER27vW/U/
         3w8RCYlXwGngLwVTvRhQRFnhLalxVssvBceWd1aIkOFVnUf9CuEKDaoJhSkEr7JpVaEW
         jHXHZnhpwzAyNvNkqNLOhhHNQhiF3wL5Tve5Io1WcpHPyKu9QnL0AaL2u1X5vYV6SHo8
         AJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uc3Llvu52b8dmLGd+187rDrw+S5tlFRNYqVDyXfp1Zc=;
        b=ml02y5ozxwoZ330PPaMdy8bDu25U8OwgTa3HMZx26FZBzqLbR6Vc5p5SdVvqIFTl1l
         PORsfuRssXplHU2DP+I19yEx7b7BRT64Sh7CzJ0RJfAyDaYRUfGtaSVKJbP7217jLc+1
         +tgwVlsZl1oPmOQjOjUdLy4Bnw95om3kHqWDBzjGcBNmaEANQDhwfFeoq0MjvYJrVM7e
         96oFqMfrHjU9wojMVN0x3oMmU6wvlnJpohZR2qR/Lyveeqh3sXVg9hACsu/iKb6qQS9C
         4fVhLtgaw0lvauLp3FmNocPnid1Ljv/l0fvRv+lduAdZ/qGJi2O3ZdgNpxOkwegVeQVG
         Fjgg==
X-Gm-Message-State: AOAM530yVLSKtEKrvKEKHj86/9sM1sNr3Kxd8BdaYfi5Y30ybxE3eTt4
        hR2aqeGUwWUGHYYPHHSWKWmOgxjAL8A=
X-Google-Smtp-Source: ABdhPJwgJX8rQIDy64p8siB6fwRajwabeXAJ1/rhyflm4y0HebvXFMVmsOmiIOq3yQbBtZe6x4oV5w==
X-Received: by 2002:a17:90a:a24:: with SMTP id o33mr8627494pjo.191.1610016197151;
        Thu, 07 Jan 2021 02:43:17 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id d4sm1795361pjz.28.2021.01.07.02.43.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:43:16 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v3 3/2] fixup! refs: allow @{n} to work with n-sized reflog
Date:   Thu,  7 Jan 2021 02:43:15 -0800
Message-Id: <8ce0071bbf8373ed00cccc797f83c4d30d72ae6e.1610016122.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609923643.git.liu.denton@gmail.com>
References: <cover.1609923643.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1508-at-combinations.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 528a77287c..e4521b7b97 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -111,4 +111,5 @@ test_expect_success '@{0} works with empty reflog' '
 	git reflog expire --expire=now refs/heads/newbranch &&
 	test_cmp_rev newbranch newbranch@{0}
 '
+
 test_done
-- 
2.30.0

