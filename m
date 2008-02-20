From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git svn forking an awful lot of "git config"s
Date: Wed, 20 Feb 2008 15:27:01 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802201520580.17164@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 16:29:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRqsY-0003QY-1m
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 16:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764605AbYBTP1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 10:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbYBTP1U
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 10:27:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:44580 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765117AbYBTP1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 10:27:19 -0500
Received: (qmail invoked by alias); 20 Feb 2008 15:27:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 20 Feb 2008 16:27:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18n7d1neKgnuQR4tErTJ91dqnaxkOiZ1OXak42YRD
	9J1NMzQQPBEkVd
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74519>

Hi,

we are approaching our first release of msysGit's installer with git-svn.  
However, I am experiencing a very bad performance, and an error:

$ git svn fetch
trace: exec: 'git-svn' 'fetch'
trace: built-in: git 'config' '--bool' '--get' 'svn.fetchall'
trace: built-in: git 'config' '--get' 'svn.username'
trace: built-in: git 'config' '--get' 'svn.repackflags'
trace: built-in: git 'config' '--bool' '--get' 'svn.quiet'
trace: built-in: git 'config' '--bool' '--get' 'svn.noauthcache'
trace: built-in: git 'config' '--get' 'svn.revision'
trace: built-in: git 'config' '--int' '--get' 'svn.repack'
trace: built-in: git 'config' '--int' '--get' 'svn.logwindowsize'
trace: built-in: git 'config' '--bool' '--get' 'svn.nocheckout'
trace: built-in: git 'config' '--get' 'svn.configdir'
trace: built-in: git 'config' '--bool' '--get' 'svn.noMetadata'
trace: built-in: git 'config' '--bool' '--get' 'svn.useSvnsyncProps'
trace: built-in: git 'config' '--bool' '--get' 'svn.followparent'
trace: built-in: git 'config' '--get' 'svn.authorsfile'
trace: built-in: git 'config' '--bool' '--get' 'svn.useSvmProps'
trace: built-in: git 'config' '--bool' '--get' 'svn.uselogauthor'
trace: built-in: git 'rev-parse' '--symbolic' '--all'
trace: built-in: git 'config' '-l'
trace: built-in: git 'config' '-l'
trace: built-in: git 'config' '-l'
trace: built-in: git 'config' '--int' '--get' 'svn-remote.svn.branches-maxRev'
trace: built-in: git 'config' '--int' '--get' 'svn-remote.svn.tags-maxRev'
trace: built-in: git 'config' '--get' 'svn-remote.svn.url'
trace: built-in: git 'config' '--get' 'svn-remote.svn.uuid'
trace: built-in: git 'config' 'svn-remote.svn.branches-maxRev' '8'
could not lock config file
config svn-remote.svn.branches-maxRev 8: command returned error: 255

I suspect that the locking problem is due to some strange anti-virus 
interaction, because issuing the same command on the command line 
succeeds.

However, did you notice the many calls to "git config"?  Especially the 
three ones which list all values anyway?

I am not really sure if that is the single reason of the slowness -- 
remember, Windows is mightily spawn()-challenged -- but it sure would help 
to have git-svn read the config once at the beginning, probably with "-z", 
too, and then just read from the cached values, no?

Ciao,
Dscho

P.S.: how far is the svn:external->submodule stuff?
