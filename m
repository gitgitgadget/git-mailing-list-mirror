From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] filter-branch: support skipping of commits more
 easily
Date: Fri, 8 Jun 2007 06:12:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080605500.4059@racer.site>
References: <20070608021157.18066.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Jun 08 07:15:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwWoy-0006NW-6L
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 07:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757110AbXFHFP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 01:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757198AbXFHFP0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 01:15:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:52372 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757110AbXFHFP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 01:15:26 -0400
Received: (qmail invoked by alias); 08 Jun 2007 05:15:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 08 Jun 2007 07:15:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EKPoTuwdEvJ0SSwOzv3GIsQcgYieKaT7AAnneaQ
	7XKDg39eVT0y/j
X-X-Sender: gene099@racer.site
In-Reply-To: <20070608021157.18066.qmail@science.horizon.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49431>

Hi,

On Fri, 7 Jun 2007, linux@horizon.com wrote:

> > I think that is fine; in effect, by saying "skip" B, you are
> > squashing B-C into C'.
> > 
> > Does this mean that, given
> > 
> >           C---D---E
> >          /   /
> >         A---B
> > 
> > and if commit-filter says "skip" on D, the written history would
> > look like this?
> > 
> >           C'------E'
> >          /       /
> >         A'--B'--'
> > 
> > The new commit E' would become an evil merge that has difference
> > between D and E in the original history?
> > 
> > I am not objecting; just trying to get a mental picture.
> 
> I think, for compatibility with the existing git path limiter,
> it should delete D from the history only if:
> 1) Told to skip D, and
> 2) Told to skip B or C (or both).
> 
> So you could get A--B--E' or A--C--E' or even A--E', but D would only
> be deleted if it wasn't needed as a merge marker.
> 
> That's probably a little more complex to implement, but it feels like
> The Right Thing.

... but if that script should do that, the name "filter"-branch was a 
misnomer.

It filters the _branch_. In the sense that a branch is one or more perls 
of commits, uniting in the tip of that branch.

If you want to skip a commit, that is fine. But a commit is _not_ a patch, 
no sir. It is a revision.

The fact that we actually are able to extract nice patches from any patch 
series, does not mean that the revisions are actually only deltas with 
regard to the previous commit. To the contrary: we actually allow -- and 
encourage -- git-diff between different revisions, be they on the same 
branch or not. That alone should tell everybody that a revision is a 
revision is a revision, and _not_ a delta.

So, when you filter commits, you should not expect a certain _patch_ to be 
skipped when you say "skip" (or maybe "squash", which I actually like 
better, because it is as unambiguous as you get it), but a _commit_ (AKA 
revision) to be skipped.

Ciao,
Dscho
