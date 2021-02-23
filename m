Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD834C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8257B64E6B
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 20:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhBWUPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 15:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbhBWUPM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 15:15:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8256BC06174A
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j187so138841wmj.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 12:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=1kIw6R65Mva4fFXQhNw9jlt+jmMt0dJ94ipOD1uq4Ac=;
        b=EirUNXlXvnNzUXv4kQvL5/YJzbxAHv667fd3Tr8q31FyttMedTALoW6etq2fKf8SP1
         sxuVNbUrIyH4VGeszXnZt9tkO9Aa/LX7YF2scz3B61noFC1gNVBQouUYYrraa1xctPIT
         FXx9dGaELSDrM31X51goGYyIZru3vnChZAT8OABz5LQ4y6hs2SpklIaYiZPoyZDq0oJ8
         XCJm9/2Su81YouJZ9W242UgZ5ukFtEWdEmMJQ3Ea+FcfnpGNoNsBEG0QatjmSO70SPsK
         HWYd2FuVhcYtRuyay8ULd3EF741VEZCQhy06EIHz8txrPDNXHx4xzWXIVgvYra2miQ5A
         Sycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1kIw6R65Mva4fFXQhNw9jlt+jmMt0dJ94ipOD1uq4Ac=;
        b=FA6iV+VBlES6RkOnlD82NwncM6DYl4X0s/ovDzzhK0G5YYYWOQG6P4znlrTGbFxO+g
         p+CjcoHikhsi0eHxicUlvIKmrFWcf6wCBhEa1YQc46KVRFzGxWIYg940v5QTfcXzVAgZ
         4E80Q0rAhc1rzrQ33RHm8Ah7noA3KU1KmEsD9vgbzsno7GmWbHEm1LghlmhfY8BQBgRM
         M6THseIsPci/1mAfJlezsqWZadTQtCKQ6VePtTI7AORDXOngEcQfS9CI/QZ876fAz4aO
         pv4tVvFvJvu4Vd6NiZaLdGaA9QPjdd+jyfIiWYGK7OfFYvm/emTsxiW6qSuNfl7YZrU+
         LuHg==
X-Gm-Message-State: AOAM532nsyn124Q8dGhJkDU1CGduYvX2m0pP5fM2DaXXLXHqjN1RFgSQ
        UdX81VA9z9vGiRQhYGi4Tcjt4cbZzts=
X-Google-Smtp-Source: ABdhPJzMiyl2ebEEtcQbO9gSJsB4XDnqSqfjl1IOvqQNOS/jyjkIttqg9L0TT/zex5xue8Ml19k5/g==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr450345wmg.66.1614111271321;
        Tue, 23 Feb 2021 12:14:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm3615350wmc.42.2021.02.23.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 12:14:30 -0800 (PST)
Message-Id: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Feb 2021 20:14:09 +0000
Subject: [PATCH 00/20] Sparse Index: Design, Format, Tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the first full patch series submission coming out of the
sparse-index RFC [1].

[1]
https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/

I won't waste too much space here, because PATCH 1 includes a sizeable
design document that describes the feature, the reasoning behind it, and my
plan for getting this implemented widely throughout the codebase.

There are some new things here that were not in the RFC:

 * Design doc and format updates. (Patch 1)
 * Performance test script. (Patches 2 and 20)

Notably missing in this series from the RFC:

 * The mega-patch inserting ensure_full_index() throughout the codebase.
   That will be a follow-up series to this one.
 * The integrations with git status and git add to demonstrate the improved
   performance. Those will also appear in their own series later.

I plan to keep my latest work in this area in my 'sparse-index/wip' branch
[2]. It includes all of the work from the RFC right now, updated with the
work from this series.

[2] https://github.com/derrickstolee/git/tree/sparse-index/wip

Thanks, -Stolee

Derrick Stolee (20):
  sparse-index: design doc and format update
  t/perf: add performance test for sparse operations
  t1092: clean up script quoting
  sparse-index: add guard to ensure full index
  sparse-index: implement ensure_full_index()
  t1092: compare sparse-checkout to sparse-index
  test-read-cache: print cache entries with --table
  test-tool: don't force full index
  unpack-trees: ensure full index
  sparse-checkout: hold pattern list in index
  sparse-index: convert from full to sparse
  submodule: sparse-index should not collapse links
  unpack-trees: allow sparse directories
  sparse-index: check index conversion happens
  sparse-index: create extension for compatibility
  sparse-checkout: toggle sparse index from builtin
  sparse-checkout: disable sparse-index
  cache-tree: integrate with sparse directory entries
  sparse-index: loose integration with cache_tree_verify()
  p2000: add sparse-index repos

 Documentation/config/extensions.txt      |   7 +
 Documentation/git-sparse-checkout.txt    |  14 ++
 Documentation/technical/index-format.txt |   7 +
 Documentation/technical/sparse-index.txt | 167 +++++++++++++
 Makefile                                 |   1 +
 builtin/sparse-checkout.c                |  44 +++-
 cache-tree.c                             |  40 ++++
 cache.h                                  |  12 +-
 read-cache.c                             |  35 ++-
 repo-settings.c                          |  15 ++
 repository.c                             |  11 +-
 repository.h                             |   3 +
 setup.c                                  |   3 +
 sparse-index.c                           | 290 +++++++++++++++++++++++
 sparse-index.h                           |  11 +
 t/README                                 |   3 +
 t/helper/test-read-cache.c               |  61 ++++-
 t/perf/p2000-sparse-operations.sh        | 104 ++++++++
 t/t1091-sparse-checkout-builtin.sh       |  13 +
 t/t1092-sparse-checkout-compatibility.sh | 136 +++++++++--
 unpack-trees.c                           |  16 +-
 21 files changed, 953 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/technical/sparse-index.txt
 create mode 100644 sparse-index.c
 create mode 100644 sparse-index.h
 create mode 100755 t/perf/p2000-sparse-operations.sh


base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-883%2Fderrickstolee%2Fsparse-index%2Fformat-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-883/derrickstolee/sparse-index/format-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/883
-- 
gitgitgadget
