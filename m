From: Jeff King <peff@peff.net>
Subject: Re: Git Notes idea.
Date: Wed, 17 Dec 2008 04:45:29 -0500
Message-ID: <20081217094528.GA18492@coredump.intra.peff.net>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com> <20081216085108.GA3031@coredump.intra.peff.net> <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com> <alpine.DEB.1.00.0812170003540.14632@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 17 10:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCszc-0004pH-GC
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 10:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbYLQJpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 04:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYLQJpm
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 04:45:42 -0500
Received: from peff.net ([208.65.91.99]:3792 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbYLQJpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 04:45:41 -0500
Received: (qmail 25179 invoked by uid 111); 17 Dec 2008 09:45:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Dec 2008 04:45:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2008 04:45:29 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812170003540.14632@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103329>

On Wed, Dec 17, 2008 at 12:48:02AM +0100, Johannes Schindelin wrote:

> > Perhaps I am missing something, how is it a linear search?
> 
> Yes, you are missing what I wrote in the original thread: tree objects 
> must be read in a forward direction, one by one.

Thanks, that was a nice writeup of what was discussed at the
GitTogether.

> Peff's very cute idea was to decouple that process from the per-commit 
> procedure, and basically make it a one-time cost (per Git call, and only 
> when notes were asked for).

To be fair, it was not my cute idea, but somebody else's (I think David
Reiss). I just coded it quickly because somebody was talking about
iPhones or something. :)

> To the contrary.  When I rebase, the tree _does_ change, otherwise I
> would have rebased onto something that had the same original tree as
> my rebase-base to begin with, which would make the rebase rather
> pointless.

Another fun option would be to put notes on patch-ids. That would of
course be horrifically slow to look up, but would survive many
cherry-picks and rebases (but not all, of course).

I don't know if that is useful or not, but I don't see any reason why
the discussed implementation would forbid it (somebody would just have
to implement the lookups at a useful spot).

> > On naming.  I strongly support a ref/notes/sha1/sha1 approach.
> I think you meant refs/notes:<first byte in hex>/<rest of bytes>/<some
> arbitrary SHA-1>?

You seem to be in favor of the fan-out. Out of curiosity, did you ever
do numbers on whether the fan-out is actually helpful?

> I am rather supporting refs/nots:<first byte in hex>/<rest of bytes>
> being either a blob, or a tree containing human readable tags, such as
> "bugfix" or "review" or some such.

Yes, I am in favor of the "tree or blob" idea, too. I want this to not
just be about "I am a person writing a note" but "arbitrary data
attached to an object after it has been created". And that means
thinking up front about managing the namespace.

-Peff
