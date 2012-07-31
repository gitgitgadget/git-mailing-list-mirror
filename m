From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fix git-svn for SVN 1.7
Date: Tue, 31 Jul 2012 02:18:18 +0000
Message-ID: <20120731021816.GA12640@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120730203844.GA23892@dcvr.yhbt.net>
 <5016F832.7030604@pobox.com>
 <20120730221548.GA388@dcvr.yhbt.net>
 <50172F10.2030402@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 04:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw22f-0008R1-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 04:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab2GaCSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 22:18:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59534 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476Ab2GaCST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 22:18:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9E511F720;
	Tue, 31 Jul 2012 02:18:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <50172F10.2030402@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202624>

Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.30 3:15 PM, Eric Wong wrote:
> >> Right now, canonicalization is a bug generator.  Paths and URLs have to be in
> >> the same form when they're compared.  This requires meticulous care on the
> >> part of the coder and reviewer to check every comparison.  It scatters the
> >> logic for proper comparison all over the code.  Redundant logic scattered
> >> around the code is a Bad Thing.  It makes it more likely a coder will forget
> >> the logic, or get it wrong, and a human reviewer must be far more vigilant.
> > 
> > <snip>  I agree completely with canonicalization.
> 
> Sorry, I'm not sure what you're agreeing with.

That's it's a bug generator and we shouldn't have redundant logic.
Having functions to compare objects themselves is a good thing.

> >> The only downside is when chasing down a bug related to canonicalization one
> >> might have to realize that eq is overloaded.
> > 
> > Having to realize eq is overloaded is a huge downside to me.
> 
> Presumably you'd be reviewing the change which implements the overloaded
> objects, so you'd know about it.  And it would be documented.

The change itself is easy to review.   Picking up the code a few
months/years down the line and having to know "eq" is overloaded
tends to bite people.

> I've listed a bunch of concrete positives for using comparison overloaded
> URI/path objects vs how it's currently being done.  How about you voice some
> of the downsides in concrete terms?  Or an alternative that solves the current
> problems?

Any custom comparison function would do the trick (e.g. URI::eq()).

I _want_ URI/path objects.  I do not want a bare "eq" operator to
obscure the fact it's calling URI::eq() behind-the-scenes.

That said, I don't mind overloads when it's obvious an overload is being
used (e.g. stringify).  It's things like "eq" which obscure the fact
function calls are happening in the background.
