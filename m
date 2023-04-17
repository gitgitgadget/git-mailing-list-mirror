Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C924C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjDQU4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjDQU4j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:56:39 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3CAC16B
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r184so11480292ybc.1
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764854; x=1684356854;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o17SZ+ao56sZiey1cjgZtHkObgK9qBj3e8TKcY0TUKA=;
        b=3fXGK7UMyXajezbb0bVZMUB7Qf1fvpZ6LzvjuzCiAYOG43MQbrU8pEAsBdVqRJZ2UN
         7tCBLOC2uAv7W5Y+6NPGgOelORyegAfmzRMHKAZ0aVAW1J4BTjYgYjZCLm256tytxS/t
         xSgZhrLShIG+F40wPCwKFVFVwxFu8VKjbf48DIlycJBm78+x8P8g83sVeXKoPY/2VGl6
         iep1fRCuWdcTuuMx1wP2UkvQj1zkiTiarEJhufnChWdMPTvDuf9wHY0F+HFQ54H8/gFY
         s5kbfmKo3xeD9vX9I6giLQwc/ElquAAo1xZkUpw8SaMbRdqBvwJD16MuILSl8A2ftwsE
         q3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764854; x=1684356854;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o17SZ+ao56sZiey1cjgZtHkObgK9qBj3e8TKcY0TUKA=;
        b=f/+6iSrr+QbhLxSifq2ra2qYBVICuU97K+/+xNt0QF768/C0+HLagRlT3XceG19EDj
         7ty0I0Q9N+42C8xyz17VVI5usIuv4Qgtf9EOpJMIMO4b0DtZxCbEcKQDY26AyaxWZxWh
         m3PxWtalQQ1VSKK3nNU9iKJ/BxW6qNXV1huOzUKVObsUnpIRDqqbjPeb++slF9bFKTmA
         dslDWT5/iIXSPulXrxGbuXL4LQy8gm7hRlWZAfV6JVNCBGmnNwsW3coedTIzYfPi2HRY
         B5s/gkOvfdbRzeA+OZDo1xDg2hiGdr6eJTqwmwWY5eMH+dEQdjpUHzWv8e2KI64SS10M
         LmQA==
X-Gm-Message-State: AAQBX9d+s2ftmvBnlI6cUBMZgsLjhZeYAgtIMy0tItH2SDP2SZZbuGFz
        sBczTCP7mNV/aF19/X81G0D0CKBvw+qiUxhR5miUqw==
X-Google-Smtp-Source: AKy350b8VpEq75x93saN8GNmZDTdSnGYtp4ThJTZU9BN9cuP+DmHMkCOqeKsl+fppmzOFcmnUNi/dg==
X-Received: by 2002:a25:dc06:0:b0:b8e:416f:e52e with SMTP id y6-20020a25dc06000000b00b8e416fe52emr15547024ybe.17.1681764853722;
        Mon, 17 Apr 2023 13:54:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 191-20020a8106c8000000b00545a081849esm3373416ywg.46.2023.04.17.13.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:13 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/10] gc: enable cruft packs by default
Message-ID: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series graduates `gc.cruftPacks` out of `feature.experimental` and
enables it by default, meaning that a bare `git gc` will generate a
cruft pack.

The main benefits are described in detail in the second to last patch,
but a brief summary is that:

  - cruft packs avoid an issue where repositories with many unreachable
    objects that were written too recently to be pruned causes an
    explosion of loose object files

  - cruft packs allow pairs of unreachable objects with similar content
    to delta with each other since they can be represented in a single
    pack instead of as individual loose objects.

Cruft packs have been in the tree for the vast majority of the past
calendar year, and have been in use at GitHub for even longer without
issue.

The series is structured as follows:

  - The first two patches are cleanup.
  - The third patches fixes an oversight where the code for `git gc`'s
    `--keep-largest-pack` option would incorrectly consider cruft packs.
  - The next five patches are test preparation.
  - Then the substantive patch, to actually graduate `gc.cruftPacks` and
    enable it by default.
  - The final patch is some cleanup that can only take place towards the
    end of the series.

Cruft packs have been a success for us at GitHub, and I am really
excited to get it in the hands of more users by default.

Thanks in advance for your review.

-Taylor

Taylor Blau (10):
  pack-write.c: plug a leak in stage_tmp_packfiles()
  builtin/repack.c: fix incorrect reference to '-C'
  builtin/gc.c: ignore cruft packs with `--keep-largest-pack`
  t/t5304-prune.sh: prepare for `gc --cruft` by default
  t/t9300-fast-import.sh: prepare for `gc --cruft` by default
  t/t6500-gc.sh: refactor cruft pack tests
  t/t6500-gc.sh: add additional test cases
  t/t6501-freshen-objects.sh: prepare for `gc --cruft` by default
  builtin/gc.c: make `gc.cruftPacks` enabled by default
  repository.h: drop unused `gc_cruft_packs`

 Documentation/config/feature.txt |   3 -
 Documentation/config/gc.txt      |  12 +--
 Documentation/git-gc.txt         |  12 +--
 Documentation/gitformat-pack.txt |   4 +-
 builtin/gc.c                     |   8 +-
 builtin/repack.c                 |   2 +-
 pack-write.c                     |  14 ++--
 repo-settings.c                  |   4 +-
 repository.h                     |   1 -
 t/t5304-prune.sh                 |  28 +++----
 t/t6500-gc.sh                    | 136 ++++++++++++++++---------------
 t/t6501-freshen-objects.sh       |  10 +--
 t/t9300-fast-import.sh           |  13 +--
 13 files changed, 121 insertions(+), 126 deletions(-)

-- 
2.38.1
