From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when
 appropriate to do so
Date: Tue, 13 Oct 2009 17:31:46 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910131654270.32515@iabervon.org>
References: <0016e68fd0123a175304754694b4@google.com> <200910122340.13366.trast@student.ethz.ch> <7vr5t89qiw.fsf@alter.siamese.dyndns.org> <200910130836.57011.trast@student.ethz.ch> <7vljjf226t.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0910131358000.32515@iabervon.org>
 <7vljjfuibr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Euguess@gmail.com, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:43:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxp9F-0004He-1b
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 23:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761448AbZJMVcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 17:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761432AbZJMVcX
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:32:23 -0400
Received: from iabervon.org ([66.92.72.58]:38612 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761442AbZJMVcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:32:23 -0400
Received: (qmail 7592 invoked by uid 1000); 13 Oct 2009 21:31:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Oct 2009 21:31:46 -0000
In-Reply-To: <7vljjfuibr.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130216>

On Tue, 13 Oct 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I suspect that a very common pattern for people who follow trees for 
> > testing and such or who only develop in topic branches is:
> > ...
> > << many issues with this kind of DWIM omitted >>
> > ...
> > On the second cycle, either git refuses or does something actively 
> > confusing to this user, and the user has to learn the difference between 
> > local branches and remote branches on the *second* cycle. IMHO, it's much 
> > better to make users learn things at the point when they don't think they 
> > know how to use the system, rather than when they think they understand it 
> > and are just trying to get things done.
> 
> Yeah, and I think J6t pointed out the same issue.
> 
> I think it tells us something, after some of "the most trusted Git
> contributors" thought "really long and hard, and making sure to take
> user-friendliness into account at least as much as simplicity of
> implementation", they are getting to the same conclusion that this
> particular DWIMery is a misguided attempt to be helpful without really
> helping but rather hurting the users.
> 
> I will stop trying to come up with a strawman for other people's itch that
> I do not agree to begin with, at least for now.  I will still look at
> concrete and workable proposals from other people, though.

I personally think that the real issue is that our "detached HEAD" message 
is still too scary, and what we really want is to issue the scary message 
when using "git commit" to move a detached HEAD from what was checked out 
to a new commit. So:

$ git checkout origin/next
(friendly message telling you you're browsing history)
$ git commit
(scary message telling you you're not on any branch)
$ git commit
(one line message like usual, except "detached HEAD" instead of branch 
name)

This still makes sure that you get the scary message before you could lose 
track of your work, but only gives it to you at the point where there's a 
commit that's in your HEAD and nowhere else.

The other thing that I think would be nice is:

$ git checkout origin/next
$ git fetch origin
$ git checkout !! (probably not a good syntax)

That is, expand "!!" to the string used to detach HEAD, and expand it 
again now. (Of course, something would have to be done if you did "git 
checkout HEAD^1" before, or "git checkout !!^1".) This is related in that 
I think the scary message should happen when "git commit" sees this stored 
string and clears it.

	-Daniel
*This .sig left intentionally blank*
