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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D00C54FCF
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D51A20714
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLodbNSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCYFzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:22 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:38741 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgCYFzS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:18 -0400
Received: by mail-qv1-f67.google.com with SMTP id p60so490531qva.5
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F+2j0Idkg1dVglAcEXf/kAgsHx0XXlGCbB639V24EsI=;
        b=XLodbNSa2/R8V9bI5H5ZBuAWv5DnX8CfK0t8MhXz2DH6gN1ehGGwTWN99BouiCzq5g
         ANbaJc3OET7b4Iy/xN8/S95sA+QGyN8xxl1pXSFu7pkpEO72PnnIJdTDbYOWkAcsuvi8
         1kNhCGXi2KrdqJFF8SaRLyHwg6mASXdVLkkvIImLgqfMLpqdZrjJ9nNVHPhS9OTFSlWV
         MeQEAv/juUiYLGUqcyTnNqEvJvoBEo1+p/+9Q0T/TrBIj2AeIOPQEhEn/TWqd+t8wE3N
         Kx/jboswqcrT6ttus8SJLpx2cpbS2xnAD0GxPG6YEdmaJ9RoDU+6Ojk1//HnrFWWI6cl
         ET5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+2j0Idkg1dVglAcEXf/kAgsHx0XXlGCbB639V24EsI=;
        b=hj4ZWBZIiq9yUtEasO0VNheq8YSVyB1hrprTGWzGQV607KyiI5M0Sl3Hp0xREyaBYF
         /YSGW9gQnbASFQi4jdiIz7AZ00Xo7f8932suVyvM7XP15a8ZS2abIYAW6UW44ME90ebg
         BdUJTppVxDdflAJ6C5ntdWkfZ71aQtP5z8bKJcp9WEg02M+j5WKgxuRpwTiCtCWT7nJ+
         EVkJIuJr7mhq0KHbrqFyR0lYpSFCqYc4MiO0qYDM7WCfLcUlxiVfHY760Adr5Y/tO9d+
         iANBDYVs9WgJHZi8bnKie5y6cknpNVC0k4aNaKwDeECgG+y33Y/+FSJqEyL7U0pST7PT
         lylw==
X-Gm-Message-State: ANhLgQ24D9eu3d8nqt2/4NstJIf7RIHqXGEBuLINLLBB1aKsu0Q3rv2M
        zyiiV6XccB5i51j/bTxjH0WeM1ol
X-Google-Smtp-Source: ADFU+vs1sWZbfrJ1+nV9pdmA39a8uCPqtQCDAXImwVjeI2maTF0toan/mB0FmoybirhbDlJs6GqI9w==
X-Received: by 2002:ad4:48c7:: with SMTP id v7mr1714816qvx.138.1585115717507;
        Tue, 24 Mar 2020 22:55:17 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:16 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/8] t5607: reorder `nongit test_must_fail`
Date:   Wed, 25 Mar 2020 01:54:52 -0400
Message-Id: <4253f51feaf47029c1c3389e017d49f2148f03c6.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on only allowing `test_must_fail` to work on a
restricted subset of commands, including `git`. Reorder the commands so
that `nongit` comes before `test_must_fail`. This way, `test_must_fail`
operates on a git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5607-clone-bundle.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 9108ff6fbd..6d5a977fcb 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' '
 
 test_expect_success '"verify" needs a worktree' '
 	git bundle create tip.bundle -1 master &&
-	test_must_fail nongit git bundle verify ../tip.bundle 2>err &&
+	nongit test_must_fail git bundle verify ../tip.bundle 2>err &&
 	test_i18ngrep "need a repository" err
 '
 
-- 
2.25.0.114.g5b0ca878e0

