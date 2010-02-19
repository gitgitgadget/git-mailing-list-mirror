From: Dale Rowley <ddrowley3@juno.com>
Subject: unexpected git-merge result
Date: Fri, 19 Feb 2010 21:35:54 +0000 (UTC)
Message-ID: <loom.20100219T202452-35@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 22:36:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiaWR-0001FP-Sc
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 22:36:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726Ab0BSVgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 16:36:23 -0500
Received: from lo.gmane.org ([80.91.229.12]:35272 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621Ab0BSVgW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 16:36:22 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NiaWI-00017S-KM
	for git@vger.kernel.org; Fri, 19 Feb 2010 22:36:18 +0100
Received: from 71-212-187-72.hlrn.qwest.net ([71.212.187.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 22:36:18 +0100
Received: from ddrowley3 by 71-212-187-72.hlrn.qwest.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 22:36:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.212.187.72 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091212 Gentoo Firefox/3.5.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140484>

Our branch history looked something like the following:

  B---C
 /     \
A---D---E---H
     \     /
      F---G

In commit D a few lines were added to a file, and then in commit G the same
lines were removed. When branches E and G were merged, those lines unexpectedly
re-appeared in the merge commit (H), even though no other commits had touched
that file.

I think I understand why this happened: git-merge-base reports that the common
ancestor for E and G is A. Since those lines don't appear in that file in
commits A or G, git-merge assumes that they were added independently on branch
E, so it decides to keep the lines in the merged result.

This merge problem arises because although A is the most recent common ancestor
of branches E and G in general, it is *not* the most recent common ancestor as
far as that single file is concerned. The most recent common ancestor for that
particular file is commit D.

This is worrisome because I imagine the converse will also be a potential
problem: lines are removed in commit D, and then re-added in commit G, and they
will unexpectedly disappear in the merge (H). So my question is whether this is
a bug in git (ie, shouldn't git be considering independent common ancestors for
each file that is merged)? This doesn't seem like a particularly unique or rare
scenario - how is everyone else preventing these kinds of problems? 

Dale
