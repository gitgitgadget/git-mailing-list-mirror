From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: svn:externals using git submodules
Date: Tue, 1 May 2007 15:17:03 -0400
Message-ID: <20070501191703.GA25287@pe.Belkin>
References: <200705011121.17172.andyparkins@gmail.com> <20070501152228.GF5942@spearce.org> <20070501153626.GA21182@pe.Belkin> <200705011936.14345.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 21:17:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HixqZ-0003gb-Df
	for gcvg-git@gmane.org; Tue, 01 May 2007 21:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161530AbXEATRH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 15:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161793AbXEATRH
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 15:17:07 -0400
Received: from eastrmmtao107.cox.net ([68.230.240.59]:33244 "EHLO
	eastrmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161530AbXEATRG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 15:17:06 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070501191705.BMMA16669.eastrmmtao107.cox.net@eastrmimpo02.cox.net>;
          Tue, 1 May 2007 15:17:05 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id tvH31W00P0epFYL0000000; Tue, 01 May 2007 15:17:03 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1HixqR-0006aZ-MV; Tue, 01 May 2007 15:17:03 -0400
Content-Disposition: inline
In-Reply-To: <200705011936.14345.andyparkins@gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45973>

On Tue, May 01, 2007 at 07:36:11PM +0100, Andy Parkins wrote:
> On Tuesday 2007, May 01, Chris Shoemaker wrote:
> 
> > > Actually that is an interesting point that Chris makes.  Isn't the
> > > svn:externals property revision controlled on the parent directory?
> > > So each change to it is actually recorded in the revision history
> > > of the parent project.
> >
> > Yes and yes.
> 
> Yes and no.  Think of svn:externals as a file in the parent repository; 
> it contains
> 
>  directory-name URL
> 
> Now, changes to that file _are_ tracked, in that if I changed the URL 
> that change would be recorded in the parent repository.  However, 
> nowhere is the revision of the external recorded.  Subversion always 
> fetches the latest revision at that URL.

That's only true when the revision is not specified in the external.
The repo you track may not do that, but it's not uncommon to do so.
And, as I think you're pointing out, it's the only way to get any sort
of reliable information about the relationship between the parent and
the external.

I think it would probably be undesirable for git-svn to attempt to
convert "floating" externals into well-versioned submodules, since
they're not even well-versioned in the svn repo.  However, handling
the "locked-down" externals is quite another thing.

> 
> > > And if every svn:externals URL included the
> > > exact version of the other project to include, aren't svn:externals
> > > then more-or-less like the subproject link support, except they
> > > also include the URL?
> >
> > Just to clarify, my point was just that Andy's setup seems to assume
> > that the externals don't specify a revision.  If they do, maybe
> 
> They don't.  If they did, they'd be just as useful as git's submodules.
>
> > git-svn can map the externals into subprojects.  Is this what
> > you're thinking?
> 
> Well, I'm thinking that that information /can/ be reconstructed from the 
> revision date information - kind of - the problem is that there is no 
> way to know when the parent updated the module.   svn:externals really 
> is just a quick way of doing
>  $ cd submodule
>  $ svn update
> That's it.  That's all you get.  We could guess that when the parent 
> module was at date YYYY-MM-DD, that the submodule would be at that same 
> date - but who knows?

svn users who want the externals to meaningfully define the version
relationship between the parent and the project already have to use
externals that specify a revision.

-chris
