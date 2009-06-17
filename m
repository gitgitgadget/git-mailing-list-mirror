From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Using git for code deployment on webservers?
Date: Wed, 17 Jun 2009 15:26:04 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0906171328080.2147@iabervon.org>
References: <200906160111.47325.ioe-git@rameria.de> <alpine.LNX.2.00.0906161332080.2147@iabervon.org> <200906171923.08034.ioe-git@rameria.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ingo Oeser <ioe-git@rameria.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:26:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MH0m0-0007Gm-74
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 21:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbZFQT0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 15:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753832AbZFQT0E
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 15:26:04 -0400
Received: from iabervon.org ([66.92.72.58]:57303 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770AbZFQT0D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 15:26:03 -0400
Received: (qmail 30541 invoked by uid 1000); 17 Jun 2009 19:26:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Jun 2009 19:26:04 -0000
In-Reply-To: <200906171923.08034.ioe-git@rameria.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121768>

On Wed, 17 Jun 2009, Ingo Oeser wrote:

> Hi Daniel,
> 
> On Tuesday 16 June 2009, Daniel Barkalow wrote:
> > You should be able to have the slave repositories store tags for tree 
> > objects (instead of commit objects), and have the webservers fetch those. 
> > You'll still have the object database, but it will only contain stuff 
> > that's been deployed to that webserver, not intermediate versions or 
> > historical versions.
> 
> Ah, that sound like a great solution. I'll try that.
> 
> > You'll still have to store both the repo and the checked out data 
> > (but git stores the content delta-compressed against each 
> > other in one big file, normally, so there really aren't files to hard link 
> > to.
> 
> Ok. That was under the assumption, that the core of git is basically a 
> content addressable file system. But that seems to be history :-)

It is (based on) a content-addressable file system, but it's not a host 
file system. It's a file system in the sense that you can put octet 
sequences into it and lookup them up by their names, but you can't mount 
it from the kernel and link to it. It's like a tar file, although it's 
more limited in that it doesn't provide a "list" operation.

There's no fundamental reason there couldn't be a kernel driver (or, 
more likely, FUSE helper) which could mount it, but that's not the normal 
method.

> > Of course, the other possibility is to check out versions on the slaves, 
> > and rsync that to the webservers, which is probably the optimal method if 
> > you're not in a situation where you benefit from anything git does in 
> > transit.
> 
> I would benefit from noticing local changes. But simple rsync is what is tried now.
> Problem is, we get no de-duplication from rsync, which git could do.

In that case, fetching trees is probably the right thing; that should give 
you a point-to-point de-duplication without any history (although you may 
also turn up git bugs, since this isn't how git is normally used).

	-Daniel
*This .sig left intentionally blank*
