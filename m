Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AAB320365
	for <e@80x24.org>; Wed,  4 Oct 2017 17:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdJDRFf (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 13:05:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:60684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751240AbdJDRFe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 13:05:34 -0400
Received: (qmail 5878 invoked by uid 109); 4 Oct 2017 17:05:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 17:05:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19724 invoked by uid 111); 4 Oct 2017 17:05:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 13:05:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 13:05:32 -0400
Date:   Wed, 4 Oct 2017 13:05:32 -0400
From:   Jeff King <peff@peff.net>
To:     Ernesto Alfonso <erjoalgo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: disable interactive prompting
Message-ID: <20171004170532.6pjcwdurcokpvcop@sigill.intra.peff.net>
References: <87tvzehp13.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tvzehp13.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 09:10:48AM -0700, Ernesto Alfonso wrote:

> Waiting for git-push synchronously slows me down, so I have a bash
> alias/function to do this in the background. But when my origin is https, I
> get an undesired interactive prompt. I've tried to disable by
> redirecting stdin:
> 
> git push ${REMOTE} ${BRANCH} &>/dev/null </dev/null
> 
> but I still get an interactive prompt.
> 
> Is there a way to either
> 
> 1. disable interactive prompting
> 2. programmatically determine whether a git command (or at least a git
> push) would interactively prompt

I assume the prompt is for credentials, since that's generally the only
thing git-push will prompt for.

Try:

  $ git help git | sed -ne '/PROMPT/,/^$/p'
         GIT_TERMINAL_PROMPT
           If this environment variable is set to 0, git will not prompt on
           the terminal (e.g., when asking for HTTP authentication).

Of course that just stops the prompting. If Git needs a credential and
you don't provide it, then the push will fail.

For advice on that that, try "git help credentials".

-Peff
