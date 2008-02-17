From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [RFC] Issues around C rebase--interactive
Date: Sun, 17 Feb 2008 14:15:48 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802171347060.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 20:16:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQozx-0008NW-OR
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYBQTPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbYBQTPu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:15:50 -0500
Received: from iabervon.org ([66.92.72.58]:36790 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbYBQTPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:15:49 -0500
Received: (qmail 8532 invoked by uid 1000); 17 Feb 2008 19:15:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Feb 2008 19:15:48 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74169>

I'm working on porting rebase--interactive to C. This has a number of 
interesting issues:

This will be the first C command which stops in the middle and then gets 
resumed. I've been thinking it would be nice if all of the commands like 
that shared handling of the process in some way. I think it would be good 
to have a "git abort" that would reset a conflicted merge, abort a rebase, 
etc., and probably "git checkout" should either require that there's 
nothing in progress or should abort anything that is in progress. (You can 
presently get lots of fun confusion by starting a rebase, checking out a 
different branch, deleting the branch that you were rebasing, attempting 
another rebase and trying to clean up.)

It would also be nice to have a "git resume" that would continue whatever 
needed user attention after you've done it. (But you'd still need "git 
rebase skip" to do that command-specific first step before resuming.)

There's a lot of stuff stored presently in ways that are convenient for 
shell scripts and inconvenient for C. Is anything else depending on the 
contents or location of ".git/.dotest-merge"?

	-Daniel
*This .sig left intentionally blank*
