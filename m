Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BE3C433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8353361007
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhDISKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISKu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:10:50 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580FEC061761
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:10:37 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id x17so6822769iog.2
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NumSB8Fo30MpJ7rbDZWKKQIE/1PwnBvcuWGkxrMWwtA=;
        b=m7puBmTvIWjrLTQi+OB4rP4oW/hIYAXovJICBYV1YV1bbtyI/Tyx3OZYFWe8X9tRBX
         Z7MAKwZdTH2RiGEO6B4j9lSxarkivzgBbJ2wwJPmrAQpqsw/H1/IdYkSZaoqg1iLamJT
         66gGZ/7VJ3i+5lwH97qS/yg8T7ATEWYeDNt/V18XaDpy7lutt79ssN/bfL3ZpXKjeqjn
         wnuZeXOWKbO3ERz90JLhNrGyg12F6MLi89EO4icG+jxdsq0aJ5UDgCFTqGVstgLUJx+T
         suN3FKhuUBviWvbe3tBfz/ttvm9foymp6DQQ6tDotr/9m486g0NWXVGlps0i9hm1knJH
         p5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NumSB8Fo30MpJ7rbDZWKKQIE/1PwnBvcuWGkxrMWwtA=;
        b=ARX6LWmqcMbjAisD3bj/5mw/JyJgHsV/OeiineSNmjIiqjNahMxrUUURxmrntSAep4
         hKCK9vASd++/eqKluAHuEKYc3T2XiZ6ZNez7WDkD6O05XWKJ9rPE319e7JeebJ/4C2x/
         OE4qQxd2wHJzK8HBKNbeGrt0eTQSYdAQHn9zSM6Znnq6HPGR+cB2UuoocJDCR8ATHzbx
         hX8w99W///h83ByTO5ansjanq2RC+ZTCJi9tsMhA5PZCHl2uPk17EAo6FthfY40uIdr9
         6tiV+XUobERDGQR3/yccsRkLPiaIMgO+2INuS5fbqIFD/ni2ZlWS+QAJaD498JWTGyMv
         HRqQ==
X-Gm-Message-State: AOAM532jyKB3sQaQU/uypKsR5NRVSVA6jdWUkUPTx5OGF73Fjre07QDL
        TzRS61squACTUgG9uamB8xomUbOclg6l0MFA
X-Google-Smtp-Source: ABdhPJyu6uHrSxkoorgpcKJgmCuucDR0qZoddTRiN5nUL9VH6yKRD8i39pEqEl/tAilj/qU0lmItiQ==
X-Received: by 2002:a02:b615:: with SMTP id h21mr15926651jam.93.1617991836482;
        Fri, 09 Apr 2021 11:10:36 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id r6sm1617331ilg.58.2021.04.09.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:10:36 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:10:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 00/22] multi-pack reachability bitmaps
Message-ID: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series implements multi-pack reachability bitmaps. It is based on
'master' after merging 'tb/pack-preferred-tips-to-give-bitmap'.

This is an extension of the classic single-pack bitmaps. Instead of
mapping between objects and bit positions according to each object's
pack-relative position, multi-pack bitmaps use each object's position in
a kind of "pseudo pack".

The pseudo pack doesn't refer to a physical packfile, but instead a
conceptual ordering of objects in a multi-pack index. This ordering is
reflected in the MIDX's .rev file, which is used extensively to power
multi-pack bitmaps.

This somewhat lengthy series is organized as follows:

  - The first eight patches are cleanup and preparation.

  - The next three patches factor out functions which have different
    implementations based on whether a bitmap is tied to a pack or MIDX.

  - The next two patches implement support for reading and writing
    multi-pack bitmaps.

  - The remaining tests prepare for a new
    GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP mode of running the test
    suite, and add new tests covering the new multi-pack bitmap
    behavior.

You can experiment with the new functionality by running "git
multi-pack-index write --bitmap", which updates the multi-pack index (if
necessary), and writes out a corresponding .bitmap file. Eventually,
support for invoking the above during "git repack" will be introduced,
but this is done in a separate series.

These patches have been extracted from a version which has been running
on every repository on GitHub for the past few weeks.

Thanks in advance for your review (including on all of the many series leading
up to this one).

Jeff King (1):
  t5310: disable GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP

Taylor Blau (21):
  pack-bitmap.c: harden 'test_bitmap_walk()' to check type bitmaps
  pack-bitmap-write.c: gracefully fail to write non-closed bitmaps
  pack-bitmap-write.c: free existing bitmaps
  Documentation: build 'technical/bitmap-format' by default
  Documentation: describe MIDX-based bitmaps
  midx: make a number of functions non-static
  midx: clear auxiliary .rev after replacing the MIDX
  midx: respect 'core.multiPackIndex' when writing
  pack-bitmap.c: introduce 'bitmap_num_objects()'
  pack-bitmap.c: introduce 'nth_bitmap_object_oid()'
  pack-bitmap.c: introduce 'bitmap_is_preferred_refname()'
  pack-bitmap: read multi-pack bitmaps
  pack-bitmap: write multi-pack bitmaps
  t5310: move some tests to lib-bitmap.sh
  t/helper/test-read-midx.c: add --checksum mode
  t5326: test multi-pack bitmap behavior
  t5319: don't write MIDX bitmaps in t5319
  t7700: update to work with MIDX bitmap test knob
  midx: respect 'GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP'
  p5310: extract full and partial bitmap tests
  p5326: perf tests for MIDX bitmaps

 Documentation/Makefile                       |   1 +
 Documentation/git-multi-pack-index.txt       |  12 +-
 Documentation/technical/bitmap-format.txt    |  72 ++-
 Documentation/technical/multi-pack-index.txt |  10 +-
 builtin/multi-pack-index.c                   |   2 +
 builtin/pack-objects.c                       |  15 +-
 builtin/repack.c                             |  13 +-
 ci/run-build-and-tests.sh                    |   1 +
 midx.c                                       | 216 ++++++++-
 midx.h                                       |   5 +
 pack-bitmap-write.c                          |  79 +++-
 pack-bitmap.c                                | 463 +++++++++++++++++--
 pack-bitmap.h                                |   8 +-
 packfile.c                                   |   2 +-
 t/README                                     |   4 +
 t/helper/test-read-midx.c                    |  16 +-
 t/lib-bitmap.sh                              | 216 +++++++++
 t/perf/lib-bitmap.sh                         |  69 +++
 t/perf/p5310-pack-bitmaps.sh                 |  65 +--
 t/perf/p5326-multi-pack-bitmaps.sh           |  43 ++
 t/t5310-pack-bitmaps.sh                      | 208 +--------
 t/t5319-multi-pack-index.sh                  |   3 +-
 t/t5326-multi-pack-bitmaps.sh                | 278 +++++++++++
 t/t7700-repack.sh                            |  18 +-
 24 files changed, 1435 insertions(+), 384 deletions(-)
 create mode 100644 t/perf/lib-bitmap.sh
 create mode 100755 t/perf/p5326-multi-pack-bitmaps.sh
 create mode 100755 t/t5326-multi-pack-bitmaps.sh

-- 
2.31.1.163.ga65ce7f831
