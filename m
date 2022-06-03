Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC06C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbiFCNh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 09:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiFCNh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 09:37:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5811820
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 06:37:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r129so4106552wmr.3
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=oyORqSxHe4hhfKmm3m7xn02p7TCI9TNWlAQ0Vfz4W/o=;
        b=HrPm7R0XNe8/1AWjiKausEFvHvb+PAvxHy8xoT4EeXlFCFGNw4sanebQfNyarTj2hZ
         51oZLkw/+KeMrnkLgTjQL4HC7FM7PnVd66CyC8Q4mr7NPQuQZQrk4M9wKLPJNIM5ynFG
         Je3R3wpvAsn5cUgh5IEVZOcVX11h9CWmu/aSralHy4ihY2uIJMUbViffDI3xgnLjSiMi
         1RMycQKQAbtwiCEm9oZFYgUz8PutKUJLxS4uSE14drNHc6i9ofQJisg+QfIlbJMyds2q
         FKqIUSbmhFJLfiUj+lAMayWQNZwkBfihJDdCdTZX3hvBAK+dBxVEWhBBZduF4q5lBSQr
         U2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oyORqSxHe4hhfKmm3m7xn02p7TCI9TNWlAQ0Vfz4W/o=;
        b=znjzEt4kKOIamx4UXaq2oWah6881jEdTSGUm1xCHZ0VZNA6AZpPDFz9L993okTHx3M
         03aGGusYR9IHk6rMGwrP+cvz4FHGZ04bSBMECIa9Bi7/MoYnkIJaj2/2z+s//cte+SHr
         cekMIvH8Ck/RQAJbMFjoR9THGpulvS4wDASAUA3Fm0FCbmaHfaCUurSekb3KD+bxH08M
         sVnVfLfVVm6L152s94JFEQT7XJjk9EdFm0c/YPfl4xROyrkZnMkTcEeXk5l0xuxXiMCM
         TSKM5ZJefA0tbLvhez/pcR3H8sx1XvqXOuvKJQJ4z2klwq8eXOyEzCi0xueCacxPmhJz
         L/Bw==
X-Gm-Message-State: AOAM532alTDx35FcWIz8KjqJIvoW63M3PLVm/5odccwPVFVHJWG1ht9F
        FqIB9GHvW6BdNVZ0e8vlLEP5GOUOC8XhCod6
X-Google-Smtp-Source: ABdhPJwwK3CxIIIhIStJzC73uSg/ajyZSCBDiRxqsU9BfBW7rngllogmIYUhhfPWPIJ9a2yptAiVbg==
X-Received: by 2002:a7b:cd17:0:b0:397:82ce:b2d8 with SMTP id f23-20020a7bcd17000000b0039782ceb2d8mr8947991wmj.20.1654263474145;
        Fri, 03 Jun 2022 06:37:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b00213b93cff5fsm2846591wri.98.2022.06.03.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 06:37:53 -0700 (PDT)
Message-Id: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jun 2022 13:37:48 +0000
Subject: [PATCH 0/4] rebase: update branches in multi-part topic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a feature I've wanted for quite a while. When working on the sparse
index topic, I created a long RFC that actually broke into three topics for
full review upstream. These topics were sequential, so any feedback on an
earlier one required updates to the later ones. I would work on the full
feature and use interactive rebase to update the full list of commits.
However, I would need to update the branches pointing to those sub-topics.

This series adds a new --update-refs option to 'git rebase' (along with a
rebase.updateRefs config option) that adds 'git update-ref' commands into
the TODO list. This is powered by the commit decoration machinery.

As an example, here is my in-progress bundle URI RFC split into subtopics as
they appear during the TODO list of a git rebase -i --update-refs:

pick 2d966282ff3 docs: document bundle URI standard
pick 31396e9171a remote-curl: add 'get' capability
pick 54c6ab70f67 bundle-uri: create basic file-copy logic
pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
pick 6adaf842684 fetch: add --bundle-uri option
pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
exec git update-ref refs/heads/bundle-redo/fetch HEAD 6c5840ed77e1bc41c1fe6fb7c894ceede1b8d730

pick 1e3f6546632 clone: add --bundle-uri option
pick 9e4a6fe9b68 clone: --bundle-uri cannot be combined with --depth
exec git update-ref refs/heads/bundle-redo/clone HEAD 9e4a6fe9b68a8455b427c9ac8cdbff30c96653b4

pick 5451cb6599c bundle-uri: create bundle_list struct and helpers
pick 3029c3aca15 bundle-uri: create base key-value pair parsing
pick a8b2de79ce8 bundle-uri: create "key=value" line parsing
pick 92625a47673 bundle-uri: unit test "key=value" parsing
pick a8616af4dc2 bundle-uri: limit recursion depth for bundle lists
pick 9d6809a8d53 bundle-uri: parse bundle list in config format
pick 287a732b54c bundle-uri: fetch a list of bundles
exec git update-ref refs/heads/bundle-redo/list HEAD 287a732b54c4d95e7f410b3b36ef90d8a19cd346

pick b09f8226185 protocol v2: add server-side "bundle-uri" skeleton
pick 520204dcd1c bundle-uri client: add minimal NOOP client
pick 62e8b457b48 bundle-uri client: add "git ls-remote-bundle-uri"
pick 00eae925043 bundle-uri: serve URI advertisement from bundle.* config
pick 4277440a250 bundle-uri client: add boolean transfer.bundleURI setting
pick caf4599a81d bundle-uri: allow relative URLs in bundle lists
pick df255000b7e bundle-uri: download bundles from an advertised list
pick d71beabf199 clone: unbundle the advertised bundles
pick c9578391976 t5601: basic bundle URI tests
# Ref refs/heads/bundle-redo/rfc-3 checked out at '/home/stolee/_git/git-bundles'

exec git update-ref refs/heads/bundle-redo/advertise HEAD c9578391976ab9899c4e4f9b5fa2827650097305


The first two patches are helpers that are needed, but the full logic of the
--update-refs option is introduced in patch 3. The config option is
available in patch 4.

Thanks, -Stolee

Derrick Stolee (4):
  log-tree: create for_each_decoration()
  branch: add branch_checked_out() helper
  rebase: add --update-refs option
  rebase: add rebase.updateRefs config option

 Documentation/config/rebase.txt |   3 +
 Documentation/git-rebase.txt    |  11 ++++
 branch.c                        |  24 ++++---
 branch.h                        |   8 +++
 builtin/rebase.c                |  10 +++
 log-tree.c                      | 111 ++++++++++++++++++++++----------
 log-tree.h                      |   4 ++
 sequencer.c                     |  99 ++++++++++++++++++++++++++++
 sequencer.h                     |   1 +
 t/t3404-rebase-interactive.sh   |  34 ++++++++++
 10 files changed, 262 insertions(+), 43 deletions(-)


base-commit: 2668e3608e47494f2f10ef2b6e69f08a84816bcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1247%2Fderrickstolee%2Frebase-keep-decorations-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1247/derrickstolee/rebase-keep-decorations-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1247
-- 
gitgitgadget
