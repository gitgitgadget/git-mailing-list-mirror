Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109EDC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E1160F9C
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 15:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbhHCPfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236892AbhHCPfh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 11:35:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E92C061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 08:35:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u15so12733288wmj.1
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TFkoGChZTjaqXGTLRODDmxjfKhdkm3fm6GvBXiaNK2I=;
        b=ReFrXuxJGQGT9QW5SquanrE6hKHSRRC+Qg7qJZ2an7R7ZlJoJml1LMgbyOLrE4HRod
         BIjWsvBKpBpOSrM5kKKHMETJpokEYI4J+q+EmjZmmd6x0oqx2q3bfMFlkGYp13FUZg8C
         O1tnA/pDwEi2ybVnv9IWtq7+PV5/kAJWnLWjCgwkwUcLeC76ExQqy5hdno5J0F4o+z/Z
         MoRg70ns1voB6QMJvhEMkWM8P41QUkUY36orc2EBC5WpV8BsoztXmm+E7U5EF4ROPy3E
         rz55dSMK2NBw1gre8BdfGpjFMCC0P8KzknMZAl2ZEfwGIHK4aKID2ayAak/3mufv0KRl
         7FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TFkoGChZTjaqXGTLRODDmxjfKhdkm3fm6GvBXiaNK2I=;
        b=bZReXaGCcMBEFPN0XamL/KdVKdO5LJGNGDjLk9VL7Wje8OtyZcoECZopX/q9IQEgWN
         hc8rPj3/ZMSfL+TjHdtibq3JIq3qNeBmb0yQ44VGjoij7F2Z/3RLIN6KQPo0XxQbycbW
         S4QfbUXf2R9QdSaj226phmHy2inRa0TiuOcR2Yoacyg8yZ6pmUrRvQOtqULgP6VmzUJd
         o43uh0jJoMEHyCrLudZTv6UWY25e8GuloJqbj9rrbmq5tlUXersN2iLPHrVRDrm+aF2s
         nZrb5UeegdpyVQ+wq/a1aF8a9hFo9gd0f0GAvfWyPAKV4GOKfxRzTpUsSIsCq7fRjkl3
         AzlQ==
X-Gm-Message-State: AOAM530JSrkrDBSQdzyN6Z07aKYr5xZhBp0Goxmg0ke9KXLesnXS6T9N
        4lxW2/DMPMUevSdWpwBu8E+J48dZkew=
X-Google-Smtp-Source: ABdhPJw9LG+SV170iw9F9U7T3YbIX8fNupOeL1g7p3LTlYoQOl0SLyv+eQGzpC37TpTieyaiepulGg==
X-Received: by 2002:a05:600c:2dd0:: with SMTP id e16mr22924661wmh.113.1628004922608;
        Tue, 03 Aug 2021 08:35:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i29sm13768376wmb.20.2021.08.03.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 08:35:21 -0700 (PDT)
Message-Id: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 03 Aug 2021 15:35:10 +0000
Subject: [PATCH 00/10] Documentation updates: merge-strategies
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I noticed while updating my switch-default-merge-strategy-to-ort submission,
that many of the changes were good documentation updates that we might want
for Git v2.33.0. So I pulled those changes out and split them into lots of
little commits so that if any parts need discussion or are objectionable, we
can just drop those from this series and apply the rest for v2.33.0.

The first 9 commits are just small documentation updates, but there is one
commit at the end that updates an error message and a code comment.

Elijah Newren (10):
  git-rebase.txt: correct antiquated claims about --rebase-merges
  directory-rename-detection.txt: small updates due to merge-ort
    optimizations
  Documentation: edit awkward references to `git merge-recursive`
  merge-strategies.txt: update wording for the resolve strategy
  merge-strategies.txt: do not imply using copy detection is desired
  merge-strategies.txt: avoid giving special preference to patience
    algorithm
  merge-strategies.txt: explain why no-renames might be useful
  merge-strategies.txt: fix simple capitalization error
  Documentation: add coverage of the `ort` merge strategy
  Update error message and code comment

 Documentation/git-rebase.txt                  | 29 ++++++----
 Documentation/merge-options.txt               |  4 +-
 Documentation/merge-strategies.txt            | 56 +++++++++++--------
 .../technical/directory-rename-detection.txt  | 14 +++--
 builtin/merge.c                               |  2 +-
 sequencer.c                                   |  2 +-
 6 files changed, 63 insertions(+), 44 deletions(-)


base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1059%2Fnewren%2Fort-doc-updates-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1059/newren/ort-doc-updates-v1
Pull-Request: https://github.com/git/git/pull/1059
-- 
gitgitgadget
