Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F69C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC26F63212
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 15:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbhKPPlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhKPPlD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 10:41:03 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00FBC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 07:38:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id z200so17378637wmc.1
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 07:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EuAJ6tC/4qj4DN6sol8iPh8dX4qwSvy2da1So2QP6tw=;
        b=E+U3sZ2EyqFR3zaAkt56IuY+/ON9pNOaDSutB9Crh6TJIZ/SDgcuJ7HchzoNl1Q3G/
         ayeg8XmKgpCSlEb0HrpnFJjZuHdzqroq3mN6JYUiLs1TyTm7aJ3Cf+4N1TG+bB92eqH9
         7ltDRjwwxr0Ag9dhPXesZ3XoDgb+hJgq8ddL6adBlqYrh4hSmwKjMU7GZB2Uh57c3wcn
         w4elEooiOIUmsPdVkqnPuUrS3IXAJ0Rb52ptEokVd3DcvWrLkYIYmQhtCPu9WND7rS/5
         ryAakYd9Vqeg8i2iaviEYmF3+yo76TdRV3PmmWXk9A6nZHnYKnNsGejhnYf83i0Xpez2
         D8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EuAJ6tC/4qj4DN6sol8iPh8dX4qwSvy2da1So2QP6tw=;
        b=oLzZGO3z3C+sSOY+bh6VEygszH2Ewhhge6xrvqErj1Fs9o/qQh/FXpSAZir3QjrDlN
         mjBGDkiiRKxPEAnAitO4IUi3WpVDgv9SqOGfQyHiturUoq8rfOqaz2qGqQMh48nJHn8A
         5Q72HcPDavz6hjrtqliz4woiXBN0KTXeMz0FslmwO9pB34l0zyxScvghXoEZ7YKnznTc
         dDqJ4NWulwlC+1i/hDRYPkG1pWu93456zSZ51+jPwGoSHhX+yA6oWtq+sL7EOCvG9IXb
         74/GXunUi8TQd9VuwOjMo8INsa90Y5DKtKBznkIOaMUjyQ70ewBDX5MaSI792sfpT/jU
         G44A==
X-Gm-Message-State: AOAM530O3SD3y6ZdekR4vR/0xLnIGES1E/cql19a02ZKrK6dC2IQbvHW
        uJpzMCGxBUVtOAqJ0TZuqFv9EVCZ3M0=
X-Google-Smtp-Source: ABdhPJyuOSLcKqjKx6wVkCFXtBIj6JBmIyPGzfgNpkXya4hMTG6G4EXqK2W954chy0aHFpeWJ6Nc+w==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr69352183wmq.144.1637077084072;
        Tue, 16 Nov 2021 07:38:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w15sm17698625wrk.77.2021.11.16.07.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:38:03 -0800 (PST)
Message-Id: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Nov 2021 15:38:00 +0000
Subject: [PATCH 0/2] Sparse index: fetch, pull, ls-files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on ld/sparse-index-blame (merged with 'master' due to an
unrelated build issue).

Here are two relatively-simple patches that further the sparse index
integrations.

Did you know that 'fetch' and 'pull' read the index? I didn't, or this would
have been an integration much earlier in the cycle. They read the index to
look for the .gitmodules file in case there are submodules that need to be
fetched. Since looking for a file by name is already protected, we only need
to disable 'command_requires_full_index' and we are done.

The 'ls-files' builtin is useful when debugging the index, and some scripts
use it, too. We are not changing the default behavior which expands a sparse
index in order to show all of the cached blobs. Instead, we add a '--sparse'
option that allows us to see the sparse directory entries upon request.
Combined with --debug, we can see a lot of index details, such as:

$ git ls-files --debug --sparse
LICENSE
  ctime: 1634910503:287405820
  mtime: 1634910503:287405820
  dev: 16777220 ino: 119325319
  uid: 501  gid: 20
  size: 1098    flags: 200000
README.md
  ctime: 1634910503:288090279
  mtime: 1634910503:288090279
  dev: 16777220 ino: 119325320
  uid: 501  gid: 20
  size: 934 flags: 200000
bin/index.js
  ctime: 1634910767:828434033
  mtime: 1634910767:828434033
  dev: 16777220 ino: 119325520
  uid: 501  gid: 20
  size: 7292    flags: 200000
examples/
  ctime: 0:0
  mtime: 0:0
  dev: 0    ino: 0
  uid: 0    gid: 0
  size: 0   flags: 40004000
package.json
  ctime: 1634910503:288676330
  mtime: 1634910503:288676330
  dev: 16777220 ino: 119325321
  uid: 501  gid: 20
  size: 680 flags: 200000


(In this example, the 'examples/' directory is sparse.)

Thanks!

Derrick Stolee (2):
  fetch/pull: use the sparse index
  ls-files: add --sparse option

 Documentation/git-ls-files.txt           |  4 ++
 builtin/fetch.c                          |  2 +
 builtin/ls-files.c                       | 12 ++++-
 builtin/pull.c                           |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 57 ++++++++++++++++++++++++
 5 files changed, 75 insertions(+), 2 deletions(-)


base-commit: ce9c834d5de7026a5271e289ab4518e569464171
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1080%2Fderrickstolee%2Fsparse-index%2Ffetch-pull-ls-files-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1080/derrickstolee/sparse-index/fetch-pull-ls-files-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1080
-- 
gitgitgadget
