Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45D0C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245648AbiFOKxl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243714AbiFOKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:53:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE435130A
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:38 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h19so11592675wrc.12
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xDMjg2UfZCcFgvn1q9idQihNe3JLOJNYz0/KKLpDuG4=;
        b=g/vT7dhUJe4NwDE44i42WS1BX8TdSBi6a3mzrRuadklW5TvrbvkOPr1fq5w8QXKIC4
         o+Ql0TpLKwyu/0EcHoaCuydkVwcU632lS/wAaIS+F97K+oU+1syKjec0/hTn50Y5EcVs
         8vW7KoyezRP1nlgvOaD5xxIGzLsIIhbH1hpU3Tj2E44AdwPoSghqtiWf4aV0WIKQdzQe
         7mUFxY2rz9c4/IAd63v2EdLOgjRvZUIrTrrVWifcgxEF2tjH6PkJM0SSicR9lOVyKkVc
         2mqQ3kHKMevjCftbmTnjqkpZA8MmFBSKL9L3vHZklFXv/l31OUElBC3rWzJmRDZ2X7pb
         3G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xDMjg2UfZCcFgvn1q9idQihNe3JLOJNYz0/KKLpDuG4=;
        b=OtpLoFUkAEWoAtxOKjD3hTn5jOuE1laQrBoeoGLa6hgi1BdYRvkl3P2hx6e/kwRNCO
         ulbE48EO9fBJ9dm8o2+xEJVUAd56hq6qm9iYMz1KVGgWTL1Q8olNGmaCMU2ieiNpOPFN
         11n+W+vnABpIpjRvmR2PSFxOoByMzF6WfufN5KPC+4Vkg+nbjgcamM9EsTeD0RnqU0dR
         cy4xlwJBWi5T6UV6x/5bHw0L2UX96oDs30E5U0h4Ts2rehD2v39L7FXdqO2zo3/iOlPm
         g4h+inpBK/R/WBhIiul6FXKGHeIw900eXblreNlpWzc541NZpwX2V6TemCCgdAYyqYJC
         JjRg==
X-Gm-Message-State: AJIora8PsGAorygWIEd+RHSMbCbRRrCPtguJPCciIKJiK1oHybDik9pY
        VKJ/PTIbJrfj8wsemuBeElsYKCpDGrk8UQ==
X-Google-Smtp-Source: AGRyM1s1aMm6WtZHxP/1craoj2sP0VnHdXBXtx7CH8+atYqJv/w1mVBaWDLg0vARfEGqn5nDBxPxDw==
X-Received: by 2002:a5d:69ca:0:b0:21a:536:61ba with SMTP id s10-20020a5d69ca000000b0021a053661bamr9390751wrw.235.1655290416657;
        Wed, 15 Jun 2022 03:53:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b0039bc95cf4b2sm1786747wmk.11.2022.06.15.03.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:53:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/5] fix issues in transfer.credentialsInUrl
Date:   Wed, 15 Jun 2022 12:53:27 +0200
Message-Id: <RFC-cover-0.5-00000000000-20220615T104503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on top of [1], and given the "rc" phase is an RFC. This:

 * Fixes the issue of the transfer.credentialsInUrl (now renamed) not
   finding passwords in "pushurl" URLs (in my case, the only place
   where I'd actually put a password in a URL in a config...)

 * 1/5 fixes a bug in an existing test, but I didn't think it was
   worth bothering with for 2.37.0.

 * Adds missing test coverage for reading the config from a file, not
   the CLI.

 * 3/5 is a WIP CI target to spot the type of issue I fixed in [2],
   it's not the first time where we have a NO_CURL=Y breakage land on
   master...

 * 4/5 attemps to "really" fix the duplicate warnings we emit, I think
   the approach there is good, especially the part where we shouldn't
   emit it twice in-process.

   But this currently misses e.g. "git ls-remote". I wonder if we
   should just stick that git_config_push_parameter() condition into
   packet_trace_identity() and call it a day.

 * 5/5 fixes the (major) blind spot of the warning missing "pushurl" config.

I think this is all non-RFC quality, except the "ls-remote" case, and
us missing tests for that & other transport users that aren't
clone/fetch/push.

Derrick: Are you interested in picking this up & pursuing it after the
release, with whatever fix-ups/rewrites etc. that you find
appropriate?

1. https://lore.kernel.org/git/cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.1-00000000000-20220615T103609Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  push tests: add a missing "test_line_count"
  fetch+push tests: add missing coverage for 6dcbdc0d661
  CI: add a linux-BUILD-vars job
  fetch: stop emitting duplicate transfer.credentialsInUrl=warn warnings
  transport: check remote.<name>pushurl with transfer.credentialsInUrl

 .github/workflows/main.yml |  3 ++
 builtin/clone.c            |  5 ++-
 builtin/fetch.c            |  4 ++
 builtin/push.c             |  6 ++-
 ci/run-build-and-tests.sh  | 30 ++++++++++++++
 remote.c                   | 82 +++++++++++++++++++++++++++-----------
 remote.h                   | 14 +++++++
 t/t5516-fetch-push.sh      | 46 ++++++++++++++++++++-
 t/t5601-clone.sh           |  2 +-
 9 files changed, 164 insertions(+), 28 deletions(-)

-- 
2.36.1.1239.gfba91521d90

