From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: add -i not able to find get_colorbool
Date: Mon, 17 Dec 2007 16:43:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712171639200.9446@racer.site>
References: <Pine.LNX.4.64.0712171400250.9446@racer.site>
 <20071217143100.GA21122@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 17:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4J4Q-0002Dk-2C
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 17:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806AbXLQQne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 11:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbXLQQnd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 11:43:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:38214 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752301AbXLQQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 11:43:33 -0500
Received: (qmail invoked by alias); 17 Dec 2007 16:43:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 17 Dec 2007 17:43:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/LuCwFORbLKCXYB5+qZcHelOs8gDYgh4Kc9ns5sT
	z5L6aHbLtWkDsF
X-X-Sender: gene099@racer.site
In-Reply-To: <20071217143100.GA21122@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68578>

Hi,

On Mon, 17 Dec 2007, Jeff King wrote:

> On Mon, Dec 17, 2007 at 02:04:21PM +0000, Johannes Schindelin wrote:
> 
> > The second line of git-add--interactive reads thusly:
> > 
> > 	use lib (split(/:/, $ENV{GITPERLLIB} || 
> > 		"/home/gitte/lib/perl5/site_perl/5.8.8"));
> > 
> > and this puzzles me:
> > 
> > 	$ grep -n get_colorbool /home/gitte/lib/perl5/site_perl/5.8.8/Git.pm
> > 	584:=item get_colorbool ( NAME )
> > 	591:sub get_colorbool {
> > 
> > So it has it, but cannot locate get_colorbool?
> 
> That does seem odd. Can you try running git-add--interactive in the perl 
> debugger and doing this:
> 
>   x \&Git::get_colorbool
>   x \&Git::repository
> 
> It should tell you where it is getting the functions from (in the first 
> case, it will presumably not find it at all, but you seem to have a 
> Git::repository, so it should point to the file that has been loaded).

Good call!

	main::(/home/gitte/bin/git-add--interactive:8):
	8:      my ($prompt_color, $header_color, $help_color, $normal_color);
	  DB<1> x \&Git::get_colorbool
	0  CODE(0x853b25c)
	   -> &CODE(0x853b25c) in ???
	  DB<2>   x \&Git::repository
	0  CODE(0x833e8ac)
	   -> &Git::repository in 
	/home/gitte/lib/perl5/site_perl/5.8.8/i586-linux-thread-multi/Git.pm:145-217

So it seems that somehow on 8. Nov 10:42 Git.pm was installed into 
i586-linux-thread-multi/ and is preferred over the Git.pm which was 
installed on 6. Dec 12:24 into site_perl/5.8.8/.

I have no idea how that happened on Nov 8, could be that I was desperate 
enough to hand-copy Git.pm there.  Git.pm seems to hate me (this was not 
the first time I had problems with it).

Ciao,
Dscho
