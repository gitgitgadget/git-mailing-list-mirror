From: Nicolas Pitre <nico@cam.org>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 10:00:58 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802140945520.2732@xanadu.home>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
 <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
 <18355.42595.377377.433309@lisa.zopyra.com>
 <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com>
 <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org> <20080214140152.GT27535@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 16:02:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPfb6-0003B9-Iy
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 16:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758238AbYBNPBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 10:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758152AbYBNPBE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 10:01:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47587 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758051AbYBNPBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 10:01:00 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW800F4XHPDUK70@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Feb 2008 10:00:51 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080214140152.GT27535@lavos.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73879>

On Thu, 14 Feb 2008, Brian Downing wrote:

> On Wed, Feb 13, 2008 at 07:43:21PM -0800, Junio C Hamano wrote:
> > People often mistake that the safety of "branch -d" is to not
> > lose the commit (i.e. not making it unreachable), but that is
> > not the case.  That safety already exists in HEAD reflogs.
> > 
> > The "branch -d" safety is about not losing the particular point.
> > The information we really are trying to protect is "this branch
> > points at _that commit_", which is just as important if not
> > more.
> 
> This actually brings up something I've been intending to ask.
> 
> When deleting a branch, is there any reason we can't add a deletion
> entry into the reflog and keep the reflog around?  This would seem to be
> a lot safer; I know I've been burned by expecting the reflog safety net
> to be there, and surprised that it's not when I've deleted a branch.

No.  That would only accumulate dead reflog files in the repository.

And as Junio said above, the "HEAD" reflog contains everything you moved 
to, including detached heads, and of course branch heads that might now 
be deleted.  You can easily retrieve a deleted branch head from there.

For example, in my 'git log -g HEAD' output, I have:

|commit 40aab8119f38c622f58d8e612e7a632eb1f3ded2 
|Reflog: HEAD@{2} (Nicolas Pitre <nico@cam.org>) 
|Reflog message: checkout: moving from next to master

If I accidentally deleted my 'next' branch, I can retrieve it with 
HEAD@{3} which is the position HEAD was pointing to before moving away 
from 'next'.  So, doing 'git branch next HEAD@{3}' would restore it.


Nicolas
