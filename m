From: Carsten Fuchs <carsten.fuchs@cafu.de>
Subject: git merge error question: The following untracked working tree files
 would be overwritten by merge
Date: Fri, 25 Jan 2013 11:37:50 +0100
Message-ID: <5102607E.2070106@cafu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 25 11:38:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tygfn-0006RQ-8g
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 11:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab3AYKhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 05:37:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:63373 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754333Ab3AYKhx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 05:37:53 -0500
Received: from [192.168.1.73] (p5B0C6F48.dip.t-dialin.net [91.12.111.72])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MPbr3-1U3Ncs1SF7-005Tsa; Fri, 25 Jan 2013 11:37:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-Provags-ID: V02:K0:Q06Ms+wOSqH1GOzLzpmPFUrKB6SYmjWe186vRcSclRT
 ApJhie/AXGsCp3oWROeqi1uP75RK/NtH2p34xcLBIPhgWuaxCm
 j3zTIo9gS0zZfpCzWARwgXBdjVl+J434Uy2IGB1e0uSI5ZAxyz
 XoDMW8FtJH0K5PXRjK7UKkiRnaviHRd2GqlOsycwVQUaRNh4Be
 H6BEAhP/t795hotOPZZ2YeVrBh0cFbBAgJF2sirt/452QHqahG
 CFZfhhwqlKvrQo8CR+Na/d+79s/WM0389ewMvC5IFW7ZUgpmKJ
 ehnAMqaYX59lD1SlSHTOBN/LsnntWoRt59v045XLtYHAg3XCLG
 A9lgHdIypAETRcXLnzII=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214540>

Hi all,

in my repo, I'm doing this:

 > $ git status
 > # On branch master
 > # Your branch is behind 'origin/master' by 2 commits, and can be fast-forwarded.
 > #
 > # Untracked files:
 > #   (use "git add <file>..." to include in what will be committed)
 > #
 > #       obsolete/
 > nothing added to commit but untracked files present (use "git add" to track)
 >
 > $ git merge origin/master --ff-only
 > Updating f419d57..2da6052
 > error: The following untracked working tree files would be overwritten by merge:
 >         obsolete/e107/Readme.txt
 >         obsolete/e107/article.php
 >         obsolete/e107/backend.php
 >         [...]


That is, the local repository has the untracked directory "obsolete", which was added 
upstream as well, and now I try to reconcile.

I seem to understand the problem stated in the error message, and the solution seems to 
be simple as well: renaming the obsolete/ directory is enough.

But why does Git find a problem here at all?

Compare with what Subversion did in an analogous case: When I ran "svn update" and the 
update brought new files for which there already was an untracked copy in the working 
directory, Subversion:
     - started to consider the file as tracked,
     - but left the file in the working-copy alone.

As a result, a subsequent "svn status" might
     a) no longer show the file at all, if the foreign copy in the working directory 
happened to be the same as the one brought by the "svn update", or
     b) flag the file as modified, if different from the one that "svn update" would 
have created in its place.

So my real question is, why does Git not do something analogous?
(Afaics, update the HEAD, update the Index, but leave the working-copy edition alone?)

I searched for this beforehand, and most advice involves either stashing, or with "git 
reset --hard" the loss of the untracked files.

Sorry if this is a stupid question -- I still consider myself a Git learner.

Best regards,
Carsten
