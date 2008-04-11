From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: url.<base>.insteadOf bugs
Date: Fri, 11 Apr 2008 16:31:15 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804111626210.19665@iabervon.org>
References: <loom.20080411T134849-798@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 22:32:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkPus-0005V6-0x
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 22:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760100AbYDKUbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 16:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759574AbYDKUbR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 16:31:17 -0400
Received: from iabervon.org ([66.92.72.58]:38389 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760077AbYDKUbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 16:31:16 -0400
Received: (qmail 11807 invoked by uid 1000); 11 Apr 2008 20:31:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2008 20:31:15 -0000
In-Reply-To: <loom.20080411T134849-798@post.gmane.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79294>

On Fri, 11 Apr 2008, Eric Blake wrote:

> I just upgraded to git 1.5.5, and decided to try out the new 
> url.<base>.insteadOf config option, to save me typing when pulling from 
> git.sv.gnu.org (and so that I can type the same url whether I'm at home and can 
> use git://, or when I'm at work and behind a stupid firewall where I must use 
> http://).  It has a couple of bugs:
> 
> First, it appears to have an off-by-one bug.
> 
> $ git --version
> git version 1.5.5
> $ mkdir bison
> $ cd bison
> $ git init
> Initialized empty Git repository in .git/
> $ git config url.http://git.sv.gnu.org/r/.insteadOf gnu:
> $ git fetch gnu:bison.git master
> fatal: I don't handle protocol 'ttp'
> $ git config --unset url.http://git.sv.gnu.org/r/.insteadOf     
> $ git config --global 'url. http://git.sv.gnu.org/r/.insteadOf' gnu:
> $ git fetch gnu:bison.git master
> Getting alternates list for http://git.sv.gnu.org/r/bison.git
> ...

That's weird; I'll check it out. Beats me how I managed to get an 
off-by-one error on that end of the string.

> Second, 'git clone --help' documents that it uses this config option, but it 
> doesn't:
> 
> $ cd ..
> $ rm -Rf bison
> $ git clone gnu:bison.git
> Initialized empty Git repository in /home/eblake/bison/.git/
> ssh: Could not resolve hostname gnu: no address associated with name
> fatal: The remote end hung up unexpectedly
> fetch-pack from 'gnu:bison.git' failed.

The documentation is a bit overly optimistic here. The C version of clone 
will support it, but we're currently still using the shell version which 
is the last thing (AFAIK) using the old shell parsing.

	-Daniel
*This .sig left intentionally blank*
