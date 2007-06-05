From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Tue, 05 Jun 2007 09:01:44 +0200
Organization: eudaptics software gmbh
Message-ID: <46650A58.4934C07C@eudaptics.com>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
	 <Pine.LNX.4.64.0706041711500.4046@racer.site> <46643F2D.7C896CBC@eudaptics.com> <Pine.LNX.4.64.0706041850350.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 05 09:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvT28-0007s8-VH
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 09:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760838AbXFEHAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 03:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761547AbXFEHAk
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 03:00:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:24898 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760838AbXFEHAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 03:00:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HvT1x-0000A0-0e; Tue, 05 Jun 2007 09:00:37 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9774C4E9; Tue,  5 Jun 2007 09:00:36 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.042
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49166>

Johannes Schindelin wrote:
> On Mon, 4 Jun 2007, Johannes Sixt wrote:
> > But this makes only sense if you have a linear history. Consider this
> > history, where you want to rewrite the commits that are only on branch
> > 'next':
> >
> > --A--B--C--D--E--F--G--H       <- master
> >    \  \  \  \  \  \  \  \
> >     X--o--o--o--o--o--o--o--o  <- next
> >
> > How would you go about with the current calling convention?
> 
> Are you actually sure that this scenario makes sense? When is the last
> time you wanted to filter a branch?

Oh, this makes a lot of sense. For example after I've imported a CVS
repository I had installed grafts for a number of merges that were made
in CVS (but we all know that CVS doesn't record them, so I did that
manually this way). That would be the merge commits in 'next' of the
example above. Now a simple

   git filter-branch -k master new-next

could "implant" the grafts into the commits. In this scenario I don't
need to rewrite 'master' because I know in advance that nothing would
actually be rewritten.

(Since 'master' was about 8000 commits I really didn't want to wait
until the no-ops would be completed, so I did it by actually fixing
cg-admin-rewritehist to not complain about the unmapped parents.)

> In any case, for such a degenerated test case I would rather try to limit
> filtering in the filter expression. Remember: you don't have to change
> _every_ commit.

I don't think that this is a degenerate case. See the example above.

Please observe that the only reasonable way to limit the commits to
rewrite is by giving some --not arguments to the rev-list. The filter
scriptlets themselves have no easy way to tell whether a commit should
be rewritten or not. They just rewrite - with the final result perhaps
ending up identical to the original; but no labor was saved.

-- Hannes
