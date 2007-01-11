From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bug-ish: CRLF endings and conflict markers
Date: Thu, 11 Jan 2007 05:41:11 -0500
Message-ID: <20070111104111.GF28309@spearce.org>
References: <200701110941.22024.andyparkins@gmail.com> <20070111095046.GA28309@spearce.org> <Pine.LNX.4.63.0701111057110.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070111101653.GC28309@spearce.org> <Pine.LNX.4.63.0701111123280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 11:41:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4xN0-0007QH-5f
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 11:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbXAKKlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 05:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbXAKKlP
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 05:41:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38686 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030262AbXAKKlP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 05:41:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4xMx-0007pY-IH; Thu, 11 Jan 2007 05:41:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 838D420FBAE; Thu, 11 Jan 2007 05:41:11 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701111123280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36578>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 11 Jan 2007, Shawn O. Pearce wrote:
> > That's a lot of work and goes very much against the Git mindset that
> > we never alter content, just store it as-is.
> 
> While that is correct, we also _use_ the content, and very much alter it 
> all the time. A diff, for example, is nothing but altered content.

Yes, of course.  But we don't take A and store A' in the ODB during
a commit.  We always assert that if you give us A, you'll get back A.
You can always ask us to compute some sort of A' later on, but that
is always based on the originally stored A.

You can also ask us to combine an A and B and get some new thing C.
But again, we don't then go off and store C' instead of C.
 
> > All I want is to make the user realize what they have done.  "Hey dummy, 
> > you just changed the entire file and the only difference I see for most 
> > lines is simply the addition/removal of a CR.  You shouldn't do that!".  
> > The pre-commit hook is the perfect place for that.
> 
> This sounds sensible. I mistook your task to be integrator for people you 
> can't smack.

To some extent I am.  But I have patched the local Cygwin package
I use to distribute Git to everyone to have a 1 line pre-commit
update hook (and no other hooks) which just invokes a Perl script
in /usr/local/bin, and that Perl script is also in the same Cygwin
package.

So Cygwin's "feature" of making all Git hooks executable by default
in a new repository plays in my favor here.  The pre-commit hook is
active in every repository by default, and it just execs a standard
script which can be modified at any time.  So I can easily update
everyone's pre-commit hook at once.

Currently the hook script is just the stock one that comes with Git,
except it ignores CRLF line endings.  I'll likely tweak it as I'm
suggesting, make the CRLF->LF/LF->CRLF check an optional feature
that can be toggled on/off in the top of the script, and submit the
patch to update the stock hook.  Others may find the check useful.

-- 
Shawn.
