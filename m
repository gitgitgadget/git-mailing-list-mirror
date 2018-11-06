Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA45C1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 07:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeKFRNI (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 12:13:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:41810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729160AbeKFRNI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 12:13:08 -0500
Received: (qmail 17602 invoked by uid 109); 6 Nov 2018 07:49:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Nov 2018 07:49:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29046 invoked by uid 111); 6 Nov 2018 07:48:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 06 Nov 2018 02:48:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Nov 2018 02:49:10 -0500
Date:   Tue, 6 Nov 2018 02:49:10 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Felix Eckhofer <felix@eckhofer.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] fix pull/merge --verify-signature on an unborn branch
Message-ID: <20181106074910.GA31978@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This bug was reported to the private security list, but I don't think
it's easily exploitable, since merging or pulling into an unborn branch
is pretty uncommon.

The root of the issue in both commands is just that we handle unborn
branches in a special code path that never learned about
--verify-signatures.

  [1/3]: merge: extract verify_merge_signature() helper
  [2/3]: merge: handle --verify-signatures for unborn branch
  [3/3]: pull: handle --verify-signatures for unborn branch

 builtin/merge.c                    | 30 +++++-------------------------
 builtin/pull.c                     | 11 +++++++++++
 commit.c                           | 26 ++++++++++++++++++++++++++
 commit.h                           |  7 +++++++
 t/t5573-pull-verify-signatures.sh  |  7 +++++++
 t/t7612-merge-verify-signatures.sh |  7 +++++++
 6 files changed, 63 insertions(+), 25 deletions(-)

-Peff
