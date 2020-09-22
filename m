Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2505C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A842076E
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="z19vFTFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIVWuV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 18:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbgIVWuV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 18:50:21 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ED9C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c2so1319930qkf.10
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmGXBTDOzMg6GWsgAQUs3j0wteQQ5xMz7xDHIDA+7qw=;
        b=z19vFTFCg8PKyF0tHGkpxDb+J47WpnN1ljfqGR6+UzIKqqIn4xGQhGywKcb8qFnW/F
         QNpRKj/OWOHy+TmrtVc78ZKKBdcL/kB911EUJKv0EoO0sRCKyKm5RNsnzAYVS1qN87H1
         f4R+RO+Qyuc9rR0a+OsSHOw5H0Uq9BXtFQxJjNXD89Uo9Yub4nDH7zDxeaQM/qRDbbi+
         Nd6W12xSqwSD/ivmdS27meEY/oNIRsoEISZFM/Fcm2VGpaxdCDtHVDiEHK6YOZ82L3v8
         /VDQrrusxfbAfTgOAxbeIYkKP4DrbZPOwtVaCEwzXQ0SFiipCJj7qqUTh714x5SvsQMx
         7Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmGXBTDOzMg6GWsgAQUs3j0wteQQ5xMz7xDHIDA+7qw=;
        b=pdBU7BV4O/PZ0N/4em6uj+1DJButMRMeHneZxs314ifuXb4nhxkVHjOtceW/d6A1PY
         p1x5pziBvBY5peJRxyl6o1HVYV2BSCY0+sbeEa70MjldKpWAdtdaQlEoZGSO7D54zmcX
         qMBneli7BLwGf9+IdZQQ57CBYlSwzLYW9Ks7nR7aRBOTAyzDg/dSOmZiQ3FiD+cQoiFv
         ARz1dyJvA2EoLmYpiwvhn6L+ZiwVBCHReNkbtOGuolmd2oWgKBt5OUHwYcD5KgmBxRPf
         JRtkFsx7k9zyAzO7gMEwZUbiC5eAaKcXEFcf7cIZc0ZCBZ9SusW8y7Sgu6LlwVas+DOA
         RnFg==
X-Gm-Message-State: AOAM533Roc3ZRMj3M3GuN3NDfnXL/sjRrPp14DSaQ4VpPLF2vWC44aN0
        TFDgc9cVvOULYFEcj+gTdfrXbsPAgUZzQA==
X-Google-Smtp-Source: ABdhPJy8kb8GIb8N2xU+8CGEdjl+I+qW2HBklZZ6sYu4sFWlcWWzcGbXqAJ+FwoZGRBDNHViG/864A==
X-Received: by 2002:a37:638d:: with SMTP id x135mr7481407qkb.60.1600815019513;
        Tue, 22 Sep 2020 15:50:19 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.96.45])
        by smtp.gmail.com with ESMTPSA id p187sm12342359qkd.129.2020.09.22.15.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:50:18 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, chriscool@tuxfamily.org, peff@peff.net,
        t.gummerer@gmail.com, newren@gmail.com
Subject: [PATCH v2 00/19] Parallel Checkout (part I)
Date:   Tue, 22 Sep 2020 19:49:14 -0300
Message-Id: <cover.1600814153.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series adds helper workers to checkout, parallelizing the reading,
filtering and writing of multiple blobs to the working tree.

Since v1, I got the chance to benchmark parallel checkout in more
machines. The results showed that the parallelization is most effective
with repositories located on SSDs or over distributed file systems. For
local file systems on spinning disks, it does not always bring good
performances. In fact, it even brings a slowdown sometimes. But given
the results on the two first cases, I think it's worth having the
parallel code as an optional (and non-default) setting.

The size of the repository being checked out and the compression level
on the packfiles also influence how much performance gain we can get
from parallel checkout. For example, downloading the Linux repo from
GitHub and from kernel.org I got packfiles with 2.9GB and 1.4GB,
respectively. The number of objects was the same, but GitHub's had a
smaller number of delta-chains with size >= 7 [A]. For this reason, the
sequential checkout after GitHub's clone was considerably faster than
the sequential checkout after kernel.org's clone. And the speedup from
parallel checkout was more modest (but it was faster in absolute values,
nevertheless).

[A]: https://docs.google.com/spreadsheets/d/1dDGLym77JAGCVYhKQHe44r3pqtrsvHrjS4NmD_Hqr6k/edit?usp=sharing

V2 got bigger with tests and some additional optimizations, so I decided
to divide the original series into two parts to facilitate reviewing.
This one is constituted of:

- The first 9 patches are preparatory steps in convert.c and entry.c.
- The middle 6 actually implement parallel checkout.
- The last 4 add tests.

