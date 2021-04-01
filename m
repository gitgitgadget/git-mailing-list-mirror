Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD58C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2C361076
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 01:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhDABcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhDABcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 21:32:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62BCC061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:32:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id g20so811913qkk.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 18:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=DP1b6EAdBFyvLqe/lbWHxmEwwWrJ+VcGQhGFAqYQOYo=;
        b=i5COnnkWpK0amPFRrgplH7moFiR+9UPy+j+alllNUEDUyFuXj1KHa9yoBNaYfivOGx
         SohN1AQZlK09dF6YnbS4MH178Nb6Nt+um2DIOnSxjOeWFHB0HU6JZpI3OhEj9ow6TO1x
         0T21WyNiC/ZnvioUpyQ+MWGZAxzasEfyu+jl5pxK3HDnTRvV/LrUfKHZeghR9A93qGqO
         peVDf6z97Mu+htXRem9bUj/1XvofAEbHIaf4k5CPWFlUOKcLZ6I8iYyBKxca5+vJLz23
         u9yNeo7P4jUKh0muHSQkqsi31U7ajmd3czs3oGLCUeOIWQV600x4KHQPLZ/+VddGOGom
         XkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DP1b6EAdBFyvLqe/lbWHxmEwwWrJ+VcGQhGFAqYQOYo=;
        b=MG5PsBjt0f4iNJJ9mSl/Wvu7ivy6RnPbGWsCDeMoakvrda7g2zhewm3LNI83azSSK+
         XXyMtzECbjjctTrHl3O2Z0D4DabQiyCxDRbZqrDqNNLWjhYsJRRxKstsHulhTW7jGIdJ
         gPAOjXLJIo6v5XiVDGjbIKWHd8sfUh44DBcQTp3smdzIiuCet82hMzGGhxgbyvTwDFUQ
         4yGFm7fl6OG5WoAZrcBKbmKXmBXC9KA1BDwQbRIWMhMEZWhQgM8ItJDhesJP+hHpjFhQ
         V4QoLf+ebl/mt+urC4W+04TesMHT6ZsMd4CygujH1y2cmKOJtBxWML/DYpT/kpI9vLI5
         4u6Q==
X-Gm-Message-State: AOAM5329NrHTtlyk7xzjGF+ac1AdzShaXj11KGqjP1fSV5R7Yyxcb9ye
        V5y3HAb18cH6tvXIwM7cXUxseryk9UfjXg==
X-Google-Smtp-Source: ABdhPJxWz7QOA9BQF+3mye2/yJuSk/gdnu3E8585Ck04ji1etivUeGGgxaPjPHQkG3CskU4Rmj4aFg==
X-Received: by 2002:a37:946:: with SMTP id 67mr5772140qkj.194.1617240725704;
        Wed, 31 Mar 2021 18:32:05 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:90ff:e0f0:a41:6c5a])
        by smtp.gmail.com with ESMTPSA id d70sm2825129qkg.30.2021.03.31.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 18:32:05 -0700 (PDT)
Date:   Wed, 31 Mar 2021 21:32:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: [PATCH 0/3] pack-objects: introduce pack.preferBitmapTips
Message-ID: <cover.1617240723.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds a new multi-valued configuration, pack.preferBitmapTips
to allow callers to specify a list of reference prefixes which should
mark their tips with the NEEDS_BITMAP flag.

This has a similar effect as setting pack.islandCore: it indicates to
the bitmap selection code that any commit object with that flag should
get bitmap coverage (it doesn't necessarily imply that it *will*, see
the third patch for details of why).

This is more fall-out from the multi-pack bitmaps topic. Since we
generate MIDX bitmaps after a geometric repack, any delta-islands
configuration only takes effect on objects in the newly-created pack.
Any commits which weren't in that pack may not get the same coverage they
otherwise would have if repacking all-into-one with the same
delta-islands settings.

So, this config was designed to suggest which commits should get marked
with NEEDS_BITMAP when the MIDX bitmap code does its own traversal to
figure out which reachable objects are in the MIDX. But it's useful for
single-pack bitmaps, too, if you're using them without delta islands.

(Like all of the MIDX bitmap topics, we have been running this code at
GitHub without any issue for a few weeks.)

Thanks in advance for your review.

Taylor Blau (3):
  pack-bitmap: add 'test_bitmap_commits()' helper
  t/helper/test-bitmap.c: initial commit
  builtin/pack-objects.c: respect 'pack.preferBitmapTips'

 Documentation/config/pack.txt | 15 ++++++++++++++
 Makefile                      |  1 +
 builtin/pack-objects.c        | 34 +++++++++++++++++++++++++++++++
 pack-bitmap.c                 | 24 ++++++++++++++++++++++
 pack-bitmap.h                 |  4 ++++
 t/helper/test-bitmap.c        | 24 ++++++++++++++++++++++
 t/helper/test-tool.c          |  1 +
 t/helper/test-tool.h          |  1 +
 t/t5310-pack-bitmaps.sh       | 38 +++++++++++++++++++++++++++++++++++
 9 files changed, 142 insertions(+)
 create mode 100644 t/helper/test-bitmap.c

-- 
2.31.1.163.ga65ce7f831
