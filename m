From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: how to backup git
Date: Mon, 12 May 2008 17:19:32 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805121647540.19665@iabervon.org>
References: <4827DEF6.1050005@gmail.com> <87ej87is50.fsf@offby1.atm01.sea.blarg.net> <alpine.DEB.1.00.0805121428310.30431@racer> <48285087.3090402@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 23:20:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvfRa-0006EX-5H
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 23:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396AbYELVTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 17:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755530AbYELVTf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 17:19:35 -0400
Received: from iabervon.org ([66.92.72.58]:47579 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756031AbYELVTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 17:19:34 -0400
Received: (qmail 30264 invoked by uid 1000); 12 May 2008 21:19:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2008 21:19:32 -0000
In-Reply-To: <48285087.3090402@gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81954>

On Mon, 12 May 2008, bill lam wrote:

> Johannes Schindelin wrote:
> > > I'd rsync just the .git directory.
> 
> Thanks to all responders for quick reply. I still have a related question. svn
> has a hotcopy command to ensure integrity so that it is possible to backup
> without shutting down the svn server. If someone update the .git while I am
> performing backup using tar or rsync? Will the atomicity of that commit still
> preserve in my backup copy?

There's the risk that the backup will start, it will copy all of the 
objects, then a git commit happens, which adds more objects (after rsync 
has passed) and updates a "refs" entry to refer to one of them, and then 
rsync copies the "refs" directory.

It's likewise possible to have part of the information for a commit copied 
and part of it not. This commit will be clearly broken, however (one or 
more objects not found). 

So, essentially, every commit goes through the stages of not at all 
written, partially written but invalid, and valid and correct. 
Independantly, which commit is the latest is updated atomically. It's 
possible for an ill-timed backup to get a branch updated to a commit 
that's not yet valid in the backup. In you restored from this, you'd need 
to use one of several methods (mainly reflogs) to get back to the last 
valid commit that got backed up.

On the other hand, git will never, even in this sort of backup, end up 
with a commit that's valid but not completely correct.

	-Daniel
*This .sig left intentionally blank*
