Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56BA22018E
	for <e@80x24.org>; Thu, 18 Aug 2016 00:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbcHRAvi (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 20:51:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:55933 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934AbcHRAvf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 20:51:35 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 17 Aug 2016 17:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,536,1464678000"; 
   d="scan'208";a="157475887"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.116])
  by fmsmga004.fm.intel.com with ESMTP; 17 Aug 2016 17:51:32 -0700
From:	Jacob Keller <jacob.e.keller@intel.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v7 0/7] implement inline submodule diff format
Date:	Wed, 17 Aug 2016 17:51:24 -0700
Message-Id: <20160818005131.31600-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.10.0.rc0.217.g609f9e8.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

As suggested by Junio, I broke this patch into several pieces, and
made a common helper function for the submodule header. Note that there
are a couple of complicated modifications to the submodule header
portion which (should) still result in the same header but allow the
diff format a bit better control. It's a bit awkward but it does pass
all the current tests, and the format between the two should be similar.

I tried to break apart the patches properly, so I hope I didn't
accidentally munge them too badly.

Jacob Keller (6):
  graph: add support for --line-prefix on all graph-aware output
  diff: prepare for additional submodule formats
  submodule: allow do_submodule_path to work if given gitdir directly
  submodule: correct output of submodule log format
  submodule: refactor show_submodule_summary with helper function
  diff: teach diff to display submodule difference with an inline diff

Junio C Hamano (1):
  diff.c: remove output_prefix_length field

 Documentation/diff-config.txt                      |   9 +-
 Documentation/diff-options.txt                     |  20 +-
 builtin/rev-list.c                                 |  70 +-
 diff.c                                             |  52 +-
 diff.h                                             |  11 +-
 graph.c                                            | 106 +--
 graph.h                                            |  22 +-
 log-tree.c                                         |   5 +-
 path.c                                             |   4 +-
 submodule.c                                        | 162 ++++-
 submodule.h                                        |   6 +
 t/t4013-diff-various.sh                            |   6 +
 ...diff.diff_--line-prefix=abc_master_master^_side |  29 +
 t/t4013/diff.diff_--line-prefix_--cached_--_file0  |  15 +
 t/t4059-diff-submodule-option-diff-format.sh       | 733 +++++++++++++++++++++
 t/t4202-log.sh                                     | 323 +++++++++
 16 files changed, 1432 insertions(+), 141 deletions(-)
 create mode 100644 t/t4013/diff.diff_--line-prefix=abc_master_master^_side
 create mode 100644 t/t4013/diff.diff_--line-prefix_--cached_--_file0
 create mode 100755 t/t4059-diff-submodule-option-diff-format.sh

-- 
2.10.0.rc0.217.g609f9e8.dirty

