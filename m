Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD67C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAF42063A
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="o5ccp4U3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgA3XAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:00:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgA3XAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 18:00:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so2254094pfh.7
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y3BrCzWxh4tJ0Z1/lrjOSlgejiCpmwQiWu9FjcujZEE=;
        b=o5ccp4U3GS/ugahqvIxfWdsxnBzMCscUrystk7MwCJon4Ilc54Mk5VSmLHHaxfS523
         lQmXQd7qszqpterMpAnHm3I1qSVDF4rq72tp/DWZxWj95NMv5JWYUQNuTfA99vYUtf9n
         2Li2I5O8xZHHHsq8Okz3q065JgMmXZOs+x901RXWLJvrOs6P1K2xVo9asJWZrMG6Og/R
         kCHG8btqIQ+oKW8Ev9cYFC9VuwVzqB+QJcQJu9vB89pK+pbBE+4SPB2dlWQ8/ORHq7lr
         WHcc/zKCZhbGIPIwT0SryXHJb5Gi3nIpEWfTos8fUI4CX0mxJsw84uqeLsXThHZImyGs
         nBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y3BrCzWxh4tJ0Z1/lrjOSlgejiCpmwQiWu9FjcujZEE=;
        b=kXrJZuZgwj67I/p5F83mP1Zi+TCtqb7LfqGqBmSvSsGB6PQjuV6jTeuEBNZ9Ax33Aj
         D4R4q1RMf9M43A2HLCNa6Fr3HaLF6dtfXQKNpIRgCTpWtKfGbFNPRqNdh7xiJepdJCx5
         689qbkUzzMJbFq6a7tYDXqQ3f9AWP75ChGxtRGQTnA3q+mJeqB6bRHP6dCkcp2fZZjtr
         x2S4byIPaX++bieBtkZ9pmIsj4bVG3XteI6hsCcVrqBbkeviL+tM//QE7EqFkuuFu9eB
         pSRBm4vWSFtFwLhvPW52TPhm7A0D5WrkZc3scH6Mmn5Pf4APWEc/ppRo739sHjt2NcWC
         H8fQ==
X-Gm-Message-State: APjAAAX5asrrXfUMAsf2bmfSnGE9VIkTIxfL9kO1kdiD5wvmZf/Q8P0N
        rrpYGX43t9s9c2xUxbJUortOOW7WyW6WHA==
X-Google-Smtp-Source: APXvYqzfQLobvYvE8+8cgZ/q21JgPTE1m/aYGYoaTpecQVSgbyyJhItH5ThUQSjzX6zUIXKiPJpJ8Q==
X-Received: by 2002:aa7:84cd:: with SMTP id x13mr7643212pfn.130.1580425242697;
        Thu, 30 Jan 2020 15:00:42 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:5c8f:7dac:47b8:95ff])
        by smtp.gmail.com with ESMTPSA id s22sm7410130pji.30.2020.01.30.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 15:00:42 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:00:40 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH 0/6] commit-graph: use 'struct object_directory *' everywhere
Message-ID: <cover.1580424766.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

While working on deploying layered commit-graphs at GitHub, I noticed
that I was able to trigger the mechanism to prevent merging
cross-alternate commit-graph layers in funny ways, like claiming that
"./objects" and "objects" were in different directories.

This resulted in removing all of the places in the commit-graph.c code
that use 'char *object_dir's with 'struct object_directory *'s instead.
This allows us to replace brittle string-based path comparisons with raw
pointer comparisons to check whether two commit-graphs belong to the
same object store or not.

This has a pleasant side effect in PATCH 5/6 of fixing an uninitialized
read as described in [1].

This series became a little bit longer than I was expecting it to be, so
here is the high-level structure:

  - 1/6 fixes a bug in a test that would cause a subsequent failure if
    unaddressed.

  - 2/6 does the first half of the removal by using 'struct
    object_directory *'s within the 'commit_graph' structure.

  - 4/6 does the second half by removing 'char *object_dir' usage in the
    'write_commit_graph_context' structure.

  - 5/6 ties 2/6 and 4/6 together by removing all path normalization
    completely, fixing the uninitialized read bug.

  - And 6/6 cleans up.

We've been running a version of this series based on our fork (which is
in turn based on 2.24) for a few hours without issue.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/20191027042116.GA5801@sigill.intra.peff.net/

Taylor Blau (6):
  t5318: don't pass non-object directory to '--object-dir'
  commit-graph.h: store object directory in 'struct commit_graph'
  builtin/commit-graph.c: die() with unknown '--object-dir'
  commit-graph.h: store an odb in 'struct write_commit_graph_context'
  commit-graph.c: remove path normalization, comparison
  commit-graph.h: use odb in 'load_commit_graph_one_fd_st'

 Documentation/git-commit-graph.txt |   5 +-
 builtin/commit-graph.c             |  25 ++++--
 builtin/commit.c                   |   3 +-
 builtin/fetch.c                    |   2 +-
 builtin/gc.c                       |   2 +-
 commit-graph.c                     | 135 +++++++++++++++--------------
 commit-graph.h                     |  17 ++--
 t/helper/test-read-graph.c         |   8 +-
 t/t5318-commit-graph.sh            |   4 +-
 9 files changed, 114 insertions(+), 87 deletions(-)

--
2.25.0.dirty
