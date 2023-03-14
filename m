Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFBCC6FD1F
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 01:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjCNBxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 21:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCNBxm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 21:53:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7D61528
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:53:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so27302wms.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678758819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=txPCP4uy7g5nFwCWt9jjWUpvg3YSH3jCXjjX/e/Tji8=;
        b=FfjOW7QcQYC9IFZEXVevvYuV2PE7zSawuH978RNi4RUb/AinPJVVdC77/wTXdeunlO
         hm6Xe6u7VDbgJhE07Fx4dLzSWVaZPYoqMeDupsZD9/eEyK6hmn3gk6Gnep6O+n1sfv2u
         q7nHa6PpHvLUkrFaoPRsV+Fw0pEvhiumD9XbewTZg9lqy6chR2wrEfh3TQkNW/LtljEO
         qRB2prAPrclJjVtpYuDveKf7MY4B+pD4ODukpmQz2SRGRlkiQdqH17NVQmsHXjHDBhLp
         nYxbrOygZfCOR3h/3sXlkmFnExaaT6cmymB7MD9cYazTR9g+pmdac7/a515TR4Vg0zbV
         GlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678758819;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txPCP4uy7g5nFwCWt9jjWUpvg3YSH3jCXjjX/e/Tji8=;
        b=MTkgaXcRFdapxEJVNmRbqDXwS/imqhGfUVTeg/uKloW55NJNJBd5KWCIHz+hnFflzw
         l5H3OUXNNrykLNJRIUHkBT6THk6zRxflOdxae9nKB0EayNNQCCZYfR1ocfhdVhMHR9GO
         2QCKymPb9lc26JPFa1v3XLZY2c8LnmVkPYDIM7IcrojHMOhBQhT6PnqNx1455+SQkBK8
         F5n9ucY75JCncz030V5tFeg5jIbZooJ/LA0d4aJoMh2CExs9d6poZr6/WPPiOD9THJ6s
         sPJfbj/3Hsb0aFbmeoq/+V6XBNTviat/ZUFPJbv6rbl/zfHfs1KfUy7Oc6QGHbxSGVVM
         qoRA==
X-Gm-Message-State: AO0yUKV8uriXdsGpUlyaLDIN8axpjuNGz3McupIarlDezkrS+DhuOVik
        CtACuPqVJUtN2m3xgN6QGJeosQFwSb4=
X-Google-Smtp-Source: AK7set8MVIvX9BteeYPmCTTldjTXXeuG7hwGRyZ5QW4BTQ26Lpl2C6/4IUUt2oltNONabG+NzB63UQ==
X-Received: by 2002:a05:600c:5493:b0:3ea:edc7:aa59 with SMTP id iv19-20020a05600c549300b003eaedc7aa59mr13048560wmb.32.1678758819723;
        Mon, 13 Mar 2023 18:53:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c2cc600b003df5be8987esm1282871wmc.20.2023.03.13.18.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 18:53:39 -0700 (PDT)
Message-Id: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Mar 2023 01:53:36 +0000
Subject: [PATCH 0/2] diff: support bare repositories when reading gitattributes for diff
 algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series adds support for bare repositories for the feature added
in [1]. When using a bare repository, by default we will look for
gitattributes from HEAD. When the --attr-source option is passed, we will
try to read gitattributes from the commit.

A side effect of this patch series is that custom drivers will now also work
with bare repositories.

 1. (a4cf900ee7 diff: teach diff to read algorithm from diff driver,
    2022-02-20)

John Cai (2):
  diff: use HEAD for attributes when using bare repository
  diff: add --attr-source to read gitattributes from a commit

 Documentation/diff-options.txt  |  4 ++++
 Documentation/gitattributes.txt |  8 +++++++
 diff.c                          | 37 ++++++++++++++++++++++++++++++---
 diff.h                          |  1 +
 t/lib-diff-alternative.sh       | 33 ++++++++++++++++++++++++-----
 t/t4018-diff-funcname.sh        | 29 ++++++++++++++++++++++++++
 userdiff.c                      |  9 +++++++-
 userdiff.h                      |  4 ++++
 8 files changed, 116 insertions(+), 9 deletions(-)


base-commit: d15644fe0226af7ffc874572d968598564a230dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1459%2Fjohn-cai%2Fjc%2Fdiff-attr-bare-repo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1459/john-cai/jc/diff-attr-bare-repo-v1
Pull-Request: https://github.com/git/git/pull/1459
-- 
gitgitgadget
