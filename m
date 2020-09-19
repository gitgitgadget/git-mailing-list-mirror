Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C44C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 08:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3710A21741
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 08:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="Mh6AkVUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgISIx6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISIx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 04:53:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E3C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 01:53:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e11so8201464wme.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 01:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZFUnyq60QIsRz8225AMhPYqyJgptPOJ4i6EpaiUTc4=;
        b=Mh6AkVUNhgsgkKVwltTYbGU8akK/tlaUxDOO6OF8bjchy8ZQFNatM+mbDa4J7HaxbJ
         RvTfUDU1F9UYmBDVhFo68heNS53Pki9FT2fGbjCjf81pO0b/ylM+b9XVfAzLJp9BNo5r
         KpfhiF/qf4qs+tfJTv4yLfxGjwPTHR6eSXUl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZFUnyq60QIsRz8225AMhPYqyJgptPOJ4i6EpaiUTc4=;
        b=lK4Vm/B/hHV/6VUAkZvmp0U8WLVSndRJI8OFgz6XyhptGqnu04/BgfI+3ORT2YHFOE
         NWxabkT8qQzlik43R7R5p9OAauIcz1PzvyaKKGBIjFcM/NNWrMxGZRB9rK8XclfKZb+V
         XjxMzTtwVN4XDSIrI+71Q//LH5ABTjCfyJK5kFDE158DHRsH26CIaBxfTjmIotC8X5+v
         ByLI2e/lnDGE7UPSZq61e+LESqn1nVwLPcAiro7zqcO8pDPJG178eD0v0erK2S6gOSNv
         jFBfD2Ej9boj+MEYOUek8AnGLA6LrPBwko9m+b67suqFJVAYaQbpSYVoXNddwX4VNvJm
         3mVA==
X-Gm-Message-State: AOAM53124DsUQlANiBJMQlgBqFU8APrZQHz771+z1Jp12x74cPDee/W1
        sHi1LCPm2eNoSVtBeYrs6E/H7ausijfBKQ==
X-Google-Smtp-Source: ABdhPJzpi8uVoAmYoyeVJxLzBMihM/zWb7scQv6HhnjGBvBDXTE6k7bDw8FSl+BYLXCUMhW2fIGcBg==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr19388388wme.179.1600505636008;
        Sat, 19 Sep 2020 01:53:56 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc149478-cmbg20-2-0-cust747.5-4.cable.virginm.net. [86.16.90.236])
        by smtp.gmail.com with ESMTPSA id t15sm8798872wmj.15.2020.09.19.01.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:53:55 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 1/2] git-p4 unshelve: adding a commit breaks git-p4 unshelve
Date:   Sat, 19 Sep 2020 09:54:40 +0100
Message-Id: <20200919085441.7621-2-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200919085441.7621-1-luke@diamand.org>
References: <20200919085441.7621-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 unshelve uses HEAD^$n to find the parent commit, which
fails if there is an additional commit.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9832-unshelve.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index e9276c48f4..feda4499dd 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -29,8 +29,11 @@ test_expect_success 'init depot' '
 	)
 '
 
+# Create an initial clone, with a commit unrelated to the P4 change
+# on HEAD
 test_expect_success 'initial clone' '
-	git p4 clone --dest="$git" //depot/@all
+	git p4 clone --dest="$git" //depot/@all &&
+    test_commit -C "$git" "unrelated"
 '
 
 test_expect_success 'create shelved changelist' '
@@ -77,7 +80,7 @@ EOF
 	)
 '
 
-test_expect_success 'update shelved changelist and re-unshelve' '
+test_expect_failure 'update shelved changelist and re-unshelve' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$cli" &&
-- 
2.28.0

