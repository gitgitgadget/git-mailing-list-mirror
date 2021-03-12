Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751AEC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 16:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4562F64D90
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 16:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCLQoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 11:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhCLQn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 11:43:58 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAA2C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 08:43:58 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id r7so3172845ilb.0
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 08:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technoplaza.net; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=l6DwyFc4NwofMq8kTdhYs68pK4FcG74GNh48KzaLe24=;
        b=gkk+DOsRd66weM6wikJ4OBooemHVcTPJ50BA+KDyJqRYeSg6XTMT4pdWdtpmlFVLSx
         bOMIpFhXs0vzO9nAa/QyOkvzPWznpTZBtdxdzuljaPPKdfqU5Lyr3WBODwhI80sq0Hmf
         js40ERSWdZ+4BZTi9PJa2hk+UfgGX8yRKz77qh/qaO2CWERYObEEv0gC0NBs0ZwJFeD2
         78xJPQpDSI5+XOfujQoICkflWxSyaMj/IedVmRBL+KxZ64m4IkNJWhchLXHBQRklRPdy
         Buw4at4QIGoeDMYS72rOxQpit4wlTIMdyhSU6DeRksjYUOMscCDYp6EztX1nHR0q5j+4
         zDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l6DwyFc4NwofMq8kTdhYs68pK4FcG74GNh48KzaLe24=;
        b=Rd4TH8gXKnQo7nPhvspFkL6tQIFTaArOdMLbhVkxB+m1jgYcAJmRthQEgfhb49u+Lx
         16DuW8o8G7UoZgEL55NJdiDWwOQ45ltM0PXf+24ZUlpxR36cqE8IzSvO8CHaywDC9rul
         bxnIH9hKWLBIyIB+83InybTvEcAJ1Uqt2wv8QjThLjcixeXeyP901Y7GOi9Phvrju3fG
         31+CQ6HzH6ehKb5CMyl2dD+8cQWH7NRfqKpFHwc+plf9s++oG6nDdtTQfpibz1Iatvbb
         UqyJ+n0AJ0E2ephWCFfCticrV3rMCNmlVDTw9D2iclOtiM/maybP/FpgQRqvroytJqex
         0kHw==
X-Gm-Message-State: AOAM532nNvWD0tN8UMKmyIyifrfLzKFZDq+30TcUPAQ5uMfC5GFKX86N
        /3vC5iNBjqnaokC6Z1E1DVDXbNOztnHUhLljKVBzvxe7ghc=
X-Google-Smtp-Source: ABdhPJxVyJdnXq67pGvx364FCDfovlMnLtcBaeXhr0i8QZBhZj0WPsffSmZ+wlXGeMq9uIxYZJOavfsn09vKglRSs40=
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr3364526ilu.183.1615567437680;
 Fri, 12 Mar 2021 08:43:57 -0800 (PST)
MIME-Version: 1.0
From:   John Ratliff <john@technoplaza.net>
Date:   Fri, 12 Mar 2021 11:43:46 -0500
Message-ID: <CAP8UukjW_TeswTHHfiwzc989U+wZMVcHeS1siRF0Rbg5nc3D5w@mail.gmail.com>
Subject: git credential cache and sudo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I do sudo git pull, git does not know about my credential cache.

On some servers, when I do a sudo -E git pull, it can find my
credential cache and use it. On other servers, I think the sudo
configuration is stripping the environment, so this doesn't work and I
still have to enter my git credentials.

What environment variables do I need to configure sudo to preserve to
make sudo -E git pull work with my credential cache? Or is there
something else I can pass to git or define to get it to use my
credential cache?

Thanks.

--John
