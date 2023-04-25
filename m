Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672EBC77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 00:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjDYAA1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 20:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDYAAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 20:00:25 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA66349FD
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:00:19 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54fe08015c1so61606387b3.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682380819; x=1684972819;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dLKW06x8Y02odKj4JdB4ndKFjM8xKy0qdiFSDYJ0KI=;
        b=BDQKhhE7Fw2rULMmmDzUDMWzCWZI7NdIpvR2pLBU8Klu5QKvXM4SOAQvO02oIbXzhk
         ohMojChXHuQ4Sqgye58eNyFOjVJJ2v81MTp23bCosoBUXd0H7S+hYeVHkwXW+PHcKhgc
         hgZTjgxf0LoUW3eriVG6hONQTNjpb2bHCw2If8Lma3zbJSOPMBWXOHiwLgFfZDT8BCUc
         uDBBAfRJJngRDfXwq8l8SARyJHE8TX9b0aihkgK1tmGLpTPCrNqj4nop2Z1VCo75PARL
         Ry86xNQhC0FeNruQR18Y2RujNxEnJTamm+vjmCJP2SCeG8+g0r6GdkSPhN1zXGuOkeFN
         hmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682380819; x=1684972819;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dLKW06x8Y02odKj4JdB4ndKFjM8xKy0qdiFSDYJ0KI=;
        b=P8oJh6sEUKVAc/ipCp6zFtCbZaNyJc7jI2H1SvKiqurTH1Yp/g+ZUuuv7Qj7GRUNeD
         Azjewi3i++yEE4Tti22+l9aiSR2N/BrCrHbs4Z+bqr3oLU7xa96i0OwIRyvU5/IZA7u7
         /QeJ031GmSHR9g4qPhFLUdlN3INjS+t4LamR2/CaI/CvoH1BjDGuOysWdUK49H4deHFy
         D83sp3lgQDj/SuyrAPNzkgbx+ROTm2HLBuMmKffOtrUbe6QV+jvyzC4/GWepNfEmRdVN
         ewyxH64sRFt/nqXSQlBDsloct/N3iNGOkl+BcgaWIR4Fvrvz8jDUaEu0V4JKOqwUDhAj
         NFUg==
X-Gm-Message-State: AAQBX9c2irWh3WmsTNaI47BESjnwdvvHqIaqSCdSV8/6nPK82+flv4on
        vHSxtkDHZld85hjvoHQrhLSBncjOE9UrTO5JN6hU8A==
X-Google-Smtp-Source: AKy350ZiXW7D1wAgUfDmx9m+L9ouJPLe7jbk4Hf6YIlOGS9/MweGkeQufPQTEx1T7awiK955GuYIaA==
X-Received: by 2002:a81:6c50:0:b0:544:5816:b93 with SMTP id h77-20020a816c50000000b0054458160b93mr9918982ywc.10.1682380818851;
        Mon, 24 Apr 2023 17:00:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r127-20020a0dcf85000000b00552df52450csm3235537ywd.88.2023.04.24.17.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 17:00:18 -0700 (PDT)
Date:   Mon, 24 Apr 2023 20:00:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] pack-bitmap: boundary-based bitmap traversal
Message-ID: <cover.1682380788.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a short (but dense) series that I worked on towards the end of
2021 with Peff.

Its goal is to improve the bitmap traversal we implement in
prepare_bitmap_walk(). Specifically, it avoids building up a complete
bitmap of the "haves" side, and instead uses a combination of (a)
UNINTERESTING commits between the tips and boundary, and (b) the
boundary itself.

The gory details are laid out in 3/3, but the high-level overview of the
new algorithm to compute the set of objects between "haves" and "wants"
using bitmaps is:

  1. Build a (partial) bitmap of the haves side by first OR-ing any
     bitmap(s) that already exist for UNINTERESTING commits between the
     haves and the boundary.

  2. For each commit along the boundary, add it as a fill-in traversal
     tip (where the traversal terminates once an existing bitmap is
     found), and perform fill-in traversal.

  3. Build up a complete bitmap of the wants side as usual, stopping any
     time we intersect the (partial) haves side.

This improves many cases where using bitmaps was significantly *slower*
than regular, non-bitmap traversal. In some instances, using bitmaps is
still slower than the non-bitmap case, but it is a substantial
improvement over the classic bitmap walk.

    $ ours="$(git branch --show-current)"
      argv="--count --objects $ours --not --exclude=$ours --branches"
      hyperfine \
        -n 'no bitmaps' "git.compile rev-list $argv" \
        -n 'existing bitmap traversal' "git rev-list --use-bitmap-index $argv" \
        -n 'this commit' "git.compile rev-list --use-bitmap-index $argv"
    Benchmark 1: no bitmaps
      Time (mean ± σ):      15.1 ms ±   4.1 ms    [User: 8.1 ms, System: 6.9 ms]
      Range (min … max):     7.4 ms …  21.8 ms    131 runs

    Benchmark 2: existing bitmap traversal
      Time (mean ± σ):      82.6 ms ±   9.2 ms    [User: 63.6 ms, System: 19.0 ms]
      Range (min … max):    73.8 ms … 105.4 ms    28 runs

    Benchmark 3: this commit
      Time (mean ± σ):      19.8 ms ±   3.1 ms    [User: 13.0 ms, System: 6.8 ms]
      Range (min … max):    17.7 ms …  38.6 ms    158 runs

    Summary
      'no bitmaps' ran
        1.31 ± 0.41 times faster than 'this commit'
        5.49 ± 1.62 times faster than 'existing bitmap traversal'

In a large repository on GitHub.com, the timings to compute the objects
unique to "master", as in:

    $ git rev-list --count --objects master --not --exclude=master --branches

improve as follows:

  - 1.012 sec (without bitmaps)
  - 29.571 sec (with the existing bitmap walk)
  - 2.279 sec (with these patches)

The first couple of patches are preparatory, and the third patch is the
substantive one.

Please have a look and poke any holes you can find in the new approach
:-). Thanks in advance for your review.

Taylor Blau (3):
  revision: support tracking uninteresting commits
  pack-bitmap.c: extract `fill_in_bitmap()`
  pack-bitmap.c: use commit boundary during bitmap traversal

 pack-bitmap.c | 252 ++++++++++++++++++++++++++++++++++++++------------
 revision.c    |  10 +-
 revision.h    |   5 +
 3 files changed, 205 insertions(+), 62 deletions(-)

-- 
2.40.0.380.gda896aa358.dirty
