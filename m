Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10915C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8F0207DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IxNtyqOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHCS5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS5I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:57:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8364C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:57:07 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so20536648qtp.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cuZcPi7JnhFovqZJFLIZTUpsFxyiJWe675S4I33WtJE=;
        b=IxNtyqOXB/V+ZtBvxQX7NKWF2pAYmvIETZEj4h21emn8EO9h2y4zOLY4seg1WH4VwX
         krczQ8SrJBr//EKlmuzVMKoJGXP+LCzHUWx+paE23QF6zG2Sxqw2cAkk/29HEcjTzqaq
         XOZJ5xJry8HBpLHeJwsh1ZZqEmX+b4N5NyUNM52d3CRbNbnqhk0vXBlGWZUEQBbVm/j/
         hcdO0zb8T07QPGkax2pnhYK1Oqm7Wav5ZixkKr7yovfXPRWvu1aGTcjhJ0mMk9YsWUHL
         G909GB3+suBORu8aHp0qIh5S3Hy2BW3c+JDsMgVQlLgnLSjnyCFcSid1YplLPIbYM2ZS
         sUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cuZcPi7JnhFovqZJFLIZTUpsFxyiJWe675S4I33WtJE=;
        b=LQMk511ToLw7XfHI/1Or7joxxrZqTuJfApaClTBs+Hp3eEerQHzAdbYCgw0G8SnBk7
         2lKlTO7aVLQtqkUpmlRBfhBtQVKZHY2sI20+9PvA5Eiy8Ira1Pe88G77H2xf6OmmOwN5
         fGn/iYPhwlQS/fSpwQH+OucjcIzAgIrtJgGXfKWq7ejCf9ltJuL4oHNkOvRm5rPTHVY4
         JUeBW7oePIP3wbEwdRQaAewg7pManlar7w9pKdeeSjNPvacZty0yyl2EvPy3bQZnnPZS
         nI8bRwgl4sZJllF9MFTgxaNpB1qel/IXNOHRGTlAGOTKQvBKHxblQ753UAEvI/j1J7U1
         PfSg==
X-Gm-Message-State: AOAM533WeoaRdem6gFWfdDkQHhcguydT24VrN87NvtbYOoaY7VnSNCQB
        k2074N94dH1weetuBiZYe2SnWEMH9vnkOQ==
X-Google-Smtp-Source: ABdhPJzXxxQGi2JfVvGt0pied8NOR/mTNWhcPpo8ru0Bh1DFl6lyUb7JDjdkSZKi1ekd9WgDiXT+Tg==
X-Received: by 2002:ac8:3d92:: with SMTP id v18mr18411125qtf.104.1596481026409;
        Mon, 03 Aug 2020 11:57:06 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id e61sm22343862qtd.20.2020.08.03.11.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:57:05 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:57:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
Subject: [PATCH 00/10] more miscellaneous Bloom filter improvements
Message-ID: <cover.1596480582.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here are some patches that I have been sitting on while rolling out
changed-path Bloom filters at GitHub. I was initially going to send this
as four separate topics, but they really make the most sense when sent
all together.

Here's an overview of what's contained:

  - The first patch fixes a bug where Bloom filters are only read if the
    most-recent layer in a commit-graph-chain has Bloom filters.

  - Patches 2-5 introduce 'commitgraph.readChangedPaths', a new
    configuration option for debugging changed-path Bloom filters. When
    disabled, the commit-graph machinery pretends as if there are no
    BIDX/BDAT chunks.

    This is useful when testing behavior with/without Bloom filters
    without having to regenerate the commit graph.

  - Patches 6-7 introduce a new 'BFXL' chunk which is a bitmap
    indicating which Bloom filters were too large to compute (ie., had
    more than 512 changed paths). This is a prerequisite for the final
    feature, --max-changed-paths.

  - Patches 8-10 introduces '--max-new-filters <n>', which allows
    callers to limit the number of Bloom filters that they are willing
    to compute from scratch when generating commit-graphs with
    --changed-paths.

The BFXL chunk is a prerequisite for '--max-new-filters' because of an
unfortunate overloading where filters with (1) no changed paths, (2) too
many changed paths, and (3) ones that weren't computed at all are all
represented as a length-0 filter by the BIDX chunk.

The problem is that in repositories with many commits that have too many
changed-paths to store Bloom filters, specifying '--max-new-filters'
recomputes those same large filters each commit-graph write, only to
throw them away. Knowing which filters are too-large allows us to skip
over computing filters we know are a waste.

Thanks in advance for your review!

Taylor Blau (10):
  commit-graph: introduce 'get_bloom_filter_settings()'
  commit-graph: pass a 'struct repository *' in more places
  t4216: use an '&&'-chain
  t/helper/test-read-graph.c: prepare repo settings
  commit-graph: respect 'commitgraph.readChangedPaths'
  commit-graph.c: sort index into commits list
  commit-graph: add large-filters bitmap chunk
  bloom: split 'get_bloom_filter()' in two
  commit-graph: rename 'split_commit_graph_opts'
  builtin/commit-graph.c: introduce '--max-new-filters=<n>'

 Documentation/config.txt                      |   2 +
 Documentation/config/commitgraph.txt          |   8 +
 Documentation/git-commit-graph.txt            |   4 +
 .../technical/commit-graph-format.txt         |   9 +
 blame.c                                       |   8 +-
 bloom.c                                       |  34 ++-
 bloom.h                                       |   9 +-
 builtin/commit-graph.c                        |  61 +++--
 commit-graph.c                                | 214 +++++++++++++-----
 commit-graph.h                                |  17 +-
 fuzz-commit-graph.c                           |   5 +-
 line-log.c                                    |   2 +-
 repo-settings.c                               |   3 +
 repository.h                                  |   1 +
 revision.c                                    |   4 +-
 t/helper/test-bloom.c                         |   2 +-
 t/helper/test-read-graph.c                    |   3 +-
 t/t4216-log-bloom.sh                          |  54 ++++-
 t/t5324-split-commit-graph.sh                 |  13 ++
 19 files changed, 357 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/config/commitgraph.txt

--
2.28.0.rc1.13.ge78abce653
