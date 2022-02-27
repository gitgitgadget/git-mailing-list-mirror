Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4F2C433FE
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 21:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiB0V5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 16:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiB0V5m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 16:57:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF766E4D5
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 13:57:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s1so12561457wrg.10
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 13:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=smaDptVsm5TPoMFW7J2Wg3Y2goQXcaqJbfhqrwmntuM=;
        b=XSXL+V0pa+hCvRhi8Bz/fc3bxJBK/uhP6SNXSx6P/TQ221iULbzYhYRy60rn8VcJAV
         FyMKHACgtgPpVi0w9fDiYBwnYfQJdOC4upOBBCiCfTg5CpmvG1guFypqDcBASPU6wzZH
         AfzdPKRg8nZnG7ynn9wtbusjhTL1fy4YsXo+EQ3rz223YzqnRV5PalWtmhDE8iBbhcWw
         HipsbZgDHf4dqT5CkkB+88Cx5ryrMvritp++I6QFMD+4RVUh3vFG89VptkS9iQQDtQQf
         56zCkOccjRBrBp2m01BDrFhr8jUM6uoj1NUQnwwSu+235gWcrdwMAnrowk2WwZXSq4fw
         ONAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=smaDptVsm5TPoMFW7J2Wg3Y2goQXcaqJbfhqrwmntuM=;
        b=3eSidjFBZmiv4dGnZaw4Bl6MdZYaJjghvvztGw9GVPqsRfYejOWwaGylh1heY0iXdA
         XJWEZmQmLL2JOTO+1LRJSa5+9BsGy5/J97XXtXm3cd+4rCRlEAH19NjqfHn0meVY16jN
         6jVZAJK6bAYzrB59O/pARUcss3CIFaLG0Eo6XDDnEBNTeaxtKBUD8REjYh8+uAf73noH
         9vAUIJMl63e5JgIDIRi6iPbnofEBcCBvXlswiZmowsqXIS0/uUbGvAPbmxoR7fxcEAD5
         mZih7+0mlrOKWpqivvBM8tEXEVlqh8IwBQP6WHyx55ttHkgPInXEcj/g2+Jlo5GJMNIP
         v98w==
X-Gm-Message-State: AOAM531Ag1jCbEkXj1YOGtO62+b8d5zLCNTiUzT3nvQNRzovANvbNt+m
        ekMITKIKqMnlntUDCp5nl80Zn/pwqSY=
X-Google-Smtp-Source: ABdhPJyQWE04KMAwD2VZhubCePdDiGLSPtQu9/nlmYGVXy/Z+ThBcaygrF5xqJ7G0vWi37eJGgLTTQ==
X-Received: by 2002:adf:fe85:0:b0:1ed:895b:a90d with SMTP id l5-20020adffe85000000b001ed895ba90dmr13488116wrr.55.1645999022865;
        Sun, 27 Feb 2022 13:57:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t8-20020a5d6908000000b001e3169cc6afsm8727097wru.94.2022.02.27.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 13:57:02 -0800 (PST)
Message-Id: <pull.986.v3.git.1645999021.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
References: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Feb 2022 21:56:58 +0000
Subject: [PATCH v3 0/3] Empty untracked cache performance issue
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset addresses a performance issue with untracked cache. When a new
untracked cache structure is added to the index but remains empty,
subsequent "git status" calls populate it but do not write the index - so
they perform as though the index were disabled.

This situation can be caused in several different ways:

 * Running "git update-index --untracked-cache" on a repo that did not have
   the untracked cache
 * Modifying the git configuration to enable untracked cache, but then
   immediately running "git status -uall", causing the untracked cache to be
   created, but not used/populated (and the index written).
 * (likely others)

The patchset includes fixes to t7519, which otherwise starts failing because
it wasn't testing what it intended to.

Tao Klerks (3):
  t7519: avoid file to index mtime race for untracked cache
  t7519: populate untracked cache before test
  untracked-cache: write index when populating empty untracked cache

 dir.c                       | 10 +++++++---
 t/t7519-status-fsmonitor.sh |  7 +++++++
 2 files changed, 14 insertions(+), 3 deletions(-)


base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-986%2FTaoK%2Ftaok-empty-untracked-cache-bug-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-986/TaoK/taok-empty-untracked-cache-bug-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/986

Range-diff vs v2:

 1:  9421b71540d ! 1:  8b1f89c259e t7519: avoid file to index mtime race for untracked cache
     @@ Commit message
          t7519: avoid file to index mtime race for untracked cache
      
          In t7519 there is a test that writes files to disk, and immediately
     -    writes the untracked index. Because of mtime-comparison logic that
     -    uses a 1-second resolution, this means the cached entries are not
     -    trusted/used under some circumstances
     +    writes the index with the untracked cache. Because of
     +    mtime-comparison logic that uses a 1-second resolution, this means
     +    the cached entries are not trusted/used under some circumstances
          (see read-cache.c#is_racy_stat()).
      
          Untracked cache tests in t7063 use a 1-second delay to avoid this
          issue, but we don't want to introduce arbitrary slowdowns, so instead
     -    use test-tool chmtime to backdate the files slightly.
     +    use test-tool chmtime to backdate the files slightly. The t7063
     +    delays are a #leftoverbit, to be worked on in a separate series.
      
          This change doesn't actually affect the outcome of the test, but does
          enhance its validity, and becomes relevant after later changes.
 2:  d29a68e65a0 = 2:  c901f9d96ca t7519: populate untracked cache before test
 3:  190b27e518a = 3:  9795a08414a untracked-cache: write index when populating empty untracked cache

-- 
gitgitgadget
