From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Naughty, Evil git-gui patches
Date: Thu, 22 May 2008 19:24:17 -0400
Message-ID: <20080522232417.GS29038@spearce.org>
References: <4835A00A.5050207@robertsr.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Barry Roberts <blr@robertsr.us>
X-From: git-owner@vger.kernel.org Fri May 23 01:25:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzK9o-0005m8-RZ
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 01:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758291AbYEVXYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758230AbYEVXYV
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 19:24:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38073 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413AbYEVXYV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 19:24:21 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JzK8m-0008F0-My; Thu, 22 May 2008 19:24:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A104D20FBAE; Thu, 22 May 2008 19:24:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4835A00A.5050207@robertsr.us>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82669>

Barry Roberts <blr@robertsr.us> wrote:
> The combination of compulsive command-line aversion among Windows users 
> and git-gui not being oriented toward CVS-like usage almost killed our 
> cvs->git transition.  These patches are emergency measures to appease 
> point-and-clickers transitioning from CVS, but  written by someone who 
> doesn't know TCL (or even git).  Written isn't even the appropriate 
> word, most are cut&paste from existing git-gui code.

Hah!  Do you know why git-gui came along?  Because it was written as
an emergency measure to allow a transition from no version control
at all to git at my day-job.  :-)

> Disclaimers and excuses:
> 0001 - All the CVS transition docs talk about pull, but not having it 
> in the gui means it doesn't really exist for some users

Yea, that has been a glaring difference between git-gui and command
line for a long time.  There is also the inability to add a remote,
or to do "git pull git://some/where for-linus" or some such one
shot pull.

> 0002 - I have read the reasons for having merge in the gui be more 
> strict than 'git merge' from the command line, but 'cvs update' never 
> gave a clean way to back out, so nobody here expects that anyway.

Maybe its just the way my brain works these days with git, but I
have never found the refusal to merge with a dirty working directory
to be a limitation.  I usually either don't have a dirty working
directory, or I stash into a temporary branch and switch back to
do the merge, then rebase or cherry-pick.  Yea, that does mean I
fall back to the command line in such cases.  Git Gui only users
don't have that option.

Once you get used to the idea of being able to recover your old
state after a merge has started (or even finished!) though the
idea of a dirty merge just sends chills down my spine.  Its a
really bad idea.  IMHO its like holding a loaded gun to your foot
and pulling the trigger every time you do a merge.  After a while
you run out of toes and have lost something you cared about.

Of course there is the school of thought that users should be
given that gun, with extra shells to boot.  I'd rather refuse to
do a dirty merge and let the user work with stashes in Git Gui.
Then the dirty merge error dialog can offer an option to stash
(and try to apply after merge) the dirty changes.  I think that
is the direction you were starting to go here.
 
> 0003 -  Yeah, I want to list the stashes and select from available 
> stashes to apply.  But this does the 80% of what we need (reducing 
> command line usage), and my tcl sk1llz aren't that l33t.

They are apparently l33t enough to come up with this set of changes.
Which is pretty good if you ask me.

Building a good looking list of stashes would probably require using
several columns of text widgets with a single scrollbar.  This is
how the blame viewer and gitk are put together.  Its ugly as s**t.
 
> 0004 - This is just a concession to (I think) Tortoise.  Just before you 
> commit, you notice that you left in a debug message.  This gives us an 
> easy way to fix by diff before commit'ing.  This requires setting 
> GIT_EXTERNAL_DIFF, or it's not very interesting.

I'm not sure I understand this.  Are you trying to get a diff for
the entire working directory against the staged files in the index?
As opposed to looking at each file individually?  What is your
external diff program able to show that git-gui's internal diff
viewer does not?

I'm not objecting to supporting GIT_EXTERNAL_DIFF, I just want to
better understand what you are trying to accomplish here so we can
make sure its the _right_ support.
 
> My intention in sending these is to hopefully generate some discussion 
> on how something like these changes can be done properly, with the 
> exception of patch 0002, which I fully intend to maintain as a local patch.

I definately see some value in your bastard patches and would like to
work with you to get them into a shape that we can include them.  :-)

-- 
Shawn.
