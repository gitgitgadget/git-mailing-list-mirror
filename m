From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries
 too.
Date: Mon, 4 Jun 2007 13:45:26 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706041336440.23741@woody.linux-foundation.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com>
 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
 <alpine.LFD.0.98.0706040857380.23741@woody.linux-foundation.org>
 <20070604175751.GL19935@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Jun 04 22:46:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvJRC-0004XR-NE
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 22:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbXFDUpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 16:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXFDUpz
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 16:45:55 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:52565 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447AbXFDUpy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 16:45:54 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l54KjVY3001491;
	Mon, 4 Jun 2007 13:45:33 -0700
In-Reply-To: <20070604175751.GL19935@cip.informatik.uni-erlangen.de>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-3.29 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49127>



On Mon, 4 Jun 2007, Thomas Glanzmann wrote:
> 
> >  - instead of doing a "git pull" that merges the two branches (your work, 
> >    and the work that happened by somebody else in the central repo while 
> >    you did it), you *may* also just want to do a "git fetch" to fetch the 
> >    changes from the central repo, and then do "git rebase origin" to 
> >    linearize the work you did on _top_ of those central repo one (so that 
> >    it no longer looks like a branch, and looks linear)
> > 
> >    In the "git rebase" case, you'll effectively merge your commits one at 
> >    a time, and you may thus have to fix up *multiple* conflicts. So it's 
> >    potentially more work, but it results in a simpler history if you want 
> >    it.
> 
> Thank you a lot. I finally understood what "git rebase" is all about!

I'd like to point out some more upsides and downsides of "git rebase".

Downsides:

 - you're rewriting history, so you MUST NOT have made your pre-rebase 
   changes available publicly anywhere else (or you are in a world of pain 
   with duplicate history and tons of confusion)

 - you can only rebase "simple" commits. If you don't just have a linear 
   history of your own commits, but have merged from others, rebasing 
   isn't a sane alternative (yeah, we could make it do something half-way 
   sane, but really, it's not worth even contemplating)

Upsides:

 - while there may be more conflicts you have to sort out, they may be 
   individually  simpler, so you *might* actually prefer to do it that 
   way.

 - if the reason for the conflicts is that upstream did some nice cleanup 
   in the same area, and you decide that you would actually want to re-do 
   your development based on that nice cleanup, then "git rebase" can 
   actually be used as a way to help you do exactly that. IOW, you can 
   take _advantage_ of the conflicts as a way to re-apply the patches but 
   also then fix them up by hand to work in the new (better) world order.

And finally, the upside that is probably the most common case for using 
"git rebase", and has nothing to do with resolving conflicts before 
pushing them out with "git push":

 - if you actually want to send your changes upstream as emailed *patches* 
   rather than by pushing them out (or asking somebody else to pull them),
   rebasing is an excellent way to keep the set of patches "fresh" on top 
   of the current development tree.

   People who send their patches out as emails are also unlikely to have 
   the downsides (ie they normally send them as patches exactly *because* 
   they don't want to make their git trees public, and they probably just 
   have a small set of simple patches in their tree anyway)

So I have to say, I'm still very ambivalent about rebasing. It's 
definitely a very useful thing to do, but at the same time I think "git 
pull" in many ways is often the more honest and correct way to do things.

		Linus
