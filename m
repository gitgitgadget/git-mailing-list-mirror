Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB20C5518A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B418A2075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 04:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es+epnur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgDXEBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbgDXEBk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 00:01:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B23FC09B045
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so8971055wme.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 21:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+9uHwK+2SopMi56CZX3LgDq+0/Zuia6ENFtGg2buZ1E=;
        b=es+epnurrC7FignqNHhek/ox/p+qRjcFC+4kpN31wTuGpe/I37kP8GSxYhNtuInfBc
         7sQvqKOd5CT6jubZFVSl+w6pSEq8z5owyju+3yDCrl/cHPHwgHkd1BIoUudLcmdEAXxS
         2gZBmNhsq2ex3IO79kekJQ7UPY5znNTowIgdBNhL+ylGK9paT1C//aM7QOERXXFYT20O
         JzAF0DJgLsxZzmiPscQLAAEbkPpOr6BGcSaCywJTFChQlPL/G/6ZoAUC5BKoIsZheXsp
         zmYLT547WwVBcukbAuCDpx8nyeqjLkQ1CrHoI3CfC1TKk8I+JRnNfsO6eXq6lyapODg/
         ANeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+9uHwK+2SopMi56CZX3LgDq+0/Zuia6ENFtGg2buZ1E=;
        b=ibxzP8530+fw4ee82QygnghOZ1TCyQzkUorS9wZS9CiZrcPlnu2s1mEh20tSvQWnKP
         PYnR3SVxNxD8O1HXXMJzzTtea165BWr9/OwSb3cLr2h121kMO8DhYq23yjv9iuf34xqH
         rMIpjFSwNLAOCZi+53QHNI5AcGxn4Sf2LgaGm0lJE0sq61Q3abOV59OChChKV9l5/TwT
         1r1rU7y/7to76k7IjwbDVig/DgKAfvHQhQQHmMFW1/YJ3ANZtHa21oXFZsWL/maXs5jr
         R4yGrBNI3MhnwPbrmOUh1oKp9zOaQNCk3f1r/gsqvbiCjjzT4Z7huBWX7lJyJuyECv3q
         zUVA==
X-Gm-Message-State: AGi0PuYrzVB+CJEEMGEf236N5KpZfDeEYOcLJohqWg5rsqxnkAXQM0oj
        I8wh2iy66y87DWYyFpHL9HAH3FTF
X-Google-Smtp-Source: APiQypIYPdS6hA1QlUGwwO+F+fLynsmNmi1hbqB6LsLGoBZTovsBnAJyfseOQmp6tp2lAKxctVa1KQ==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr7685050wmd.162.1587700898863;
        Thu, 23 Apr 2020 21:01:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7sm1049497wmj.12.2020.04.23.21.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 21:01:38 -0700 (PDT)
Message-Id: <pull.614.git.1587700897.gitgitgadget@gmail.com>
From:   "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 04:01:29 +0000
Subject: [PATCH 0/8] CMake build system for git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an attempt to build Git using CMake. CMake is cross-platform build
generator which works well on a variety of platforms(primarily Linux and
Windows). Using CMake we can check whether certain headers exist, certain
functions exist, the required libraries are present and configure the build
accordingly. Using CMake we can also build and test Git out of source,
resulting in a clean source tree.

Tested platforms

Ubuntu 18.04 GCC 7.4 Clang 8.0.1

Windows MinGW GCC 9.2 Clang 9 Visual Studio 2015,2017,2019

Sibi Siddharthan (8):
  Introduce CMake support for configuring Git on Linux
  cmake: generate the shell/perl/python scripts and templates,
    translations
  cmake: installation support for git
  cmake: support for testing git with ctest
  cmake: support for testing git when building out of the source tree
  cmake: support for building git on windows with mingw
  cmake: support for building git on windows with msvc and clang.
  ci: modification of main.yml to use cmake for vs-build job

 .github/workflows/main.yml |  43 +-
 CMakeLists.txt             | 952 +++++++++++++++++++++++++++++++++++++
 2 files changed, 977 insertions(+), 18 deletions(-)
 create mode 100644 CMakeLists.txt


base-commit: 744177e7f7fd407c26e9e4aa3b19696859010c48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-614%2FSibiSiddharthan%2Fgit-og-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-614/SibiSiddharthan/git-og-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/614
-- 
gitgitgadget
