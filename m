From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 10:25:16 +0200
Message-ID: <4E5890F8-2184-4555-8FBE-6B92FE2590E9@zib.de>
References: <20071024194849.GH29830@fieldses.org> <86784BB7-076F-4504-BCE6-4580A7C68AAC@zib.de> <20071024203335.GJ29830@fieldses.org> <471FB3D0.4040800@op5.se> <20071024212854.GB6069@xp.machine.xx> <05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de> <Pine.LNX.4.64.0710242258201.25221@racer.site> <008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de> <Pine.LNX.4.64.0710250021430.25221@racer.site> <47204297.5050109@op5.se> <20071025073102.GD6069@xp.machine.xx> <47204C6D.3020900@op5.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 10:24:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iky0l-0000au-S6
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 10:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755711AbXJYIYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 04:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755616AbXJYIYB
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 04:24:01 -0400
Received: from mailer.zib.de ([130.73.108.11]:46783 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732AbXJYIX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 04:23:59 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9P8NlQ7015038;
	Thu, 25 Oct 2007 10:23:47 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9P8NkLa006976
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Oct 2007 10:23:46 +0200 (MEST)
In-Reply-To: <47204C6D.3020900@op5.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62287>


On Oct 25, 2007, at 9:57 AM, Andreas Ericsson wrote:

> 50+ repositories, with stable, testing and maint branches. Some  
> repos have more
> than that, so it amounts to roughly 200 branches. Each branch can  
> be modified by
> anyone (we're a small company - everyone still works everywhere),  
> but all changes
> should be done to the tip of the upstream branch. Especially for  
> maint this is a
> bit of a problem, since we frequently have consultants out and  
> about, and they
> sometimes find a bug that they commit locally to their own repo.  
> They're in a
> hurry though, and have no connection to the mothership repo so they  
> can't git-pull
> to get up to date. They aren't exactly developers, but savvy enough  
> to fix a few
> simple bugs, but the concept of the locally-modifiable branches not  
> being updated
> to their remote-tracking counterparts with each git-pull is just  
> incomprehensible
> to them. To me, that suggests that we're doing something wrong.

Johannes described a workflow using rebase. It would create
a very clean history avoiding long "parallel roads" and it
mimics what experience git users would probably do: Just work
if you have no connection but cleanup your work by using rebase
before pushing it.

Johannes, and Peter, too, propose to delete local branches
asap to avoid the third copy besides the copy on the server
and the copy in remotes. They suggest that local branches
should be absolutely reserved for local work.

However, my feeling is that the current tools make it too hard
to work the way described. Therefore it's hard to sell such a
workflow to an unexperienced developer. For example checking
out a remote branch for doing some local work, pushing this
work, and cleaning up requires

    git checkout -b <branch> origin/<branch>
    # work work ...
    git push origin <branch>
    git checkout <don-t-work-here>
    git branch -D <branch>

These are a lot of commands and some of them look quite
redundant.  Nearly every command contains <branch>. Why isn't is
sufficient to tell the name of the branch I'm working on once.
And '-D' looks even dangerous to me because it overrides all
safety checks. This should not be needed in daily work.

Here are some questions:
Do you think a workflow using rebase is feasible for
unexperienced git users?
What would be needed to bring such a workflow down to a few,
simple and reliable commands?

I think the general question is what I described in a previous
mail: You have a shared repository containing stable and topic
branches. Provide a workflow that is as simple as possible
for as many as possible developers. The average developer
should need nothing more than equivalents of "cvs update",
"cvs commit" for daily work if there are no conflicts. Note,
there are no redundant branch names allowed in the commands.
If a developer doesn't switch branches there's no need to
tell the branch name. "git pull ; ... ; git push" is simple
but it has the problem of reporting errors that average devs
don't understand.

	Steffen
