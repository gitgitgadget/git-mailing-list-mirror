Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9392ECAAA1
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 17:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiISRrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 13:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiISRro (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 13:47:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C492A3D5BD
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e16so285564wrx.7
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=rkaercVm3D13XqpypTynuv9PaPXClvP8nER7b0Vf/qM=;
        b=mn7mJEhQeldWo2Oh69Yjt7cqDZsNvpjqiWvXUa+xH6Ot/Rjta/sJn2w4QzlYBAzfa7
         bmVjeqJpKHQfuN34GKfUFU7hItTgb8IjWDjOzdMpDVWxgryQHvRCxVVE44yn+Op4mA+X
         vNMZdWVkBe0uuGq5IiQQUodb6fbU4unC1I5+8a2pSXQzYUYYjJ+/F6Ko4Mr8cWQxmPvT
         ara6IgR+3+/iFILFn27CRF+hH9ccOjbY2DE43tIGu7dpxFYLGmYLQak2LUO21pnhbVMX
         UjHdF5acNw6ODLm7efjsXT92e9GLQtmcEOKghVTKkjcb8VI/fBfchcfYxIf8Vn0pLZWT
         VD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=rkaercVm3D13XqpypTynuv9PaPXClvP8nER7b0Vf/qM=;
        b=ZD8wgKPukDtUBqcJtymcbJWNRyzhLfA7hR40fN8TXgyUva6V/iQH2VzUZo2Tpm9RUD
         vT1/cB6IJx0l8nqL46y4vTNjsBtcz1lLFUxJ+qKK+NWfhEZqHtCactNAWXiiUQgboGLm
         rw1Tk396XJo5WlSmht1BoQ7g2IFiOkEOSF5JZSeYZqEVBuSWmL/dRPGMU4jnpwGYwUXk
         QFZI+ICtfEcpcKqXAIc+PGkSjlm22FL1BCpeEjhlm1ijOcpLpfn7dZbyXBVUWOnt89XM
         tKiVMJRaVrrtRpuUEctK4ZuHEybZGc/7obT/laJw3upddVaQtUHmqy0vtqNzfSWWyZoT
         vJfg==
X-Gm-Message-State: ACrzQf2pG6GUIRh6txAkLVHDcKhN8bwQvnLl3TO2ixKRZ2Slo0XgJbOM
        gRtPFOzmqGqQJA+GrX9arRI68IsexA4=
X-Google-Smtp-Source: AMsMyM7AMFMBL32jNku6TVB2egSIGm6TA0CniumFiDyoOKZchNB1jEDxvtYiVRnnw8pgBxU6EnwXmA==
X-Received: by 2002:adf:eec3:0:b0:22a:d159:456c with SMTP id a3-20020adfeec3000000b0022ad159456cmr11033148wrp.463.1663609661151;
        Mon, 19 Sep 2022 10:47:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6b84000000b002286670bafasm14326070wrx.48.2022.09.19.10.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:47:40 -0700 (PDT)
Message-Id: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 17:47:34 +0000
Subject: [PATCH 0/5] [RFC] introduce Roaring bitmaps to Git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git currently uses ewah bitmaps ( which are based on run-length encoding) to
compress bitmaps. Ewah bitmaps stores bitmaps in the form of run-length
words i.e. instead of storing each and every bit, it tries to find
consecutive bits (having same value) and replace them with the value bit and
the range upto which the bit is present. It is simple and efficient. But one
downside of this approach is that we have to decompress the whole bitmap in
order to find the bit of a certain position.

For small (or medium sized) bitmaps, this is not an issue. But it can be an
issue for large (or extra large) bitmaps. In that case roaring bitmaps are
generally more efficient[1] than ewah itself. Some benchmarks suggests that
roaring bitmaps give more performance benefits than ewah or any other
similar compression technique.

This patch series is currently in RFC state and it aims to let Git use
roaring bitmaps. As this is an RFC patch series (for now), the code are not
fully accurate (i.e. some tests are failing). But it is backward-compatible
(tests related to ewah bitmaps are passing). Some commit messages might need
more explanation and some commits may need a split (specially the one that
implement writing roaring bitmaps). Overall, the structure and code are near
to ready to make the series a formal patch series.

I am submitting it as an RFC (after discussions with mentors) because the
GSoC coding period is about to end. I will continue to work on the patch
series.

Abhradeep Chakraborty (5):
  reachability-bitmaps: add CRoaring library to Git
  roaring.[ch]: apply Git specific changes to the roaring API
  roaring: teach Git to write roaring bitmaps
  roaring: introduce a new config option for roaring bitmaps
  roaring: teach Git to read roaring bitmaps

 Makefile                   |     3 +
 bitmap.c                   |   225 +
 bitmap.h                   |    33 +
 builtin/diff.c             |    10 +-
 builtin/multi-pack-index.c |     5 +
 builtin/pack-objects.c     |    81 +-
 ewah/bitmap.c              |    61 +-
 ewah/ewok.h                |    37 +-
 midx.c                     |     7 +
 midx.h                     |     1 +
 pack-bitmap-write.c        |   326 +-
 pack-bitmap.c              |   969 +-
 pack-bitmap.h              |    27 +-
 roaring/roaring.c          | 20047 +++++++++++++++++++++++++++++++++++
 roaring/roaring.h          |  1028 ++
 t/t5310-pack-bitmaps.sh    |    79 +-
 16 files changed, 22490 insertions(+), 449 deletions(-)
 create mode 100644 bitmap.c
 create mode 100644 bitmap.h
 create mode 100644 roaring/roaring.c
 create mode 100644 roaring/roaring.h


base-commit: d3fa443f97e3a8d75b51341e2d5bac380b7422df
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1357%2FAbhra303%2Froaring-bitmap-exp-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1357/Abhra303/roaring-bitmap-exp-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1357
-- 
gitgitgadget
