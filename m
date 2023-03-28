Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E04C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjC1OGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC1OGL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:06:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A05ECA1E
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so9504622wmq.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKdoz8Xp6iodDGIZKsiD48q69nz9jdau8wljbxb+fM0=;
        b=E5fCkw1YJ0S2owCl0jGxYMMfXSPljIOwyUcK2RkpFLFRRvHRHnv9T5Y52Q8G43AkBk
         AZEJtO5MThBFEx+ZZDzUlqbKgr1+mtX9fRHgBkP8571Xd0gbW3v4zKeiklOnQjmOMb1+
         JSndV5hAp4kgrOyKwhcKr97mBXKSdYimBtTkxbqf+phL4QqwooiDnDKJUOswBgU9qYQ/
         xdj1LPb30B/wbRv2Wj6i7vMmmABl/4N/g2Z6iQpr0gqh0442+oq9+U7DtXH0uwT92aA0
         I6LL50bU79ChHHGvxVBo59o09+xZJLn0TI9rkSNC5miCHb4b39C9GSslDY7sLxAhM9pZ
         QGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKdoz8Xp6iodDGIZKsiD48q69nz9jdau8wljbxb+fM0=;
        b=k0J8X+wSKs4u9JA7hPeLClGLPkqokPq9JIXmcXOJMldMYE7Se5Df54q2l/XCT6KKYG
         CNUN00WhiyyPzUL4oEvtWueP2Vt8civMJgvg2mCBj5+wYfzKaTeZ7fXX3RWroSA+pcbq
         DwIHlnMmG7XcrTU+DTGsYv2ajtlM5tZukt2f96pO+EtrL3acx5xSDmGJbedmd7VGwNC7
         ypv6xFh+PjnQs8yUMDay9lTGK3aOcCfr93IWUuPnslujeMsy89X6Cdq8GRn9kX4xlKhI
         oyULujAC0GQoNwhkQ8h96hZebcWnK65C6KjwU36rwAeC5audy6o8Zw9Zodotgg/IcCRp
         j0kw==
X-Gm-Message-State: AO0yUKWzbEnjR+LFlJxF0QoS99iKlH3xz+Lrptz3EJVD5P+Jos93kcXj
        u2JhXocPW+6nrD/a8hUirKKJUlMXHKY5Ug==
X-Google-Smtp-Source: AK7set/62/2yhZ3ltIl2aEvs4a3i0aVPWPm1u1mhdHshuejqsuY0Ybk92lqd/uMn/mCFc6c86bGPhw==
X-Received: by 2002:a7b:cd88:0:b0:3ee:7061:1bdd with SMTP id y8-20020a7bcd88000000b003ee70611bddmr12342922wmj.4.1680012276227;
        Tue, 28 Mar 2023 07:04:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c3b8a00b003ede3f5c81fsm12903622wms.41.2023.03.28.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:04:35 -0700 (PDT)
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
Subject: [PATCH v8 0/9] config API: make "multi" safe, fix segfaults, propagate "ret"
Date:   Tue, 28 Mar 2023 16:04:19 +0200
Message-Id: <cover-v8-0.9-00000000000-20230328T140126Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
References: <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
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
v2[2]. Changes since v7[3]:

* A trivial documentation change to 3/9, to clarify which doc in
  config.h refer to what. As noted in the v7 discussion I think that
  config.h could use some larger cleanups in this area, but let's
  leave that for some future topic.

Branch & passing CI for this at:
https://github.com/avar/git/tree/avar/have-git_configset_get_value-use-dest-and-int-pattern-8

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com/
3. https://lore.kernel.org/git/cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com/

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
 config.h                             |  72 +++++++++++++++---
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
 21 files changed, 481 insertions(+), 72 deletions(-)

Range-diff against v7:
 1:  9f297a35e14 =  1:  b600354c0f6 config tests: cover blind spots in git_die_config() tests
 2:  45d483066ef =  2:  49908f0bcf3 config tests: add "NULL" tests for *_get_value_multi()
 3:  a977b7b188f !  3:  d163b3d04ff config API: add and use a "git_config_get()" family of functions
    @@ config.h: void git_configset_clear(struct config_set *cs);
       * value in the 'dest' pointer.
       */
      
    ++/**
    ++ * git_configset_get() returns negative values on error, see
    ++ * repo_config_get() below.
    ++ */
     +RESULT_MUST_BE_USED
     +int git_configset_get(struct config_set *cs, const char *key);
     +
 4:  3a5a323cd91 =  4:  d7dfedb7225 versioncmp.c: refactor config reading next commit
 5:  dced12a40d2 =  5:  840fb9d5c74 config API: have *_multi() return an "int" and take a "dest"
 6:  d910f7e3a27 =  6:  75a68b14217 for-each-repo: error on bad --config
 7:  57db0fcd91f =  7:  a78056e2748 config API users: test for *_get_value_multi() segfaults
 8:  b374a716555 =  8:  686b512c3df config API: add "string" version of *_value_multi(), fix segfaults
 9:  6791e1f6f85 =  9:  6fce633493b for-each-repo: with bad config, don't conflate <path> and <cmd>
-- 
2.40.0.rc1.1034.g5867a1b10c5

