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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3304C636C9
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D57C66115C
	for <git@archiver.kernel.org>; Sat, 17 Jul 2021 15:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhGQPos (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Jul 2021 11:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbhGQPor (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jul 2021 11:44:47 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75A1C061762
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t5so15599195wrw.12
        for <git@vger.kernel.org>; Sat, 17 Jul 2021 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=y9kJFOH/NzBX3fULqq7NH8gbIZLl7VtKSRx6Yz6I9cI=;
        b=o0xaGdDBJq/dogt/Y6TOAxBO3YiXPowlPedeDLaYPmnsMgwZqCdzy6HXIhdhoNPaS3
         hM7i33TrshJS8NWDfw4Az4zwMMq9gvpSOgLUZ4/GKfosM//rbCnO7HGtwLFtvNPgCp5c
         SFwCVnsaHxJuu1Zq0WeyQrQtCxBgWefalYSiUW5+ZhDhuqGISxVXuafnIRsB/AS85X+0
         0SN2m7l/2rGsd9fhpsI0fOBD7iqOAAeWodFnQPr2eY700l2Arq9A+CO5ehzwyj2Dpk+K
         ybckVJNnvKu5TT5HD5LHoHqqYrjSl/VMNqtzjOWflJvbN7ydu0TlUrjJL4PCO71zNCu1
         KSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y9kJFOH/NzBX3fULqq7NH8gbIZLl7VtKSRx6Yz6I9cI=;
        b=ZFaZ3fxiUm6BucrQHZvETlKimfgrU3V2XMNhYZK5gJntCsQaKzw9daXF26pVe1ekPC
         zNBTSJJExr9AjQ6q0SBQXufoddBRel2DPHnQJJ3Gd8Z1fo/iQXim31uW6FwcoI1SYfkG
         /KzOFnR79fsESdWss+TcHay2QDpEDUxmJu8gcYL8Qy2M6KkW2/ADbvV4a3053Gx/WHOC
         Abh4Zqfnn7SDULGZnxryn3URiNQck5zV7KqFZYuayQgr/H0+7bXoPn4PSAc3VirB0IDX
         jl1aOakFSGGah+/EwmBWUobR2POvk8tDPJ9gS6SP4kruWUjcexvIu7INfGmCwHJkhoab
         /K4g==
X-Gm-Message-State: AOAM533N1k85X0kvmsQSYOadfPOVzQUfwX7dsoYiwxgWefcwMsDDuAuu
        ZTVp6bHlDQKp3fK5zVw1U5eA55N16bg=
X-Google-Smtp-Source: ABdhPJxh6tzuzJWQt0DqYxO+LC6UyYc+RIeEUSpbWWfN1A9mZ1tHkWSvH7CrPI99x0BkJWNoZz+3jA==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr19026476wrv.403.1626536509351;
        Sat, 17 Jul 2021 08:41:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm15733549wrr.90.2021.07.17.08.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 08:41:48 -0700 (PDT)
Message-Id: <pull.1049.git.git.1626536507.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 17 Jul 2021 15:41:38 +0000
Subject: [PATCH 0/9] Handle pull option precedence
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Matthias Baumgarten <matthias.baumgarten@aixigo.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on a recent list of rules for flag/option precedence for git-pull[1]
from Junio (particularly focusing on rebase vs. merge vs. fast-forward),
here's an attempt to implement and document it. Given multiple recent
surprises from users about some of these behaviors[2][3] and a coworker just
yesterday expressing some puzzlement with git-pull and rebase vs. merge, it
seems like a good time to address some of these issues.

Since the handling of conflicting options was holding up two of Alex's
patches[4][5], and his patches fix some of the tests, I also include those
two patches in my series, with a few small changes to the first (so I've
kept him as author) and more substantial changes to the second (so I've
given him an Initial-patch-by attribution).

Quick overview:

 * Patches 1-2: new testcases (see the commit messages for the rules)
 * Patch 3: Alex's recent patch (abort if --ff-only but can't do so)
 * Patches 4-6: fix the precedence parts Alex didn't cover
 * Patch 7: Alex's other patch, abort if rebase vs. merge not specified
 * Patch 8: Compatibility of git-pull with merge-options.txt (think
   rebasing)
 * Patch 9: Fix multiple heads handling too

[1] https://lore.kernel.org/git/xmqqwnpqot4m.fsf@gitster.g/ [2]
https://lore.kernel.org/git/CAL3xRKdOyVWvcLXK7zoXtFPiHBjgL24zi5hhg+3yjowwSUPgmg@mail.gmail.com/
[3]
https://lore.kernel.org/git/c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com/
[4]
https://lore.kernel.org/git/20210711012604.947321-1-alexhenrie24@gmail.com/
[5]
https://lore.kernel.org/git/20210627000855.530985-1-alexhenrie24@gmail.com/

Alex Henrie (1):
  pull: abort if --ff-only is given and fast-forwarding is impossible

Elijah Newren (8):
  t7601: add relative precedence tests for merge and rebase
    flags/options
  t7601: add tests of interactions with multiple merge heads and config
  pull: since --ff-only overrides, handle it first
  pull: ensure --rebase overrides ability to ff
  pull: make --rebase and --no-rebase override pull.ff=only
  pull: abort by default when fast-forwarding is not possible
  pull: update docs & code for option compatibility with rebasing
  pull: fix handling of multiple heads

 Documentation/git-pull.txt      |  22 ++--
 Documentation/merge-options.txt |  25 ++++
 advice.c                        |   5 +
 advice.h                        |   1 +
 builtin/merge.c                 |   2 +-
 builtin/pull.c                  |  55 ++++++---
 t/t4013-diff-various.sh         |   2 +-
 t/t5520-pull.sh                 |  26 ++--
 t/t5521-pull-options.sh         |   4 +-
 t/t5524-pull-msg.sh             |   4 +-
 t/t5553-set-upstream.sh         |  14 +--
 t/t5604-clone-reference.sh      |   4 +-
 t/t6402-merge-rename.sh         |  18 +--
 t/t6409-merge-subtree.sh        |   6 +-
 t/t6417-merge-ours-theirs.sh    |  10 +-
 t/t7601-merge-pull-config.sh    | 212 +++++++++++++++++++++++++++++---
 t/t7603-merge-reduce-heads.sh   |   2 +-
 17 files changed, 321 insertions(+), 91 deletions(-)


base-commit: 75ae10bc75336db031ee58d13c5037b929235912
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1049%2Fnewren%2Fhandle-pull-option-precedence-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1049/newren/handle-pull-option-precedence-v1
Pull-Request: https://github.com/git/git/pull/1049
-- 
gitgitgadget
