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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15547C433EF
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BBD610A6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbhIMPqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245436AbhIMPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FCAC0A8890
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:26 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i3so6948519wmq.3
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EKgIYMV65+pF8SWCbofzmd9DTdcc/w9+US6Qm8arifo=;
        b=Of0rWDWAgVVaHdcD3HWcKPR+QPAU5Wl01lYhQg0lOC2822OoNzOVBH1//y/K9nexjR
         sCdnauHBFIOne8vuy35As9Hunex49ELkA+8cNqZb+NCVOS5JTYZ+u0SRml8gd0P4Jmb4
         n+FuGok/BVoXsEdY+nNpGPi4N2HwhB/RPv0+cZL8eRekpgp+Y2fX4MklRrcvYR3ddftl
         B3249kCF45rdAeznrRe2DNjQRWagceWxAWDIsjv95P4J287rVBzKlLVDBSszW4VZqI3d
         Cp6LdVQvXb+M/mpMs8uZgcz+hJt23a2a2AdLrcRyNFtsnNDdkGw75YwLJafmZ5JOCmNh
         o3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EKgIYMV65+pF8SWCbofzmd9DTdcc/w9+US6Qm8arifo=;
        b=zpOqPRu9qGBcG9LP1y8Y+FKSGg21wgV6ijFzyqJu6BPFTF7JFGLFA6aDYPaQ1IBUjJ
         d1/kFk3OqmIjRImabXZAmZTsNnM8VlqtIFIY36RyxSUnrFqnjuuGuJZg0INcYk9kZNVa
         4fcpq5fY0SEBATzVWQ4k++fEhPry881SAPWqpXL66h1jxlX9bVJpWz8Oe2GZSDcbZKS7
         ibBqY5B3g/UGYvDQW4Koy14RIe0blCbcS5gkPJmtO+e1APUZ+1updzIP5EJy36hvJM5U
         Rz7kdLYCl+N/xFK6kC5XwYkMiAg44kECht19HTvrckOdC7sGBMBtmGvLyA3o1x+43FAB
         9Sww==
X-Gm-Message-State: AOAM531io/c10Eo+KhP7V3T50N/FeFnTs77tx8BjhHm8cLXo104ZhCfC
        SC4NBSkrAiQBHyhgVudAbVbBow+hF6k=
X-Google-Smtp-Source: ABdhPJxOkGSzqJbWGhjH1533EmabLK5eAENOQ4By1Z2rqOKfPSxuy6BpLPWOyAKZkrQEwauRt5MHgQ==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr11818263wmj.173.1631546365505;
        Mon, 13 Sep 2021 08:19:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm7326291wri.43.2021.09.13.08.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:25 -0700 (PDT)
Message-Id: <abfffb31a562cc3b896c0a94a1ef7456657e1268.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:13 +0000
Subject: [PATCH v2 02/11] t3407: use test_commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Simplify the setup by using test_commit. Note that this replaces the
branch "pre-rebase" with a tag of the same name. "pre-rebase" is only
used as a fixed reference point so it makes sense to use a tag rather
than a branch.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index c747bd31d76..0ad21966bc5 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -8,22 +8,15 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-	echo a > a &&
-	git add a &&
-	git commit -m a &&
+	test_commit a a a &&
 	git branch to-rebase &&
 
-	echo b > a &&
-	git commit -a -m b &&
-	echo c > a &&
-	git commit -a -m c &&
+	test_commit b a b &&
+	test_commit c a c &&
 
 	git checkout to-rebase &&
-	echo d > a &&
-	git commit -a -m "merge should fail on this" &&
-	echo e > a &&
-	git commit -a -m "merge should fail on this, too" &&
-	git branch pre-rebase
+	test_commit "merge should fail on this" a d d &&
+	test_commit "merge should fail on this, too" a e pre-rebase
 '
 
 testrebase() {
-- 
gitgitgadget

