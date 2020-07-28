Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF05C433E1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09D820809
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 09:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxXB+ODT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgG1JN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 05:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgG1JNz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 05:13:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91751C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id d6so6069327ejr.5
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 02:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+bj2KRYW4tJCwSeADvw8mc8YeGiSacu1hZ+ecjrTVzk=;
        b=QxXB+ODTyvpnpp2fWfoJXL3ZbNY83rwJBCMHRTWVkTs4n6coXddhNp8oL1QAY5Z8DV
         7BWig38nlOWrLYi+L4UYXhurot6V1IJXMcvJ2WnJE2HSDLrxoe+EtznvP5iCdUihNLU0
         pVZzNlTfKXEiDe0AlqEzi/+qxlHv1CYd4EeqW5oxDAnLEVuNW18l8zG6+pB+dz9Q0Thr
         PUMP4Afxr+5wC/+wrNVF4tRWMv1J3uTNm30CKURouXm1MRplhHuIvyKcJWHCuSs2bdGK
         ynYVSUdzGKM7C48/OVzOIQnEeUzIygvYeytYQUC79DiBDCEiOiCULANPZVf60+/4R8Am
         VnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+bj2KRYW4tJCwSeADvw8mc8YeGiSacu1hZ+ecjrTVzk=;
        b=SLXERtMt+PDMArCLmILuTZAGMniC1MR1iBxSkElOu3t38/28+F+Kz2+dKrkgt6TJSS
         /wbpfmQK2+hR7bob2Puuo2tpLDGKq+t0lB4Ww5pwaQKBBYDfOj8dHUQBote1kLa1RPWn
         hs4VhkeMP7kXtsbW+XYBrW4ZV4G84FDKJXMRtVRDW8VsvYUtT5s7OgtQuAjjM5ShMUCO
         KvPGW8glF75ya1lahLWGd5BM5JIW3aK8ImbetcOY/lzx7g4gT7lZkYC1deOBx5cx+WtH
         uO80pviKOqprqpFj726KwybYvT439SzjKLJIDcRpOJz8LMi7bVBW1IfBDNJzYEEtRdcX
         2Bgg==
X-Gm-Message-State: AOAM531ROAis8p0oWkxM4+VH50pUN5+M+sznuj9qyy1TgUJFlsv/JHou
        AwPFiAxvLHHAzcVFMCCaUm25rB56
X-Google-Smtp-Source: ABdhPJwbrpMualQXOiXo2Fnqqnu5LJzpLXXq2Gxh0Ko/HnknBYlsWYdxXF2C1W6jkmoh4+9tTv1aDA==
X-Received: by 2002:a17:906:8316:: with SMTP id j22mr5231274ejx.20.1595927633942;
        Tue, 28 Jul 2020 02:13:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm9403616edk.36.2020.07.28.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 02:13:53 -0700 (PDT)
Message-Id: <pull.676.git.1595927632.gitgitgadget@gmail.com>
From:   "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jul 2020 09:13:45 +0000
Subject: [PATCH 0/6] [GSoC] Implement Corrected Commit Date
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series implements the corrected commit date offsets as generation
number v2, along with other pre-requisites.

Git uses topological levels in the commit-graph file for commit-graph
traversal operations like git log --graph. Unfortunately, using topological
levels can result in a worse performance than without them when compared
with committer date as a heuristics. For example, git merge-base v4.8 v4.9 
on the Linux repository walks 635,579 commits using topological levels and
walks 167,468 using committer date.

Thus, the need for generation number v2 was born. New generation number
needed to provide good performance, increment updates, and backward
compatibility. Due to an unfortunate problem, we also needed a way to
distinguish between the old and new generation number without incrementing
graph version.

Various candidates were examined (https://github.com/derrickstolee/gen-test, 
https://github.com/abhishekkumar2718/git/pull/1). The proposed generation
number v2, Corrected Commit Date with Mononotically Increasing Offsets 
performed much worse than committer date (506,577 vs. 167,468 commits walked
for git merge-base v4.8 v4.9) and was dropped.

Using Generation Data chunk (GDAT) relieves the requirement of backward
compatibility as we would continue to store topological levels in Commit
Data (CDAT) chunk. Thus, Corrected Commit Date was chosen as generation
number v2. The Corrected Commit Date is defined as:

For a commit C, let its corrected commit date be the maximum of the commit
date of C and the corrected commit dates of its parents. Then corrected
commit date offset is the difference between corrected commit date of C and
commit date of C.

We will introduce an additional commit-graph chunk, Generation Data chunk,
and store corrected commit date offsets in GDAT chunk while storing
topological levels in CDAT chunk. The old versions of Git would ignore GDAT
chunk, using topological levels from CDAT chunk. In contrast, new versions
of Git would use corrected commit dates, falling back to topological level
if the generation data chunk is absent in the commit-graph file.

Here's what left for the PR (which I intend to take on with the second
version of pull request):

 1. Add an option to skip writing generation data chunk (to test whether new
    Git works without GDAT as intended).
 2. Handle writing to commit-graph for mismatched version (that is, merging
    all graphs into a new graph with a GDAT chunk).
 3. Update technical documentation.

I look forward to everyone's reviews!

Thanks

 * Abhishek


----------------------------------------------------------------------------

The build fails for t9807-git-p4-submit.sh on osx-clang, which I feel is
unrelated to my code changes. Still need to investigate further.

Abhishek Kumar (6):
  commit-graph: fix regression when computing bloom filter
  revision: parse parent in indegree_walk_step()
  commit-graph: consolidate fill_commit_graph_info
  commit-graph: consolidate compare_commits_by_gen
  commit-graph: implement generation data chunk
  commit-graph: implement corrected commit date offset

 blame.c                       |   2 +-
 commit-graph.c                | 181 +++++++++++++++++++++-------------
 commit-graph.h                |   7 +-
 commit-reach.c                |  47 +++------
 commit-reach.h                |   2 +-
 commit.c                      |   9 +-
 commit.h                      |   3 +
 revision.c                    |  17 ++--
 t/helper/test-read-graph.c    |   2 +
 t/t4216-log-bloom.sh          |   4 +-
 t/t5000-tar-tree.sh           |   4 +-
 t/t5318-commit-graph.sh       |  21 ++--
 t/t5324-split-commit-graph.sh |  12 +--
 upload-pack.c                 |   2 +-
 14 files changed, 178 insertions(+), 135 deletions(-)


base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-676%2Fabhishekkumar2718%2Fcorrected_commit_date-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-676/abhishekkumar2718/corrected_commit_date-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/676
-- 
gitgitgadget
