Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AFEC61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 16:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjBCQai (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjBCQaf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 11:30:35 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B5A7ED8
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 08:30:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so5833468wmq.1
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 08:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iULrQ+WcsGhisQZnI/shoRoT2T+g0IhmlkUwAu8kdJY=;
        b=XsAe8jjLYb8f/WdnFdt6VoPm/dZ5aMFGGmG3WOFXYMSTvHgNK0MvPNxflDp0ZsYOi6
         pJxgW8wo0FvVeybuyv8o+Vacxqxcueiv9KBMFrG809CgVLCoRD9sTxTEx8/0/gJql/WL
         JmIkmOCHQ3KR4rSgO2Y9Nx2YLvkjKBFnWToQ1N96EQU+w4n5ckGlqm8bnWnWMFUb6aXz
         AyiwOiputT2HTnJiw/RvfYl9DqS1z5GoCtQaeQQookFTpbmZvx4CXunU2xAaqwmPwCrG
         O1K5g7eMhyVFxthlJ/WQVdVy/Mqra3tUv5tmCSq+vPDk9ylAPuGwxq6oFfigwa+Ai/L4
         AIUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iULrQ+WcsGhisQZnI/shoRoT2T+g0IhmlkUwAu8kdJY=;
        b=eZMyJW/ife5wclNrZ74SNKpgdjHpWkZiAbZXMIvmJPC3VpJnlq7+DtESzxR2SSYWvo
         kGP2pEI5lsb4m8hfVd9+rQc1vMCiYY8rUkeZY4apeyRPdFng8y7I+Iobeg2pgcqOZTaD
         v3sSRt7M+pKllIPWF4bUAcdT00N72/S7mMpuQ4e3fcRufMuCAyUtuXRui4a58Lti7/Ad
         0VnEalTaJ9wkCE7scU4UeBs3ajz3zSfkt7Nf3aovy1Rn0NZ4PoyiWQ7g5m6AbPOuxkvj
         S1i6xDREmey0Do793InYxhkk4tkx4/jFiaerP9u6m71FxgO0uQ7MG8e/+J/MBmj5Omj7
         7ltw==
X-Gm-Message-State: AO0yUKXV+Yh+xKS+gIhIAZrXuNbR3lKuxR9W65d94AhMaTNGN9mLyyYl
        4E2/ryyTOacRuUac3dymw/O3v5V2bcm3dXC8
X-Google-Smtp-Source: AK7set+iV9QVlBXVITe2//t5b+aM9/tKTxNYxB4KVwh3nlupzokT8WOt9ym/cmeijRXcZxmtYhARvA==
X-Received: by 2002:a05:600c:500d:b0:3dc:42d2:aee4 with SMTP id n13-20020a05600c500d00b003dc42d2aee4mr10060603wmr.25.1675441831604;
        Fri, 03 Feb 2023 08:30:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s7-20020a5d6a87000000b00287da7ee033sm2315637wru.46.2023.02.03.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:30:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] add: remove Perl version of "git add -[pi]"
Date:   Fri,  3 Feb 2023 17:30:01 +0100
Message-Id: <cover-0.3-00000000000-20230203T125859Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1397.gbe42486b8a4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The v2.37.0 we've made the built-in version of "git add -i" and "git
add -p" the default, after having had the built-in version optionally
available since v2.25.0.

With this the time we kept around the legacy implementation falls
between the time we kept the similar "rebase" and "stash"
implementations.

After it was made the default we had a next-release regression fix[1],
but haven't had any issues since then. Any outstanding bugs in it are
something we'd fix in the C code, not something where users are likely
to want an escape hatch to scramble back to the Perl implementation.

Branch & CI for this available at:
https://github.com/avar/git/tree/avar/nuke-perl-add--interactive

1. 4788e8b2569 (add --interactive: allow `update` to stage deleted
   files, 2022-06-28)
   https://github.com/msys2/MSYS2-packages/issues/3066

Ævar Arnfjörð Bjarmason (3):
  add: remove "add.interactive.useBuiltin" & Perl "git add--interactive"
  add API: remove run_add_interactive() wrapper function
  docs & comments: replace mentions of "git-add--interactive.perl"

 .gitignore                   |    1 -
 Documentation/config/add.txt |    7 +-
 Documentation/git-add.txt    |    6 +-
 Makefile                     |    1 -
 builtin/add.c                |   61 +-
 builtin/checkout.c           |   12 +-
 builtin/clean.c              |    2 +-
 builtin/reset.c              |    4 +-
 builtin/stash.c              |    3 +-
 ci/run-build-and-tests.sh    |    1 -
 commit.h                     |    2 -
 git-add--interactive.perl    | 1920 ----------------------------------
 pathspec.c                   |    2 +-
 t/README                     |    4 -
 t/t2016-checkout-patch.sh    |    6 -
 t/t3701-add-interactive.sh   |   29 +-
 t/t6132-pathspec-exclude.sh  |    6 +-
 t/test-lib.sh                |    4 -
 18 files changed, 49 insertions(+), 2022 deletions(-)
 delete mode 100755 git-add--interactive.perl

-- 
2.39.1.1397.gbe42486b8a4

