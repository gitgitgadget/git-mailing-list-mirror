Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3498BC433F5
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 10:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345677AbiDOKYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 06:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbiDOKYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 06:24:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8144BB0A1
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:21:40 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i20so10137126wrb.13
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fczvw9W+VSgm70tBsHUgR082mKuD0qsI7aG7wUVioh0=;
        b=X5dVKdaek81ZZdPkb2N0+hG4OWjqXxnSG3VikuUlQLBrRiRZZJ2kvmeO/YwFxbnBGZ
         61m7g74JUsFsfwerK6PQxTCc9k05lUyGZKAYZaQGsVZcuqDvlfIw6NAsJ1dtjUGo/Nia
         YkpBnslECHEIn3PJN96YAyYUVR5YYZJkMP72kFbtfGvl04/zGO2tf8k7hXLbmCT7C2ks
         CppR6mpu4c/YMuDYjVeSzYKZLAbQYKKhYQDHIfMTmBDDo56REBjRxryzwCZUL886LYkv
         Vygt5X58+1D0iRQAL6xgWGxBaQHTZ/k681GrwXjZs/JZwA3xjB6nLP0ygRQCVlovCx8q
         STHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fczvw9W+VSgm70tBsHUgR082mKuD0qsI7aG7wUVioh0=;
        b=MRd6wdqcXuQ/Yg2rFQqjrI77zuVw5a7+0eUO3/YtvO0ahb/y1I3t3/BxxXIv9+5++K
         aC9qNAuF3QLNGXikKV8040eeFGGoCrsz34aN/nqJU4IozYFz3cwDq5NCRqTZcM6Jsg7c
         iFnHX6/ZiKse6X9zY//AlD7DZBv4+92L/myFqnLnXpoJKk0OIb2l1B0rifXj/CdP48PN
         72LiEE6EeKlAszJD1+AQuvaREQEUCLKXo9umkMD2GFAih/TOAc6Ye2pwQbCe/2Y0+WY4
         U/tu1Q2vz6jNWxYpCC6e1jHuJPHGgWud8t86tZ8jtRZ4bPNJwswCQuKZCZdP07H7qpyb
         czAg==
X-Gm-Message-State: AOAM530CeOaueFEO5fycUlz1XZMBOwCqZreMNAUVYgyuzr4bQjRqAEQL
        NR4sVl552U014Oy9az/9CYPgaTnraik=
X-Google-Smtp-Source: ABdhPJzMtTUpuKg4rM/vAvEAkgVkiv3bEhh+DiA6j9HjSZGhvPkzR86UFroe3BSsIf6qlTXau7OV/A==
X-Received: by 2002:a5d:5503:0:b0:207:a2dc:7fe1 with SMTP id b3-20020a5d5503000000b00207a2dc7fe1mr5020486wrv.129.1650018098871;
        Fri, 15 Apr 2022 03:21:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c186-20020a1c35c3000000b0038e6c6fc860sm4585791wma.37.2022.04.15.03.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 03:21:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/2] reftable: remove poor man's SANITIZE=address, fix a memset() bug
Date:   Fri, 15 Apr 2022 12:21:34 +0200
Message-Id: <RFC-cover-0.2-00000000000-20220415T101740Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.863.gfc2c14e3b91
In-Reply-To: <20220415083058.29495-1-carenas@gmail.com>
References: <20220415083058.29495-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 15 2022, Carlo Marcelo Arenas Belón wrote:

> 1214aa841bc (reftable: add blocksource, an abstraction for random
> access reads, 2021-10-07), makes the assumption that it is ok to
> free a reftable_block pointing to NULL if the size is also set to
> 0, but implements that using a memset call that at least in glibc
> based system will trigger a runtime exception if called with a
> NULL pointer as its first parameter.

FWIW I've been carrying 1/2 here for a while in my local tree,
i.e. reftable/* has various abstractions and indirections that aren't
really needed. In this case we can just get rid of that & free them,
so the memset()s you fixed can just be removed.

The 2/2 is then another memset() issue I spotted when looking at this
again, -fanalyzer notes the bug related to it.

Ævar Arnfjörð Bjarmason (2):
  reftable: remove the "return_block" abstraction
  reftable: don't memset() a NULL from failed malloc()

 reftable/block.c                |  4 +---
 reftable/blocksource.c          | 28 +---------------------------
 reftable/publicbasics.c         |  2 ++
 reftable/reftable-blocksource.h |  2 --
 4 files changed, 4 insertions(+), 32 deletions(-)

-- 
2.36.0.rc2.863.gfc2c14e3b91

