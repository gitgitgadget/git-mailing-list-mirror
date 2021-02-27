Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DA3C433DB
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 22:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8DB64D74
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 22:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhB0WoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Feb 2021 17:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhB0WoS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Feb 2021 17:44:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D501C06174A
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 14:43:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id w1so21198035ejf.11
        for <git@vger.kernel.org>; Sat, 27 Feb 2021 14:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=nyQ9aH6bYHrJuc7+rTXiiZlySZ+9rngW0NhcCzGwD04=;
        b=Ju/ezpAcQ5Tc2up5o1rcUuO2J5PgfJAv85mo5CYIJc4wdVvPYV2zrlYyLHBzvJbm0U
         QviI4sEXQTlTNZsOOBuNmexf2Fl4ok1mVtwLSByyihe1dKp+VxaIQSgPbge/70SQWPrO
         yqXDkv8wN6B4M5Xg1qnl8jy/C6Ev2NduJtPrXixGXxC2hb3gPerwgUj8+JkhsemBd2a3
         EWR99s0KG/tpt+P3MmWPpuqeBh+yGdpi8M9PaBNncwUbWd8HByy/XMUByFxE8UatGe3j
         +T1JyhVkHHPvTocKZbAYcY24coIAwlfA9i2Fw1Le8lMNIs1q3fcXqJfyKRcTTCxfcPY5
         x2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nyQ9aH6bYHrJuc7+rTXiiZlySZ+9rngW0NhcCzGwD04=;
        b=NItVTdgW6hedBUv3MU1SwkbK6Jycbrf0MV9jyXoYBD7FPLP6egVKvUXWhWbVwhjl/c
         GcfyIcQS5F8ejaATqDMsgi3yUgvLsW6KRDG9C3uwbYsjK7MjOp9v/lcIcNhqxOabC3Zt
         tMDgc4gBDyCB609mLJlxtk2XsOADdMHWn/AlskOWJJEu2DP3TB2H4JiF687tjC43BwNq
         P2wOAIGmi22QNAtZRyyoI6Uo19s6CeXQbAalREChE0D1nlOMxy6TyiQbjWIUYWs/F4t9
         lWknPGImamTw1hCK+/DmbgWdsYz4erVX8/9Zut5AMXSuYVoMrwIC7V5s9rXVcUovPaxr
         +VNQ==
X-Gm-Message-State: AOAM533jtIFuXovrcV3sqbI/J1TvVe/4bJOUHTuh7+6yHhTwm7viVt7r
        WI4TRlib40hINf84ZyN4RF0oqqgwNPXE3GS+vrNJRLkiq0Mwdg==
X-Google-Smtp-Source: ABdhPJxiVHdc0aZzNBpqC0Q+M221+4Hf2i1lwswWjEMjcuwbLXv03QNnVbN0QARXNbHPCSq8SvxzgdLbaYkNusp/kMw=
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr1930418ejt.216.1614465816720;
 Sat, 27 Feb 2021 14:43:36 -0800 (PST)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 27 Feb 2021 23:43:25 +0100
Message-ID: <CAP8UFD2vJymLUf-YStjsgr35L7m8F7dqRLEqra-bMENAHK4XeA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 72
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.email>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Christian Walther <cwalther@gmx.ch>,
        Sebastian Morr <sebastian@morr.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 72nd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/02/27/edition-72/

Thanks a lot to Taylor Blau who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/481
