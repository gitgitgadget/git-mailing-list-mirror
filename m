Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0C4C4332B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FB164F91
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhCPVR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 17:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhCPVRT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 17:17:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7DCC06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l11so11233198wrp.7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 14:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=vO8t16wk+mRD4MLPWErXVZBPVUAnIvlI95PQg3EvXnw=;
        b=t9ERxvYgo+LqbF8JbYyWoAyV653tgR6HcYCGqz1AQnMKOIwnQxKEqMclTAibE7olPx
         oaVUdGOv7kcO3gPu313KLewCSflTLZXntqM2WQaQ6qU5pW6uOrtCSie5Rcp5Z12C/raV
         wwnaikMkEbvX9JFaDubiZHrcAJ4EuNgEbLG/3wnM4UGVWyPJRz66cX2yvTom5P20nqj0
         uDl+FIdlFDR9Wnt9ecwACqnq+u9CtZWYSuD9e7EI0QrUBmumwqzxZ15w2JWekqMRB033
         2GaZQFU5Px0JLOQ6HXEg5/JgRRFQTmAX95WiJmZQvmN1DiVxEN426/IXdJhYxRCy2U84
         FoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vO8t16wk+mRD4MLPWErXVZBPVUAnIvlI95PQg3EvXnw=;
        b=UqUSqsgE8SQS/ola2XDRwLG5kEm9OGFaJjJlqkcB0c8cd6DjCVrFQoFtLelvryqSYh
         nrpmNqj8BYFRKdJ8EC5LRf6Yv7fUlOCTyhHo0a+lDJeNV6tjRfiAHy1JzaFTEnpEYwG5
         d053rDoDR12ZyuT+cKwlWfPE1fHOKJIPXgXzmO2YW+bTJ/pO8G+HHeReaWs8OBmhfWQV
         oXWtOmOAt5tSb7nhYzGLieHZ8tJYCM9ZAQ03zA1MvGatJfFKTwJ000cUrFo+wCVbPGXr
         Y/lS1R5BWw1PGrO7FkDWKwboEI1bujzOdw3pvD4HRrhagt9RHAPFl0//OOvCWhjYpBYZ
         tknQ==
X-Gm-Message-State: AOAM5331q/xp43uXy5cG4tIZYkt/kfv8ifzWRRYQHLe+EapI98qfcVlQ
        VEkiP+6nO5GCiBmVE/wcYDf1ZkGB83Q=
X-Google-Smtp-Source: ABdhPJyhRO/e2t6rsavj9ZsDiKab/52vT4h1URHP01PzVcyRcGV7Y9SrnPXsPhbSExizMW+oJZ8GxA==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr913116wrr.81.1615929437493;
        Tue, 16 Mar 2021 14:17:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a14sm385762wrn.5.2021.03.16.14.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 14:17:17 -0700 (PDT)
Message-Id: <pull.906.git.1615929435.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Mar 2021 21:16:48 +0000
Subject: [PATCH 00/27] Sparse Index: API protections
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the second patch series submission coming out of the sparse-index
RFC [1].

[1]
https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/

This is based on v3 of the format series [2].

[2]
https://lore.kernel.org/git/pull.883.v3.git.1615912983.gitgitgadget@gmail.com/

The point of this series is to insert protections for the consumers of the
in-memory index. We mark certain regions of code as needing a full index, so
we call ensure_full_index() to expand a sparse index to a full one, if
necessary. These protections are inserted file-by-file in every loop over
all cache entries. Well, "most" loops, because some are going to be handled
in the very next series so I leave them out.

Many callers use index_name_pos() to find a path by name. In these cases, we
can check if that position resolves to a sparse directory instance. In those
cases, we just expand to a full index and run the search again.

The last few patches deal with the name-hash hashtable for doing O(1)
lookups.

These protections don't do much right now, since the previous series created
the_repository->settings.command_requires_full_index to guard all index
reads and writes to ensure the in-memory copy is full for commands that have
not been tested with the sparse index yet.

However, after this series is complete, we now have a straight-forward plan
for making commands "sparse aware" one-by-one:

 1. Disable settings.command_requires_full_index to allow an in-memory
    sparse-index.
 2. Run versions of that command under a debugger, breaking on
    ensure_full_index().
 3. Examine the call stack to determine the context of that expansion, then
    implement the proper behavior in those locations.
 4. Add tests to ensure we are checking this logic in the presence of sparse
    directory entries.

I will admit that mostly it is the writing of the test cases that takes the
most time in the conversions I've done so far.

Thanks, -Stolee

Derrick Stolee (27):
  *: remove 'const' qualifier for struct index_state
  read-cache: expand on query into sparse-directory entry
  sparse-index: API protection strategy
  cache: move ensure_full_index() to cache.h
  add: ensure full index
  checkout-index: ensure full index
  checkout: ensure full index
  commit: ensure full index
  difftool: ensure full index
  fsck: ensure full index
  grep: ensure full index
  ls-files: ensure full index
  merge-index: ensure full index
  rm: ensure full index
  sparse-checkout: ensure full index
  update-index: ensure full index
  diff-lib: ensure full index
  dir: ensure full index
  entry: ensure full index
  merge-ort: ensure full index
  merge-recursive: ensure full index
  pathspec: ensure full index
  read-cache: ensure full index
  resolve-undo: ensure full index
  revision: ensure full index
  sparse-index: expand_to_path()
  name-hash: use expand_to_path()

 Documentation/technical/sparse-index.txt | 32 ++++++++++-
 attr.c                                   | 14 ++---
 attr.h                                   |  4 +-
 builtin/add.c                            |  1 +
 builtin/checkout-index.c                 |  1 +
 builtin/checkout.c                       |  2 +
 builtin/commit.c                         |  2 +
 builtin/difftool.c                       |  2 +
 builtin/fsck.c                           |  1 +
 builtin/grep.c                           |  1 +
 builtin/ls-files.c                       | 12 ++--
 builtin/merge-index.c                    |  3 +
 builtin/rm.c                             |  1 +
 builtin/stash.c                          |  1 +
 builtin/update-index.c                   |  1 +
 cache.h                                  |  7 ++-
 convert.c                                | 26 ++++-----
 convert.h                                | 20 +++----
 diff-lib.c                               |  1 +
 dir.c                                    | 13 +++--
 dir.h                                    |  8 +--
 entry.c                                  |  1 +
 merge-ort.c                              |  1 +
 merge-recursive.c                        |  3 +-
 name-hash.c                              | 10 ++++
 pathspec.c                               |  7 ++-
 pathspec.h                               |  6 +-
 read-cache.c                             | 33 +++++++++--
 resolve-undo.c                           |  2 +
 revision.c                               |  1 +
 sparse-index.c                           | 72 ++++++++++++++++++++++++
 sparse-index.h                           | 14 ++++-
 submodule.c                              |  6 +-
 submodule.h                              |  6 +-
 34 files changed, 243 insertions(+), 72 deletions(-)


base-commit: 3db06ac46dd5c61e83d7fc4747615d616fdbbdda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-906%2Fderrickstolee%2Fsparse-index%2Fprotections-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-906/derrickstolee/sparse-index/protections-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/906
-- 
gitgitgadget
