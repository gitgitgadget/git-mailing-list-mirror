Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD0D42022A
	for <e@80x24.org>; Sat, 29 Oct 2016 19:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbcJ2TK1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 15:10:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:36044 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751479AbcJ2TK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2016 15:10:26 -0400
Received: (qmail 9894 invoked by uid 109); 29 Oct 2016 19:10:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Oct 2016 19:10:25 +0000
Received: (qmail 6877 invoked by uid 111); 29 Oct 2016 19:10:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 29 Oct 2016 15:10:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Oct 2016 15:10:23 -0400
Date:   Sat, 29 Oct 2016 15:10:23 -0400
From:   Jeff King <peff@peff.net>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Fetch/push lets a malicious server steal the targets of "have"
 lines
Message-ID: <20161029191023.ztrfe76u4gi4l3ci@sigill.intra.peff.net>
References: <1477690790.2904.22.camel@mattmccutchen.net>
 <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
 <1477692961.2904.36.camel@mattmccutchen.net>
 <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
 <1477712029.2904.64.camel@mattmccutchen.net>
 <20161029133959.kpkohjkku3jgwjql@sigill.intra.peff.net>
 <1477757311.1524.21.camel@mattmccutchen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1477757311.1524.21.camel@mattmccutchen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2016 at 12:08:31PM -0400, Matt McCutchen wrote:

> Let's focus on the first scenario.  There the user is just pulling and
> pushing a master branch.  Are you saying that each time the user pulls,
> they need to look over all the commits they pulled before pushing them
> back?  I think that's unrealistic, for example, on a busy project with
> centralized code review or if the user is publishing a project-specific 
> modified version of an upstream library.  The natural user expectation
> is that anything pulled from a public repository is public.

No, I'm saying if you are running "git push foo master", then you should
expect the contents of "master" to go to "foo". That _could_ have
security implications if you come up with a sequence of events where
secret things made it to "master". But it seems to me that "foo
previously lied to you about what it has" is not the weak link in that
chain. It is not thinking about what secret things are hitting the
master that you are pushing, no matter how they got there.

I agree there is a potential workflow (that you have laid out) where
such lying can cause an innocent-looking sequence of events to disclose
the secret commits. And again, I don't mind a note in the documentation
mentioning that. I just have trouble believing it's a common one in
practice.

The reason I brought up the delta thing, even though it's a much harder
attack to execute, is that it comes up in much more common workflows,
like simply fetching from a private security-sensitive repo into your
"main" public repo (which is an example you brought up, and something I
know that I have personally done in the past for git.git).

-Peff
