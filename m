Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4DBC3815B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CE221BE5
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 20:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgykxkaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbgDPUTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 16:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730136AbgDPUTs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 16:19:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB253C0610D5
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 13:14:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id j20so9697494edj.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BgAzKgI0+9uiCyb4a+W+vGavShHUELOILnN9iZp+c5M=;
        b=PgykxkaYijXO8Cj1cu9wAV3s7RLaSpAH8HOFkSQ3K0JKHeRWjcBrrWFEDM4Y8v1LLK
         uXeZtyMdCNHFiO91AIkNHEGMQjnUekHYztAoS44TWyJkzs9ewtTyJbN0jc0dXfjyBYM+
         8RhGhoQVKQmzh5v+Ek8A1eqBgwSqZSAYK2gNaJ8OUDox1BIB+Z90dMRnUpgsNd7p/aJj
         FFvU3FMDlEFJk70+zDkByTNtiR8JqDntow3JOZvW84YWqwc25n2JWLhuTyi4M1WTWQax
         qoF12VdKY+Lmm8v2mwlc0Derk2mziwo8K39KqR5on8Iz2o8OsPe3k+URtSGDrjwny13c
         ZOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BgAzKgI0+9uiCyb4a+W+vGavShHUELOILnN9iZp+c5M=;
        b=Rrc82E42mACPNKII6zWOYBeKv4gdsv3MZzZ52jO3tM8nzO30e2zf/KAS+EWYElKzdT
         0o9/hn0NnP+2pius+v5Pr1erUpG1XM4i0anEsxwTFF+o6NyZxnVFcjaqaa3U/NOffYUa
         ilXcpIo0s3m8fA2mDjzgdcGk9o919HbgL6Qrsh6Am1NxZ6HOjWG8fRTxG7+SfO+Map42
         1KM9t2Rx1xt+R8CbX2iuzyOzFnJd0knysTaarW9G4Khn1QrQLmKCmaJyhbeaDwQ3o3/n
         6c42BvTZ6UgIglqxAkKS47zqFo40/ZV6fri8qJR1s+rzj3Y7YuJju+p+vStM2eZ0wNyW
         hGfw==
X-Gm-Message-State: AGi0PuYeDhkyOyD8XSNNRUIxVyLvitMq3kTq5oWilUWSS+tDtomeBSQu
        CgOtnZ9URZxTe2FOmYoLEYQLwI/q
X-Google-Smtp-Source: APiQypI9wZHGyyyECZgKHAaMsoij1TS9riKs1GNC4zHqMkBD2rnUynzM/Z4BywqiC7QCKhDX453inQ==
X-Received: by 2002:a05:6402:1246:: with SMTP id l6mr21852074edw.186.1587068045332;
        Thu, 16 Apr 2020 13:14:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o33sm2661900eda.30.2020.04.16.13.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 13:14:04 -0700 (PDT)
Message-Id: <pull.609.v3.git.1587068044.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
References: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Apr 2020 20:14:01 +0000
Subject: [PATCH v3 0/3] Integrate changed-path Bloom filters with 'git blame'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the changed-path Bloom filters are relatively stable, then I propose
trying to build upon them as a way to discover any deficiencies. Also, it's
good to use them when we can.

The goal I set out to achieve was to use Bloom filters as much as possible
in git blame. I think I have achieved most of that, except I did not
integrate it with the -C mode. In that case, the blob-diff computation takes
a majority of the computation time, so short-circuiting the tree diff using
Bloom filters. Also, it's just really complicated. If someone else thinks
there is an easy win there, then please go ahead and give it a try with the
extra logic presented here in PATCH 3.

While I was playing around with Bloom filters and git blame, I purposefully
got it working with some scenarios but not all. Then I tried to trigger a
failing build in the blame tests using GIT_TEST_COMMIT_GRAPH=1 and 
GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1. But the tests all succeeded!

Examining the data, I see that the commit-graph didn't have the Bloom filter
chunks at all. This is because we are not setting the flag to write them in
the right spot. The GIT_TEST_COMMIT_GRAPH=1 variable triggers a commit-graph
write during git commit, so we need to update the code there instead of just
inspecting the variable in git commit-graph write. (This is PATCH 2.)

