Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78BDC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59DF60F46
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbhH3QMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhH3QMr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 12:12:47 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367E1C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 09:11:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s12so26930097ljg.0
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=J7mR/eLKgBj20MphsBmtWpinotnH4fm4vply+j3slNY=;
        b=FAcglsiYCzis1f0tItjRdS5LDYowoQfhqZgiDAL9y99Jm16y/1tiBXOsdjkvyRhYq9
         l6Kfq8Iv/gK4U6t9UVJPMbcGoOp1d+dFSuwOLNjAKTxwk/QrN/M8W/ZHxU0qZT2lhzyY
         UvMqR3c6oTieJQPrYrwNIznN5yKxc3vrzGEj3ymPyhTsdVNojQYBJF82Rz58WjkQwHzs
         fNpLK0pkGnPJdHheC4zZOQNsSMrYNsAEuD0DMwrauezcAkvP3rm+efMFVDhY8ZrNn3UE
         guJfhuAS6HyOxiEmjEGKId8sQYSo9IWSpykJq6MV/u8OSStCVGjwb0m1E25iCXEv6x3B
         /m2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=J7mR/eLKgBj20MphsBmtWpinotnH4fm4vply+j3slNY=;
        b=OFWKuKEENkmfwiUOUkrgfb9I+za+EcRzwA9msun6cS4QGgVw+9jTAd1qYIoTSao9Sg
         6oOnKIBkDdJb7EaEH0O8AooW6M7AeKoWYKKgdfP3eLMK5KiRxMkSJuPhKtzSsVVCK/vC
         qfxnkMFCHSHzY6uO8V7+SuLU7VxSdt8VRw6CMAlF7XVNWz+XywBgZNS4wNVvQevUaNDs
         7mGR6QhNsjpN8nKqHiwInHEg9TjLwPfT1MDSsuEHLbcImCtI90dSYgKsYZ7uEL7mcrIG
         wXYzK5w0W2N/MvjnLNCIRh4HW8jPEv12ir3V+9f7UC3Xagw8hBnI/XrBXMnqjE6vGI6J
         cegA==
X-Gm-Message-State: AOAM530polIpP7Qam1bD9a/WXpswUkDbk9fpgsnSto/lR4IcpjuKwTLn
        Fm4g0je7J3c3qfx6YLbo5O2GdMf7vyll+qOI
X-Google-Smtp-Source: ABdhPJy3hthcX3hK0yGz5d8I2VwyrEKt8wGXbt5qPQDKzJL+fO7d4YtgEJrGozVVdBQv/VTSubUGDA==
X-Received: by 2002:a05:651c:94:: with SMTP id 20mr22078346ljq.164.1630339911593;
        Mon, 30 Aug 2021 09:11:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w9sm2045508ljo.36.2021.08.30.09.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 09:11:50 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 06AE1102EF9; Mon, 30 Aug 2021 19:11:50 +0300 (+03)
Date:   Mon, 30 Aug 2021 19:11:49 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     git@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Problem accessing git.kernel.org with git v2.33 plus gitproxy
Message-ID: <20210830161149.xggfosjthnjxcoxp@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I've stepped on a problem after upgrading git to v2.33.0. git fetch-pack
fails with an error:

        fetch-pack: unexpected disconnect while reading sideband packet

It only happens when I access git.kernel.org over git:// (github over
git:// works fine) and if there's a gitproxy configured.

For test I used a dummy gitproxy:

        #!/bin/sh -efu
        socat - "TCP:$1:$2"

It is enough to trigger the issue.

I'm not sure if it's kernel.org problem or git problem.

Has anybody else stepped on the issue? Any clues?

-- 
 Kirill A. Shutemov
