Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9509BC47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB50208DB
	for <git@archiver.kernel.org>; Fri,  1 May 2020 15:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLIeNoIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgEAPad (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 11:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgEAPac (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 11:30:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328EFC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 08:30:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so11878242wrg.11
        for <git@vger.kernel.org>; Fri, 01 May 2020 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=OQAtczCYAIjmD++TS2hxWoY3tV5Bb35hQvEEHXW32E8=;
        b=eLIeNoIpz8P7zzCWwreig+FoJavhZgcaz1PrWLLwCdrcfcxKPd6uGBJOFBzXSxuxGI
         8L0/s3a73hFtw1W9PNfzXEg9ejmtyo/j44fZFXHfUzMoQ0FeUawbO7N67e5YJv3HvtCu
         yp3LPXbYvCgVa8zhanNIlBvnxHjWQteCfBESHE6Ki4j3BafaJLPzPXwq9jge37/S72/0
         zRvqgWSfYlhCOucHhZayX2C81mbhC5J/GkQ3HyJ83R85r/fNvYv6/nauS+CuqjY5On+m
         DxLfDQU5A3n3frt0ueX4DP0ki0Fhc5yEJRsDr3IALxZjmh7+O3WqQlaF8WjqOXcMQ+kd
         qkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=OQAtczCYAIjmD++TS2hxWoY3tV5Bb35hQvEEHXW32E8=;
        b=QMI2DJ4RQjHBBXaJvecqThDfap0jKAAJ2z9Xi4Zy/Lvp8ORriBzwY5FVJlIy4yiJ2s
         0TN2vgc4TNva/oyRklbmsRHh0cikBJy6plDIFwzb/ASLS/Av8sFXrYM2d6DUStKjjcXO
         krol1r7bgJ0gZXiz/mrbPwTK6pEE0dQh3gzjaols98ky0One/GlFz01K96RhI+a3LRbg
         dQuueXcjJbPavyNOB9zwTM0XBg0O9oqGsS6hDr9cXS92i1qwB+czq22gra6Y7vS3LDOL
         BdsE+sRqiWIuBHdtaeWBfpWExISfjAEzbOBirWUph5VrGrMODHfeKqUsQCuWwE0aDF7Q
         7Ujw==
X-Gm-Message-State: AGi0PuZ4QZRlFzSNTbW/azA4b9TB4XEGm27mEigUHy2kjZw/b2dYdZBK
        rma8zCXnKCf09SyDyrkVJq+F8bkM
X-Google-Smtp-Source: APiQypK1F5fbVax9CGWtjzQRuJBT2Hw7yUSMPC5lmF/L4Y3HqqdWZlx6TOuavPljM7ghvxYfRlCK1Q==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr4886265wrr.10.1588347030667;
        Fri, 01 May 2020 08:30:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm4609995wrt.93.2020.05.01.08.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:30:30 -0700 (PDT)
Message-Id: <pull.622.git.1588347029.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 May 2020 15:30:17 +0000
Subject: [PATCH 00/12] Integrating line-log and changed-path Bloom filters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     peff@peff.net, me@ttaylorr.com, garimasigit@gmail.com,
        szeder.dev@gmail.com, jnareb@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The best way to learn how a feature works is to build on it. That's also the
best way to find defects.

I started on this patch series with two goals:

 1. Understand and submit Szeder's incremental line-log RFC [1].
 2. Integrate changed-path Bloom filters with line-log.

[1] https://lore.kernel.org/git/20190818182801.7580-1-szeder.dev@gmail.com/

Since I knew a lot about the Bloom filters and not much about line-log.c, I
expected to learn a lot that could contribute to improving Szeder's patches.
Instead, I discovered some deficiencies in the Bloom filter code, including
a few meaningful bugs that should be fixed before the topic is merge to
master.

This series is organized as follows:

 * Patches 1-4 are minor Bloom filter cleanups, including a documentation
   bug.
   
   
 * Patch 5 fixes a problem where the Bloom filters use much larger filters
   than expected.
   
   
 * Patch 6 fixes a bug related to the short-circuit of large diffs from
   e369698016 (diff: halt tree-diff early after max_changes, 2020-03-30).
   The condition for halting the diff computation is different than the
   check in bloom.c to see if that short-circuit was hit, which leads to
   some commits with large diffs getting an incomplete Bloom filter. This
   happened on the root commit of the Linux kernel repo, for example.
   
   
 * Patches 7-11 are Szeder's RFC, with my sign-off added. I have not changed
   the code from those submissions because I didn't find anything wrong with
   them as I was testing. However, I will take responsibility to respond to
   the feedback in this series.
   
   
 * Patch 12 integrates Bloom filters with the line-log code.
   
   

I organized these patches so patches 1-6 could be split into its own topic,
if beneficial to take earlier than the line-log changes.

The end result of this combined effort is the following: git log -L commands
feel much more responsive to a terminal user because Szeder's changes make
the computation incremental, and they have better end-to-end performance
because of the integration with Bloom filters to reduce time spent running
tree diffs for TREESAME commits.

The following table is also in patch 12, but it summarizes the results of
this series. These are timings for running git log -L 1,10:$path for these
recently-edited paths. The "Entire History" columns wait for the full
command to complete. The "First Result" columns add "-n 1" to the command,
so we see the benefits of the incremental algorithm. Thus, the performance
improvements from "Entire History" to "First Result" are due entirely to
Szeder's patches. The performance improvements from "Before" to "After" are
due to the changed-path Bloom filters.

|                              | Entire History  | First Result    |
| Path                         | Before | After  | Before | After  |
|------------------------------|--------|--------|--------|--------|
| MAINTAINERS                  | 4.26 s | 3.87 s | 0.41 s | 0.39 s |
| fs/namei.c                   | 1.99 s | 0.99 s | 0.42 s | 0.21 s |
| arch/x86/kvm/cpuid.c         | 5.28 s | 1.12 s | 0.16 s | 0.09 s |
| fs/io_uring.c                | 4.34 s | 0.99 s | 0.94 s | 0.27 s |
| arch/x86/kvm/vmx/vmx.c       | 5.01 s | 1.34 s | 0.21 s | 0.12 s |
| arch/x86/kvm/x86.c           | 2.24 s | 1.18 s | 0.21 s | 0.14 s |
| fs/btrfs/disk-io.c           | 1.82 s | 1.01 s | 0.06 s | 0.05 s |
| Documentation/scsi/index.rst | 3.30 s | 0.89 s | 1.46 s | 0.03 s |

Some splashy numbers include a 110x speedup for finding the first result for
Documentation/scsi/index.rst. That's certainly an outlier, but the rest have
an at least 10x speedup.

Thanks, -Stolee

Derrick Stolee (7):
  bloom: fix whitespace around tab length
  test-bloom: fix usage typo
  Documentation: changed-path Bloom filters use byte words
  bloom: de-duplicate directory entries
  bloom: parse commit before computing filters
  bloom: use num_changes not nr for limit detection
  line-log: integrate with changed-path Bloom filters

SZEDER Gábor (5):
  completion: offer '--(no-)patch' among 'git log' options
  line-log: remove unused fields from 'struct line_log_data'
  t4211-line-log: add tests for parent oids
  line-log: more responsive, incremental 'git log -L'
  line-log: try to use generation number-based topo-ordering

 .../technical/commit-graph-format.txt         |  8 +--
 bloom.c                                       | 61 ++++++++++++-----
 bloom.h                                       |  5 +-
 contrib/completion/git-completion.bash        |  1 +
 line-log.c                                    | 43 +++++++++++-
 line-log.h                                    |  5 +-
 revision.c                                    | 43 ++++++++++--
 t/helper/test-bloom.c                         |  2 +-
 t/t0095-bloom.sh                              |  6 +-
 t/t4211-line-log.sh                           | 68 +++++++++++++++++++
 10 files changed, 201 insertions(+), 41 deletions(-)


base-commit: 1b4c57fa87e121f155863f898dc39d06cf4a1d99
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-622%2Fderrickstolee%2Flog-l-on-bloom-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-622/derrickstolee/log-l-on-bloom-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/622
-- 
gitgitgadget
