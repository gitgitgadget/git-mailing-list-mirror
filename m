Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F85C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E6160F5B
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 22:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhIHWSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 18:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhIHWSY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 18:18:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DAEC0613CF
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 15:17:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id q3so5315139iot.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bBHAlaw6wXDF7+ysMxV6Ob3HFhbB4XTY6EwMOlNqolw=;
        b=xVE0WEoZCpOwuhnMEJX3ZoiSzM7HZmpmzujn+LvYv0VVJFwFcCxLjinQi5p5Jvc5P4
         F83ZaCsjN+J46OeSYOCYFCPdHYNSAn9+grpisiBkFtL3P9VKb7RCL2h2yrCIkhOpyBAw
         R7dtrcfR30dEE3mKaxd67tUPW6gFxaiLAmyaESan57hPBgPy7ufFJKNyk6EjJAGB5Fw5
         woJAtcUTktQn0lIIBuujys//IqwgLTMQYdE6NcPKb8TqQpO1tasio7gCXP1OwFeR7j74
         xhARnt2pIABNs1431FF7+L4LLYMXr3CeA/woA7t3j686nkFY9RPDHfWREnKlnDmkxAw5
         +IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bBHAlaw6wXDF7+ysMxV6Ob3HFhbB4XTY6EwMOlNqolw=;
        b=3/ZeJ519ZZThtg2ywzlkoH7r4nSdFDEg1VbveXNGIZoU39K2kWlfBUG3w5lT9JtTNz
         n2LL7fMPQ9k3OUYwcSzxOwBJk+Ld/lRgPNm/zfBrvFhF1u76b9RZw8w28TOWdX6qsbBU
         IxWClFt6cnmeA11m45tE6yLkzKHDwxeucu/obww/s5I1oHcFoTbvkKRn6K8SElj481BK
         tKuejxSq7ooSY8v1+y3VDpE56mM48rTChtqrXvBNzpO5vHPQvUTo+bR8TpbZTxKurLK2
         TfxqqBazgfV+ZQxCjeZ5YOHLwOg2hgOmbGlBeIxxaoTi72lx74jMugv0L9f5q368FJ/v
         GEow==
X-Gm-Message-State: AOAM533SyGRshsWXgsGETyq8rmljFWgJpA4CI8tQfrcG7DAKNA8YdH/6
        RT/8irpUIuG0boUfQg9GJzFVY4zL9HOVPDLs
X-Google-Smtp-Source: ABdhPJwVTAiw5vQjLqSWXkLRrelnxrFS+Fpn4I9kIV7AifYmyBZyPIA55qzO53ffDn0UqVaGLmIxhA==
X-Received: by 2002:a02:95ee:: with SMTP id b101mr577481jai.96.1631139435885;
        Wed, 08 Sep 2021 15:17:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t17sm202908iln.24.2021.09.08.15.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 15:17:15 -0700 (PDT)
Date:   Wed, 8 Sep 2021 18:17:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com
Subject: [PATCH v2 0/3] prevent opening packs too early
Message-ID: <cover.1631139433.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1630461918.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a very small reroll of a couple of patches to make sure that packs are
not read before all of their auxiliary files exist and are moved into place, by
renaming the .idx file into place last.

New since the original version is a patch to apply similar treatment to
index-pack, as noticed by Peff in [1]. This should be queued before Ævar's
series on top.

[1]: https://lore.kernel.org/git/YS75P7r33NIBmFh2@coredump.intra.peff.net/

Taylor Blau (3):
  pack-write.c: rename `.idx` files into place last
  builtin/repack.c: move `.idx` files into place last
  builtin/index-pack.c: move `.idx` files into place last

 builtin/index-pack.c | 16 ++++++++--------
 builtin/repack.c     |  2 +-
 pack-write.c         | 12 ++++++------
 3 files changed, 15 insertions(+), 15 deletions(-)

Range-diff against v1:
1:  ea3b1a0d8e ! 1:  cb3a843994 pack-write.c: rename `.idx` file into place last
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    pack-write.c: rename `.idx` file into place last
    +    pack-write.c: rename `.idx` files into place last
     
         We treat the presence of an `.idx` file as the indicator of whether or
         not it's safe to use a packfile. But `finish_tmp_packfile()` (which is
2:  a6a4d2154e = 2:  925f9ada2a builtin/repack.c: move `.idx` files into place last
-:  ---------- > 3:  460b7b9151 builtin/index-pack.c: move `.idx` files into place last
-- 
2.33.0.96.g73915697e6
