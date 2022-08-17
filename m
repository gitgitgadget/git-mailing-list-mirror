Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC807C25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 07:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiHQH4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiHQH4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 03:56:44 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4927A771
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 00:56:42 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r69so11351108pgr.2
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KcX/luD9+zN6xwBaC3mAHSTH3DLVwJY3BO9d0z3/oFA=;
        b=jG94pKdlNVyHWQ0Jj7bvT7/VTAZw4jceOcBGMAe1dJ+T6brRfv8KdIXED9Tb4xzaUO
         i0jf13g6NvU8k2VJrWHOjXe1//xNH1Bq0ZhA+X0SG8GnsNvv8Xhn/bbzRuwznh8JHmKZ
         JNqpJ1NHFqflJfNyfVpWnUyHqD3aR/1y1G4Abcmgzu2m1IY9DiDfXF8CdtPY9+XXYt8M
         J8myRh8LPE4berfIqgefOqJ6VirT08bXd4J+mJ1VHX3YlzaVOIMGQLb9H7tc+Le4s3gw
         G9Oth63N9VvZluW3VTcYiVE8DOeyQLfyurTM8Xy2FvO5D68WR1smATvmWUTze1izVjWy
         lGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KcX/luD9+zN6xwBaC3mAHSTH3DLVwJY3BO9d0z3/oFA=;
        b=iAR7kYDsK8nu7lG+SKtCPyo/01LWEwuuzvdaDJ8QUh8O1YFpZlM0YogOExmGeJYGMN
         Br9myJi4LN5y3OAF+uC0B+uz71XHw4ttxwUhmDGnE/IhVl4z/4O66A+J8XeEUwBhJhNe
         5vwyU1C+T8FiEUl/IdjCMFAp9NRySgfOfj99A6pUJqQEJrMJIqMErCjn7xz/qoIJXNmD
         pLpfwwET6628fvYzVZ5r3VZu2CbEzR6Uj1wc+J8j1Cg7kpv3XLtlrGgetbg78Pkdp1+m
         5m76y9pJ1H+RpAhjlh6V0nyKNCqNNZh4gYsGuF3sDxN8X11i+QFNEOnCVfI6ax8Lq1fb
         zPGw==
X-Gm-Message-State: ACgBeo3cfCPm/9VJiurUiBzBQFinSaiSgLpnk2I6a/ncg9YwUmKuq+L7
        d8s6hT0D2xrOaodjiy4gp0YOZgbLrhkxGg==
X-Google-Smtp-Source: AA6agR51LS3Eb1qT81/lhb/JZLm3ANufHQoO1tse/OMHudsAvfIIHYgxZbj5Liy5eE17rTSqdyyDNA==
X-Received: by 2002:a05:6a00:3489:b0:532:830e:d4a7 with SMTP id cp9-20020a056a00348900b00532830ed4a7mr21202455pfb.13.1660723002038;
        Wed, 17 Aug 2022 00:56:42 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.228.141])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b0016d1b708729sm743532plg.132.2022.08.17.00.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:56:41 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, vdye@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 0/2] grep: integrate with sparse index
Date:   Wed, 17 Aug 2022 15:56:31 +0800
Message-Id: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate `git-grep` with sparse-index and test the performance
improvement.

Note: This series is based on 'next' because the 'rm' series
ede241c715 (rm: integrate with sparse-index, Aug 7th 2022) is in the
'next', and the test cases overlap. Base on top of 'next' makes sure
there are no conflicts to reduce work for Junio.

Shaoxuan Yuan (2):
  builtin/grep.c: add --sparse option
  builtin/grep.c: integrate with sparse index

 builtin/grep.c                           | 18 +++++++++++++++---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 17 +++++++++++++++++
 t/t7817-grep-sparse-checkout.sh          | 12 ++++++------
 4 files changed, 39 insertions(+), 9 deletions(-)


base-commit: c19287026c9b940f7f43d34e6dacbd5c34e4a2e0
-- 
2.37.0

