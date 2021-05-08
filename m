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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB762C433B4
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E196100C
	for <git@archiver.kernel.org>; Sat,  8 May 2021 00:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhEHAJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 20:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhEHAJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 20:09:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E3C061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 17:08:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso7274096wmc.1
        for <git@vger.kernel.org>; Fri, 07 May 2021 17:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m102OJarVyDKXlmtLcgSfCq0YckDtrC07GFzMyQcpHM=;
        b=o42V6fn5hTILE1KNt/fFVuccuFMT8kog1vj5cv50jHh4uiKvlhU3wmra5wa10Mz+hR
         WdmAhGrY8tiwvNFtuGw61B2zDMlNpQKhRJ9p5aumL+Y08C1LfMSP4eaCd2gjJ7T9SfyG
         6n7yHfvMDJ4jvzKnAc+91QEDFL3IRJRdJSlFXTofWtSEZVuI/tJvQSsBtz+jnQouLqg5
         UAyGHCNZxL+AMjefh+MzTOO/oLIQjMeI5bGL3lN8pJ43TvnzzsTMBcatrKeBvSG6V3TE
         1qWPr5VMYbf5Dzb4SIJA3j8sZpwnIbPR74ZiO2mtFZ8dCjIBlzqoCwqXLghjdd9ftEhL
         UdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m102OJarVyDKXlmtLcgSfCq0YckDtrC07GFzMyQcpHM=;
        b=LpN9yyxS/8WN2KIEVOuut57EsTNcFCZ/MppzT5c6JJJl68QLKycnXQuGhtybgQO4RS
         K7elZ4WDkZ7jMomGO4w47k4ook/GJBwRigy6Pjuxuu2PynTFpZI9BYM5pwIfaYtwGKHJ
         4+DLgRyDOx3iUrFrQNql9gNfhVKBpCFMcCXLXaLhoLK40fVan1waKZ4BYOtLK3/D2c3B
         nrxqCNhrSrIpeDNLdXCt8D3HtfoeB8z3CaJkTMPKbjpZzDkK0tUP92urh+Tz8rS45+qL
         Ek3pTycTj2tjjlY9L7mchpFowWWBkxCot5ALF/d9zx9NVdtGm/NAdoNMRSp6dCfTE4kg
         SeAQ==
X-Gm-Message-State: AOAM533V14W7y1qErFrUrHe5+NhqmmJzKl5hrQTJy5ThiCTwvn2HL4ke
        VJN9Rc1wBz2xo4Cl+X0tL8oZm5QaADo=
X-Google-Smtp-Source: ABdhPJzRnniqsJDZ7v5hJSqK6q94Y0WymyqehpNJcVPNBt+R/BzLNNgcq9voUkqkkMojXd/LQ1WUzw==
X-Received: by 2002:a1c:255:: with SMTP id 82mr24420295wmc.74.1620432501952;
        Fri, 07 May 2021 17:08:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13sm10474407wrt.65.2021.05.07.17.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 17:08:21 -0700 (PDT)
Message-Id: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
In-Reply-To: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
References: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 May 2021 00:08:12 +0000
Subject: [PATCH v2 0/8] Directory traversal fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset fixes a few directory traversal issues, where fill_directory()
would traverse into directories that it shouldn't and not traverse into
directories that it should.

Changes since v2:

 * Added a patch from Stolee to clean up some nearby comments that were made
   out-of-date 12 years ago
 * Added a new RFC patch that switches dir.c from using trace1 to trace2
 * Added a new RFC patch that adds directories-visited and paths-visited
   statistics using the trace2 output, and use that to vastly simplify (and
   accelerate) the t7300 testcase

I'm curious what others think of the backward compatibility ramifications of
the RFC patches, patch 5 & patch 6. And whether my use of trace2 is clean,
idiomatic, correct, etc. I've not used it before for things other than
region_enter & region_leave.

Also, if anyone has any ideas about a better place to put the "Some
sidenotes" from the third commit message rather than keeping them in a
random commit message, that might be helpful too.

[1] See
https://lore.kernel.org/git/DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com/
or alternatively https://github.com/git-for-windows/git/issues/2732.

Derrick Stolee (1):
  dir: update stale description of treat_directory()

Elijah Newren (7):
  t7300: add testcase showing unnecessary traversal into ignored
    directory
  t3001, t7300: add testcase showcasing missed directory traversal
  dir: avoid unnecessary traversal into ignored directory
  dir: traverse into untracked directories if they may have ignored
    subfiles
  [RFC] ls-files: error out on -i unless -o or -c are specified
  [RFC] dir: convert trace calls to trace2 equivalents
  [RFC] dir: reported number of visited directories and paths with
    trace2

 builtin/ls-files.c                 |   3 +
 dir.c                              | 103 +++++++++------
 dir.h                              |   4 +
 t/t1306-xdg-files.sh               |   2 +-
 t/t3001-ls-files-others-exclude.sh |   5 +
 t/t3003-ls-files-exclude.sh        |   4 +-
 t/t7063-status-untracked-cache.sh  | 194 ++++++++++++++++-------------
 t/t7300-clean.sh                   |  41 ++++++
 t/t7519-status-fsmonitor.sh        |   8 +-
 9 files changed, 238 insertions(+), 126 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1020%2Fnewren%2Fdirectory-traversal-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1020/newren/directory-traversal-fixes-v2
Pull-Request: https://github.com/git/git/pull/1020

Range-diff vs v1:

 1:  a3bd253fa8e8 = 1:  a3bd253fa8e8 t7300: add testcase showing unnecessary traversal into ignored directory
 2:  aa3a41e26eca = 2:  aa3a41e26eca t3001, t7300: add testcase showcasing missed directory traversal
 3:  3c3f6111da13 = 3:  3c3f6111da13 dir: avoid unnecessary traversal into ignored directory
 4:  fad048339b81 = 4:  fad048339b81 dir: traverse into untracked directories if they may have ignored subfiles
 5:  3d8dd00ccd10 = 5:  3d8dd00ccd10 [RFC] ls-files: error out on -i unless -o or -c are specified
 -:  ------------ > 6:  1d825dfdc70b dir: update stale description of treat_directory()
 -:  ------------ > 7:  3a2394506a53 [RFC] dir: convert trace calls to trace2 equivalents
 -:  ------------ > 8:  fba4d65b78c7 [RFC] dir: reported number of visited directories and paths with trace2

-- 
gitgitgadget
