Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2187C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC30620678
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pib7S9xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388120AbgDBNEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:04:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42244 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBNEU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 09:04:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so1710244pfa.9
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7d1bHCDMEOO7P7gnLN/oX6EYhJkZwkqTR1rLBhWtZA=;
        b=pib7S9xzIOK6l+LEKn2ApKBMSkaT4dxYFJIDDpyHaJbBbm/USDtSPyxorUsryyHo7b
         0jr/h6qZonvBBWy7Tz3el+4n3RdgUKu7UvXaNAbV8+4p7KDRB1KIhZTAvmwdxsJQ4/oh
         2ubG8ogh+59siYUG7gpPVLtzKcDIvwsC+Rvjruu0k6Mxoj+WCjOQc14URm8Q6MK3DwWD
         kUcBJUj/qxvLFSxBb8OY7lLV1uBOJYoy2BlNqqqhbpQKuBrM/jDZidtibHxzZFVFQOtS
         KukTidXVFo+ijNgfVDyz9XkQGDlT013Hc8UVlu0K1sWAiV4cXFXVVP1k6jbsJmO4ATGo
         mURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7d1bHCDMEOO7P7gnLN/oX6EYhJkZwkqTR1rLBhWtZA=;
        b=l7jl9zpQi9wNXqA+et2+kOdsLPke2A8SX6DQHM00Md/hBxZsEgS2uhB+z/dTnJIHq6
         y5p8PckQZyljuQBd5ysyk4NJdd88t8i2C0sZOuWO3ExY6QrX9FCwCqtMGSkEw5hMc4J5
         SLNRWpM8G+uSA/BuEF4pU0JWLa+KJ3yxLFoPmEiEXodrnNtISPFFN5NoOBoAGMaTOnTo
         FA+azhviwVK2pfLt8PxXQpHgkVlrQKMhw4suGGJ9TdN9zEwReM+CNz0twRkEiwgYh+oj
         h1kbicisGYlWaOydGZ67LnW/2Kmwg9euPETay88YG/wniU1GKlKUXZ5Df/K7yuYsJwLN
         Gpuw==
X-Gm-Message-State: AGi0Pua385QMbg8RQUmbig9RRYyissWhoy/pX/C/wqM9vBBtWVeC367s
        UN1gR5y5+MFayUedbcnkUUHseMS1
X-Google-Smtp-Source: APiQypIvf3Nt3N/oARgoAMA8KrY4FxHR6iY1ziw1PgPpqaJj8JwotWldWZLWGTiYAYli9EIPDWmT3w==
X-Received: by 2002:a63:1245:: with SMTP id 5mr3223922pgs.55.1585832659048;
        Thu, 02 Apr 2020 06:04:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id o15sm3371124pgj.60.2020.04.02.06.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 06:04:18 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 0/6] Travis + Azure jobs for linux with musl libc
Date:   Thu,  2 Apr 2020 20:03:59 +0700
Message-Id: <cover.1585832270.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585474409.git.congdanhqx@gmail.com>
References: <cover.1585474409.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Recently, we've un-broken git for Linux with musl libc,
and we have a serie to fix false negative with busybox shell utils.

Add a CI job on Travis and Azure to make sure we won't break it again.

This is a nearly rewrite of this series, because there're GitHub Action
allow running directly inside container.

=> I rewrite this series to prepare as much as possible for the GitHub
Action series.
=> No range-diff

The first patch is coming from Szeder, Junio hasn't picked it up yet.
And, this series depends on it.

Sample build without busybox fix series:
https://travis-ci.org/github/sgn/git/builds/670097222

With busybox fix:
https://travis-ci.org/github/sgn/git/builds/670103249


SZEDER Gábor (1):
  ci: make MAKEFLAGS available inside the Docker container in the
    Linux32 job

Đoàn Trần Công Danh (5):
  ci/lib-docker: preserve required environment variables
  ci/linux32: parameterise command to switch arch
  ci: refactor docker runner script
  ci/linux32: libify install-dependencies step
  travis: build and test on Linux with musl libc and busybox

 .travis.yml                                   | 10 ++++-
 azure-pipelines.yml                           | 39 ++++++++++++++++++-
 ci/install-docker-dependencies.sh             | 18 +++++++++
 ci/lib.sh                                     |  8 ++++
 ...n-linux32-build.sh => run-docker-build.sh} | 39 +++++++++++++------
 ci/{run-linux32-docker.sh => run-docker.sh}   | 28 ++++++++++---
 6 files changed, 121 insertions(+), 21 deletions(-)
 create mode 100755 ci/install-docker-dependencies.sh
 rename ci/{run-linux32-build.sh => run-docker-build.sh} (63%)
 rename ci/{run-linux32-docker.sh => run-docker.sh} (43%)

-- 
2.26.0.334.g6536db25bb

