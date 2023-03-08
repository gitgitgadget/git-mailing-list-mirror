Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0563C678D5
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 09:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCHJHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 04:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjCHJHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 04:07:45 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAA9BA5A
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 01:07:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h11so14619125wrm.5
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 01:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678266438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCjvsPS/5AzQ4XA5v/svYt3XrEHy+Cp3rMKbi3JxAI0=;
        b=P/ScWKCVxMxkEIWjLFFxLFURXWuuixdj9g09/v/AQeeq7XnDILqGayOjPW1vNK4cGH
         /xlUbj9KKh3ln0B9e68isnfZHUIh6Saidn5ke/A4BcmZWZNy4VPY6Zn4H0VlmOm0MWjf
         XCtY8UaTLpljnf2IbFDD9HiQmeV7TAKEuqAJKjV8XoKvcTy4Uo+RE8xDU5YSjS3l+McX
         EaHtH+gMPCRjExXOxYA0W5GNG2WtcncRGRmsTgWjfWdBsuaO7whJpGHE6Z+UPA1nAljP
         RCZcOIlBYMvh9rQ5bXL3Z84hw3QNUK/yzZZcFsy0JdFQ4z9svsnEMVfkymXLL31RZlA3
         9S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678266438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCjvsPS/5AzQ4XA5v/svYt3XrEHy+Cp3rMKbi3JxAI0=;
        b=sMtyvV6MrFhcX5tjQxEWnIfpViUFt/pdtg2qdyAlwVkzPchiqdrZJvEZ2PGm78FwSI
         IszdkgEqLAn9feOtPyuLcFVz6ZnoMDtn/LIaLw5djWOnO8GdETnXm3EuvhwKBXaXed4z
         rxKTpsEO0jg0nXFgEdM4kqLJUV+eKeOXtfw8dayGX+TOXbGtaZkmwM0e8gS5p6y80EnT
         doPPWiR9v+KCCstm0w0m+l6qQzTY7SPuZp6UZdrxmBZ7REoQT/IwZNjoTvYmACaSSrqQ
         2+kJTYUDENOA631M33zWvHsfIi7gJFg5mtJyt+Jq2oDQQN+tBR33hcr6czksM2kA0rEn
         6MLw==
X-Gm-Message-State: AO0yUKVAobWM0CWZ89jcPCAy3QX+kdyM9VegdCEZWWl2q0POAmKFp+YC
        WnzPNd96dpSqi0IF6kMIVVvJQZYtymqwMQ==
X-Google-Smtp-Source: AK7set/X46294vdyIiJStxMeuDehqxrkjvDtQB/jeVuU9jD9b3CGdG/7GwzJKsnSvpmzQNP4pJdguQ==
X-Received: by 2002:adf:f311:0:b0:2c9:730c:1439 with SMTP id i17-20020adff311000000b002c9730c1439mr10840510wro.30.1678266438455;
        Wed, 08 Mar 2023 01:07:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm14435156wrm.92.2023.03.08.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 01:07:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 0/9] config API: make "multi" safe, fix segfaults, propagate "ret"
Date:   Wed,  8 Mar 2023 10:06:42 +0100
Message-Id: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes numerous segfaults in config API users, because they
didn't expect *_get_multi() to hand them a string_list with a NULL in
it given config like "[a] key" (note, no "="'s).

A larger general overview at v1[1], but note the API changes in
v2[2]. Changes since v6[3]:

 * Glen pointed out that ejecting a commit in v6 orphaned a
   corresponding forward-reference in a commit message, fix that.

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com/
3. https://lore.kernel.org/git/cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com/
4. https://lore.kernel.org/git/kl6lwn3sgjam.fsf@chooglen-macbookpro.roam.corp.google.com/

Ævar Arnfjörð Bjarmason (9):
  config tests: cover blind spots in git_die_config() tests
  config tests: add "NULL" tests for *_get_value_multi()
  config API: add and use a "git_config_get()" family of functions
  versioncmp.c: refactor config reading next commit
  config API: have *_multi() return an "int" and take a "dest"
  for-each-repo: error on bad --config
  config API users: test for *_get_value_multi() segfaults
  config API: add "string" version of *_value_multi(), fix segfaults
  for-each-repo: with bad config, don't conflate <path> and <cmd>

 builtin/for-each-repo.c              |  14 ++--
 builtin/gc.c                         |  15 ++--
 builtin/log.c                        |   6 +-
 builtin/submodule--helper.c          |   7 +-
 builtin/worktree.c                   |   3 +-
 config.c                             | 109 ++++++++++++++++++++++-----
 config.h                             |  68 ++++++++++++++---
 pack-bitmap.c                        |   6 +-
 submodule.c                          |   3 +-
 t/helper/test-config.c               |  28 ++++++-
 t/t0068-for-each-repo.sh             |  19 +++++
 t/t1308-config-set.sh                | 108 +++++++++++++++++++++++++-
 t/t3309-notes-merge-auto-resolve.sh  |   7 +-
 t/t4202-log.sh                       |  15 ++++
 t/t5304-prune.sh                     |  12 ++-
 t/t5310-pack-bitmaps.sh              |  20 +++++
 t/t5552-skipping-fetch-negotiator.sh |  16 ++++
 t/t7004-tag.sh                       |  17 +++++
 t/t7413-submodule-is-active.sh       |  16 ++++
 t/t7900-maintenance.sh               |  38 ++++++++++
 versioncmp.c                         |  22 ++++--
 21 files changed, 477 insertions(+), 72 deletions(-)

Range-diff against v6:
 1:  43fdb0cf50c =  1:  9f297a35e14 config tests: cover blind spots in git_die_config() tests
 2:  4b0799090c9 =  2:  45d483066ef config tests: add "NULL" tests for *_get_value_multi()
 3:  62fe2f04e71 !  3:  a977b7b188f config API: add and use a "git_config_get()" family of functions
    @@ Commit message
         "int" instead of "void". Let's leave that for now, and focus on
         the *_get_*() functions.
     
    -    In a subsequent commit we'll fix the other *_get_*() functions to so
    -    that they'll ferry our underlying "ret" along, rather than normalizing
    -    it to a "return 1". But as an intermediate step to that we'll need to
    -    fix git_configset_get_value_multi() to return "int", and that change
    -    itself is smaller because of this change to migrate some callers away
    -    from the *_value_multi() API.
    -
         1. 3c8687a73ee (add `config_set` API for caching config-like files, 2014-07-28)
         2. https://lore.kernel.org/git/xmqqczadkq9f.fsf@gitster.g/
         3. 1e8697b5c4e (submodule--helper: check repo{_submodule,}_init()
 4:  e36303f4d3d =  4:  3a5a323cd91 versioncmp.c: refactor config reading next commit
 5:  e38523267e7 =  5:  dced12a40d2 config API: have *_multi() return an "int" and take a "dest"
 6:  3a87b35e114 =  6:  d910f7e3a27 for-each-repo: error on bad --config
 7:  66b7060f66f =  7:  57db0fcd91f config API users: test for *_get_value_multi() segfaults
 8:  0da4cdb3f6a =  8:  b374a716555 config API: add "string" version of *_value_multi(), fix segfaults
 9:  627eb15a319 =  9:  6791e1f6f85 for-each-repo: with bad config, don't conflate <path> and <cmd>
-- 
2.40.0.rc1.1034.g5867a1b10c5

