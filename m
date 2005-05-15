From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Sun, 15 May 2005 14:40:42 +0200
Message-ID: <20050515124042.GE13024@pasky.ji.cz>
References: <200505151122.j4FBMJa01073@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mpm@selenic.com, git@vger.kernel.org, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, mercurial@selenic.com,
	torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sun May 15 14:41:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXIQy-0005RL-3z
	for gcvg-git@gmane.org; Sun, 15 May 2005 14:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbVEOMlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 08:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbVEOMlT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 08:41:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48048 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262826AbVEOMkq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 08:40:46 -0400
Received: (qmail 29398 invoked by uid 2001); 15 May 2005 12:40:42 -0000
To: "Adam J. Richter" <adam@yggdrasil.com>
Content-Disposition: inline
In-Reply-To: <200505151122.j4FBMJa01073@adam.yggdrasil.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 01:22:19PM CEST, I got a letter
where "Adam J. Richter" <adam@yggdrasil.com> told me that...
> On Sun, 15 May 2005 10:54:05 +0200, Petr Baudis wrote:
> >Dear diary, on Thu, May 12, 2005 at 10:57:35PM CEST, I got a letter
> >where Matt Mackall <mpm@selenic.com> told me that...
> >> Does this need an HTTP request (and round trip) per object? It appears
> >> to. That's 2200 requests/round trips for my 800 patch benchmark.
> 
> >Yes it does. On the other side, it needs no server-side CGI. But I guess
> >it should be pretty easy to write some kind of server-side CGI streamer,
> >and it would then easily take just a single HTTP request (telling the
> >server the commit ID and receiving back all the objects).
> 
> 	I don't understand what was wrong with Jeff Garzik's previous
> suggestion of using http/1.1 pipelining to coalesce the round trips.
> If you're worried about queuing too many http/1.1 requests, the client
> could adopt a policy of not having more than a certain number of
> requests outstanding or perhaps even making a new http connection
> after a certain number of requests to avoid starving other clients
> when the number of clients doing one of these transfers exceeds the
> number of threads that the http server uses.

The problem is that to fetch a revision tree, you have to

	send request for commit A
	receive commit A
	look at commit A for list of its parents
	send request for the parents
	receive the parents
	look inside for list of its parents
	...

(and same for the trees).

> 	Being able to do without a server side CGI script might
> encourage deployment a bit more, both for security reasons and
> effort of deployment.

You could still use it without the server side CGI script as it is now,
just without the speedups.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
