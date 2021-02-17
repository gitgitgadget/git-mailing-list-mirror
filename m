Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D5C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EF964E62
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhBQT5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 14:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbhBQT5E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 14:57:04 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42615C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:56:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so23728754lfg.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 11:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQ2DWjt8FGCfqK/1fn6RrnlohiTpDBcaSZFYf1GUoto=;
        b=cnvBvzUTAmb02MiEaKJlLzFOILpROri0HCNf4GPhfR1boJPlCFw0kxrQxlc7ba+Fwn
         2pwrfSj8aXCtujCleRyVngRxyL1u6lIUWCOWwlN3KKxcH0GCwN7rrEKkMgLhVpTVUdgY
         W9wvBoNX7fUgEL2YgVVlK27F+30ouRhD+v1dwTfpUwp32z5yCsjWYXnLsKECDnqcqfSV
         bVn4IM937I1ddES/TBO9Vn6u7w2Plrq1T9GDQz+NumRLOeoQyojMv5qro5+Lh/HNwzfu
         6xv9SO9h/3Wha91m5neDPHDou6j2f1UdMoqTWW+hQiDvkKmi/RG9EqN9RUADFvgbXnB8
         jNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQ2DWjt8FGCfqK/1fn6RrnlohiTpDBcaSZFYf1GUoto=;
        b=IwohF4eyRfTc95FU1JIsUxgZlc7oCLUtM19qbA6ZaFU4Tn9P9S/WZEnXAe+u+JUj53
         V+GBg4lZgLJMjNFci2EDlQKS3VporVPCsh0/huCWnDZfCFow3PHzqkLjfE2wDaKOu3it
         eqnpcbBKep0CCbXjTJiylRxks5vQfAXkEQ05lpa529+WtC8EsYwJWv5t+en31jUH/imO
         PeNa7LWJ1JJXGIxszD0i/CfPwTfxYkY8K7Je0qlUuphvvSql9Ihy9xwZclprmJvGQIgn
         k51BRwsElioXop9tqLhhXd3/X2kXmphtyXQ1TnetR9KNL34BhHhKy/DzFNmgeapYYoYh
         zEiQ==
X-Gm-Message-State: AOAM531t0+gFXVzmpATUT2bNAjUCgw177VR4d50a6f11RwJSOB+aK8a3
        658VlwBhhXLyfIid76D0jlJsznMcKmk=
X-Google-Smtp-Source: ABdhPJymPik+j6JWJW7yqCW4oX0hGyw4Kb7vsMPxjMbUlHrnzo6v1GNPH+/mTMXBldVYrRhPFqHa0g==
X-Received: by 2002:ac2:4297:: with SMTP id m23mr303963lfh.270.1613591782459;
        Wed, 17 Feb 2021 11:56:22 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id o19sm347495lfu.182.2021.02.17.11.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 11:56:21 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] fix some doc rendering issues since v2.30.0
Date:   Wed, 17 Feb 2021 20:56:03 +0100
Message-Id: <cover.1613590761.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These three patches fix some rendering issues I came across in the
output of

  ./doc-diff v2.30.0 master

The original topics are so/log-diff-merge, ps/config-env-pairs and
ab/mailmap.

Martin Ågren (3):
  rev-list-options.txt: fix rendering of bonus paragraph
  git.txt: fix monospace rendering
  gitmailmap.txt: fix rendering of e-mail addresses

 Documentation/git.txt              | 2 +-
 Documentation/gitmailmap.txt       | 8 ++++----
 Documentation/rev-list-options.txt | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.30.0.284.gd98b1dd5ea

