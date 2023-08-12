Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB2EC001B0
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 00:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjHLAAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 20:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjHLAAf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 20:00:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A4E171F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bdc8081147so2308765ad.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691798433; x=1692403233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsnMIYHKRZvK3rY/PvaxbUD5LvlSB/MZGdW/ZnyawnI=;
        b=GpodgeHUIsTF10KIVpDV+mzshMYUO6uRF9mIurZuHIRbDyBcr/4mzZmYXN9budZ7mP
         bsWY/2vDlZbMsazpGOjSRjaBYMII0R0WWKFUlirCVK7N9MBzsa8+Grs30yNAQilylNPV
         1uXUE1Zhl/eN7ff03gQ9k+6u+TMtTmCIuPKG9BOnP8RrdE63aJv8hwRCGACxi1iQfF8O
         pzEuvRuLzODZocrruMKwYZKoXzbERWdMOCJuh8fc88AQfBiGZe13RNZNr852N8LDlQT9
         5J4lhBioQe2Hw1ZBNXCEytiqlisKOno0sWZxrW2LNH0FPCL97LUcr0GKcTgohL7CYLXL
         5eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691798433; x=1692403233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsnMIYHKRZvK3rY/PvaxbUD5LvlSB/MZGdW/ZnyawnI=;
        b=OqBYhW9dcCvikJzJZoAUUd04ExD57TjuUmc/3vEXwldMJd7b+4FM1rlhyfRsLSbeyk
         I2XcZtBZft/6G9atZB8wfk3TyFR8XUf/6T3qLzf3g9b1h4rO774jOaV0/xHNpRWPEE8R
         gYyDU+1X7SShwBY4Z68TpnM2xEAgRC69eYXY6NMiAD4eC0Avi6Lz+hVP8UXl87truZ+7
         n1v837WwkNaj97boO8tzf3QKeHvV8eLI2w+QjSJKah3G9lZP5TUfSy9tm9EepHGAsRqr
         PVc7ouwSPlR8h5J79G/zfbQw0y1DA19AXjx2JtpZ+LSlSPG0aGWoYIgYtH/UD2yaQqRD
         nv7A==
X-Gm-Message-State: AOJu0Yz0KAh1+inGdFsehHJQtjBuzgHqukRN0gHjP4wpqOHq87sfecSi
        U/ct6P+P3pOr/L2xaqpUh1DJLLm6Q8kFCA==
X-Google-Smtp-Source: AGHT+IHz6wNZMLR/9Lm6XVX27uBgUqXPhygw9TRTHO++dZwy0f++5QLSNLgp7CoT3FaDoZxiazQZtg==
X-Received: by 2002:a17:902:daca:b0:1b8:8702:1e7c with SMTP id q10-20020a170902daca00b001b887021e7cmr8912509plx.33.1691798432959;
        Fri, 11 Aug 2023 17:00:32 -0700 (PDT)
