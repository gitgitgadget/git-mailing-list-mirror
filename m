Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2E9C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AED161A6F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353260AbhJAKGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238647AbhJAKGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297DC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d21so14571166wra.12
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=W3cuMXWP8vZeDhtxXecjvrevYTjik9fGzDGbu54MnS0=;
        b=PaUH6RY08p8G1G9tUDTOZc0DYZJ1epwEzkH8wLEMxRruZA1MY606au/41J4d8GuYYU
         VMB0/2ixmWxq2ZKqkPjrerhpnddMWt5en8To/WXRdJG1MD2kQKuHhFJfxcdnltyPBtqt
         v1pyfrwlmjLetl5Y1NZZ4xxVHH1t7X95R9R/rzD8/ad9A1jbmoJHYh8P4scqB0herTEX
         R+fyM60QRKACOFNG0UDPi2/aJWwSODile8T87Bfpc7FE3SBV/cEAt2XdgU+7FnRcIZ3v
         0BMgSqDbVoGHZqNVQ6OPT9CgcG7m2p+lIRzExuCjIXkuBy2u61WpbRKcgKPYdyIhQ05i
         Mxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W3cuMXWP8vZeDhtxXecjvrevYTjik9fGzDGbu54MnS0=;
        b=ORl7TfYaw2QSLTBzebmrU9v5n0FtWL2/DBWf/KUp2lmPaskXfeSO1I88gAGwobKmm6
         7dtwQYD7k3LzwjPZHGxQ9SYh/xr2xs9qtV6DbZlncEnn87Q09t9Xt268jCOB4XrOfNzN
         OKZlORk1ZVxMnzA0n/j5Op4mZqB28mHmxOEP+6HA8cHaWk4jCHpwAzkcnXzRNchAvTtU
         YWhaBU89G3KlfbhVVQPiRQqgIuYO4f/KVDbLkxB2sGry6JllhN0qoOZiBsb9eqdFl5GX
         egb2XB0V1FG7ZaREcsn3tz409Mey6pkIbT3mYgKrxtGiy8qovpeqHv7wPRfPYdZeb0JC
         icMw==
X-Gm-Message-State: AOAM533xA5tvmOFYzQeRiVWKK65r9jggF3d07TFr6uxinCmMeMww+Qqw
        9fxNI+qN35U7hjHQfuKdsaf79/Mv/hA=
X-Google-Smtp-Source: ABdhPJyoFCOIz1QzPArTqp6Ps4XajlpejVevam+Sh5TubDcJwk91SCCNRg5kNjF37XF/Nck8FUxHTw==
X-Received: by 2002:a5d:6d81:: with SMTP id l1mr11393010wrs.404.1633082704002;
        Fri, 01 Oct 2021 03:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c4sm5303743wrt.23.2021.10.01.03.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:03 -0700 (PDT)
Message-Id: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:51 +0000
Subject: [PATCH 00/11] rebase: reset_head() related fixes and improvements
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix some issues with the implementation and use of reset_head(). The last
patch was previously posted as [1], I have updated the commit message and
rebased it onto the fixes in this series. There are a couple of small
conflicts merging this into seen, I think they should be easy to resolve (in
rebase.c take both sides in reset.c take the changed lines from each side).
These patches are based on pw/rebase-of-a-tag-fix

[1]
https://lore.kernel.org/git/39ad40c9297531a2d42b7263a1d41b1ecbc23c0a.1631108472.git.gitgitgadget@gmail.com/

Phillip Wood (11):
  rebase: factor out checkout for up to date branch
  reset_head(): fix checkout
  reset_head(): don't run checkout hook if there is an error
  reset_head(): remove action parameter
  reset_head(): factor out ref updates
  reset_head(): make default_reflog_action optional
  rebase: cleanup reset_head() calls
  reset_head(): take struct rebase_head_opts
  rebase --apply: fix reflog
  rebase --apply: set ORIG_HEAD correctly
  rebase -m: don't fork git checkout

 builtin/merge.c            |   6 +-
 builtin/rebase.c           |  97 +++++++++++++++----------
 reset.c                    | 143 ++++++++++++++++++++++---------------
 reset.h                    |  33 +++++++--
 sequencer.c                |  48 ++++---------
 sequencer.h                |   3 +-
 t/t3406-rebase-message.sh  |  23 ++++++
 t/t3418-rebase-continue.sh |  26 +++++++
 8 files changed, 240 insertions(+), 139 deletions(-)


base-commit: 7740ac691d8e7f1bed67bcbdb1ee5c5c618f7373
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1049%2Fphillipwood%2Fwip%2Frebase-reset-head-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1049/phillipwood/wip/rebase-reset-head-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1049
-- 
gitgitgadget
