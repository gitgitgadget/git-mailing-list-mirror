Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A80EC25B4E
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 18:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjATSq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 13:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjATSq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 13:46:26 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D1CA5CD3
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 10:46:19 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id p12so3139030ilq.10
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wh2TePA5EA9VTUhCd2SdYmlOe/a0oBeYCkaAhuyfeL4=;
        b=ZkU7YWqXFGQNNHpvVuywogUf0pYM7G/U76de4prlQ3dMRDGg/rh3DwY5rIH3rU/v9f
         dD/X7ldXUzDSU6A1xxgzfNB8Z7AHKmgqnQ/AyUNAWp4fB81PzAXPbgX9XqUWT5Lq0yKJ
         uqHt3ppKa6u3WDeAbzqcej0qew5vwa7nhlRQGNUs4r34xSIrKER1HLb3m8r6XulVg3vl
         9vbyPFNs6ZIA6HBx2GhrJzq9s8lJ+PrZPKvkA5WhqwsbMmxIrXBhx0iisECNpNjJZA4B
         05r5bDB/1iI605n26N8QPjzZEf3s5oCDLukgZSQcDbB9oVautTptdFFoTWvc6DLGQuFg
         h1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh2TePA5EA9VTUhCd2SdYmlOe/a0oBeYCkaAhuyfeL4=;
        b=MCn0TZtc8qBE6OIAebEpAPoMJpuG9lPejQm1x1W/hg/aFDT8pSkY1dRaQDBWfCMoXW
         4WpIlW/os5pDx8e2w/O9aiTVCuMqOdNdxqy8jVAApqQvu1/knVyNJZUXMAiQfTGqzi5S
         akM9KBq6BHnVycfShZo4oJq8suVVyiC29dYRUDTBg75wAx6neZ7F4lvvLEEAnb3N/QKL
         fe3hByCbvAHvVeVNyxGnFuW+v+ip1zv/GgAKUx9r9WKOlyizlAHkrVmZ9MbBlbIMCP/l
         H9jmoGidEIBgAOSjVmL8qU6DMWbyVtzGlLZantWfCq/Zlb0TL0CNR9isSVTK150r5YSs
         W6fA==
X-Gm-Message-State: AFqh2kruo/5g8YMLtq260pa8gWiiU12lMEbemNBfi9YXEyILF4gq2nQV
        U95Kp8U6SGYFWWzHBCwu9MdqLtYs98FmUBA4HqA=
X-Google-Smtp-Source: AMrXdXu88d/MyYuRALrayHU6Z13isf5VSBq21I97ogEvRjXQnmyjV4bkviCwvHSt9+Ci8j5z90SElw==
X-Received: by 2002:a92:d6cb:0:b0:30c:4754:eda6 with SMTP id z11-20020a92d6cb000000b0030c4754eda6mr12053457ilp.8.1674240378579;
        Fri, 20 Jan 2023 10:46:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10-20020a02c4ca000000b00363362cd476sm2227597jaj.101.2023.01.20.10.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 10:46:18 -0800 (PST)
Date:   Fri, 20 Jan 2023 13:46:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH] Makefile: suppress annotated leaks with certain ASan options
Message-ID: <b1efe56ab5193d5505ccb9334f7d15e1795c27fb.1674240261.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When building with `SANITIZE=leak`, we define `SUPPRESS_ANNOTATED_LEAKS`
in order to make the `UNLEAK()` macro work (without the aforementioned
define, `UNLEAK()` is a noop). This is from `UNLEAK()`'s introduction in
0e5bba53af (add UNLEAK annotation for reducing leak false positives,
2017-09-08), where `UNLEAK()` is a noop for performance reasons unless
we are using the leak sanitizer.

However, it is possible to use the leak sanitizer without
`SANITIZE=leak`. This happens when building with `SANITIZE=address` and
enabling the leak sanitizer via the `ASAN_OPTIONS` variable (by
including the string "detect_leaks=1").

This renders `UNLEAK()` useless when doing `SANITIZE=address` builds
which also use the leak checker.

Update our Makefile to pretend as if `SANITIZE=leak` was given when
`SANITIZE=address` is given and the leak checker is enabled via
`ASAN_OPTIONS`.

Playing around with all five options (two spelling "enabled", two
spelling "disabled", and the empty set of options) yields the correct
behavior:

    for opt in '' detect_leaks=1 detect_leaks=true detect_leaks=0 detect_leaks=false
    do
      echo "==> ${opt:-(nothing)}"
      make -B builtin/add.o V=1 SANITIZE=address ASAN_OPTIONS="$opt" 2>&1 |
        grep -o -- '-DSUPPRESS_ANNOTATED_LEAKS'
    done

gives us:

    ==> (nothing)
    -DSUPPRESS_ANNOTATED_LEAKS
    ==> detect_leaks=1
    -DSUPPRESS_ANNOTATED_LEAKS
    ==> detect_leaks=true
    -DSUPPRESS_ANNOTATED_LEAKS
    ==> detect_leaks=0
    ==> detect_leaks=false

Making it possible to rely on `UNLEAK()` when implicitly using the leak
checker via SANITIZE=address builds.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
I found this while playing around with GitHub's ASan-enabled CI builds
for our internal fork following a merge with v2.38.3.

The check-chainlint recipe in t/Makefile started using "git diff" via
d00113ec34 (t/Makefile: apply chainlint.pl to existing self-tests,
2022-09-01), which triggered a leak in some of GitHub's custom code. I
was surprised when marking the variable with UNLEAK() didn't do the
trick, and ended up down this rabbit hole ;-).

 Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index db447d0738..b00bb8bd1e 100644
--- a/Makefile
+++ b/Makefile
@@ -1445,13 +1445,18 @@ ifneq ($(filter undefined,$(SANITIZERS)),)
 BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
 endif
 ifneq ($(filter leak,$(SANITIZERS)),)
-BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
-BASIC_CFLAGS += -O0
 SANITIZE_LEAK = YesCompiledWithIt
 endif
 ifneq ($(filter address,$(SANITIZERS)),)
 NO_REGEX = NeededForASAN
 SANITIZE_ADDRESS = YesCompiledWithIt
+ifeq ($(filter $(patsubst detect_leaks=%,%,$(ASAN_OPTIONS)),0 false),)
+SANITIZE_LEAK = YesViaASanOptions
+endif
+endif
+ifneq ($(SANITIZE_LEAK),)
+BASIC_CFLAGS += -DSUPPRESS_ANNOTATED_LEAKS
+BASIC_CFLAGS += -O0
 endif
 endif

--
2.38.0.16.g393fd4c6db
