Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15511C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 15:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4ABE20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulhJhHoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHBPUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHBPUu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 11:20:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908CFC06174A
        for <git@vger.kernel.org>; Sun,  2 Aug 2020 08:20:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so9527501wmc.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4+WJbcq8QBKbJ3CfzQ3WtWL8gWbmcdCbUXRVG2cHeTc=;
        b=ulhJhHoJCigzEbyfE7r40+iCdx3Di8H4LPUzNp3rtYpkhlimQYKxs1C+vQi5XEtQXN
         CUQUKOegCLcl7jvw4+Yr4/SZpifvG4yopxAygmxvhLB1ZVuVETDlYkbLzolnrp/riABm
         gdAbP8fXJmOOkc/0pCUtA8co8TkvovOHBlJudeCNgkl7143K8zSFyMKRproO29VQi61j
         ZjocjHdp23HYN0NK/shMt9ZqX9TYQZv5NsgahkGNKDpqHFqKhSFAjhURpKz6AP2Gz9iV
         SbU9KIwTlBmMeAohXGvvpJsOepIRjc+80vELvRx/lffWcrmtu9iKjQamL1Q1HaUTtyXN
         aaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4+WJbcq8QBKbJ3CfzQ3WtWL8gWbmcdCbUXRVG2cHeTc=;
        b=i0CL5z4gRePHQ9Ut8WL4GzGPYD/AILqLNd0P7MJ1fo0JPZVq4nngXb/5Is1xapozLU
         aj2sghl3xTl0rqc31uUGf7BY5T6gsNCJuvDzIw8RGi7O0RSlOC/vRZuE/K7UAe5nl2Ld
         DaVDenssU5n2EbqilYlMaYSG0TB13RMrHzHCTAaQ46UmuZ15N/MjyHD+EZ6qMc+YcrEu
         L9H5zjFoTxjrz/59juFHvV03JEb9YXetjGx+YvRKSg0Skjo5S5iAcmODaxCjdVIuRFdl
         kLSmlN12JR+IMCBE5MyQ9gbftiqQO8Ou34S4hikK2c1U0b8YIAlLL3Qu3xqkZIqshYRD
         Ymtg==
X-Gm-Message-State: AOAM533lcUlOX9I9T/drnWgQt6PDEi0g9vuY2H4j2q8bVy6sRtrNjmGW
        KD7rv5svzXX8NONE9KvSG9EgxoVQ
X-Google-Smtp-Source: ABdhPJyR+t+RkscRGm854aIVdl9ZfYwPpZybGYPdNQAHZ9VFYXWGYJgC8wWDTrxYcNzjaThEED0iew==
X-Received: by 2002:a1c:e107:: with SMTP id y7mr11419135wmg.99.1596381648928;
        Sun, 02 Aug 2020 08:20:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 68sm21000479wra.39.2020.08.02.08.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 08:20:48 -0700 (PDT)
Message-Id: <pull.691.git.1596381647.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 15:20:44 +0000
Subject: [PATCH 0/3] [RFC] List all guides in git(1)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a list of the guides to git(1).

The first commit adds the misssing guides 'gitcredentials' and
'gitremote-helpers' to command-list.txt. The only missing guide after this
change is 'gitweb.conf', but I think this one is obscure anough, and already
linked to in 'gitweb.txt', that it does not matter much.

The second commit drops the usage of 'common' and 'useful' for guides. This
was suggested as one of two ways forward by Duy in [1] but was not commented
on. I'm CC'ing the people that were CC'ed on that message.

The third commit tweaks 'Documentation/cmd-list.perl' so that it also
generates a list of the guides, which gets included in 'git.txt'. I chose to
put this list just after the end of the list of commands.

[1] 
https://lore.kernel.org/git/CACsJy8ADj-bTMYDHxRNLOMppOEdPbVwL49u3XCfNBCmoLLZo+A@mail.gmail.com/

Philippe Blain (3):
  command-list.txt: add missing 'gitcredentials' and 'gitremote-helpers'
  help: drop usage of 'common' and 'useful' for guides
  git.txt: add list of guides

 Documentation/Makefile           |  1 +
 Documentation/cmd-list.perl      | 10 ++++++++--
 Documentation/git-help.txt       |  6 +++---
 Documentation/git.txt            |  7 +++++++
 Documentation/gitcredentials.txt |  2 +-
 builtin/help.c                   |  2 +-
 command-list.txt                 |  2 ++
 help.c                           |  4 ++--
 help.h                           |  2 +-
 9 files changed, 26 insertions(+), 10 deletions(-)


base-commit: e8ab941b671da6890181aea5b5755d1d9eea24ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-691%2Fphil-blain%2Flist-guides-in-git.1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-691/phil-blain/list-guides-in-git.1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/691
-- 
gitgitgadget
