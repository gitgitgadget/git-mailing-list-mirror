Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B77C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC692166E
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 17:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="wWOjYB7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgIIRTo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgIIP1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 11:27:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299AC0619C8
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 08:22:39 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h1so1685610qvo.9
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hUAsz5RCiWx9RNNoVMQv/0ENuouUgQPdVmwy0soTBYs=;
        b=wWOjYB7FbbGVIXMJpPtypd4BRaPNdARkYhCwC7O2G9BTvAH8g+uWBNPLB/V8N2wSZS
         ojbUVDJKS5CjpHURoB566EMzojnfmRFLxHBpqp7g+J0rzy1H7uqEuFLHZbJInZl1t50a
         XMOSgM6EZgkv3v92Hn4/QOZiWpKdWA0Ptb91OAlV9lbPGwrfi9HNQd3rN5th5eI1Iu8J
         vfqz2J4FUzvGn6Rc8nEn6uAFe1BH0PkbmI9VE/1isnrbpu1tMymp36+s3FEHPbhjDU9j
         RssFmk7F6CvLyuRvtNHeo8cl/LPlRaf4fqBLrhRPufH3O6jQkUX8gLKTSBvqV/yM1sql
         sJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hUAsz5RCiWx9RNNoVMQv/0ENuouUgQPdVmwy0soTBYs=;
        b=aFmebC0R/TonJkoCKDBbM+Kp/GU2CspbZ6b0n/KV8iGDKF0YHG6tj683iAHBWM39fD
         kDwT8DKg/FijK9bqEdOUPmhv8I+teZzNOUcNEAvEvGAdOMvH/8WaFD+C5ihYHiFIdCY5
         hkImlEB9QSikyYHCLMwDxVagHEp6+HPvpjAsYLqfrNSb3d3iKQVW7JiA+7lVmrSa9Faf
         QfNOL/QoTMWWX1i/ZXChmPrA2y37R9GHoRLNeOo8C7Qu/yKGmdkK3E8cSPgjjDZ0y61i
         r7LlSPMBl/d/om9dTXWwqaJhopu/CFzQzu8+wbyREHeQlmGrneLtUA7d/LyCvsciTx99
         upWQ==
X-Gm-Message-State: AOAM530eLIVMECGR/uj1SGTLb25qVFvj42HXNK5uET/fQ3PcqIjpe5qO
        f8jdmFea7VLMfk+R28RVMvtAl92/NHqUGiY8
X-Google-Smtp-Source: ABdhPJyI7XjjUQpp+u4918ygMIF9H79IaqE22NtaM26CVFmQAtw40P4e7zRSHHtLHSHg8PVJwIo2Sw==
X-Received: by 2002:a0c:a085:: with SMTP id c5mr4726502qva.30.1599664958290;
        Wed, 09 Sep 2020 08:22:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id k6sm3311918qti.23.2020.09.09.08.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:22:37 -0700 (PDT)
Date:   Wed, 9 Sep 2020 11:22:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH 00/12] more miscellaneous Bloom filter improvements, redux
Message-ID: <cover.1599664389.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a rejiggered version of my series in [1], which accomplishes the
same without changing any of the on-disk commit-graph format.

As a reminder, the main goal of this series is to introduce a
'--max-new-filters' flag to 'git commit-graph write' to place a limit on
the number of new Bloom filters a writer is willing to compute from
scratch. The main difficulty is disambiguating between empty/too-large
filters and ones that haven't been computed yet. See "bloom: encode
out-of-bounds filters as non-empty" for the details.

The series is organized as follows:

  * Patches 1-4 are uninteresting preparatory steps.,
  * Patch 5 introduces the 'commitGraph.readChangedPaths' configuration.
  * Patches 6-8 are more preparation.
  * Patch 9 is from Stolee and fixes a bug where computing Bloom filters
    from scratch wouldn't stop at the limit of 512.
  * Patches 10-12 prepares for and then introduces '--max-new-filters'.

The first nine patches are basically unchanged from [1] where they were
thoroughly reviewed. The tenth patch is new, and the final two patches
are only touched up and simplified to work with this new approach, but
they have otherwise been reviewed.

Since the old thread was getting long, and this is a substantially new
approach, I'm sending this as "v1" of a new series, which hopefully
nobody minds.

[1]: https://lore.kernel.org/git/cover.1596480582.git.me@ttaylorr.com/

Derrick Stolee (1):
  bloom/diff: properly short-circuit on max_changes

Taylor Blau (11):
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

 Documentation/config.txt                      |   2 +
 Documentation/config/commitgraph.txt          |   8 +
 Documentation/git-commit-graph.txt            |   6 +
 .../technical/commit-graph-format.txt         |   2 +-
 blame.c                                       |   8 +-
 bloom.c                                       |  53 +++--
 bloom.h                                       |  29 ++-
 builtin/commit-graph.c                        |  61 ++++--
 commit-graph.c                                | 148 ++++++++++----
 commit-graph.h                                |  17 +-
 diff.h                                        |   2 -
 fuzz-commit-graph.c                           |   5 +-
 line-log.c                                    |   2 +-
 repo-settings.c                               |   3 +
 repository.h                                  |   1 +
 revision.c                                    |   7 +-
 t/helper/test-bloom.c                         |   4 +-
 t/helper/test-read-graph.c                    |   3 +-
 t/t0095-bloom.sh                              |   4 +-
 t/t4216-log-bloom.sh                          | 181 ++++++++++++++++--
 t/t5324-split-commit-graph.sh                 |  13 ++
 tree-diff.c                                   |   5 +-
 22 files changed, 442 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/config/commitgraph.txt

--
2.28.0.462.g4ff11cec37
