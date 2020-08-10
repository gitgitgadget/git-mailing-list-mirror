Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9685DC433E0
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610FC206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="okIUFawm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgHJVeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVeP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:34:15 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FE4C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id m7so9828996qki.12
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpZGhODEb3xIoFDiKLVjEsRV0ddQMQvR6hzNeQLJHFs=;
        b=okIUFawmWwTIuZYsQvrPc4zQ64sWr2zuFZLvSX0Sm6jmgRSE/IRV87DPG5e69qm0ye
         M5HncKagMU6inf25aCAB8Nrxde1RJtqOcaKy3r72KmwAUuBb0ccsT1eZZ24ZdXCE0GWF
         DXovIrchtC8BK1H+FCbsHBfxRUWHcXlD998eWarm5cxEsrjHl/ESzx+ePtzNpw7rGaGu
         p2ChIwPBEPCyx/owECztDiEd7p/LdKSi/z8DvEOj2ESEje5qKn1gzSDlNNC3nAwBWDpT
         T1guGprNRmflARVnu6dT8JKdEHlBB/qFtJ9msiesUQwSelTP3DHhJjPhRbjJ73J24ePK
         XbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GpZGhODEb3xIoFDiKLVjEsRV0ddQMQvR6hzNeQLJHFs=;
        b=g8iv1Bmh202TBH3Fa750yWdnyp9wALaxO8iKfrrXgATdlMsCyNfuW4mEkNI0cPXFu9
         IQVp4FNZc+E9prxbwxESXcXLbyYTx8llAoaxrQULYmEdnYFVO/h5PVhW6luzEhuqdmgA
         euqi7IedIzZH+9hN4XJGpn3LEVK4Xwjxpd5nrS71WAL6aI2QWXyvMlTLiZWqlzi3BU4+
         oPOXKc0Fw6IR13kBl8jKhKHSNJnzTDWyh+mw959lnzMHl3JPNlBKqRphhtQ+iE6gOTyq
         ZAfJcQPBphVZXX+CpdUugy08Iknqfze8il4Yd6KtFiQ3C4aGUKOymudMODGsdcVXITRB
         75ew==
X-Gm-Message-State: AOAM533BBPoQ3ZzlVuQlvR/jO3wfBW4N+dQZ2i+/mfCEM1Ylo8FbunTr
        nJtb6P0hy6i3lLmsgSD1c2xr1KW/RbA=
X-Google-Smtp-Source: ABdhPJxHIgTo4/SkHIcw3/jLH60hNlPG6WuqmPT8x2q+ai2mMW7lD7IGD8IC9gMmh9o+Xk8f13PUKg==
X-Received: by 2002:a37:850:: with SMTP id 77mr10567246qki.90.1597095253431;
        Mon, 10 Aug 2020 14:34:13 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:12 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com
Subject: [RFC PATCH 00/21] [RFC] Parallel checkout 
Date:   Mon, 10 Aug 2020 18:33:08 -0300
Message-Id: <cover.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds parallel workers to the checkout machinery. The cache
entries are distributed among helper processes which are responsible for
reading, filtering and writing the blobs to the working tree. This
should benefit all commands that call unpack_trees() or check_updates(),
such as: checkout, clone, sparse-checkout, checkout-index, etc.

This proposal is based on two previous ones, by Duy [1] and Jeff [2]. It
uses some of the patches from these two series, with additional changes.
The final parallel version was benchmarked during three operations with
cold cache in the linux repo: cloning v5.8, checking out v5.8 from
v2.6.15 and checking out v5.8 from v5.7. The three tables below show the
mean run times and standard deviations for 5 runs in: a local file
system, a Linux NFS server and Amazon EFS. The number of workers was
chosen based on what produces the best result for each case.

Local:

            Clone                  Checkout I             Checkout II
Sequential  8.180 s ± 0.021 s      6.936 s ± 0.030 s      2.585 s ± 0.005 s
10 workers  3.406 s ± 0.187 s      2.164 s ± 0.033 s      1.050 s ± 0.021 s
Speedup     2.40 ± 0.13            3.21 ± 0.05            2.46 ± 0.05

Linux NFS server (v4.1, on EBS, single availability zone):

            Clone                  Checkout I             Checkout II
Sequential  208.069 s ± 2.522 s    198.610 s ± 1.979 s    54.376 s ± 1.333 s
32 workers  58.170 s ± 0.648 s     56.471 s ± 0.093 s     22.311 s ± 0.220 s
Speedup     3.58 ± 0.06            3.52 ± 0.04            2.44 ± 0.06

EFS (v4.1, replicated over multiple availability zones):

            Clone                  Checkout I             Checkout II
Sequential  1143.655 s ± 11.819 s  1277.891 s ± 10.481 s  396.891 s ± 7.505 s
64 workers  94.778 s ± 4.984 s     201.674 s ± 2.286 s    149.951 s ± 12.895 s
Speedup     12.07 ± 0.65           6.34 ± 0.09            2.65 ± 0.23


