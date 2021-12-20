Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CB4C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhLTP52 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbhLTP51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:57:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDCDC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:27 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v11so20993129wrw.10
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 07:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cnqihFNTIOQB7NXRy4qc1hNzBMBt+YGjJ+eutSZhwmQ=;
        b=YAqbefdvY3h/ol2pCyIQ7iLgSLKHFnW2017x5aZGHPWk/7P0eem7BlN4EgMoMuU1kr
         x1tC3eUJPA7NonlnMM58GxKz+HqJhSpKKZraPlySjTgjdrEL+fh74UmSPInPCZJRyEWE
         zRZOkzIuiyKMAaNzc4JQRQAPCQZOYw5H5Ehw4eKIOekdhfsLVdWtbr5/rA0MnKKgAExT
         yK4ZI4nrW0rBRDkbNt9/kC8Ni9yeSVjqoDyByF5oK7n5d6x1f+p1vWHp6TiM7BTSeGcK
         5knYwiBIk5oblEt7hEe694GVTUvk4rUf2sNsy/CLqflnpNFHslEM1erPkKHboJq8frPy
         +IPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cnqihFNTIOQB7NXRy4qc1hNzBMBt+YGjJ+eutSZhwmQ=;
        b=3dREtYxowxZ82licc1eaZ3PNJdG7UEZcFVX66iLU6WwlCQ7wSZH6XypAU2gOEiANg5
         HgmiUqD75u6rNoipV3vliRb4NtBqS/t1PS1JFDA9OEVP5zrUNoeeLOa0eJxDtwK+Ku6D
         1KmGTMvyLZwSnf9gxYutygQktmrXjq2nQonQYerXSFQ/RgdNlRNVoF4q6xmLmlZAsKhi
         bs5Rcy8TA7k00/Ow4oXfa+0JIv4bzsYXBY2Hjj6TiUbrqp/TiWU+Jq+V7xKezI5hd70K
         g+v1/XT9jvZEK5Pt8xLyDhq7rNCBME8apzr103woZN6O+3Ts2xbzeQkcWXblHouerSxd
         W+YQ==
X-Gm-Message-State: AOAM533u8qejzpm8p93hcJmMPbGy11qyYBWYdRvHIJbL61FbylaAA69P
        sg3QXhDK53svEY4JPyaXvKZh64i3nCE=
X-Google-Smtp-Source: ABdhPJy8A5uJkxndEwvBpl3m+XFHbGBFC2ggxmmiyR+aenOphAJS0GIfekcfeA60EdwZxV55TOeFSg==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr13480234wrx.411.1640015845769;
        Mon, 20 Dec 2021 07:57:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q206sm12075581wme.8.2021.12.20.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 07:57:25 -0800 (PST)
Message-Id: <pull.1101.git.1640015844.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 15:57:20 +0000
Subject: [PATCH 0/4] Sparse checkout: fix bug with worktree of bare repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, sunshine@sunshineco.com, allred.sean@gmail.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series includes a fix to the bug reported by Sean Allred [1] and
diagnosed by Eric Sunshine [2].

The root cause is that 'git sparse-checkout init' writes to the worktree
config without checking that core.bare might need to be set. This only
matters when the base repository is bare, since creating the config.worktree
file and enabling extensions.worktreeConfig will cause Git to treat the base
repo's core.bare=false as important for this worktree.

This series fixes this, but also puts in place some helpers to prevent this
from happening in the future. While here, some of the config paths are
modified to take a repository struct.

The critical bits are in Patches 3 and 4 which introduce the helper and then
consume it in builtin/sparse-checkout.c and sparse-index.c.

[1]
https://lore.kernel.org/git/CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com/
[2]
https://lore.kernel.org/git/CAPig+cQ6U_yFw-X2OWrizB1rbCvc4bNxuSzKFzmoLNnm0GH8Eg@mail.gmail.com/

Thanks, -Stolee

Derrick Stolee (4):
  setup: use a repository when upgrading format
  config: make some helpers repo-aware
  config: add repo_config_set_worktree_gently()
  sparse-checkout: use repo_config_set_worktree_gently()

 builtin/sparse-checkout.c          | 25 +++++--------
 config.c                           | 56 ++++++++++++++++++++++++++++--
 config.h                           | 13 +++++++
 list-objects-filter-options.c      |  2 +-
 repository.h                       |  2 +-
 setup.c                            |  6 ++--
 sparse-index.c                     | 10 ++----
 t/t1091-sparse-checkout-builtin.sh | 14 +++++++-
 8 files changed, 95 insertions(+), 33 deletions(-)


base-commit: 69a9c10c95e28df457e33b3c7400b16caf2e2962
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1101%2Fderrickstolee%2Fsparse-checkout%2Fbare-worktree-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1101/derrickstolee/sparse-checkout/bare-worktree-bug-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1101
-- 
gitgitgadget
