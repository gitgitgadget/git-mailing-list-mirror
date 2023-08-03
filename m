Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3B0C001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbjHCSrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 14:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjHCSrV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 14:47:21 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DDF4EC8
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 11:46:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d0b597e7ac1so1518768276.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691088357; x=1691693157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmxRGsdoQ3VMafZWh3p4/Zofz+xAe2YDP3F8iQ8MFTI=;
        b=qSJX2NZfo5B8gxaPB6URgkTEAQpg/wCLUj0mwXonk4Hqmia8yPTKn5DQtlq0mGdVwF
         9Hr3fnArL8lwPDPiTOwkMOPX2XptVYfImTq0tsMGFrlcQ90b8aZlI7gaBOZ9D+RFA2GY
         CjNGEoz2PSdsOcyvGx2F/PI6aJ6/VaS52Ph+aYuQCaCmKYAvZbcom8MRW+wZ/XsOFgVL
         gmRxjKimfEIxwPY7ka9E8M9K+rOpn18byI2q6Yv3Sfv4mP5wdf7RhGq0OjP2KTV4XW1O
         VNXDoPyqaFruEJJLlgXAu+NfA0D7wawzm6S9rhH7MN7tPUTfrJOITMAKlNxBDNwVZUyo
         Xk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691088357; x=1691693157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmxRGsdoQ3VMafZWh3p4/Zofz+xAe2YDP3F8iQ8MFTI=;
        b=VpqA2nqwCWwmtyQHZmmCRTrkTHxiraKUot31yhFXrTRrRmrnhnuJ/BHPMLDXSh/PaL
         k1PGPsg5QZhJoF6KOt/VMHgNXHFRAbmTlbiVs+OWyf5PBEAWvSqlgU7NRwUeR6CPQyUB
         uMr9xf5yxBQK0l6Np47ZBa1IDoWyY5cR70bl+wzIgQuAxdnD+X295Iah/WkonxJcLFfu
         f9hzh1v/g/i/yJurPaD49eMvREkj4mOpTUeA2ovSKPTRoDS3wJhG0l123IImhyu4xAqz
         VtfrdAEVOaQd8n7TtrGzOZvjWY5ZpHi8imWgn+SYuTUNWnRWqFFB6soTo0K/7Yu5axVp
         Z0Rg==
X-Gm-Message-State: ABy/qLbo4Iz8PdONJs6IySTbIlV1Q2XoMavb/opuqfcoypqIZOk21t2d
        IE5Oha0k0EO5/5dsPpA1XQmgh6RsdwgHPCy05FoEZA==
X-Google-Smtp-Source: APBJJlH1zkv236U0RMUypLUd1+Idwt2dwqYfsEvywKjfBljBAOMLgtVCfAPo8sxPHGfgF37V4k/+UQ==
X-Received: by 2002:a25:74c2:0:b0:d06:66be:b22 with SMTP id p185-20020a2574c2000000b00d0666be0b22mr19780081ybc.19.1691088356725;
        Thu, 03 Aug 2023 11:45:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 1-20020a250901000000b00d3e7b5ae274sm88134ybj.58.2023.08.03.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:45:55 -0700 (PDT)
Date:   Thu, 3 Aug 2023 14:45:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
Message-ID: <ZMv14grkM7x7Sf8m@nand.local>
References: <ZMKvsObx+uaKA8zF@nand.local>
 <20230727205308.401364-1-jonathantanmy@google.com>
 <ZMlKMmAs3wKULAOd@nand.local>
 <ZMruSSAGQWS8crvi@nand.local>
 <491c237b-de23-52b0-c034-d4d358372864@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <491c237b-de23-52b0-c034-d4d358372864@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 03, 2023 at 09:18:11AM -0400, Derrick Stolee wrote:
> > So I think the revised condition is something like: a commit's Bloom
> > filter is reusable when there are no paths with characters >= 0x80 in
> > a tree-diff against its first parent. I think that ensuring that there
> > are no such paths in both a commit's root tree, as well as its first
> > parent's root tree is equivalent, since that removes the possibility of
> > such a path showing up in its tree-diff.
>
> This condition is exactly "we computed the diff to know which paths were
> input to the filter" which is as difficult as recomputing the Bloom filter
> from scratch. I don't think there is much room to gain a performance
> improvement here.

I think that's true in the worst case, and certainly for repositories
with many tree entries which have characters >= 0x80.

But note that it's a heuristic in one direction only. If we know that a
commit's root tree (and that of it's first parent, if it has one) is
free of any such paths, then it's impossible for the first parent
tree-diff to contain such an entry, and therefore we can reuse any
existing filter.

Of course, a commit's root tree (and its parent) may both have a path
whose characters >= 0x80 while still not seeing a corresponding entry
show up in the tree-diff if that path is unchanged between a commit and
its first parent.

I think if we were looking at every tree every time only to realize that
we have to go back and compute its changed-path Bloom filter, this would
be a non-starter. But since we "cache" the results of our walk via the
tree object's flags bits, we can skip looking at many trees.

In my testing, this showed a significant improvement on linux.git and
git.git. My setup for testing is something like:

    $ git clone git@github.com:torvalds/linux.git
    $ cd linux
    $ git commit-graph write --reachable --changed-paths
    $ graph=".git/objects/info/commit-graph"
    $ mv $graph{,.bak}

so that .git/objects/info/commit-graph.bak is a commit-graph with v1
changed-path Bloom filters for all commits in generation order.

With that in place, I can do:

    $ git config commitGraph.changedPathsVersion 2
    $ hyperfine -p 'cp -f $graph.bak $graph' -L v 0,1 \
        'GIT_TEST_UPGRADE_BLOOM_FILTERS={v} git.compile commit-graph write --reachable --changed-paths'

, producing the following results on linux.git:

    Benchmark 1: GIT_TEST_UPGRADE_BLOOM_FILTERS=0 git.compile commit-graph write --reachable --changed-paths
      Time (mean ± σ):     124.873 s ±  0.316 s    [User: 124.081 s, System: 0.643 s]
      Range (min … max):   124.621 s … 125.227 s    3 runs

    Benchmark 2: GIT_TEST_UPGRADE_BLOOM_FILTERS=1 git.compile commit-graph write --reachable --changed-paths
      Time (mean ± σ):     79.271 s ±  0.163 s    [User: 74.611 s, System: 4.521 s]
      Range (min … max):   79.112 s … 79.437 s    3 runs

    Summary
      'GIT_TEST_UPGRADE_BLOOM_FILTERS=1 git.compile commit-graph write --reachable --changed-paths' ran
        1.58 ± 0.01 times faster than 'GIT_TEST_UPGRADE_BLOOM_FILTERS=0 git.compile commit-graph write --reachable --changed-paths'

On git.git, writing a new commit-graph after upgrading from v1 to v2
filters went from taking 4.163 seconds to 3.348 seconds, for a more
modest 1.24x speed-up.

Of course, all of this depends on how much of the tree meets the above
conditions, so we'd expect worse results on repositories with paths that
contain characters >= 0x80. I think we'd want some kind of mechanism
(probably via config, not a GIT_TEST environment variable) to control
whether or not to upgrade existing filters.

Thanks,
Taylor
