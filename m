From: Axel Freyn <axel-freyn@gmx.de>
Subject: Re: 500Mb file erroneously commited
Date: Mon, 6 Jun 2011 09:55:08 +0200
Message-ID: <20110606075508.GC19127@axel>
References: <loom.20110606T093627-918@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 09:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTUei-0004HW-6K
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 09:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab1FFHzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 03:55:19 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:57935 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755488Ab1FFHzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 03:55:18 -0400
Received: (qmail invoked by alias); 06 Jun 2011 07:55:15 -0000
Received: from LN-mac29.grenoble.cnrs.fr (EHLO axel) [147.173.67.29]
  by mail.gmx.net (mp058) with SMTP; 06 Jun 2011 09:55:15 +0200
X-Authenticated: #5679941
X-Provags-ID: V01U2FsdGVkX1/hEP06Xu/hTBZjcUBn1Uflrjj0d8WyjciQ2Oygox
	NOo8ywMtzFmSCN
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20110606T093627-918@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175103>

On Mon, Jun 06, 2011 at 07:43:20AM +0000, Bartolomeo Nicolotti wrote:
> Hello,
> 
> we're using CVS to store some sources, but for some big projects I'm considering
> to use git. Last week it has happened that one collegue erroneously commited one
> big file, 500Mb the file only. To avoid to have this file in the repository
> we've deleted the history file in the CVS repository, the one with ,v, this has
> been easy as each file has its own history. Would it be possible to do the same
> with git, or there's no possibility to delete a 500Mb file erroneously commited? 
Hi,

yes, you can. In fact, there are at least two situation:
 - if you detect the error DIRECTLY after the commit (and have no other
   commits on top of it), then a
   git rm bigfile
   git commit --amend
   does the trick (well, the big file will be unused now, and be deleted
   by the next "git gc")
 - if you have already other commit's on top of it, you can use e.g.
   "git rebase" in order to redefine the history... something like (I'm
   not sure it works exactly like that, but in principle)
   git checkout -b tmp <WRONG_COMMIT>
   git rm bigfile
   git commit --amend
   git checkout master
   git rebase tmpfix
   git branch -d tmpfix

   
However, there if your tree has been already shared with other
developers, they also will have to change to the new and corrected
branch.

Axel
