Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFEAC07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6526008E
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGGKYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhGGKYh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:24:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E4C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:21:56 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t6so2411805wrm.9
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hX1cRELzpbGqb75llFqRDmTL7uW8qHCbqYD/TXNp/vU=;
        b=MJu9QVI2hULTiwylBkD+905eO7Ga1bPQQ2t430Q3Nzh01Egox4YzKXYPDiQwjCoS+1
         3ji+5ho660suGf2GBaKDGY+3eDJ4Hs1gskQQ95r5UgesJYqxmfwE0gx70RV4VJIVNq+d
         a5FveGyaZ6kw7V8/uhvxzuLIxyQHDW7t7qW1Am9UoFX7kVlwH/t+BgN27vmRQ850LLFS
         hxXVAuK0S/LzbZSf9TAiWqCM6lWNFqEJltiJflxHIgShR3LfHAZlLwVBO7wfELUseoIO
         xafYY6nMderOqlUFLrw1Z+wXzvCZSp79UlmM2lQuMUW91OucPeFhOAhbaot3ZyRc9LLL
         RuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hX1cRELzpbGqb75llFqRDmTL7uW8qHCbqYD/TXNp/vU=;
        b=J7kTe84vHh0ELRiYJVAzUa0zVL5jM8Rd6+Kau9JIkcztxijrfD5QhX3e8SYRFe64AZ
         PQ5id1emwxz3GTVVNL2Gqr+NampGiXdjqdIeH/GCVGzj5LJM22xItxTEHIH8E4r6xjw5
         cnOc8AqV8Nh8VrKw30v3croeVvbNugk/HUa+z1quoYXyukzBe1LeNv46OzCfzgae42bx
         8Ei7CIeOMz5bOg84+1XEkHXmyNh8KMBY56o0nkU6JRloShvPH5eTY+rFOW+7+0SMUp2C
         uIRqbbNrN56HudtR8oOtStf5hOQ71W0SaPIeiiWzgIMZYDBmFGH6xp1SFsAqnLBkdxmW
         yg8A==
X-Gm-Message-State: AOAM531QxebCHoARwMdUvhmCy9FL4KDqaqzXAgJDrwNP7TZ+8rI7tHun
        EPH/6Rw6sc8tLMM0suEkyzHN1byKrdMJSg==
X-Google-Smtp-Source: ABdhPJyZgkHcz0NtLVEy402HUkeHg35jsQgj0W9R4h428jvTMPh8eUUdi1vw+Gs6s3eLb4fauz24iw==
X-Received: by 2002:adf:fd86:: with SMTP id d6mr27022610wrr.84.1625653314409;
        Wed, 07 Jul 2021 03:21:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm19701187wrr.76.2021.07.07.03.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:21:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] tests: migrate to "test-tool pkt-line"
Date:   Wed,  7 Jul 2021 12:21:44 +0200
Message-Id: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that uses [de]packetize() to use "test-tool
pkt-line". That we had these two concurrently in the tests is mostly
just a historical anomaly/inconsistency that we can fix.

Even the CC'd author of [de]packetize() has recently been using the
test-tool, in af22a63c399 (sideband: diagnose more sideband anomalies,
2020-10-28).

"Mostly" because it turns out we were missing one feature in the
test-tool, to packetize raw input without any \n or \0 munging. This
series adds that capabability, migrates those users, and finally
removes the now-obsolete [de]packetize() functions.

Ævar Arnfjörð Bjarmason (5):
  serve tests: add missing "extra delim" test
  serve tests: use test_cmp in "protocol violations" test
  tests: replace [de]packetize() shell+perl test-tool pkt-line
  tests: replace remaining packetize() with "test-tool pkt-line"
  test-lib-functions.sh: remove unused [de]packetize() functions

 t/helper/test-pkt-line.c               | 13 ++++++
 t/t5410-receive-pack-alternates.sh     | 42 +++++++++++++-----
 t/t5411/once-0010-report-status-v1.sh  | 12 ++---
 t/t5500-fetch-pack.sh                  | 15 ++++---
 t/t5530-upload-pack-error.sh           | 24 +++++-----
 t/t5562-http-backend-content-length.sh | 16 ++++---
 t/t5570-git-daemon.sh                  | 22 ++++++----
 t/t5704-protocol-violations.sh         | 61 ++++++++++++++++++--------
 t/test-lib-functions.sh                | 42 ------------------
 9 files changed, 136 insertions(+), 111 deletions(-)

-- 
2.32.0.636.g43e71d69cff

