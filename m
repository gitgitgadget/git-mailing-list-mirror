From: Peter Krefting <peter@softwolves.pp.se>
Subject: Interactive rebase with pre-built script?
Date: Tue, 11 Sep 2012 07:32:34 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1209110725130.8398@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 11 08:38:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBK75-0008J0-Jx
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 08:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175Ab2IKGiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 02:38:15 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:57198 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753566Ab2IKGiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 02:38:14 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Sep 2012 02:38:13 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q8B6WZfH009636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Sep 2012 08:32:35 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q8B6WYtn009631;
	Tue, 11 Sep 2012 08:32:35 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 11 Sep 2012 08:32:35 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205208>

Hi!

At $DAYJOB, we have a lot of code flowing from a central repository 
to repositories which hold refinitions and ports of the code from the 
central repository. Often enough the people working on the porting 
repositories find bugs in the code from the central repository, and 
want to submit patches upstream.

We want to get these patches upstream in the easiest possible manner, 
and a clever colleague of mine came up with this recipe, to be run 
from the downstream repository:

   git log --reverse --format="pick %h %s" master.. -- common_paths > 
changes.txt

This gives a list of the commits changing the code in the common paths 
(we try to make sure to make them in separate changesets, not touching 
the downstream code), in a format that can be used as input to git 
rebase --interactive.

Now, to my question. Is there an easy way to run interactive rebase 
on the upstream branch with this recipe? The best we have come up with 
so far is

   git checkout master # the upstream branch
   git rebase -i HEAD~

and then just append everything from the generated recipe. This 
doesn't play well if the last commit is a merge, though (making a 
dummy commit and just removing it from the default rebase recipe works 
for that case, though).

I was thinking about using git cherry-pick with a list of commits, 
rebase is better at helping with conflicts and such.

-- 
\\// Peter - http://www.softwolves.pp.se/
