From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: interactive rebase results across shared histories
Date: Fri, 26 Feb 2016 23:56:50 +0100
Message-ID: <20160226225650.GA3185@ucw.cz>
References: <87io1j6laz.fsf@gmail.com>
 <56C91D21.90306@moritzneeb.de>
 <87io1f5nsi.fsf@gmail.com>
 <56CCE3C2.1050608@moritzneeb.de>
 <87egc358ou.fsf@gmail.com>
 <CAMPXz=on8ONkzDYWEEGFqqKhRoBb9zYBqmYDBsKWagdwFRPRdA@mail.gmail.com>
 <87povj41m9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seb <spluque@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 00:04:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZRRQ-0001FV-QZ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbcBZXEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:04:52 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56638 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbcBZXEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:04:51 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Feb 2016 18:04:51 EST
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
	id D66691C0122; Fri, 26 Feb 2016 23:56:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87povj41m9.fsf@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287632>

Hello Seb,

let me add a few things, perhaps they'll clean some misunderstandings.

On Fri, Feb 26, 2016 at 03:12:46PM -0600, Seb wrote:
> After cleaning up all the mess, I've ended up with a long master branch,
> and a series of earlier commits that are not reachable from master.
> Fortunately, the tags have kept them alive. This is the scenario
> simplified:
> 
> A---C---D(tag2)                 loose commits (not on any branch)
>  \
>   B(tag1)
> 
> E---F---G---H---*               (master)

I noticed that these are tags.  Actually, tags in git are meant to mark
certain fixed points, and they are not meant to change in the future.

They are used to mark releases in the project, and they can even have
a cryptographic signature attached to it, so that no one can forge them.

I guess that you used them as a temporary mark for yourself when you
reaced a point in development, or to mark a stable point as a base for
future development.  If that was the case, you could have used a branch
as well.

I guess that people subconsciously still think that branch is ecpensive,
based on the experiences from other VCS.  It's not true: branch is
a variable that holds a value: the hex id of the top commit.
As you do not care how many variables you need to declare when writing
code, you should not hesitate to create as many branches as you need
to mark the points in the history.

Perhaps you just delte the tags.  That would be true if the code
in these old branches has already been copied (by rebase) to the new
master.

If you would like to mark the corresponding points in the rewritten
history, you can create these marks again.  (As branches, perhaps.)

Then you say that you want to put everything to one branch master,
to create a linear history of development.  (Well, not true history,
but a made up history, you see.)

For that goal, does master already contain all the code?
If yes, then you have it.  You can perhaps just delete all the old
branches that were used to develop individual parts...

I'm working on a project, where we decided to have linear history
on the main server.
So my own local git clone of my work contains lots of branches named
after features and their combination, like:
    counting
    counting-3counters
    pairs
    counting-with-pairs
    counting-3c-pairs

I use rebase heavily to move each of the feature (=series of commits)
to another branch ot to master.

For example, when i wanted to enhance branch "counting" with the feature
"pairs," I did it like this:

git branch counting-with-pairs pairs
git rebase -i counting counting-with-pairs

That will take all the commits that are in pairs, but not in counting.
(This is usually all the commits in "pairs", staring from the point
where in branched from master.) And all these get replayed on the tip of
"counting".

Likewise, I can move the topic to the latest master, then move master
(git checkout master; git merge --ff-only some-branch)
and then push.

BTW, another thing:
when you decided to clean up the history -- are there any other
people working with the repository you are working with?

If yes, then each of them has to be prepared to follow your cleanup.
All their work is currently base on the old history; if they push
their work all the old hostory will be back.

They could throw away their current local clones and start anew,
if they had no work there.  But that's probaably not the case.

So they have to fetch your new history of master and then rebase
all of their features --onto your new master.

I hope some of my talking will be useful.

Stepan
