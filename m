From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: odd behavior with concurrent fetch/checkout
Date: Mon, 22 Oct 2007 12:51:25 -0400
Message-ID: <20071022165125.GG583@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 18:51:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik0V8-0000p4-P0
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 18:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbXJVQv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 12:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbXJVQv1
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 12:51:27 -0400
Received: from mail.fieldses.org ([66.93.2.214]:58057 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbXJVQv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 12:51:26 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ik0Uv-000314-OE
	for git@vger.kernel.org; Mon, 22 Oct 2007 12:51:25 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62025>

Just now I checked out a topic branch in my working repo:

	git checkout server-xprt-switch

and while waiting for it to complete (I just started work and caches
were all cold), I ran a

	git fetch origin

in another window to update from Linus.  The git fetch gave a warning:

	remote: Generating pack...
	remote: Counting objects: 7550
	remote: Done counting 12885 objects.
	remote: Result has 8400 objects.
	remote: Deltifying 8400 objects...
	remote:  100% (8400/8400) done
	Indexing 8400 objects...
	remote: Total 8400 (delta 7257), reused 5696 (delta 4586)
	 100% (8400/8400) done
	Resolving 7257 deltas...
	 100% (7257/7257) done
	* refs/remotes/origin/master: fast forward to branch 'master' of
	* git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
	  old..new: d85714d..55b70a0
	Cannot fetch into the current branch.

Why the warning?  Also, afterwards I was left with server-xprt-switch
pointing to the tip of the branch I'd just switched from (another
miscellaneous topic branch).  The working directory was in some
completely different state--thanks to a quick reset --hard I don't know
what it was.  Also, in the reflog for the checked-out branch:

	commit bac1e7977eb4781e62cee7f1c7c3d13a9e5d8d74
	Reflog: server-xprt-switch@{0} (J. Bruce Fields <bfields@citi.umich.edu>)
	Reflog message: fetch origin: Undoing incorrectly fetched HEAD.
	Author: J. Bruce Fields <bfields@citi.umich.edu>
	Date:   Mon Oct 22 12:32:37 2007 -0400
	...

Why was a fetch into the remote fooling with HEAD or anything under
refs/heads/?

--b.
