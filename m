Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA9AC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C0C22261
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 20:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj6QfZgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390905AbgJIUxz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 16:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgJIUxz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 16:53:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57628C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 13:53:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q5so11081682wmq.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QjlF4Vf51qJASCu9ecBY2Dvn8hVx6AW4gVh3A5qlypg=;
        b=dj6QfZgkrjuhYJB3Bqtfn1rPQXuuGnHBs4wDo27hq6xj5fHAlW1yCRU+vunf9RRy6T
         qTPEJPAJVFxMdN67QgEAOtLzqiQLbTtR+cpHFyZWmnMxKFGMMEIuMdhzL3UUxFeYdPMa
         WwntFA7Tf9DKn7ZzjCIdtfBqERX5c4XBQRJqlLdaLiZrPXIBbUFqi2BLYHawL8swIi4G
         mM6qVxnyrrun8FFaQY2Y2KOjW4e9DrbMMp38QOjWYjrj1G1UOev7iEKu+Fy9MeXfjupm
         geK3fU1CPt1V/4eThCbkOKjkpIMKpLDvxmloZ9y9BPJluFJimP4dPHNSXoU5AWMW2M2+
         vThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QjlF4Vf51qJASCu9ecBY2Dvn8hVx6AW4gVh3A5qlypg=;
        b=m2pXMDGNLwJJUhn8SXueGufHyU2oyK+zVkOfyNtHCI/UDDwt8pMiG+dm3oKMLSG5j7
         roKFFihPZmAEdWYbii+NXU+us4LTvAeguHE1NZTiseCSiCz42KPh0EKUNU2Df2tRgsBJ
         Qhnf2lq4boH6TYR814KxPKq1EI03HEGDBKJ4Wm0//p+dP6Iy1bM2GUSzTuDcdUez1IGA
         PvFTAc/5ed/9PGXpg6Z2g/IKw3+c0bnx6ZIlN1EpMz4XvDMnGo0MabSlJHLnq+OkIPW+
         VTXJEPsyOs4drlWXZOYCTjYhQMBzN14jUjq3QtUT2JWyqkurlDdqmhKMYZdyF+7Jq9g3
         NUqA==
X-Gm-Message-State: AOAM530ZF5XAley5hIKzRZ/Ao8WdcZFvMaq23Zki6FnUphCPLmyYZfW6
        J2TzVDEVmq/1Yb/9Yn39CM5ElQGVsKA=
X-Google-Smtp-Source: ABdhPJx6v1SybmRVKp/dYwAlBpG0qwkXEva9GkOMRrlTAVaa9TClRWiGlClzBH/q/b91QftlxFGslQ==
X-Received: by 2002:a1c:6a0a:: with SMTP id f10mr16363705wmc.86.1602276833829;
        Fri, 09 Oct 2020 13:53:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm618603wmi.4.2020.10.09.13.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 13:53:53 -0700 (PDT)
Message-Id: <pull.747.v4.git.1602276832.gitgitgadget@gmail.com>
In-Reply-To: <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
References: <pull.747.v3.git.1602169479482.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Oct 2020 20:53:50 +0000
Subject: [PATCH v4 0/2] commit-graph: ignore duplicates when merging layers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is v4 of a series that was previously only one patch.

Thanks to the efforts of Thomas, Peff, and Taylor, we have a full
understanding of what went wrong here. Details are in the patches
themselves, but generally when writing a commit-graph chain we rely on the
commit-graph parsing to know which commits are already in the lower layers
of the chain. When 'core.commitGraph' is disabled, then we don't do that
parsing, and then we add all reachable commits to the top layer and merge
down. This causes us to hit the previous die() statement.

This fixes the problem by first handling any duplicates we see during a
merge (this is important for handling any other data out there in this
situation) and also to disable commit-graph writes when 'core.commitGraph'
is disabled.

Thanks, -Stolee

Derrick Stolee (2):
  commit-graph: ignore duplicates when merging layers
  commit-graph: don't write commit-graph when disabled

 Documentation/git-commit-graph.txt |  4 +++-
 commit-graph.c                     | 21 ++++++++++++++++++---
 t/t5324-split-commit-graph.sh      | 13 +++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)


base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-747%2Fderrickstolee%2Fcommit-graph-dup-commits-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-747/derrickstolee/commit-graph-dup-commits-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/747

Range-diff vs v3:

 1:  9e760f07ac ! 1:  9279aea3ef commit-graph: ignore duplicates when merging layers
     @@ Commit message
          pointers. This allows us to get the end result we want without extra
          memory costs and minimal CPU time.
      
     -    Since the root cause for producing commit-graph layers with these
     -    duplicate commits is currently unknown, it is difficult to create a test
     -    for this scenario. For now, we must rely on testing the example data
     -    graciously provided in [1]. My local test successfully merged layers,
     -    and 'git commit-graph verify' passed.
     +    The root cause is due to disabling core.commitGraph, which prevents
     +    parsing commits from the lower layers during a 'git commit-graph write
     +    --split' command. Since we use the 'graph_pos' value to determine
     +    whether a commit is in a lower layer, we never discover that those
     +    commits are already in the commit-graph chain and add them to the top
     +    layer. This layer is then merged down, creating duplicates.
     +
     +    The test added in t5324-split-commit-graph.sh fails without this change.
     +    However, we still have not completely removed the need for this
     +    duplicate check. That will come in a follow-up change.
      
          Reported-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
          Helped-by: Taylor Blau <me@ttaylorr.com>
     @@ commit-graph.c: static void sort_and_scan_merged_commits(struct write_commit_gra
       	stop_progress(&ctx->progress);
       }
       
     +
     + ## t/t5324-split-commit-graph.sh ##
     +@@ t/t5324-split-commit-graph.sh: test_expect_success '--split=replace with partial Bloom data' '
     + 	verify_chain_files_exist $graphdir
     + '
     + 
     ++test_expect_success 'prevent regression for duplicate commits across layers' '
     ++	git init dup &&
     ++	git -C dup config core.commitGraph false &&
     ++	git -C dup commit --allow-empty -m one &&
     ++	git -C dup commit-graph write --split=no-merge --reachable &&
     ++	git -C dup commit --allow-empty -m two &&
     ++	git -C dup commit-graph write --split=no-merge --reachable &&
     ++	git -C dup commit --allow-empty -m three &&
     ++	git -C dup commit-graph write --split --reachable &&
     ++	git -C dup commit-graph verify
     ++'
     ++
     + test_done
 -:  ---------- > 2:  4439e8ae8f commit-graph: don't write commit-graph when disabled

-- 
gitgitgadget
