From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: how to update a submodule?
Date: Sat, 1 Jan 2011 20:39:57 +0000
Message-ID: <20110101203957.GC26920@cs-wsok.swansea.ac.uk>
References: <20101231222438.GA28199@cs-wsok.swansea.ac.uk> <201012312342.oBVNg1lx021930@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Sat Jan 01 21:40:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZ8FE-0005zi-Ie
	for gcvg-git-2@lo.gmane.org; Sat, 01 Jan 2011 21:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab1AAUkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jan 2011 15:40:00 -0500
Received: from laurel.swan.ac.uk ([137.44.1.237]:47977 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751322Ab1AAUj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jan 2011 15:39:59 -0500
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.72)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1PZ8F4-0004ZN-2G; Sat, 01 Jan 2011 20:39:58 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id D65421C1F38;
	Sat,  1 Jan 2011 20:39:57 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id C2D91741EB; Sat,  1 Jan 2011 20:39:57 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <201012312342.oBVNg1lx021930@no.baka.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164404>

On Fri, Dec 31, 2010 at 06:42:01PM -0500, Seth Robertson wrote:
> 
> In message <20101231222438.GA28199@cs-wsok.swansea.ac.uk>, Oliver Kullmann writ
> es:
> 
>     it would be very helpful if somebody could tell me the
>     supposed workflow how to update a submodule (I'm using version
>     1.7.3.2; the man-page doesn't say much about it).
> 
> https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial
>

thanks, that's definitely something.
 
> --------------------------------------------------
> cd submodule_path
> git checkout <branchname>
> git pull
> cd .. # or otherwise get to the superproject
> 
> git add submodule_path
> git commit -m "Updated submodule to latest <branchname>"
> git submodule update
> --------------------------------------------------
> 
> This (untested) code obviously only works for a single repository.  If
> you want to do it for all repositories, you need something more like
> the untested:
> 
> --------------------------------------------------
> git submodule foreach git checkout <branchname>
> git submodule foreach git pull
> git add -a -m "Updated all submodules to latest <branchname>"
> git submodule update
> --------------------------------------------------
> 

As far as I see that, this doesn't concern the problem how to I update
one repository with submodules from another repository with "these" submodules
(as the same paths)?

Actually, even the simplest case of just cloning a repository with submodules
doesn't work:
After cloning, "git submodule status" shows "-", okay so I do "git submodule init",
which already shows a false understanding --- it shows the URL of the old repository,
from which the original submodule originated, which is long gone and no longer relevant.
Then of course "git submodule update" fails, and in the submodule there is just nothing.

A clone should provide a relation to the mother-clone, not transitively to
the grandmother-clone.

The problem seems to be that the information about the place where to update a
submodule is in .gitmodules, which git actually has under version control (different
from other configuration information), and thus copies it verbatimly.
Okay, then apparently after a clone .gitmodules has to be updated (by hand).

So .gitmodules concerns only "git submodule update", not "git pull" from within
the submodules? This would be good to know, to understand the role of the information
in .gitmodules (where the task of "git submodule init" is apparently just to
transport this information to .git/configure ?).

This has the disadvantage, that one has to publish this private
information about the places where by chance one is pulling from?
Perhaps I should then put .gitmodules into .gitignore? Or would that have
bad consequences??

Or is the idea that .gitmodules normally is not under version control, and
thus "git init", which actually hides the information of .gitmodules ?

> If you find yourself doing this continuously, and doing it for all of
> your submodules, you may way to use gitslave instead of submodules
> which keeps the branches checked out all of the time so all you need to
> do is `git pull`.  This may be better, or worse, for you workflow.
> 
> gitslave (http://gitslave.sf.net) is useful when you control and
> develop on the subprojects at more of less the same time as the
> superproject, and furthermore when you typically want to tag, branch,
> push, pull, etc all repositories at the same time.
>

On the one hand, I always want to pull "everything" (inclusive the content of all submodules),
however the submodules are completely independent (they are from Github, or collaborations on
papers, and such things --- I just want to conveniently carry around all of that with me in
one go).
 
> git-submodule is better when you do not control the subprojects or
> more specifically wish to fix the subproject at a specific revision
> even as the subproject changes
>

This seems to be the case here, so it seemed to me that gitslave wouldn't be appropriate
here.

Thanks for your help!

Oliver
 
