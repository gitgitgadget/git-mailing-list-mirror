Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D49C001DB
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjHGSvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHGSvp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:51:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD851E68
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:51:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31768ce2e81so4222566f8f.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691434302; x=1692039102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6bBiEz/8HS+LTP/YRadC2zyFWCULywktcYe80anIZ6U=;
        b=IM+7K1uhLIGkrIMLTzPN5nkaA/n/4/5DjK94GCxRW59eiAbmpg8gUiTuJdprY06HrO
         J6jA/CvKJafRQLv7E1UX/omr8nH7IY1K44JXQwnY6yjWCkA1lqUrL/ORCdCXH3v3izzj
         oB/7BmAYtlBiiw/hepwsize684uoOzeSWqz298nnWaMOqOI04JbfSXRZj2oOLw8GdO3d
         miWbQn6VrwVsW4NunNmOH6aGElluXy/pzkCeH7GiAmgbl7t6VebmqqDwTgweE7/SIJwH
         Ijd5YA93cFswGblQ0sgJPSszYSlsoWBvHwBiSoJQolXc+7sA9NkXqZYL2HxS7rtNkOTh
         1K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434302; x=1692039102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6bBiEz/8HS+LTP/YRadC2zyFWCULywktcYe80anIZ6U=;
        b=cPSGOs18s7YOIB78cb1lrYqj7uZtPTcanXoSoQzKYgg4OnFFWwwkq7c536GyMlPmLd
         T3FaSPdKEIEjK1a1a1D/xklrWg9pAJwz+fXgEmahd78wJ4d0NTAkrP6Zvg0jm/9sn4wF
         ZILdYULL2Y5vBa1sJ7OSJGaFHZTDFjnFHZuZQO1I6eWcGNNTqWluzqqb4jj+EiwN/2sH
         eZOiKEthU5OEP/6Vfk158WTZck1SzQ1VYrQM5drnsfINQpxEcWKfIUwvm60I99IbKASU
         2ga0FlbPjf4IiaioKrNiJSxAn11TDUrl8DPb3CnWPIwOPGTo5gBTY4GsHzR29RyEJR5j
         Fg6Q==
X-Gm-Message-State: AOJu0YxhnVcP2Uq3jxE/DFT7cdky2BKdvQTmwa0+zIbgym4w1fbDiGT3
        Wsum4yTsjliADGin2hXgljNQ8iDsGL8=
X-Google-Smtp-Source: AGHT+IHFRZ2QpjMk36V3DlqJ6D5hP07ecK15sND/g9rCq3CMmt88SBLCmYjX/rL5Em5hEcQnnXtJ6Q==
X-Received: by 2002:a5d:46c2:0:b0:313:e88d:e6cf with SMTP id g2-20020a5d46c2000000b00313e88de6cfmr7149826wrs.69.1691434302000;
        Mon, 07 Aug 2023 11:51:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15-20020adff74f000000b00317eee26bf0sm2833547wrp.69.2023.08.07.11.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:51:41 -0700 (PDT)
Message-ID: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 18:51:34 +0000
Subject: [PATCH 0/6] maintenance: schedule maintenance on a random minute
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we initially created background maintenance -- with its hourly, daily,
and weekly schedules -- we considered the effects of all clients launching
fetches to the server every hour on the hour. The worry of DDoSing server
hosts was noted, but left as something we would consider for a future
update.

As background maintenance has gained more adoption over the past three
years, our worries about DDoSing the big Git hosts has been unfounded. Those
systems, especially those serving public repositories, are already resilient
to thundering herds of much smaller scale.

However, sometimes organizations spin up specific custom server
infrastructure either in addition to or on top of their Git host. Some of
these technologies are built for a different range of scale, and can hit
concurrency limits sooner. Organizations with such custom infrastructures
are more likely to recommend tools like scalar which furthers their adoption
of background maintenance.

This series attempts to help by spreading out background maintenance to a
random minute of the hour. This minute is selected during git maintenance
start, and the same minute applies to each of the three schedules.

This isn't a full solution to this problem, as the custom infrastructure
needs to be resilient to bursts of activity, but at least this will help
somewhat.

Each of the integrated schedulers needs a different way of integrating the
random minute. The most problematic is systemd, since our integration had a
clever use of templates to write one schedule that inserted the hourly,
daily, and weekly schedules as a string into the template. This needs some
refactoring before the custom minute could be inserted.

For the most part, each scheduler's integration is relatively simple. That
is, until we get to the systemd integration. That integration made use of a
clever templating technique that is no longer possible when making this
adjustment. The last two patches involve systemd, though one is just a move
of code (without edits) to make the second's diff look a lot simpler.

Thanks, -Stolee

Derrick Stolee (6):
  maintenance: add get_random_minute()
  maintenance: use random minute in launchctl scheduler
  maintenance: use random minute in Windows scheduler
  maintenance: use random minute in cron scheduler
  maintenance: swap method locations
  maintenance: use random minute in systemd scheduler

 builtin/gc.c           | 259 ++++++++++++++++++++++++++---------------
 t/t7900-maintenance.sh |   4 +-
 2 files changed, 166 insertions(+), 97 deletions(-)


base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1567%2Fderrickstolee%2Fmaintenance-random-minute-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1567/derrickstolee/maintenance-random-minute-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1567
-- 
gitgitgadget
