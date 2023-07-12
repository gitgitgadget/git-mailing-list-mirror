Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B22EEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjGLXh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGLXh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:37:28 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36A19B4
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so3157276.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205046; x=1691797046;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZgAZ1RN4Zw92PyukSC65/fPsKQZ8IpXXn+eaoaWG0Y=;
        b=DQ3Q/fLPcIgDRykF5UVRRhtlGkL4XbJj9sD9+tR181qj8XBGNsBVNtIVp7KAzN5H+0
         HzKKYTiSacymWzPEEFdCwncVkgUJyKVynNjX7y/Rd9+sqODaaoszukwiVJRm0uog/s29
         MubMhJQLptDcQyfM9AanGa6Tc3KghJ3bZbpXYiem2T1pIduO32Bkf3bh8ZvaswSnVlqq
         0MY/jfPOY+FV3C9s0jlfDkL//hK/nNQ1QmMxCcuX4TEgqt/OOCC1l/1NBbDgTFgBmSdD
         J1ptDd01OL2CUa0OKQFHjEwYSzdMeHBK+R/hPOboWBkmwp84vC20CXvTW1lcIfv4+XlJ
         SOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205046; x=1691797046;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZgAZ1RN4Zw92PyukSC65/fPsKQZ8IpXXn+eaoaWG0Y=;
        b=KDqM6pn3eMZDW7hSPFKw7J8pvnWHlTlk6Fo/OKKdKC6BvNz2xnzOvNL2Y7djTkABDT
         xPbRckW93AibB7viw78VMFvzJ4Rtcl4JGLq6iGuvxTuZ4aZqQ7A8bAkTiADhQqWUv2Ge
         MdgoH3XeD7Ha/KX9NZ/G5Jzz9Tp6xcbx2kjupZ/uCiyjkIYVJChCDDD5vV4xp3fhMPwu
         rzsl2qzcpS60Vj0osdU52ZYdL92SBVaiLINOkl82IzQlpzo5+rX/b1jH5odK7bByWTx2
         7To1/MJw5xEL9d62CNh/TV0pUKfl8XlKPDOU4lu8hXPsEgX7tbl7Df1mLuMQMGc22UsW
         7qiw==
X-Gm-Message-State: ABy/qLYkHLpXT9H5Jz3p6JAgLr9Ekjsm8Hh32yyHn1ljbGpusvvUwPYZ
        vj0vdz5VBr2jcYbfNAhLgvnQq4cMkdtCJs1gjZE0VA==
X-Google-Smtp-Source: APBJJlEBZEuKSoNM1uF2A+9oGwztTjVIrh3elGo6LfoYXNGuh1Ghs5clvVvooa3CRUkDjARw/ViTKg==
X-Received: by 2002:a25:2541:0:b0:cab:fc9e:fc48 with SMTP id l62-20020a252541000000b00cabfc9efc48mr1603421ybl.24.1689205045786;
        Wed, 12 Jul 2023 16:37:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j63-20020a25d242000000b00bcf788d09e3sm1191900ybg.34.2023.07.12.16.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:37:25 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:37:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 00/20] guard object lookups against 32-bit overflow
Message-ID: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series I wrote over the last week or so to address a handful
of spots where we may overflow a computation, and produce incorrect
results.

Most of these share a common theme, which is that many of our
data structures (packfiles, bitmaps, commit-graph, MIDX) all tolerate
up to 2^32-1 objects. But when we, say, multiply the number of objects
by some constant or other value which isn't a 64-bit unsigned, we'll
overflow.

Often times the overflows occur when looking up an object / bit
position / commit / etc which is at position 2^32-1/20 or greater,
causing us to exceed the maximum 32-bit unsigned value when we multiply
by 20 (or the_hash_algo->rawsz, if stored as an "unsigned int").

There are a handful of instances where the existing implementation won't
overflow (i.e. because one of the operands is already a size_t, or an
explicit cast is made, etc.). These instances are also replaced with
their corresponding checked functions (st_add(), st_mult(), etc.) to
more clearly express that these operations are supposed to be computed
with 64-bit values.

This series regrettably does not contain any tests. There was some
discussion internally about using a purpose-built test helper to
generate raw packs without going through fast-import. I looked around
for prior examples of how we handled testing (or not) when writing these
kinds of patches with the following script:

    $ git log --format='%H' -G 'st_(mult|add[234]?)\(' |
        xargs -I {} sh -c 'echo "==> {}" && git -P diff {}^ {} -- t'

And looking at each such commit which mentions st_mult(), st_add(), or
one of its variants, I could not find any examples of us constructing a
gigantic pack/MIDX/commit-graph/bitmap/etc specifically to trigger an
overflow.

Taylor Blau (20):
  packfile.c: prevent overflow in `nth_packed_object_id()`
  packfile.c: prevent overflow in `load_idx()`
  packfile.c: use checked arithmetic in `nth_packed_object_offset()`
  midx.c: use `size_t`'s for fanout nr and alloc
  midx.c: prevent overflow in `nth_midxed_object_oid()`
  midx.c: prevent overflow in `nth_midxed_offset()`
  midx.c: store `nr`, `alloc` variables as `size_t`'s
  midx.c: prevent overflow in `write_midx_internal()`
  midx.c: prevent overflow in `fill_included_packs_batch()`
  pack-bitmap.c: ensure that eindex lookups don't overflow
  commit-graph.c: prevent overflow in `write_commit_graph_file()`
  commit-graph.c: prevent overflow in add_graph_to_chain()
  commit-graph.c: prevent overflow in `load_oid_from_graph()`
  commit-graph.c: prevent overflow in `fill_commit_graph_info()`
  commit-graph.c: prevent overflow in `fill_commit_in_graph()`
  commit-graph.c: prevent overflow in `load_tree_for_commit()`
  commit-graph.c: prevent overflow in `split_graph_merge_strategy()`
  commit-graph.c: prevent overflow in `merge_commit_graph()`
  commit-graph.c: prevent overflow in `write_commit_graph()`
  commit-graph.c: prevent overflow in `verify_commit_graph()`

 commit-graph.c | 63 ++++++++++++++++++++++++++++++++------------------
 midx.c         | 42 ++++++++++++++++++---------------
 pack-bitmap.c  | 12 ++++++----
 packfile.c     | 15 ++++++------
 4 files changed, 79 insertions(+), 53 deletions(-)

-- 
2.41.0.347.g7b976b8871f
