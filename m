Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2A11FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 00:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdFHA5B (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 20:57:01 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33580 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdFHA5A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 20:57:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so3193320pfe.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 17:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=+9h/eSc0fdkWIge2iZHPSGinYCKKWaISu/1GxmLbzxg=;
        b=Vrnd4hOesY4L8lVl2pWtx4Clly2EBK0Pl1w+E8kwukdVdXYgYT0Tm67uIhV8N5x63v
         U9ihSFVATL4GgJbbHXX4Ia7D2a8YkAHv4wavwXUV4YYWQ5jQ1OUtrDV+kEpJBG0iLesn
         570Kyp3p7rEduThuOiSTnXfcn4EkCq8+1uRRQydZPAy+WmQ7q9ea7XzG5xGvVGNbJ8CS
         s/OgB8M/lUkai2Uzs1x+QFoZM0H01x/Xyjhic590beHQ+IJmLRUhKUibijDhl6l44z8q
         G1Hip4F8L0yJHi4fftfnG6UIuG47LgenegEQJtDMniKX+cb6nzVNGVLdLM9njzIbYrim
         7ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+9h/eSc0fdkWIge2iZHPSGinYCKKWaISu/1GxmLbzxg=;
        b=RAQLrceCQf39y5EZJ5xxfG9zoDXmzvLveLoCQkbtaAHybLK6Y+MTlLPWSDWN0Zbe0M
         NikCfkA/ly+UMgt+lCOWmrJwzgOmzG44DOmNxMH3wdzBQfZsDecmrAogFaf9SSay/T2T
         yBBm7tqkstFcJ+sMQlX4Hngd393VVWGtji4hXEzcuZZ7D/Z8LDNtPHZn/02Ame2hEPkc
         al8caF9MnsL4FOgxptcC7kC0RaorcQ6HgVnd5d5lQIrS1iDGACAQ7o7dqmbwi7RwcSkh
         3TF1t7Gnbw/4EgqrORbqXVjs6qxtNNygi7+dgxxX2C0RuT/7Qghq9df2UCWCPz2YI3aQ
         hf3A==
X-Gm-Message-State: AODbwcBz848tklBeLWwlMyTWmFrFC/lRBPvpWff/RA3h2L1m9KFG36H6
        eHVoYaGDkmuB8pnhu+s=
X-Received: by 10.101.70.129 with SMTP id h1mr35625440pgr.50.1496883419276;
        Wed, 07 Jun 2017 17:56:59 -0700 (PDT)
Received: from localhost.localdomain (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id s17sm6418848pfk.112.2017.06.07.17.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jun 2017 17:56:58 -0700 (PDT)
From:   Joel Teichroeb <joel@teichroeb.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Joel Teichroeb <joel@teichroeb.net>
Subject: [PATCH v4 0/5] Implement git stash as a builtin command
Date:   Wed,  7 Jun 2017 17:55:30 -0700
Message-Id: <20170608005535.13080-1-joel@teichroeb.net>
X-Mailer: git-send-email 2.13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've rewritten git stash as a builtin c command. All tests pass,
and I've added two new tests. Test coverage is around 95% with the
only things missing coverage being error handlers.

Changes since v3:
 * Fixed formatting issues
 * Fixed a bug with stash branch and added a new test for it
 * Fixed review comments

Outstanding issue:
 * Not all argv array memory is cleaned up

Joel Teichroeb (5):
  stash: add test for stash create with no files
  stash: Add a test for when apply fails during stash branch
  stash: add test for stashing in a detached state
  merge: close the index lock when not writing the new index
  stash: implement builtin stash

 Makefile                                      |    2 +-
 builtin.h                                     |    1 +
 builtin/stash.c                               | 1224 +++++++++++++++++++++++++
 git-stash.sh => contrib/examples/git-stash.sh |    0
 git.c                                         |    1 +
 merge-recursive.c                             |    9 +-
 t/t3903-stash.sh                              |   34 +
 7 files changed, 1267 insertions(+), 4 deletions(-)
 create mode 100644 builtin/stash.c
 rename git-stash.sh => contrib/examples/git-stash.sh (100%)

-- 
2.13.0

