Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3A92036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbdJEJ4l (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:56:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:33334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751522AbdJEJ4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:56:39 -0400
Received: (qmail 16212 invoked by uid 109); 5 Oct 2017 09:56:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 09:56:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25908 invoked by uid 111); 5 Oct 2017 09:56:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Oct 2017 05:56:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Oct 2017 05:56:36 -0400
Date:   Thu, 5 Oct 2017 05:56:36 -0400
From:   Jeff King <peff@peff.net>
To:     rpjday@crashcourse.ca
Cc:     git@vger.kernel.org
Subject: Re: couple questions about git "logical variables" and "git var"
Message-ID: <20171005095636.mpp2ohf7vp7mtzeb@sigill.intra.peff.net>
References: <20171005051104.Horde.8J0J7-XC6jD4AOgtYrou3Na@crashcourse.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171005051104.Horde.8J0J7-XC6jD4AOgtYrou3Na@crashcourse.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 05:11:04AM -0400, rpjday@crashcourse.ca wrote:

>   i just ran across "git var" for the first time, and it seems a bit weird.
> it refers to the (apparently) four git "logical variables":

It's definitely weird.

>  - GIT_AUTHOR_IDENT
>  - GIT_COMMITTER_IDENT
>  - GIT_EDITOR
>  - GIT_PAGER
> 
> first question -- what is it about precisely those four variables that makes
> them "logical" variables in git parlance? just those four? no others?

It was introduced in the very early days as a way for scripts to get
access to "standard" values that would be computed the same way as the C
portions of Git.  But it hasn't generally been kept up to date with new
possible variables.

It also only tells half the story. You have to know not just what's in
$GIT_EDITOR, but you have to know the right way to evaluate it. There's
a git_editor helper in git-sh-setup, but other scripting languages are
on their own. We'd probably have done better to introduce a "git editor"
command which can be run from any language.

But as most of Git is written in C these days, it seems that nobody had
enough interest to smooth out these kinds of rough edges.

>   also, the man page "man git-var" seems wrong:
> 
> "OPTIONS
>   -l
>     Cause the logical variables to be listed. In addition, all the variables
>     of the Git configuration file .git/config are listed as well."
> 
> no, if i run "git var -l", i see not only the logical variables, but i
> see *all* of the available config settings (system and global), not just
> those in .git/config (unless i'm misreading what that is supposed to mean).

Yes, I agree the description there is wrong. I'd have to dig in the
history to be sure, but I'm pretty sure it has _always_ been wrong.

> p.s. yes, i realize this command is deprecated in favour of "git config -l",
> but as long as it's available, it should work as described in the man page.

Yes, though I think fixing the manpage is the right way to make them
consistent.

-Peff
