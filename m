Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855E2C433B4
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616926008E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 12:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbhEUMBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 08:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbhEUMBL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 08:01:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA358C0613ED
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so4371407wmq.0
        for <git@vger.kernel.org>; Fri, 21 May 2021 04:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JgmxC3ji1LdwWDcaPHjhS9lC0LNmteE5DJe06eKmBqM=;
        b=rSliofy1Ct9+U3VBWZiDOesr+WcsEObHZEW90vSfwExB3bAOY1h/iqMHcpy1u5cOoq
         /Ta89MOhl92/g55DgjV9Liu9TyGgOF/09Po+gVVWfNqUpYJggxuZNc2fX4BKCrbRz3VH
         X2gTSq3Uc+8vL05HxkE63nX+6r+/OL8gfPiu5XBluVR7vd/15+H7Lzcx12/d74wa/TFg
         cI7xr6mNoV45oHkawEl+lW8YSq3B8/aMhOjGTtDHTDKso880QbWPEl6YyVe5yDqZCgsu
         /T82PyPqBQuxW5YDf6/GQHVFVcZthvYHQzdrz2SrgXrMdKKNYCx60pwnYl3GDH8n3FBl
         1rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JgmxC3ji1LdwWDcaPHjhS9lC0LNmteE5DJe06eKmBqM=;
        b=E/FbWkA3vGqh+/bWsnjf7OTm32Bz1HTuppQrtkI2K7CwNr7Be/Sz7dlagFkxW3RIbi
         FakumEtmi+RAAWU9Xw+oWgk9Jnm86qd+QcwmGcLoA5R6ZQFJC0QHoAWb1ZVzMXKMYXOf
         cKL92WWvxDIecv9EtVoa2/XEI2jzN6vPjk5ay6/emYRIKtZiKjt8UYvYySXhwolWx2eq
         GVU6WvxiNzts6KuGoryOl17V/KGx3OKPjeXuaww240bzKHzwDUHFLdZgqAiTlcwd7xMa
         HxJyEUItu1JJmoW60RPMcSwgCCinehYXPTCCRXMmOd+fq6QwQbC5vxCbHz/M6Io3P82w
         7dwQ==
X-Gm-Message-State: AOAM533WUOb3R7hTflKAscVS40uSiYo8E2XTfg8QQnb55Q/Qgk2hXyss
        HwjUkIpoQe9mVzFfgz2M0mouEzZi47c=
X-Google-Smtp-Source: ABdhPJyN8cg+fpqOpqh/5lE+xcSJhbkHiA1Gv/x4i7mEAVOZ3XqPuV4EpC/iNekMP6TGbWjjC3d1ug==
X-Received: by 2002:a05:600c:b58:: with SMTP id k24mr8688174wmr.155.1621598385461;
        Fri, 21 May 2021 04:59:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s199sm12292947wme.43.2021.05.21.04.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 04:59:45 -0700 (PDT)
Message-Id: <70971b1f9261f2623ad6d6393be1a8e191003eb4.1621598382.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
        <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 May 2021 11:59:32 +0000
Subject: [PATCH v4 03/12] t1092: expand repository data shape
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

