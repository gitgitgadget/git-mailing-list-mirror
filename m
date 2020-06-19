Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2053FC433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C5F2158C
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 13:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbgFSNXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:23:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:37122 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732463AbgFSNXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 09:23:05 -0400
Received: (qmail 2677 invoked by uid 109); 19 Jun 2020 13:23:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Jun 2020 13:23:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14548 invoked by uid 111); 19 Jun 2020 13:23:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Jun 2020 09:23:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Jun 2020 09:23:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/3] fast-export: allow dumping anonymization mappings
Message-ID: <20200619132304.GA2540657@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "master" branch is special in fast-export in that we don't anonymize
it.  And the reason is that it helps to have some known reference point
between the original and anonymized repo, so you can find the same
commits.

This series gives an alternate way to achieve the same effect, but much
better in that it works for _any_ ref (so if you are trying to reproduce
the effect of "rev-list origin/foo..bar" in the anonymized repo, you can
easily do so). Ditto for paths, so that "rev-list -- foo.c" can be
reproduced in the anonymized repo.

And then we can drop the specialness of "master", which in turn is one
less thing to worry about in Dscho's series to make the default branch
configurable.

  [1/3]: fast-export: allow dumping the refname mapping
  [2/3]: fast-export: anonymize "master" refname
  [3/3]: fast-export: allow dumping the path mapping

 Documentation/git-fast-export.txt | 32 +++++++++++++++++
 builtin/fast-export.c             | 58 +++++++++++++++++++++++++++----
 t/t9351-fast-export-anonymize.sh  | 30 ++++++++++++----
 3 files changed, 106 insertions(+), 14 deletions(-)

-Peff
