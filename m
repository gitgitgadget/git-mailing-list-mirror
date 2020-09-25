Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C983BC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A07120936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lsuo2N2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgIYO2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgIYO2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96422C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a9so3541765wmm.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=arV1XAxCRP4WEwMf++VFicrTLP+Ol3vSBpghJJcJqeM=;
        b=Lsuo2N2KbnXd3tY6TG4nAVn8aQDss4AYUJZ/F7rVfzA56Aw94wEvCKnzVKEa90Ml20
         nuzTeKUl3plRPPJfJJ/6bX+ZJPFVxqen+apr2RGOF7Kq/8Vw4LzOIPuPWMPVfOB88g8w
         RCmyH931qYKOsPOY8CLr88tvWkHyyt0XwXKIGmGjnoW0/NmOKmdXIANTenhaZKvD8awo
         2rn0wEs/zNJiXP/7w6RdNK/0mg8zdjDeku2K/OGN5x3GAarUHLSNxGz2shyQGI3KPDvf
         ALTNy6npLTFE03lBx5ELTvNxFOslTtAnUZntA9zS5duDVUXgupywwRabycLOJu8a3BVE
         tfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=arV1XAxCRP4WEwMf++VFicrTLP+Ol3vSBpghJJcJqeM=;
        b=KICu3qQLCE+siPln5XLEuRyNeLmdW9ADbD5BqrSmDKeDQSjXmlpq43c7dlUqvpSSng
         REp8QZ2+kI+RMGRDT0BSa/Z9szOY21O34fPy3Mmf3wqpZBj/xcEHLDUD6beIxFG3VNoQ
         grXjPJPrdKtHwBVKgSUode/zuvtQCnikoMXhLLH4f/3wJjF/O1c0LEz08Nn4H7ddQdwi
         LwHyiYPEp6LsGNJpkez6Gz3MYN35xjCba8JTGHRVbuDBBaEQ195r2GZUPPkpGC4zdfZ+
         GR6kdCoDWjXVdrDSH/xIh26842/c7FwQ3O/BIJDuJLgF9dGGiJbG5mLiQUXVRpTJTO2m
         yuCA==
X-Gm-Message-State: AOAM533lZvTUzEqvuHZ1vyEFxzdiqOB/cEE8/ccOx7jd9nvULBS8TfQi
        3RU5Ass3kjT97AkovK/GbKmsIsMVBIk=
X-Google-Smtp-Source: ABdhPJxSnvfbCwXOyS5MreAXBZs0KhXDKA4/tAb2VpitRlEnH86HMgTu2m4yWY7zcWLGgZquJx/UjQ==
X-Received: by 2002:a1c:b7d7:: with SMTP id h206mr3660076wmf.159.1601044119972;
        Fri, 25 Sep 2020 07:28:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t4sm3249819wrr.26.2020.09.25.07.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:39 -0700 (PDT)
Message-Id: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:28 +0000
Subject: [PATCH 00/10] CMake and Visual Studio
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The intention of this patch series is to make it as easy as possible for a
Visual Studio user to start building Git from scratch. The idea is to

 * clone Git's source code,
 * open it in Visual Studio via File>Open>Folder...
 * let CMake configure things (and vcpkg build the dependencies, which will
   take a while), and
 * start the build.

It does require a Git for Windows to be installed (so that the source can be
cloned, but also to run the shell script parts of the CMake configuration),
and also to run the tests.

This patch series replaces the patch "Ignore files generated by CMake" I
sent via https://github.com/gitgitgadget/git/pull/735.

Johannes Schindelin (10):
  cmake: ignore files generated by CMake as run in Visual Studio
  cmake: do find Git for Windows' shell interpreter
  cmake: ensure that the `vcpkg` packages are found on Windows
  cmake: fall back to using `vcpkg`'s `msgfmt.exe` on Windows
  cmake: quote the path accurately when editing `test-lib.sh`
  cmake (Windows): let the `.dll` files are found when running the tests
  cmake (Windows): complain when encountering an unknown compiler
  cmake (Windows): initialize vcpkg/build dependencies automatically
  cmake (Windows): recommend using Visual Studio's built-in CMake
    support
  hashmap_for_each_entry(): work around MSVC's run-time check failure #3

 .gitignore                          |  1 +
 attr.c                              |  2 +-
 blame.c                             |  4 +--
 bloom.c                             |  2 +-
 builtin/describe.c                  |  2 +-
 builtin/difftool.c                  |  2 +-
 builtin/fast-import.c               |  2 +-
 builtin/sparse-checkout.c           |  6 ++--
 config.c                            |  2 +-
 contrib/buildsystems/CMakeLists.txt | 43 +++++++++++++++++++++++++----
 merge-recursive.c                   | 10 +++----
 name-hash.c                         |  2 +-
 revision.c                          |  4 +--
 submodule-config.c                  |  2 +-
 t/helper/test-hashmap.c             |  2 +-
 t/helper/test-lazy-init-name-hash.c |  4 +--
 16 files changed, 62 insertions(+), 28 deletions(-)


base-commit: e1cfff676549cdcd702cbac105468723ef2722f4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-738%2Fdscho%2Fcmake-and-visual-studio-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-738/dscho/cmake-and-visual-studio-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/738
-- 
gitgitgadget
