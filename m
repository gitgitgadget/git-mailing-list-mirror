Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D4C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138B1610E9
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhEGEGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhEGEGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:06:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099CC061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 21:05:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h4so7671951wrt.12
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EVwtTIS8VIwIo9Zzd+3x8hpnM1EjFdDxuit1aF+XSkE=;
        b=S8sLnxs6nzoOz7cHK2c9Erm4d8EtbIG1a3XExRi6ojoKWvXAIPjtogz8smxRG69fKO
         TQXJ2DDY16dAK6T31A4LD9MrIDeCiyG4q4yi7Fjavfm93DJDTj4VHXKTWt6GNBcqjc6h
         0W0WCZn2SlHzkwM9k7dRX6IuVDTblyqDDZXS8jLd3ycMM9AfcIQoN6G5LeLnxlDL0m0O
         lXsPSmGWFs1hh/xMriVqpQ0Hh/g752uoJh5Rb82WcLXyuPTzEO13h7vCorEybN2BDG0a
         JrcpNA7kURy/hot6QhssBiUqqC0dYYpxtlHLG4m1+i7jKbyx15INceTk6xrJgmCuZ4xv
         3UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EVwtTIS8VIwIo9Zzd+3x8hpnM1EjFdDxuit1aF+XSkE=;
        b=MM88DOGAT5YyYYbDf65O4oWRYlZwrtrKlje0h45uHBKJwQCRuSgVOTCFliimB3WtIN
         Nrm607y87XZTz16KGMS4tknoRCRw7v85JN0DC2530zIbWsXg98nzPZZAAMXHcGtZQz7l
         ukeGnDtvd7vz7W4iDdQXxzERGjhvHFmXnWxHFe8Yus2pxlP8Alr/Phw5yiJBLw0gmzUU
         7Bfa4GzHteF71N+JHMzcEVH/paYm9ElRb067q0GQYhOyAYWDzA3QidTPfqtVyJiGDKZN
         G8K07Dl/TIdTSuORiRinN+f6efu7EwHF7GnTlCKlcAB1zYHKGTGYFKoAm3EOijtUlxwf
         yyhA==
X-Gm-Message-State: AOAM532QG+L8aHopKaMoLn890wGdgjNcv/jwS6QPpe/eUKWuapZgVBm7
        I4Lz7oWXn6Ejso77Lg7Y+stas87hbSU=
X-Google-Smtp-Source: ABdhPJx1ky0nkWqASLlHS04YCg9camNsoMJ4Pui1Viqlgz9yQZfRfsAUkHgMft5K83OaceUJGLmwgQ==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr9453431wrq.193.1620360301657;
        Thu, 06 May 2021 21:05:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19sm5569954wme.48.2021.05.06.21.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 21:05:01 -0700 (PDT)
Message-Id: <pull.1020.git.git.1620360300.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 May 2021 04:04:55 +0000
Subject: [PATCH 0/5] Directory traversal fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset fixes a few directory traversal issues, where fill_directory()
would traverse into directories that it shouldn't and not traverse into
directories that it should. One of these issues was reported recently on
this list[1], another was found at $DAYJOB.

The fifth patch might have backward compatibility implications, but is easy
to review. Even if the logic in dir.c makes your eyes glaze over, at least
take a look at the fifth patch.

Also, if anyone has any ideas about a better place to put the "Some
sidenotes" from the third commit message rather than keeping them in a
random commit message, that might be helpful too.

[1] See
https://lore.kernel.org/git/DM6PR00MB06829EC5B85E0C5AC595004E894E9@DM6PR00MB0682.namprd00.prod.outlook.com/
or alternatively https://github.com/git-for-windows/git/issues/2732.

Elijah Newren (5):
  t7300: add testcase showing unnecessary traversal into ignored
    directory
  t3001, t7300: add testcase showcasing missed directory traversal
  dir: avoid unnecessary traversal into ignored directory
  dir: traverse into untracked directories if they may have ignored
    subfiles
  [RFC] ls-files: error out on -i unless -o or -c are specified

 builtin/ls-files.c                 |  3 ++
 dir.c                              | 50 ++++++++++++++++---------
 t/t1306-xdg-files.sh               |  2 +-
 t/t3001-ls-files-others-exclude.sh |  5 +++
 t/t3003-ls-files-exclude.sh        |  4 +-
 t/t7300-clean.sh                   | 59 ++++++++++++++++++++++++++++++
 6 files changed, 103 insertions(+), 20 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1020%2Fnewren%2Fdirectory-traversal-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1020/newren/directory-traversal-fixes-v1
Pull-Request: https://github.com/git/git/pull/1020
-- 
gitgitgadget
