Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70949C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5746F6023E
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 13:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbhG1NxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbhG1Nut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 09:50:49 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84A8C061757
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 06:50:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l24so1369876qtj.4
        for <git@vger.kernel.org>; Wed, 28 Jul 2021 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Th6NjDlQtWV8epIzDDw/OtzDdcEw0F8vjLc6D0RyUpo=;
        b=HUKRJKiTb3K4YF7jCbF0CZIxUxuw6AbYchvXrjdU2uqwIw5H4cqmzeWitTdDXgsvOa
         GEnS2aXqMD+A3/ygScsIO/IjKW4bGH4ctN2vtSj3LBGNs7NGaHrCwZWDUL15mlSonsB3
         TsF/218bi4kPk+ETjxUa/E5VqvjCSVYx337NvcCZxTNH4aFgLSMXkxYHrtho+SCSTBUW
         sVQohXE9Y34GXqGOjcEBWd5qjwEupo8nQkCpMHyy+/QGqd7FEGm0wwPgXVlZ54FmuLQx
         zFFNlSUtzFMSYUmai9j2sEO85htfgplBhM+IvBR5LkPDUebpj5TAJy64WdHWREfGUUw1
         kVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Th6NjDlQtWV8epIzDDw/OtzDdcEw0F8vjLc6D0RyUpo=;
        b=hAWX7pGPAWNnRQYpGGQko8oiMEOXXe5PA1oFOpqRlOBFeTuXRNiffksvJYi4ikpKrq
         f5rsy1OZkxWUF0pjTt/MS59kla9eV3X6GhnOgzUyn4wKKcuNxw5BjGuikRH0D9UJYITw
         OtmMzpCGyFufvX3b21ALEAfVzIdzxfwmbFn09TH0VrG5kXAB3LZhQ+J2V1E+G7LrdMi6
         LpVYlvwCLBl786Hw1G6+O06bjQ27ANiswo2dr5bFkemy3w4YimmniGgfsv/8+yQvsyxy
         XpAlXDWAut1028TiuAAZmut/kk4l3/Krx4F08rEPU8e0YvB04ZuV5GzBmyVXOI2bCZIc
         RnCQ==
X-Gm-Message-State: AOAM532s0WJJmCYqKLAdX1fFH2omibuWIEoruEAdY/hh4IuZMysFs70T
        WgAJFEYMXHMKmnm81eZBUAk6moVNQ4A=
X-Google-Smtp-Source: ABdhPJzL+lIO6dVVSLld7wwJf3cveTkc2n7bMsV765icpWzCp0qzuIdqad6DNLHDSaJ2LetIFmxfCw==
X-Received: by 2002:ac8:5e97:: with SMTP id r23mr24103403qtx.35.1627480246686;
        Wed, 28 Jul 2021 06:50:46 -0700 (PDT)
Received: from localhost ([24.169.20.255])
        by smtp.gmail.com with ESMTPSA id o15sm2787860qtp.25.2021.07.28.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 06:50:45 -0700 (PDT)
From:   Ben Boeckel <mathstuf@gmail.com>
To:     git@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 0/1] Improve automatic setup of tracking for new branches
Date:   Wed, 28 Jul 2021 09:50:40 -0400
Message-Id: <20210728135041.501850-1-mathstuf@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently discovered some of the nicer behaviors of the `--track`
option for local branches (courtesy of `vim-fugitive`'s status
rendering). However, after a few weeks of slowly working `-t
origin/master` into my workflow, I figured that Git could help me out
here.

This patch adds three new configuration variables to initialize the
`branch.<name>.*` settings for tracking remote branches.

I suspect there are more tests that should be added.

Thanks,

--Ben

Ben Boeckel (1):
  config: support setting up a remote tracking branch upon creation

 Documentation/config/branch.txt | 15 +++++++++
 branch.c                        | 28 ++++++++++------
 branch.h                        |  3 ++
 config.c                        | 15 +++++++++
 environment.c                   |  3 ++
 t/t3200-branch.sh               | 57 +++++++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+), 10 deletions(-)


base-commit: eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687
-- 
2.31.1

