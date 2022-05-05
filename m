Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B2AC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 20:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385899AbiEEUgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiEEUgd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 16:36:33 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6305FF15
        for <git@vger.kernel.org>; Thu,  5 May 2022 13:32:53 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h3so4072192qtn.4
        for <git@vger.kernel.org>; Thu, 05 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQ2Y7/6VDkvlQJxsFn0F9f9upCHRvdieD/zLb/krEbM=;
        b=Es7mq7xjzGhiZ6ZZ229K82jLuw5SFa0osn4aX4w10/W2z4nI3m2b+En/tME90Ee5Nv
         rDRiLH+MN5D18QBIjQPebeqtNYhE7be4bkg39+hVib9chWMqGPUbs1+37idfl1D+7UNL
         zAimrzsKIK+cgPHYO4emGRtps5HQDrACDhxv6ViiJCeW7L/YFTOSs/WfAhidLjzNneBp
         ga/gA2GRH8v/lPqealdsBlHW3yG5/ofIrRI4BAKO2Q81D0JOOWJmNMw3DmUjDcMzCx64
         zsqT34EcXk6ZOZr+O22fUhVED4l1lH/9PVqDhTtnd49efyvUiyrKEse99L8tshNJtjk0
         8Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GQ2Y7/6VDkvlQJxsFn0F9f9upCHRvdieD/zLb/krEbM=;
        b=LZxty2/F/R16D85BiQuBtGEp2b8h2fLUpZ5ghsRV2qSM+dyCffgIKLvkPhtdX6neHh
         Gvwb1pmwS9JMwdRnyrb9CF+uWGjOttV9Gu6e1nM8+Y6PnLnsushSOzQnaFWEn6LeF7TG
         QSlskWs62XvgL2jlevYKk0ZQRJyBo/b8FW5Y95WY7DQUi6GcfgK0sYsBZdM7C2PHl0/+
         YzcRmEnHxeqfzd7jp0qUdrVXqHIzaICDmVFrqxbNLIkWmEpjOUG7JwMPWR/rv5Q3A902
         aWxwafDm8fiJ6PtOYIsEXiReyzYEGcYUi4ZdNRg5yvVB8CTFx5pZOiaqre1XIqDwbR0V
         Aw2w==
X-Gm-Message-State: AOAM530MfoQkY04WvyeHbd4PN3c536FrAdCeBwBnZcUiBGghhIF6M41x
        W4umBYGOzN3BEq2ebohfYp0zxIwJB4bZ3y0sVxs=
X-Google-Smtp-Source: ABdhPJz8GHgwtlmEYkLonwQGl4Ml51x5ZRirQPiO1/Zfmsytxip3icSTJGVhJoti1ThDPbRFiNnFSg==
X-Received: by 2002:ac8:58ce:0:b0:2f3:a42d:ae28 with SMTP id u14-20020ac858ce000000b002f3a42dae28mr19886518qta.416.1651782772134;
        Thu, 05 May 2022 13:32:52 -0700 (PDT)
Received: from localhost.localdomain (pool-100-33-115-203.nycmny.fios.verizon.net. [100.33.115.203])
        by smtp.gmail.com with ESMTPSA id y12-20020ac8524c000000b002f39b99f695sm1350285qtn.47.2022.05.05.13.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:32:51 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [RFC PATCH 0/1] dir: consider worktree config in path recursion
Date:   Thu,  5 May 2022 20:32:33 +0000
Message-Id: <20220505203234.21586-1-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Please see the commit message for a description. Effectively, since
8d92fb2927 (dir: replace exponential algorithm with a linear one,
2020-04-01) the following no longer does what it used to do:

```
test_repo="$(mktemp -d /tmp/git-test-XXXXXXX)"
cd "$test_repo"
>test-file
git init
git config core.worktree /tmp
git add test-file
```

In terms of desired behavior, it seems that if it is possible to track
files that are outside the default worktree, then it should also be
possible to track files inside the default worktree location.
Personally, I was using this setup to track dotfiles and some other
system related snippets and liked that design more than alternatives I'm
aware of.  I ran into this problem because I was recently unable to add a
file to an existing repository with this configuration.

There are a couple open items but I wanted to get some feedback to
confirm that the behavior of this patch is desirable or if I'm
overlooking something entirely.

TODOs:
[ ] add test
[ ] add signoffs

Goss Geppert (1):
  dir: consider worktree config in path recursion

 dir.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)


base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
-- 
2.36.0

