Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA6F81F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 05:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfKMFPb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 00:15:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:46186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726010AbfKMFPb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 00:15:31 -0500
Received: (qmail 12733 invoked by uid 109); 13 Nov 2019 05:15:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Nov 2019 05:15:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22588 invoked by uid 111); 13 Nov 2019 05:19:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Nov 2019 00:19:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 Nov 2019 00:15:30 -0500
From:   Jeff King <peff@peff.net>
To:     Mateusz Loskot <mateusz@loskot.net>
Cc:     git@vger.kernel.org
Subject: Re: Merge commit says refs/heads/<branchname> instead of <branchname>
Message-ID: <20191113051530.GA3547@sigill.intra.peff.net>
References: <CABUeae82_qQrR5s_QYsDzkVX6CeVM-B7pT5DZt_BjpL=KJdtBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABUeae82_qQrR5s_QYsDzkVX6CeVM-B7pT5DZt_BjpL=KJdtBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 12:48:53AM +0100, Mateusz Loskot wrote:

> After setting up a new machine with latest Git and
> I noticed commit messages for true merge changed from
> 
>    Merge branch '<branchname>'
> to
>    Merge branch 'refs/heads/<branchname>'
> 
> Nothing changed in the merge workflow or git configuration

I can't reproduce the problem here. If I set up a repository like this:

  git init repo && cd repo
  >base && git add base && git commit -m base
  >master && git add master && git commit -m master
  git checkout -b side HEAD^
  >side && git add side && git commit -m side
  git checkout master
  git tag tip

and then run:

  git reset --hard tip && git merge --no-edit side
  git log -1 --oneline

I get:

  Merge branch 'side'

If I do:

  git reset --hard tip && git merge --no-edit refs/heads/side
  git log -1 --oneline

then I get:

  Merge branch 'refs/heads/side'

And the behavior seems the same going back to older versions of Git. Are
you sure your workflow hasn't changed somehow?

Can you show an example that triggers the behavior for you?

> I'm failing to find in the docs what drives that change, what
> configuration option controls such (default?) message.
> 
> What may be the reason of that change?

I think any change there would probably be unintentional (but it's hard
to say for sure without tracking it down).

-Peff
