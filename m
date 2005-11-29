From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Tue, 29 Nov 2005 01:57:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511290141220.25300@iabervon.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
 <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org> <Pine.LNX.4.64.0511282027360.25300@iabervon.org>
 <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org> <Pine.LNX.4.64.0511282208050.25300@iabervon.org>
 <Pine.LNX.4.64.0511282029290.3177@g5.osdl.org> <Pine.LNX.4.64.0511282337170.25300@iabervon.org>
 <7vmzjom00m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 08:09:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgzQI-0005Sj-C7
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 07:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbVK2G4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 01:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbVK2G4l
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 01:56:41 -0500
Received: from iabervon.org ([66.92.72.58]:18704 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751333AbVK2G4l (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 01:56:41 -0500
Received: (qmail 4973 invoked by uid 1000); 29 Nov 2005 01:57:09 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Nov 2005 01:57:09 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzjom00m.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12925>

On Mon, 28 Nov 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > the two-way merge. That is, what I want to have work is:
> >
> >   server$ git checkout production
> >   work$ git push server:production
> >   server$ git checkout
> >
> > and this should leave the working tree on server with the changes pushed 
> > from work.
> 
> I think the approach Linus was suggesting before he suggested
> the funny refs/heads/../.. symlink idea (honestly, I think he
> was half joking) is cleaner, easier to understand, easier to
> implement and generally makes more sense.  Your work cycle would
> become like this:
> 
>     server$ git checkout production
>     work$ git checkout master
>     work$ git pull server production ;# merge into work's master
>     work$ git push server master:receive_from_work
>     server$ git pull . receive_from_work ;# merge into server's production
> 
> and you make sure receive_from_work is not checked out on server
> (or production is never pushed into) and always do fast forward
> and nothing else.

That's what I'm doing currently, actually (with work pushing to 
"production", but server having checked out "deploy"), and I find it 
annoying to have to do the pull each time and have a separate head. It 
also means that, if the stuff on the server is set up as a hook, it'll 
have to do the locking against concurrent changes to the working tree in 
pull, which is much more complicated than checkout.

It's also somewhat non-intuitive, and leaves a surprising way for the user 
to confuse the system in a way that it can't detect.

	-Daniel
*This .sig left intentionally blank*
