Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B9AC04E69
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 17:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGURap (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjGURaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 13:30:23 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A1B3A96
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:12 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-579d5d89b41so24309707b3.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689960611; x=1690565411;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fep75uP7HZ3Jm6OOMyWgMieaC6eiYV+QXc2uyc/jZJI=;
        b=q0pmDAbOi9+gj79g6tAO7TgLYNhW9shwun4pSlgqMgt0sEY/C21MIOGtF6NHpHJImd
         Di1wL14uFHivmKLEB39aMU1/qxtco787SYK7MeIOG+X6GmydDFB4c3CE7Ywu2LaVwC+A
         xukvaz1jBtqHoCS9RiLy/NTUtPpd7gTLVVoBRn/wk0GGBTBr5h9ayQ5BZAsxPggsC5pO
         paRZoOAw2SicbeaTa3zDDlHF/0l+WXVZrY2fxJCgS649hkw/0eqaFJkqQacd9NOeasNG
         GF7WNvv9N/T0Rl6H7z0X1aT0V84lAiO8IfkAz0ksICqT4CTP0R+iFqDI+ukgNDNEJxr/
         2YaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960611; x=1690565411;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fep75uP7HZ3Jm6OOMyWgMieaC6eiYV+QXc2uyc/jZJI=;
        b=WCU6e4ei1ndR7960powSn8RYc6thabltepPRT4zBVr1IDWdyw3oNuCMNXjnLVu45BD
         cfblP/Z1+NpYuJH3kQ4aMkUCXTkC5J38rnec4eWnFD1tJCfhAZfti21aa3c9BDCot9ev
         wPVi4tgvkakbEfKw6wh65RRJCCpv62FJ0ar56c9FjSqgQbpcF4RIxrYQyBGDzhyjKkoL
         PLn0Ta2Jsna3CYTZPq+GYQz6a/5rXh6d9W/Q0CEySasDiho3BZXhzA4tRX/2rp8mr3vT
         BqvyhnoC7uH3V2xVRksRXDtTfM2bUCPSImZ/qRWPQoZ7ZGNZHd9c86g2mgytSXIitJ0l
         OaiQ==
X-Gm-Message-State: ABy/qLYGT46yxGoShLo6jv4xs8dlN1VDSqriwIXApWxMeV5/IBWJ9M/O
        NNWYnVrYij5gEGmT46chkT19K4ATTxYxas9Bv1jZew==
X-Google-Smtp-Source: APBJJlFLD0eseKv3hhIkds1FGzJyonxzU9Ci08c9BXrhZnvXywJk7UzvwTVv4Xn16paHtvaYU+2vXA==
X-Received: by 2002:a0d:cb4f:0:b0:583:69b4:c75a with SMTP id n76-20020a0dcb4f000000b0058369b4c75amr683013ywd.21.1689960610977;
        Fri, 21 Jul 2023 10:30:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x196-20020a81a0cd000000b005838c613b40sm712547ywg.44.2023.07.21.10.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:30:10 -0700 (PDT)
Date:   Fri, 21 Jul 2023 13:30:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/5] commit-graph: test cleanup and modernization
Message-ID: <cover.1689960606.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This short series addresses a few style nitpicks that I noticed while
looking through the commit-graph tests while writing [1].

Most importantly, it removes many instances in t5318 that change
directories outside of a sub-shell, altering the current working
directory of subsequent tests. This makes it difficult to run a subset
of tests, or otherwise include `cd "$TRASH_DIRECTORY"` at the top of
each test.

The first two patches are predatory, the next two are the substantive
test clean-ups, and the final patch cleans up some intermediate state
necessary to perform the clean-up over multiple commits.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/cover.1688776280.git.me@ttaylorr.com/

Taylor Blau (5):
  t/lib-commit-graph.sh: allow `graph_read_expect()` in sub-directories
  t/lib-commit-graph.sh: avoid directory change in
    `graph_git_behavior()`
  t5318: avoid top-level directory changes
  t5328: avoid top-level directory changes
  t/lib-commit-graph.sh: avoid sub-shell in `graph_git_behavior()`

 t/lib-commit-graph.sh              |  27 ++-
 t/t5318-commit-graph.sh            | 378 +++++++++++++----------------
 t/t5328-commit-graph-64bit-time.sh |  54 ++---
 3 files changed, 217 insertions(+), 242 deletions(-)

-- 
2.41.0.381.gd8424d64777
