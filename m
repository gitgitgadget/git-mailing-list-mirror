Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DB0C7EE26
	for <git@archiver.kernel.org>; Tue, 23 May 2023 23:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjEWXR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 19:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjEWXR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 19:17:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1CDDA
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:17:56 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-30a95ec7744so73982f8f.3
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684883874; x=1687475874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HDOEJ92fTJbeNdZyfrxycogQ66+O7s78c6TTXcGIPBI=;
        b=DVME+E9+B3yivuEHQ4eU8AwNMtIWsiejfUGXXVN3dn0e2fHCvNuFhWRWyePYPRLL1t
         ywTOJcxOf3gufFnsvTkbBSBRDleHCvoKmA5MNdefiEfqwXM5SDOIa7mEP5x+lqLxquMe
         m9g987WLurPMPh5g3dL9c0k3Ka57Ov2muqcjOdrHtvMvA0vVVWowPXnmhMGwnLQ11o80
         yM7OStwHOpnLjJ/dM6cClhCPP1ozcnE8cMOeQ++DwvNGlGkr4Pj7j3wvnIsQbv1Dh3Ha
         VKKZDU2CjPapi9W1/GZb3G7O7s8PpdLJ9K8DZn0Ft+4gjs/WewAz3mzRSth1FB7ARdDq
         VTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684883874; x=1687475874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDOEJ92fTJbeNdZyfrxycogQ66+O7s78c6TTXcGIPBI=;
        b=GqoT5J617REshLwEtR4DEmx4YdKtUaHlrOfNTacN6WNu9gOCf+Z5wmD85m4qqgbCb5
         5gDgq9LwSOMAXKPREJa+XnV/j13XELC7YJZi0m0ki0J/GaCEmvN3lVYHJz+lBzzUGmcT
         keQ93TWrpsEpy8L8Bbk57URY+R8uuuifkFawZEFc/7Y21YyzpKepYIXvczVf65uMfPuB
         TyQVLGY77E4QkVT/GSttPM750SbosbDq30pC/okeapM8frxZo3CbBkHms68lR4yxDGxX
         umIyXJkGn61bO8wmyfJFtw72ELUb10HNMKhn2mfHbldVpTS0hh5Zh9YYNmasQb8gN4y1
         Qr2g==
X-Gm-Message-State: AC+VfDx8O0zut+6rA8RNCZsm+WKJSY2J9tjMnCoDv4XZhTzgAV8gKjSh
        BVzZs6EQ72KgrofwGuA0/RS3gGDeh9I=
X-Google-Smtp-Source: ACHHUZ7eUlbz4a7LIB9wbxOboWiZwRZkToHoMX6BmEeTQXGT31p4j3ydyG4XmEGd/+/kNRHQb/Zexw==
X-Received: by 2002:adf:f091:0:b0:306:3f97:4847 with SMTP id n17-20020adff091000000b003063f974847mr12527848wro.65.1684883873981;
        Tue, 23 May 2023 16:17:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d16-20020a5d5390000000b00301a351a8d6sm12470709wrv.84.2023.05.23.16.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 16:17:53 -0700 (PDT)
Message-Id: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 May 2023 23:17:50 +0000
Subject: [PATCH 0/2] Fix behavior of worktree config in submodules
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, chooglen@google.com,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About a year ago, discussion on the sparse index integration of 'git grep'
surfaced larger incompatibilities between sparse-checkout and submodules
[1]. This series fixes one of the underlying issues to that incompatibility,
which is that the worktree config of the submodule (where
'core.sparseCheckout', 'core.sparseCheckoutCone', and 'index.sparse' are
set) is not used when operating on the submodule from its super project
(e.g., in a command with '--recurse-submodules').

The outcome of this series is that 'extensions.worktreeConfig' and the
contents of the repository's worktree config are read and applied to (and
only to) the relevant repo when working in a super project/submodule setup.
This alone doesn't fix sparse-checkout/submodule interoperability; the
additional changes needed for that will be submitted in a later series. I'm
also hoping this will help (or at least not hurt) the work to avoid use of
global state in config parsing [2].

Thanks!

 * Victoria

[1]
https://lore.kernel.org/git/093827ae-41ef-5f7c-7829-647536ce1305@github.com/
[2]
https://lore.kernel.org/git/pull.1497.git.git.1682104398.gitgitgadget@gmail.com/

Victoria Dye (2):
  config: use gitdir to get worktree config
  repository: move 'repository_format_worktree_config' to repo scope

 builtin/config.c                       |  3 +-
 builtin/worktree.c                     |  2 +-
 config.c                               | 42 ++++++++++++++++++--------
 environment.c                          |  1 -
 environment.h                          |  1 -
 repository.c                           |  1 +
 repository.h                           |  1 +
 setup.c                                | 10 ++++--
 t/t3007-ls-files-recurse-submodules.sh | 34 +++++++++++++++++++++
 worktree.c                             |  4 +--
 10 files changed, 78 insertions(+), 21 deletions(-)


base-commit: 4a714b37029a4b63dbd22f7d7ed81f7a0d693680
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1536%2Fvdye%2Fvdye%2Fsubmodule-worktree-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1536/vdye/vdye/submodule-worktree-config-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1536
-- 
gitgitgadget
