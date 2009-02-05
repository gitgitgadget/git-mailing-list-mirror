From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: do not consider diverging submodules a
 'dirty worktree'
Date: Thu, 5 Feb 2009 18:39:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902051838310.7491@intel-tinevez-2-302>
References: <cover.1233758410u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902041540130.10279@pacific.mpi-cbg.de> <7vvdrqunog.fsf@gitster.siamese.dyndns.org> <4989CF79.2070209@viscovery.net> <7vvdrqt74k.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0902041915070.22763@intel-tinevez-2-302> <7vbptit4hm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:40:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8DU-0000nA-JK
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbZBERjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753327AbZBERjR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:39:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:48814 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752917AbZBERjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:39:16 -0500
Received: (qmail invoked by alias); 05 Feb 2009 17:39:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp067) with SMTP; 05 Feb 2009 18:39:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/BW4liUI/iV9Lw7JJ2GaNh/QehUplvqqxsDzrps
	wce9urfs9zS79i
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vbptit4hm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108588>

Hi,

On Wed, 4 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 4 Feb 2009, Junio C Hamano wrote:
> >
> >> Johannes Sixt <j.sixt@viscovery.net> writes:
> >> 
> >> > Because if the repository is non-bare, then filter-branch updates the
> >> > work-tree at the end of the run; we don't want to overwrite uncommitted
> >> > work in this case.
> >> >
> >> > This behavior is a relic from cg-admin-rewritehist, I think. I've never
> >> > found it useful.
> >> 
> >> Ok, I think "read-tree -m -u HEAD" at the end sort of makes sense, if you
> >> filtered the branch you are currently sitting on.  Does that mean we do
> >> not have to barf on dirtyness if we can tell if the filter-branch will not
> >> touch the current branch at all?  Again, I am not suggesting it as an
> >> improvement, but I am trying to see if I am talking a total nonsense.
> >
> > That's correct.  Checking if we would touch the current branch is too 
> > expensive here, that's why we don't do it.
> 
> Ok, so these exchange suggests that the commit log message needs a bit
> more explanation why the check matters before describing why submodules
> should not be checked.  Something like this, perhaps?
> 
>     At the end of filter-branch in a non-bare repository, the work tree is
>     updated with "read-tree -m -u HEAD", to carry the change forward in
>     case the current branch was rewritten.  In order to avoid losing any
>     local change during this step, filter-branch refuses to work when
>     there are local changes in the work tree.
> 
>     This "read-tree -m -u HEAD" operation does not affect what commit is
>     checked out in a submodule (iow, it does not touch .git/HEAD in a
>     submodule checkout), and checking if there is any local change to the
>     submodule is not useful.

Great!

> While I think it makes sense to ignore submodules for the diff-files
> check, I do not think it is correct to do so in the check to see if you
> have staged changes.  If you updated what commit should be checked out in
> your index, and if you run "read-tree -m -u HEAD", it can conflict the
> same way as a staged change to a regular blob.  The most trivial example
> would be if your filtering were to remove any submodule.  Your work tree
> change wanted to modify while the branch switching is to remove and you
> have a modify/remove conflict right there.  Or am I again confused?

I removed that change, and added a few words why it makes sense to check 
that.

Thanks,
Dscho
