Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09770203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 19:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbcGYT2o (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 15:28:44 -0400
Received: from siwi.pair.com ([209.68.5.199]:44196 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbcGYT2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 15:28:43 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 21C3984607;
	Mon, 25 Jul 2016 15:28:40 -0400 (EDT)
From:	Jeff Hostetler <jeffhost@microsoft.com>
To:	git@vger.kernel.org
Cc:	git@jeffhostetler.com, peff@peff.net, gitster@pobox.com,
	jeffhost@microsoft.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v2 0/8] status: V2 porcelain status
Date:	Mon, 25 Jul 2016 15:25:42 -0400
Message-Id: <1469474750-49075-1-git-send-email-jeffhost@microsoft.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch series adds porcelain V2 format to status.
This provides detailed information about file changes
and about the current branch.

The new output is accessed via:
    git status --porcelain=v2 [--branch]

This patch series hopefully addresses all of the
comments from the previous series.  The first 2
commits move the choice of output routines into
wt-status.c and cleanup the API from builtin/commit.c.
The command line parameter is "v2" to make it easier
to define other formats and/or JSON output later if
we want.  Detail lines for ordinary changes and
unmerged changes are now completely separate and have
a unique prefix key (and are grouped by type).  The
unit tests have been converted to use heredoc's.

I removed the v2 argument from git commit --porcelain
since it didn't really fit here.

Jeff Hostetler (8):
  status: rename long-format print routines
  status: cleanup API to wt_status_print
  status: support --porcelain[=<version>]
  status: per-file data collection for --porcelain=v2
  status: print per-file porcelain v2 status data
  status: print branch info with --porcelain=v2 --branch
  status: update git-status.txt for --porcelain=v2
  status: tests for --porcelain=v2

 Documentation/git-status.txt |  90 ++++++-
 builtin/commit.c             |  78 +++---
 t/t7060-wtstatus.sh          |  21 ++
 t/t7064-wtstatus-pv2.sh      | 542 +++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 616 +++++++++++++++++++++++++++++++++++++++----
 wt-status.h                  |  32 ++-
 6 files changed, 1269 insertions(+), 110 deletions(-)
 create mode 100755 t/t7064-wtstatus-pv2.sh

-- 
2.8.0.rc4.17.gac42084.dirty

