Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C31A1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfAXPRl (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 10:17:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:47350 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727562AbfAXPRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 10:17:41 -0500
Received: (qmail 32648 invoked by uid 109); 24 Jan 2019 15:17:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 15:17:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29004 invoked by uid 111); 24 Jan 2019 15:17:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 10:17:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 10:17:39 -0500
Date:   Thu, 24 Jan 2019 10:17:39 -0500
From:   Jeff King <peff@peff.net>
To:     Naum Derzhi <Naum.Derzhi@halliburton.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Removing data from repository
Message-ID: <20190124151739.GA26616@sigill.intra.peff.net>
References: <7A854577E980BE4FB29FDD041B9B75E701798CEE@NP1EXMB203.corp.halliburton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7A854577E980BE4FB29FDD041B9B75E701798CEE@NP1EXMB203.corp.halliburton.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 02:51:50PM +0000, Naum Derzhi wrote:

> I have this problem: years ago one of our developers committed a large
> (Gigabytes) piece of binary data into our project repository. This
> should not have been done, but it happened. (Honest, it was not me).
> We never needed this data in the repository.
> 
> Using git rm removes these files from the working tree, but they are
> still somewhere in the repository, so when we clone, we transfer
> gigabytes of unneeded data. 
> 
> Is it possible to fix this problem?

You'll have to rewrite the offending history. You can use
git-filter-branch. See especially these sections of the manpage:

  https://git-scm.com/docs/git-filter-branch#_examples

  https://git-scm.com/docs/git-filter-branch#_checklist_for_shrinking_a_repository

as well as the warning in the DESCRIPTION section:

  WARNING! The rewritten history will have different object names for
  all the objects and will not converge with the original branch. You
  will not be able to easily push and distribute the rewritten branch on
  top of the original branch. Please do not use this command if you do
  not know the full implications, and avoid using it anyway, if a simple
  single commit would suffice to fix your problem. (See the "RECOVERING
  FROM UPSTREAM REBASE" section in git-rebase(1) for further information
  about rewriting published history.)

You may also want to check out the BFG repo cleaner[1], as separate
project that handles this case a little more simply (it doesn't save you
from dealing with rewritten history, but it does avoid having to learn
filter-branch's flexible but confusing syntax).

-Peff

[1] https://rtyley.github.io/bfg-repo-cleaner/
