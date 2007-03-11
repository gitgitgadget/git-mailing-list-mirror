From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] fast-import: tree allocation cleanups
Date: Sun, 11 Mar 2007 11:51:38 -0400
Message-ID: <20070311155138.GA7110@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192114.GA3875@coredump.intra.peff.net> <20070311032147.GA10781@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 16:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQKn-0003Il-NB
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 16:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933787AbXCKPvm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 11:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933788AbXCKPvm
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 11:51:42 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4277 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933787AbXCKPvl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 11:51:41 -0400
Received: (qmail 4046 invoked from network); 11 Mar 2007 11:52:01 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Mar 2007 11:52:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Mar 2007 11:51:38 -0400
Content-Disposition: inline
In-Reply-To: <20070311032147.GA10781@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41933>

On Sat, Mar 10, 2007 at 10:21:47PM -0500, Shawn O. Pearce wrote:

> > +
> > +		t->entries[t->entry_count++] = e;
> This I wouldn't have bothered to do in this patch.  It is just
> unecessary code churning, as you turn around and change this again
> in the next patch.  I actually dropped these two hunks from this
> patch (but left the dang commit message comment in, whoops) and
> moved the first hunk to the next patch.

OK. There are actually two changes: moving the insertion until after
e->name is set up (which has no functionality impact) and changing the
manner of insertion. I split them up to try to make them more readable,
but clearly you figured out what I was going for.

> > +	name = to_atom(p, n);
> [...]
> > -	e->name = to_atom(p, (unsigned short)n);
> 
> You missed an unsigned short cast here.

Actually, I removed it intentionally (though clearly I should have
documented it). It's casting from an unsigned int to an unsigned short.
Such a cast is at best pointless (since the compiler performs the exact
same cast implicitly -- see C99 6.5.2.2, paragraph 7), and at worst
masks an error (e.g., if the type of n is changed).

Is there some subtle issue I'm missing here?

-Peff
