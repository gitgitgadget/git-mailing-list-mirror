Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C614CC4332F
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C9C6120A
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhKFVNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhKFVNm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:13:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69AC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:11:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso12161006wmd.4
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzq+9L2bYzdz2pA/J/R4uM9ut5wgCspVmfDrGGLNWrg=;
        b=MgCRYDYjdmvF+Pt1QLBs5BYY4Vogw5RuhAw43CoziovRkBou7aA6Pch9hWblwlWFxA
         wk2NMZNuIDEDREnkSvYe9icoI8z2cdCVVAiDlfjskD/u5E0RX6Y67Fnt0meO5Wlyb3Yh
         FcIFxEFWK7t7sdO1Q2NCQNn8bqeBOviqDy8BPqjxchk+eprZgjxCb+17pWpy+ax7rpYY
         kadRurwUCohkjCS6XrWMwlszmw5fFinqQEo001Xk+maaQgmJo4/GKkVrWnQkJB6TPAtZ
         QXIjugPwJcjDn61uvSKJ+vdVrHFGCrkNmqSumfN0hejJfr3qDBuwuIdsmdfJaHtMkkC3
         GlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nzq+9L2bYzdz2pA/J/R4uM9ut5wgCspVmfDrGGLNWrg=;
        b=edPkH63wuL0BSOtjogn1yAq1EESPs08ziMmX0KNifhJoXVw8OYGzeNFTmVmBWwEfmr
         6H5Bdv+zgfnMmM7qiZIHlOMA5ONCsvw9MKZ+VwRSaV+F0+Sb2vJlp1d/kvrdRmwbYIHQ
         6y0fXsXi2NdVQ+Mbfe9oh+Qz1HDm3FfXHaVx456nWXZTDg+eJGsBomFecAAgodR+Hbv5
         VwZGGA0njZaLn5mPlT6RjVCntZQCB9Y6yiluvikX+phuZTelHKr0S+dGgX3F/cMWbbFz
         lhAU6oF6jT/x5L4AqanSpPvsXA1aie3YPHwbKS5zQ5e0l8VBdxdwQKR4At5b+DYM7wTV
         MC9g==
X-Gm-Message-State: AOAM532zT8mGPDwUmWsDIH5sf8zAmrJ95sX1yDGIC5uH6UkO12QVAl4q
        JKjhG+ZZseAsHccUVSmg8zXwSrgvgSrMuw==
X-Google-Smtp-Source: ABdhPJw51VJgwnNzy95kox30y9GHxevrqrFfGJMWpiLKGkUOqmoK3EEiJ3WB9sZd5swJB4h7lSjTKw==
X-Received: by 2002:a1c:1dd8:: with SMTP id d207mr41266856wmd.46.1636233059088;
        Sat, 06 Nov 2021 14:10:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm9123051wmq.31.2021.11.06.14.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:10:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/8] grep: simplify & delete code by changing obscure cfg variable behavior
Date:   Sat,  6 Nov 2021 22:10:46 +0100
Message-Id: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to use the grep API for more things in some upcoming
optimization patches, and to do that I need to use grep_init(),
grep_config() etc.

These APIs have a very unusual API, and we've got quite a bit of code
in grep.c to support an obscure edge case in how "grep.extendedRegexp"
behaves when clashing with a "grep.patternType" variable present in
the same config space.

This series is an opinionated change of that behavior, and resulting
large deletion of code.

The series starts out by deleting some unused code in grep.c, and
moving a bit of related builtin/grep.c-specific code to that file, and
out of grep.c.

Ævar Arnfjörð Bjarmason (8):
  grep.h: remove unused "regex_t regexp" from grep_opt
  git.c & grep.c: assert that "prefix" is NULL or non-zero string
  grep: remove unused "prefix_length" member
  grep.c: move "prefix" out of "struct grep_opt"
  log tests: check if grep_config() is called by "log"-like cmds
  grep API: call grep_config() after grep_init()
  grep: simplify config parsing, change grep.<rx config> interaction
  grep: make "extendedRegexp=true" the same as "patternType=extended"

 Documentation/config/grep.txt |   4 +-
 Documentation/git-grep.txt    |   4 +-
 builtin/grep.c                |  31 +++++----
 builtin/log.c                 |  13 +++-
 git.c                         |   4 +-
 grep.c                        | 118 ++++------------------------------
 grep.h                        |  34 ++++++----
 revision.c                    |   4 +-
 t/t4202-log.sh                |  16 +++++
 t/t7810-grep.sh               |   4 +-
 10 files changed, 89 insertions(+), 143 deletions(-)

-- 
2.34.0.rc1.741.gab7bfd97031

