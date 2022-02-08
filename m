Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094DDC433FE
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386358AbiBHWZS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386332AbiBHUJt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 15:09:49 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A7C0613CB
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 12:09:48 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k1so339023wrd.8
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 12:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=RmjVCgJjoZL8H97Rh/Ja3+Jod5QLmJ3Z1ZQvmqVb+FE=;
        b=OyBLLQa5qIoNltk/7oxPIjKcZNYhbYEArgVL1PUBhXCnI/ZzQQRUOdCK5hiJhJ5pZN
         7vCfPr6qI/pOP3tdPiWr8DJqGKQLjkCPOqU3CEdgBYCDktgd6sq3S8CqvcLuNrc2Sb0t
         YOzdTP83OJ/8nJulJokKSoKFXsoE2zkCS3puEursr1MYqfXv8y5cAkCsYwu1IWrzTtEG
         JOxQJVc8s3iSQZuEH8s3OL0EzJrH0U7A0ZJ6fN4sqTcd57kGWvRMmUVZl5XrO0EwYnCb
         oA+pmo/ZOb864sCeeypcqRs2QfIb2x6hVlVtIgYWImQ+ckEIQ6LbOTM2+DHvWIqhpkgW
         IvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RmjVCgJjoZL8H97Rh/Ja3+Jod5QLmJ3Z1ZQvmqVb+FE=;
        b=h9wf/vINsEfyTwDDdKMgoA85w0wBybEMSvt4RHxW2Wwuki3saJ7GiJsZvhhP7UCV/l
         WOasuPqa3U8ZloseiSvFjshfCN4E4F/Y9GU4IGnLfW//zZBxMyumez8czDt7UIF5iFaN
         r2iEU9QuNsVIM7Qr+kPd15bRyCCsjBpIv+UKGgMOoEFXK3FmCPnEeM+kT67TJuItcptg
         jfaaJinAf3T2HIhjVGnDIOmS95Uqxp62XaT628aYUt7BaklMyzYbTpYZtK1QuvuebP0I
         Vv186bO0Lpy7MiKKo31BPMvp6cKFWtv/eeowAWgi4m9e9c9spV/749msHUx7ZWcQo3/g
         fLTA==
X-Gm-Message-State: AOAM532G0HG1WpOgMw+55gnfgw1iSbHoNOtJqpxjChFfvjtqWt2wnwRM
        Atn77VTlO3e6NUDVSWaWjXi0oZ45Yxc=
X-Google-Smtp-Source: ABdhPJy06Kv1gdQhOwicTZKzlJY2c2zPj2FdIheDq+gYTLBVv4XVbcc4FxoaEvbbRgcJ7iX9O6niWQ==
X-Received: by 2002:adf:d849:: with SMTP id k9mr4714389wrl.366.1644350986646;
        Tue, 08 Feb 2022 12:09:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o125sm458311wme.37.2022.02.08.12.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:09:46 -0800 (PST)
Message-Id: <pull.1214.git.git.1644350985.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Feb 2022 20:09:43 +0000
Subject: [PATCH 0/2] Prepare (auto)stash for reftable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stashes are stored as hex OIDs in files under .git/ but are accessed as
refs.

This series consistently treats stashes (AUTOMERGE_STASH,
rebase-merge/autostash etc.) as refs.

Han-Wen Nienhuys (2):
  t3420: prepare for reftable
  Treat MERGE_AUTOSTASH and friends as a pseudoref

 branch.c                    |  2 +-
 builtin/commit.c            |  2 +-
 builtin/merge.c             | 29 +++++++++++------------
 builtin/rebase.c            | 34 ++++++++++++++++++++++-----
 path.c                      |  1 -
 path.h                      |  3 +--
 sequencer.c                 | 46 +++++++++++++++++--------------------
 t/t3420-rebase-autostash.sh | 31 +++++++++++++------------
 8 files changed, 82 insertions(+), 66 deletions(-)


base-commit: a9cd6a0c5981a7d3c9865cf1966243c82f93e58e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1214%2Fhanwen%2Freftable-stash-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1214/hanwen/reftable-stash-v1
Pull-Request: https://github.com/git/git/pull/1214
-- 
gitgitgadget
