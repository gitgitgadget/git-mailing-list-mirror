From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: git-stash
Date: Thu, 7 Jun 2007 23:28:33 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706072328000.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 00:30:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQVJ-0005OD-A2
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764470AbXFGWap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936505AbXFGWap
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:30:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:51368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764470AbXFGWao (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:30:44 -0400
Received: (qmail invoked by alias); 07 Jun 2007 22:30:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 08 Jun 2007 00:30:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kCrh1Tpxkpu22HsY66Rv+5YNGUOovECpil1fncX
	jH2arJAsWtXm0e
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49395>

Hi,

I just was in the need for git-stash (for the 1e6th time this year), but 
instead of writing a script, I though I'd try the "!" convention for 
aliases. Works quite well for me:

git config alias.stash '!git diff-files --name-only -z | git update-index 
-z --stdin && tree=$(git-write-tree) && commit=$(echo stash $(date) | 
git-commit-tree $tree) && git-update-ref refs/heads/stash $commit && 
git-reset --hard'

(This is one long line.)

With this, I can now say "git stash" with a dirty working directory, and 
it will have the same effect as "git reset --hard", i.e. reset to the 
clean state in HEAD.

Except that all my changes are stashed away in the branch "stash". It is 
not really a branch, as I expect it to jump from loose end to loose end, 
like this:

A - B - C - D - E - F - G - H - ...  (master branch)
  \               \       \
    A'  ..          E'  ..  G'       (stash branch)

The ".." denote reflog connections: "git log stash" will show G' and as 
its parent G with its history, while "git reflog stash" will show G', and 
then E', and then A'.

Maybe it is not only useful for me...

Ciao,
Dscho
