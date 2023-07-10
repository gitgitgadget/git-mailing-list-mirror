Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE829EB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 19:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGJThS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 15:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJThR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 15:37:17 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4828D9E
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 12:37:15 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-579ed2829a8so53231747b3.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689017834; x=1691609834;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zL63m3CR83xiB16SjaqjOZKtkj1pEqWHjXM7LXVdGgg=;
        b=ISRfqyxcaTmS8ICjwrev7DW81q4sWQ1x8CJXm7JDT74H8SGCrb6j7FrWZ8caUCRpil
         qV6zJMP5trKL7Xto+NECv2dOiXcyxbOHbyEh+FurF8YOFU0jf7Txesq4TMqpJr15z7PW
         gWTPmMAFFzbExXwQuy3qFORkxwBhxSk6KCiXPel8BA5vtnuBdTvR+96iXbNfLcsKpICq
         t4vxzMcRnUDd5ffB05vRD0cxAcx/npcBFcQm6h7brC1xYM0NjtKSEf2nsQ67b5m6YuuK
         OMPowRQmEbtQC6nYRyvPctO9n3N/uedMfRGBQhUeQgpaBuRYYyzRJ7icZkXNLkzYn2ZU
         VQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689017834; x=1691609834;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL63m3CR83xiB16SjaqjOZKtkj1pEqWHjXM7LXVdGgg=;
        b=gWhcooSgDyn6KQ1v60Im5jLzyuCTsrTKBsI30jJU3enR/9/SgwERJ3OiVzzXqS6ZcL
         nPZQR+sE1kP6YC3Q4WTtwZ4+sLEQALskocACSoGSnve1L68p47MGscAv9MMXz/lqn+h7
         MMDCVWMjuRltUbpP4OkK32KOUeWbyN2K1zIrnwI2O5ZHELj3cdGVvvItXjED+GGl4ZVu
         KPpT7R3uunk2ut0ohqbFp+mAry0EHGXgTf1Re91mHi7Sp1H9+8NrW81SimCcQywYUDDR
         fC8ZT61Wvqa4HbGsY7qxp6G023GsVu3v/f4d4IISIQL5fBjnofc+h5RQdl+ujz6qDKPg
         vsuw==
X-Gm-Message-State: ABy/qLaaibUTPQR4TtdWc0tCfLIoULJNyDx7P0v63/ct7/4sV8pD1lQ4
        X2SvSfSH8wtzSerlQ2rAUX+ZfY+1fEydi6lVQX+6pQ==
X-Google-Smtp-Source: APBJJlHdOyE7LK7zsFQRp7i7JXNLR52lJUpFELqwO/TpLL9zkoRp1YuL1ykAjXxJ8VAHNSfaxbGkFQ==
X-Received: by 2002:a81:91ca:0:b0:576:97b7:9335 with SMTP id i193-20020a8191ca000000b0057697b79335mr11620767ywg.52.1689017834370;
        Mon, 10 Jul 2023 12:37:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v4-20020a816104000000b0056f3779557esm135526ywb.113.2023.07.10.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 12:37:13 -0700 (PDT)
Date:   Mon, 10 Jul 2023 15:37:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 0/2] repack: make `collect_pack_filenames()` consistent
Message-ID: <cover.1689017830.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series combines a patch that Stolee wrote[1] as an RFC, along with
one that I added as a follow-up on top[2].

The details are spelled out in the commit messages, but the gist is that
the first patch restores behavior from prior to 73320e49ad
(builtin/repack.c: only collect fully-formed packs, 2023-06-07).

The second patch does not change any behavior, but reimplements
`collect_pack_filenames()` in terms of `get_all_packs()`, to make `git
repack`'s notion of which packs exist in a usable state in the
repository is consistent with `add_packed_git()`,
`install_packed_git()`, etc.

[1]: https://lore.kernel.org/git/pull.1546.git.1687287782439.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/ZJ1N2I6sDfxhrJo8@nand.local/

Derrick Stolee (1):
  builtin/repack.c: only repack `.pack`s that exist

Taylor Blau (1):
  builtin/repack.c: avoid dir traversal in `collect_pack_filenames()`

 builtin/repack.c  | 38 +++++++++++++++-----------------------
 t/t7700-repack.sh | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 28 deletions(-)

-- 
2.41.0.320.gb3d0d9308ef
