Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E9C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJUPOB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJUPNp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCC957276
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n12so5255371wrp.10
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fLcC727r8Hz5jYXq9dSyxwVz5dk1sjxOFU5aPHIgTX0=;
        b=Rj2Iq3X7nZ7tAf4dvyEXctTyCaby6rSqMIOyYtQgqLjNy4/CjqsCMAoT/TqHy0w92s
         DzT04o3s4mNT8Yxevxt97hrSEOUxHInTmy1jsEOfJSYNyZ23rKOzUW/cQ6HO3lU918wb
         SXm8FgkBJPFferrb6YwQOydENYcpVwGEsNKLCuKh1SC0WNdkW4vvflUTUSLGY/j/UGJ7
         NZ+sKWlhxhx0r5JYI587A6oK200vaRazC1Pj2BvjBdeCQ5ZoiR932GOnpxEynwr86rke
         naD+XihKYn7f1fA1YV2V9RWXjRYReiW8QYSZd3ZjYAKKmVPtq6opM+++QqCYo/UtIPdY
         NrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLcC727r8Hz5jYXq9dSyxwVz5dk1sjxOFU5aPHIgTX0=;
        b=m6E0QcBs5kRIqTLOKNggTmAr8mNYnPQ1TV8Q7kzW8+YpcMFkZ6pBx+w/IGElo/iAn7
         RjKLDUyiEJ4D+KIO4VL51m0c2zGYGyi6tjVmcdc0ppDfaflKH3YmZqwWtYt7eZt4TFn/
         VYGMiMjfbMoeHxVYc1CvLZbvJ/TppSv8sJTPo1WZ6MnWPZIm2XeplEZCpzhQpw7tO6/Y
         Lo/HasfZ6Ua4wT+da2G1zZuVntnxU82so/RK2oJRJoGmvEYO2BUVTXZbtad3bZPwQY0e
         r3aDLM+s4Wwgj3cS0PqOkJIj/2cCNC+fTmTSLs0hla4ijAVSm8hmOA9x8ByzmuI6RVIc
         CTLA==
X-Gm-Message-State: ACrzQf2+3aWblFXgBcK9LGJdgGoWPsYAKL8njAsye4tHvqsbeDpKDEJJ
        d3PPNgzHDt5AHUYndlX2PBB1a3JVPCU=
X-Google-Smtp-Source: AMsMyM40i1iyiVlu2RtwnjY20SieIgtbsKKp8qa56a/F30Ej8VVLiHp4yMnSUdWjHNdc75I4zYh8+Q==
X-Received: by 2002:a5d:64c4:0:b0:231:3d94:6eb2 with SMTP id f4-20020a5d64c4000000b002313d946eb2mr12293758wri.580.1666365222878;
        Fri, 21 Oct 2022 08:13:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d6e82000000b0022ccae2fa62sm19194850wrz.22.2022.10.21.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:41 -0700 (PDT)
Message-Id: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:30 +0000
Subject: [PATCH 0/9] subtree: fix split and merge after annotated tag was squash-merged
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a limitation of 'git subtree merge' and 'git subtree
split' that would fail when the previous squash-merge merged an annotated
tag of the subtree repository that is missing locally.

The 5 first commits are small improvements for coherency with the rest of
the code base, robustness, user experience and maintanability.

Commits 6-7 are small refactors that prepare for the fix in the next
commits. Commits 8-9 fix the behaviour for merge and split, respectively.

I'm CC-ing people that worked on 'git subtree' recently.

Cheers!

Philippe Blain (9):
  test-lib-functions: mark 'test_commit' variables as 'local'
  subtree: use 'git rev-parse --verify [--quiet]' for better error
    messages
  subtree: add 'die_incompatible_opt' function to reduce duplication
  subtree: prefix die messages with 'fatal'
  subtree: define a variable before its first use in
    'find_latest_squash'
  subtree: use named variables instead of "$@" in cmd_pull
  subtree: process 'git-subtree-split' trailer in separate function
  subtree: fix squash merging after annotated tag was squashed merged
  subtree: fix split after annotated tag was squashed merged

 contrib/subtree/git-subtree.sh     | 177 +++++++++++++++++++----------
 contrib/subtree/git-subtree.txt    |  16 ++-
 contrib/subtree/t/t7900-subtree.sh |  60 +++++++++-
 t/test-lib-functions.sh            |  16 +--
 4 files changed, 192 insertions(+), 77 deletions(-)


base-commit: 45c9f05c44b1cb6bd2d6cb95a22cf5e3d21d5b63
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1390%2Fphil-blain%2Fsubtree-pull-tag-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1390/phil-blain/subtree-pull-tag-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1390
-- 
gitgitgadget
