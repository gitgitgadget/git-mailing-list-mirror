From: alan@clueserver.org
Subject: Odd problems trying to build an orphaned branch
Date: Thu, 5 Nov 2015 13:16:54 -0800
Message-ID: <1bf03e2146ceb5bb36b81f1ce64354b0.squirrel@clueserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: alan@clueserver.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 22:28:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuS4u-0000aU-3n
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 22:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768AbbKEVYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 16:24:43 -0500
Received: from clueserver.org ([65.102.45.174]:58423 "EHLO clueserver.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756917AbbKEVYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 16:24:32 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2015 16:24:32 EST
Received: from clueserver.org (localhost [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 6BD2F60059E;
	Thu,  5 Nov 2015 13:16:54 -0800 (PST)
Received: from 192.55.54.43
        (SquirrelMail authenticated user alan)
        by clueserver.org with HTTP;
        Thu, 5 Nov 2015 13:16:54 -0800
User-Agent: SquirrelMail/1.4.22-14.fc20
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280940>

I am trying to create an orphaned branch that contains the linux-3.12.y
branch from linux-stable. Each time I try a method to make this work I
encounter a blocker that halts my progress.

I expect that at least one of these is a bug, but I am not sure.

Here is what I did. I have read the docs and tried a huge pile of
suggestions. How is this supposed to be done?

I am using git version 2.6.2.402.g2635c2b. It passes all the tests.

I created an orphan branch from 3.12-rc1. I then used git format-patch to
generate patches from 3.12-rc1 to HEAD. (Over 7000 patches.) I use git am
to apply them to the orphan branch. At patch 237 it fails to apply. (It
appears the patch is from a block of code added with a merge commit, but
it is somewhere in the middle of the block.)

Are merge commits supposed to screw up git-format-patch?

I also tried using clone with depth and --single-branch set.  It ignored
the depth setting and gave me the whole branch all the way back to 2.6.x.

All the examples of shallow clones use depth=1. Is it broken for values
bigger than 1 or am I missing something?

I tried using graft and filter-branch. None of the descriptions are very
clear. None of them worked either. Filter-branch died on a commit
somewhere in 2.6 land that had no author. (Which is outside of the commits
I want to keep.)

I tried creating an orphan branch and using cherry-pick
v3.12-rc1..linux-3.12.y. It blew up on the first merge commit it hit. I
tried adding in "-m 1" to try to get it to pick a parent, but then it died
on the first commit because it was not a merge.

Why is this so hard?

All I want to do is take a branch from linux-stable and create a branch
that contains just the commits from where it was branched off of master
until it hits HEAD. That is it. All the scripts that I have seen that
claim to do just what I want break when it hits a merge or a bogus author.
(How that got into linux-stable, I have no idea. The commit is 10 year
old!)

Ideas? Do I need to create a new command? ("cake-cutter". Cut from
commit..commit and make a new branch out of it.)
