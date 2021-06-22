Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFDFC2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92B0613AB
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 10:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhFVKtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhFVKtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 06:49:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91078C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:46:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e22so19515596wrc.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=gwZZtTJ8LF9hNByKxTZvcSS6nLM7hW9gDCmH8F0tUIo=;
        b=jMSpBgIWK1TcwhBOa0sd5sHC6xAl+g9vm/ymxCOW5xkSkLJdDmeBK19WRWcS66JrkI
         3/KCUMdaezzrsyMCI0PH3SCufbNcToLz/CFQ/bMmjemO9n2/h9rc1dp/RSHtz6+tJ3ht
         aweqHCHrydAXni7mZmIoEDvJcOb13YzHaz1/y0popYoX/q+lzSmfdzj5l/XukUdUGn0h
         KIC3ydP7gdZnNuAcftt7dhLqNbqMJoleJgZzGT+ywlnh2A1ZKqecnRIDG0mRVmOaam2r
         Xu8LoShu+IpawF5hd9I0hkZhT6CV7jeJ/tI+O7GWzdRw27WPw6pFbwyjP/ZZja1Gi8/q
         n5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gwZZtTJ8LF9hNByKxTZvcSS6nLM7hW9gDCmH8F0tUIo=;
        b=gXSQluIib5GsmViGT3d3CcUen7QwdaeJDBJ9hq5zVUGcArPYnL3fBCvWJu89M9vkin
         HgheMNPzdeNPcdegMgAsQ+HGyVdLKq/YS4rZl48P1N/XxqPV0czkj8tb2QOI0vOm+U0F
         xlpjQumvw2fua9WLagRbihhh6TiCQcb4+B5nzdPofGaeO4RxIkjjJK7yTKl9n6xmGPHf
         xJEYJrSqE9RWipl0I3Grov21sqb7NzZ23pqaoWRGr8HuZBmdT+cwYpW6L0krL3gkByh+
         zknfK5D4lKHckA+SMwv6ysiTUIjPj5lwISLwlpX2Mr+VllUMgp6BLWJ+NxL/RYpt/ntv
         CQhw==
X-Gm-Message-State: AOAM533DY+eboZrlad+PG8/00ambW434AfNaCHble5A0N/tyeDVL/ryC
        p/dhwSQqYy5CUlSGjD8UeI5Jxuu7OaU=
X-Google-Smtp-Source: ABdhPJyjdZ06XIeaZiS1ViiEMnRBmMj0gHo0UFtaYdYucup4NOAc7z1uOMvfmlnZVe0pKqqmVOWR8g==
X-Received: by 2002:a5d:6208:: with SMTP id y8mr3842878wru.386.1624358810170;
        Tue, 22 Jun 2021 03:46:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm20360706wrv.37.2021.06.22.03.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 03:46:49 -0700 (PDT)
Message-Id: <pull.984.git.1624358809.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Jun 2021 10:46:45 +0000
Subject: [PATCH 0/3] Move Git for Windows' system config to its top-level directory's etc/
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implementation details let Git for Windows' git.exe live in /mingw64/bin
(that is the pseudo-Unix path, of course, the real Windows path will be
prefixed by the actual installation location). This resulted in the awkward
location of the system config in C:\Program Files\Git\mingw64\etc\gitconfig,
and that is what Git for Windows v2.x used for a few years.

A much more natural location, however, is the same path without that mingw64
infix. Therefore, the Git for Windows project switched (back) to that
location for a while now.

It is time to bring that change into core Git.

Dennis Ameling (1):
  cmake(windows): set correct path to the system Git config

Johannes Schindelin (2):
  mingw: move Git for Windows' system config where users expect it
  config: normalize the path of the system gitconfig

 config.c                            |  7 ++++---
 config.mak.uname                    | 10 ++++++++++
 contrib/buildsystems/CMakeLists.txt | 11 +++++++----
 3 files changed, 21 insertions(+), 7 deletions(-)


base-commit: 670b81a890388c60b7032a4f5b879f2ece8c4558
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-984%2Fdscho%2Fmove-gfw-system-config-to-top-level-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-984/dscho/move-gfw-system-config-to-top-level-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/984
-- 
gitgitgadget
