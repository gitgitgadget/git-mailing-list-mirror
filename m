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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A20EC433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123662220B
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 16:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404247AbhAZQCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390121AbhAZQCK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 11:02:10 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD9EC0611BD
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id e15so3257389wme.0
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 08:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2uqOeMw484Kd0Yn24SikwOCergiJTHmFaHOgOiCeKk8=;
        b=JNEhtP5ORZ+A3jgEpo8PgmIAyJhzci30GKKkQIj0WI1VcyDFfiEIQIA8CJ/wwK37O0
         iwjw6TOonjRVWw5iLHwq762/lbJrFPdEOTbQmFwlaCybWvtUk4gWrAShZiLmpVuCVw9i
         P3NFqpwQv68tF6D9the0UyWZ9Qd/QhImpfDt+K3iko5IrB818iX/v5M4pGfYby3spsFL
         DjZ1jRgsFNq7k2wCpWkaJhVSc0kyr1/2THMYtYzsIfhv0G0KeJsPDr4x4PHXOv+R4ud3
         36FJ/NZ2hyiVeXD7BeBWwXcgbQVywf2hnxcHR2qIC8vW0j57r1/v/uQF+OUGBrUo5NxB
         nWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2uqOeMw484Kd0Yn24SikwOCergiJTHmFaHOgOiCeKk8=;
        b=IiiQtQsyr4F8vx5yKDXrIHJ+qT1/XrkrnC7j9H2LOnmj0o5lJGwszJZueSNamxlpHE
         Dt+vvs5DkUF+9bo/L+OGuL9JBOl8tgi3JZIgDUZpr+7fPdE0ipA0SnF8BjD8LQ5GNxoO
         HLlWHRilMCHw7MPtZiyyoAShm9XSJlksAbWEl/XOwkeCkes1iLD3sLUkreEjQzMpYFFL
         CfqB8EXV399pkquIThcAeag6iNllBLEjuYSl3njAW9pIQVdOJ/chEvKFCPkxxnnpJRv5
         YCyIFc28MJt78caTO6elZ7EXznZkf8JQG/M4cGoChDBlJWx142oLGrAP6tfTQk4Vhcff
         B2NQ==
X-Gm-Message-State: AOAM532LlxwAryYrX7StzaYbc8gHhtNycHVKtw06zs0BpfYI/rK5hC11
        H5Kycoj/nBZzLh2hTDdLir87YkVOKU8=
X-Google-Smtp-Source: ABdhPJyITTWQ0li0cM9Rj1rsPhuC4k2sRJKpKfdUTGYZpv/ISJb0EIP1eiX7s8LdfUCtTEVYGoU+vw==
X-Received: by 2002:a1c:3d56:: with SMTP id k83mr373158wma.25.1611676888082;
        Tue, 26 Jan 2021 08:01:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q63sm4082496wma.43.2021.01.26.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:01:27 -0800 (PST)
Message-Id: <pull.848.git.1611676886.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Jan 2021 16:01:09 +0000
Subject: [PATCH 00/17] Refactor chunk-format into an API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com, l.s.r@web.de,
        szeder.dev@gmail.com, Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a restart on the topic previously submitted [1] but dropped because
ak/corrected-commit-date was still in progress. This version is based on
that branch.

[1]
https://lore.kernel.org/git/pull.804.git.1607012215.gitgitgadget@gmail.com/

This version also changes the approach to use a more dynamic interaction
with a struct chunkfile pointer. This idea is credited to Taylor Blau [2],
but I started again from scratch. I also go further to make struct chunkfile
anonymous to API consumers. It is defined only in chunk-format.c, which
should hopefully deter future users from interacting with that data
directly.

[2] https://lore.kernel.org/git/X8%2FI%2FRzXZksio+ri@nand.local/

This combined API is beneficial to reduce duplicated logic. Or rather, to
ensure that similar file formats have similar protections against bad data.
The multi-pack-index code did not have as many guards as the commit-graph
code did, but now they both share a common base that checks for things like
duplicate chunks or offsets outside the size of the file.

Here are some stats for the end-to-end change:

 * 638 insertions(+), 456 deletions(-).
 * commit-graph.c: 171 insertions(+), 192 deletions(-)
 * midx.c: 196 insertions(+), 260 deletions(-)

While there is an overall increase to the code size, the consumers do get a
bit smaller. Boilerplate things like abstracting method to match
chunk_write_fn and chunk_read_fn make up a lot of these insertions. The
"interesting" code gets a lot smaller and cleaner.

Thanks, -Stolee

Derrick Stolee (17):
  commit-graph: anonymize data in chunk_write_fn
  chunk-format: create chunk format write API
  commit-graph: use chunk-format write API
  midx: rename pack_info to write_midx_context
  midx: use context in write_midx_pack_names()
  midx: add entries to write_midx_context
  midx: add pack_perm to write_midx_context
  midx: add num_large_offsets to write_midx_context
  midx: return success/failure in chunk write methods
  midx: drop chunk progress during write
  midx: use chunk-format API in write_midx_internal()
  chunk-format: create read chunk API
  commit-graph: use chunk-format read API
  midx: use chunk-format read API
  midx: use 64-bit multiplication for chunk sizes
  chunk-format: restore duplicate chunk checks
  chunk-format: add technical docs

 Documentation/technical/chunk-format.txt      |  54 +++
 .../technical/commit-graph-format.txt         |   3 +
 Documentation/technical/pack-format.txt       |   3 +
 Makefile                                      |   1 +
 chunk-format.c                                | 165 +++++++
 chunk-format.h                                |  41 ++
 commit-graph.c                                | 363 +++++++-------
 midx.c                                        | 456 ++++++++----------
 t/t5318-commit-graph.sh                       |   2 +-
 t/t5319-multi-pack-index.sh                   |   6 +-
 10 files changed, 638 insertions(+), 456 deletions(-)
 create mode 100644 Documentation/technical/chunk-format.txt
 create mode 100644 chunk-format.c
 create mode 100644 chunk-format.h


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-848%2Fderrickstolee%2Fchunk-format%2Frefactor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-848/derrickstolee/chunk-format/refactor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/848
-- 
gitgitgadget
