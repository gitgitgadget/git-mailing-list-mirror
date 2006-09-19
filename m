From: Joel Dice <dicej@mailsnare.net>
Subject: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 15:07:45 -0600 (MDT)
Message-ID: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Tue Sep 19 23:08:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPmor-0006PF-LG
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 23:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWISVHs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 17:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWISVHs
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 17:07:48 -0400
Received: from v187.mailsnare.net ([206.246.200.187]:55945 "EHLO
	mail.mailsnare.net") by vger.kernel.org with ESMTP id S1750837AbWISVHr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 17:07:47 -0400
Received: from joeldicepc.ecovate.com (unknown [208.50.222.162])
	by mail.mailsnare.net (Postfix) with ESMTP id 45D711DCA7
	for <git@vger.kernel.org>; Tue, 19 Sep 2006 21:07:44 +0000 (UTC)
To: git@vger.kernel.org
X-Virus-Scanned: by ClamAV at mailsnare.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27284>

Hello, all.

I'm considering adopting Git for a medium-sized project which is currently 
managed using Subversion.  I've used Git for a few smaller projects 
already, and the thing I've missed most from Subversion is the convenience 
of incrementing revision numbers.  The following is a proposal to add this 
feature to Git.


Rationale:

Incrementing revision numbers (IRNs - an acronym I just made up) are 
useful in that they can be treated as auto-generated tags which are easier 
to remember and communicate than SHA hashes, yet do not require extra 
effort to create like real tags.  Also, they have the advantage of being 
chronologically ordered, so if I assert that a bug was fixed in revision 
42 of a shared repository, everyone may assume that revision 45 has that 
fix as well.

Proposal:

As with Subversion, the IRN state in Git would be specific to a given 
repository and have no significance beyond that repository.  Also like 
Subversion, IRN state would be global across a repository, so that a 
commit to any branch would increment the current IRN value.  Every Git 
command taking a revision parameter would accept an IRN using a syntax 
such as "r$IRN".  Every commit would report the IRN to the user as well as 
the SHA ID.  The IRN feature could be enabled or disabled via a 
configuration option.

Implementation:

A simple, efficient implementation of this feature would be based on a 
single file, $GIT_DIR/history, which would contain a newline-delimited 
list of SHA commit IDs in chronological order, oldest first.  The current 
repository IRN would be calculated as the size of that file divided by the 
SHA+newline length, and the commit ID of any IRN could be determined by 
seeking to the correct offset in that file.  Every commit would cause a 
new line to be appended to the history file with that commit's ID. 
Finally, a history file could be generated for an existing repository by 
serializing the commit history based on chronological order.


I'd be happy to put together a patch that implements this, but first I'd 
like to get some feedback.  If something like this has already been 
proposed, please point me to the discussion.  Thanks.

  - Joel
