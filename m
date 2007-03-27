From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 16:54:33 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703271602110.6485@iabervon.org>
References: <1174825838.12540.5.camel@localhost> <20070326220302.GH22773@admingilde.org>
 <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <200703270117.59205.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0703270952020.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703271338210.6485@iabervon.org>
 <Pine.LNX.4.64.0703271115580.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 22:54:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWIgh-0001at-8u
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 22:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934203AbXC0Uyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 16:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934207AbXC0Uyg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 16:54:36 -0400
Received: from iabervon.org ([66.92.72.58]:2933 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934203AbXC0Uye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 16:54:34 -0400
Received: (qmail 4420 invoked by uid 1000); 27 Mar 2007 16:54:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Mar 2007 16:54:33 -0400
In-Reply-To: <Pine.LNX.4.64.0703271115580.6730@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43305>

On Tue, 27 Mar 2007, Linus Torvalds wrote:

> On Tue, 27 Mar 2007, Daniel Barkalow wrote:
> > 
> > Is it fair to say that subproject support means that there's a use case 
> > where everybody will need shallow clones? And that it points out natural 
> > triggers for shallowness?
> 
> No.
> 
> I personally don't believe in shallow clones. And I *certainly* don't 
> believe that it has anything to do with subprojects. So people may want 
> shallow clones, but it's at least independent of the issue of submodules.
> 
> With subprojects, it's not that you don't want the history. It's just that 
> you don't want the history for *all* projects. Most people care about a 
> very small subset.

Are you talking about submodule history, or submodule state? If they care 
about any state but not the corresponding history, they need to do a 
shallow clone of the subproject, right?

Or are you assuming that people only want to have every subproject either 
there with full history or entirely absent?

I think that one common thing would be to care about the sequence of linux 
kernel snapshots selected by openembedded in their commits, without caring 
about the linux kernel history in between those snapshots. And they 
probably even want to bisect the superproject (still without getting into 
kernel versions that were never in superproject commits), so they can 
track down what caused their PDA to stop booting, where it's not clear 
which program is even responsible. Maybe once the bug is down to a single 
superproject commit, they'd want the history for the responsible 
subproject.

In any case, I think that the superproject object database needs to keep 
track of where references came from (e.g., if you pull somebody's 
superproject commit, and the point of that commit is to use a 
custom-modified subproject commit, that subproject commit must come from 
the same person, and you need to be able to fetch it correctly after the 
fact if you don't get it immediately, even if you've personally forgotten 
the URL).

> (The exception, of course, is when the superproject simply isn't that big, 
> and only has a couple of subprojects. In git, for example, the xdiff stuff 
> could be a subproject if you wanted to do it that way. But then, the 
> subproject isn't a size issue, it's purely an organizational thing, and 
> there is no argument for/against shallowness there either).

Of course. And to make this use case also viable, it's probably necessary 
to be able to tell git to fetch these subprojects automatically, because 
you'll be sad if you leave for a long plane trip with the latest git but 
not the xdiff it uses. (Clearly an application for .gitattributes, but 
that'd be extra fun to implement.)

	-Daniel
*This .sig left intentionally blank*
