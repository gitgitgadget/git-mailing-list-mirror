Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70250C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 00:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbhLAAIc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 19:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbhLAAIb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 19:08:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5778C061574
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 16:05:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s13so48169966wrb.3
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 16:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=GFWcUR0E2rLV5+1mHw8sbPXIAZaonW856attdSFQE3k=;
        b=a7qIfDeMqmOlzXIjy6AD83iu+9sD25AcpCs4rgfSdEAxw8Z6T+JEfzisp9I1yzvJO+
         rtEVcV4A0IfCq4C5m7kUnWmwinSFSNoIcuI381f5UvcYjR3bXOtS+D5WNygd2/4MOmmZ
         RZm1t5Go8IbRWDpsHaUFENCIus1qA9MYV4Z38ZymJnlPOJvBx02xEjG+4RVRhIRLisXr
         GAuPDoI2wUuqrL4BrLMXX2k0A5aY+92XEb3bDYpeJQ3ABjrdgZzljjQiJwsDpO43NALK
         0M1jL0y7166pmVdYMLmFsGmhqram8Hx5jtH7nQmssjy5jbuhJUmMkiQjSdYRiMw6Zubc
         vqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=GFWcUR0E2rLV5+1mHw8sbPXIAZaonW856attdSFQE3k=;
        b=k/PY2pjzJBxNVnGy1CZic35pmBAKqcG5i9nnQY0DgbAFlxZ+XcWL8AlRZJoLFWSZvO
         X7B0Ip88renaapw9Zv79hxgutuOoaMlskxFahvdTYyVgtkKF+MBwAjdcMMSwhT+n1H/E
         yHohvoo1bZ2tgU3InuYmqFPtd7bsiHOA1nhBwU8gcDv3x56CzQN81Fqry8ICT1fxrgmj
         bEfDy9WTJCpT5vqTaJkvzUSR+pgv3fIRpNuqA5MfeU0H4gAhed5sirnV5N9W1tV3nAk1
         Ivm8n3OILj4FYi7QiE1CJbQHDSOK0izdHiySyuJxxd/hwhBW7NImYAM8pYUH0BRo9A8e
         nswg==
X-Gm-Message-State: AOAM532vTn3INQUYTUBaOQ+xjK1lfYIbffZSVkpe2RlM8Y7VNtmnW8KY
        PBL6TOTFXSwgQuORFgCN8ULBoZhm/JE=
X-Google-Smtp-Source: ABdhPJx5K89GIUZHHK2DbJplwYsBTNde6sDPgVAdR8Jn0wbv0YuFc1A7XDS66iPRPTe9BsbHaBIgMw==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr2548170wrq.264.1638317109243;
        Tue, 30 Nov 2021 16:05:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm3647482wmk.37.2021.11.30.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 16:05:08 -0800 (PST)
Message-Id: <pull.1036.v5.git.git.1638317108.gitgitgadget@gmail.com>
In-Reply-To: <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
References: <pull.1036.v4.git.git.1637028785.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 00:05:05 +0000
Subject: [PATCH v5 0/2] Implement new zdiff3 conflict style
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement a zealous diff3, or "zdiff3". This new mode is identical to
ordinary diff3 except that it allows compaction of common lines between the
two sides of history, if those common lines occur at the beginning or end of
a conflict hunk.

Change since v4:

 * None; just resending because v3 wasn't picked up.

Changes since v3:

 * More fixes from Phillip.
 * Marked Phillip as the author of the first commit because he's written
   most the code now; gave myself a co-authored-by trailer on that commit.
 * Removed the RFC label since it's now passing our tests.

Changes since v2:

 * Included more fixes from Phillip, and a new testcase

Changes since v1:

 * Included fixes from Phillip (thanks!)
 * Added some testcases

Elijah Newren (1):
  update documentation for new zdiff3 conflictStyle

Phillip Wood (1):
  xdiff: implement a zealous diff3, or "zdiff3"

 Documentation/config/merge.txt         |  9 ++-
 Documentation/git-checkout.txt         |  3 +-
 Documentation/git-merge-file.txt       |  3 +
 Documentation/git-merge.txt            | 32 +++++++--
 Documentation/git-rebase.txt           |  6 +-
 Documentation/git-restore.txt          |  3 +-
 Documentation/git-switch.txt           |  3 +-
 Documentation/technical/rerere.txt     | 10 +--
 builtin/checkout.c                     |  2 +-
 builtin/merge-file.c                   |  2 +
 contrib/completion/git-completion.bash |  6 +-
 t/t6427-diff3-conflict-markers.sh      | 90 ++++++++++++++++++++++++++
 xdiff-interface.c                      |  2 +
 xdiff/xdiff.h                          |  1 +
 xdiff/xmerge.c                         | 63 ++++++++++++++++--
 15 files changed, 205 insertions(+), 30 deletions(-)


base-commit: 4c719308ce59dc70e606f910f40801f2c6051b24
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1036%2Fnewren%2Fzdiff3-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1036/newren/zdiff3-v5
Pull-Request: https://github.com/git/git/pull/1036

Range-diff vs v4:

 1:  473fae82da1 = 1:  473fae82da1 xdiff: implement a zealous diff3, or "zdiff3"
 2:  69f20a702b4 = 2:  409ae2bbd85 update documentation for new zdiff3 conflictStyle

-- 
gitgitgadget
