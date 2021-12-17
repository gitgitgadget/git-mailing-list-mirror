Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61AFC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 04:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhLQEZY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLQEZX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 23:25:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACB7C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:23 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j9so1754572wrc.0
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ84zD86cEg9mrtWGKMyHKqPWZzfRMaBywR5qYO2BHU=;
        b=VEycnMPlZYWU50TpOiBE82RrKUvlICIRRLPpu1NkdqkwXPXhuLZ3jkDmnYAcJOc5a3
         BacRYfHY11kNJp3E0Cu4fvonWqalrzgKqKjlzO/arac5bYazzDtVJlZXE+W31yPp7dTl
         aDPTKebwz66zrvbMxbuxHUs+Htsm4DdcQvn8wMUG8y1ntFg1MJR2kAdsZB0YpGtYPH0y
         NT4u3lA/682zG+PJmmBN8nUv4nAFIEdogia2h0QOMPttjRYrIzM2NMjsgI74FmWsKNhX
         NyxCgA4WzCz7vEZhsSNUmsLXP3r+vEWB9pRpOfsUk+tD9nN8ri5VuWi4+NXALVuDnFCa
         Ug/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJ84zD86cEg9mrtWGKMyHKqPWZzfRMaBywR5qYO2BHU=;
        b=jojB58wgOq4d4ed0swHGKa2FZK+QVegNKNlNUs3L302no8UEChw5KVR9ZXN7CZMnD8
         epMc++rt3Yoe5EGfoVCZekccvjV2knqNJdYoi0sxW4yr2nMReFmHoV+8sR6wdPB2hJdH
         DQcBGbzXhf+l5eJxsMIFkmYpLYFLsEmrGUUrDToeVJnRaWhuTrqdH3OSnHcidJCcRSF7
         UR3i7Aa1n96mkC7mryFvi8AJdr2zYauJtAASS+tX8VP0K+K7I9tFxgseFbmu8Q62kUxr
         gbF4WVFadAWGCfhW4RU7y/3Go77bEIuQFKbw3yy1pMVt9Fo+PizIAV3YrNe1yWhByHyc
         IJ6w==
X-Gm-Message-State: AOAM530Epy/qwm7/Zn7wlfnHxiCFXnUC+Pzka2cVgr1azbbqe4ts1+fb
        YTz9EPdV9kp2Uh5dOnS6eryPeT+j6nLGRQ==
X-Google-Smtp-Source: ABdhPJwy3/ptw9elp1LOPTnSVVtq5t+Tp8uCm1uFmsduG34ldOzljux5FKsc0CoY3HEm5jTUbr95EA==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr892060wrq.44.1639715121767;
        Thu, 16 Dec 2021 20:25:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o64sm6325634wme.28.2021.12.16.20.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:25:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 0/7] progress: test fixes / cleanup
Date:   Fri, 17 Dec 2021 05:24:55 +0100
Message-Id: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A series that used to be about adding a "global progress" state, but
started with some cleanups & adding the ability to test that mode. See
[1] for the v6 and [2] for a discussion on the previous 8/8 patch.

This v7 ejects that 8/8 patch. I think it's safe to merge down, but
per [3] etc. this topic has been stalled for a while in "needs
review". I think it's had enough thorough review. The sticking point
has been me & SZEDER disagreeing on whether adding that BUG() in the
previous 8/8 can be deemed safe or not.

So let's bypass that for now and hopefully queue these up. Once this
lands we can re-visit that 8/8 and various other progress.c API & UX
improvements I have unsubmitted, which have been blocked by this
topic.

1. https://lore.kernel.org/git/cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com/
2. https://lore.kernel.org/git/211203.868rx2t0hv.gmgdl@evledraar.gmail.com/
3. https://lore.kernel.org/git/211115.86wnl9qkfz.gmgdl@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (7):
  leak tests: fix a memory leaks in "test-progress" helper
  progress.c test helper: add missing braces
  progress.c tests: make start/stop commands on stdin
  progress.c tests: test some invalid usage
  progress.c: add temporary variable from progress struct
  pack-bitmap-write.c: don't return without stop_progress()
  various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)

 builtin/bisect--helper.c    |  2 +-
 builtin/bundle.c            |  2 +-
 compat/mingw.c              |  2 +-
 pack-bitmap-write.c         |  6 +--
 progress.c                  |  5 +-
 t/helper/test-progress.c    | 52 +++++++++++++++-----
 t/t0500-progress-display.sh | 94 ++++++++++++++++++++++++++++---------
 7 files changed, 121 insertions(+), 42 deletions(-)

Range-diff against v6:
1:  88d89652831 = 1:  5367293ee84 leak tests: fix a memory leaks in "test-progress" helper
2:  2fa92e7db83 = 2:  81788101763 progress.c test helper: add missing braces
3:  400b491449e = 3:  d685c248686 progress.c tests: make start/stop commands on stdin
4:  7557975a122 = 4:  40e446da277 progress.c tests: test some invalid usage
5:  61c8da31aeb = 5:  c2303bfd130 progress.c: add temporary variable from progress struct
6:  f6a76b80e91 = 6:  776362de897 pack-bitmap-write.c: don't return without stop_progress()
7:  1a2eadf28d0 ! 7:  0670d1aa5f2 various *.c: use isatty(0|2), not isatty(STDIN_FILENO|STDERR_FILENO)
    @@ Commit message
         {STDIN_FILENO,STD{OUT,ERR}_FILENO} macros in "stdlib.h" to refer to
         them.
     
    -    Let's change these for consistency, and because a subsequent commit's
    -    commit message outlines a recipe to change all of these for ad-hoc
    -    testing, not needing to match these with that ad-hoc regex will make
    -    things easier to explain.
    +    Let's change these for consistency, and because another commit that
    +    would like to be based on top of this one[1] has a recipe to change
    +    all of these for ad-hoc testing, not needing to match these with that
    +    ad-hoc regex will make things easier to explain. Only one of these is
    +    related to the "struct progress" code which it discusses, but let's
    +    change all of these while we're at it.
    +
    +    1. https://lore.kernel.org/git/patch-v6-8.8-bff919994b5-20211102T122507Z-avarab@gmail.com/
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
8:  bff919994b5 < -:  ----------- progress.c: add & assert a "global_progress" variable
-- 
2.34.1.1119.g7a3fc8778ee

