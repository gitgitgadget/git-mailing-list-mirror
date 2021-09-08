Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2425AC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F8D6113D
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 08:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348140AbhIHIam (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 04:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244673AbhIHIal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 04:30:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBD2C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 01:29:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i28so2018211wrb.2
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=HZRiwCOD9pLgziNvbqJ0YIGRkTZsDXYpavvTYD8+m5o=;
        b=ZJliDUbfGarcE5DQQOB98ZN19Z0cOq5tJxQun25eYlU8D7k8vCVDUclaW/HF4qDusx
         PlSv2+TFq3yri15QT/bjc7TZMSgVWrWDQqO1ccSJ7oCZEW3MEKJZgVTnn5BywgpuNMnL
         Q7p5n1fhUVKW1eBohpseViOAQwkpdPXdUGZg6i4k5n9DuUA1tSv98cAnsu7zXeQqYNh+
         XvTrHfMaioegEIsZDlKnk88lEy50M0MCG+LbQRj8mOoe3lwXw9vylia2iSiekXq+krwM
         0nD9d5sgpdpImlx5Ac3LqAYp/2h6sbj+4J6gsuR6epav4mpIm2AGGrWamWfAfZBtau+a
         hOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HZRiwCOD9pLgziNvbqJ0YIGRkTZsDXYpavvTYD8+m5o=;
        b=DN57AUrcKB+lNMfL2YBUU+ISN5egX/TvxzI0fGujE6JV8oYNXepxxd8+947wgmwXvO
         UGBOvvOoDzNZxZxcwDMY3Xpslz5Ss5rj+X9pJTsO6EpHX70HXxk9c03aEb+JM4WYZCqY
         9nKyHfytaU6a87kVrYK8FXLSPJTPLBMI40Zb6vsrQMK7zHmjVm2uDMWEztIQoen6sjXW
         XCFlZWhwUCflQUYQ/R2EIXuUHsf8Bz8p8Ojbk2Z67FHX7IucAge2v1i7W+IhH0lvWrgP
         kimroSrpsHSiBV4CFB1BB1Wq7jg52o+M6tO9IaJf7BDOrxedPu8YVED/Btq+BWpGEf64
         6+sQ==
X-Gm-Message-State: AOAM533y6dxrTFNhynBxadwpZCRGMiCVpBhCmg1ggLum8l+ctuRJmUJJ
        1wOUaN3WxNkARnGwMHe94CADeNAint0=
X-Google-Smtp-Source: ABdhPJz96jbEbavxe/nDm5XJgZCxxGGvfPA52WZYFRhKEpdIyDF712qiESYZwY6+cQJMZereBYS2Nw==
X-Received: by 2002:adf:e0cd:: with SMTP id m13mr2607240wri.137.1631089772560;
        Wed, 08 Sep 2021 01:29:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm1450453wmq.45.2021.09.08.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 01:29:32 -0700 (PDT)
Message-Id: <pull.1032.git.1631089771.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 08:29:29 +0000
Subject: [PATCH 0/2] pull: release handles to pack files before potentially gc'ing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported in Git for Windows
[https://github.com/git-for-windows/git/issues/3336] that there are still
some code paths where .pack files are still open when a garbage collection
is triggered. This time, the affected command is git pull.

The fix is relatively trivial but uncovers a bug in the commit-graph code,
which we have to fix first.

Johannes Schindelin (2):
  commit-graph: when closing the graph, also release the slab
  pull: release packs before fetching

 builtin/pull.c | 2 ++
 commit-graph.c | 1 +
 2 files changed, 3 insertions(+)


base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1032%2Fdscho%2Frelease-packs-before-fetching-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1032/dscho/release-packs-before-fetching-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1032
-- 
gitgitgadget