By updating this variable, I saw some test failures in other tests regarding
non-exact pathspecs. I fixed these in PATCH 1 so we keep clean builds.

I based this change on [1] but it would apply cleanly (and logically) on
gs/commit-graph-path-filter

Updates in v2:

 * Added PATCH 3 to write commit-graph files during 'git merge' if
   GIT_TEST_COMMIT_GRAPH is enabled.
   
   
 * Updated PATCH 1 with the simplification recommended by Taylor.
   
   
 * Fixed the lower-case "bloom" in the commit message.
   
   

Thanks, -Stolee

[1] 
https://lore.kernel.org/git/pull.601.v2.git.1586437211842.gitgitgadget@gmail.com/

Derrick Stolee (3):
  revision: complicated pathspecs disable filters
  tests: write commit-graph with Bloom filters
  blame: use changed-path Bloom filters

 blame.c          | 139 ++++++++++++++++++++++++++++++++++++++++++++---
 blame.h          |   6 ++
 builtin/blame.c  |  10 ++++
 builtin/commit.c |   4 +-
 builtin/merge.c  |   7 ++-
 commit-graph.c   |  14 +++++
 commit-graph.h   |   9 +++
 revision.c       |  19 ++++++-
 8 files changed, 193 insertions(+), 15 deletions(-)


base-commit: f4df00a0dd448edce0e854a97f63598fefe27d27
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-609%2Fderrickstolee%2Fbloom-blame-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-609/derrickstolee/bloom-blame-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/609

Range-diff vs v2:

 1:  adc03eee4ac = 1:  adc03eee4ac revision: complicated pathspecs disable filters
 2:  7e8f1aed113 < -:  ----------- commit: write commit-graph with Bloom filters
 3:  824f8ad067b ! 2:  4073c8fe42f commit-graph: write commit-graph in more tests
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    commit-graph: write commit-graph in more tests
     +    tests: write commit-graph with Bloom filters
      
     -    The GIT_TEST_COMMIT_GRAPH test environment variable triggers
     -    commit-graph writes during each "git commit" process. To expand
     -    the number of tests that have commits in the commit-graph file,
     -    add a helper method that computes the commit-graph and place
     +    The GIT_TEST_COMMIT_GRAPH environment variable updates the commit-
     +    graph file whenever "git commit" is run, ensuring that we always
     +    have an updated commit-graph throughout the test suite. The
     +    GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variable was
     +    introduced to write the changed-path Bloom filters whenever "git
     +    commit-graph write" is run. However, the GIT_TEST_COMMIT_GRAPH
     +    trick doesn't launch a separate process and instead writes it
     +    directly.
     +
     +    To expand the number of tests that have commits in the commit-graph
     +    file, add a helper method that computes the commit-graph and place
          that helper inside "git commit" and "git merge".
      
     +    In the helper method, check GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS
     +    to ensure we are writing changed-path Bloom filters whenever
     +    possible.
     +
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## builtin/commit.c ##
     @@ commit-graph.c
       
      +void git_test_write_commit_graph_or_die(void)
      +{
     -+	if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0) &&
     -+	    write_commit_graph_reachable(the_repository->objects->odb, 0, NULL))
     ++	int flags = 0;
     ++	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
     ++		return;
     ++
     ++	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
     ++		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
     ++	
     ++	if (write_commit_graph_reachable(the_repository->objects->odb,
     ++					 flags, NULL))
      +		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
      +}
      +
     @@ commit-graph.h
       #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
       #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
       
     ++/*
     ++ * This method is only used to enhance coverage of the commit-graph
     ++ * feature in the test suite with the GIT_TEST_COMMIT_GRAPH and
     ++ * GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS environment variables. Do not
     ++ * call this method oustide of a builtin, and only if you know what
     ++ * you are doing!
     ++ */
      +void git_test_write_commit_graph_or_die(void);
      +
       struct commit;
 4:  4ae196d6355 = 3:  463d6bf5033 blame: use changed-path Bloom filters

-- 
gitgitgadget
