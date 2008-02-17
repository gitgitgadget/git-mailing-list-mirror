From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: warning: no common commits - slow pull
Date: Sun, 17 Feb 2008 15:41:49 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171437460.5816@iabervon.org>
References: <200802102007.38838.lenb@kernel.org> <7vd4r4clnb.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802162239090.5496@iabervon.org> <alpine.LSU.1.00.0802171449230.30505@racer.site> <7vhcg71n9u.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0802171925330.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Len Brown <lenb@kernel.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 21:42:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQqLC-0000gh-Ct
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 21:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbYBQUlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 15:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbYBQUlv
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 15:41:51 -0500
Received: from iabervon.org ([66.92.72.58]:53741 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039AbYBQUlu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 15:41:50 -0500
Received: (qmail 11438 invoked by uid 1000); 17 Feb 2008 20:41:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 20:41:49 -0000
In-Reply-To: <alpine.LSU.1.00.0802171925330.30505@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74180>

On Sun, 17 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 17 Feb 2008, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Sat, 16 Feb 2008, Daniel Barkalow wrote:
> > >
> > >> I wonder if the problem is that something isn't getting reinitialized 
> > >> for the second connection. It's not a separate invocation of 
> > >> fetch-pack, and I can't say for sure that it's sending the right info 
> > >> to the server when the statics in builtin-fetch-pack.c are left over 
> > >> from the earlier call. This would particularly explain the 
> > >> information that hitting ctrl-c and trying again fixes it.
> > >
> > > Oh, that should be it!  After all, the code in get_rev() in 
> > > builtin-fetch-pack.c marks commits as SEEN and COMMON and POPPED.
> > 
> > I seem to be slow today, but how does that explain that the problem is 
> > reported only by Len so far?
> 
> Hmm.  The code I was referencing is only in "next" so far, right?  And 
> AFAICT it only occurs when you are fetching something which autofetches 
> tags, right?

I think the code you referenced is quite old; the new thing is having it 
called twice in the same process, and that's also in "master" along with 
builtin-fetch, I think.

> But thinking about this again: do we reuse the connection also for 
> automatic tag fetching?  If not, my whole reasoning is wrong.

No, the way the protocol works, you can't request more stuff after you've 
received stuff on a connection, so we have to start a second one for that 
case.

	-Daniel
*This .sig left intentionally blank*
