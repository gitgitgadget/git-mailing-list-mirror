Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4F0C433E7
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B269206FA
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 20:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmJs55CS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgIAUTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgIAUTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 16:19:32 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BACC061245
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 13:19:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a9so2407655wmm.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s+zHR3Bi0aSN7VexU6w+KSamEHrE3KpyFdDeDHhtATo=;
        b=rmJs55CSgThRXhdaC+BXUhHr4sIjnXA84XVWQoszidjjdRpHA9m+jVvVBOi/1lapkh
         pVV3kSUQbq/4LzkRd1sJ+mthjAzjqbDhyWxBU7w1+g32W4I6ose/dvGjKeMZsVYOBcw7
         iFBoqiKawPCdBK+/SyCPVk/RLTFYu7keNcl6FxKJ3lob65sllZbDWFPYsWb0kc++8spm
         w5Ubbkx0L2l3++GXqmRPOu68i58QAoXkWO26btyUt/WRfMZZms6AROlO4Q91kZbhiLV8
         bTdQP1p0Kj2zl6zXN2Q1B8Uwzfey2DE7GO7UGXSyVB3ISDXRK/BefXCvjD7Nhxkr5ndR
         CoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s+zHR3Bi0aSN7VexU6w+KSamEHrE3KpyFdDeDHhtATo=;
        b=BpjN3WzFiTmJnPuKKdVvNq6fFunoyBnCWTd9uVMeHOJ0w71suhiEcJ3uNnsjKJOwxs
         pbwtzsPzesH+x2BkGqKXf7yK+vRfRGLvPPQGfKgoU5RC4dxbu8Jg1tKqYsKTz4rDyw+q
         WhedEt71pcMT4Gmw62bRtDrFrV561YZu6J2AbSEa4heBuTglsyI92Y2OGq3qu7HiiN2A
         y6FGROV/GBPZO4T/Th996MbZEZrM1wQlkbpzrRaS40q3ynb1Z9zNV66op6YWAB/kazyv
         D0bzfaxGD0CjaYzTWNwdexiw3uwo9IxKMHGzxHZIAabmyJWAiMMI7iKkFJP5sLzuFocB
         PH1Q==
X-Gm-Message-State: AOAM5324299HKH4crPr9fCN1YhCZ4AUH1MF4Usu/zjrtSEbpq4BCTdUZ
        LHQQ7smSvP2X3UbCJcutIvc5OE7Dhgg=
X-Google-Smtp-Source: ABdhPJxtYi0W7nsSujTwplXw2seeu6IE+lqbgjaH2uWoiEWkyeNFO2nzZPqZMc9xHywGXNIjPgX9jw==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr3146362wmj.132.1598991570101;
        Tue, 01 Sep 2020 13:19:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h5sm3826173wrt.31.2020.09.01.13.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:19:29 -0700 (PDT)
Message-Id: <b5363e282f69570e34ffb806f7a62e00e39b98bc.1598991568.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.719.git.1598991568.gitgitgadget@gmail.com>
References: <pull.719.git.1598991568.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Sep 2020 20:19:26 +0000
Subject: [PATCH 1/2] ci: fix indentation of the `ci-config` job
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The section added in e76eec35540f (ci: allow per-branch config for
GitHub Actions, 2020-05-07) contains a `&&`-chain that connects several
commands. The first command is actually so long that it stretches over
multiple lines, and as per usual, the continuation lines are indented one
more level than the first.

However, the subsequent commands in the `&&`-chain were also indented
one more level than the first command, which was almost certainly
unintended.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 30425404eb..6fd1d1a2c8 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -23,8 +23,8 @@ jobs:
             --filter=blob:none \
             https://github.com/${{ github.repository }} \
             config-repo &&
-            cd config-repo &&
-            git checkout HEAD -- ci/config
+          cd config-repo &&
+          git checkout HEAD -- ci/config
       - id: check-ref
         name: check whether CI is enabled for ref
         run: |
-- 
gitgitgadget

