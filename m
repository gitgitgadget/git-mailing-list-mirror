From: Eric Wong <normalperson@yhbt.net>
Subject: git-svn: does anybody care for sub-optimal merge tracking?
Date: Sun, 14 Jan 2007 22:56:35 -0800
Message-ID: <20070115065635.GA939@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jan 15 20:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2J-0000NW-Hw
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:23 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V94-0003eK-No
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbXAOG4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 01:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbXAOG4h
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 01:56:37 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38743 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082AbXAOG4h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 01:56:37 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A218B7DC094;
	Sun, 14 Jan 2007 22:56:35 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 14 Jan 2007 22:56:35 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36870>

First off, parental information on the creation of new tags and branches
will stay, meaning --follow-parent will remain in git-svn; and will
probably even become the default for fetching.

However... there are some experimental features in git-svn
that I'm considering dropping:

* tree matching: -b/--branch <refname> and -B/--branch-all-refs[1]
* the graft-branches command

Tree matches are usually done at fetch time, and will add parents to an
imported commit if the tree matches the one made in a commit.  I
originated this feature myself, but have not used it often.

Tree matching likely has problems with a dcommit-based
workflow (I haven't heard any complaints, either because nobody is using
it or they're still using set-tree (formerly 'commit').

Tree matching will almost certainly go away unless somebody raises some
very good objections.

graft-branches attempts to do merge-tracking via regexes on log
messages, analyzing parenting information in logs, and also via tree
matching (like -b/-B).  git-svnimport does somewhat the same things
(minus tree matching), but at import time (not after-the-fact with
grafts).

Despite spending a reasonable amount of time creating graft-branches, I
have hardly ever used it on real projects; and the times I did use it I
didn't think it was very useful.  The regex matching on log messages and
parenting information in logs should not be harmful to a dcommit-based
workflow.

[1] - apologies for not documenting -B/--branch-all-refs in
      the manpage, it's basically shorthand for:
      `git-rev-parse --symbolic --all | xargs -n1 echo -b`

-- 
Eric Wong
