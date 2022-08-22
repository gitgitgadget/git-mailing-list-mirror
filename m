Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E736C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiHVS0r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiHVS0q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:26:46 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE24481FB
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:26:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h24so14263414wrb.8
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=4OktAaZWTbDseVqOz8sx0GQZCxb9KbfC/1ngWB+12B0=;
        b=NXTjNlVnEi8koc2gJdT30kq8ZooThiLjeq8fTGGWhaZJ6YS2lpzlOFDQQaoLfXoGO5
         Q/BGPqm4Po0k5FVOqQXyHk3Xp/9OuZc81W0qG6HvS1hTgDDczKiDpMPJkrxqMDwR35Bs
         U02qt8S/QzB36QBzmxMTgJHrvAd4QCcNSqxFyILM7Td7M57rt160Ehj935xK0uSq/JHo
         8yu6h7hef85wqgYjfVk1ppWEOiuG9qq7nMVQP3XMpdOT42IZGCz2BwMtsrxkss3d3JvO
         3pvXpDXVWovdsiqpdVD8NdYFEKsDu0mpAd8F6CYk3mqIOeICH/Et3MzkVBdgIkbtRdxS
         DPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=4OktAaZWTbDseVqOz8sx0GQZCxb9KbfC/1ngWB+12B0=;
        b=2HgxFxzoG9eybjaTsjkaaDYMoIW+pgsRwaoyutr7cPRrCIr1QoRv+iFrZunjI28v3U
         PYdKh1Dm3/0B8ZxhKP+sfnTk7Q9ka0Bygzdt7QNAqhUzMoPBCoJsW/h+Oeef4pXq3fWS
         rcl4ZLNyTiHLXzGm1gAdKJEV+9S/yn9xqXUNZhe9nsOuoKvXuoovBlb8NFkwG9DvjhtF
         YtI6aVvBMyUrBFFNVS30JiCm7XnSyCc97NbUt6i43c8nFmQN7idBdu7Hh7+TqPD57xDF
         TVQ5P2oIY1CZOxBMYh17wyczL79ZQ+TVBLO2UZnw+5XqfIhr1kq5LAwyeFBU5a9EfGu5
         UiVQ==
X-Gm-Message-State: ACgBeo0sP7Fc0kdcYiezDWGvDng3p5C0emjL6h34SND88UVaHeSU+h2D
        ACeDrWZ8W2h8zjJ3s2WgFJxJSZIRIss=
X-Google-Smtp-Source: AA6agR50/BAPQw4iyU9oM0C0GNfQjU2k4KA42xAZnqA/jMMQA6vpaTgoOJ6dsAkGE0VJFMeZNNocEA==
X-Received: by 2002:a5d:4610:0:b0:225:294e:7c1d with SMTP id t16-20020a5d4610000000b00225294e7c1dmr11191885wrq.386.1661192803736;
        Mon, 22 Aug 2022 11:26:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdb92000000b0021eaf4138aesm14910028wri.108.2022.08.22.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:26:43 -0700 (PDT)
Message-Id: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 18:26:39 +0000
Subject: [PATCH 0/3] tests: fix broken &&-chains & abort loops on error
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes some broken &&-chains in tests and adds missing || return
1 (or || exit 1) to loops to ensure they exit early upon error. It is a
followup to an earlier series which fixed many more such problems.^1
[https://lore.kernel.org/git/20211209051115.52629-1-sunshine@sunshineco.com/]

Eric Sunshine (3):
  t2407: fix broken &&-chains in compound statement
  t1092: fix buggy sparse "blame" test
  t: detect and signal failure within loop

 t/perf/p7527-builtin-fsmonitor.sh        |  2 +-
 t/t1092-sparse-checkout-compatibility.sh | 10 +++++-----
 t/t2407-worktree-heads.sh                |  4 ++--
 t/t5329-pack-objects-cruft.sh            |  8 ++++----
 t/t6429-merge-sequence-rename-caching.sh |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1312%2Fsunshineco%2Fchainmore-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1312/sunshineco/chainmore-v1
Pull-Request: https://github.com/git/git/pull/1312
-- 
gitgitgadget
