Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74980C388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E0020770
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 07:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373866AbgJWHHs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 03:07:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:40158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373849AbgJWHHs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 03:07:48 -0400
Received: (qmail 26388 invoked by uid 109); 23 Oct 2020 07:07:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 07:07:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13445 invoked by uid 111); 23 Oct 2020 07:07:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 03:07:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 03:07:47 -0400
From:   Jeff King <peff@peff.net>
To:     VenomVendor <info@venomvendor.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: committer-date-is-author-date flag removes email in "Commit"
Message-ID: <20201023070747.GA2198273@coredump.intra.peff.net>
References: <e08df0d5792ab70a9158be32cfa28696@venomvendor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e08df0d5792ab70a9158be32cfa28696@venomvendor.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 11:18:51AM +0530, VenomVendor wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
> * Create empty repo using `git init`
> * Make few commits, at least two
> * execute `git log --format=fuller`
> * Notice the log, with "Author", "AuthorDate", "Commit", "CommitDate"
> * Note, "Commit"
> * execute `git rebase --committer-date-is-author-date HEAD~1`
> * execute `git log --format=fuller`
> * Note, email from "Commit" is empty <>

Thanks for a clear report. I was able to easily reproduce the problem.
There are actually two related bugs here, and they're both regressions
in v2.29.0.

  [1/3]: t3436: check --committer-date-is-author-date result more carefully
  [2/3]: am: fix broken email with --committer-date-is-author-date
  [3/3]: rebase: fix broken email with --committer-date-is-author-date

 builtin/am.c                   | 4 ++--
 sequencer.c                    | 2 +-
 t/t3436-rebase-more-options.sh | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

-Peff
