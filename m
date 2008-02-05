From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [BUG] Rebase, squash, and conflicts
Date: Tue, 5 Feb 2008 16:27:56 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802051618190.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 22:28:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMVLD-0005Ys-VN
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 22:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759751AbYBEV17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 16:27:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759668AbYBEV16
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 16:27:58 -0500
Received: from iabervon.org ([66.92.72.58]:39127 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758769AbYBEV15 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 16:27:57 -0500
Received: (qmail 13357 invoked by uid 1000); 5 Feb 2008 21:27:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Feb 2008 21:27:56 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72702>

I think there's a bug in the squash behavior for git rebase -i. Say you've 
got the following history:

aaaaa introduce an API
bbbbb use the API in new code
ccccc some unrelated review
ddddd fix the API due to review

And you do the following rebase:

pick aaaaa introduce an API
squash ddddd fix the API due to review
pick bbbbb use the API in new code
pick ccccc some unrelated review
pick ddddd fix the API due to review

(the last line being because some of the changes don't apply between a and 
b, so we want to duplicate the commit later, and probably squash it into 
b, but that's not part of this bug report)

You get a conflict on the second item, which you expected. But when you 
resolve it, it squashes 3/5 into 2/5, not 2/5 into 1/5. I think this is 
because rebase --continue isn't noticing that it's a squash that needed 
help. It seems to work fine to do this in two steps (pick instead of 
squash, followed by another rebase that does the squash when it's 
unconflicted), as a workaround.

	-Daniel
*This .sig left intentionally blank*
