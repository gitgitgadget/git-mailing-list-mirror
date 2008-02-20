From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn forking an awful lot of "git config"s
Date: Wed, 20 Feb 2008 14:39:53 -0800
Message-ID: <20080220223953.GA32663@hand.yhbt.net>
References: <alpine.LSU.1.00.0802201520580.17164@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRxcO-0007e4-Tj
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 23:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbYBTWj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 17:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765969AbYBTWj4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 17:39:56 -0500
Received: from hand.yhbt.net ([66.150.188.102]:49843 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758239AbYBTWjz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 17:39:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 5EEFD7F4101;
	Wed, 20 Feb 2008 14:39:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802201520580.17164@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74558>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> we are approaching our first release of msysGit's installer with git-svn.  
> However, I am experiencing a very bad performance, and an error:
> 
> $ git svn fetch
> trace: exec: 'git-svn' 'fetch'
> trace: built-in: git 'config' '--bool' '--get' 'svn.fetchall'
> trace: built-in: git 'config' '--get' 'svn.username'
> trace: built-in: git 'config' '--get' 'svn.repackflags'
> trace: built-in: git 'config' '--bool' '--get' 'svn.quiet'
> trace: built-in: git 'config' '--bool' '--get' 'svn.noauthcache'
> trace: built-in: git 'config' '--get' 'svn.revision'
> trace: built-in: git 'config' '--int' '--get' 'svn.repack'
> trace: built-in: git 'config' '--int' '--get' 'svn.logwindowsize'
> trace: built-in: git 'config' '--bool' '--get' 'svn.nocheckout'
> trace: built-in: git 'config' '--get' 'svn.configdir'
> trace: built-in: git 'config' '--bool' '--get' 'svn.noMetadata'
> trace: built-in: git 'config' '--bool' '--get' 'svn.useSvnsyncProps'
> trace: built-in: git 'config' '--bool' '--get' 'svn.followparent'
> trace: built-in: git 'config' '--get' 'svn.authorsfile'
> trace: built-in: git 'config' '--bool' '--get' 'svn.useSvmProps'
> trace: built-in: git 'config' '--bool' '--get' 'svn.uselogauthor'
> trace: built-in: git 'rev-parse' '--symbolic' '--all'
> trace: built-in: git 'config' '-l'
> trace: built-in: git 'config' '-l'
> trace: built-in: git 'config' '-l'
> trace: built-in: git 'config' '--int' '--get' 'svn-remote.svn.branches-maxRev'
> trace: built-in: git 'config' '--int' '--get' 'svn-remote.svn.tags-maxRev'
> trace: built-in: git 'config' '--get' 'svn-remote.svn.url'
> trace: built-in: git 'config' '--get' 'svn-remote.svn.uuid'
> trace: built-in: git 'config' 'svn-remote.svn.branches-maxRev' '8'
> could not lock config file
> config svn-remote.svn.branches-maxRev 8: command returned error: 255
> 
> I suspect that the locking problem is due to some strange anti-virus 
> interaction, because issuing the same command on the command line 
> succeeds.

I believe somebody on the list also had the same problem with file
locking in Windows.  Unfortunately, I have little idea as to what could
be wrong.  Could Windows not be releasing file locks properly?

It could be worth it to write a standalone Perl script that replicates
the git-config calls without the rest of git-svn getting in the way...

> However, did you notice the many calls to "git config"?  Especially the 
> three ones which list all values anyway?
> 
> I am not really sure if that is the single reason of the slowness -- 
> remember, Windows is mightily spawn()-challenged -- but it sure would help 
> to have git-svn read the config once at the beginning, probably with "-z", 
> too, and then just read from the cached values, no?

Many months ago, I thought about implementing a transparent caching layer
in Git.pm to work with git configs.  Of course, that requires
cooperation from all readers/writers within the process...  Done
correctly, it would help more than just git-svn. too.

I think I had this idea around the time we made git-config output Perl
hashes and arrays.

> Ciao,
> Dscho
> 
> P.S.: how far is the svn:external->submodule stuff?

Yikes.  I've let other work pile up on my ever-growing todo-list :/
I'll see if I can dig it out and wrap it up this weekend or next...

-- 
Eric Wong
