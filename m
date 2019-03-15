Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87FEE20248
	for <e@80x24.org>; Fri, 15 Mar 2019 03:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfCODa6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 23:30:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:51890 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726708AbfCODa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 23:30:58 -0400
Received: (qmail 14665 invoked by uid 109); 15 Mar 2019 03:30:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Mar 2019 03:30:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28687 invoked by uid 111); 15 Mar 2019 03:30:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Mar 2019 23:30:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Mar 2019 23:30:20 -0400
Date:   Thu, 14 Mar 2019 23:30:20 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: GitGitGadget on github.com/git/git?, was Re: [RFC/PATCH] point
 pull requesters to Git Git Gadget
Message-ID: <20190315033020.GE28943@sigill.intra.peff.net>
References: <20190312213246.GA6252@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1903141235390.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903141235390.41@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 01:04:51PM +0100, Johannes Schindelin wrote:

> > One thing that I think submitGit can do that GGG cannot (yet), is just
> > take PRs straight on git/git. If we're going to start recommending it,
> > then I think we'd probably want to configure that, since it's one less
> > confusing step for first-timers, who right now might have to go re-make
> > their PR on gitgitgadget/git.
> 
> I just realized that I had not responded to that yet. It is not *quite*
> that easy, unfortunately.
> 
> I did design GitGitGadget to have a state. For example, to avoid spamming
> the Git mailing list with bogus patch series, GitGitGadget maintains a
> list of GitHub user names for users allowed to send patch series. (I saw
> my share of bogus PRs in the Git for Windows fork, and had no desire to
> facilitate similar patch series on the list.) This information, together
> with information about the Message IDs to monitor, and about the PRs that
> are still open, are maintained in a JSON-formatted object that is stored
> in `refs/notes/gitgitgadget`.

Ah, I wondered if there might be a catch like this. I do think it would
be nice to keep that ref out of git.git. We definitely would not want to
lose the features that depend on it, but it sounds like we could use a
separate metadata repository.

> I could imagine that we keep pushing those refs to gitgitgadget/git, but
> now also allow for PRs on git/git to use GitGitGadget (we would have to
> install the GitHub App there, too, and I would have to change the code to
> allow that, and we would have to use a slightly different format for the
> tags generated from git/git PRs to avoid clashes with the gitgitgadget/git
> PRs, all of which is totally doable).

I don't think connecting the GitHub App should be a big deal. Ideally it
would not even need write permission to the git/git repository, if it's
keeping metadata elsewhere (it would need to be able to write PR
comments, of course). It might not be a show-stopper if GitHub's
permissions aren't fine-grained enough to allow that, but not having
repo write access would be nice insurance against bugs in GitGitGadget
writing where we don't expect it to.

> If this is truly something we ("we" as in "engaged Git developers") want,
> I can set aside some time to work on that. I had originally planned on
> exactly that, i.e. supporting PRs on git/git, but I got rather strong
> indications that GitGitGadget is hated by some (Duy, for example, was very
> vocal about refusing to even look at any of the GitGitGadget-sent patch
> series, let alone using the tool himself). While I think that this hate is
> undeserved, I cannot change other people's feelings, nor would I try, all
> I can do is to try not to make the situation worse.
> 
> In short: before I spend serious time on extending GitGitGadget to handle
> git/git PRs, I want to be sure that I won't get backlash for that.

IMHO, GitGitGadget is a useful tool to develop. It has some rough edges,
still, but I think the _idea_ is certainly a good one. Especially if the
dream of bi-directionality is ever fulfilled (though I am not exactly
holding my breath on that; I think it can get very tricky). But even
without that, I think it's useful to have something like it (or
submitGit) available for some contributors.

In general, I have not minded the use of GGG on the list lately by you
or Stolee. I do complain about the rough edges (timestamps, sender-cc on
the cover letter, etc), but even as it stands now I am not hating it as
a reviewer. If you are happy with it on the sending side, and especially
if you want to smooth some of those rough edges, then I do not have a
problem myself with its continued use.

-Peff
