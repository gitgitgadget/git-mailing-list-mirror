Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0E4120966
	for <e@80x24.org>; Fri,  7 Apr 2017 15:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756108AbdDGPxa (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 11:53:30 -0400
Received: from siwi.pair.com ([209.68.5.199]:11136 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933728AbdDGPxT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 11:53:19 -0400
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2F58484668;
        Fri,  7 Apr 2017 11:53:18 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2] unpack-trees: avoid duplicate ODB lookups during checkout
Date:   Fri,  7 Apr 2017 15:53:05 +0000
Message-Id: <20170407155306.42375-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Version 2 simplifies this and just copies the tree_descriptor
data and borrows the underlying buffer without mallocing.  It
also handles the n=3 cases, so merges shold be helped too.

I've updated the p0004 perf times in the commit message.
The V2 changes took ~0.15 off the V1 times.  The total
reduction is ~1 second.

================
Avoid duplicate ODB lookups for trees during traverse_tree_recursive().

Jeff Hostetler (1):
  unpack-trees: avoid duplicate ODB lookups during checkout

 unpack-trees.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.9.3

