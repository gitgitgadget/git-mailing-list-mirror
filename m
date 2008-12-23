From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-recursive: mark rename/delete conflict as
 unmerged
Date: Tue, 23 Dec 2008 17:20:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812231716000.30769@pacific.mpi-cbg.de>
References: <85647ef50812220629o46134a70waf159bb6cd6d6e72@mail.gmail.com> <7v4p0whr7a.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812222308410.30769@pacific.mpi-cbg.de> <7v7i5rhkix.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 17:16:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF9vn-0003Ro-C3
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 17:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017AbYLWQOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 11:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754012AbYLWQOs
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 11:14:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:46322 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753996AbYLWQOq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 11:14:46 -0500
Received: (qmail invoked by alias); 23 Dec 2008 16:14:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 23 Dec 2008 17:14:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+U0ig644+UEsTDVIQ8/ucI8g1Kh0Z0OQQylRrOk+
	XtB/FZAwatKiWu
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i5rhkix.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103830>

Hi,

On Mon, 22 Dec 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When a file was renamed in one branch, but deleted in the other, one 
> > should expect the index to contain an unmerged entry, namely the 
> > target of the rename.  Make it so.
> 
> That was quick, but the surrounding code makes me wonder if other
> if/elseif branches also need similar handling.

I tried to make sure that the surrounding code also adds unmerged entries, 
but I have to admit that my focus lay with the bug report at hand.

> For example, rename/add comes up with a new name that does not exist 
> anywhere, and adds both to the index; it is understandable that you need 
> to do this when processing a merge with non-zero depth because you need 
> to have a tree as the result, but shouldn't the final zero depth merge 
> just use the original names and leave the results in higher stages?

Hmm.  I think this is a different issue (if you mean the issue that the 
result might be named differently than expected).

As for the unmerged entries, no, I do not think we need to do anything 
else besides calling update_file() and set try_merge = 1.

After all, if a file was renamed in one branch, but added directly in 
another, does it need to conflict?  I'd say no.

Ciao,
Dscho
