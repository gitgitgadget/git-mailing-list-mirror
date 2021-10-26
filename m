Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5AEC433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8731C61078
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 22:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240098AbhJZWh7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbhJZWh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 18:37:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D934CC061767
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:35:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b71so80175wmd.0
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 15:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=dMdwP4uwXEfNCziaCqzxRrpLWKVjpuNMRb9x3xSPMPY=;
        b=q3Ze0pgWKM6Vz5gsmIrx+D8mZ/JH5G8kUb7ynpsX3VvFEyl7cC5OCOgVUnbOC/hOss
         /ew0an0FGfiWM3CIeCqXj8/OUpAgK2uMEsRtZTBGHkVrBHEDeMyb7jEW3dOfCdEqRH4T
         xLx1WM8sreD+C/q5/MMk7dz7DhpIB0Subh5JSlkDGelRD6l/Ct9G0TORW3hY9jhFTj5l
         /9R/gyZVoCi4QZb5lVgH8RdjyzS7X1DRjLBVCunP3PDHdDskk7V1flp6cdChS92GahAQ
         jFhJGbW8eTWQtXW7js8YSKxuZHKsYcuQ7MQiQqqkPxc4Cen/9eAx4qXfQGa6HacdLzrx
         /+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dMdwP4uwXEfNCziaCqzxRrpLWKVjpuNMRb9x3xSPMPY=;
        b=R/pbER+ycTYioOBdhOhFKh+RftrbMDrYHSJg4gX+gpzyS5KSbj25TqEaGrGSQq7R3Y
         p6RP9PrR0u9JB2TwF6TOlQ5xS59G2U6sheMFc3EYSi0cFHRUFlrWFckwmi9qH/QNDsmS
         p1kczFgdegZuv81UJAfeKti6Y+opaSbsyn4t+QZrZxP3gcJcDeTmpuQtou+ShK0ubLD3
         5TFWMpSwasGybrH4IdHkO69i6OWlGHCo20MyE9F+JZzXNZ6Ds9ViMM8FFL+xukKuVLK+
         LY3TC3+gm2+xqiV3RorDHGaqhflelmenm4EvSvc3MI+LlzCkZbyz1Yb/JlT+mN4u4rJ9
         05vg==
X-Gm-Message-State: AOAM531G4MUvi+yLXAFmpyc23h4wIIKFlsVzp3sLXg142t25aj/e/UYA
        QSqqXbORugSVZIDusy0BckPJc6XZP0Y=
X-Google-Smtp-Source: ABdhPJyEq4dlurqZcauPvJm3PUgKn/8xoBC7guHCyyZ0E4zdvXaFsCGYNGbwXCg5nG8sg24a4DMm8g==
X-Received: by 2002:a7b:c1cf:: with SMTP id a15mr1612637wmj.163.1635287731466;
        Tue, 26 Oct 2021 15:35:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t12sm1809739wmq.44.2021.10.26.15.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:35:31 -0700 (PDT)
Message-Id: <pull.1067.git.1635287730.gitgitgadget@gmail.com>
From:   "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Oct 2021 22:35:28 +0000
Subject: [PATCH 0/2] tmp-objdir: fix regressions in core.fsyncobjectfiles=batch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 * Fix prune code to be able to work against multiple cruft directories. I
   noticed this in self-review.

 * When dscho enabled core.fsyncobjectfiles=batch in git-for-windows we saw
   some test-failures in update-index tests. The root cause is that
   setup_work_tree does a chdir_notify, which erases the tmp-objdir state. I
   now unapply and reapply the tmp-objdir around setup_git_env.

This branch autosquashes cleanly and it needs to be merged with
ns/batched-fsync, where it currently merges cleanly.

Neeraj Singh (2):
  fixup! tmp-objdir: new API for creating temporary writable databases
  fixup! tmp-objdir: new API for creating temporary writable databases

 builtin/prune.c |  1 +
 environment.c   |  5 +++++
 tmp-objdir.c    | 25 +++++++++++++++++++++++++
 tmp-objdir.h    | 15 +++++++++++++++
 4 files changed, 46 insertions(+)


base-commit: 50741b157f2f90df76a60418e2781b2c1e6e3c78
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1067%2Fneerajsi-msft%2Fns%2Ftmp-objdir-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1067/neerajsi-msft/ns/tmp-objdir-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1067
-- 
gitgitgadget
