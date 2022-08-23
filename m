Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D110C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 16:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244387AbiHWQOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiHWQOc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 12:14:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24783102F11
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 05:35:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d16so11542438wrr.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 05:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=CxmyIFc4jN9ehikIjIbyLlAYACRVwzW7D0xZIWQNLVQ=;
        b=NJqMCrzsXaT0yTNyhmQgYnOZV+/zZIaj2mSe4U2YGVL3fvJ2lEumXuhvyxop/PrzW0
         hla/9tO5P2sxK+ZjuLtLQhsBdVcV5UEKAZxOfsGtCKtgb/t15y7K+eqXYjb1EIlwQBXR
         Vd4Y+mYMuO27xaiJGAMhTq3XACIf3Ilsy3kjq8JJ2AlXYWMmyY6PAvd/gmizQZtY+Ctr
         9HWTBry8KT9IkRIPsrm0b9qs4KkSjozWAXfsBguQ3H0gKsXSP9VRqtFOi92gCKR7cYOL
         s4ALw/7fLe8pflOuWlRoLOCf8Q2b2qTHHAgTpSUg24Zo7aT1a5VEvSedBbD48Gc0uFkA
         RfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=CxmyIFc4jN9ehikIjIbyLlAYACRVwzW7D0xZIWQNLVQ=;
        b=IZ3kjKlnid56Bh2NQClP5BJYvw2VOqSxibK6/AiAz1kOp7jiWgfigk7bmWR/iyBb45
         r2ZHc9IxYIasYIcDRF2Fmc5E2p1f7S1ENESdiA89FT5jDhyW6wgpaEA8Lc4d/Bt0B4tn
         bzaZkP1VcbIxKwjsI0+uF+95E1Lt7XFP77eKL20jenbhfTiy0ZD29I8ALKUp1AzI5u07
         mYDnpuaGKUAQ6lVyu3AJ1/kj7EWcw4ByeKkL1aY8cttkhNtPBj3b32ilCJ1MKOSABq5L
         ftqiYvFkbNdcoTtjewVxEF0o/lGOjTN83xbkWPMBEKcZT8x0gEVyAuSjW98ugVNBPZj3
         TFRg==
X-Gm-Message-State: ACgBeo3aAW9ysopreHbjgXn6saW+dsAIVjoUvygBaeNLVvL7dZ1w3RSU
        3fpvEMtR2R7Rv7qj+QZf6CPmgbbMEzA=
X-Google-Smtp-Source: AA6agR6hWupRAswjzjmDza+NBAyd/3lqciM9IMIvqYgLt/q/g82CRTP8MD4xO8yfHZ6kPM/C8sXuTg==
X-Received: by 2002:a5d:5a9b:0:b0:225:3fa0:f9ca with SMTP id bp27-20020a5d5a9b000000b002253fa0f9camr9624392wrb.204.1661258123397;
        Tue, 23 Aug 2022 05:35:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c384900b003a35ec4bf4fsm18075977wmr.20.2022.08.23.05.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 05:35:23 -0700 (PDT)
Message-Id: <pull.1335.git.1661258122.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 12:35:20 +0000
Subject: [PATCH 0/2] Allow passing pathspecs to git range-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just had the need to find out upstream commits corresponding to a handful
of backported commits, and most importantly, identify upstream commits
touching a given file that had not yet been backported.

This new mode helped me identify them.

Johannes Schindelin (2):
  range-diff: reorder argument handling
  range-diff: optionally accept a pathspec

 Documentation/git-range-diff.txt |  4 +++
 builtin/range-diff.c             | 54 ++++++++++++++++++++++++--------
 range-diff.c                     |  2 +-
 t/t3206-range-diff.sh            | 11 +++++++
 4 files changed, 57 insertions(+), 14 deletions(-)


base-commit: 795ea8776befc95ea2becd8020c7a284677b4161
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1335%2Fdscho%2Frange-diff-with-pathspec-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1335/dscho/range-diff-with-pathspec-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1335
-- 
gitgitgadget
