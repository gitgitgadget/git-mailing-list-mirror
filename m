Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A0C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352541AbiHSVaM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352516AbiHSVaL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:30:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A511104B3A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id x5so4278779qtv.9
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=/hC5A3GJ9TJcH3l7Kr6isZfJ6voiwz97/XzTC3LKtp4=;
        b=Xky8w17vhadcDEygOoKwBJY6Dtwe0xy82SKGLfmtw69JnwgEihUY2hTfjH+sXFIo11
         QCH7QH0xhblZuH9+U3ncPYZmFgcG6yxppsMUermJvXDQZ7+Ag1uQGZxRasbDDISUQCQW
         toqeaj4ruf+9md+E0BSzbBYhg0aUkot7WBgyqPUbxRF3YosQhJXiooBvGDJmh3QhnEqZ
         OjaQ6lPI+PRaJ4ZBtJ1ZLR7tcItqWY2iJVvxugQVsIgRXKu5G1s1t2OzipsM2PAlDS/O
         p+nVxMgajZI12WbvM7l33i+dKPEoZ35VWhaVWl2zuwoa7EEYgYAh3NILkOhewE8danHi
         zTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=/hC5A3GJ9TJcH3l7Kr6isZfJ6voiwz97/XzTC3LKtp4=;
        b=nynJtW649oA4tmr+juGntTlIrxX7er6Mn3t7pUqtANJfiYOVxid6GZgHXRI6iO/0rp
         8RK7VUdJGYYj1m5uR/fq1/7mFe30nSli2vT2u8q//+wOxXsJrcdZ1WLSb71nOQAuqNgg
         b8My65fMsU59XUdGUF8P1SRw+6BFkRIO4sJk2LO3Uu00Xfb+M/Ry/Akii5MNMGFqwL08
         v1JiXnDLPuSmjcKzsze3Hf5EqAosUsKS6Y6Vjgg8cQgBaUM1cG0NHpN4FtMu9De0pYyq
         yztJYAsaOu/x0ovhsZnhkgKa/5ABQT6GtAcH8krkKK9VaLLDfag/mJc1nG4ae680fi9X
         lnLw==
X-Gm-Message-State: ACgBeo0IB6CXICtEcHuTPtjOhFL7/Ons6iIY4c52dmW0aa0BqpTCbynu
        58j16MNDzpER6Ufxm71hvqqVoMDcApIV/lQw
X-Google-Smtp-Source: AA6agR75xjDuiA3qUJztSwgBuiho84LTW70XzaOaw6PX43tAWf5FBTMWtk82pVMPUPP2OFmxybVYBg==
X-Received: by 2002:ac8:58d4:0:b0:344:5dbe:38a4 with SMTP id u20-20020ac858d4000000b003445dbe38a4mr8211375qta.381.1660944608970;
        Fri, 19 Aug 2022 14:30:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a269700b006b893d135basm4427690qkp.86.2022.08.19.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 14:30:08 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:30:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, derrickstolee@github.com,
        jonathantanmy@google.com, kaartic.sivaraam@gmail.com
Subject: [PATCH 0/6] midx: permit changing the preferred pack when reusing
 the MIDX
Message-ID: <cover.1660944574.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series resolves a bug that was reported[1] by Johannes, and
investigated by him, Abhradeep, and Stolee in that same sub-thread.

The crux of the issue is that a MIDX bitmap can enter a corrupt state
when changing the preferred pack from its value in an existing MIDX in
certain circumstances as described in the first and final patches.

This series is structured as follows:

  - The first patch of this series adds a test which demonstrates the
    problem. (This is an improvement from the debugging in [1], where we
    only noticed the problem racily in an existing test, and only in
    SHA-256 mode).

  - The next small handful of patches refactor midx.c's
    `get_sorted_entries()` function to make fixing this bug more
    straightforward.

  - The final patch resolves the bug and updates the test to no longer
    expect failure.

A couple of meta-notes:

  - This bug has existed since the introduction of MIDX bitmaps, but
    probably wasn't noticed until now since it is only triggerable when
    the `--stdin-packs` mode *isn't* passed, so it never occurs when
    invoked via `git repack`.

  - We could likely change the behavior of 56d863e979 (midx: expose
    `write_midx_file_only()` publicly, 2021-09-28), which explicitly
    disables reusing the existing MIDX (by avoiding loading it
    altogether) when `--stdin-packs` is given.

    The rationale in the comment added by 56d863e979 is somewhat unclear,
    but I have a vague recollection of running into a bug that was
    squashed by avoiding reusing an existing MIDX to write one with
    bitmaps. This was likely that bug.

Thanks in advance for your review, and thanks to Johannes, Abhradeep,
and Stolee for investigating this bug while I was on vacation.

[1]: https://lore.kernel.org/git/p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr/

Taylor Blau (6):
  t5326: demonstrate potential bitmap corruption
  t/lib-bitmap.sh: avoid silencing stderr
  midx.c: extract `struct midx_fanout`
  midx.c: extract `midx_fanout_add_midx_fanout()`
  midx.c: extract `midx_fanout_add_pack_fanout()`
  midx.c: include preferred pack correctly with existing MIDX

 midx.c                        | 128 ++++++++++++++++++++++------------
 t/lib-bitmap.sh               |   2 +-
 t/t5326-multi-pack-bitmaps.sh |  43 ++++++++++++
 3 files changed, 127 insertions(+), 46 deletions(-)

-- 
2.37.0.1.g1379af2e9d
