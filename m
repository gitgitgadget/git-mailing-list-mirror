Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4955C6FD1F
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjCFOHb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 09:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCFOHM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 09:07:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545A12595E
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 06:06:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bw19so8906393wrb.13
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 06:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678111600;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5VKfQXI/1hIMEzU+Nwf5TkhR6+/nFVIOvZRJWOj5nBo=;
        b=KtjannxOL43N0FVtk111NJEjnJ3Knkp6w70tyc6LTGh9kNzWsJRrI3JOMnd7OCI7A7
         +R/h596lAZ+6NmvsW2fOcBfyWMSNvYLCU8z5uIeI0SC9NGOCD2OlZ0BIgEUrC+LDna4J
         iVhSY4HyKCiOyaCwCmcc4IvKlQ0tvf4Jq3ibE7xi0FG+72RH1dCzb5l9TvQfCYtaZaT8
         ALE8dVPRPBF+5HMv9qy/Fp84OL8V8JikyjwVEP3VsHydwO1LBrdK98NZ3dBWQVMVNL/R
         MlRea3VwMWLuSMAP0aXpgmHoyWWXj0xC/j9stnYMrqQJySElzyUoCcPmWYXqEvF30k7v
         cZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678111600;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VKfQXI/1hIMEzU+Nwf5TkhR6+/nFVIOvZRJWOj5nBo=;
        b=gyXRHl/lwlAlSWRRLhce3IXajwYjilrHhhSrocgBFTofCBywnT9BvRa0+5PM0c+ujg
         QRBN4b+MKe2/GSP5MYNTrlSdxE/lH9vR2iDY92asfYzWBkqr62jcDy4s4pf6FFl99h/u
         ZuXxll2V3ZBXPGK+Bn6lwjnEoXCKNu6aNqBwQK64KGloUVz0r/jin8jBbDztCm7d+j9t
         IcUx32CWk0uhlTBPFdw9ytcrbyDQdG3qslvhjrQRmiLzkpSw97+C8hODkRhI+8GjM++d
         4rSwZJEZPAmpk+EjgPR2JSybdSbIStMmB5EhXvG7hLBurWGC+57i4/06xsZGbpl0s777
         a3XQ==
X-Gm-Message-State: AO0yUKWBoZEXjG24kYKo+meO0unI7ZJ+uMnmkFceaLFUtevQVidNFc6l
        SQ08j8uhp+mEuk5UaczsgAzBJpV0aZM=
X-Google-Smtp-Source: AK7set81c9gKVWBaPxv0ialQrEtxGyObXmYOqiHKEy1PRQHlv+BfZAXxUGOOoG2HUHQxHTzN3ZZ9mQ==
X-Received: by 2002:a05:6000:11c8:b0:2cb:a82c:2523 with SMTP id i8-20020a05600011c800b002cba82c2523mr8647784wrx.35.1678111599938;
        Mon, 06 Mar 2023 06:06:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17-20020a5d4ed1000000b002c5584d0e3dsm9774659wrv.24.2023.03.06.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 06:06:39 -0800 (PST)
Message-Id: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Mar 2023 14:06:30 +0000
Subject: [PATCH 0/8] ahead-behind: new builtin for counting multiple commit ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series introduces the 'git ahead-behind' builtin, which has been used
at $DAYJOB for many years, but took many forms before landing on the current
version.

The main goal of the builtin is to compare multiple references against a
common base reference. The comparison is number of commits that are in each
side of the symmtric difference of their reachable sets. A commit C is
"ahead" of a commit B by the number of commits in B..C (reachable from C but
not reachable from B). Similarly, the commit C is "behind" the commit B by
the number of commits in C..B (reachable from B but not reachable from C).

