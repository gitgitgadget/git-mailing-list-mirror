From: Erez Zadok <ezk@cs.sunysb.edu>
Subject: Re: why git-reset needed after "cp -a" of a git repo?
Date: Wed, 22 Aug 2007 15:19:23 -0400
Message-ID: <200708221919.l7MJJNkX012184@agora.fsl.cs.sunysb.edu>
References: <alpine.LFD.0.999.0708221208090.30176@woody.linux-foundation.org>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 21:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INvjy-00057l-H4
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 21:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760300AbXHVTTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 15:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764891AbXHVTTe
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 15:19:34 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47335 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755759AbXHVTTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 15:19:33 -0400
Received: from agora.fsl.cs.sunysb.edu (agora.fsl.cs.sunysb.edu [130.245.126.12])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l7MJJNER032299;
	Wed, 22 Aug 2007 15:19:23 -0400
Received: from agora.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by agora.fsl.cs.sunysb.edu (8.13.1/8.13.1) with ESMTP id l7MJJNqr012187;
	Wed, 22 Aug 2007 15:19:23 -0400
Received: (from ezk@localhost)
	by agora.fsl.cs.sunysb.edu (8.13.1/8.12.8/Submit) id l7MJJNkX012184;
	Wed, 22 Aug 2007 15:19:23 -0400
In-reply-to: Your message of "Wed, 22 Aug 2007 12:11:14 PDT."
             <alpine.LFD.0.999.0708221208090.30176@woody.linux-foundation.org> 
X-MailKey: Erez_Zadok
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56410>

In message <alpine.LFD.0.999.0708221208090.30176@woody.linux-foundation.org>, Linus Torvalds writes:
> 
> 
> On Wed, 22 Aug 2007, Erez Zadok wrote:
> > 
> > However, I noticed that after I copy a git repo (using v1.5.2.2), the index
> > entries are all out of sync, and I need to run git-reset.  Why?  What's in
> > the index file that changes after a cp -a or rsync that git depends on?  Is
> > it atime's and if so, aren't they copied by cp -a or rsync?
> 
> ctime/mtime and inode numbers too.
> 
> If you use hardlinks to copy the working tree, *and* you reset ctime 
> afterwards, you'd be ok. But basically, git tries to be *really* anal in 
> noticing any possible change to the inode, so anything it can do to notice 
> that the index file might be stale, it does.
> 
> But you don't need to do a "git reset", you're actually better off just 
> doing a "git status" instead. That will refresh the index.
> 
> 		Linus

Thanks for the info and tips.  It's a good idea of course to detect any
possible changes, but I wonder if for those of us who know what they're
doing (i.e., living on the edge :-), there could be an option to ignore
inode numbers and just depend on good 'ol ctime/mtime (as other tools like
make do).

If such an option might be deemed useful, I'm willing to take a crack at it.

Erez.
