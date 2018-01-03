Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6D81F406
	for <e@80x24.org>; Wed,  3 Jan 2018 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeACVrp (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 16:47:45 -0500
Received: from siwi.pair.com ([209.68.5.199]:45491 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbeACVro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 16:47:44 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F024E844DE;
        Wed,  3 Jan 2018 16:47:43 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 825FF844DC;
        Wed,  3 Jan 2018 16:47:43 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v3 0/5] Add --no-ahead-behind to status
Date:   Wed,  3 Jan 2018 21:47:28 +0000
Message-Id: <20180103214733.797-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is version 3 of my patch series to avoid expensive
ahead/behind calculations in status.  This version tries
to address most of the comments in V2.

I've switched back to a "status.aheadBehind" config setting
rather than in "core.*".  This has been better integrated
with the existing status_deferred_config mechanism in
builtin/commit.c and lets both status and commit inherit it.

Config values of true and false control non-porcelain formats
for compatibility reasons as previously discussed.  In the
last commit I added a new value of 2 for the config setting
to allow porcelain formats to inherit the new setting.  I've
marked this experimental for now or so that we can discuss
it.

Jeff Hostetler (5):
  stat_tracking_info: return +1 when branches not equal
  status: add --[no-]ahead-behind to status and commit for V2 format.
  status: update short status to respect --no-ahead-behind
  status: support --no-ahead-behind in long format
  status: add status.aheadBehind value for porcelain output

 Documentation/config.txt     | 11 ++++++
 Documentation/git-status.txt |  5 +++
 builtin/checkout.c           |  2 +-
 builtin/commit.c             | 37 +++++++++++++++++++-
 ref-filter.c                 |  8 ++---
 remote.c                     | 42 +++++++++++++++++------
 remote.h                     | 20 +++++++++--
 t/t6040-tracking-info.sh     | 82 ++++++++++++++++++++++++++++++++++++++++++++
 t/t7064-wtstatus-pv2.sh      | 73 +++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 38 +++++++++++++++-----
 wt-status.h                  |  2 ++
 11 files changed, 292 insertions(+), 28 deletions(-)

-- 
2.9.3