I also repeated the local benchmark tests including pc-p4-core [2], to
make sure the new proposal doesn't have performance regressions:

            Clone                  Checkout I             Checkout II
pc-p4-core  3.746 s ± 0.044 s      3.158 s ± 0.041 s      1.597 s ± 0.019 s
10 workers  3.595 s ± 0.111 s      2.263 s ± 0.027 s      1.098 s ± 0.023 s
Speedup     1.04 ± 0.03            1.40 ± 0.02            1.45 ± 0.04


The series is divided in three blocks:

- The first 9 patches are preparatory steps in convert.c and entry.c.
- The middle 7 actually implement parallel checkout.
- The last 5 are ideas for further optimization of the parallel version.
  They don't bring a huge difference in local file systems (e.g. linux
  clone is only 1.04x faster than the previous parallel code), but in
  distributed file systems, there is a significant difference: 1.15x
  faster in NFS and 1.83x faster in Amazon EFS. (For comparison, the
  timings before these additional patches can be seen in the commit
  message of patch 11.)

The first 4 patches come from [2]. I couldn't get in touch with Jeff yet
and ask for his approval on then, so I didn't include his Signed-off-by,
for the time being.

Note: we probably want to add some extra validation and perf tests. But,
for now, parallel checkout is enabled by default in this series (with no
threshold on the minimum number of entries), so the test base is already
exercising the parallel code. (see [3])

There are some additional optimization possibilities I want to
experiment with later, such as:
- Work stealing, to better re-distribute tasks in case of non-uniform
  work loads. Duy already proposed a way to implement this in his
  original series.
- Add a --stat option to checkout--helper, to avoid calling stat() when
  state.refresh_cache is false.
- Try to detect when a repository is in NFS/EFS to automatically use a
  higher number of workers, as this showed out to be very effective in
  distributed file systems.

[1]: https://gitlab.com/pclouds/git/-/commits/parallel-checkout
[2]: https://github.com/jeffhostetler/git/commits/pc-p4-core
[3]: https://github.com/matheustavares/git/actions/runs/203036951 

----
Notes on the benchmarks:

Local tests were executed in an i7-7700HQ (4 cores with hyper-threading)
running Manjaro Linux, with SSD. NFS and EFS tests were executed in an
Amazon EC2 c5n.large instance, with 2 vCPUs. The Linux NFS server was
running on a m6g.large instance with 1 TB, EBS GP2 volume. For
pc-p4-core tests, I used the set of parameters that resulted in the
fasted mean execution (of 5 runs) on my machine, which was:
- For clone: async mode, 22 helpers, 2 writers, 10 preloading slots
- For checkout I: async mode, 20 helpers, 2 writers, 20 preloading slots
- For checkout II: sync mode, 4 helpers, 2 writers, 30 preloading slots


Jeff Hostetler (4):
  convert: make convert_attrs() and convert structs public
  convert: add [async_]convert_to_working_tree_ca() variants
  convert: add get_stream_filter_ca() variant
  convert: add conv_attrs classification

Matheus Tavares (17):
  entry: extract a header file for entry.c functions
  entry: make fstat_output() and read_blob_entry() public
  entry: extract cache_entry update from write_entry()
  entry: move conv_attrs lookup up to checkout_entry()
  entry: add checkout_entry_ca() which takes preloaded conv_attrs
  unpack-trees: add basic support for parallel checkout
  parallel-checkout: make it truly parallel
  parallel-checkout: add configuration options
  parallel-checkout: support progress displaying
  make_transient_cache_entry(): optionally alloc from mem_pool
  builtin/checkout.c: complete parallel checkout support
  checkout-index: add parallel checkout support
  parallel-checkout: avoid stat() calls in workers
  entry: use is_dir_sep() when checking leading dirs
  symlinks: make has_dirs_only_path() track FL_NOENT
  parallel-checkout: create leading dirs in workers
  parallel-checkout: skip checking the working tree on clone

 .gitignore                        |   1 +
 Documentation/config/checkout.txt |  16 +
 Makefile                          |   2 +
 apply.c                           |   1 +
 builtin.h                         |   1 +
 builtin/checkout--helper.c        | 135 +++++++
 builtin/checkout-index.c          |  17 +
 builtin/checkout.c                |  21 +-
 builtin/difftool.c                |   3 +-
 cache.h                           |  35 +-
 convert.c                         | 121 +++---
 convert.h                         |  68 ++++
 entry.c                           | 180 +++++++--
 entry.h                           |  54 +++
 git.c                             |   2 +
 parallel-checkout.c               | 611 ++++++++++++++++++++++++++++++
 parallel-checkout.h               | 103 +++++
 read-cache.c                      |  12 +-
 symlinks.c                        |  42 +-
 unpack-trees.c                    |  24 +-
 20 files changed, 1292 insertions(+), 157 deletions(-)
 create mode 100644 builtin/checkout--helper.c
 create mode 100644 entry.h
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h

-- 
2.27.0