Received: from christian-Precision-5550.. ([129.126.215.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709028f8500b001b8a7e1b116sm4478308plo.191.2023.08.11.17.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:00:32 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 0/8] Repack objects into separate packfiles based on a filter
Date:   Sat, 12 Aug 2023 02:00:03 +0200
Message-ID: <20230812000011.1227371-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc1.8.ga52e3a71db
In-Reply-To: <20230808082608.582319-1-christian.couder@gmail.com>
References: <20230808082608.582319-1-christian.couder@gmail.com>
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

# Changes since version 4

Thanks to Junio who reviewed versions 1, 2, 3 and 4, and to Taylor who
reviewed version 1, 3 and 4! Thanks also to Robert Coup who
participated in the discussions related to version 2 and Peff who
participated in the discussions related to version 4. The changes are
the following:

- In patch 2/8, which introduces `test-tool find-pack`, a spurious
  space character has been removed between 'die' and '(', as suggested
  by Taylor.

- In patch 4/8, which refactors code into a find_pack_prefix()
  function, this function has been changed so that the `packdir` and
  `packtmp` arguments are now 'const', as suggested by Taylor.

- In patch 5/8, which introduces `--filter=<filter-spec>` option, the
  `filter_options` member of the 'cruft_po_args' variable is not
  initialized and freed anymore, as this member is actually unused.

- Also in patch 5/8, the '--filter fails with --write-bitmap-index'
  test has been changed to use `test_must_fail env` to fix failures
  with the 'test-lint' Makefile target, as suggested by Junio and
  Taylor. (Junio's 'SQUASH???' patch was squashed into that patch.)

- Also the series was rebased on top of v2.42.0-rc1 as it will likely
  be merged after v2.42.0 will be released and Junio's
  cc/repack-sift-filtered-objects-to-separate-pack branch is based on
  top of v2.42.0-rc0.

# Commit overview

* 1/8 pack-objects: allow `--filter` without `--stdout`

  This patch is the same as in v1, v2, v3 and v4. To be able to later
  repack with a filter we need `git pack-objects` to write packfiles
  when it's filtering instead of just writing the pack without the
  filtered out objects to stdout.

* 2/8 t/helper: add 'find-pack' test-tool

  For testing `git repack --filter=...` that we are going to
  implement, it's useful to have a test helper that can tell which
  packfiles contain a specific object. Since v4 only a space character
  has been removed between a function name and the following '(' to
  comply with our style guide.

* 3/8 repack: refactor finishing pack-objects command

  No change in this patch compared to v2, v3 and v4. This is a small
  refactoring creating a new useful function, so that `git repack
  --filter=...` will be able to reuse it.

* 4/8 repack: refactor finding pack prefix

  This is another small refactoring creating a small function that
  will be reused in the next patch. Since v4 the new function has been
  changed so that its `packdir` and `packtmp` argument are now const.

* 5/8 repack: add `--filter=<filter-spec>` option

  This actually adds the `--filter=<filter-spec>` option. It uses one
  `git pack-objects` process with the `--filter` option. And then
  another `git pack-objects` process with the `--stdin-packs`
  option. A few changes have been made since v4:

    - The `filter_options` member of the 'cruft_po_args' variable is
      not initialized and freed anymore, as this member is actually
      unused.

    - The test that checks that `--filter=...` fails with
      `--write-bitmap-index` has been changed to use `test_must_fail
      env` to fix failures with the 'test-lint' Makefile target.

* 6/8 gc: add `gc.repackFilter` config option

  No change in this patch compared to v4. This is a gc config option
  so that `git gc` can also repack using a filter and put the filtered
  out objects into a separate packfile.

* 7/8 repack: implement `--filter-to` for storing filtered out objects

  No change in this patch compared to v4. For some use cases, it's
  interesting to create the packfile that contains the filtered out
  objects into a separate location. This is similar to the
  `--expire-to` option for cruft packfiles.

* 8/8 gc: add `gc.repackFilterTo` config option

  No change in this patch compared to v3 and v4. This allows
  specifying the location of the packfile that contains the filtered
  out objects when using `gc.repackFilter`.

# Range-diff since v4

1:  09fd23c7d0 = 1:  bbcc368876 pack-objects: allow `--filter` without `--stdout`
2:  c75010d20c ! 2:  f1b80e5728 t/helper: add 'find-pack' test-tool
    @@ t/helper/test-find-pack.c (new)
     +          }
     +
     +  if (count > -1 && count != actual_count)
    -+          die ("bad packfile count %d instead of %d", actual_count, count);
    ++          die("bad packfile count %d instead of %d", actual_count, count);
     +
     +  return 0;
     +}
3:  28221861a0 = 3:  ffecc73960 repack: refactor finishing pack-objects command
4:  41d4faf62b ! 4:  6c2f381a88 repack: refactor finding pack prefix
    @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *ar
        return finish_pack_objects_cmd(&cmd, names, local);
      }
      
    -+static const char *find_pack_prefix(char *packdir, char *packtmp)
    ++static const char *find_pack_prefix(const char *packdir, const char *packtmp)
     +{
     +  const char *pack_prefix;
     +  if (!skip_prefix(packtmp, packdir, &pack_prefix))
5:  a929572b96 ! 5:  134700c2ce repack: add `--filter=<filter-spec>` option
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
        };
      
     +  list_objects_filter_init(&po_args.filter_options);
    -+  list_objects_filter_init(&cruft_po_args.filter_options);
     +
        git_config(repack_config, &cruft_po_args);
      
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
        string_list_clear(&existing_kept_packs, 0);
        clear_pack_geometry(geometry);
     +  list_objects_filter_release(&po_args.filter_options);
    -+  list_objects_filter_release(&cruft_po_args.filter_options);
      
        return ret;
      }
    @@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavaila
     +'
     +
     +test_expect_success '--filter fails with --write-bitmap-index' '
    -+  GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 test_must_fail git -C bare.git repack \
    -+          -a -d --write-bitmap-index --filter=blob:none
    ++  test_must_fail \
    ++          env GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 \
    ++          git -C bare.git repack -a -d --write-bitmap-index --filter=blob:none
     +'
     +
     +test_expect_success 'repacking with two filters works' '
6:  a22a560d74 = 6:  d3365c7b48 gc: add `gc.repackFilter` config option
7:  387b427fed = 7:  9a09382cd1 repack: implement `--filter-to` for storing filtered out objects
8:  76fac86b0e = 8:  a52e3a71db gc: add `gc.repackFilterTo` config option


Christian Couder (8):
  pack-objects: allow `--filter` without `--stdout`
  t/helper: add 'find-pack' test-tool
  repack: refactor finishing pack-objects command
  repack: refactor finding pack prefix
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
 builtin/repack.c                       | 167 +++++++++++++++------
 t/helper/test-find-pack.c              |  50 +++++++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/t0080-find-pack.sh                   |  82 ++++++++++
 t/t5317-pack-objects-filter-objects.sh |   8 +
 t/t6500-gc.sh                          |  24 +++
 t/t7700-repack.sh                      | 197 +++++++++++++++++++++++++
 14 files changed, 542 insertions(+), 50 deletions(-)
 create mode 100644 t/helper/test-find-pack.c
 create mode 100755 t/t0080-find-pack.sh

-- 
2.42.0.rc1.8.ga52e3a71db

