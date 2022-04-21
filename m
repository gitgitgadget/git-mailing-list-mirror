Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C2C4332F
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 14:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389758AbiDUPAo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389774AbiDUPAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 11:00:42 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9A245065
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 07:57:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso6056257wme.5
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=OQB3/A/sJ6Dwst/RlHCV0k+l/uZVuL1ceODz4LuyusE=;
        b=gajnsGtb2yfiXDR3KbYSui22N5lnuG6EdPSzhiTa7xCDHCPiLpNg6MrHPs8utQNucw
         adDGU+uanMRpi+GoeDNsoyeszxgxfEpYYtlzOzLU2uF1EZO3ZL73WSPfdAvpOFZsysYg
         q/wwK/y2nVLqDfl5dxHsBgEyeUblLjUnUbenn9jdIDm1SdI0CnVR+eosI3RLcov1H6oy
         IGcDQea9ejhwh/NUERgeaxKsbbmknME/RdO/ca3miFoQuEN1+9oxaz4ovGrLfSonifQn
         tUyTbhszKTmYCyKqSzDRfEw4dH2jWVY0+yA1qFS2V66K4eE9EV/P18UzpSrc5lK31oyH
         YhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OQB3/A/sJ6Dwst/RlHCV0k+l/uZVuL1ceODz4LuyusE=;
        b=OkLrvjJ3nO5ER4XTvYN5+zwqcWMcd/DqZejrxHsnNVpFFP8QLi+C6BFod6Er3lyYwU
         xaUriUHaJ8BCUlucQDbIuEXMh2hgBa9iRAE6vgBDyHAqimbxIYEu67YyEcjuouJj/qvq
         dzVFMoyboD03zs9j/SwmElpq7fobZwJrXbrk5xVTAU7psny1gZX0Br99e8nWX2MojOeH
         gPpfH1NvkHSR5yQtAxozkwqvVatJ4+Eu48YjXDCE8UPR7pZXo18elk+milAl5LrAA1g/
         snQaDR/iiFYCnMHeoXTDrbPOTVpd1x4//lEOd27PgNNJa1HBswhnbCkjasQx5fzuFDMV
         Fvjw==
X-Gm-Message-State: AOAM531wdO00Qu+r2ZCcu30JWiWWTg4GUT4q1ZUEYIdoGgLTzHlq1NZY
        RKyVbOCp8kgtjHH8ehf0GK/OMYsWT/M=
X-Google-Smtp-Source: ABdhPJyP06NEks2oH9R369RzQ7m3ze/0vD8fUoE1SEN7gwWH2H+hQazAO58JCvb+YOHWgcd4Xu0MZw==
X-Received: by 2002:a7b:c0d5:0:b0:38e:ca29:f40 with SMTP id s21-20020a7bc0d5000000b0038eca290f40mr9047034wmh.205.1650553070994;
        Thu, 21 Apr 2022 07:57:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm2440248wrf.80.2022.04.21.07.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:57:50 -0700 (PDT)
Message-Id: <pull.1221.git.1650553069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Apr 2022 14:57:47 +0000
Subject: [PATCH 0/2] multi-pack-index: use real paths for --object-dir
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A VFS for Git user reported [1] that the background maintenance did not seem
to be doing anything. At least, the 'git multi-pack-index expire' and 'git
multi-pack-index repack' steps did nothing. The 'write' subcommand worked to
collect all pack-files into a single multi-pack-index file, but the packs
were only growing in number instead of being maintained carefully.

[1] https://github.com/microsoft/git/issues/497

The root issue is about path comparisons between Windows and Unix path
styles.

The fix is two-fold:

 * Patch 1 performs real-path normalization at a low-level where it is
   required.
 * Patch 2 performs real-path normalization at a high-level to be extra
   safe.

I'm not exactly sure how to test this properly in the Git codebase, but I'm
looking to add some tests into VFS for Git to ensure this doesn't regress in
the future.

Thanks, -Stolee

Derrick Stolee (2):
  midx: use real paths in lookup_multi_pack_index()
  multi-pack-index: use --object-dir real path

 builtin/multi-pack-index.c | 19 ++++++++++++++++---
 midx.c                     | 17 +++++++++++++----
 2 files changed, 29 insertions(+), 7 deletions(-)


base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1221%2Fderrickstolee%2Fmidx-normalize-object-dir-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1221/derrickstolee/midx-normalize-object-dir-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1221
-- 
gitgitgadget
