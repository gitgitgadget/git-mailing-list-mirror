Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6B0C2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FBB20732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 14:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5KLstQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbgDMOpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729082AbgDMOpa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 10:45:30 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA826C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:45:29 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ca21so9914114edb.7
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 07:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1qCCm3cNAzfutMwSphfC0sfa00BoY7YZx4n6rGQrhVc=;
        b=s5KLstQR6dVg5HHzrk5DQmd4RmpINk1TdHjqCk+Nrzi333afNIPCWc5sBsHLb7ESzD
         mZv+3usUWttwHTI8xKbP6XPLx/rmu+8bS4COjuVAdg+LTMHKFSG4SB9wnwsNsxnZAoSf
         a6eMvu8ByRgif0i2IwMJpNY71/Q87zKAhkFUFhzj8n7ckixHH5Slxb5AmEK2zZz9jq5A
         OXdffDuUeGdnUfIC1WcpxLI7rlrvpgO7Fo/eL7ZjcGHNxEl/yxAJzbZ5SATmU/Lbf0IT
         AHbN6SHKqmE1FfFl3yn/eNIcCZBdtZZS+6Zb9jsYbJfze0xxYr5xImsMz5KzmOcUkbC0
         M8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1qCCm3cNAzfutMwSphfC0sfa00BoY7YZx4n6rGQrhVc=;
        b=REH55qq2r7vjwf+xPGJinFCnGWNB8aLWyDdLhH7JtVDp4Sg4wybe6y4GY1SO3fUA1W
         DT/eT8gCxn0QIeXgJn35mLw/L+ATI30418qAybcMllPIhuPxKveWjjWJFqhRTCjEY7d/
         joaeFfLqfOHNKLbeV7+BD9Ii/lCvtm8uC8XjE26M48mT44IeyX0Kys1aivvaw+cqCn3b
         hiEuF5UHOJtal8MPjDwFSZosZIfF2jtfVwFHPzHpGEteBD9IFbSMaOoTLNdVFSsqb5XB
         dvRKbHg94jSUbx8vhfXHl7I2u1crsEY9Z1iCiiKeVomQyCTEwa2c5k2MHPQEGyOd+Szf
         1I/Q==
X-Gm-Message-State: AGi0PubYyBO10MnxUm7w1WjP7BEtU7NUuCOSxCm9eDlHAJdX8BejxHQ9
        Okn1Mcc7U+XqVj3WLF3Ic8cYUIf5
X-Google-Smtp-Source: APiQypK4zFTx4E5bRMmBPDs0hPd+YKodvFU4duw5kI/qYBH9x8AFxzWwt5H9oQFZ4O8WAKFkSQsgJQ==
X-Received: by 2002:a17:906:1fd6:: with SMTP id e22mr13825995ejt.150.1586789127886;
        Mon, 13 Apr 2020 07:45:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm1636598ejz.44.2020.04.13.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:45:27 -0700 (PDT)
Message-Id: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
In-Reply-To: <pull.609.git.1586566981.gitgitgadget@gmail.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Apr 2020 14:45:22 +0000
Subject: [PATCH v2 0/4] Integrate changed-path Bloom filters with 'git blame'
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

Derrick Stolee (4):
  revision: complicated pathspecs disable filters
  commit: write commit-graph with Bloom filters
  commit-graph: write commit-graph in more tests
  blame: use changed-path Bloom filters

 blame.c          | 139 ++++++++++++++++++++++++++++++++++++++++++++---
 blame.h          |   6 ++
 builtin/blame.c  |  10 ++++
 builtin/commit.c |   4 +-
 builtin/merge.c  |   7 ++-
 commit-graph.c   |   9 +++
 commit-graph.h   |   2 +
 revision.c       |  19 ++++++-
 8 files changed, 181 insertions(+), 15 deletions(-)


base-commit: f4df00a0dd448edce0e854a97f63598fefe27d27
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-609%2Fderrickstolee%2Fbloom-blame-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-609/derrickstolee/bloom-blame-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/609

Range-diff vs v1:

 1:  9cc31c289aa ! 1:  adc03eee4ac revision: complicated pathspecs disable filters
     @@ Commit message
          path Bloom filters in the test suite. That will be fixed in the
          next change.
      
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## revision.c ##
     +@@ revision.c: static void trace2_bloom_filter_statistics_atexit(void)
     + 	jw_release(&jw);
     + }
     + 
     ++static int forbid_bloom_filters(struct pathspec *spec)
     ++{
     ++	if (spec->has_wildcard)
     ++		return 1;
     ++	if (spec->nr > 1)
     ++		return 1;
     ++	if (spec->magic & ~PATHSPEC_LITERAL)
     ++		return 1;
     ++	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
     ++		return 1;
     ++
     ++	return 0;
     ++}
     ++
     + static void prepare_to_use_bloom_filter(struct rev_info *revs)
     + {
     + 	struct pathspec_item *pi;
      @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
     - 	if (!revs->commits)
     - 	    return;
     + 	int len;
       
     -+	if (revs->prune_data.has_wildcard)
     -+		return;
     -+	if (revs->prune_data.nr > 1)
     -+		return;
     -+	if (revs->prune_data.magic ||
     -+	    (revs->prune_data.nr &&
     -+	     revs->prune_data.items[0].magic))
     + 	if (!revs->commits)
     +-	    return;
      +		return;
      +
     ++	if (forbid_bloom_filters(&revs->prune_data))
     ++		return;
     + 
       	repo_parse_commit(revs->repo, revs->commits->item);
       
     - 	if (!revs->repo->objects->commit_graph)
 2:  bb5ce39d028 < -:  ----------- commit: write commit-graph with bloom filters
 -:  ----------- > 2:  7e8f1aed113 commit: write commit-graph with Bloom filters
 -:  ----------- > 3:  824f8ad067b commit-graph: write commit-graph in more tests
 3:  431fde68031 = 4:  4ae196d6355 blame: use changed-path Bloom filters

-- 
gitgitgadget
