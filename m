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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264BC433E1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC9A61969
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 12:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhC2Mlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhC2Mlt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 08:41:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC10CC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:48 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o16so12769362wrn.0
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OOTETm+r8ojRy5BWXgK2QXJ3oUmGajhQjI5OrerUzcs=;
        b=o/kyjgAEPAY+4vrIDXyCaf7Cmd78sqs2CO4b5Pw08Ds3+ErShvs/MGqMLvOflDwyn9
         VCQ5qY11Zb+ZUd1zLoGEjF4BM36jZ1kWFb11Z7IOtsI457nOHPBoTcmV/W/JJVH8vtga
         7YEH67P2I6qKxwPdsb1H4qzmf/B0vTc49PbEqFgKMnwq6zTZCSG3wLksj2/CPvKiXXHa
         UH1UIah0/4UCC7Zu67D6rA7c3W56OEewJDn6HQvGJV6U7iDqTwlaP7ZrTravLmtH9Snc
         VV0HlrZNONOjEG62LKTp+xyL3Ib+Bi4oc/pFhH/roNyfVqdjBF5Udr1sHghtWs9DrXkM
         ynDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OOTETm+r8ojRy5BWXgK2QXJ3oUmGajhQjI5OrerUzcs=;
        b=uGaWdCd23Oof6DKnovNDiZPcLifdPp3aP5rgggRkmnyfa+4dPhwPgpGF0pxFnymU+p
         XLCvLvJ+zjqDTO0lruNWSRqAwieYYn9idibrCf84orZ2WsRIi80AaxIfKi6ZPwIY7fs+
         BSIU6pIibswB9XXqq2KLaXcJDpd51PdtrNQiIPTlPsxfsLc7G3aB/HBEoOO/N0n8zSmU
         K+LVYVszT7OTV8o8FKgN+IHUS7eJKwFoe0yIG3yq7cUj2EYhf2N7vCTeSxyjr6ktrhfu
         lBJLgU6YHDTtIS79RkLnAtNeE73oejmXmvi7UmbfSHwIlf28H7aFOV+++FIvc1T2if+Q
         pPFQ==
X-Gm-Message-State: AOAM531ObdyU0vMuf6Y7aXkCGCV2Vc+9jL8RWTaSKxz3GlRZMAvT1gGY
        B0lnl/t9aVyEVjguKKQgLTpHX26DdP4=
X-Google-Smtp-Source: ABdhPJwzNgX0ygpD012JH1DQB4g04jgh8TcJP0Us5Dpg/PU2kHRKisIIP/wsBg49wt1vlRiuhd+/OQ==
X-Received: by 2002:a5d:6307:: with SMTP id i7mr28726946wru.305.1617021707528;
        Mon, 29 Mar 2021 05:41:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11sm29944892wrz.40.2021.03.29.05.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 05:41:46 -0700 (PDT)
Message-Id: <pull.887.v2.git.1617021705.gitgitgadget@gmail.com>
In-Reply-To: <pull.887.git.1616886386.gitgitgadget@gmail.com>
References: <pull.887.git.1616886386.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 12:41:41 +0000
Subject: [PATCH v2 0/4] cmake: learn to optionally skip linking dashed built-ins
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In Git for Windows, we would like to make use of the fact that our
CMake-based build can also install the files into their final location. This
patch series helps with that.

Changes since v1:

 * Use proper string/variable CMake syntax, as pointed out by Danh

Dennis Ameling (2):
  cmake(install): fix double .exe suffixes
  cmake(install): include vcpkg dlls

Johannes Schindelin (2):
  cmake: support SKIP_DASHED_BUILT_INS
  cmake: add a preparatory work-around to accommodate `vcpkg`

 .github/workflows/main.yml          |  5 +++++
 contrib/buildsystems/CMakeLists.txt | 26 +++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)


base-commit: 773e25afc41b1b6533fa9ae2cd825d0b4a697fad
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-887%2Fdscho%2Fskip-dashed-built-ins-in-cmake-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-887/dscho/skip-dashed-built-ins-in-cmake-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/887

Range-diff vs v1:

 1:  ff7e8121d7a4 = 1:  ff7e8121d7a4 cmake: support SKIP_DASHED_BUILT_INS
 2:  69856f278645 = 2:  69856f278645 cmake(install): fix double .exe suffixes
 3:  543fd0f5d7e5 ! 3:  5d953a21e9bd cmake: add a preparatory work-around to accommodate `vcpkg`
     @@ contrib/buildsystems/CMakeLists.txt: list(TRANSFORM git_shell_scripts PREPEND "$
       #install
      -install(TARGETS git git-shell
      +foreach(program ${PROGRAMS_BUILT})
     -+if(${program} STREQUAL git OR ${program} STREQUAL git-shell)
     ++if(program STREQUAL "git" OR program STREQUAL "git-shell")
      +install(TARGETS ${program}
       	RUNTIME DESTINATION bin)
      +else()
 4:  4b183c7def58 = 4:  f020cb517dfc cmake(install): include vcpkg dlls

-- 
gitgitgadget
