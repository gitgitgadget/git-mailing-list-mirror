Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E127FC7EE23
	for <git@archiver.kernel.org>; Wed, 31 May 2023 23:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjEaXMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 May 2023 19:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjEaXMo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2023 19:12:44 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4994597
        for <git@vger.kernel.org>; Wed, 31 May 2023 16:12:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565d1b86a64so2098177b3.3
        for <git@vger.kernel.org>; Wed, 31 May 2023 16:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685574762; x=1688166762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uE0z4VLSPRLlcqCHX/4LIOC4dkdKWVinu/h2KczwqYk=;
        b=2O1nNHdqZcRFl6Jcikl/Z612WjSdFZTYXXln2h0rw/chgcImc2l/fzxWiyPqw3YzsF
         tscWi+Cy7ZX3sF/1RRrFVooRaNQcSDAF3bPts2HHSM18GWRMKG1fwj3NRrmD+kUz2nJq
         9EdwXENeCjrJ3EP0COljvvTizPz2aod/9TCO6GlgAp07y1MgSnJEYcPTh9MAOzAcP1kP
         +Cq4pCU9z3NL8snVEApc+yvq8ZUgbSjEg29Mr8xTD6UL743WkBxSbyNruqh8QCTn3b7X
         8btiUyyV9FDo0yejzzgqworaUf1oR6mRll8KRvnScnR0rVDXLDn0QlAeinnrIqphi8Rp
         GK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685574762; x=1688166762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uE0z4VLSPRLlcqCHX/4LIOC4dkdKWVinu/h2KczwqYk=;
        b=KgPrtO8/lZCsI4PQoDbausgFa2lQBx0xg+r1t/GEIdFHi3Qaft93avWoql4ywMj98v
         adzam8tZ2C/THgTzx6WB7cypz4qKvXykFL8c5L12e66sjS0bcG3lN+OWqSRataokdXvB
         C3IP4HzGWxu7uTlZ7qSoXSO8ZvrAssPBS0sPrNSfUzWv68ICxdRTKi+Gz+vB/qaV7BIQ
         4OMLPxHj71k2xAlRM/ReDkskdAPSb+pVWLnw8zQPkDK+BVukJ3puks6wL098U0PNjmYw
         UWpskJL4Bg4sisy1JtMNQfC3ekDsZeo10IlgUkNvfIeDL+qH1+39BlgB++x05zq89s2U
         5/hg==
X-Gm-Message-State: AC+VfDwfinM/mrI2gIlhMYIubGAJF9METmMgiTdbFc2YUB9dwV1s0kwR
        /VU8yU0mopij11WtJslpKmvILZooqwqXqFj45yEGw35iv2QD//X6TqODoyrkObAf2GkrmCNiNF7
        RfiKayMvu3Glv+xySaRM1ktalYVAbO/psXKxRgWbfPy0l7c4TCv2NwMOzWmM3yEnycGjIbWpMI0
        yW
X-Google-Smtp-Source: ACHHUZ4hNPIkWoJcu4wXPreSigThwnV84xLG3mJ6RrzWV679B5Vh6xV5sXroD/dVptRapciuo6jjplfGvy22tUGIcYDO
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:2ee:ade5:9636:9867])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b147:0:b0:54f:646d:19c8 with
 SMTP id p68-20020a81b147000000b0054f646d19c8mr4339397ywh.3.1685574762429;
 Wed, 31 May 2023 16:12:42 -0700 (PDT)
Date:   Wed, 31 May 2023 16:12:34 -0700
In-Reply-To: <cover.1684790529.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1684790529.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <cover.1685574402.git.jonathantanmy@google.com>
Subject: [PATCH v2 0/3] Changed path filter hash fix and version bump
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a new version. With this, Git can function with both version
1 (incorrect murmur3) and version 2 (correct murmur3) changed path
filters, but not at the same time: the user can set a config variable to
choose which one, and Git will ignore existing changed path filters of
the wrong version (and always write the version that the config variable
says).

In patch 1, the test assumes that char is signed. I'm not sure if it's
worth asserting on the contents of the filter, since it depends on
whether char is signed, but I've included it anyway (since it's easy
to remove).

Jonathan Tan (3):
  t4216: test changed path filters with high bit paths
  repo-settings: introduce commitgraph.changedPathsVersion
  commit-graph: new filter ver. that fixes murmur3

 Documentation/config/commitgraph.txt | 16 +++++--
 bloom.c                              | 65 ++++++++++++++++++++++++++--
 bloom.h                              |  8 ++--
 commit-graph.c                       | 29 ++++++++++---
 oss-fuzz/fuzz-commit-graph.c         |  2 +-
 repo-settings.c                      |  6 ++-
 repository.h                         |  2 +-
 t/helper/test-bloom.c                |  9 +++-
 t/t0095-bloom.sh                     |  8 ++++
 t/t4216-log-bloom.sh                 | 65 ++++++++++++++++++++++++++++
 10 files changed, 192 insertions(+), 18 deletions(-)

Range-diff against v1:
1:  3a5d53d3c0 < -:  ---------- t4216: test wrong bloom filter version rejection
2:  5a91f9682b < -:  ---------- commit-graph: fix murmur3, bump filter ver. to 2
-:  ---------- > 1:  175dc912fe t4216: test changed path filters with high bit paths
-:  ---------- > 2:  4a7553f3fb repo-settings: introduce commitgraph.changedPathsVersion
-:  ---------- > 3:  f5c3f6080a commit-graph: new filter ver. that fixes murmur3
-- 
2.41.0.rc0.172.g3f132b7071-goog

