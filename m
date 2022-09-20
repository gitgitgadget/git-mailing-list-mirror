Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18754C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiITBzm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiITBzk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:55:40 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D383CBDF
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:39 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j8so1043722qvt.13
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=/3FbNLMqhVTUbGeYWsQfeu7nX04j03dl2gWMz+8QLZg=;
        b=WBH7TEtjjeAus81h7YhV/oM76ulDrxSrEsMkEBDYQ+yszKFTIdAA18Zyt+ENtYATwF
         tFWyl57hWIgn9PrM5H2tYxeLCDJHtxFBQg6Vipnq9/ULl1PB1UAOKrGgWrUZCyi0Z4B+
         pNzytm5TY6TWAz+kSp8wvcgA1L1MBn9bFdEtvpOHhbHUpd2QRenX8e3yTTlvdHE/SE66
         Ot6A4+Ro+WkkbB4I/OfWCpdB5xrbBE3fyi59qprO/aXncKrpem/4tj/QTsgFgIOb77vh
         hYmJFpLK3ITE67Xa9eXaFMik24hYIziq124zpn7nDQ/n3E3y83KMhWzd0fboqONCelvF
         f4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/3FbNLMqhVTUbGeYWsQfeu7nX04j03dl2gWMz+8QLZg=;
        b=z8Gi/tUTPGJKUdPM8WPp5aoCuAVAkYTSd+ftn6QL/9ktBOhpiLiojGJSCsPmGefDgK
         8JbgBmfT/vvwQPKapUuEZalJFdq12RXWuADRp0G2Ya69wCJNKZZMl14P6Y9Zv+nXJD9Z
         FQMuZpF9NEDgac9pT0I81/dDIl9BX5ObKDmRYvYbbquIRzFqQ0vp1jM7z78IErPHogkA
         GEzxreXYqXbTffl6L7BJ4NPUyg93LhuSwn3NhUgyIKVwiTBIoPau5mgy+vlQMdHZQOn9
         V0SBC54ab23nxUAl+cZESfABh/dfmwNNYPFybMR/OvxS41NGcVi9pHJINhpJjS21PexE
         z+jQ==
X-Gm-Message-State: ACrzQf2Y4dxToZbUTnGq9LazKXro8ppBy61LrE/9DbMg5xuOPMgHr1/O
        +Q/VkAUSGfJ+YsuLpfvoWymjQ/veEphtZg==
X-Google-Smtp-Source: AMsMyM4LtQVRZbqrjK33G/7sn721wNYnkBqIRJAz0r2OpCzVq5t7xMI8fMm+jMhdghOhfaDi2/FzKQ==
X-Received: by 2002:a05:6214:29e1:b0:4ad:2653:dbf4 with SMTP id jv1-20020a05621429e100b004ad2653dbf4mr10642414qvb.28.1663638938747;
        Mon, 19 Sep 2022 18:55:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006b95b0a714esm103840qkp.17.2022.09.19.18.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:55:38 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:55:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Subject: [PATCH 0/7] midx: ignore cruft pack with `repack`, `expire`
Message-ID: <cover.1663638929.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a pair of bugs that were originally pointed out by
Gregory Szorc in [1].

Namely, that both `git multi-pack-index repack` and `git
multi-pack-index expire` can cause us to "absorb" the cruft pack,
distributing its objects into a new pack, and removing its metadata.

This is worth avoiding, since even though it doesn't result in object
corruption, this bug removes semi-important metadata contained in the
.mtimes file, which controls how fast objects leave the repository
during a pruning GC.

This series teaches both sub-commands to avoid any cruft pack(s),
preserving their metadata.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/CAKQoGanPBec6wRO6uWrETaoJXdszpjRWytXaJwx6jw0mrrj-gQ@mail.gmail.com/

Taylor Blau (7):
  Documentation/git-multi-pack-index.txt: fix typo
  Documentation/git-multi-pack-index.txt: clarify expire behavior
  midx.c: prevent `expire` from removing the cruft pack
  midx.c: avoid cruft packs with `repack --batch-size=0`
  midx.c: replace `xcalloc()` with `CALLOC_ARRAY()`
  midx.c: remove unnecessary loop condition
  midx.c: avoid cruft packs with non-zero `repack --batch-size`

 Documentation/git-multi-pack-index.txt |  7 +-
 midx.c                                 | 12 +++-
 t/t5319-multi-pack-index.sh            | 94 ++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 6 deletions(-)

-- 
2.37.0.1.g1379af2e9d
