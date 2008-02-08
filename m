From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 11:50:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081142060.11591@racer.site>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 12:51:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNRlW-00063W-Rc
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 12:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762078AbYBHLu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 06:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbYBHLu2
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 06:50:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:54252 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762078AbYBHLuY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 06:50:24 -0500
Received: (qmail invoked by alias); 08 Feb 2008 11:50:23 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp045) with SMTP; 08 Feb 2008 12:50:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JUdoqKhXJjbYpunDCK/N2Ja9kZ1K/e6HMAediD9
	jr/ilifMwDHQ0m
X-X-Sender: gene099@racer.site
In-Reply-To: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73077>

Hi,

On Fri, 8 Feb 2008, Martin Langhoff wrote:

> To git+ssh://git.catalyst.net.nz/var/git/moodle-r2.git
>  ! [rejected]        mdl17-ceo -> mdl17-ceo (non-fast forward)
>  ! [rejected]        mdl18-local -> mdl18-local (non-fast forward)
>  ! [rejected]        mdl18-masseyedu-wimbatest ->
> mdl18-masseyedu-wimbatest (non-fast forward)
>  ! [rejected]        mdl18-nmit -> mdl18-nmit (non-fast forward)
>  ! [rejected]        mdl18-proxy -> mdl18-proxy (non-fast forward)
>  ! [rejected]        mdl18-shared -> mdl18-shared (non-fast forward)
>  ! [rejected]        mdl18-sqm -> mdl18-sqm (non-fast forward)
>  ! [rejected]        mdl18-stcuthberts -> mdl18-stcuthberts (non-fast forward)
>  ! [rejected]        mdl18-topnz -> mdl18-topnz (non-fast forward)
>  ! [rejected]        mdl19-dbperf -> mdl19-dbperf (non-fast forward)
>  ! [rejected]        mdl19-ucol -> mdl19-ucol (non-fast forward)
>  ! [rejected]        mdl19-uow -> mdl19-uow (non-fast forward)
> error: failed to push to 'git+ssh://git.catalyst.net.nz/var/git/moodle-r2.git'
> 
> The error messages ("! rejected", "error: failed to push") appear even
> if one or two branches did get pushed... I think they are a bit over
> the top. None of these "rejected" branches have anything _new_, they
> are just stale.

So you're saying that the local sides' refs are ancestors of the remote 
sides' refs?

The problem is that the local side cannot tell, and we try to avoid 
putting load on the server, because in many cases, there will be one 
central server and many clients.

So I think this is not technically feasible.  Or do you have another idea 
how to find out that the "[rejected]" ref is a stale ref (i.e. an ancestor 
of the remote side) as opposed to properly rejected?

Another way to "solve" this issue, of course, is to use the remote layout.  
I did the switchover myself some time ago; it was hard at first, since I 
was so used to just check out the branches I just fetched.  But in the 
long run the distinction between local and tracking branches made life 
much easier for me.

Related is this idea that I did not really follow up: often, you want to 
work on a branch which you are tracking already, but there is no local 
branch.  And most often, you just want to create a local branch of the 
same name.  So maybe we should just introduce a new flag, like

	$ git checkout -c origin/next

which would create (or fast-forward) the local branch "next" to what's in 
origin/next.  The long option would read --create-local.

In the same vein, maybe "git branch -d next" should be taught to look at 
the remote branches of name "<nick>/next", too, when checking if that ref 
is an ancestor of HEAD?

Ciao,
Dscho
