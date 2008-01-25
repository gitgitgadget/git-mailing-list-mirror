From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 14:09:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801251355490.13593@iabervon.org>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org> <m3fxwlagbu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JITwJ-0007aM-E7
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 20:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbYAYTJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 14:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbYAYTJk
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 14:09:40 -0500
Received: from iabervon.org ([66.92.72.58]:56677 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358AbYAYTJj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 14:09:39 -0500
Received: (qmail 26601 invoked by uid 1000); 25 Jan 2008 19:09:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2008 19:09:30 -0000
In-Reply-To: <m3fxwlagbu.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71729>

On Fri, 25 Jan 2008, Jakub Narebski wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This allows users with different preferences for access methods to the
> > same remote repositories to rewrite each other's URLs to get the
> > desired access.
> 
> [...]
> > +host.<name>.base::
> > +	The base URL which should be used for this particular
> > +	host. This can be used by a user who has a better access
> > +	method to a repository than other users to make use of the
> > +	preferable path despite getting URLs from other users using
> > +	more commonly-available methods. Alternatively, a user who
> > +	only has less privileged access to a repository than the usual
> > +	audience can use this mechanism to replace disallowed methods
> > +	with public ones.
> > +
> > +host.<name>.alias::
> > +	Additional base URLs which refer to this host. If a URL
> > +	matches this, any access to it will use the URL formed with
> > +	the corresponding base URL instead of the given URL.
> > +
> 
> From this I could not get how those configuration are meant to be
> used. Perhaps some usage example?

[host "kernel"]
        base = git://git.kernel.org/pub/
        alias = git+ssh://master.kernel.org/pub/
	alias = master.kernel.org:/pub/

> BTW. wouldn't the same be solved better by enabling remote.<name>.url
> to be multi-valued, first working for fetch, all URLs for push?

The real point is actually for when you're dealing with URLs on the 
command line which you've cut-and-paste from email or other things. For 
example, the patches in the -mm quilt series say where the git trees are, 
but they're all like 
"git+ssh://master.kernel.org/pub/scm/linux/kernel/git/dtor/input.git", 
which is ideal for people (like Andrew) who have accounts on master, but 
requires manual fixing for people (like me) who don't.

With the above config, I can do:

git fetch git+ssh://master.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

and it actually fetches

git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git, which 
actually works for me.

	-Daniel
*This .sig left intentionally blank*
