Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914D9EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjFNT0H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFNT0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:26:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5777C2135
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f8d1eb535eso9129445e9.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686770761; x=1689362761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAsfcRPXVit9bJyRwxvgIaceQ3tOHJjzaLDKm7jbE60=;
        b=LNdwf/tiHPB1HXqNObOYKlyzqIftuxui+0COGjowFJBa/NedVuh6AjzZlp5FEYwvzH
         kg0N1CI7PovqlT2+1DP59+32Z0PCncAmcT5/oblr4vJVXwBA+Cc/6m2iIiiAt5//+T6D
         RwhwBXqgWK6moyul5mMWDze9b1qvILR1+mPNAdHGsaleHtyr2Be19tE88Z5PkgM9hvMY
         ac3+8Paz6+1at5SNT2+Rw/2eXdReqEo6m4vocKypRFM5VVPHPDpIkxPPkh6G4k0AIzHn
         YpiIvxmQCBwmE7jFLNvh3eYitKkYinAw+yHPCqv6l9IqJwEBN3a+VMT1VLGr8mdMBsEE
         Vr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770761; x=1689362761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAsfcRPXVit9bJyRwxvgIaceQ3tOHJjzaLDKm7jbE60=;
        b=UebVPTcOTsS3uGJYDWZnPlj+YGPr0hWGyWZdh4fV4XWvgOvMWkIdnGmXzHmdli3r0s
         /AdHkcChRZp/AaQ9o4g6pXnpta04hGRckG9nfvDKs7NhgKGtPgWtyjMYq1kkpTx/uywF
         O93RTWvep3AmS0raPZiQrT2Vv6LePmda6elSWK+NNK+bve5zLFxwnISAQmAeqHEymM65
         b3lCDYzvkzkJ3daqndNVRD0nIVzCEYqOSqlT92fwTrh69GtLt2yYy946xplgn4r8Zyng
         ciu+wIj73Wsx8cx+lpu6dT0CjFIE1jv6Cp7o6cro8mMPBfirGxuGTkMGWaTHTJOpZdSv
         thkA==
X-Gm-Message-State: AC+VfDwKNW2H4ewOL1MYaGXAL39fG91Wjw1wyrPy3uyum6d5JSHwmHrO
        /NNIiQXn3LPgGJYmPyn9mSpiOMpn184=
X-Google-Smtp-Source: ACHHUZ4G/c+ckNmS4204KYmB3zXB2b0s8+NaDGqr7qgnw+UXqMXyB6BdJpoduq215bA6dZlA6Jm/Pg==
X-Received: by 2002:a05:600c:2042:b0:3f7:f90c:4979 with SMTP id p2-20020a05600c204200b003f7f90c4979mr10376391wmg.26.1686770760743;
        Wed, 14 Jun 2023 12:26:00 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e164:efe0:8fdb:6ba])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm18370365wmm.39.2023.06.14.12.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:25:59 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/9] Repack objects into separate packfiles based on a filter
Date:   Wed, 14 Jun 2023 21:25:32 +0200
Message-ID: <20230614192541.1599256-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.37.gae45d9845e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Intro

Last year, John Cai sent 2 versions of a patch series to implement
`git repack --filter=<filter-spec>` and later I sent 4 versions of a
patch series trying to do it a bit differently:

  - https://lore.kernel.org/git/pull.1206.git.git.1643248180.gitgitgadget@gmail.com/
  - https://lore.kernel.org/git/20221012135114.294680-1-christian.couder@gmail.com/

In these patch series, the `--filter=<filter-spec>` removed the
filtered out objects altogether which was considered very dangerous
even though we implemented different safety checks in some of the
latter series.

In some discussions, it was mentioned that such a feature, or a
similar feature in `git gc`, or in a new standalone command (perhaps
called `git prune-filtered`), should put the filtered out objects into
a new packfile instead of deleting them.

Recently there were internal discussions at GitLab about either moving
blobs from inactive repos onto cheaper storage, or moving large blobs
onto cheaper storage. This lead us to rethink at repacking using a
filter, but moving the filtered out objects into a separate packfile
instead of deleting them.

