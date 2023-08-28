Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724F2C83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 22:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjH1WtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 18:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbjH1WtH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 18:49:07 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069ED11C
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:04 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58fb73e26a6so44400617b3.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1693262943; x=1693867743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uybh8rnZhhbKkmri1ZeKPTbLGoOHsiiD9dw3FdQmnio=;
        b=aeJ/WG+aCy9Gl4N6xhB0m8vzSy0h2a/iVR1vaZC0r+JowMJIQRWIKfdifxHWDTal42
         G8EE7ExUpnPgY9vnbonInzXz40Q+YIfW5Ta9lhpEYTJx57AX6JbZLRU5vOCws3nON+A7
         /h6b50vSI4G9Q5wlIAvBzzjWqw9wtRUt8Y8luakaJDoJVzxlqIxMl1OYxIzRUwOqSg7f
         KE3yvc77bQOIlfwQbqUNI7Wuap3q3xlZ1DfNc7UJSULbCpCfEyc8wwZkj5/HtnOUQRo1
         AVcMZ2Q69XfK6mJCEv4eE0Wx8ysUIMCGzgwNHDPwrU7NdpXj1nwUmwIjrC0d9kAq7SNs
         4dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262943; x=1693867743;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uybh8rnZhhbKkmri1ZeKPTbLGoOHsiiD9dw3FdQmnio=;
        b=b1705YRa+N1IsLR5lZYesP2SjBTfzbsZG6NKmell+xhubZXoi+Na8VCX0tzYbZ2OmJ
         WKwl/xAlwziDlXWYQY/8P94/80LzLfQgN76yfuIRwZEvYU07EgqaW3deMoOBBunsaeDd
         9B+RtJ3d4xxHDRp9VNE9MJXNYKQgE8wS06fZ7EBRzZUkf8FysPYLqbq1cdIfB9m8ymB+
         26wgqFIR7WFca9T2gcbnMcLb679z9+kXpXuwQviilIJtVWhUN2gLAUG/4Wrtg4FH6gdb
         oHHbV0WzaJnIwKnG23+NZYy+U5e27M7shacPqE3hgda4/bey+8icUFd9TzYbV4yR8yc7
         Kecg==
X-Gm-Message-State: AOJu0YxUZV0fQYo4QYOx48noJ0ojtIMzuDBnMYyW3q46YJ4WJdo8W3FL
        oKI6RqlAU85nfD2Oh4WZz4j6W6XhkiXTwv194WLEng==
X-Google-Smtp-Source: AGHT+IGGU2g3ANWknOotAKfKackukavqVMXs9TgLPCf8IprNzFafyA0pbV4Oi6/wywuimW68lKfxZg==
X-Received: by 2002:a81:784d:0:b0:592:9235:4bcc with SMTP id t74-20020a81784d000000b0059292354bccmr11318139ywc.50.1693262943003;
        Mon, 28 Aug 2023 15:49:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i9-20020a81f209000000b00594fff48796sm1469936ywm.75.2023.08.28.15.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:49:02 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:48:58 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/4] pack-objects: support `--max-pack-size` for cruft packs
Message-ID: <cover.1693262936.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series comes from the beginning of a longer one with the goal
of giving users more flexible options to manage a set of cruft packs.

The goal of that series is to be able to do things like:

    $ git repack --cruft --max-cruft-size=10G

and coalesce smaller cruft packs together until they reach the given
threshold.

This series takes a tiny step towards that direction by making
`--max-pack-size` work with cruft packs. This will be necessary since we
have to guess the size of cruft packs when we combine two or more
existing cruft packs.

This accommodates situations like having an object which, when packed
with a cruft pack that is below the size threshold, crosses over and
causes the resulting pack to go above the size threshold. When
specifying `--max-pack-size`, we would split the pack appropriately, and
pack the aforementioned object separately.

But that is neither here nor there, since this series just makes a start
in getting `--max-pack-size` to work with `--cruft`. Thanks in advance
for your review!

Taylor Blau (4):
  builtin/pack-objects.c: remove unnecessary strbuf_reset()
  builtin/pack-objects.c: support `--max-pack-size` with `--cruft`
  Documentation/gitformat-pack.txt: remove multi-cruft packs alternative
  Documentation/gitformat-pack.txt: drop mixed version section

 Documentation/git-pack-objects.txt |  4 +--
 Documentation/gitformat-pack.txt   | 36 +-------------------
 builtin/pack-objects.c             |  8 ++---
 builtin/repack.c                   |  3 +-
 t/t5329-pack-objects-cruft.sh      | 54 ++++++++++++++++++++++++------
 5 files changed, 50 insertions(+), 55 deletions(-)

-- 
2.42.0.49.g03c54e21ee
