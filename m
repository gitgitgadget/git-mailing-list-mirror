Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00E0C433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FE764E79
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 21:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhBQVDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 16:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBQVDT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 16:03:19 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF4C061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:38 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o21so10646956qtr.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 13:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sl5Gt+s6CFqxZOdWncTO27zlrWEJu6nIv7nXrXW4fDo=;
        b=SaZZHjoDDl9OWqsOGkql3U/G2VU4VV+FiC6/uALWzEeay3zcSnUrRsqINPw166r777
         fr5cIjkVV2ZG4ZXF1flIm0RAVceztGb1O7XRCc6W587SD0r4FQa6ii59MApg+jgl4mCk
         NOFRownJmn5Ma8pjzP+pLWURgA2mVHJ8bXrODXSTd9TgkCPhnMpNCYE4fDixbmCkjGmt
         a+k02tuj+J3HJoxqGibON8jhGvdW15QTMeGSvnqh6a/+vLoiVSkO3o8nlyjwghQaIJIk
         jPL5hxceb2RwOF+VXGjA46+utRbHGITsv/KffnmTYr8haOpjFRbiQOmFfmKJEa4zdUjf
         msoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sl5Gt+s6CFqxZOdWncTO27zlrWEJu6nIv7nXrXW4fDo=;
        b=ZIGiDCjkfw8d5/B0g3EsQKG8ZtlTXxEtgrS7/Qsvs1Xbozgd84V9+5FESLW58gUdv2
         PfCJDx9u6dVPH76ICRRSIkn5BBNHT001xSN1v63NKsW8Cix92U7sJjD/PNUyqnux0gXb
         hT7+TBZVL0u7t2GXB5NyiBGWTLeDGCK2RE63rN7xUXBXLqb3rC6aX3YzmU3dFsiRX2cG
         CfobhyWo/Cz8tdETSUkbLAbKNrARgDHnZE3UuVzAC4LTK9KqMassvtDXhka8BCnEtcLn
         yg8R07Kl38G9whIeiiTJ3WBCVCeiWmj+vaKuxjObG0Tv37owkRq5RrdlPESM7WNXHU5Z
         Jzpg==
X-Gm-Message-State: AOAM531E8Kb69778X96xviJ4PqSI1j463hokSFAhX01732O1YR8u1LNj
        xhicuydPu/TvyqB1OnzxemPNhrd1fSe0sw==
X-Google-Smtp-Source: ABdhPJzLo5IM+Qxl2B7KioLaaJgcTPuUcNAjxhO0EKfR/NtwER7WjENkrZJUCKMo2NiQKrU5FHiGDw==
X-Received: by 2002:ac8:5a82:: with SMTP id c2mr1237184qtc.90.1613595757601;
        Wed, 17 Feb 2021 13:02:37 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id o194sm2438459qke.101.2021.02.17.13.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:02:36 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, stolee@gmail.com
Subject: [RFC PATCH 0/7] add/rm: honor sparse checkout and warn on sparse paths
Date:   Wed, 17 Feb 2021 18:02:23 -0300
Message-Id: <cover.1613593946.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <c17158e3b105d7c0679515446c5fd7b8d5fc8435.1605535068.git.matheus.bernardino@usp.br>
References: <c17158e3b105d7c0679515446c5fd7b8d5fc8435.1605535068.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on the discussion at [1]. It makes `rm` honor sparse
checkouts and adds a warning to both `rm` and `add`, for the case where
a pathspec _only_ matches skip-worktree entries. The first two patches
are somewhat unrelated fixes, but they are used by the later patches.

[1]: https://lore.kernel.org/git/CABPp-BHwNoVnooqDFPAsZxBT9aR5Dwk5D9sDRCvYSb8akxAJgA@mail.gmail.com/

Matheus Tavares (7):
  add --chmod: don't update index when --dry-run is used
  add: include magic part of pathspec on --refresh error
  t3705: add tests for `git add` in sparse checkouts
  add: make --chmod and --renormalize honor sparse checkouts
  pathspec: allow to ignore SKIP_WORKTREE entries on index matching
  add: warn when pathspec only matches SKIP_WORKTREE entries
  rm: honor sparse checkout patterns

 Documentation/config/advice.txt  |   4 +
 Documentation/git-rm.txt         |   4 +-
 advice.c                         |  19 +++++
 advice.h                         |   4 +
 builtin/add.c                    |  72 ++++++++++++++----
 builtin/check-ignore.c           |   2 +-
 builtin/rm.c                     |  35 ++++++---
 pathspec.c                       |  25 ++++++-
 pathspec.h                       |  13 +++-
 read-cache.c                     |   3 +-
 t/t3600-rm.sh                    |  54 ++++++++++++++
 t/t3700-add.sh                   |  26 +++++++
 t/t3705-add-sparse-checkout.sh   | 122 +++++++++++++++++++++++++++++++
 t/t7011-skip-worktree-reading.sh |   5 --
 t/t7012-skip-worktree-writing.sh |  19 -----
 15 files changed, 349 insertions(+), 58 deletions(-)
 create mode 100755 t/t3705-add-sparse-checkout.sh

-- 
2.29.2