Part II will contain some extra optimizations, like work stealing and
the creation of leading directories in parallel. With that, workers
won't need to stat() the path components again before opening the files
for writing. We will also skip some stat() calls during clone.


Major changes since v1:

General:
- Added tests
- Parallel checkout is no longer the default, since not all machines
  benefit from it.
- Rebased on top of master to use the adjusted mem_pool API of
  en/mem-pool.

Patch 10:
- Converted BUG() to error(), in handle_results(), when we finish
  parallel checkout with pending entries. This is not really a BUG; it
  can happen when a worker dies before sending all of its results. Also,
  by emitting an error message instead of die()'ing, we can continue
  processing the next results and, thus, avoid wasting successful work.
- Added missing initialization of ci->status on enqueue_entry().
- Fixed bug on which collision report during clone would not be correct
  when the file that is first written appears after it's colliding pair
  in the cache array.
- Reworded commit message and added comment in handle_results() to
  explain why we retry writing entries with path collisions.
- Renamed CI_RETRY to CI_COLLISION, to make it easier to change the
  behavior on collided entries in the future, if necessary.
- Some other minor changes like:
  * Removed unnecessary PC_HANDLING_RESULTS status.
  * Statically allocated the global parallel_checkout struct.
  * Renamed checkout_item to parallel_checkout_item.

Patch 11:
- Made parse_and_save_result() safer by checking that the received data
  has the expected size, instead of trusting ci->status and possibly
  accessing an invalid address on errors.
- Limited the workers to the number of enqueued entries.
- Added comment in packet_to_ci() mentioning why it's OK to encode
  NULL as a zero length string when sending the working_tree_encoding to
  workers.
- Split subprocess' spawning and finalizing loops, to mitigate the
  spawn/wait cost.
- Don't die() when a worker exits with an error code (only report the
  error), to avoid wasting good work by not updating the index with the 
  stat information from the written entries.
- Renamed checkout.workersThreshold to checkout.thresholdForParallelism.


Jeff Hostetler (4):
  convert: make convert_attrs() and convert structs public
  convert: add [async_]convert_to_working_tree_ca() variants
  convert: add get_stream_filter_ca() variant
  convert: add conv_attrs classification

Matheus Tavares (15):
  entry: extract a header file for entry.c functions
  entry: make fstat_output() and read_blob_entry() public
  entry: extract cache_entry update from write_entry()
  entry: move conv_attrs lookup up to checkout_entry()
  entry: add checkout_entry_ca() which takes preloaded conv_attrs
  unpack-trees: add basic support for parallel checkout
  parallel-checkout: make it truly parallel
  parallel-checkout: support progress displaying
  make_transient_cache_entry(): optionally alloc from mem_pool
  builtin/checkout.c: complete parallel checkout support
  checkout-index: add parallel checkout support
  parallel-checkout: add tests for basic operations
  parallel-checkout: add tests related to clone collisions
  parallel-checkout: add tests related to .gitattributes
  ci: run test round with parallel-checkout enabled

 .gitignore                              |   1 +
 Documentation/config/checkout.txt       |  21 +
 Makefile                                |   2 +
 apply.c                                 |   1 +
 builtin.h                               |   1 +
 builtin/checkout--helper.c              | 142 ++++++
 builtin/checkout-index.c                |  17 +
 builtin/checkout.c                      |  21 +-
 builtin/difftool.c                      |   3 +-
 cache.h                                 |  34 +-
 ci/run-build-and-tests.sh               |   1 +
 convert.c                               | 121 +++--
 convert.h                               |  68 +++
 entry.c                                 | 102 ++--
 entry.h                                 |  54 ++
 git.c                                   |   2 +
 parallel-checkout.c                     | 631 ++++++++++++++++++++++++
 parallel-checkout.h                     | 103 ++++
 read-cache.c                            |  12 +-
 t/README                                |   4 +
 t/lib-encoding.sh                       |  25 +
 t/lib-parallel-checkout.sh              |  45 ++
 t/t0028-working-tree-encoding.sh        |  25 +-
 t/t2080-parallel-checkout-basics.sh     | 197 ++++++++
 t/t2081-parallel-checkout-collisions.sh | 116 +++++
 t/t2082-parallel-checkout-attributes.sh | 174 +++++++
 unpack-trees.c                          |  22 +-
 27 files changed, 1793 insertions(+), 152 deletions(-)
 create mode 100644 builtin/checkout--helper.c
 create mode 100644 entry.h
 create mode 100644 parallel-checkout.c
 create mode 100644 parallel-checkout.h
 create mode 100644 t/lib-encoding.sh
 create mode 100644 t/lib-parallel-checkout.sh
 create mode 100755 t/t2080-parallel-checkout-basics.sh
 create mode 100755 t/t2081-parallel-checkout-collisions.sh
 create mode 100755 t/t2082-parallel-checkout-attributes.sh

-- 
2.28.0

