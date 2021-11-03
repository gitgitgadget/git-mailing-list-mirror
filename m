Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320B2C433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1245B600EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 15:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhKCPLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbhKCPLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 11:11:18 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D4CC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 08:08:40 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso1211337otg.9
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=rBhRCs0PknascNw3Ef4MCm5L4Dnwr9ub6YKCdJtm2y0=;
        b=BqxRfrQ2jTt+0n+PDr6T2s42BA9v95fcY1YTYio4edjZ3NbYHlUs4CxDg7+8lQVgQC
         gPIKv90oUGpzfx5WC2GzCaHWwN69wqbhmIthDI4BmvXz5UrmghC3gYL29dRgICZZ2ovC
         tgg2SHH8BJbu///qhqUfyXfDmPlWVceTu1abqNP6/nLzpjNiv5RvUHlUDdvW5bitsuBb
         S2qOzM5ViD3EPap3By+ELPi2Ut0dqOHl4ePuFTGFRXiU4UZsZgEXi88i6z8+ezL+7Hxs
         3sFITKuHxiD9Du4aL+pk2X1hcQthgSluyAAjDOVL5V25Gyj9qXjMkxvyq6NqCe8dN0yh
         wGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rBhRCs0PknascNw3Ef4MCm5L4Dnwr9ub6YKCdJtm2y0=;
        b=yVVH3SoKfuZZ7rFYwnMSrsvGwOHIMzHKiNCKL4YZx26cKD2nylhzCtoG8Patb1cwVO
         XhOkm16IYUfuMC9Yx53vZ4b7tPbaQ8X6EvNJ5jjWnvqPhhZUxwb7huaD9PFsgei7xkUf
         i71/jvdHHjVUIIhIDjGnG+NBZ5L1G0+lsMXaSajhdpohaPK/xp1eTFiVsijPAB/I7cv9
         bd//phmEAmYYygLNb5EoJ0b2NgLWxCSAM384jvP0gRkAYOi4rIGfVqpaP5brb5Lsoqj4
         KY7uV/fv4wlVoCJZBL4QWl6q4Q98bVE3kJv4OLoNGX0JIdFL7LdOsM23eZxgqrD4lQPu
         ljbw==
X-Gm-Message-State: AOAM533fa3Txp8lvyHPPsCEwfkmzNMWBqQQE4AyIpjEy8f80jsnvwbyI
        0ylUTNTXtV4x45SvXNoVbSliOQY+4DpFrBS1S8bCrYezowXEJA==
X-Google-Smtp-Source: ABdhPJxEffnUmMX+d4nCspn5HL2nn0alSOopEGyF9G+jT/VhoR4VlPEQvt9adp995vnBP6qse8P271dm4TGNQCwe0Cw=
X-Received: by 2002:a9d:7746:: with SMTP id t6mr27875279otl.283.1635952119913;
 Wed, 03 Nov 2021 08:08:39 -0700 (PDT)
MIME-Version: 1.0
From:   Cyrus Vafadari <cvafadari@gmail.com>
Date:   Wed, 3 Nov 2021 11:08:29 -0400
Message-ID: <CAMd+_QCDN5UwwC=ZRcT4Y3p1x7kCQ1TEVf5321Ykx4xrhv-YOA@mail.gmail.com>
Subject: Git Checkout tracking behavior with <start_point>?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I'm new to this mailing list, so I hope I'm doing it right!

I am an avid user of this pattern: "git checkout -b my_branch
upstream/3.2.x", using "start_point" to build my backported patch
against an old feature version. But in this case, the default tracking
is against 3.2.x, rather than my new feature branch. So, then, when I
push I specify to update the tracking against the new branch name.
There are also various default behaviors for push, which I won't
enumerate here, but in the end I need to specify tracking.

I'm wondering if there is some usage/pattern I'm missing?

Or is this an opportunity to add a gitconfig for "tracking behavior"
of `checkout` with start_point? If there is agreement that this could
be improved with a new config, I'd be happy to open a PR.

Best,
Cyrus
