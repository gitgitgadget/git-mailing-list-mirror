From: Jeff King <peff@peff.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 11:10:16 -0400
Message-ID: <20080910151015.GA8869@coredump.intra.peff.net>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080910122118.GI21071@mit.edu> <20080910141630.GB7397@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Tso <tytso@MIT.EDU>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRLp-0002SB-TP
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbYIJPKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 11:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYIJPKU
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:10:20 -0400
Received: from peff.net ([208.65.91.99]:4610 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbYIJPKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:10:18 -0400
Received: (qmail 31119 invoked by uid 111); 10 Sep 2008 15:10:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 10 Sep 2008 11:10:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Sep 2008 11:10:16 -0400
Content-Disposition: inline
In-Reply-To: <20080910141630.GB7397@cuci.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95524>

On Wed, Sep 10, 2008 at 04:16:30PM +0200, Stephen R. van den Berg wrote:

> >Once you have this information, it is not difficult to maintain a
> >berk_db database which maps a particular Bug identifier (i.e.,
> >Red_Hat/149480, or Debian/471977, or Launchpad/203323) to a series of
> >commits.
> 
> This is nice, I admit, but it has the following downsides:
> - It is nontrivial to automate this on execution of "git cherry-pick".

Maybe a cherry-picking hook?

> - In a distributed environment this requires a network-reachable bug
>   database.

Use a distributed bug tracking system (DBTS).

> - A network-reachable bug database means that suddenly git needs network
>   access for e.g. cherry-pick, revert, gitk, log --graph, blame.

Use a DBTS.

> - Network queries for commits containing references kind of kills
>   performance.

Use a DBTS.

> - Some backports don't have entries in a bug database because they
>   weren't bugs to begin with, in which case it becomes impossible to add
>   an identifier to the commit message after the fact.

Use a DBTS, since then you can generally make up a new UUID on the spot.

> - It relies heavily on tools outside of git-core, which raises the
>   threshold for using it.

True.

But maybe Ted is on to something here. Rather than adding the
information to the commit object itself, why not maintain a separate
mapping, but keep it _within git_. That is how most of the DBTS's work
that I have seen. Maybe it is possible to implement some subset of the
features in a tool that could become part of core git.

There was a proposal at some point for a "notes" feature which would
allow after-the-fact annotation of commits. I don't recall the exact
details, but I think it stored its information as a git tree of blobs.
You could choose whether or not to transfer the notes based on
transferring a ref pointing to the notes tree.

I'm not sure how applicable this is to your problem, but if you want to
investigate you can find discussion in the list archive under the name
"notes".

-Peff
