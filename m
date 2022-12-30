Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D96CC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 07:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiL3H2Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiL3H2V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 02:28:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3029F18E09
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso8145641wms.5
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 23:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJMpYJWDmmKV+lHuO18zvZX8WDVA7DvLNVfig9FOXsM=;
        b=Xl120IgStGY210JzmW+l0aFDJv8PmGVbAbq0BW4IGm0yStTB0uXs8TI5CA1/caGZlM
         NfGSHvRTZi0Kr7NJW90M8Bhh984SC3NryNLZ0IXw1P5W4+ijmZtx38QJye5+7v6Ozwt7
         HwblzNlLwSQ0CFC5aaQYPXkrLvCdvL7ZuTnuhgHUt0SLW5Drh5GYgbFNV51yhc8m0ilE
         6yQ5qu6OaGFSQVD6aK1QNXXFTbQ1ph3fV9rgZHBoeExAJCnbab450SKXKyDzZtLJy7No
         W/TkxH+29cTTMJHboBRUcNiAl/50Sxpz54ACp5XuVRpV7coW40cWnbhzLeuOcRX4V0Ax
         h2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJMpYJWDmmKV+lHuO18zvZX8WDVA7DvLNVfig9FOXsM=;
        b=3YwNApzVMwHsf73jsu2SIUjOeU32k1bDcTeRRqZ4X1/y4O6ZVjDv5hsFrPVeFHWopf
         OhdqkQ241QalHP9UJYlhCPTtOYzXf+dbevRa5NbY2wjOMcARsi80A6G1Ic84sSZCu6aT
         VeStOgyScuxGneUxz12/MXPckclU3EfJspmhzOPXjAbp6/RBeH2+13N4kObYIDVXenWB
         tkxbPrbe/r2btGcx3nchlufbHbzkd7GDyZRxtC+FbiTs44ks/4I2uBIHTKHubxACieso
         vPuYCceqFdfYw135eVSB2iqmzZrPDCCnQdVTqJAQCSCbLuBv6sw1EptwOivzad5rPXXd
         UKJQ==
X-Gm-Message-State: AFqh2ko/z3x10AgB01SclWKfuRkpL9trEgt/1cbws5gEa3qR5PXBCPYK
        tRR3S3rClC2xGraqH89ftXIy1z/KUXZZxQ==
X-Google-Smtp-Source: AMrXdXvEWm+qgmmSUnQ+pVEFMYMbyJ2XZbBconvTr+ypA+CKkUq6mhBU8hyvWZQYi4QeCzcy3YGxdA==
X-Received: by 2002:a05:600c:48a1:b0:3d1:f270:a81e with SMTP id j33-20020a05600c48a100b003d1f270a81emr21971078wmp.17.1672385298118;
        Thu, 29 Dec 2022 23:28:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c444d00b003d998412db6sm6526449wmn.28.2022.12.29.23.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 23:28:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/10] sequencer API & users: fix widespread leaks
Date:   Fri, 30 Dec 2022 08:28:05 +0100
Message-Id: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes various widespread leaks in the sequencer and its
users (rebase, revert, cherry-pick). As a result 18 tests become
leak-free in their entirety.

The main change is the 3/10 here, where we introduce a
replay_opts_release() to free the "struct replay_opts". The rest is
then either refactorings to be able to call that destructor
(e.g. "return" to "goto cleanup"), or other miscellanious adjacent
leaks.

This is a follow-up to the discussion ending at [1], as noted there
the recent ff84d031a9d (Merge branch 'pw/rebase-no-reflog-action',
2022-11-23) ended up introducing a leak because of the disfunctional
lack of a destructor (or rather, the current logic being tied up in
sequencer_remove_state().

This can be queued and graduated independently of the other concurrent
leak series I've submitted[2]. When the two are combined we'll end up
passing more tests, i.e. both topics combined get us over the finish
line for some of them, but neither one is enough in isolation.

But that's OK, we just won't opt them into the "linux-leaks"
testing. I'll submit a follow-up similar to [3] at some later date to
mark them as passing. I think that's a better trade-off than making
these two depend on one another.

1. https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com/
3. https://lore.kernel.org/git/patch-v2-01.20-3de29c6d75f-20221230T020341Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  rebase: use "cleanup" pattern in do_interactive_rebase()
  sequencer.c: split up sequencer_remove_state()
  rebase & sequencer API: fix get_replay_opts() leak in "rebase"
  builtin/revert.c: refactor run_sequencer() return pattern
  builtin/revert.c: fix common leak by using replay_opts_release()
  builtin/revert.c: move free-ing of "revs" to replay_opts_release()
  builtin/rebase.c: fix "options.onto_name" leak
  sequencer.c: always free() the "msgbuf" in do_pick_commit()
  builtin/rebase.c: free() "options.strategy_opts"
  commit.c: free() revs.commit in get_fork_point()

 builtin/rebase.c                       | 19 +++++-----
 builtin/revert.c                       | 40 +++++++++++----------
 commit.c                               |  1 +
 sequencer.c                            | 48 +++++++++++++++++---------
 sequencer.h                            |  1 +
 t/t3405-rebase-malformed.sh            |  1 +
 t/t3412-rebase-root.sh                 |  1 +
 t/t3416-rebase-onto-threedots.sh       |  1 +
 t/t3419-rebase-patch-id.sh             |  1 +
 t/t3423-rebase-reword.sh               |  1 +
 t/t3425-rebase-topology-merges.sh      |  2 ++
 t/t3431-rebase-fork-point.sh           |  1 +
 t/t3432-rebase-fast-forward.sh         |  1 +
 t/t3437-rebase-fixup-options.sh        |  1 +
 t/t3438-rebase-broken-files.sh         |  2 ++
 t/t3501-revert-cherry-pick.sh          |  1 +
 t/t3502-cherry-pick-merge.sh           |  1 +
 t/t3503-cherry-pick-root.sh            |  1 +
 t/t3506-cherry-pick-ff.sh              |  1 +
 t/t3511-cherry-pick-x.sh               |  1 +
 t/t7402-submodule-rebase.sh            |  1 +
 t/t9106-git-svn-commit-diff-clobber.sh |  1 -
 t/t9164-git-svn-dcommit-concurrent.sh  |  1 -
 23 files changed, 82 insertions(+), 47 deletions(-)

-- 
2.39.0.1153.g589e4efe9dc

