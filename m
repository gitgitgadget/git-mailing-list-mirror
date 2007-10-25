From: Federico Mena Quintero <federico@novell.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007
	unfinishedsummary continued
Date: Thu, 25 Oct 2007 11:06:26 -0500
Message-ID: <1193328386.4522.352.camel@cacharro.xalalinux.org>
References: <8fe92b430710221635x752c561ejcee14e2526010cc9@mail.gmail.com>
	 <92320AA3-6D23-4967-818D-F7FA3962E88D@zib.de>
	 <Pine.LNX.4.64.0710231155321.25221@racer.site>
	 <90325C2E-9AF4-40FB-9EFB-70B6D0174409@zib.de>
	 <20071024192058.GF29830@fieldses.org><471F9FD1.6080002@op5.se>
	 <20071024194849.GH29830@fieldses.org>
	 <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de>
	 <20071024203335.GJ29830@fieldses.org><471FB3D0.4040800@op5.se>
	 <20071024212854.GB6069@xp.machine.xx>
	 <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>
	 <Pine.LNX.4.64.0710242258201.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 25 18:06:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il5Db-0000Bp-N2
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 18:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbXJYQET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 12:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbXJYQET
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 12:04:19 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:23341 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbXJYQES (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 12:04:18 -0400
Received: from [164.99.192.129] ([164.99.192.129])
	by jericho.provo.novell.com with ESMTP; Thu, 25 Oct 2007 10:04:12 -0600
In-Reply-To: <Pine.LNX.4.64.0710242258201.25221@racer.site>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62331>

On Wed, 2007-10-24 at 23:14 +0100, Johannes Schindelin wrote:

> Whenever I told people "pull = fetch + merge", they got it.
[snip]
> My "pupils" _always_ liked the preciseness of the nomenclature.  And they 
> made many less mistakes because they had a clear mental model of what is 
> remote, and what is local.  And that local branches are always forks.

This is a *very* powerful concept.  Unfortunately, it is not 100% clear
in the documentation, at least not when you are reading about
fetch/merge/pull initially.

After reading the user's manual, I just could not understand what
"fetch" does, and therefore "merge" and "pull" did not make sense.  I
could not understand where Git stored the new changes from upstream
while also keeping my working directory in the same state it was.  After
10 years of using CVS/SVN, the assumption you have is, "whenever I get
changes from the remote repository, they will be visible in my working
copy (and merge conflicts are a fact of life)".

Some time later, I ran into "Git for computer scientists" and then
finally I got it, thanks to the nice diagrams and explanation.  I
realized how powerful a concept "fetch" is:  THIS is the right way to
examine what upstream worked on while you did your own local work.

Once you understand what's going on, however, it is not obvious how to
*visualize* the state of things after you do "git fetch".  Probably
"gitk --all" is the correct way to do it, but the presentation is not
ideal --- you have to hunt down the list of commits until you find your
own "master" (or whatever branch), and *there* is where you can say,
"oh, this is where we diverged; now let's see what I'll get when I
rebase later".

So, a few problems so far, with possible solutions:

* The docs do not make it easy to understand what git-fetch does.  Can
we just cut&paste most of "Git for computer scientists" into the Git
user's manual?).

* It's not obvious how to visualize the state after git-fetch, i.e.
"gitk --all" is not the first thing that occurs to you.  Maybe git-fetch
should suggest you to run "gitk --all" when your remotes get changes, so
that you can see what's going on?

* It's hard to find the "divergence point" in gitk's display, since you
have to scroll down the reverse-chronological list of commits until you
find your local refs and where they started diverging.  Would there be a
way to "flatten" the display a bit, so your local stuff is always easy
to find, and yet it's easy to see what the remote changes were?

> And here I have to disagree strongly.  In a workflow based on a
> shared 
> repository, you do not want to merge.  You want to rebase.

.. And after I understood what "fetch" does, "rebase" became obvious,
and *this* is where I started loving Git.  I understood that in the past
all I had been doing with CVS was to rebase by hand; that is where I
said "Git is such a powerful tool".

> But _even if_ you merge instead of rebase, I fail to see how the current 
> situation is different from CVS (which many people maintain is _easier_ 
> than gi), where first thing you do is to "cvs update".  Just for git it is 
> "git pull".

It's a matter of perception.  CVS requires *less* steps, even if you do
more manual work.  To commit something, you need to

  cvs update
  <resolve conflicts by hand - they are a fact of life, remember?>
  cvs commit

Whereas with Git you need

  git fetch
  git rebase <huh, what was the name of the remote branch?>
  <fix conflicts>
  git commit
  git push

[Maybe that's not 100% the right sequence, but you know what I mean.]

So your perception is that you have to fiddle more with Git (look up the
remote branch name, invoke more git commands), even if Git saved you a
lot of work when rebasing.

When you start using a complex tool like CVS or Git, you do it by
voodoo:  you learn sequences of commands, but you don't really
understand what they do.  If one tool makes you use less comands, it is
perceived as simpler and more powerful ("because the other one needs
more babysitting").

So, Git needs to make it very clear from the beginning (in the user's
manual or the distilled tutorials) that it has *very powerful* concepts
at your disposal.  It needs to *teach you* how it will save you a lot of
work when compared to traditional tools like CVS.

  Federico
