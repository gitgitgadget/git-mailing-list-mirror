From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rollback index if git-commit is interrupted by a
 signal
Date: Thu, 29 May 2008 15:03:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291456030.13507@racer.site.net>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org> <alpine.DEB.1.00.0805291341290.13507@racer.site.net> <483EAD69.9090001@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 16:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1ilX-0001cz-KJ
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 16:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbYE2OFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 10:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbYE2OFK
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 10:05:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:42816 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750807AbYE2OFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 10:05:09 -0400
Received: (qmail invoked by alias); 29 May 2008 14:05:07 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp044) with SMTP; 29 May 2008 16:05:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RX8kHTkHRK+PFUwCkCY/S1KRF+C9HU6+Amt962p
	i4GDI2AZdc5wqC
X-X-Sender: gene099@racer.site.net
In-Reply-To: <483EAD69.9090001@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83203>

Hi,

On Thu, 29 May 2008, Paolo Bonzini wrote:

> > >  static void rollback_index_files(void)
> > >  {
> > > -	switch (commit_style) {
> > > -	case COMMIT_AS_IS:
> > > -		break; /* nothing to do */
> > > -	case COMMIT_NORMAL:
> > > -		rollback_lock_file(&index_lock);
> > > -		break;
> > > -	case COMMIT_PARTIAL:
> > > -		rollback_lock_file(&index_lock);
> > > -		rollback_lock_file(&false_lock);
> > > -		break;
> > > -	}
> > > +	rollback_lock_file(&index_lock);
> > > +	rollback_lock_file(&false_lock);
> > >  }
> > 
> > Your commit message gives _no_ good reason for this change.  As a 
> > matter of fact, I imagine that this could be a regression.
> 
> Without this change, there could be races between the time the lock file 
> is created and the time the commit_style variable is set, leading to the 
> rollback not being performed.

IMO it would make much more sense to _guarantee_ that the commity_style 
variable is set before the index is locked.  It is feasible, and there is 
no good reason not to do that.

Ciao,
Dscho