So here is a new patch series doing that while implementing the
`--filter=<filter-spec>` option in `git repack`.

This could be useful for the following purposes:

  - As a way for servers to save storage costs by for example moving
    large blobs, or blobs in inactive repos, to separate storage
    (while still making them accessible using for example the
    alternates mechanism).

  - As a way to use partial clone on a Git server to offload large
    blobs to, for example, an http server, while using multiple
    promisor remotes (to be able to access everything) on the client
    side. (In this case the packfile that contains the filtered out
    object can be manualy removed after checking that all the objects
    it contains are available through the promisor remote.)

  - As a way for clients to reclaim some space when they cloned with a
    filter to save disk space but then fetched a lot of unwanted
    objects (for example when checking out old branches) and now want
    to remove these unwanted objects. (In this case they can first
    move the packfile that contains filtered out objects to a separate
    directory or storage, then check that everything works well, and
    then manually remove the packfile after some time.)

As the features and the code are quite different from those in the
previous series, I decided to start a new series instead of continuing
a previous one.

# Commit overview

* 1/9 pack-objects: allow `--filter` without `--stdout`

  This patch is the same as the first patch in the previous series. To
  be able to later repack with a filter we need `git pack-objects` to
  write packfiles when it's filtering instead of just writing the pack
  without the filtered out objects to stdout.

* 2/9 pack-objects: add `--print-filtered` to print omitted objects

  We need a way to know the objects that are filtered out of the
  packfile generated by `git pack-objects --filter=<filter-spec>`. The
  simplest way is to teach pack-objects to print their oids to stdout.

* 3/9 t/helper: add 'find-pack' test-tool

  For testing `git repack --filter=...` that we are going to
  implement, it's useful to have a test helper that can tell which
  packfiles contain a specific object.

* - 4/9 repack: refactor piping an oid to a command
  - 5/9 repack: refactor finishing pack-objects command

  These are small refactorings so that `git repack --filter=...` will
  be able to reuse useful existing functions.

* 6/9 repack: add `--filter=<filter-spec>` option

  This actually adds the `--filter=<filter-spec>` option. It uses one
  `git pack-objects` process with both the `--filter` and the
  `--print-filtered` options. From this process it reads the oids of
  the filtered out objects and pass them to a separate `git
  pack-objects` process which will pack these objects into a separate
  packfile.

* 7/9 gc: add `gc.repackFilter` config option

  This is a gc config option so that `git gc` can also repack using a
  filter and put the filtered out objects into a separate packfile.

* 8/9 repack: implement `--filter-to` for storing filtered out objects

  For some use cases, it's interesting to create the packfile that
  contains the filtered out objects into a separate location. This is
  similar to the --expire-to option for cruft packfiles.

* 9/9 gc: add `gc.repackFilterTo` config option

  This allows specifying the location of the packfile that contains
  the filtered out objects when using `gc.repackFilter`.


Christian Couder (9):
  pack-objects: allow `--filter` without `--stdout`
  pack-objects: add `--print-filtered` to print omitted objects
  t/helper: add 'find-pack' test-tool
  repack: refactor piping an oid to a command
  repack: refactor finishing pack-objects command
  repack: add `--filter=<filter-spec>` option
  gc: add `gc.repackFilter` config option
  repack: implement `--filter-to` for storing filtered out objects
  gc: add `gc.repackFilterTo` config option

 Documentation/config/gc.txt            |  11 ++
 Documentation/git-pack-objects.txt     |  14 ++-
 Documentation/git-repack.txt           |  11 ++
 Makefile                               |   1 +
 builtin/gc.c                           |  10 ++
 builtin/pack-objects.c                 |  55 ++++++--
 builtin/repack.c                       | 166 ++++++++++++++++++-------
 t/helper/test-find-pack.c              |  35 ++++++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/t5317-pack-objects-filter-objects.sh |  27 ++++
 t/t6500-gc.sh                          |  23 ++++
 t/t7700-repack.sh                      |  43 +++++++
 13 files changed, 345 insertions(+), 53 deletions(-)
 create mode 100644 t/helper/test-find-pack.c

-- 
2.41.0.37.gae45d9845e

