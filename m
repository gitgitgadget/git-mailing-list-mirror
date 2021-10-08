Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BFEC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF7061027
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243456AbhJHVsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbhJHVsY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:48:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA7BC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:46:28 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id b16so10883049qtt.7
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Bc3pVE2IZy1P1HUhKo1WqxUhZ1KUiGY/bM2VNdChtyk=;
        b=vYBz86hR88c1CHRzCC2r9IlNIeE1BhrgOpHEDdO6UqU4qnCwaT/o3HIvRB28pnf7pV
         v7C7o61axqYtQmlqxTahfU6hIQvLXoWcmm/PXBF/j8MYBffztmH2SnU+yviN4DNFI43+
         XRKuD0VnQApBXGEQKa1UKx+aQyq/V1h6k2pgxQQJu83HDaX+eiQ/3IotuF7zJMQhTDK1
         GQE9Ft+ytdlN4faTiHm/eK8AMZG+dQ+yGh+JcC3VenxN/qGhQ9LBb8KRSs+Vgnf5rvqk
         AEjn/lnE20tE3/P7bzs1qidU1rhPw3NLETmpSQXVA6sG7dYYzJN6e9WSeo3HI4cI3D3h
         Cb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Bc3pVE2IZy1P1HUhKo1WqxUhZ1KUiGY/bM2VNdChtyk=;
        b=n865hp+eteZwWm8BhsWqm0ls29FDkVeUU1fIX3c3GS+TKE1ctvCj2InjlrgoKBz6HR
         g4NKVGAK2RsVcK+bvL+qusLsHE6j5vM3IFRkkInYJxLUbPGTiHlEk7RYAKxgvSFI/4OA
         xP3PNto3e0uMBF20XLkiK94MWPXqR8JH/4etvmmcCK2jZQk5fDFUhY8HXO1tVfWNs6io
         DbHYco7zN6kst5C9pSNGM3p9PLcliaOIbD/0SMOeFr4dNC08JYe6uTcZgNbrPtbajXyN
         ZmwcLu19CbYkWV4NJvSLFIEfH8NeGaatmQja8sW7y1hYZwg/YqlvINEurNWDLDKSgmIi
         8mjg==
X-Gm-Message-State: AOAM533gnIVVR6JGU2h5wnfZx50LMc/em683ECh+ST1ref8lElP9ZCQV
        Fa+Jf4v0zkUUL+esCTmpkLI9Zs6sRxGr1w==
X-Google-Smtp-Source: ABdhPJx8jUHSgDLSO0BnXKQoi1IOZ8vjcvL4UhyD5D5wL46ys+CVRT8HNKZJMLZrRafse9eyhgjLvg==
X-Received: by 2002:ac8:3e82:: with SMTP id y2mr864491qtf.284.1633729587419;
        Fri, 08 Oct 2021 14:46:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m1sm377656qtu.59.2021.10.08.14.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:46:27 -0700 (PDT)
Date:   Fri, 8 Oct 2021 17:46:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, dstolee@microsoft.com,
        jeffhost@microsoft.com, peff@peff.net
Subject: [PATCH 0/4] midx: avoid potential rename-while-mapped on Windows
Message-ID: <cover.1633729502.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(This topic is based on tb/repack-write-midx).

While looking through some failures in t5319 when Git is compiled with
SANITIZE=leak, I noticed a curious pattern that basically looks like:

    struct multi_pack_index *m = load_multi_pack_index(object_dir, 0);
    /* ... */
    write_midx_internal();

This can cause problems on platforms where a memory mapped file cannot be
overridden via a rename, because load_multi_pack_index() builds a new MIDX from
scratch each time it is called without adding that MIDX to the object store. But
write_midx_internal() loads a MIDX from the object store, causing the same
region to be mapped twice.

The details are fully spelled out in the second patch, but the gist is that
while write_midx_internal() unmaps *its* copy of the MIDX, the caller's copy is
still mapped in memory.

Strangely, I could not get this to produce a failure on Windows, even though I
would have expected one. I asked around off-list, and it sounds like it's
possible this behavior has changed, or Windows' mmap-equivalent may not lock
files that fit within a single page.

In any case, we let's side step the issue entirely by only interacting with
MIDXs that can be found from the object store.

Taylor Blau (4):
  midx.c: extract MIDX lookup by object_dir
  midx.c: lookup MIDX by object directory during expire
  midx.c: lookup MIDX by object directory during repack
  midx.c: guard against commit_lock_file() failures

 midx.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

-- 
2.33.0.96.g73915697e6
