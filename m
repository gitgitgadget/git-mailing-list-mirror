Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0DFE748F8
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238530AbjJBQzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Oct 2023 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbjJBQzb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2023 12:55:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16BFA7
        for <git@vger.kernel.org>; Mon,  2 Oct 2023 09:55:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5344d996bedso15522626a12.3
        for <git@vger.kernel.org>; Mon, 02 Oct 2023 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696265726; x=1696870526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k97Pr8OKJomCSJcFsYyHs1rkOCBHF4SCK5ahm+05m3s=;
        b=UxRHwtnCLA3UYJ7rGiuqGf7hYgJRmtuvs5AmPP4SS2DVzDadRpAXWmXKBK1b4TaGIZ
         oafnrjA5u3wkZS48L7akyM0nTQmkSFs3cFYR8XE5nEcjt/f7JeWIzDAiJt7oz8Gxv/SB
         jf9MUFHYMp8gxwfjmEYMZCTTmGvOkwYW27sxr55z48kWc79GZod5hUYV2LlzEA1y3s4Y
         E8z7G92kyhdmfRAddE/YK7cgPwyh8AE4NAtnI7or+aSbOI8IlhmiXlJhw0R1MMqfjpNH
         9yaVxyj2yDbTlCbv38PqmE4L/qvzmTv3c2Mv/DpNc0yvuLXG+9R3SFC+Zj1oZzgF9m58
         OY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265726; x=1696870526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k97Pr8OKJomCSJcFsYyHs1rkOCBHF4SCK5ahm+05m3s=;
        b=Ve5nO1oTs9RMiK69P9kIOn0p4zIwQUMkOhLNSzmIz4o91GqA/ysPGGjA82ngBqmF0M
         0kwNs/SDVZ04ZA5ahJI5JU3HSoiJVaGd++a4YjtemhfGx3ZbrBN12X8wCuijq3J0+yR7
         jb6JUJCiuBfdaFwfdCekJGbQMn2wFiqB6GEOo69aLjGDsNNellvliNTnjRpJvmnJxFoL
         MxGaNUiwQE8sZs2r7CsIP3ahZaU8sI9ZCWv/wipKkdIIuz6a8T+fXCgcxQyY81Suz0sv
         j1Dv2YM7Wx3qx3+NIHxcTgUFxm/808tMbZ0PxqqZw6wW03XLACyTf4pIn1nheC/9N9CP
         Gf2Q==
X-Gm-Message-State: AOJu0YxixToQCA7U2s60NF7R6bqb1KsrrYc/bxkJANLOKSLNhtmkZRvQ
        y/bTrC1cylpp1Bk1fHAomc1UdS91eYzqaQ==
X-Google-Smtp-Source: AGHT+IFHMKuIQVarlhtKwz+xoLvYOSyPFewkqJdnbn6OLO4DkvruIpDMw3OKF2DH/8BoZ8vOxJoY1g==
X-Received: by 2002:a05:6402:60c:b0:52f:a318:d7a0 with SMTP id n12-20020a056402060c00b0052fa318d7a0mr9930405edv.26.1696265725659;
        Mon, 02 Oct 2023 09:55:25 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:c027:f1d4:d825:fbf4:9197:5c9f])
        by smtp.gmail.com with ESMTPSA id er15-20020a056402448f00b00533c844e337sm12762364edb.85.2023.10.02.09.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:55:25 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 0/9] Repack objects into separate packfiles based on a filter
Date:   Mon,  2 Oct 2023 18:54:55 +0200
Message-ID: <20231002165504.1325153-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.305.g5bfd918c90
In-Reply-To: <20230925152517.803579-1-christian.couder@gmail.com>
References: <20230925152517.803579-1-christian.couder@gmail.com>
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

# Use cases for the new feature

This could be useful for example for the following purposes:

  1) As a way for servers to save storage costs by for example moving
     large blobs, or all the blobs, or all the blobs in inactive
     repos, to separate storage (while still making them accessible
     using for example the alternates mechanism).

  2) As a way to use partial clone on a Git server to offload large
     blobs to, for example, an http server, while using multiple
     promisor remotes (to be able to access everything) on the client
     side. (In this case the packfile that contains the filtered out
     object can be manualy removed after checking that all the objects
     it contains are available through the promisor remote.)

  3) As a way for clients to reclaim some space when they cloned with
     a filter to save disk space but then fetched a lot of unwanted
     objects (for example when checking out old branches) and now want
     to remove these unwanted objects. (In this case they can first
     move the packfile that contains filtered out objects to a
     separate directory or storage, then check that everything works
     well, and then manually remove the packfile after some time.)

As the features and the code are quite different from those in the
previous series, I decided to start a new series instead of continuing
a previous one.

Also since version 2 of this new series, commit messages, don't
mention uses cases like 2) or 3) above, as people have different
opinions on how it should be done. How it should be done could depend
a lot on the way promisor remotes are used, the software and hardware
setups used, etc, so it seems more difficult to "sell" this series by
talking about such use cases. As use case 1) seems simpler and more
appealing, it makes more sense to only talk about it in the commit
messages.

# Changes since version 7

Thanks to Junio who reviewed or commented on nearly all the versions,
and to Taylor who reviewed or commented on version 1, 3, 4, 5 and 6!
Thanks also to Robert Coup who participated in the discussions related
to version 2 and Peff who participated in the discussions related to
version 4.

