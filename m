Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07DB720970
	for <e@80x24.org>; Fri, 14 Apr 2017 19:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755428AbdDNTMm (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 15:12:42 -0400
Received: from siwi.pair.com ([209.68.5.199]:30395 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754765AbdDNTMl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 15:12:41 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 70CAD845C3;
        Fri, 14 Apr 2017 15:12:39 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v10 0/3] read-cache: speed up add_index_entry
Date:   Fri, 14 Apr 2017 19:12:27 +0000
Message-Id: <20170414191230.52825-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 10 addresses mailing list comments on coding style in
read-cache.c and in p0006.  I've also adjusted the speed-up
algorithm and more thoroughly documented the cases in the code.

We skip the binary searches whenever we can prove that the new
entry (and every sub-directory prefix of the entry) clearly
FOLLOWS the last entry in the index.  Otherwise, we fall through
to the existing search algorithm -- which handles stages and
CE_REMOVE entries.

Jeff Hostetler (3):
  read-cache: add strcmp_offset function
  p0006-read-tree-checkout: perf test to time read-tree
  read-cache: speed up add_index_entry during checkout

 Makefile                           |   1 +
 cache.h                            |   1 +
 read-cache.c                       | 138 ++++++++++++++++++++++++++++++++++++-
 t/helper/.gitignore                |   1 +
 t/helper/test-strcmp-offset.c      |  22 ++++++
 t/perf/p0006-read-tree-checkout.sh |  67 ++++++++++++++++++
 t/perf/repos/.gitignore            |   1 +
 t/perf/repos/many-files.sh         | 110 +++++++++++++++++++++++++++++
 t/t0065-strcmp-offset.sh           |  21 ++++++
 9 files changed, 360 insertions(+), 2 deletions(-)
 create mode 100644 t/helper/test-strcmp-offset.c
 create mode 100755 t/perf/p0006-read-tree-checkout.sh
 create mode 100644 t/perf/repos/.gitignore
 create mode 100755 t/perf/repos/many-files.sh
 create mode 100755 t/t0065-strcmp-offset.sh

-- 
2.9.3

