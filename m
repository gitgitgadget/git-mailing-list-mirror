From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Tue, 17 Feb 2015 05:46:28 -0500
Message-ID: <20150217104628.GA25978@peff.net>
References: <20150216054550.GA24611@peff.net>
 <20150216054754.GB25088@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:46:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNffo-0006AI-5i
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 11:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752AbbBQKqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 05:46:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:49825 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755150AbbBQKqa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 05:46:30 -0500
Received: (qmail 17980 invoked by uid 102); 17 Feb 2015 10:46:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 04:46:31 -0600
Received: (qmail 6178 invoked by uid 107); 17 Feb 2015 10:46:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 05:46:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2015 05:46:28 -0500
Content-Disposition: inline
In-Reply-To: <20150216054754.GB25088@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263944>

On Mon, Feb 16, 2015 at 12:47:54AM -0500, Jeff King wrote:

> When the "push_default" flag was originally added, it was
> made globally visible to all code. This might have been
> useful if other commands or library calls ended up depending
> on it, but as it turns out, only builtin/push.c cares.
> 
> Let's make it a static variable in builtin/push.c.
>
> [...]
> 
> ---
> We know this is safe because no other callers needed tweaked when the
> variable went out of scope. :) It would only be a bad idea if we
> were planning on having other code in the future depend on push_default
> (e.g., the code in remote.c to find the push destination). But it does
> not seem to have needed that in the intervening years, so it's probably
> fine to do this cleanup now.

I had a nagging feeling that there was some code which wanted to use
this elsewhere, and I did finally find it, when I merged this topic with
my other personal topics.

If we wanted to implement "@{push}" (or "@{publish}") to mean "the
tracking ref of the remote ref you would push to if you ran git-push",
then this is a step in the wrong direction.

The patches I posted last January (and which you carried as
jk/branch-at-publish for a while) do work, and I've used the feature
once or twice since then. From the discussion, it looks like they were
meant to be a building block for more triangular-flow work, but I don't
remember what else was needed. I'm tempted to resurrect them, but it's
not a high priority for me.

Anyway, food for thought on whether we want to do this cleanup or not,
then. We can always leave this here as part of git_default_config, and
still move Dave's new option into git_push_config.

-Peff
