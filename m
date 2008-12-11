From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git log --numstat disagrees with git apply --numstat
Date: Thu, 11 Dec 2008 15:53:37 -0800
Message-ID: <20081211235337.GK32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 12 00:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAvMu-0001Jy-9E
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 00:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbYLKXxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 18:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbYLKXxi
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 18:53:38 -0500
Received: from george.spearce.org ([209.20.77.23]:57345 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbYLKXxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 18:53:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 521D338200; Thu, 11 Dec 2008 23:53:37 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102847>

I've found a case where git apply --numstat and git log --numstat
produce different results for the same commit.

In egit (git://repo.or.cz/egit.git/):

  $ git log --numstat -1 --pretty=o 9bda5ece6806cd797416eaa47c
  9bda5ece6806cd797416eaa47c7b927cc6e9c3b2 Teach RevWalk about ...
  8       0       org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java
  69      13      org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java

  $ git log -p -1 --pretty=o 9bda5ece6806cd797416eaa47c | git apply --numstat
  8       0       org.spearce.jgit/src/org/spearce/jgit/revwalk/DateRevQueue.java
  68      12      org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java

I found this because I was writing a unit test for JGit that ran
through the JGit project history and compared the output of git
log --numstat against the output of JGit's "git apply --numstat"
implementation, after scraping the "git log -p" output.

I can't quite figure out why log --numstat is coming up with a +1
difference here for both added and removed, but it is.  I haven't
dug into the Git code yet to figure out why.  FWIW, JGit produces
the same result as "git apply --numstat" (the 68/12).

At this point JGit was able to successfully read and match 715 of
1211 commits before it found this difference, so its also somewhat
rare to occur I think...

-- 
Shawn.
