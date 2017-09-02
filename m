Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B023208CD
	for <e@80x24.org>; Sat,  2 Sep 2017 08:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbdIBIdW (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Sep 2017 04:33:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:55660 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751838AbdIBIdV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2017 04:33:21 -0400
Received: (qmail 28053 invoked by uid 109); 2 Sep 2017 08:33:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 08:33:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9204 invoked by uid 111); 2 Sep 2017 08:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Sep 2017 04:33:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Sep 2017 04:33:19 -0400
Date:   Sat, 2 Sep 2017 04:33:19 -0400
From:   Jeff King <peff@peff.net>
To:     Ross Kabus <rkabus@aerotech.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] commit-tree shouldn't append an extra newline to commit
 messages
Message-ID: <20170902083319.lcugfpkkk5lahieb@sigill.intra.peff.net>
References: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEVs+za9do_wXC12SSRznF9v9oGw3_Grq2EFDVf8nH1CRgM-Qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2017 at 02:58:52PM -0400, Ross Kabus wrote:

> When doing git commit-tree to manually create a commit object, it can be seen
> that the resulting commit's message has an extra appended newline (\n) that
> was not present in the input for either argument -m or -F. This is both
> undesirable and inconsistent with the git commit porcelain command.

Hmm. As a plumbing command, I'd expect commit-tree to generally _not_
perform such niceties. And definitely it does not when taking the
message in via stdin. In Git's original design, commit object bodies do
not even have to be text, though certainly the porcelain tools all
assume they are.

But I am confused by your "inconsistent with git commit porcelain"
comment. The porcelain git-commit definitely _does_ add a newline if one
isn't present (and in fact runs the whole thing through git-stripspace
to clean up whitespace oddities).

So I don't think "inconsistent with git-commit" is a compelling
argument, unless I'm missing something.

I _could_ see an argument for "commit-tree as plumbing should always
treat the message verbatim". But since "-F" and "-m" have done the
newline-completion since their inception, I'm not sure it's a good idea
to change them now. The current behavior also makes some sense, as it's
consistent with the matching options in git-commit (again, as far as I
can see; if you have a counter-example it would be interesting to see).

-Peff
