From: "Steven E. Harris" <seh@panix.com>
Subject: How does git follow branch history across a merge commit?
Date: Fri, 28 Aug 2009 18:37:59 -0400
Organization: SEH Labs
Message-ID: <8363c75zug.fsf@torus.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 29 01:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhAon-0002tl-8q
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 01:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbZH1XZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 19:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbZH1XZG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 19:25:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:37857 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbZH1XZF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 19:25:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MhAoZ-0002pv-Po
	for git@vger.kernel.org; Sat, 29 Aug 2009 01:25:03 +0200
Received: from pool-68-162-167-240.pitt.east.verizon.net ([68.162.167.240])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Aug 2009 01:25:03 +0200
Received: from seh by pool-68-162-167-240.pitt.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 Aug 2009 01:25:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-68-162-167-240.pitt.east.verizon.net
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (windows-nt)
Cancel-Lock: sha1:gy7CS9VrgKIo4doD6TrueFx01N0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127361>

This question concerns git's representation of merge commits.

I understand that branches in git are references to commit vertices in a
graph, that each of these vertices have zero or more reference edges to
a parent (predecessor) vertex, and that merges create vertices with at
least two parents. Walking back in time from a branch head involves
traversing parent edges.

But what happens when such traversal reaches a merge commit? If one asks
git to move back, say, in time by a few days, or so many predecessors,
how does it know (or choose) which way to go upon reaching a merge
commit?

I set up an experiment with two competing branches that require merging
back together:

,----
| mkdir gitexp && cd gitexp && git init
| $EDITOR file1.txt
| git add file1.txt
| git commit -m'Initial impound.'
| $EDITOR file1.txt
| git commit -a -m'Added a second line.'
| 
| git checkout -b competition
| $EDITOR file1.txt
| git commit -a -m'Extended second line.'
| 
| git checkout master
| $EDITOR file1.txt
| git commit -a -m'Added third line.'
| 
| git checkout competition
| $EDITOR file1.txt
| git commit -a -m'Edited second line.'
| $EDITOR file1.txt
| git commit -a -m'Added an alternate third line.'
| 
| git checkout master
| git merge competition
| # Edit to resolve conflict:
| $EDITOR file1.txt
| git commit -a
| 
| git checkout 'HEAD^'
| # At this point, git picked the predecessor along branch "master".
`----

Was it just luck that "HEAD^" referred to the predecessor that came from
branch "master" rather than branch "competition"?

-- 
Steven E. Harris
