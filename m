Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF55C43214
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7B66103C
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 21:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243615AbhHZVBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 17:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243603AbhHZVBD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 17:01:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D418C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id n11so6610689edv.11
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdR1aQKjlpEG5QSHNUMLX+QG8NVn1igfaNppAefxTmM=;
        b=jNEUjP+2M4GdvdksgtuU2ueAhaKBiKO7KJ48Voxrdofa9csadpCWKMpvlWvkn/q/kl
         kYsoJQ812PflibGyE5Tzy6iGVsfq9GqdFFUq11b7TSOaE1JJiwABcjKJPuRg4pBZMm5W
         V/ErLh/me2hIhMRJ4VsbL1kVH9Auf0zgk+Q/r2/pHLr9mC50VEoqBcDa7INHPf51EHkr
         Mjix1l8eE86j0sdQxcN8RVH/XKTr9fXQT2eO6yxJJzlwUsY+V9cgEZbdGb3JM/Kj1C6m
         OOjF153bBZUUiz2/o8XdUzfHwoJo5nH4uELyWpusfMTr7eamj0UIg1hiEtds4UvaGmQN
         knRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdR1aQKjlpEG5QSHNUMLX+QG8NVn1igfaNppAefxTmM=;
        b=Flow3XA7rnV8JZ/NLE8kPUU7PbHfpvUKFXt1KllNuZtVb1WplLpGkK5wy4OZbzozsg
         Vo73v1re+3m6IE5mRv2yJvb/xYFq3gchZXG4unWYUXV8luEAhfrR4D/iOlStA76hxiv4
         38ZEcq42IpYqqAsXOLeu2cNf5ea9Pn/CEoHsgHJcSK6SVPnVKMVbMDmQA20ufIMli1n4
         ncUBj3II3dkWDCT+i3gZCq2F6SuMp5wPryxOwNZN6YizGMGRh7ng9r1+NDHEKTLw7be4
         CwcLtasq+m2H1QFcb1/m+HSwElaUVVuPrt5r70JqzyYJddIREEiu5X2IGWjeBsBzW7sl
         6d6A==
X-Gm-Message-State: AOAM531za2yBMSoyasS5Tgo2OLE/DjP4zFlmSl0GukpqN+DDumSw5rtl
        6HwvmFjpIhRbgqoX2b7k+774/h5ZHlY=
X-Google-Smtp-Source: ABdhPJyN6IefuyBQ8k9RXkkMewrkLIrm0wF1/hP9b/Dq/uz1JoyCy4btATKCaRldU61c1BJ2/00RbQ==
X-Received: by 2002:aa7:d455:: with SMTP id q21mr1416023edr.5.1630011614128;
        Thu, 26 Aug 2021 14:00:14 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id q14sm1884779ejc.93.2021.08.26.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 14:00:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 2/6] t1600-index: don't run git commands upstream of a pipe
Date:   Thu, 26 Aug 2021 23:00:00 +0200
Message-Id: <20210826210004.672860-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.33.0.358.g803110d36e
In-Reply-To: <20210826210004.672860-1-szeder.dev@gmail.com>
References: <20210817174938.3009923-1-szeder.dev@gmail.com>
 <20210826210004.672860-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t1600-index.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 5d10cec67a..aa88fc30ce 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -13,7 +13,8 @@ test_expect_success 'bogus GIT_INDEX_VERSION issues warning' '
 		rm -f .git/index &&
 		GIT_INDEX_VERSION=2bogus &&
 		export GIT_INDEX_VERSION &&
-		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		git add a 2>err &&
+		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: GIT_INDEX_VERSION set, but the value is invalid.
 			Using version Z
@@ -27,7 +28,8 @@ test_expect_success 'out of bounds GIT_INDEX_VERSION issues warning' '
 		rm -f .git/index &&
 		GIT_INDEX_VERSION=1 &&
 		export GIT_INDEX_VERSION &&
-		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		git add a 2>err &&
+		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: GIT_INDEX_VERSION set, but the value is invalid.
 			Using version Z
@@ -50,7 +52,8 @@ test_expect_success 'out of bounds index.version issues warning' '
 		sane_unset GIT_INDEX_VERSION &&
 		rm -f .git/index &&
 		git config --add index.version 1 &&
-		git add a 2>&1 | sed "s/[0-9]//" >actual.err &&
+		git add a 2>err &&
+		sed "s/[0-9]//" err >actual.err &&
 		sed -e "s/ Z$/ /" <<-\EOF >expect.err &&
 			warning: index.version set, but the value is invalid.
 			Using version Z
-- 
2.33.0.358.g803110d36e

