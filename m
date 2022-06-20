Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE1C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 12:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242623AbiFTMdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242711AbiFTMdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A920CDF89
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c21so14490414wrb.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NnqrAMmeFWZpJ0vG9rzfZ7vph9ZQjJ6tfvtKYSViYAU=;
        b=RPNm8lEzqmPbdMuC6k6u+UDyH5RCekdpv7tMLuUV3YhkCClr9Gdk3G1De3dPB0AmZ+
         XPjy59TWLxObhT4F3VbQ2ly92h7a8J9sn18RDpTujVbTcULKborYGaEdpHfuO+aMfwSM
         tt9C1cqPJn2508RwzlTgoIp+JNTg9/Q8/o61JY5NI0EPUvVb/WDgc9fPHSzZVfzNiwKl
         0OjUiCHtdvmp+naMKCWuQZbk9bw42TaZfbkbk/xUAyA6nND6hrgOW38hpqIe3httFIAS
         hkBfRLFucyEuiffCHhLRtT3bRmello0XEN1fZl6QBc/CnKP03uFgdZ5Koak+TfxzeXUB
         0+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NnqrAMmeFWZpJ0vG9rzfZ7vph9ZQjJ6tfvtKYSViYAU=;
        b=ADXtjHoEx4HAxPu11krSJ9LkPbaFs1AeSczxKUTbELStjbYnnrPW2l1lBpYBPW4tuE
         xjUq4Aav8l6dxBzWM04U4ubAMN468rhDflG2tpWMK6ycvxHQ+XihKnst6s6b0iYlMzrF
         /nXaaQ+eakYwwTrQzbAk4RH2NHhWDs465McyVzsVDxQjS2Zmhuh31oRG0LgpspxxzCEh
         GMmq/krs24JRcOBLHCadnvnEANhYFVb0sMJYy0Dw0CDmASq91fac74r0Tkp5Xcm1p0cO
         axX+oimNNZ3xj/4nQk7hettxe9D386tfr1IjCBKTs1mtaQ464vtGKySsQzwBEj77jAsm
         IZzQ==
X-Gm-Message-State: AJIora/ubWs5xxffsi+rKgcm8IchTaSV5dxDTroq5Q0+tjzZJLllp2BY
        QxV08IA2eeO9a2knmGlpqtlPw1ZlOa9OCA==
X-Google-Smtp-Source: AGRyM1twbdwKLu3TSnXbwGvRfbVt7dX0O7M+vbHSHd/4W33KXWeIjsa3CfKnYGO3jB5Xd5iF4YNgvQ==
X-Received: by 2002:a05:6000:a1e:b0:21b:8c8d:3cb5 with SMTP id co30-20020a0560000a1e00b0021b8c8d3cb5mr6827848wrb.372.1655728396641;
        Mon, 20 Jun 2022 05:33:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m42-20020a05600c3b2a00b003973435c517sm15507093wms.0.2022.06.20.05.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:33:15 -0700 (PDT)
Message-Id: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 12:33:08 +0000
Subject: [PATCH 0/6] [GSoC] bitmap: integrate a lookup table extension to the bitmap format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the .bitmap file, git loads all the bitmaps one by one even if
some of the bitmaps are not necessary. We can remove this overhead by
loading only the necessary bitmaps. A look up table extension can solve this
issue.

The proposed table has:

 * a list of nr_entries object ids. These objects are commits that has
   bitmaps. Ids are stored in lexicographic order (for better searching).
 * a list of <offset, xor-offset> pairs (4-byte integers, network-byte
   order). The i'th pair denotes the offset and xor-offset(respectively) of
   the bitmap of i'th commit in the previous list. These two informations
   are necessary because only in this way bitmaps can be found without
   parsing all the bitmap.
 * a 4-byte integer for table specific flags (none exists currently).

Whenever git want to parse the bitmap for a specific commit, it will first
refer to the table and will look for the offset and xor-offset for that
commit. Git will then try to parse the bitmap located at the offset
position. The xor-offset can be used to find the xor-bitmap for the
bitmap(if any). This process is recursive and will end if xor-offset is null
(i.e. there is no xor-bitmap left).

Abhradeep Chakraborty (5):
  Documentation/technical: describe bitmap lookup table extension
  pack-bitmap: prepare to read lookup table extension
  pack-bitmap-write.c: write lookup table extension
  bitmap-commit-table: add tests for the bitmap lookup table
  bitmap-lookup-table: add performance tests

Taylor Blau (1):
  builtin/pack-objects.c: learn pack.writeBitmapLookupTable

 Documentation/config/pack.txt             |   7 +
 Documentation/technical/bitmap-format.txt |  31 ++++
 builtin/pack-objects.c                    |   8 +
 pack-bitmap-write.c                       |  59 +++++++-
 pack-bitmap.c                             | 172 +++++++++++++++++++++-
 pack-bitmap.h                             |   1 +
 t/perf/p5310-pack-bitmaps.sh              |  60 +++++---
 t/perf/p5326-multi-pack-bitmaps.sh        |  55 ++++---
 t/t5310-pack-bitmaps.sh                   |  14 ++
 t/t5326-multi-pack-bitmaps.sh             |  19 +++
 10 files changed, 375 insertions(+), 51 deletions(-)


base-commit: 5699ec1b0aec51b9e9ba5a2785f65970c5a95d84
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1266%2FAbhra303%2Fbitmap-commit-table-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1266/Abhra303/bitmap-commit-table-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1266
-- 
gitgitgadget
