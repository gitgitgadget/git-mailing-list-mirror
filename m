Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DB8C433E0
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56AB5233E2
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 16:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391665AbhATQ5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403811AbhATQym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 11:54:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E50C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:02 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 190so3451152wmz.0
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=IXHpEZ/cnLFKqfOzfL5929rICwNWAlSj+NiRYrA+gPU=;
        b=JBqR5PIDVTQM2fNdqnT45IeSISL/y3rOlIuu+Wfz6FHXHh59HeeHWodq98paAjMI14
         VkH39uY9qPHpc7/tmlBGR6U5BngnZM1Gymv4Il8YT5gZnm5Ch7cTS4p0AwIqqe5jiZZJ
         iqJ85Khm8Rju/SDWWHc2vDmi+poYe5mXR1CezMIMo0nNtDLn2mfi6a6wqZKjXkD/YuNb
         UW2AFhihvdCnu7AqCSmEiz4BR3uRCcJ6tEtqrq+uPKpIRV/rzK9ya6zEd8CQmmLgwQo/
         v1BU6AknT13rlgasrwiV2hfOWRQ6AgL3S2qLfHL0ON+S6CNtU68NmwmQC7ur2ZX7c3+S
         F66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IXHpEZ/cnLFKqfOzfL5929rICwNWAlSj+NiRYrA+gPU=;
        b=JyxO/QulYRFdGfgcy9SGb0SLp0PeQsbVEx54amqgJ3BnO0A1cg0EpV3T/P71luVwTW
         IsRRiIZoih1zkRZst1vUx0B/B/EQAbEJ8VRARf8B4OLNezkcp1AaquWoDdT0Nw/ppnzE
         /HjGkZwp4KKuCQDzgpSaVPXgeAfUOnAOROtLAr6cj4yyV8ROxuz61aYxIM8/PirHMiez
         P+w/u4y/vnfhjNb+b5yDBWa2ZdLOzUwf2FbsVSCVZZTdcdpiLByUelRxz2W4M7Fyp3Pd
         JXJfYTUcPr4QzO2Fz+3zKewFMbIDgDcM7VdC3lH6rk0se1RDkSzB5Gpa9v7tfoG/PQ2/
         HJ0w==
X-Gm-Message-State: AOAM5320VzM9QJZW1fQWI4NaA6oOo7Fbs7ShL175m33l1qE8erA0JKd2
        7vMshFWP5+tJ5ShoDi0OFuNacnMfukg=
X-Google-Smtp-Source: ABdhPJySBDpCR6jYYvCzmtXn6cDVnix/tIeBqIOyDczerraeKMIHP07oOhzNWsi76OS3s305uXgIvw==
X-Received: by 2002:a7b:c196:: with SMTP id y22mr5297152wmi.91.1611161641043;
        Wed, 20 Jan 2021 08:54:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm5226837wmb.14.2021.01.20.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:54:00 -0800 (PST)
Message-Id: <pull.839.git.1611161639.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jan 2021 16:53:50 +0000
Subject: [PATCH 0/9] More index cleanups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ds/cache-tree-basics.

Here are a few more cleanups that are vaguely related to the index. I
discovered these while preparing my sparse-index RFC that I intend to send
early next week.

The biggest patch is the final one, which creates a test script for
comparing sparse-checkouts to full checkouts. There are some commands that
do not behave similarly. This script will be the backbone of my testing
strategy for the sparse-index by adding a new mode to compare
sparse-checkouts with the two index types (full and sparse).

Thanks, -Stolee

Derrick Stolee (9):
  cache-tree: clean up cache_tree_update()
  cache-tree: extract subtree_pos()
  fsmonitor: de-duplicate BUG()s around dirty bits
  repository: add repo reference to index_state
  name-hash: use trace2 regions for init
  sparse-checkout: load sparse-checkout patterns
  sparse-checkout: hold pattern list in index
  test-lib: test_region looks for trace2 regions
  t1092: test interesting sparse-checkout scenarios

 builtin/sparse-checkout.c                |  22 +-
 cache-tree.c                             |  20 +-
 cache-tree.h                             |   2 +
 cache.h                                  |   3 +
 dir.c                                    |  17 ++
 dir.h                                    |   2 +
 fsmonitor.c                              |  27 +-
 name-hash.c                              |   3 +
 repository.c                             |   4 +
 t/t0500-progress-display.sh              |   3 +-
 t/t1092-sparse-checkout-compatibility.sh | 323 +++++++++++++++++++++++
 t/test-lib-functions.sh                  |  40 +++
 unpack-trees.c                           |   6 +-
 13 files changed, 431 insertions(+), 41 deletions(-)
 create mode 100755 t/t1092-sparse-checkout-compatibility.sh


base-commit: a4b6d202caad83c6dc29abe9b17e53a1b3fb54a0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-839%2Fderrickstolee%2Fmore-index-cleanups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-839/derrickstolee/more-index-cleanups-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/839
-- 
gitgitgadget
