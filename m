From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What to expect after 0.99.8
Date: Tue, 4 Oct 2005 03:31:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510040321170.23242@iabervon.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 09:27:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMhBz-0008Kx-6c
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 09:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbVJDH0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 03:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVJDH0T
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 03:26:19 -0400
Received: from iabervon.org ([66.92.72.58]:14088 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932463AbVJDH0T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 03:26:19 -0400
Received: (qmail 32144 invoked by uid 1000); 4 Oct 2005 03:31:00 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Oct 2005 03:31:00 -0400
To: Dan Aloni <da-x@monatomic.org>
In-Reply-To: <20051004071210.GA18716@localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9667>

On Tue, 4 Oct 2005, Dan Aloni wrote:

> On Mon, Oct 03, 2005 at 04:16:27PM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Mon, 3 Oct 2005, Junio C Hamano wrote:
> > > 
> > > This reminds me of one patch:
> > > 
> > >     From: Dan Aloni <da-x@monatomic.org>
> > >     Subject: [PATCH] Fix git+ssh's indefinite halts during long fetches
> > >     Date: Sat, 1 Oct 2005 21:39:42 +0300
> > >     Message-ID: <20051001183942.GA2099@localdomain>
> > > 
> > > I'd appreciate it if you had a chance to take a look at it and
> > > comment on it.
> > 
> > I personally hate it.
> > 
> > It adds horrible patches to fairly core stuff, all because the prefetching 
> > is not limited.
> 
> Well it can be reworked to be more clean...
>  
> > As far as I can tell, it should be much easier to just limit the 
> > prefetching to some reasonable limit (say, a few objects deep), which 
> > guarantees that the prefetching doesn't fill up the write queues on the 
> > fetching side.
> 
> I'm not sure how this will be completely reliable, even if you limit the
> prefetching to one object.
> 
> Suppose that this one object's size is larger than the receiving queues of 
> the receiving end (like 1 MB?) and the bandwidth is high, wouldn't that 
> break?

It shouldn't cause any problem, unless there isn't a 4K buffer between the 
git-ssh-fetch and ssh; the fetch side would have to fill this buffer 
before getting stuck, even if ssh can't send out any more data until the 
object has been read, and 100 requests (each 21 bytes) wouldn't be enough. 
I remember that there's a lot that depends on being able to put 4K into an 
empty pipe without blocking, and I'd guess that UNIX sockets have a 
similar capacity (although I'm not going to look it up tonight).

	-Daniel
*This .sig left intentionally blank*
