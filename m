Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7D1D1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 23:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfJBXtd (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 19:49:33 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:56872 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfJBXtc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 19:49:32 -0400
Received: by mail-pg1-f201.google.com with SMTP id u4so632731pgp.23
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 16:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=2iP60HDYfuzrb/NxgpZH3Rqc2oIV+tXyN5JAWDhlOhk=;
        b=bCP29OBZZH3ZGDNxiME2AMBjeEnKaY2vlCLf1xt1CKpLzbEkKbkLCMVy9d4yWEmnlE
         9Kt1qgzaczge/ItURMMISrsf6ft0WDWNYso0nrVPoHBszMWOxQ+9H2yAsfrH0wM8Vr1Q
         CDlYtyG/Ve43RUwYpx0U/yMso4ynOpK842NDzKIexE/lOBmUUqIuI5DIgRHWhH7fgqpS
         JIGSOnQHUcSv+DKn99DYWtdU+Aot9PZtRx5L7pF6T0R3zPl41XFh9hw7HAni9LfRlVt+
         xxNJygG71Y0BGECdkCWaZGzy0u8WesU0Dyx1GbCum5ZO3+A9IXY0f6rSYzQwIpoujJFC
         Ys3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=2iP60HDYfuzrb/NxgpZH3Rqc2oIV+tXyN5JAWDhlOhk=;
        b=FM9wYCmTSPetQDtV3vbcwyCC3yJbGA6hdYXJ3Ysk9v4NLO+VtQDEj49Y1OnS7btRmy
         F+Fau26Q5XiUVmOHofRCTb/meiCSfJmh/h565bgFaO/YfZcq6LPMd34c2cghbrO89/Pb
         x4WgUUSqXVJsraRHggU1DlISyATR+EBy0kGK68M06XTPsKL73OawqabvyVi3X2qdjtdY
         V/OeSXR+VIV3sDsgOGdKHpbbBLJWE6+BHeK9cuvhMZa2+szfUm7fuX03kJ7b2OfXH/25
         y07F1TTOYvbf58AbuMRbPTocEH0MwMAA01OhHYW1rvDWO4oI1zlbWU31CUHZmMYmti+B
         b6Tg==
X-Gm-Message-State: APjAAAXVvfihiDeA9NwYMZxaxy5VzhREYpLeVjPUxd0h4+qnoLilo3XU
        WFJc6xcT3y0jQgvCT2vPMqyGD2R0gQIh3/BOxDceeD8RfuK7p/kzyWzTgk4SxAmBMjdrmvGWyiX
        bXA6xxzGV7L3t5ch6j7P1R/uksiKZgi7vii0OHDkgU1aobM0NR7a4ZlD0p6bMjoY=
X-Google-Smtp-Source: APXvYqwh7nshsvqkg0b/XBXi59u4r8UFfCp47yx/lMdVbkqLt+x5VudKvJtAeZ6n68J4OiZoTF3vsLV3O6/dig==
X-Received: by 2002:a63:4924:: with SMTP id w36mr6536753pga.113.1570060171662;
 Wed, 02 Oct 2019 16:49:31 -0700 (PDT)
Date:   Wed,  2 Oct 2019 16:49:27 -0700
Message-Id: <cover.1570059953.git.steadmon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 0/2] add trace2 regions to fetch & push
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We'd like to collect better statistics about where the time is spent in
fetches and pushes so that we can hopefully identify some areas for
future optimization. So let's add some trace2 regions around some of the
fetch/push phases so we can break down their timing.

Josh Steadmon (2):
  fetch: add trace2 instrumentation
  push: add trace2 instrumentation

 builtin/fetch.c | 22 +++++++++++++++-------
 builtin/push.c  |  2 ++
 fetch-pack.c    | 13 ++++++++++++-
 transport.c     | 14 ++++++++++++--
 4 files changed, 41 insertions(+), 10 deletions(-)

-- 
2.23.0.444.g18eeb5a265-goog