There are only the following changes since version 7:

- This series has been rebased on top of 493f462273 (The thirteenth
  batch, 2023-09-29) to avoid possible conflicts with other series
  that could potentially conflict with this one.

- Patch 2/9 (t/helper: add 'find-pack' test-tool) has been reworked to
  use the "t0081" test script number instead of "t0080" as the later
  is used by js/doc-unit-tests. I asked in:
  
  https://lore.kernel.org/git/CAP8UFD2YbYH5aZEG5NX8HLe9VeEQ+NhBfiZ9Mhy3UXTUrab3ug@mail.gmail.com/

  if someone thought another number was better, but got no answer.

I checked that CI tests passes in:

https://github.com/chriscool/git/actions/runs/6382343338

All jobs seem to have succeeded.

# Commit overview

(No changes in any of the patches compared to version 7, except on
patch 2/9.)

* 1/9 pack-objects: allow `--filter` without `--stdout`

  To be able to later repack with a filter we need `git pack-objects`
  to write packfiles when it's filtering instead of just writing the
  pack without the filtered out objects to stdout.

* 2/9 t/helper: add 'find-pack' test-tool

  For testing `git repack --filter=...` that we are going to
  implement, it's useful to have a test helper that can tell which
  packfiles contain a specific object. The only change compared to v7
  is the change in test script number.

* 3/9 repack: refactor finishing pack-objects command

  This is a small refactoring creating a new useful function, so that
  `git repack --filter=...` will be able to reuse it.

* 4/9 repack: refactor finding pack prefix

  This is another small refactoring creating a small function that
  will be reused in the next patch.

* 5/9 pack-bitmap-write: rebuild using new bitmap when remapping

  It fixes an issue when bitmaps are rebuilt that was revealed by this
  series, and caused a CI test to fail.

* 6/9 repack: add `--filter=<filter-spec>` option

  This actually adds the `--filter=<filter-spec>` option. It uses one
  `git pack-objects` process with the `--filter` option. And then
  another `git pack-objects` process with the `--stdin-packs`
  option.
  
* 7/9 gc: add `gc.repackFilter` config option

  This is a gc config option so that `git gc` can also repack using a
  filter and put the filtered out objects into a separate packfile.

* 8/9 repack: implement `--filter-to` for storing filtered out objects

  For some use cases, it's interesting to create the packfile that
  contains the filtered out objects into a separate location. This is
  similar to the `--expire-to` option for cruft packfiles.

* 9/9 gc: add `gc.repackFilterTo` config option

  This allows specifying the location of the packfile that contains
  the filtered out objects when using `gc.repackFilter`.

# Range-diff since v7

 1:  eec0c09731 =  1:  b23d216277 pack-objects: allow `--filter` without `--stdout`
 2:  19c8b8a4b9 !  2:  27e70ccf39 t/helper: add 'find-pack' test-tool
    @@ t/helper/test-tool.h: int cmd__dump_reftable(int argc, const char **argv);
      int cmd__genrandom(int argc, const char **argv);
      int cmd__genzeros(int argc, const char **argv);
     
    - ## t/t0080-find-pack.sh (new) ##
    + ## t/t0081-find-pack.sh (new) ##
     @@
     +#!/bin/sh
     +
 3:  aaaf40bd5d =  3:  7e692c4cfd repack: refactor finishing pack-objects command
 4:  1eb6bc3f7e =  4:  227159ed4e repack: refactor finding pack prefix
 5:  b9159e1803 =  5:  79786eb5e1 pack-bitmap-write: rebuild using new bitmap when remapping
 6:  f2f5bb54d3 =  6:  205d33850e repack: add `--filter=<filter-spec>` option
 7:  7ea0307628 =  7:  16b1621169 gc: add `gc.repackFilter` config option
 8:  698647815b =  8:  92a5ff7cc7 repack: implement `--filter-to` for storing filtered out objects
 9:  57b2ba444c =  9:  5bfd918c90 gc: add `gc.repackFilterTo` config option

Christian Couder (9):
  pack-objects: allow `--filter` without `--stdout`
  t/helper: add 'find-pack' test-tool
  repack: refactor finishing pack-objects command
  repack: refactor finding pack prefix
  pack-bitmap-write: rebuild using new bitmap when remapping
  repack: add `--filter=<filter-spec>` option
  gc: add `gc.repackFilter` config option
  repack: implement `--filter-to` for storing filtered out objects
  gc: add `gc.repackFilterTo` config option

 Documentation/config/gc.txt            |  16 ++
 Documentation/git-pack-objects.txt     |   4 +-
 Documentation/git-repack.txt           |  23 +++
 Makefile                               |   1 +
 builtin/gc.c                           |  10 ++
 builtin/pack-objects.c                 |   8 +-
 builtin/repack.c                       | 164 ++++++++++++++------
 pack-bitmap-write.c                    |   6 +-
 t/helper/test-find-pack.c              |  50 +++++++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/t0081-find-pack.sh                   |  82 ++++++++++
 t/t5317-pack-objects-filter-objects.sh |   8 +
 t/t6500-gc.sh                          |  24 +++
 t/t7700-repack.sh                      | 197 +++++++++++++++++++++++++
 15 files changed, 544 insertions(+), 51 deletions(-)
 create mode 100644 t/helper/test-find-pack.c
 create mode 100755 t/t0081-find-pack.sh

-- 
2.42.0.305.g5bfd918c90

