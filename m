Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D341F404
	for <e@80x24.org>; Wed, 20 Dec 2017 14:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755292AbdLTOm5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 09:42:57 -0500
Received: from siwi.pair.com ([209.68.5.199]:15133 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754664AbdLTOm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 09:42:56 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2A8C2845D6;
        Wed, 20 Dec 2017 09:42:55 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B5E85845D4;
        Wed, 20 Dec 2017 09:42:54 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 0/4] Add --no-ahead-behind to status
Date:   Wed, 20 Dec 2017 14:42:41 +0000
Message-Id: <20171220144245.39401-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This patch series adds a "--no-ahead-behind" option to status
to request that it avoid a possibly expensive ahead/behind
computation for the current branch.  Instead, it just prints a
not up to date message in place of the detailed counts.

This idea was previously discussed in [1].  Working with the
enormous Windows repository, we found that 20+ seconds was being
spent in the ahead/behind computation when the current branch was
150K commits behind the upstream branch.  (Yes, this happens and
only took 3 weeks on the reporter's system.)


I've only modified "git status" in this patch series.  A similar
change could be added to "git branch -vv" and "git checkout" to
avoid delays there too.  I avoided doing it here to keep this
patch series focused.


[1] https://public-inbox.org/git/030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com/T/

Jeff Hostetler (4):
  status: add --no-ahead-behind to porcelain V2
  stat_tracking_info: return +1 when branch and upstream differ
  status: update short status to use --no-ahead-behind
  status: support --no-ahead-behind in long status format.

 Documentation/config.txt     |  5 +++++
 Documentation/git-status.txt | 16 ++++++++++++++++
 builtin/checkout.c           |  2 +-
 builtin/commit.c             |  6 ++++++
 ref-filter.c                 |  4 ++--
 remote.c                     | 36 ++++++++++++++++++++++++++++--------
 remote.h                     |  4 +++-
 t/t6040-tracking-info.sh     | 42 ++++++++++++++++++++++++++++++++++++++++++
 t/t7064-wtstatus-pv2.sh      | 23 +++++++++++++++++++++++
 wt-status.c                  | 24 ++++++++++++++++++++----
 wt-status.h                  |  1 +
 11 files changed, 147 insertions(+), 16 deletions(-)

-- 
2.9.3

