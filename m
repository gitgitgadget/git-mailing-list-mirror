Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14FA120133
	for <e@80x24.org>; Thu,  2 Mar 2017 08:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753969AbdCBI1p (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 03:27:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:37041 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdCBI1o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 03:27:44 -0500
Received: (qmail 22531 invoked by uid 109); 2 Mar 2017 08:21:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 08:21:02 +0000
Received: (qmail 15182 invoked by uid 111); 2 Mar 2017 08:21:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 03:21:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 03:21:00 -0500
Date:   Thu, 2 Mar 2017 03:21:00 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2] fixing corner-cases with interpret_branch_name()
Message-ID: <20170302082100.edaretznmlralswa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of the series from:

  http://public-inbox.org/git/20170228120633.zkwfqms57fk7dkl5@sigill.intra.peff.net/

Thanks Junio and Jake for reviewing the original. This is mostly the
same, but:

  - it fixes the case where "branch -r @{-1}" mistakes a local branch
    for a remote (and adds a test)

  - as a result of the above fix, the series needs to be applied on top
    of jk/auto-namelen-in-interpret-branch-name.

  - I clarified the history in the commit message of patch 4

  - the commit message for patch 4 now explicitly mentions which
    callers can be left alone (so anybody blaming the history won't
    think they were simply forgotten).

With the exception of patch 6 flipping the failure/success bit on the
new test, the rest of the patches should be identical.

  [1/8]: interpret_branch_name: move docstring to header file
  [2/8]: strbuf_branchname: drop return value
  [3/8]: strbuf_branchname: add docstring
  [4/8]: interpret_branch_name: allow callers to restrict expansions
  [5/8]: t3204: test git-branch @-expansion corner cases
  [6/8]: branch: restrict @-expansions when deleting
  [7/8]: strbuf_check_ref_format(): expand only local branches
  [8/8]: checkout: restrict @-expansions when finding branch

 builtin/branch.c                      |   5 +-
 builtin/checkout.c                    |   2 +-
 builtin/merge.c                       |   2 +-
 cache.h                               |  32 +++++++-
 refs.c                                |   2 +-
 revision.c                            |   2 +-
 sha1_name.c                           |  92 ++++++++++++-----------
 strbuf.h                              |  21 +++++-
 t/t3204-branch-name-interpretation.sh | 133 ++++++++++++++++++++++++++++++++++
 9 files changed, 240 insertions(+), 51 deletions(-)
 create mode 100755 t/t3204-branch-name-interpretation.sh

-Peff
