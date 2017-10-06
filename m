Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0E01FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdJFEdD (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:33:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:34734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750710AbdJFEdD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:33:03 -0400
Received: (qmail 6825 invoked by uid 109); 6 Oct 2017 04:33:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 04:33:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2564 invoked by uid 111); 6 Oct 2017 04:33:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 00:33:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 00:33:01 -0400
Date:   Fri, 6 Oct 2017 00:33:01 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     rpjday@crashcourse.ca, git@vger.kernel.org
Subject: Re: couple questions about git "logical variables" and "git var"
Message-ID: <20171006043300.to2d2zv6ludbinrh@sigill.intra.peff.net>
References: <20171005051104.Horde.8J0J7-XC6jD4AOgtYrou3Na@crashcourse.ca>
 <20171005095636.mpp2ohf7vp7mtzeb@sigill.intra.peff.net>
 <20171006023530.GA134987@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006023530.GA134987@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 07:35:30PM -0700, Jonathan Nieder wrote:

> > It also only tells half the story. You have to know not just what's in
> > $GIT_EDITOR, but you have to know the right way to evaluate it. There's
> > a git_editor helper in git-sh-setup, but other scripting languages are
> > on their own.
> 
> I am not sure I understand the complaint here.  git-var(1) says:
> 
> 	GIT_EDITOR
> 	   Text editor for use by Git commands. The value is meant to be
> 	   interpreted by the shell when it is used. Examples: [...]
> 
> Are you saying that the output of the command should quote that
> manpage, so as to tell the rest of the story?

No, I just meant that after reading that manpage, I'm not sure I would
have picked up the subtlety that shell scripts need to call:

  eval "$GIT_EDITOR" '"$@"'

and not:

  "$GIT_EDITOR" "$@"

or:

  $GIT_EDITOR "$@"

(And likewise, other languages need to make sure they run "sh -c ..."
and not a straight spawn/exec of the editor command).

If the command were instead:

  git editor "$@"

that's harder to get wrong.

-Peff
