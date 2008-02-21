From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git svn forking an awful lot of "git config"s
Date: Thu, 21 Feb 2008 00:18:42 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802210006590.17164@racer.site>
References: <alpine.LSU.1.00.0802201520580.17164@racer.site> <20080220223953.GA32663@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 01:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRzA6-0006g4-TE
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 01:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933633AbYBUATD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 19:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765706AbYBUATD
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 19:19:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:51177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S935002AbYBUATA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 19:19:00 -0500
Received: (qmail invoked by alias); 21 Feb 2008 00:18:58 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp038) with SMTP; 21 Feb 2008 01:18:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+s+Y8xeQ+sbQNjLkQw4fuSXJ6XhOALyCp+bX4TrK
	HwJB3VjV4gvXcX
X-X-Sender: gene099@racer.site
In-Reply-To: <20080220223953.GA32663@hand.yhbt.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74579>

Him

On Wed, 20 Feb 2008, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > we are approaching our first release of msysGit's installer with 
> > git-svn.  However, I am experiencing a very bad performance, and an 
> > error:
> > 
> > $ git svn fetch
> > trace: exec: 'git-svn' 'fetch'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.fetchall'
> > trace: built-in: git 'config' '--get' 'svn.username'
> > trace: built-in: git 'config' '--get' 'svn.repackflags'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.quiet'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.noauthcache'
> > trace: built-in: git 'config' '--get' 'svn.revision'
> > trace: built-in: git 'config' '--int' '--get' 'svn.repack'
> > trace: built-in: git 'config' '--int' '--get' 'svn.logwindowsize'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.nocheckout'
> > trace: built-in: git 'config' '--get' 'svn.configdir'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.noMetadata'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.useSvnsyncProps'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.followparent'
> > trace: built-in: git 'config' '--get' 'svn.authorsfile'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.useSvmProps'
> > trace: built-in: git 'config' '--bool' '--get' 'svn.uselogauthor'
> > trace: built-in: git 'rev-parse' '--symbolic' '--all'
> > trace: built-in: git 'config' '-l'
> > trace: built-in: git 'config' '-l'
> > trace: built-in: git 'config' '-l'
> > trace: built-in: git 'config' '--int' '--get' 'svn-remote.svn.branches-maxRev'
> > trace: built-in: git 'config' '--int' '--get' 'svn-remote.svn.tags-maxRev'
> > trace: built-in: git 'config' '--get' 'svn-remote.svn.url'
> > trace: built-in: git 'config' '--get' 'svn-remote.svn.uuid'
> > trace: built-in: git 'config' 'svn-remote.svn.branches-maxRev' '8'
> > could not lock config file
> > config svn-remote.svn.branches-maxRev 8: command returned error: 255
> > 
> > I suspect that the locking problem is due to some strange anti-virus 
> > interaction, because issuing the same command on the command line 
> > succeeds.
> 
> I believe somebody on the list also had the same problem with file 
> locking in Windows.  Unfortunately, I have little idea as to what could 
> be wrong.  Could Windows not be releasing file locks properly?

I am not half as concerned with locks on Windows (since they occur 
regularly, thanks to _two_ Antiviruses, go figure), as with unnecessary 
config file reading.

> > However, did you notice the many calls to "git config"?  Especially 
> > the three ones which list all values anyway?
> > 
> > I am not really sure if that is the single reason of the slowness -- 
> > remember, Windows is mightily spawn()-challenged -- but it sure would 
> > help to have git-svn read the config once at the beginning, probably 
> > with "-z", too, and then just read from the cached values, no?
> 
> Many months ago, I thought about implementing a transparent caching 
> layer in Git.pm to work with git configs.  Of course, that requires 
> cooperation from all readers/writers within the process...  Done 
> correctly, it would help more than just git-svn. too.

Yes, but I am really scared there.  Last time, Pasky tried to put a _lot_ 
into Git.pm, and it did not work here.  As a consequence, I put aside a 
_lot_ of my time to turn the most important (to me!) perl scripts into 
builtins.

> I think I had this idea around the time we made git-config output Perl 
> hashes and arrays.

You mean -z?

> > P.S.: how far is the svn:external->submodule stuff?
> 
> Yikes.  I've let other work pile up on my ever-growing todo-list :/ I'll 
> see if I can dig it out and wrap it up this weekend or next...

Actually, I can understand what you're talking about.  But just let me 
tell this: I (amongst others) are _excited_ to wait until you have that 
particular feature working...

Ciao,
Dscho
