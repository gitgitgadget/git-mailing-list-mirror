From: Jeff King <peff@peff.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 09:46:49 -0400
Message-ID: <20070517134649.GA20853@coredump.intra.peff.net>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517110225.GA3334@steel.home> <20070517124622.GP4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 15:47:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HogJm-0002EZ-AF
	for gcvg-git@gmane.org; Thu, 17 May 2007 15:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbXEQNqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 09:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755492AbXEQNqx
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 09:46:53 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4327 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754497AbXEQNqw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 09:46:52 -0400
Received: (qmail 15951 invoked from network); 17 May 2007 13:46:52 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 17 May 2007 13:46:52 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 17 May 2007 09:46:49 -0400
Content-Disposition: inline
In-Reply-To: <20070517124622.GP4489@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47521>

On Thu, May 17, 2007 at 02:46:22PM +0200, Petr Baudis wrote:

> > why can't I just have _repo_ configuration:
> > 
> >  	[subproject "kernel/"]
> >          	URL = http://www.kernel.org/pub/linux-2.6.git
> > ?
> > It can be first-time cloned from the upstream, but it stays after
> > people change it to suit their systems. They can depend on it not to
> > be broken by upstream.
> 
> Because kernel/ can get removed, moved around, or point at entirely
> *different* projects over time and branches - kernel/ can switch from
> linux-2.4 to linux-2.6, libc/ can switch between glibc and uClibc, ...

I think we clearly need a 2-level system: a tracked pointer to the repo,
with an optional local override.

However, I don't quite like Junio's idea of using the URL as a key,
since it is intended to change. IOW, if I am overriding your URL via
.git/config, if you change your URL then my config is now broken.

Instead, why not:
  1. url location is supplied in configuration as
     [subproject "kernel/"]
       url = git://git.kernel.org/pub/linux-2.4.git
  2. .gitmodules is simply read as a lower-priority version of
     configuration

One advantage of this approach is that it's totally general; instead of
.gitmodules, we could in fact be talking about .gitconfig, a mechanism
for projects to contain tracked configuration that can be overridden by
individual repos. For some projects, I imagine some of the commit
encoding config options might make sense.

Thoughts?

-Peff
