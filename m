From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 22:38:33 -0800
Message-ID: <7vmzjom00m.fsf@assigned-by-dhcp.cox.net>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
	<7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
	<20051128105736.GO22159@pasky.or.cz>
	<7vsltgtvk4.fsf@assigned-by-dhcp.cox.net>
	<20051128212804.GV22159@pasky.or.cz>
	<Pine.LNX.4.64.0511281420390.3263@g5.osdl.org>
	<Pine.LNX.4.64.0511281845280.25300@iabervon.org>
	<Pine.LNX.4.64.0511281637480.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282027360.25300@iabervon.org>
	<Pine.LNX.4.64.0511281837040.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282208050.25300@iabervon.org>
	<Pine.LNX.4.64.0511282029290.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282337170.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 08:08:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egz8p-00027N-Bp
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 07:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVK2Gig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 01:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVK2Gig
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 01:38:36 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38053 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751312AbVK2Gif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 01:38:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129063836.SMBN25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 01:38:36 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0511282337170.25300@iabervon.org> (Daniel
	Barkalow's message of "Tue, 29 Nov 2005 01:02:07 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12924>

Daniel Barkalow <barkalow@iabervon.org> writes:

> the two-way merge. That is, what I want to have work is:
>
>   server$ git checkout production
>   work$ git push server:production
>   server$ git checkout
>
> and this should leave the working tree on server with the changes pushed 
> from work.

I think the approach Linus was suggesting before he suggested
the funny refs/heads/../.. symlink idea (honestly, I think he
was half joking) is cleaner, easier to understand, easier to
implement and generally makes more sense.  Your work cycle would
become like this:

    server$ git checkout production
    work$ git checkout master
    work$ git pull server production ;# merge into work's master
    work$ git push server master:receive_from_work
    server$ git pull . receive_from_work ;# merge into server's production

and you make sure receive_from_work is not checked out on server
(or production is never pushed into) and always do fast forward
and nothing else.
