From: Larry D'Anna <larry@elder-gods.org>
Subject: RFC: git sync
Date: Tue, 9 Feb 2010 22:27:20 -0500
Message-ID: <20100210032720.GA5205@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 04:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf3Ec-0003CD-Gc
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 04:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913Ab0BJD1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 22:27:22 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:44768 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab0BJD1V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 22:27:21 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id D40C282200F; Tue,  9 Feb 2010 22:27:20 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139478>

So say you have a project with a bunch of branches.  You have two main computers
you work on: a laptop and a workstation, and you keep an authoritative copy on a
server somewhere.  When you sit down at your laptop to work on your project, the
first thing you want to do is make sure that whatever you've got locally is
up-to-date with the repo on the server.  So you run: 

git push origin :

Then if it says anything isn't a fast-forward, you use some combination of git
pull, git checkout, or git fetch to get all you branches up to date, then
possibly you run the push again to push merges back to the server.

How about instead we add a new command called "git sync" that does all that for
you?  So if you say 

git sync origin : 

It matches refs just like git-push would, but it will also automatically
fast-forward your local refs if possible.  (and update the worktree+index if
HEAD is one of the local refs that gets fast forwarded).  If any merges would
be required, it will print a warning and leave that ref alone.

And if you say

git sync --merge origin :

it will try to merge any refs that need it.  If the merge succeeds, it will be
exactly as if you had said

git checkout foobranch
git pull origin foobranch
git push origin foobranch

What do you all think?  If you like the idea, I'll do it as a builtin.
Otherwise I'll just hack up a perl script for myself.


          --larry
