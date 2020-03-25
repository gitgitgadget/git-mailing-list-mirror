Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF86C54FD4
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A6320714
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoOVqDGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYFzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:21 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37075 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCYFzT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:19 -0400
Received: by mail-qv1-f67.google.com with SMTP id n1so494939qvz.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vtqO/4mtDevFWui0LMS2jVUrFypGbKFzLmNnZzqby5I=;
        b=aoOVqDGm5CmsTtvUAWAS7XFVzmxcT8kOo6m5DOGLDsG2575ivT6NBeFHxdA2jHyZy/
         YjQaqXopb0ycNBRJCJeG0ekWb4a3aI1+xLHW+t77Bk6ByeUlQH87SVenXGtcCCHWHno5
         o3h8iahxUFzsbxSn9P62OJHITh7i4EWwIo9yPnGbLv/lP+F2DcJ6vT/JYRTrkV1t1TFP
         D7rSYuhjibfHUlUVBG0zIVnUkJofmUBB0eg76FVMZRovzG0LM80XW9xM1kP0av8q0n/k
         MxYEbw+IS6uq82paNoXd8+uHPMIqaU8lNwSS9CpE/nUdjE0bmepvM79w+d45XGZ/aHtE
         ySEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vtqO/4mtDevFWui0LMS2jVUrFypGbKFzLmNnZzqby5I=;
        b=B1CFzcImvVt/Gkt8IDVHfilXpeyc9q2OCGXZkX1gTlniE3CIAATm0QltsFxzEhqrZU
         WF7XuwW0kZvDyoVnMG+e3mO7cyJGEdhzwQOspWv3kTOQ5rAt1wrfugaxV6OGCp6yxjmx
         J5gvD9gHGyq3uRGL5prGoPuyxFVZQeYB3F/WKVLTgKW1/ChnP49nxl/NUATN5RoQRWS8
         7GoYB77Y64CBeMxKjib5YyV7o6VhWacnq8FdcSaFzKUkl7uFi3CkriSgilFkO1jMFUeK
         hQS2n/4jct7ZzDuqEP2zhsMEhCwmyP5rsh9bJMTJDaqCQ4EG5ebU7lFseJCFmQpqsAdP
         LhqA==
X-Gm-Message-State: ANhLgQ1xGjwCKfj/24AT3Y/xeCeBeQSNHkK1bXT4JqBEd/kSLfX+CVFB
        3573yHNtbdzEyDzFnpirrsOQhyR9
X-Google-Smtp-Source: ADFU+vtQd40pVFycinpS1HAINncjuoBJ3ewpwBg1VwSlplb1LTzLkv/P8Sb830YruZCLzhElzPnxBw==
X-Received: by 2002:a05:6214:11f4:: with SMTP id e20mr1710070qvu.66.1585115718597;
        Tue, 24 Mar 2020 22:55:18 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:18 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 6/8] t5612: don't use `test_must_fail test_cmp`
Date:   Wed, 25 Mar 2020 01:54:53 -0400
Message-Id: <2bac5f4a290620ef37e3dcf1e05773acd14cb725.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since test_cmp() just
wraps an external command, replace `test_must_fail test_cmp` with
`! test_cmp`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5612-clone-refspec.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index e36ac01661..28373e715a 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -87,7 +87,7 @@ test_expect_success 'by default no tags will be kept updated' '
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
-	test_must_fail test_cmp expect actual &&
+	! test_cmp expect actual &&
 	test_line_count = 2 actual
 '
 
-- 
2.25.0.114.g5b0ca878e0

