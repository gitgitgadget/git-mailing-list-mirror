Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F357C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1099D61090
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346980AbhIGVTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243883AbhIGVS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:18:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB63C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:17:53 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b7so359954iob.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AMYRJfP0Ytocl4XSwc4mbv2AFiA7XCBhhfMkFlNo41c=;
        b=npXK0OSrdCJJomPAsC5nMY7+Pgb7hjwoqg8bzdF0n8pMRIpe0YmApBXkMMtbDvUGaq
         /UWN6okJOxZjeNAcYdcTQnMy0HGshZ2mjOwgRjKtLCMp059KcUVJzhOzYTyi1yzFlIp6
         RZ50C49p00ApTZiMcI9O0e3fDDL3VvwmaPbEViXmeeu12vRPYcgpRb2b4vE79jb32kn1
         3Iggc3gmZfnhdp2Af9jGY91vbFbZkXE2OGF+KOsBcYuSc8YfWGWCBQTFiNiyZ7gAO8i8
         msPBmLlVuYEQbX0Xbh6AcLsec/GR30oF4sxcZ+WJ/BiWSReVixmkF0ui8e44KbYo5hue
         zVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AMYRJfP0Ytocl4XSwc4mbv2AFiA7XCBhhfMkFlNo41c=;
        b=Obb+/gq+c0/18TvsCYU701ru9gg8a4OkJwyaFSDDhZpKmqd9wV56IxQVLTcihzwBem
         TzRzDIiRcxP+wfcAC5BkbzKLh0/p8U8qHgpR4WV9y3bPZ9zhe8mIWZ8CEUqy4BoFQRAz
         oTGVrpZJR6sr8I7DbvqGw6ZfDeXh31Rf/BLbWYQQmXo/k7G6ZrcKjMpugwLWbWvYhKfj
         O/BHZ460n2afK2vtX+2p2+XjMrwVdyfbu0VrWiaG7NaB2GpfmkbmvznUbvixSh1YscZ1
         UwmrOkLqjl1oXJTkQM7jA8Fq/JYKvvUTgjjX0HBC0UMEZGcrqNdLV8EYzmSgDveWI9n4
         JEEg==
X-Gm-Message-State: AOAM530jlPhDe39nPNGbLsGGMs0tfU0IgKcVmaX2G7Q3qujiXcrASGOo
        csuzYkv73QDDBtYe99aTfAeM6BhAVF6lnwA+
X-Google-Smtp-Source: ABdhPJwHaYaQWb73S+Z+PqLqBJIsNUMgoGqE58hlG2Tka0ap/JfiNPUeNpns1GKdHEnDjG7JbIKBDA==
X-Received: by 2002:a5e:c609:: with SMTP id f9mr164816iok.127.1631049472582;
        Tue, 07 Sep 2021 14:17:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i14sm150226ilc.51.2021.09.07.14.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:17:52 -0700 (PDT)
Date:   Tue, 7 Sep 2021 17:17:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net
Subject: [PATCH 0/4] pack-bitmap: permute existing namehash values
Message-ID: <cover.1631049462.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series depends on tb/multi-pack-bitmaps and is used to propagate
the hashcache between .bitmap files when generating multi-pack reachability
bitmaps.

The gist is that single pack bitmaps get the namehash values via the traversal
used to generate the pack, but there is no such traversal for MIDX bitmaps, and
thus the hash-cache extension (if we were to write it) would contain all zeros.

This series teaches the pack-bitmap code how to permute the hashcache values
from an existing bitmap into the new one. This doesn't keep the hashcache
up-to-date, but it at least prevents existing data from falling out when
generating a MIDX bitmap.

Taylor Blau (4):
  t/helper/test-bitmap.c: add 'dump-hashes' mode
  pack-bitmap.c: propagate namehash values from existing bitmaps
  midx.c: respect 'pack.writeBitmapHashcache' when writing bitmaps
  t5326: test propagating hashcache values

 Documentation/config/pack.txt |  4 ++++
 builtin/multi-pack-index.c    | 21 ++++++++++++++++++++
 midx.c                        |  6 +++++-
 midx.h                        |  1 +
 pack-bitmap.c                 | 36 +++++++++++++++++++++++++++++------
 pack-bitmap.h                 |  1 +
 t/helper/test-bitmap.c        | 10 +++++++++-
 t/t5326-multi-pack-bitmaps.sh | 32 +++++++++++++++++++++++++++++++
 8 files changed, 103 insertions(+), 8 deletions(-)

-- 
2.33.0.96.g73915697e6
