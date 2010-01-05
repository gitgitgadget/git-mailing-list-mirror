From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 5 Jan 2010 10:46:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001051032440.4985@pacific.mpi-cbg.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 05 10:41:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS5uN-0004a2-BV
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 10:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab0AEJkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 04:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754Ab0AEJkz
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 04:40:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:41967 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751563Ab0AEJkx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 04:40:53 -0500
Received: (qmail invoked by alias); 05 Jan 2010 09:40:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 05 Jan 2010 10:40:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182/l9GnlE2Dhae8lpICGiaYWMXgTUPypCew6znPQ
	R1LH+bSCMnS9VZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B42F425.4010901@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136179>

Hi,

On Tue, 5 Jan 2010, Jens Lehmann wrote:

> Am 04.01.2010 23:29, schrieb Johannes Schindelin:
> 
> > - submodules were designed with a strong emphasis on not being forced 
> >   to check them out.  But Git makes it very unconvenient to actually 
> >   check submodules out, let alone check them out at clone-time.  And 
> >   it is outright impossible to _enforce_ a submodule to be checked 
> >   out.
> 
> Absolutely. But i think the group mappings discussed by Junio and Heiko
> are a good starting point to solve that problem:
> http://thread.gmane.org/gmane.comp.version-control.git/130928/
> 
> This should be solvable by putting the necessary information into
> .gitmodules and have git clone use it.

And of course, existing Git versions will not handle it correctly.  
Judging from the rebasing-submodule patch, the next Git version will not 
handle it either.

But you're correct, one has to start _somewhere_.

> > - among other use cases, submodules are recommended for sharing 
> >   content between two different repositories. But it is part of the 
> >   design that it is _very_ easy to forget to commit, or push the 
> >   changes in the submodule that are required for the integrity of the 
> >   superproject.
> 
> Definitely (and if i got that right, svn externals have the same problem).

Yes, svn externals have that problem.  But we do not need to take the svn 
externals example more seriously than it deserves: it illustrates a valid 
use case that is not handled by submodules.  But svn externals are not 
what I would call "elegant design" either.

> What about checking for every submodule before a push in the 
> superproject that its HEAD is on a remote branch? I don't think we can 
> provide full safety here, but we could handle the 99% case of a 
> forgotten push in the submodule. This could even be done with a rather 
> simple hook (if we had a pre-push hook that is :-).

The problem with hooks is that for security reasons, every user has to 
install them in every repository herself (unless she is working on a 
machine serviced by an overzealous administrator).

> > - that use case -- sharing content between different repositories -- 
> >   is not really supported by submodules, but rather an afterthought.  
> >   This is all too obvious when you look at the restriction that the 
> >   shared content must be in a single subdirectory.
> 
> I don't see that as a problem (and it's the same with svn externals, no?).
> 
> And having worked for a long time with a RCS variant which allowed
> "projects" to contain an arbitrary list of files, i don't think this is
> a problem (but forgetting to add new files to this list really is, so
> putting everything in one directory is *much* safer IMHO).
> And: almost all files were properly grouped in directories after a decade
> of development even though that was not enforced by the scm at all.

That happens to be the case here, I agree.

But I have a use case here where the shared content is _not_ a library 
that can live in a subdirectory naturally.

> > - related are the use cases where it is desired not to have a fixed 
> >   submodule tip committed to the superproject, but always to update to 
> >   the current, say, master (like Subversion's externals).  This use 
> >   case has been wished away by the people who implemented submodules 
> >   in Git.  But reality has this nasty habit of ignoring your wishes, 
> >   does it not?
> 
> Having read up about svn externals in the meantime, what about something
> like this:
> - Add a command like "git submodule forward" (as update is already in
>   use) that takes an optional -b <branchname>. It does a fetch in the
>   submodule, then tries to fast forward (or rebase) to master or the
>   branch given and stages this commit in the superproject. This should
>   be the equivalent to doing an "svn update" in a repo with externals.
>   Or am i missing something?

Yes.  It is not the decision of the fetcher, but of the guy who adds the 
submodule to decide what it is.

> - We could also add an option to "git submodule add" to specify the
>   default branch name for forward.

That's an obvious precondition for proper always-tip-submodules.  But 
Git's core data structure, the index, does not allow for it.  _That_ is 
the difficulty, not what the user interface would look like.

> > - while it might be called clever that the submodules' metadata are 
> >   stored in .gitmodules in the superproject (and are therefore 
> >   naturally tracked with Git), the synchronization with .git/config is 
> >   performed exactly once -- when you initialize the submodule.  You 
> >   are likely to miss out on _every_ change you pulled into the 
> >   superproject.
> 
> Yes. This synchronization could be either obsoleted by only using
> .gitmodules or automated.

I start to wonder whether the insistence that .gitmodules' settings must 
be overrideable makes any sense in practice.

> > Besides, as long as there is enough reason to have out-of-Git 
> > alternative solutions such as repo, submodules deserve to be 2nd-class 
> > citizens.
> 
> I think in the long run to make submodules first class citizens the
> following submodule commands must be obsoleted by their regular git
> parts: init (by git clone), status (by git status), update (by git
> checkout), summary (already in git diff thanks to your patch) and sync
> (maybe Avery's idea of only relying on .gitmodules and not copying data
> int .git/config would solve this).

Avery's idea was to make .gitmodules overrideable in .git/config, which 
would share almost all the shortcomings I listed for the current solution.

> That would leave git submodule add, foreach and maybe a command to do 
> what svn update does for externals and another to manipulate things like 
> group membership etc..
> 
> Which reminds me of Sverre's quote from Alles Wird Git: "Yes, it is 
> possible. But it will be hard."

Yeah, it will be hard.  Especially since the fact that submodule is a 
bloated shell script has outlived its usefulness by far.  (It would be 
different if it was a nice, small, elegant script, but you have looked at 
it, so you know why I am disgusted.)

Ciao,
Dscho
