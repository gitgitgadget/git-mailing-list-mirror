Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025ECC43463
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96A02083B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 02:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="F3FE5rKV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgIRC6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730411AbgIRC6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 22:58:39 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D73CC06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:58:39 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o5so4612395qke.12
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 19:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nt9qFaZjHuvmK8SQC3zq2BJdGrI8P6MIF4Ab3uSQYqE=;
        b=F3FE5rKV5EqsPL1Cr3pyTk0Kd7UeMhRISiJ3uBLIi2iTmBqtsKilM+l0xnfaiwpQAJ
         d3emTrECrWS+1GCKCObKQFx2Yn8Ol3sy7fzH7muu84u95QWQXlOHo0L6fON17/NWsqhJ
         ES4Qyye81uod3O5BfnE4t3k8NYq6raIeK0KbWlx5+3+HCZCVnCjPMdYK/Kc/YZ0YDOgL
         7G1O16P7sTlKNo/+Ucioa4gty1LxoCALcOVVdHQzpZsKgX9hdv3iOiBn0KGxqTKZmJz7
         9Z7zJtgfnq4axDtlLnJlvQlUbYFz3YJR51LmXzJw+q5BsjD3fN2jb1FA5wrMqrB1cAhL
         GHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nt9qFaZjHuvmK8SQC3zq2BJdGrI8P6MIF4Ab3uSQYqE=;
        b=YkUljnrleSr3MyKtQwF2kT72JhWa5FK9MCboH1GPK3YL71O3ZuPGJMCZwPDG8cS9K7
         WzwZx7WmAUChsbwN6hnViMsGjCPt1ySIXEB4zhabgFKVS1xBTeO99m8tl0xvLZqiiFjd
         YtTFLsxTJ7gB3nKPPx6SSYYrtd5iQc6lIjJr7k1KouRFt2wboZ/hDGPwHUon4yjkT8X5
         zBubxSPFMEPGyJ1ttxdUflRUVywOHxmS91P46/IWPmh72pNT9uyc3NXIvZSkG83gfNdd
         PDfHyBuDanLSV5fR3XhXiXAEHIVXrFzMQzVgkycV9omYA3sMs1mPLTHaJ5rwiux5p/Uf
         7sHA==
X-Gm-Message-State: AOAM531+bFWlsjtcAYa6Y+q5ZyYuLm/hQ2L2pfchG7ae/zZdEmeoAnlS
        HG5lpeWo2+Dj+xOqnXMki0Jg41z0JqJJd4SL
X-Google-Smtp-Source: ABdhPJzSaKxiFZvXWZS1O/FimqWDgRjoEZYvgSkLAoKkfMGLNlqRWRekiHi9JmkZ82q/XxaoBuwRNw==
X-Received: by 2002:a37:a414:: with SMTP id n20mr31885933qke.332.1600397918080;
        Thu, 17 Sep 2020 19:58:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id x43sm173773qtx.40.2020.09.17.19.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 19:58:37 -0700 (PDT)
Date:   Thu, 17 Sep 2020 22:58:35 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v3 00/13] more miscellaneous Bloom filter improvements, redux
Message-ID: <cover.1600397826.git.me@ttaylorr.com>
References: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1599664389.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Here's a few more changes to the "Bloom filter improvements" topic,
sent as one brand-new re-roll in order to simplify queuing. It
incorporates:

  - Junio's changes from applying to 'seen' (namely, dropping references
    to "too-small" commits in favor of the much more clear "empty"
    commits).

  - On top, I applied Gàbor's data gathered in [1] to 10/13 (and added a
    little more detail on the absolute and relative size differences of
    the resulting commit-graph files built before/after that patch).

Thanks to everyone who has helped out along the way with this series
(Stolee, Gàbor, Junio, Jakub, and I am sure that I am forgetting some...).

Sorry to have given anyone the impression that I was abandoning this
topic; I'm definitely not ;-).

[1]: https://lore.kernel.org/git/20200917221302.GC23146@szeder.dev/

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
 commit-graph.c                                | 141 +++++++---
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
 t/t4216-log-bloom.sh                          | 242 ++++++++++++++++--
 t/t5324-split-commit-graph.sh                 |  13 +
 tree-diff.c                                   |   5 +-
 22 files changed, 507 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/config/commitgraph.txt

--
2.28.0.510.g375ecf1f36
