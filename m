From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: git rev-list ordering
Date: Mon, 17 Nov 2008 02:35:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811170231430.30769@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0811151922310.2935@sys-0.hiltweb.site> <bd6139dc0811151727k605a3575hf409fed32a3a4baf@mail.gmail.com> <alpine.LFD.2.00.0811152040570.2935@sys-0.hiltweb.site> <alpine.DEB.1.00.0811162215370.30769@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0811162001550.28544@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sverre@rabbelier.nl, Git Mailing List <git@vger.kernel.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 02:28:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1sv5-0004VK-RT
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 02:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbYKQB1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 20:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbYKQB1h
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 20:27:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:52940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751497AbYKQB1g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 20:27:36 -0500
Received: (qmail invoked by alias); 17 Nov 2008 01:27:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 17 Nov 2008 02:27:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/i6y5bnVbiV+oH2G9te64pVoWIAk7LgjMGUaCxGt
	T15n3H7y7Us7/7
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0811162001550.28544@sys-0.hiltweb.site>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101191>

Hi,

On Sun, 16 Nov 2008, Ian Hilt wrote:

> On Sun, 16 Nov 2008, Johannes Schindelin wrote:
> 
> > On Sat, 15 Nov 2008, Ian Hilt wrote:
> > 
> > > On Sat, 15 Nov 2008, Sverre Rabbelier wrote:
> > > > The --reverse is applied after the --max-count, so you are seeing 
> > > > the reverse of one commit ;). For comparison, have a look at:
> > > > 
> > > > $ git rev-list --reverse --max-count=2
> > > 
> > > Ah, I see.  So if you didn't want the sorting to take a long time 
> > > for many commits, you would limit the output to n commits, then sort 
> > > the output.  Is this the logic behind this design?
> > 
> > Yes.  It is by design, since the guy who wrote the initial --reverse 
> > support cannot think of an interesting situation where you need to 
> > list the oldest n commits.
> 
> I see.  Well, the situation in which I found this to be needed was while 
> trying to figure out how to find the next commit on branch X while on a 
> detached head from that branch without counting how many commits back I 
> was.  In other words,
> 
> $ git checkout X~4
> $ # now I want X~3 without using a number or carets
> $ git checkout $(git rev-list --reverse ..X | head -1)
>  -- or --
> $ git checkout $(git rev-list ..X | tail -1)

This could break down horribly when there was branching going on.  
However, in case you are certain there is only one child of X~4, I'd 
suggest doing this:

$ git checkout $(git rev-list --parents --all ^HEAD |
	sed -n "s/ .*$(git rev-parse HEAD).*$//p")

IOW I would list all revisions with parents, and filter out all which do 
not have the current one as parent.

Hth,
Dscho
