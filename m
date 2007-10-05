From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: The 3rd msysGit Herald
Date: Fri, 5 Oct 2007 04:13:39 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710050405410.4174@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-307776946-1191554019=:4174"
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Oct 05 05:13:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdddR-0008QE-3X
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 05:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbXJEDNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 23:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXJEDNo
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 23:13:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:45600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754092AbXJEDNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 23:13:43 -0400
Received: (qmail invoked by alias); 05 Oct 2007 03:13:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 05 Oct 2007 05:13:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TB45+yNwTdwfW/SSZZlTPM5oBKWt4pzHZkx8rG+
	UnTJrOSqYhwckd
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60033>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-307776946-1191554019=:4174
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Good morning git land!

This hour of the tiger in Scotland is as good an occasion as any to issue
the third episode of the msysGit Herald, the not-quite-biweekly news letter
to keep you informed about msysGit, the effort to bring one of the most
powerful Source Code Management systems to the poor souls stuck with
Windows.

These are the covered topics:

	Umlauts in the path name

	Compiling Perl from scratch!

	Including the 'html' branch as a submodule

	The language wars, this time: no .NET in msysGit

	Inno installer

	Where is HOME?


Umlauts in the path name
========================

Another issue cropped up the other day; MSys cannot handle path names with
umlauts alright.  For example, if you try to remove a checkout of git.git
(which unnecessarily contains an umlaut in a test for gitweb) with MSys'
"rm", it will fail.  It will say that it removed the file "Märchen", but
the file is still there.

We will see if at some point in future, we will be able to compile MSys
from within msysGit, and maybe we will be able to fix this issue.

For now, please try to avoid spaces in the installation path of msysGit!


Compiling Perl from scratch!
============================

Somehow I lured Simon Sasburg into trying to get Perl compiling inside
msysGit.  I already had compiled it, using the "official" method,
downloading dmake and stuff, and the result was a commit with a recipe
how to compile it from scratch (e887f810 in the "full" branch).

However, this was a MinGW Perl, not a MSys Perl.  Remember: the main
difference (usage-wise) is that MSys has a fake "/" directory.  So
wherever you install it, it will be able to find /etc/bla.  And the
perl I built cannot use that, and therefore does not find essential
parts of git, making it useless for our purposes.

Simon jumped through the hoops and got some additional packages from
mingw.org installed, and was nice enough to put that into a branch
in msysgit.git: msysperl.  When checking that branch out, you will
have a /perl directory with two scripts: one to download perl and
apply some patches, and another to build perl.


Including the 'html' branch as a submodule
==========================================

Steffen Prohaska, who was very interested in msysGit right from the start,
has joined the msysGit team.  He realised that the help was not working,
and created a new submodule containing the html pages, along with some
patches to allow opening these pages, even when msysGit (or GitMe or
WinGit) was installed to a path containing spaces.

So all of you, seeking help in WinGit, look forward to the release 0.3
of WinGit, which will include some.


The language wars, this time: no .NET in msysGit
================================================

We realised pretty soon that some convenient parts which are present in
every Unix system are simply lacking in Windows.

It begins with the missing C compiler, which is so untrivial to set up
that there was a demand for msysGit.  But it certainly does not end
there.

For example, the effort to compile Perl from scratch (see above) is
necessary so that we have the chance to compile the modules missing
for git-svn support.

In the midst of these efforts, a tool was checked in that allows you
to call an arbitrary diff viewer, by setting three environment
variables.

Of course, you could do that with a simple shell script, but it seems
some people are so uncomfortable with the shell that they have to
write a program to do the same.

The big problem with this program, though, is that it was written
using .NET 2.0.

I already had many complaints how many dependencies msysGit has, and
was actively working on reducing the size of the WinGit installer
by leaving out non-essential parts; and there was even talk about
making a WinGit installer that does not even install Perl.

So I was not happy with the situation, and moved the commits out of
our 'devel' branch into the branch 'dmitry/dotnet-gitdiff'.

In the wake of this cleanup, Steffen Prohaska proposed that all new
changes should first be committed to topic branches, and only move them
into 'devel' once another developer has seen them.

For a short time I was even thinking about asking all developers to
just fork msysgit.git, and work in their repositories, but for the
moment, it seems that we're okay with Steffen's proposal.

However, everyone who disagrees with me is (of course) free to fork
msysgit.git; repo.or.cz makes that trivial.


Inno installer
==============

Sebastian Schubert, a colleague of Steffen, was so disgusted with my
beautiful 7-Zip/Tk based installer that he decided to work on an Inno
based one.

Now, we already have a script to make an installer using NSIS (see the
"nsis-installer" branch of msysgit.git), but my biggest concern was
always to avoid installing other software than msysGit to build the
installers.  And as far as I can tell, NSIS is not really small.

Sebastian has promised that Inno would be small enough, so I guess
we'll just wait and see...

If it finds the unilateral love of the msysGit team members, version
0.3 of the WinGit installer will already be based on Sebastian's work.


Where is HOME?
==============

While working on the Inno setup, Sebastian suggested installing an
Explorer extension so that you can "Start Git Shell here" in the
Explorer.  Apparently a component of Inno makes it easy to add such a
small Explorer extension.

Unless you do a "cd $HOME" in /etc/profile, which we do.  So, when
calling the shell (which has to be a login shell) we want to stay
where we are, but we do not (this was requested in Issue 51 in our
issue tracker).

In the following discussions, it appeared that not everybody is
happy that Windows, Cygwin and MSys all have different home
directories.

I proposed changing the HOME in MSys to the Windows home, also known
as %USERPROFILE%.  This would help new users, as well as uninstalling
(since the repositories would be outside of the installation directory),
but it would also involve changing existing setups, and we're close to
700 downloads for WinGit, and double that for msysGit.

This issue is not resolved yet.
--8323584-307776946-1191554019=:4174--
