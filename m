From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 17:34:51 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901111727510.19665@iabervon.org>
References: <200901111602.53082.borntraeger@de.ibm.com>  <200901111607.59054.borntraeger@de.ibm.com>  <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de>  <200901111620.03345.borntraeger@de.ibm.com>  <alpine.LFD.2.00.0901111113150.6528@localhost.localdomain>
  <20090111194258.GA4840@uranus.ravnborg.org>  <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain> <f19298770901111417t6762e1e3x79b2f488ee6f1243@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 23:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8un-0000Lc-5V
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 23:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZAKWey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 17:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbZAKWex
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 17:34:53 -0500
Received: from iabervon.org ([66.92.72.58]:58884 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbZAKWex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 17:34:53 -0500
Received: (qmail 4662 invoked by uid 1000); 11 Jan 2009 22:34:51 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jan 2009 22:34:51 -0000
In-Reply-To: <f19298770901111417t6762e1e3x79b2f488ee6f1243@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105243>

On Mon, 12 Jan 2009, Alexey Zaytsev wrote:

> On Sun, Jan 11, 2009 at 23:04, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Sun, 11 Jan 2009, Sam Ravnborg wrote:
> >>
> >> The cost of moving this piece of history from one git tree to another
> >> git tree is that we make it harder to debug the kernel for the advanced user
> >> that knows how to do bisect.
> >>
> >> It is not like this history would be lost - one just had to look
> >> somewhere else to find it.
> >>
> >> That may be a bad pain/benefit ratio - time will tell.
> >
> > Umm. No.
> >
> > Time is exactly what makes it useful. It will make all the downsides
> > shrink, and the advantages stay.
> >
> >> There should be a way to avoid such pain when bisecting without
> >> having to mark a semi-random (for the average person) commit as good.
> >
> > Well, you don't actually have to mark that semi-random one as good either.
> > What you can do is to just mark anything that _only_ contains fs/btrfs as
> > good. IOW, you don't have to know the magic number - you just have to be
> > told that "oh, if you only have btrfs files, and you're not actively
> > bisecting a btrfs bug, just do 'git bisect good' and continue".
> >
> > Yeah, you'll hit it a few times, but you don't even have to compile things
> > or boot anything, so it's not actually going to be all that much slower
> > than just knowing about the magic point either.
> 
> But would not such bug avoid being bisected if you blindly
> mark btrfs commits as good?
> 
> v2.6.29 <-- bad
> ...
> ...
> ...
> btrfs stuff <-- mark as good
> ...
> the-real-bug
> ...
> v2.6.28 <-- good
> 
> So you hit the btrfs commit, mark it as good, leaving the real bug below,
> and the bisection continues, with both sides being actually bad.
> 
> Am I missing something?

Yes, there are no kernel bugs below the btrfs stuff, because there's no 
kernel at all below the btrfs stuff. The history is actually like:

A -- B -- C -- D -- G
              /
        F -- E

F and E are the btrfs stuff, while A-D and G are commit containing the 
kernel source (D and G also containing btrfs). Marking E as good cuts off 
F, but doesn't cut off anything at all on the top line. Of course, if 
you're actually debugging a problem with btrfs that you somehow know to 
have worked while btrfs was a separate module at so point, you would want 
to get into this history (and would build it as a separate module in order 
to do so).

	-Daniel
*This .sig left intentionally blank*
