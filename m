From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 18:33:50 -0800
Message-ID: <20070104023350.GA1194@localdomain>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com> <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Shawn Pearce <spearce@spearce.org>,
	Sasha Khapyorsky <sashak@voltaire.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 03:34:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2IQg-0000rv-RU
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 03:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbXADCdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 21:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbXADCdx
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 21:33:53 -0500
Received: from hand.yhbt.net ([66.150.188.102]:60088 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932118AbXADCdw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 21:33:52 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id E2DF17DC094;
	Wed,  3 Jan 2007 18:33:50 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 03 Jan 2007 18:33:50 -0800
To: Chris Lee <chris133@gmail.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35903>

Linus Torvalds <torvalds@osdl.org> wrote:
> On Wed, 3 Jan 2007, Chris Lee wrote:
> > First issue I ran into: On a machine with 4GB of RAM, when I tried to
> > do a full import, git-svnimport died after 309906 revisions, saying
> > that it couldn't fork.

Managing memory with the Perl SVN libraries has been very painful in my
experience.

Part of it is Perl, which (as far as I know) never frees allocated
memory back to the OS (although Perl can reuse the allocated memory for
other things).  I'm CC-ing the resident Perl guru on this...

I'm also fairly certain that most higher-level languages have this
problem.

> I suspect you'd have been better off just re-starting, and using something 
> like
> 
> 	while :
> 	do
> 		git svnimport -l 1000 <...>
> 		.. figure out some way to decide if it's all done ..
> 		git repack -d
> 	done

> However, I don't know what the proper magic is for svnimport to do that 
> sane "do it in chunks and tell when you're all done". Or even better - to 
> just make it repack properly and not keep everything in memory.

<shameless self-promotion>
	git-svn already does this chunking internally

	Just set the repack interval to something smaller than 1000;
	(--repack=100) if you experience timeouts.
</shameless self-promotion>

-- 
Eric Wong
