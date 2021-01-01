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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF99C433E0
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92F3207A3
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbhAACQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhAACQu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:16:50 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1DFC0613C1
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:35 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id r9so19256792otk.11
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8I3VRV2dP0OquyCcbiibfDrON5cX4YJu3rmX0DerIg=;
        b=avOIEnhyStduwjRp2FjgfREV1ZhmmXMSgnOihxtxIPCJAxO0dAZn6JjZGGEPM+RsUl
         a+S+PGSCe8bglrasoi/sgRz/0kL1BVTRQYoTRe+PgKGsLeWT7jiPjMLTc0v0KcjxB9q0
         bbgBz+rVeWhp/Hyj7ZflvBXVWZw9g75MOKxX+kf8cEIQaAL5quQbSYw6AacAB4A2elDn
         6N+NlCUChXHh363vLvE5HjDPn1qStRVl3ZSO4K+lCrncYY2QDcMd0TqQFytClhUdKx9P
         Dh/m8Zv0c/Bs6BfCru/MLMHykMZsJUV2ql2NIFH5UVWmuJGw4xAEENWFbTgBvu7gUlBd
         lHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8I3VRV2dP0OquyCcbiibfDrON5cX4YJu3rmX0DerIg=;
        b=b5fi3gFuTf+GMOJCLMOeBabcnrLlCRTs9NFP5pWcRflKMT/e6WieufAJrB2cYzZ29U
         8Z3FEvs5McVTPy63vjLk9o6eDLpapWmfB9bqfzCWZpPx8IVB+jBEBuBCfBANSovikc9t
         X0FbMd/ShlsT31hdf9vs4IuW9CLlk1jVtSSOrcmYaeaOJ9dE7tSgWwsoM0G1G2mFTM4B
         m5fG2z5VlhIrhea705imEceoc+9JmS1oJQHDhU3oqRAHwDRTrBLScPQk4B9Y45lzJ6Mu
         zm3OOe23oNGn43eSGTVrO3uybNsx3vcdk26nrFHGXDYWCJnOZb9cGHx5N9HdwxUuew5x
         J4xg==
X-Gm-Message-State: AOAM533jTbkVb6hpmAbP3Ie1hatixAqigOZj3EhjR3AYocesMT6mHB+N
        0SJSICE/ryg4EzxHB1svJyxKJCKmfHxGeg==
X-Google-Smtp-Source: ABdhPJy4YAw9To3kZ8J8Io5sZdtK6r/bASaSdb2ZRQjKi4HlMG3tfn7zawr+ZSVQIZLuHNyDjbcOBw==
X-Received: by 2002:a9d:1ac:: with SMTP id e41mr17762846ote.46.1609467394413;
        Thu, 31 Dec 2020 18:16:34 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j15sm11513398ota.39.2020.12.31.18.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:16:33 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/47] test: completion: fix currently typed words
Date:   Thu, 31 Dec 2020 20:15:41 -0600
Message-Id: <20210101021622.798041-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They don't match what we are supposed to be completing.

No functional change.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 39760293f6..05469f04aa 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -486,7 +486,7 @@ test_expect_success '__gitcomp - option parameter' '
 '
 
 test_expect_success '__gitcomp - prefix' '
-	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
@@ -494,7 +494,7 @@ test_expect_success '__gitcomp - prefix' '
 '
 
 test_expect_success '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next seen" "branch." \
+	test_gitcomp "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
-- 
2.30.0

