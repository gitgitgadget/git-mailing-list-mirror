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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C907C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEB461442
	for <git@archiver.kernel.org>; Fri, 14 May 2021 18:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhENScd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 14:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhENSc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 14:32:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECBFC061756
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a4so186727wrr.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JgmxC3ji1LdwWDcaPHjhS9lC0LNmteE5DJe06eKmBqM=;
        b=Ifs7ofUwR7nF/LTeYWHUsJ8AdRLR03DTa/suMJ7VcuucRdYDbCGjuiPKhdbZKFPOV0
         Ivoj7mRKFyxKWj5nCfY2LdR2a2sPl855yBIjFW4xNzrblRfuOeLOCaii9fyfWXU16VTo
         aPg8B28USGIqdfMqSVemfRjS7nIjWVwn+jvP3h0XMh+pAIjqSqw55NVDLLJ95ZgOzKZr
         LqqUtcUhFGJDAWljuj82VbDyJOdIrdCUGdvHg5REqZPSUnUhfqmVP+mF3Tb8GlRVGsqF
         zmkzEN/H0p3FU5n0jEZYxD55vT+tjtazYk/BtbL/10AM1x0NQf0KsbodSbNWRUnC7LIj
         XyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JgmxC3ji1LdwWDcaPHjhS9lC0LNmteE5DJe06eKmBqM=;
        b=Yp+TJaOQoxxfHm2fw4m0FkeR2frfoL7vG3p9u2vpfm6BbbNXR7d/tAiF6GUdyP6LEK
         iteimQrurkw4mjM6eWrXimxT1w93dQjTgbpnaGhV10Bsx9A5sDf55lZ4N5hfTeL2hi4S
         Y3QG4+ikoZlXUoZYZ0LhOq9zNHR+jqvSR1Wa42NrDJGokJHdg2bzJUc3ATrKu5u45XcU
         RHtGBBDlQQ2QPWu5/PTzyc1rKbLq1ECtDd3/8E8iT52cLRS1JcObGtGGpvoNhPS2x8Tx
         3IGkeTWCeW56L1YFxtVn1zmKG7TOTb8/Ef+9ZVGvLlknMM+Xd1imSjacZwNgC/YC8UnA
         BqIQ==
X-Gm-Message-State: AOAM531nK+qZVXse87z/AR0ZyaSREAAgMbiX6EqgKCU3uVnhFIPiPfbc
        JyXUC2XWdHT0naUk7vdM9z0D9geDF6Q=
X-Google-Smtp-Source: ABdhPJwFWWiEJEuvZIo3v4XiUQD9lbcthCSxA8d28Eqxe0HGMfmw6Cdm3iUAdVDVJWRaUZxc60L7nA==
X-Received: by 2002:a5d:670c:: with SMTP id o12mr8419029wru.223.1621017076401;
        Fri, 14 May 2021 11:31:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l14sm7624767wrv.94.2021.05.14.11.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 11:31:15 -0700 (PDT)
Message-Id: <70971b1f9261f2623ad6d6393be1a8e191003eb4.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
        <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 May 2021 18:31:02 +0000
Subject: [PATCH v3 03/12] t1092: expand repository data shape
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As more features integrate with the sparse-index feature, more and more
special cases arise that require different data shapes within the tree
structure of the repository in order to demonstrate those cases.

Add several interesting special cases all at once instead of sprinkling
them across several commits. The interesting cases being added here are:

* Add sparse-directory entries on both sides of directories within the
  sparse-checkout definition.

* Add directories outside the sparse-checkout definition who have only
  one entry and are the first entry of a directory with multiple
  entries.

Later tests will take advantage of these shapes, but they also deepen
the tests that already exist.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 4f2f09b53a32..98257695979a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -17,7 +17,7 @@ test_expect_success 'setup' '
 		echo "after folder1" >g &&
 		echo "after x" >z &&
 		mkdir folder1 folder2 deep x &&
-		mkdir deep/deeper1 deep/deeper2 &&
+		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
 		mkdir deep/deeper1/deepest &&
 		echo "after deeper1" >deep/e &&
 		echo "after deepest" >deep/deeper1/e &&
@@ -25,10 +25,16 @@ test_expect_success 'setup' '
 		cp a folder2 &&
 		cp a x &&
 		cp a deep &&
+		cp a deep/before &&
 		cp a deep/deeper1 &&
 		cp a deep/deeper2 &&
+		cp a deep/later &&
 		cp a deep/deeper1/deepest &&
 		cp -r deep/deeper1/deepest deep/deeper2 &&
+		mkdir deep/deeper1/0 &&
+		mkdir deep/deeper1/0/0 &&
+		touch deep/deeper1/0/1 &&
+		touch deep/deeper1/0/0/0 &&
 		git add . &&
 		git commit -m "initial commit" &&
 		git checkout -b base &&
-- 
gitgitgadget

