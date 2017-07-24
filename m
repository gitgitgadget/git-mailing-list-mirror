Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0816203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 16:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753304AbdGXQw0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 12:52:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:47092 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751521AbdGXQwY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 12:52:24 -0400
Received: (qmail 5256 invoked by uid 109); 24 Jul 2017 16:52:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 16:52:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9994 invoked by uid 111); 24 Jul 2017 16:52:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 12:52:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 12:52:22 -0400
Date:   Mon, 24 Jul 2017 12:52:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victor Toni <victor.toni@gmail.com>,
        Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
        Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: Handling of paths
Message-ID: <20170724165221.2biudhpfyyp5ytfc@sigill.intra.peff.net>
References: <CAG0OSgdEE3g-ugEJU4EZqfbxZ=3h2WPdLC4W4mG7b6UeTaXQ-Q@mail.gmail.com>
 <xmqq7ez2lwsv.fsf@gitster.mtv.corp.google.com>
 <20170720200523.GA13792@hashpling.org>
 <xmqqwp72kg03.fsf@gitster.mtv.corp.google.com>
 <CAG0OSgfWZAbr1_j-SYYZyAzOvW4mrSFa7bBkfhRbJskgdGmsZQ@mail.gmail.com>
 <xmqq1sp9izy2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sp9izy2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2017 at 08:15:17AM -0700, Junio C Hamano wrote:

> In general, I (and other experienced reviewers here) prefer to give
> chances to people who are new to the Git development community and
> are inclined to do so to scratch their own itch, by giving analysis
> of the problem and a suggested route to solve it, but without giving
> the final solution in a patch form.  After all, many developers
> (including me) started from small changes before getting involved
> more deeply to the project and starting to play more important
> roles.

This is a good point, and I should remember to do it more, too.
It's often faster to do a small patch yourself than to help walk a
first-timer through it, but keeping the community healthy is an
important step.

At any rate, your patch to use config_pathname() looks like the right
thing to me.

> Having said all that, I suspect that your original problem
> description might point at another thing we may want to look into.
> 
> The patch under discussion may have solved the "~[username]/" prefix
> issue, but I offhand am not sure if a path-like variable that holds
> a relative path behaves sensibly when they appear in configuration
> files and in a file that has configuration snippets that is included
> with the "[include] path=..." thing, and if there is a need to clarify
> and/or update the rules.

The "[include]path" behavior is intentional and documented: it takes the
path relative to the including file. I think that would be a reasonable
behavior for path-like variables in general (and a path-like variable in
an included file would be relative to that included file; this should
Just Work because the include mechanism keeps a stack of files).

I could probably sketch out a patch, but per the above discussion I'll
leave it for now. Also, I'm lazy. ;)

-Peff
