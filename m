Return-Path: <SRS0=BhVQ=67=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA9AC433E0
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549A7207F9
	for <git@archiver.kernel.org>; Sun, 17 May 2020 18:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spq+4+aX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgEQSwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 May 2020 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQSwd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 May 2020 14:52:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF644C061A0C
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e125so5316459lfd.1
        for <git@vger.kernel.org>; Sun, 17 May 2020 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IdOc17yN9FRNkLZ5J6ehXVK55yHo37eeEfE3sBfSmow=;
        b=Spq+4+aXvyHMT4630Lwb/YsTJATkHb0DAxhz/Tss83UttG5FV49gcCZRpjLH50RzZw
         WUuPwUgCRg5e9FSihSvwjXDurk6dgdiZ7uYOquh0Yq+x1JHXcuxDilai/WvaYpUVQdlx
         pRANKFV086X/amkuBvCLYB1he6stQ4lwV/db/WC+/TtwApyo+eb2S+VCK3qqwREGj4sf
         giZte08FSjJYYR7GoFkEEvXtWLI0Bu071wli/dz91mcW7uYAvkcs6Vjv/MsOHdFphmo+
         3iMjHQXRbH1kxah/6xowRwgIaGILbnk4pV6V+7LNo6SzXCNVc5hqwGv2RvMjLQxhJuON
         1gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IdOc17yN9FRNkLZ5J6ehXVK55yHo37eeEfE3sBfSmow=;
        b=rboJfdidB6hp6DxC66eAf5gahSIaEjDijuYACLecAHuVjRVUlf+a7jrWvw9r9aCnOI
         XVDiypq1H9kiRdtu3YeFey1HrWI0M8jmyrAltGwM0oWP6rpBrN8QZUb35WRnV/Fawfiw
         3pDjL3YO+xdE7fPuQr5FqJIVYK9kwG7cwpuD8ws1lDTvh2wEZ+y51T+YtkNmAMffwwE3
         FEEujKP5yCFqTfFKmJ4LzPO8rTBY/LFuurkFGTt2RLKqw9gefNOdfdBLB6fqnwZys3nh
         sQVG2Td/4eEVF62Fp9Pe51znulefjVicDkAGr4aLRFK4o/uJya40gejBM5XxKA2OV1d3
         g99Q==
X-Gm-Message-State: AOAM532lNDh1xrTaQ1Ga1Pc553A6Y0D3UN7EHii+Zx4b3YGwqWnel6p6
        z1QD26LQHEb6knR7QQ0OuJTqnan5
X-Google-Smtp-Source: ABdhPJxc0hSwG4OBNPRBkY7Q+qPXbWXckSefM2ZEg67BaJlsTMwZdzdAsmnZRSODlURFQw76u0ERDA==
X-Received: by 2002:a05:6512:6ca:: with SMTP id u10mr9344084lff.184.1589741550282;
        Sun, 17 May 2020 11:52:30 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a12sm4513938ljj.64.2020.05.17.11.52.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 11:52:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 0/7] Documentation fixes for v2.27.0-rc0
Date:   Sun, 17 May 2020 20:52:15 +0200
Message-Id: <cover.1589739920.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've gone through

  doc-diff v2.26.0 v2.27.0-rc0

and identified a few misrenderings. Here's my attempt to address them.

Working on this, I also got to look at the new features in the upcoming
release from another angle -- looking good!

Martin Ågren (7):
  date-formats.txt: fix list continuation
  git-bugreport.txt: fix reference to strftime(3)
  git-commit-graph.txt: fix grammo
  git-commit-graph.txt: fix list rendering
  git-credential.txt: use list continuation
  git-sparse-checkout.txt: add missing '
  rev-list-options.txt

 Documentation/date-formats.txt        |  3 +--
 Documentation/git-bugreport.txt       |  2 +-
 Documentation/git-commit-graph.txt    |  3 ++-
 Documentation/git-credential.txt      | 16 +++++------
 Documentation/git-sparse-checkout.txt |  2 +-
 Documentation/rev-list-options.txt    | 38 +++++++++++++--------------
 6 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.27.0.rc0

