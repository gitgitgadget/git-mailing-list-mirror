Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A9C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDJWx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJWx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:53:26 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13490173C
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id u13so6338811ybu.5
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681167204; x=1683759204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0drjlbEuyMcEtZl3ijl7ek3mudC6OHCJewHhfTLtsJ8=;
        b=AiXk6q84L2XlF4EL83F8Id3nHH5q1O+gk7vWQO7GqbKyELeJA0FKNP9JlN84GkHM1k
         7AYu0+k+vJoUe+hjQ5Ay1l+jz7uf/8MNqqVxfvdaydxkPHxVleB119UgMc0/hOTHDKk+
         d65HyH0K3e2XQrZf9/jt8YLM+76ygWEiias2deNrdeHHPU7SuvR3kfTvpeFGu2t5pQTF
         17zyZ96RBz7WTPZNRfH+L8+6dEakPQuNujyabdVuwzxHf5iXDE3BUYwgI89YuWYnm48T
         AqYT/SJcqD8MtCLS8JkUy/NSL/HkP0zrGg0LWqMFDhHPouEpjao2YuTmh3v1B9tr1zhf
         Oeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167204; x=1683759204;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0drjlbEuyMcEtZl3ijl7ek3mudC6OHCJewHhfTLtsJ8=;
        b=Ax8G531qHdvAgaeRd+MGSWGIlqZ126dXe7Rx/wGWhLNETu0t7ATmbNrL8W+PmrvrQS
         d2XaLZpFP2aO7l4Lc1b9fyptS7/sjVM1TLnjdEdbJmZ6BlvDMDDSn7Po/6Hoc16lBIVV
         j6fcb6apeN/HBVcENLQ92O3dAJwiRUZhEyKlrKxoggnxJx7Aoc0iy2GQHqdFsp03txiI
         kbPaAGWgqRP785gyb8TWpZW5X0OKWpqbVEc0usYMAqfZIDOoGKu014HFI0I9iP8XyYUT
         Ajg6C2TmAY7K0YXk9D4bUCEXgN5IQdc1hHoZ6t0aeDfnH26EfvKoTPLsWo8hujf+Be50
         JXaw==
X-Gm-Message-State: AAQBX9fAaQhBNkfrnbICf1U6HVewglyDRxFqsfWdUAEuh3n4n24oh1zk
        0jZbpQRJPQpdFOorsY7QHU0AHesphhX2IFPSQ8HsbQ==
X-Google-Smtp-Source: AKy350bwrsjujeTLjYYGbGuUPZKVToOkZRCUBDfj1+CoJk91tK8myfvnqKqCY3vEgekLMteOMxXUxg==
X-Received: by 2002:a05:6902:1207:b0:b8e:f653:45d8 with SMTP id s7-20020a056902120700b00b8ef65345d8mr4836810ybu.40.1681167204028;
        Mon, 10 Apr 2023 15:53:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j19-20020a25d213000000b00b7767ca7487sm3230922ybg.36.2023.04.10.15.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:53:23 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:53:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/7] pack-revindex: enable on-disk reverse indexes by default
Message-ID: <cover.1681166596.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series enables pack reverse-indexes to be written to disk by
default instead of computed on-the-fly in memory.

For repositories with large packs, this can have a significant benefit
for both end-users and Git forges. Extensive performance tests appear in
the fifth and sixth commit, but here are some highlights:

  - The time it takes to generate a pack containing objects for the 10
    most-recent commits in linux.git (starting from 68047c48b228) drops
    from ~540ms to ~240ms, yielding a ~2.22x improvement.

  - The time it takes to compute the on-disk object size of a single
    object drops from ~300ms to 4ms, yielding a ~76.96x improvement.

Reverse indexes are a trade-off between the time they take to be
computed versus the time it takes to access a single record. In-memory
reverse indexes take time to generate proportional to the number of
packed objects in the repository, but have instantaneous lookup time.

On-disk reverse indexes can be "generated" instantly (the time it takes
to generate them is a one-time cost, loading them is instantaneous).
But individual record lookup time is slower, since it involves multiple
disk I/O operations.

In the vast majority of cases, this trade-off favors the on-disk ".rev"
files. But in certain cases, the in-memory variant performs more
favorably. Since these cases are narrow, and performance is machine- and
repository-dependent, this series also introduces a new configuration
option to disable reading ".rev" files in the third commit.

The series is structured as follows:

  - A couple of cleanup patches to plug a leak in stage_tmp_packfiles().
  - Three patches to enable `pack.readReverseIndex`.
  - Another patch to change the default of `pack.writeReverseIndex` from
    "false" to "true".
  - A final patch to enable the test suite to be run in a mode that does
    not use on-disk ".rev" files.

Thanks in advance for your review. I'm really excited to get this in the
hands of users after a couple of years of running this at GitHub (and
being opt-in otherwise).

Taylor Blau (7):
  pack-write.c: plug a leak in stage_tmp_packfiles()
  t5325: mark as leak-free
  pack-revindex: make `load_pack_revindex` take a repository
  pack-revindex: introduce GIT_TEST_REV_INDEX_DIE_ON_DISK
  pack-revindex: introduce `pack.readReverseIndex`
  config: enable `pack.writeReverseIndex` by default
  t: invert `GIT_TEST_WRITE_REV_INDEX`

 Documentation/config/pack.txt     |  8 +++++++-
 builtin/index-pack.c              |  5 +++--
 builtin/pack-objects.c            |  5 +++--
 ci/run-build-and-tests.sh         |  1 -
 pack-bitmap.c                     |  5 +++--
 pack-revindex.c                   | 12 +++++++++---
 pack-revindex.h                   |  6 ++++--
 pack-write.c                      |  2 ++
 packfile.c                        |  2 +-
 repo-settings.c                   |  1 +
 repository.h                      |  1 +
 t/README                          |  2 +-
 t/perf/p5312-pack-bitmaps-revs.sh |  3 +--
 t/t5325-reverse-index.sh          | 16 +++++++++++++++-
 14 files changed, 51 insertions(+), 18 deletions(-)

-- 
2.40.0.323.g9c80379958
