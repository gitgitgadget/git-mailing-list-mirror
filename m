Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B677A1F4C1
	for <e@80x24.org>; Thu, 31 Oct 2019 15:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfJaPmU (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 11:42:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:35024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726735AbfJaPmU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 11:42:20 -0400
Received: (qmail 17867 invoked by uid 109); 31 Oct 2019 15:42:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 15:42:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2393 invoked by uid 111); 31 Oct 2019 15:45:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 11:45:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 11:42:17 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
Message-ID: <20191031154217.GA30187@sigill.intra.peff.net>
References: <20191030183950.GA21277@generichostname>
 <20191030202835.GB29013@sigill.intra.peff.net>
 <20191030224328.GB44961@generichostname>
 <20191031061832.GA20830@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
 <8b9021fa-f60c-a2e0-1174-a2fc1f11c476@gmail.com>
 <nycvar.QRO.7.76.6.1910311229150.46@tvgsbejvaqbjf.bet>
 <9aa1cefc-daeb-e702-95ba-1e83f8f7dcfe@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9aa1cefc-daeb-e702-95ba-1e83f8f7dcfe@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 01:45:31PM +0000, Philip Oakley wrote:

> Hi,
> On 31/10/2019 11:30, Johannes Schindelin wrote:
> > And while we're dreaming: it would be nice to discern between "push
> > upstreams" and "base upstreams". Example: when I work on the
> > `fix-t5516-flakiness` branch, I target `upstream/master`, but I push to
> > `dscho`, i.e. my "push upstream" is `dscho/fix-t5516-flakiness`.
> > 
> > Ciao,
> > Dscho
> Yep, the triangular workflow of 'publish' v 'upstream' v 'local' is quite
> tricky. There is little user facing docs for that.
> 
> Many of my branches have the wrong "upstream" in the sense that it's the
> push-publish remote that holds copies of my work (i.e. I manually select the
> push-remote every time;-), even though the branches are set to track the
> original start point's upstream.

Do either of you use remote.pushDefault, branch.*.pushRemote, or
@{push}?

My triangular config for git.git looks like:

  [remote "origin"]
	url = https://github.com/gitster/git.git
  [remote "github"]
	url = https://github.com/peff/git.git
  [remote]
	pushDefault = github
  [branch "jk/foo"]
	remote = origin
	merge = refs/heads/master

Then upstream comparisons, "git rebase" etc without arguments, do what I
want: compare against master. And "git push" without arguments does what
I want: push this branch to my fork. And if I need to refer to the
pushed version for some reason (e.g., comparing what I just changed to
what I last sent out, "git range-diff @{u} @{push} HEAD" does the right
thing.

-Peff
