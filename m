From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: confusion over git-cherry-pick, git-merge and git-cherry
Date: Wed, 24 Feb 2010 16:39:23 -0500
Message-ID: <20100224213923.GV14244@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 22:49:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkP6z-00014j-Uh
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 22:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252Ab0BXVtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 16:49:35 -0500
Received: from hqmtaint01.ms.com ([205.228.53.68]:61210 "EHLO
	hqmtaint01.ms.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904Ab0BXVte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 16:49:34 -0500
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Feb 2010 16:49:33 EST
Received: from hqmtaint01 (localhost.ms.com [127.0.0.1])
	by hqmtaint01.ms.com (output Postfix) with ESMTP id 7E8F288C1AA
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 16:39:24 -0500 (EST)
Received: from ny0032as01 (unknown [144.203.194.95])
	by hqmtaint01.ms.com (internal Postfix) with ESMTP id 6187BB00030
	for <git@vger.kernel.org>; Wed, 24 Feb 2010 16:39:24 -0500 (EST)
Received: from hn315c1n5 (localhost [127.0.0.1])
	by ny0032as01 (msa-out Postfix) with ESMTP id 53F82C94243;
	Wed, 24 Feb 2010 16:39:24 -0500 (EST)
Received: from menevado.ms.com (unknown [144.203.222.190])
	(Authenticated sender: yes)
	by ny0032as01 (msa-in Postfix) with ESMTPA id 33AB54C0046;
	Wed, 24 Feb 2010 16:39:24 -0500 (EST)
Received: by menevado.ms.com (Postfix, from userid 49008)
	id CDC93530211; Wed, 24 Feb 2010 16:39:23 -0500 (EST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.35/RELEASE, bases: 24022010 #3415295, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140991>


Hi,


Given this scenario:

  Work is done over a series of commits on branch 'alpha'.  A commit is
  cherry-pick'd from 'alpha' onto branch 'beta'.  Later, branch 'alpha'
  is merged into branch 'beta', I'm seeing unexpected output from
  git-cherry.

  Here's what the history currently looks like:


                      B'-----M beta
                    /       /
               o---A---B---C alpha


I would expect git-cherry to recognize that B' has the same content as
B and thus show me a '-' sign in front.  Instead, I get the following
output from 'git-cherry alpha beta'

  $ git cherry alpha beta
  + B'

The output of git-log looks like this (which is also unfortunate):

  $ git log --pretty=oneline
  M  Merge branch 'alpha' into beta
  B' change 2
  C  change 3
  B  change 2
  A  change 1
  o  initial commit


The output of git-patch-id for B and B' is identical.  

Can someone please explain to me why git-cherry doesn't notice that the
duplicate commit has the same content?  Shouldn't it?   Shouldn't I get
the following output:

  $ git cherry alpha beta
  - B'

that is, there exists a commit on beta that doesn't exist in alpha, but
the content there is the same?


How do others deal with cherry-pick and merge combined together?


To give some further background on what I'm trying to do, I would like
to prevent changes getting made in the beta branch that don't already
exist in alpha.  I'm enforcing this with a server side hook that does a
git-cherry and checks if any of the lines start with a '+'.  This works
great until I allow changes to be cherry-picked from alpha.  The first
cherry-pick works, but then when the whole of alpha is later merged in,
the hook fails to allow any subsequent push to 'beta'.


Thanks

--Kevin
