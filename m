Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D699C001B0
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 16:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjHIQyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjHIQyv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 12:54:51 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F112108
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 09:54:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3175f17a7baso85504f8f.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691600088; x=1692204888;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WN1oD5doMpTCJdBvdymIaADTlysyHwk7+0Z2lXKf2E8=;
        b=LgRvykleC8ZYNPpvoH2XFFTjUqrMkEVCQNyctPI9ytLnctL2bKC4yWoyWx32HAwt9+
         +jjhfoLl5zmtUz106ZYElq/N+rmGhsQj5JV+3K8L2pgsVa/S4eXqigO2IIYW+ckTWVpr
         eHJhHmEbMslj8ynDYTONst5oqmeNM5DYC1LNpwAuo7hp1NLXYX+K9zwUKupgIl/fjadA
         Cz+kUWK1P3KALZJTs84rqIzdcvpdrO7JWG8y5iHjQFHWaX2VR98heTXP8Y1qKhNVZDyW
         nwNHqb+Hu+QbAmup16smXPMiJvR4R5FhHN5IonosEOPbg/ZHVKVAm8IjnZF7sLi3riXt
         keKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600088; x=1692204888;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN1oD5doMpTCJdBvdymIaADTlysyHwk7+0Z2lXKf2E8=;
        b=RLPChh0x5I8e0LgTdbnsL1PQJ00wSHvhBJtPpsAPkuDONJDqH95XsIGglB4Fb+MAyC
         hnOSPE4VbHz7E3xr7/HEHEMFCEV96ufFXITXnU+DHXrvZRMiPDwM/skMqcjYBGz3y/X2
         fCIdVvduoqSWx6oyjVENy0RbkumFqUOYjjGHV+fiRPLAqdMr2CSHIBCFosTKLJ/bE01J
         NDq0dgoGh8j5W+s//kGmaE5LpqEKbiQ6dmQ+BYAj0XIlndxt5ELbndCS67oUQz2k9PU+
         XV1itF6RFYubGSU5e4JKowMRM/hTg7etQFlgi//kJjq5n9qWuPEYdHQ+nCPvZQKx76Tw
         heNQ==
X-Gm-Message-State: AOJu0YzUxW+iNgxrtJc5dOyOXZMz3DiJnyIxrVueCo/fP8F6QqFaDmW3
        9EDWmxAAcrpv/5+FORcvvSChibPcCLU=
X-Google-Smtp-Source: AGHT+IERLUtwvfY9q0FZHOtX0wHC46CoaCaus7R951w+Inl5fi2gIYBFgHuO9p58DUAQUx/yO8qVdA==
X-Received: by 2002:a5d:428a:0:b0:317:3f0c:b40e with SMTP id k10-20020a5d428a000000b003173f0cb40emr2218110wrq.58.1691600088259;
        Wed, 09 Aug 2023 09:54:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x5-20020adfffc5000000b003180027d67asm3795285wrs.19.2023.08.09.09.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:54:47 -0700 (PDT)
Message-ID: <pull.1570.git.1691600087.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Aug 2023 16:54:45 +0000
Subject: [PATCH 0/2] maintenance: do not open console on Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two patches are cherry-picks of commits that have lived in
git-for-windows/git since 2019 when background maintenance was originally
introduced.

If we run the core Git project's version of background maintenance on a
Windows platform, then each background maintenance run will create a new
console window, visible to the user. This is due to quirks around how
Windows applications work: they require some parent application and will
create a console window if one does not exist.

This is solved by creating a new 'headless-git.exe' executable that knows
how to hide its own window. This isn't an appropriate change to make to
'git.exe' since that expects to be run within an existing console or
application.

 1. Patch 1 introduces the 'headless-git.exe' executable with the ability to
    hide its window.
 2. Patch 2 modifies the schtasks integration to use 'headless-git.exe'
    instead of 'git.exe'.

Thanks, -Stolee

Johannes Schindelin (2):
  win32: add a helper to run `git.exe` without a foreground window
  git maintenance: avoid console window in scheduled tasks on Windows

 Makefile                                   |   9 ++
 builtin/gc.c                               |   2 +-
 compat/win32/headless.c                    | 115 +++++++++++++++++++++
 config.mak.uname                           |   3 +
 contrib/buildsystems/CMakeLists.txt        |   9 ++
 contrib/buildsystems/Generators/Vcxproj.pm |   4 +-
 contrib/buildsystems/engine.pl             |   1 +
 7 files changed, 140 insertions(+), 3 deletions(-)
 create mode 100644 compat/win32/headless.c


base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1570%2Fderrickstolee%2Fheadless-git-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1570/derrickstolee/headless-git-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1570
-- 
gitgitgadget
