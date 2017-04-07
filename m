Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A8A8209F1
	for <e@80x24.org>; Fri,  7 Apr 2017 21:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756752AbdDGVVB (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 17:21:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:57581 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756740AbdDGVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 17:20:58 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 22175845E7;
        Fri,  7 Apr 2017 17:20:56 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v7 0/3] read-cache: speed up add_index_entry
Date:   Fri,  7 Apr 2017 21:20:44 +0000
Message-Id: <20170407212047.64950-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 7 addresses size_t and casting issues in strcmp_offset()
and replaces shell test function with an awk expression to make
the perf test run faster.

================
Teach add_index_entry_with_check() and has_dir_name()
to avoid index lookups if the given path sorts after
the last entry in the index.

This saves at least 2 binary searches per entry.

This improves performance during checkout and read-tree because
merge_working_tree() and unpack_trees() processes a list of already
sorted entries.

Jeff Hostetler (3):
  read-cache: add strcmp_offset function
  p0004-read-tree: perf test to time read-tree
  read-cache: speed up add_index_entry during checkout

 Makefile                      |   1 +
 cache.h                       |   1 +
 read-cache.c                  |  66 +++++++++++++++++++++++-
 t/helper/.gitignore           |   1 +
 t/helper/test-strcmp-offset.c |  64 +++++++++++++++++++++++
 t/perf/p0004-read-tree.sh     | 117 ++++++++++++++++++++++++++++++++++++++++++
 t/t0065-strcmp-offset.sh      |  11 ++++
 7 files changed, 259 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-strcmp-offset.c
 create mode 100755 t/perf/p0004-read-tree.sh
 create mode 100755 t/t0065-strcmp-offset.sh

-- 
2.9.3

