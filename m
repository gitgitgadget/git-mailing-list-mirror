Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16E8220970
	for <e@80x24.org>; Tue, 11 Apr 2017 19:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbdDKTRR (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 15:17:17 -0400
Received: from siwi.pair.com ([209.68.5.199]:57825 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbdDKTRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 15:17:16 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D6E44844F9;
        Tue, 11 Apr 2017 15:17:14 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v9 0/3] read-cache: speed up add_index_entry
Date:   Tue, 11 Apr 2017 19:16:59 +0000
Message-Id: <20170411191702.20134-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 9 addresses the following:
  () p0006 perf test can now run using either synthetic repos
     from t/perf/repos/many-repos.sh -OR- an actual real-world
     repo.
  () The commit message has been updated to include results of
     p0006 on linux.git.
  () Line 0006.3 shows a positive value, but results for that
     line had a lot of variance between runs.  I measured the
     blocks of code I added and they only added 0.007 to 0.015
     seconds.  I suspect the overall time difference and variance
     is due to file I/O to update the worktree when switching
     branches.

I think this version has addressed everything raise so far,
so I think I'm ready to let this one rest.  Thanks for all
the help and feedback.


Jeff Hostetler (3):
  read-cache: add strcmp_offset function
  p0006-read-tree-checkout: perf test to time read-tree
  read-cache: speed up add_index_entry during checkout

 Makefile                           |   1 +
 cache.h                            |   1 +
 read-cache.c                       |  66 +++++++++++++++++++++-
 t/helper/.gitignore                |   1 +
 t/helper/test-strcmp-offset.c      |  22 ++++++++
 t/perf/p0006-read-tree-checkout.sh |  69 +++++++++++++++++++++++
 t/perf/repos/.gitignore            |   1 +
 t/perf/repos/many-files.sh         | 110 +++++++++++++++++++++++++++++++++++++
 t/t0065-strcmp-offset.sh           |  21 +++++++
 9 files changed, 290 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-strcmp-offset.c
 create mode 100755 t/perf/p0006-read-tree-checkout.sh
 create mode 100644 t/perf/repos/.gitignore
 create mode 100755 t/perf/repos/many-files.sh
 create mode 100755 t/t0065-strcmp-offset.sh

-- 
2.9.3

