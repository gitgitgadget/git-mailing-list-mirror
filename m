From: Ingo Rohloff <lundril@gmx.de>
Subject: Documentation about "push.default=upstream" is confusing
Date: Sun, 9 Feb 2014 17:31:57 +0100
Message-ID: <20140209163157.GA7652@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 17:32:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCXId-0002E6-6C
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 17:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbaBIQcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 11:32:01 -0500
Received: from mout.gmx.net ([212.227.17.22]:64929 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbaBIQcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 11:32:00 -0500
Received: from flatline.chipnet ([178.26.62.48]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MEo4s-1W0xlM0Hf8-00G21I for <git@vger.kernel.org>;
 Sun, 09 Feb 2014 17:31:59 +0100
Received: by flatline.chipnet (sSMTP sendmail emulation); Sun, 09 Feb 2014 17:31:57 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:hy80fTpJtlitMUcRCcSq5NvvIo3RY/3uDtLuS5qBf/J++F718rP
 2I/8uVIZwtxhJTM4sU/tEb5y2cdQGbcfRFFQDSY19Y3HWCN1SbCQTHLqTKeI8/Jul7v5Ol5
 M/2D04yMmJF3FsqxnjxbBmvqmovnC/K8hvjLAiMVZtc99jv+nwfE4K5qIDWlS5GIoCvj/x1
 fPBpc09/5kYSIkVJOFYJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241882>

Hello,

I recently started to use git and now are digging through more and more
of the low level details.

What I recently tried was to do this for a repository created by Bob:

  git remote add -t for_bob anna <url>

So setup a remote (created by anna) for which a branch called 
"for_bob" is fetched.
Then "git fetch anna".

Then
  git checkout -b from_anna anna/for_bob

So create a "from_anna" branch in Bobs repository which tracks the "for_bob"
branch in the remote "anna" repository.

Now "git pull" works as expected for the "from_anna" branch.

But "git push" does not, because "from_anna" has a different branch name
than the branch you want to push to (you want to push to the "for_bob"
branch).

So after googling I found out about the "push.default=upstream" config
option, which seems to do exactly what I want: It uses the tracking
information to decide to which remote branch I want to push.

Now for cross checking I looked up the documentation of "push.default" at
http://git-scm.com . It says:

----- snip ------
push.default ...

upstream - push the current branch back to the branch whose changes are
usually integrated into the current branch (which is called @{upstream}).
This mode only makes sense if you are pushing to the same repository you
would normally pull from (i.e. central workflow).

----- snip -----

I think the second sentence here is quite confusing.
To me it seems "push.default=upstream" is actually the best choice for a
*de-centralized* workflow.

Rationale:
Assume I pull the "master" branch from several remote repositories
(de-centralized workflow I guess).

To handle that I setup several remote tracking branches called:
  repo1_master   (tracks repo1/master)
  repo2_master   (tracks repo2/master)
  reap3_master   (tracks repo3/master)

Now without "push.default=upstream" I would have to either always explicitly
do something like:
  git push repo1 repo1_master:master
  git push repo2 repo2_master:master

Or modify ".git/config" to add that per default via "push=" entries.

Whereas with "push.default=upstream" everything works as expected it seems.

So if I am not wrong here, I would propose to rephrase the sentence
------ snip -----
This mode only makes sense if you are pushing to the same repository you 
would normally pull from (i.e. central workflow).
------ snip -----

To do that: Could someone point out, when it does NOT make sense to use
"push.default=upstream" ?

with best regards
  Ingo