These numbers can be computed by 'git rev-list --count B..C' and 'git
rev-list --count C..B', but there are common needs that benefit from having
the checks being done in the same process:

 1. Our "branches" page lists ahead/behind counts for each listed branch as
    compared to the repo's default branch. This can be done with a single
    'git ahead-behind' process.
 2. When a branch is updated, a background job checks if any pull requests
    that target that branch should be closed because their branches were
    merged implicitly by that update. These queries can e batched into 'git
    ahead-behind' calls.

In that second example, we don't need the full ahead/behind counts (although
it is sufficient to look for branches that are "zero commits ahead", meaning
they are reachable from the base), so this builtin has an extra '--contains'
mode that only checks reachability from the base to each of the tips. 'git
ahead-behind --contains' is sort of the reverse of 'git branch --contains'.

The series starts with some basic boilerplate and argument parsing, along
with error conditions for missing objects. To avoid TOCTOU races, an
'--ignore-missing' option allows being flexible when a tip reference does
not exist. This is all covered in patches 1-3.

Patches 4-6 introduce a new method: ensure_generations_valid(). Patch 4 does
some refactoring of the existing generation number computations to make it
more generic, and patch 5 updates the definition of
commit_graph_generation() slightly, making way for patch 6 to implement the
method. With an existing commit-graph file, the commits that are not present
in the file are considered as having generation number "infinity". This is
useful for most of our reachability queries to this point, since those
commits are "above" the ones tracked by the commit-graph. When these commits
are low in number, then there is very little performance cost and zero
correctness cost.

However, we will see that the ahead/behind computation requires accurate
generation numbers to avoid overcounting. Thus, ensure_generations_valid()
is a way to specify a list of commits that need generation numbers computed
before continuing. It's a no-op if all of those commits are in the
commit-graph file. It's expensive if the commit-graph doesn't exist.
However, 'git ahead-behind' computations are likely to be slow no matter
what without a commit-graph, so assuming an existing commit-graph file is
reasonable. If we find sufficient desire to have an implementation that does
not have this requirement, we could create a second implementation and
toggle to it when generation_numbers_enabled() returns false.

Patch 7 implements the ahead-behind algorithm, as well as integrating the
builtin with that implementation. It's a long commit message, so hopefully
it explains the algorithm sufficiently.

Patch 8 implements the --contains option, which is another algorithm, but
more similar to other depth-first searches that already exist in
commit-reach.c.

Thanks, -Stolee

Derrick Stolee (7):
  ahead-behind: create empty builtin
  ahead-behind: parse tip references
  ahead-behind: implement --ignore-missing option
  commit-graph: combine generation computations
  commit-graph: return generation from memory
  ahead-behind: implement ahead_behind() logic
  ahead-behind: add --contains mode

Taylor Blau (1):
  commit-graph: introduce `ensure_generations_valid()`

 .gitignore                         |   1 +
 Documentation/git-ahead-behind.txt |  78 +++++++++++
 Makefile                           |   1 +
 builtin.h                          |   1 +
 builtin/ahead-behind.c             | 121 +++++++++++++++++
 commit-graph.c                     | 209 +++++++++++++++++++----------
 commit-graph.h                     |   7 +
 commit-reach.c                     | 205 ++++++++++++++++++++++++++++
 commit-reach.h                     |  37 +++++
 git.c                              |   1 +
 t/perf/p1500-graph-walks.sh        |  29 ++++
 t/t4218-ahead-behind.sh            | 162 ++++++++++++++++++++++
 t/t5318-commit-graph.sh            |   2 +-
 t/t6600-test-reach.sh              | 120 +++++++++++++++++
 14 files changed, 904 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/git-ahead-behind.txt
 create mode 100644 builtin/ahead-behind.c
 create mode 100755 t/perf/p1500-graph-walks.sh
 create mode 100755 t/t4218-ahead-behind.sh


base-commit: d15644fe0226af7ffc874572d968598564a230dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1489%2Fderrickstolee%2Fstolee%2Fupstream-ahead-behind-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1489/derrickstolee/stolee/upstream-ahead-behind-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1489
-- 
gitgitgadget
