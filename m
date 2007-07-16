From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Mon, 16 Jul 2007 02:19:48 -0400
Message-ID: <20070716061948.GG32566@spearce.org>
References: <469A2B1D.2040107@alum.mit.edu> <alpine.LFD.0.999.0707151119120.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 08:20:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAJw6-0002VT-9W
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 08:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbXGPGTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 02:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbXGPGTz
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 02:19:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48977 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbXGPGTy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 02:19:54 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAJvx-0001Pj-EW; Mon, 16 Jul 2007 02:19:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7231820FBAE; Mon, 16 Jul 2007 02:19:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707151119120.20061@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52645>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sun, 15 Jul 2007, Michael Haggerty wrote:
> > 2. It appears that author/committer require an email address.  How
> > important is a valid email address here?
> 
> Git itself doesn't really care, and many CVS conversions have just 
> converted the username into "user <user>", but from a QoI standpoint it's 
> much nicer if you at least were to allow the kind of conversion that 
> allows user-name to be associated with an email.
> 
> Maybe git-fast-import could be taught to do the kind of user name 
> conversion that we already do for CVS imports.. Shawn?

It could, but I'm not sure I want to implement it.  ;-)

I pretty much view source->Git translation as the business/policy
of the frontend, not of fast-import.  But we have three frontends
that all share the same file format (git-cvsimport, git-svnimport,
git-svn), and are all independent implementations.  Maybe pushing
it down into a tool like fast-import would benefit a lot of users,
and thus should be done.

I'll put it on my todo list.  Which is much longer than I have
time for.
 
> > 5. Is there any significance at all to the order that commits are output
> > to git-fast-import?  Obviously, blobs have to be defined before they are
> > used, and '<committish>'s have to be defined before they are referenced.
> >  But is there any other significance to the order of commits?
> 
> Not afaik. Git internally very fundamentally simply doesn't care (there 
> simply _is_ no object ordering, there is just objects that point to other 
> objects), and I don't think git-fast-import could possibly care either. 
> You do need to be "topologically" sorted (since you cannot even point to 
> commits without having their SHA1's), but that should be it.

Linus is completely correct here.  The only requirement on data
ordering is that all parent commits (from/merge lines) must
come before any child that depends on them.  But that's a pretty
reasonable request, as almost all VCS systems want data to come in
at least that order, if not something even more strict.

In theory marks could be used to stub in commits and let you feed
them out of order, but to make that work fast-import would need to
buffer them until it saw everything it needed to produce a SHA-1.
Not exactly a good idea.

-- 
Shawn.
