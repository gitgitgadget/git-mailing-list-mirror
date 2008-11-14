From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Fri, 14 Nov 2008 01:37:41 -0500
Message-ID: <20081114063740.GA12001@coredump.intra.peff.net>
References: <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org> <20081108142756.GC17100@coredump.intra.peff.net> <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org> <20081109014926.GA31276@coredump.intra.peff.net> <f73f7ab80811111644y14f0e0ccweed44440356a6508@mail.gmail.com> <20081112084412.GA3860@coredump.intra.peff.net> <f73f7ab80811122122i4ae3ba6dn2ceb314b86660a70@mail.gmail.com> <20081113053735.GA5343@coredump.intra.peff.net> <7vhc6ci24o.fsf@gitster.siamese.dyndns.org> <f73f7ab80811130558h34cb1220q76ef5536e853151c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 07:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0sKe-0003tW-Ko
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 07:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbYKNGhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 01:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYKNGhp
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 01:37:45 -0500
Received: from peff.net ([208.65.91.99]:3434 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYKNGhn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 01:37:43 -0500
Received: (qmail 31713 invoked by uid 111); 14 Nov 2008 06:37:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Nov 2008 01:37:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2008 01:37:41 -0500
Content-Disposition: inline
In-Reply-To: <f73f7ab80811130558h34cb1220q76ef5536e853151c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100953>

On Thu, Nov 13, 2008 at 08:58:50AM -0500, Kyle Moffett wrote:

> I guess the issue comes down to a UI complication.  It would very easy
> for me to tell somebody how to check out and test their branch in my
> testbed if I'm not around, except for that little bit of arcane
> syntax.  Moreover, the consequences if they forget are really

If the problem is merely the syntax, then perhaps that argues for "git
checkout -d" to force detaching.

> frustrating and hard to figure out.  It's also very easy with a GUI to
> do the simple *rightclick branch, click "Checkout"*, but would be much
> harder to do the detached HEAD checkout correctly.

And again, perhaps this argues for a "Detach" option in the GUI.

But I have to admit, this is a pretty infrequently-used use-case. I
detach all the time when looking at non-branches, but I can't think of
the last time I used "ref^0" to detach intentionally.

> If it didn't involve reconfiguring a lot of other people's
> repositories, I might consider having them push to "refs/remotes/*".
> In theory that's actually much closer to what I'm doing anyways.  That
> would force any checkouts to be bare, but it would require lots of
> git-foo on the pushing side.  Perhaps some way to "git push" which
> asks the remote repository where it wants the stuff?

Or git-receive could even just silently munge the incoming refs when
writing them out (i.e., it exposes "refs/test/*" as "refs/heads/*", and
when you ask to write "refs/heads/foo" it writes "refs/test/foo"
instead).

Though that sort of lying feels a little wrong to me, since the pushing
side will incorrectly update its tracking branches. It wouldn't so bad
if the "fetch" side respected the munging, too.

But again, this seems uncommon enough that it is not worth trying to
implement something too clever.

> Alternatively, it might be possible to add ref attributes or a config
> option to force detached HEAD checkouts.

I think that is a more sensible solution. Your workflow is not about
"sometimes I want to detach the HEAD" but rather "in this particular
repo, we should _always_ detach the HEAD." Which a config option
represents very nicely.

-Peff
