From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 21:28:28 +0200
Message-ID: <20070613192828.GB3412@steel.home>
References: <18031.64456.948230.375333@lisa.zopyra.com> <86zm33291h.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 21:29:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyYX7-00060J-OF
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 21:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759542AbXFMT2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 15:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759515AbXFMT2g
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 15:28:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:28401 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383AbXFMT2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 15:28:35 -0400
Received: from tigra.home (Fcb25.f.strato-dslnet.de [195.4.203.37])
	by post.webmailer.de (fruni mo44) (RZmta 7.2)
	with ESMTP id E01be2j5DJIlXP ; Wed, 13 Jun 2007 21:28:29 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id EF70D277BD;
	Wed, 13 Jun 2007 21:28:28 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id BCDBAD261; Wed, 13 Jun 2007 21:28:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86zm33291h.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBkvAA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50118>

Randal L. Schwartz, Wed, Jun 13, 2007 17:01:14 +0200:
> > We have some CVS users who complain that they cannot do a pull
> > into a dirty working tree, as they could under CVS.  Here is
> > their scenario: they make a few changes to their code and want
> > to test it out; someone else pushes changes to the central repo
> > that they then want to add to their working tree to test also;
> > they then want to pull in these changes and test everything, as
> > if they had done 'mv stuff stuff-; git pull; mv stuff- stuff'.
> 
> > They would like an option (perhaps a config option) to do a "dirty
> > pull".
> 
> Maybe this will do it, presuming they haven't published any of their local
> work, and they're on a topic branch "topic"
> 
> git-tag WIP # mark HEAD so we can come back
> git-commit -a -m WIP # commit current work so we can replay it
> git-fetch origin # grabs the upstream
> git-rebase origin # rebase current work-in-progress onto new upstream
> # might need to resolve and commit conflicts repeatedly
> git-reset --soft WIP # next commit will be on top of commit prior to rebase
> git-reset # mark all files as uncommitted as yet
> git-tag -d WIP # no more need for this tag
> 
> This effectively puts the upstream changes "under" (or "prior to") the current
> topic branch.
> 

Wont work for new files (not yet known to git) which conflict with the
same names from origin. Your method will not put them anywhere and
their presence will break git-rebase. You _must_ do a merge.
