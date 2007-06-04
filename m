From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to use git-svn to clone from a mirror?
Date: Mon, 4 Jun 2007 19:08:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706041906570.4046@racer.site>
References: <86hcpq8qjz.fsf@lola.quinscape.zz> <85myzfsqji.fsf@blr-RHarinath.blr.novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Raja R Harinath <rharinath@novell.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 20:10:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvH13-0006K1-O8
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 20:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759780AbXFDSKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 14:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759829AbXFDSKH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 14:10:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:34751 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759794AbXFDSKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 14:10:05 -0400
Received: (qmail invoked by alias); 04 Jun 2007 18:10:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 04 Jun 2007 20:10:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/JF2Eu1uvJV31fQkxR92+fZswUyL9ZVMwUG2KYUh
	rARVr8pQQVcjYP
X-X-Sender: gene099@racer.site
In-Reply-To: <85myzfsqji.fsf@blr-RHarinath.blr.novell.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49123>

Hi,

On Mon, 4 Jun 2007, Raja R Harinath wrote:

> David Kastrup <dak@gnu.org> writes:
> 
> > I have used something like
> >
> > git-svn clone -T trunk -b branches -t tags file:///tmp/rsync-mirror
> >
> > to clone an rsync mirror of an SVN repository.  Now I want to have 
> > fetch revert to pulling from the upstream repository in future. 
> > However, if I change the respective line in .git/config to 
> > svn://the.svn.link/whatever, git-rebase will fetch the right updates, 
> > but then says that it can't work with the objects in the git 
> > repository.
> >
> > Changing the config back will make git-rebase -l work.
> >
> > So what would be the right procedure to shift the SVN source from an
> > rsync mirror to the original, without git-svn breaking?
> 
> I think you'll have to
> 
> -------------8<------------
>   # remove stored revision db, since we're going to change all the commit ids
>   rm .git/svn/git-svn/.rev_db.*
> 
>   # rewrite git-svn-id: lines
>   cg-admin-rewritehist \
> 	--msg-filter \
> 	'sed "s,file:///tmp/rsync-mirror,svn://the.svn.link/whatever,"'
> 
>   # recreate new revision db, and fetch updates, if any
>   git-svn rebase
> -------------8<------------

<shameless plug>
	Or you use the just-rewritten version of it, git-filter-branch.
</shameless>

Ciao,
Dscho
