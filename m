Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB7E51F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 23:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbcHOXHK (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 19:07:10 -0400
Received: from mga14.intel.com ([192.55.52.115]:38420 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307AbcHOXHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 19:07:09 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 15 Aug 2016 16:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,527,1464678000"; 
   d="scan'208";a="1036073626"
Received: from jekeller-desk.amr.corp.intel.com ([134.134.3.116])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2016 16:07:08 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v6 0/3] Add support for displaying submodules as a proper diff
Date:	Mon, 15 Aug 2016 16:06:59 -0700
Message-Id: <20160815230702.30817-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.9.2.873.g47c31b4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This patch series adds support for displaying a submodule as a
difference between the pre and post commits. This allows projects who
frequently update submodule contents to view the submodule in the log as
if it were just one squashed commit that updates all the files in the
submodule together, even if you mix-match the submodule part with a
regular part you just see a complete diff that shows all the changes.

To make this work, I also extended the graph-aware output with a
--line-prefix option. This option extends both diff and log to show a
prefix. It's a bit of a hack in someways, but it works for showing a
prefix both when graph is enabled and when its not. I think it works
quite well.

I added several tests to the line-prefix, and also a few tests for the
new submodule format.

I welcome comments on how to improve the graph line-prefix code, as well
as the actual submodule diff format.

Jacob Keller (2):
  graph: add support for --line-prefix on all graph-aware output
  diff: add SUBMODULE_DIFF format to display submodule diff

Junio C Hamano (1):
  diff.c: remove output_prefix_length field

 Documentation/diff-config.txt                      |   3 +-
 Documentation/diff-options.txt                     |  10 +-
 builtin/rev-list.c                                 |  70 +-
 diff.c                                             |  49 +-
 diff.h                                             |  11 +-
 graph.c                                            | 105 +--
 graph.h                                            |  22 +-
 log-tree.c                                         |   5 +-
 submodule.c                                        | 130 ++++
 submodule.h                                        |   6 +
 t/t4013-diff-various.sh                            |   6 +
 ...diff.diff_--line-prefix=abc_master_master^_side |  29 +
 t/t4013/diff.diff_--line-prefix_--cached_--_file0  |  15 +
 t/t4059-diff-submodule-option-diff-format.sh       | 738 +++++++++++++++++++++
 t/t4202-log.sh                                     | 323 +++++++++
 15 files changed, 1419 insertions(+), 103 deletions(-)
 create mode 100644 t/t4013/diff.diff_--line-prefix=abc_master_master^_side
 create mode 100644 t/t4013/diff.diff_--line-prefix_--cached_--_file0
 create mode 100755 t/t4059-diff-submodule-option-diff-format.sh

-- 
2.9.2.873.g47c31b4

