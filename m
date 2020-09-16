Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A82C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A1A2083B
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IxK6uqQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgIPSHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgIPSGv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:06:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AAAC06174A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:06:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id n10so6891992qtv.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0LwL5yH6mKpPJQ43aPoke7P5zi3jtL5Qw2uhYgsXuyo=;
        b=IxK6uqQvGDEv48lU42Zvdp4f0sKqfBUJV43BNF+ICYB0yY8w3Md3l+TdT6rqaaPHwP
         fZ9WWQA67i4wduIXBoQGOApH04xIbnPMYLrJzcGZYlHH0GyObw2W8msuVrQjKMlfkqwE
         dEGJSWE6taAseuGcDbTbnQ2911rpuU17Kv5RC5OuUkAjdd8ZEDFM9iV9Me3eJb54YP6P
         2TL+tcT+mHSBuBguGTeFjLZQQtct8e8A7ave7mThnD/3A1UmGiehDuTV9OeyWP4XDH/b
         Sm/W3y+gy6sEuN8itp3+aSZh7JGVXZoGM8cK1eQmoUIKPhazcu1C1hRH0nksiEUqT7rp
         zt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0LwL5yH6mKpPJQ43aPoke7P5zi3jtL5Qw2uhYgsXuyo=;
        b=g18f/GjV3M2c02/5WtAaX0hupAApH1yFYhVKQgcVGE6vUQ+DPjgswKDGt7VPCBRykB
         Q3kg314xxBc/piT6X12e5CiG6PYFkv6egocgPXzvdNsDf5mjEm7ou+xJX6Lx7mMhb6XW
         9a3PULWTtj13p9M8NMLC2AlMtNgtm38AgW4iUGdpBg/y5pJK3zVdirajc6B3Gp4CX01a
         dCJXfbG8ODoHI7HDKEV7EmzZ4JWvD3GQTxqo4xW/UKcjAS5nzx5KIQ7OPzcsWUgTAZ4p
         jU2eitVwVwYy024xeu6cK9SpPnIU71UBTFwRxhqFKiNf5z1l6kq+LPcEqipNrSPcPQwh
         /pWg==
X-Gm-Message-State: AOAM530cZYGrrNLx96kI4ZAD+gChuFaj0SwcdCA+WBUsjQkfHpr7ro5q
        BxKaPEBu/4qaVv6lu7D3yYgr7E3HWZqa9u/J
X-Google-Smtp-Source: ABdhPJz8RWHyeLgPyPSOqknY55KFFg+/kjDkQ4lnz1UJfDGjzPVAkmcfcZOHRNft0f48t4bpjZExUA==
X-Received: by 2002:aed:37c4:: with SMTP id j62mr11901941qtb.274.1600279609462;
        Wed, 16 Sep 2020 11:06:49 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:e86e:6adf:7537:ae24])
        by smtp.gmail.com with ESMTPSA id b199sm19675721qkg.116.2020.09.16.11.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 11:06:48 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:06:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 00/13] more miscellaneous Bloom filter improvements, redux
Message-ID: <cover.1600279373.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's another re-roll of mine and Stolee's series to add a series of
improvements to the Bloom filter machinery, culminating in the
command-line flag '--max-new-filters'.

Much is left the same from [1], with two notable exceptions:

  - I took much of Stolee's feedback from [2], since the suggestions
    were good and we are rerolling, anyway.

  - I dropped the trace2 calls that write JSON from within the
    commit-graph machinery in favor of pure "data" writes, which are
    easier to grep for. This caused some test refactoring and allowed us
    to ultimately drop the 'test_bloom_filters_computed' function.

Hopefully this is it for this series ;). I think that it's in good shape
now, and I couldn't find anything in my own inspection that I wanted to
change. So, if others feel good, too, I think we should focus on
incremental fixes on top of this.

[1]: https://lore.kernel.org/git/cover.1599664389.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/134d64a0-abb6-bdc9-2c05-7aded01a906a@gmail.com/

Derrick Stolee (1):
  bloom/diff: properly short-circuit on max_changes

Taylor Blau (12):
  commit-graph: introduce 'get_bloom_filter_settings()'
  t4216: use an '&&'-chain
  commit-graph: pass a 'struct repository *' in more places
  t/helper/test-read-graph.c: prepare repo settings
  commit-graph: respect 'commitGraph.readChangedPaths'
  commit-graph.c: store maximum changed paths
  bloom: split 'get_bloom_filter()' in two
  bloom: use provided 'struct bloom_filter_settings'
  bloom: encode out-of-bounds filters as non-empty
  commit-graph: rename 'split_commit_graph_opts'
  builtin/commit-graph.c: introduce '--max-new-filters=<n>'
  commit-graph: introduce 'commitGraph.maxNewFilters'

 Documentation/config.txt                      |   2 +
 Documentation/config/commitgraph.txt          |   8 +
 Documentation/git-commit-graph.txt            |   6 +
 .../technical/commit-graph-format.txt         |   2 +-
 blame.c                                       |   8 +-
 bloom.c                                       |  59 +++--
 bloom.h                                       |  29 ++-
 builtin/commit-graph.c                        |  63 ++++-
 commit-graph.c                                | 140 +++++++---
 commit-graph.h                                |  17 +-
 diff.h                                        |   2 -
 fuzz-commit-graph.c                           |   5 +-
 line-log.c                                    |   2 +-
 repo-settings.c                               |   3 +
 repository.h                                  |   1 +
 revision.c                                    |   7 +-
 t/helper/test-bloom.c                         |   4 +-
 t/helper/test-read-graph.c                    |   3 +-
 t/t0095-bloom.sh                              |   8 +-
 t/t4216-log-bloom.sh                          | 241 ++++++++++++++++--
 t/t5324-split-commit-graph.sh                 |  13 +
 tree-diff.c                                   |   5 +-
 22 files changed, 505 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/config/commitgraph.txt

--
2.28.0.510.g86fdc5f89a
