From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: git pull -s subtree doesn't work properly
Date: Thu, 31 Dec 2009 20:37:08 +0000
Message-ID: <20091231203708.GA4158@cs-wsok.swansea.ac.uk>
References: <20091105180905.GP17628@cs-wsok.swansea.ac.uk> <20091231193800.GB19537@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 21:37:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQRlq-0003XV-Bd
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 21:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbZLaUhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 15:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbZLaUhK
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 15:37:10 -0500
Received: from laurel.swan.ac.uk ([137.44.1.237]:33255 "EHLO laurel.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZLaUhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 15:37:09 -0500
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by laurel.swan.ac.uk with esmtp (Exim 4.70)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1NQRlc-0003ue-LV; Thu, 31 Dec 2009 20:37:08 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 90DE6BA9B;
	Thu, 31 Dec 2009 20:37:08 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 7588174210; Thu, 31 Dec 2009 20:37:08 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20091231193800.GB19537@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135973>

Just adding a bit more information about the apparently
wrong behaviour of "-s subtree":

The question is what is the "subtree"??? Apparently git just
looks for the first matching file it finds (!) --- now there is in repository B
a file index.html, and there is index.html in A (while B is to be
merged into A), and thus git apparently deduces that must be
the "subtree". If this is not a bug ...

Does the repository name belong to what specifies a "subtree"?
As one can see below, the repository name has been changed.
For example when creating a repository a Github, then the name
of the repository is not really under control, and also how
Git treats repositories, it seems that the name of the repository
doesn't matter.

In this case we have in A the directory "CS_M41", while in B it was 
"CS_M41_Programs"; then later in Github the name of B was further
changed to "CS-M41-Programming-in-Java". Is this an issue (should it be)?

Oliver

P.S. Would renaming CS_M41 in A to CS-M41-Programming-in-Java changed something?
Or would it make things worse?
I tried it, and it doesn't make any change.


On Thu, Dec 31, 2009 at 07:38:00PM +0000, Oliver Kullmann wrote:
> Hello,
> 
> it seems no reply yet (if I understand that web-email-interface
> properly); has nobody any idea here, or is it a Git bug,
> or my fault?
> 
> To me it seems all pretty normal, so I would be glad to get
> some reaction.
> 
> The situation didn't improve: It seems "subtree" is completely broken ---
> it has no idea that the files to be pulled are to be placed in
> a subtree. (The pull via "git pull -s subtree CSM41 master" actually
> also manages to ignore the ignore-patterns; don't know how this
> could happen.)
> 
> So shouldn't one use this option?
> Or how can I restart?
> 
> I would also need in other situations the ability of Git to have one independent repository (say,
> at Github), which is also included in some other bigger repository (where it is
> not changed, only included) --- how to do so if the "subtree"-mechanism doesn't work?
> 
> Hope for some help.
> 
> Oliver
> 
> 
> 
> On Thu, Nov 05, 2009 at 06:09:05PM +0000, Oliver Kullmann wrote:
> > Hello,
> > 
> > using
> > 
> > IntroductionJava> git remote add -f CSM41 /home/kullmann/csoliver/UofT/Java0910/ProgrammingJava/CS-M41_Programs
> > IntroductionJava> git merge -s ours --no-commit CSM41/master
> > IntroductionJava> git read-tree --prefix=Artikel/Skripte/IntroductionJava/CS_M41/ -u CSM41/master
> > IntroductionJava> git commit -m "Einfuegen des CS-M41-Projektes als Verzeichnis CS_M41"
> > 
> > I have imported repository "CS-M41_Programs" into another repository. Later then
> > I replaced in the config-file the old url /home/kullmann/csoliver/UofT/Java0910/ProgrammingJava/CS-M41_Programs
> > by the new one
> > 
> > [remote "CSM41"]
> > 	url = git://github.com/OKullmann/CS-M41-Programming-in-Java.git
> > 	fetch = +refs/heads/*:refs/remotes/CSM41/*
> > 
> > But now
> > 
> > IntroductionJava> git pull -s subtree CSM41 master
> > 
> > doesn't work anymore: In the CSM41 repository just one file index.html was changed,
> > and apparently the merge strategy recognises that the other files haven't
> > been changed, while index.html is placed just as if the relative path would
> > start from the root of the repository.
> > 
> > IntroductionJava> git pull -s subtree CSM41 master
> > remote: Counting objects: 7, done.
> > remote: Compressing objects: 100% (3/3), done.
> > remote: Total 4 (delta 1), reused 0 (delta 0)
> > Unpacking objects: 100% (4/4), done.
> > >From git://github.com/OKullmann/CS-M41-Programming-in-Java
> >  * branch            master     -> FETCH_HEAD
> > CONFLICT (delete/modify): Artikel/LaTeX/SystemStile/Html/index.html deleted in HEAD a
> > nd modified in 38b11a96fa009a5b2c24cfc94c0268ab9ca7ce39. Version 38b11a96fa009a5b2c24
> > cfc94c0268ab9ca7ce39 of Artikel/LaTeX/SystemStile/Html/index.html left in tree.
> > Automatic merge failed; fix conflicts and then commit the result.
> > 
> > IntroductionJava> git status
> > # On branch master
> > # Unmerged paths:
> > #   (use "git reset HEAD <file>..." to unstage)
> > #   (use "git add <file>..." to mark resolution)
> > #
> > #       deleted by us:      ../../LaTeX/SystemStile/Html/index.html
> > #
> > no changes added to commit (use "git add" and/or "git commit -a")
> > 
> > The path of index.html is Artikel/Skripte/IntroductionJava/CS_M41/Html/index.html.
> > Why git thinks that index.html should be placed into another directory Artikel/LaTeX/SystemStile/Html/
> > I have no clue (this directory doesn't exist).
> > 
> > Is it possible to tell "git pull" where the subtree really is, or is that
> > not really the cause of the problem?
> > 
> > Thanks for your consideration!
> > 
> > Oliver
> > 
