Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D58EC433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C411610D0
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 09:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKDJpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 05:45:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52936 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhKDJpu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 05:45:50 -0400
Received: (qmail 8038 invoked by uid 109); 4 Nov 2021 09:43:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 09:43:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32130 invoked by uid 111); 4 Nov 2021 09:43:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Nov 2021 05:43:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Nov 2021 05:43:10 -0400
From:   Jeff King <peff@peff.net>
To:     Steven Penny <srpen6@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: credential-store get: No such file or directory
Message-ID: <YYOrLgj3KMq6eKpp@coredump.intra.peff.net>
References: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
 <YYHzDuoJfWknI1XM@coredump.intra.peff.net>
 <CAP8dQmvoxWDnD_rbCdBS9cnwS90YFjjXcCPWLmjMq=ck7vo1Ww@mail.gmail.com>
 <YYJuK70U8Sk7xSYl@coredump.intra.peff.net>
 <CAP8dQmsbR7V1zX=xpk+ah-5bgkOP3vJGTMBq_25m9Vhw_fADAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8dQmsbR7V1zX=xpk+ah-5bgkOP3vJGTMBq_25m9Vhw_fADAQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 03, 2021 at 11:01:16AM -0500, Steven Penny wrote:

> On Wed, Nov 3, 2021 at 6:10 AM Jeff King wrote:
> > Hmm, that's the right output, I think. Even though it's wrapped in
> > single-quotes I think that's just how run_command shows it.
> 
> Why does this have no quotes:
> 
>     run-command.c:666 trace: run_command: git-remote-https origin
> https://github.com/89z/googleplay
> 
> and this have quotes:
> 
>     run-command.c:666       trace: run_command: 'git credential-store get'
> 
> If youre saying that both commands ran unquoted, then I believe you. But
> hopefully you'll agree that even if nothing is wrong with the code that runs the
> commands, that the output is confusing at best, and misleading at worst.

It's because internally, the "git credential-store get" command is
assembled as a single string passed to the shell, whereas remote-https
is run directly via exec/spawn.

I agree the output is confusing.

That may give us a clue as to what's going wrong, though. I.e., there
could be some issue with the shell on your system.

> Hopefully you won't fault me for just wanting something that works, so I am just
> going to use my AskPass program [2] that I wrote in response to this situation.
> Ironically, "git push" is actually faster now than it was with Netrc, so I guess
> that's a win. Thanks for the responses.

Nope, that's definitely your right if you don't want to spend time
digging further.  But as I can't reproduce here, it may mean the problem
goes unsolved. We do have tests for credential-store in our test suite,
so if it were broken for everybody, I expect we'd have noticed. If it is
specific to your system somehow, then you working around it is as good
as a solution. :)

-Peff
