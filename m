Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A414C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090E2207F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 19:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="GekYEoZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKKTlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 14:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgKKTll (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 14:41:41 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923AC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:41:38 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id d9so2894470qke.8
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 11:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6Lyl1Ngj4+Es26LBpxCVkXaNMMcM4sqOCYz94M8wx2s=;
        b=GekYEoZgepDTUomfyfggmrBEwZuW3Cb8AlgHH8o7DqfP83XLZJZxAwIo8pGe5vT4AF
         uDFwDAxrMSeB8nHt8GQAy2T+KxU3MYVN7K7Fu3k+BXFEiUJyGUepJq6kUQgsIJYThbPy
         HffIfoe2KjjAwflfjePGOC3gL6vq+RLB7a9PegBPz2GqvUsHUhVwdxEsXDwTolSwDxFw
         0m3YI0bt3gseV5InW0bTt9weyIjVPhd+K3Hi8RmZWPG6llCR9qbcGIipLYEUQM0+49nk
         Srr8RV7eyxhmT7UlzGEO/Ybfoa5mTCVqj/Qqx066EWXaLkAQo9nlzET3Gf9+m9UpUxUe
         O+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6Lyl1Ngj4+Es26LBpxCVkXaNMMcM4sqOCYz94M8wx2s=;
        b=VKQx44tGoTG7ZOZjC7OO+EYvtLX99p7CrNWaUBoD47tvfvyJZdoue1OyiEuC0Hkum1
         BiQoxPDtmKpSrjPBzqNd9GSOvUNeFum6X9K0B8WeY7xnV9unKEkDNVSaQUNLaPn63WcX
         wxPMpjMZ/V8XM/1WjyOLJQuC+vRcCYMnt9vj5jZ+pfVVpZyZ08N4cVOYZWneeby5jUaK
         173phvvnoYz21WIPu2/MT2q03/ltch/pVH+y0eUEkpsXSvI5R5a6sony54LY3Rm+mN8h
         UPIVJayGqlGfY1+9dNEcRQBnZZZ4q9nvKw5EEU2ODrpV+7+Z3/M5Qoo/xkShZyle3BNX
         QHNQ==
X-Gm-Message-State: AOAM531j77+BPGh5CoHksKuzhzVewwvhp76ST1Bmerd8qa6cn4UmsL/I
        811WCcdkzL5zGpR35stvuleBKBEw9RKBnxAA
X-Google-Smtp-Source: ABdhPJz0NVp87huWq15+8La62fSA7XMm17TUh2V0+KVjvuY/rPu7TxsbVhucMSemyvCKBkcUJa6agw==
X-Received: by 2002:a37:46d0:: with SMTP id t199mr25954995qka.308.1605123697537;
        Wed, 11 Nov 2020 11:41:37 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7ccc:9a51:1ad:2057])
        by smtp.gmail.com with ESMTPSA id q15sm3003614qki.13.2020.11.11.11.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:41:36 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:41:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH 00/23] pack-bitmap: bitmap generation improvements
Message-ID: <cover.1605123652.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series contains some patches that GitHub has been using in its fork
for the past few months to improve generating reachability bitmaps,
particularly in pathological cases, such as the repo containing all
forks of chromium/chromium.

The patches that follow are organized into five parts:

  - The first nine patches do some basic clean-up and fix a bug that we
    were able to exercise in tests while writing these patches.

  - The next two patches reimplements bitmap writing in order to avoid making
    multiple passes over the object graph. This approach ends up
    regressing both the time and memory used to generate bitmaps on the
    kernel's fork-network, but ends up being a useful stepping stone for
    further improvements.

  - The six patches that follow that culminates in a patch to build
    fewer intermediate bitmaps during the walk in order to reduce both
    memory and time for reasonably-sized repositories. (Which
    intermediate bitmaps are considered "important" is discussed in
    detail in the seventeenth patch).

  - The next several patches make reusing previously generated reachability
    bitmaps purely an optimization for generating new bitmaps. Importantly, that
    allows the bitmap selection process to pick better commits to bitmap going
    forward, rather than blindly reusing previously selected ones. They also
    include some light refactoring, and a patch to avoid tree walks when
    existing bitmaps suffice.

  - The final two patches address a trade-off in the prior patches between
    walking a wide history only once with high memory cost, and walking the same
    history multiple times with lower memory cost. Here, the walk is reduced to
    only cover the first-parent history. The final patch treats existing bitmaps
    as maximal in order to make it more difficult for a different set of
    selected commits to "walk around" the previously selected commits and force
    a large number of new bitmaps to be computed.

In the end, no block-buster performance improvements are attained on
normal-to-large sized repositories, but the new bitmap generation routine helps
substantially on enormous repositories, like the chromium/chromium fork-network.

Individual performance numbers are available in the patches throughout.

This series is a prerequisite to a list of other bitmap-related patches in
GitHub's fork, including multi-pack bitmaps.

Derrick Stolee (9):
  pack-bitmap-write: fill bitmap with commit history
  bitmap: add bitmap_diff_nonzero()
  commit: implement commit_list_contains()
  t5310: add branch-based checks
  pack-bitmap-write: rename children to reverse_edges
  pack-bitmap-write: build fewer intermediate bitmaps
  pack-bitmap-write: use existing bitmaps
  pack-bitmap-write: relax unique rewalk condition
  pack-bitmap-write: better reuse bitmaps

Jeff King (11):
  pack-bitmap: fix header size check
  pack-bitmap: bounds-check size of cache extension
  t5310: drop size of truncated ewah bitmap
  rev-list: die when --test-bitmap detects a mismatch
  ewah: factor out bitmap growth
  ewah: make bitmap growth less aggressive
  ewah: implement bitmap_or()
  ewah: add bitmap_dup() function
  pack-bitmap-write: reimplement bitmap writing
  pack-bitmap-write: pass ownership of intermediate bitmaps
  pack-bitmap-write: ignore BITMAP_FLAG_REUSE

Taylor Blau (3):
  ewah/ewah_bitmap.c: grow buffer past 1
  pack-bitmap: factor out 'bitmap_for_commit()'
  pack-bitmap: factor out 'add_commit_to_bitmap()'

 builtin/pack-objects.c  |   1 -
 commit.c                |  11 +
 commit.h                |   2 +
 ewah/bitmap.c           |  54 ++++-
 ewah/ewah_bitmap.c      |   2 +-
 ewah/ewok.h             |   3 +-
 pack-bitmap-write.c     | 452 +++++++++++++++++++++++++---------------
 pack-bitmap.c           | 130 +++++-------
 pack-bitmap.h           |   8 +-
 t/t5310-pack-bitmaps.sh | 164 ++++++++++++---
 10 files changed, 548 insertions(+), 279 deletions(-)

--
2.29.2.156.gc03786897f
