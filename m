From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Mon, 15 Dec 2008 12:09:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812151206360.30933@intel-tinevez-2-302>
References: <20081210201259.GA12928@localhost>  <20081215004651.GA16205@localhost>  <7v63lm1c76.fsf@gitster.siamese.dyndns.org>  <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>  <20081215095949.GA7403@localhost>  <7vskopwxej.fsf@gitster.siamese.dyndns.org>
 <e2b179460812150250t6e028330xf0e0ff626c1b6b3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	raa.lkml@gmail.com
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 12:11:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCBLj-0000UA-0A
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 12:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbYLOLJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 06:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbYLOLJh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 06:09:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:35026 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752570AbYLOLJg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 06:09:36 -0500
Received: (qmail invoked by alias); 15 Dec 2008 11:09:34 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp065) with SMTP; 15 Dec 2008 12:09:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18o5/4uJZoozx63Z1/tLz5lNyKaHi6nTukNPvzdPl
	AZvxnydz4oBy6z
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <e2b179460812150250t6e028330xf0e0ff626c1b6b3c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103157>

Hi,

On Mon, 15 Dec 2008, Mike Ralphson wrote:

> 2008/12/15 Junio C Hamano <gitster@pobox.com>:
> > Clemens Buchacher <drizzd@aon.at> writes:
> >
> >> On Sun, Dec 14, 2008 at 07:34:46PM -0800, Junio C Hamano wrote:
> >>> merge-recursive: do not clobber untracked working tree garbage
> >>>
> >>> When merge-recursive wanted to create a new file in the work tree 
> >>> (either as the final result, or a hint for reference purposes while 
> >>> delete/modify conflicts), it unconditionally overwrote an untracked 
> >>> file in the working tree.  Be careful not to lose whatever the user 
> >>> has that is not tracked.
> >>
> >> This leaves the index in an unmerged state, however, so that a 
> >> subsequent git reset --hard still kills the file. And I just realized 
> >> that the same goes for merge-resolve. So I'd prefer to abort the 
> >> merge, leave everything unchanged and tell the user to clean up 
> >> first.
> >
> > That is unfortunately asking for a moon, I am afraid.
> >
> > It needs a major restructuring of the code so that the recursive works 
> > more like the way resolve works, namely, changing the final "writeout" 
> > into two phase thing (the first phase making sure nothing is clobbered 
> > in the work tree, and then the second phase actually touching the work 
> > tree).
> 
> I wonder if another approach is workable... to read 'vulnerable' 
> untracked working tree files into a new (temporary, uncommittable) stage 
> in the index, perform whatever merging is required, then reinstate all 
> entries from the new stage.

I think the solution is not in making things more complicated, but 
simpler.  I agree with Junio that the recursive merge needs a major 
rewrite which respects d/f conflicts and renames in the _design_, not as 
an afterthought.

Besides, I really do not want untracked files to be inserted into a stage.  
Remember, adding something to the index means to hash it, and I do have 
half-a-gigabyte untracked data in some of my worktrees.

Ciao,
Dscho
