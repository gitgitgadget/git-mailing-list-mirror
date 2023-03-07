Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB2CC6FD1A
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 18:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjCGSPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 13:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjCGSOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 13:14:33 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A642D9EF60
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 10:10:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id da10so56022102edb.3
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678212600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP8vBXXYoimJ50PXULAFJFs5XovRj6rwfpubaBTL5H8=;
        b=p3sEnk3VqB07vpZhv3PSjIX+MG8DVgCS3LAIi5PPBfnRWac+GwIDfVTBPqUClqqx/T
         w23f6oLVwhmq3eWLkmFxAXJxD5htffRmDjDLYUXRH8whY8u8282sK1fKaVshHAgd3WEd
         5sRVIwLhRpSQUXSx0Pg157KtL2peSSf2NlBIdr/kmoxe8n0mfrrhhfElpESOK4xeM2zA
         ANmHsFKh7iAX3duvRRJsvzXd3MWjLsk34NBR+ZLxOQEv5cCreIV10YWmi4i0AcFw6Rvc
         S8OZTcFZGurMqn5Vfn6DRX2UcTb6UiI9OVHaapTyxY9t4sFfylqhx/p+o0y9zTCgUF9Y
         RlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP8vBXXYoimJ50PXULAFJFs5XovRj6rwfpubaBTL5H8=;
        b=iIvb1n70AE8RN3/pdiRLIeHF0SWbRI2NW5ARFf8WOqrJL4sw2fZdxAwMsPvBuD90AY
         PvtjN5x8R5rsEzQnUd3USvSO8ujng6k8OSDgnVPIxPItqSUSR+MZQhv9tOT5Ho+o6vUs
         6wz6MQbiLRd7Uv96dd1jxa0rjiIC+nZzyw3i8MjuptHsCnwjkJ4vw0o5vXeEQVclh++t
         0C7Ecy+RahbTSNgtUuqYZ5ybZcQKCmrdqJa5tgVIofn52iX09fb3RiQsMji/Ee4Xo+qT
         QKr4iZGyDIO3780wNtmCyPUEdq0frmUrXyfsfZIB2HgJHAyidvYUTWsWW8EQqVGiBGPh
         dR/g==
X-Gm-Message-State: AO0yUKWr+IIxS3C7QT4aNFkhbfipOFtBT3sWDBNeQVReqmDGyKI4tMDY
        ZRlRf+8EbSaYAwO9yUNoJnmdRaG0Sf4=
X-Google-Smtp-Source: AK7set9QLPgdjTPnDvUjkUmxTkWbyj/3QpGmXe6L0w/Q8PFZWXnUjyBCryY3+8NTk295BiZX7BRTng==
X-Received: by 2002:a17:907:2d93:b0:8b2:2141:6de8 with SMTP id gt19-20020a1709072d9300b008b221416de8mr20793812ejc.73.1678212600395;
        Tue, 07 Mar 2023 10:10:00 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709063ec500b008b1797a53b4sm6401008ejj.215.2023.03.07.10.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:09:59 -0800 (PST)
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
Subject: [PATCH v6 0/9] config API: make "multi" safe, fix segfaults, propagate "ret"
Date:   Tue,  7 Mar 2023 19:09:31 +0100
Message-Id: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com>
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
v2[2]. Changes since v5[3]:

 * Drop the 6th commit, which made existing API functions return
   -1. We shouldn't coerce errors to "return 1", but making the API
   consistent can wait for a follow-up to this topic.

   This should address the reason for this topic being stalled for a
   while, see e.g. [4].

1. https://lore.kernel.org/git/cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com/
3. https://lore.kernel.org/git/cover-v5-00.10-00000000000-20230207T154000Z-avarab@gmail.com/
4. https://lore.kernel.org/git/xmqqcz5snyxz.fsf@gitster.g/

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

Range-diff against v5:
 1:  cefc4188984 =  1:  43fdb0cf50c config tests: cover blind spots in git_die_config() tests
 2:  91a44456327 =  2:  4b0799090c9 config tests: add "NULL" tests for *_get_value_multi()
 3:  4a73151abde =  3:  62fe2f04e71 config API: add and use a "git_config_get()" family of functions
 4:  382a77ca69e =  4:  e36303f4d3d versioncmp.c: refactor config reading next commit
 5:  8f17bf8150c !  5:  e38523267e7 config API: have *_multi() return an "int" and take a "dest"
    @@ config.c: void git_die_config(const char *key, const char *err, ...)
      }
     
      ## config.h ##
    -@@ config.h: int git_configset_add_parameters(struct config_set *cs);
    +@@ config.h: int git_configset_add_file(struct config_set *cs, const char *filename);
      /**
       * Finds and returns the value list, sorted in order of increasing priority
       * for the configuration variable `key` and config set `cs`. When the
 6:  b515ff13f9b <  -:  ----------- config API: don't lose the git_*get*() return values
 7:  8a83c30ea78 =  6:  3a87b35e114 for-each-repo: error on bad --config
 8:  d9abc78c2be =  7:  66b7060f66f config API users: test for *_get_value_multi() segfaults
 9:  65fa91e7ce7 =  8:  0da4cdb3f6a config API: add "string" version of *_value_multi(), fix segfaults
10:  4db3c6d0ed9 =  9:  627eb15a319 for-each-repo: with bad config, don't conflate <path> and <cmd>
-- 
2.40.0.rc1.1034.g5867a1b10c5

