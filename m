From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Can you do this with GIT?
Date: Fri, 27 Jul 2007 12:45:35 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707271236410.3442@woody.linux-foundation.org>
References: <11834063.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: CPD <cdavidson@altsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:45:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVl2-0005pe-0t
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbXG0Tps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761372AbXG0Tps
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:45:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36350 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760761AbXG0Tpr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jul 2007 15:45:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6RJjflq018825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Jul 2007 12:45:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6RJjZIx006659;
	Fri, 27 Jul 2007 12:45:35 -0700
In-Reply-To: <11834063.post@talk.nabble.com>
X-Spam-Status: No, hits=-2.733 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.15__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53957>



On Fri, 27 Jul 2007, CPD wrote:
> 
> We produce variations based on a (mostly) common codebase. In CVS I set up
> "environment" modules for each platform, then when you are working on that
> platform, you simply check out the correct environment and build. Only the
> needed code and tools are exposed in that environment (this is important as
> clients must NOT see each other's code and most customers have some
> customization). I do this by defining and renaming modules in the CVSROOT
> modules file.
> 
> Does GIT support anything like this? Or another way to acheive the same end?

Depending on how big the individual pieces are, you can do it either with 
branches or subprojects.

If the "mostly common" codebase means that 90% of it really ends up being 
common, and what you have is a few config things and perhaps a library or 
two that either shows up or not, git branches would work really well. 

And branches are totally independent of each other, so it's quite possible 
to have even "secret" things in one branch, and it would never get exposed 
to anybody else. The biggest worry you'd need to make sure of is that you 
don't want to merge such private branches directly with each other - since 
then the merged branch would see everything that was in the history of the 
other branch, even if the merge itself ended up not picking the "secret 
stuff".

So with branches that have private information, you'd have to have one 
"common" branch that doesn't have any of the private stuff at all, and do 
the general development on that, and then you can merge that common stuff 
into all the individual private branches (and if you want to go the other 
way, moving something from a private branch to the "common area", you'd 
have to cherry-pick just that particular detail into the common branch).

If you have bigger building blocks, and some of the whole building blocks 
need to be private, you'd probably want to use the subproject support, 
which would make for more of a CVS "modules" kind of thing and in that 
sense perhaps closer to what you do now, but I suspect that just using 
branches would actually end up being much simpler for you. It would depend 
mostly on how big those building blocks that you need to keep separate 
are.

		Linus
