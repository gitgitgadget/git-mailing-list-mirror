From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Thu, 1 Nov 2007 08:03:57 +0100
Message-ID: <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z
  ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 08:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InU78-0007KE-Ja
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 08:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbXKAHE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 03:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbXKAHE7
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 03:04:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:35290 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753164AbXKAHE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 03:04:58 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA172cSx006281;
	Thu, 1 Nov 2007 08:04:43 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1f43e.pool.einsundeins.de [77.177.244.62])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA172YlD002616
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 1 Nov 2007 08:02:34 +0100 (MET)
In-Reply-To: <7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62924>


On Oct 31, 2007, at 10:31 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>>> You forgot a lot more important part.  Pushing into publishing
>>> repositories.  And the discussion is about git-push command.
>>
>> Exactly, here are two examples:
>>
>> If you push only to publishing repositories that are read
>> only by others, you'll never encounter the problem that
>> 10/10 tried to solve. The publishing repository is never
>> changed by others. You are the only one who pushes to this
>> repository. Therefore the remote never advances unexpectedly.
>
> Wrong.
>
> People can and do work from more than one private repositories
> (I do).  In a sense, that is sharing the repository with
> oneself.

I do, too. But as long as I do not forget what I've done, the
branches do not advance _unexpectedly_. I am in full control.


> I may do an emergency patch to fix breakage on 'maint' (and
> 'maint' only) from a location that is not my primary development
> box and push the fix out.  I fully expect that the push will
> push out 'maint' and expect the other branches such as 'master'
> on the remote side to stay the same, as I haven't touched
> 'master' on that box for quite a while and it is now stale.  In
> that situation, I _want_ the "git push" itself to report failure
> to notify me that it did not push what _I_ asked it to push out,
> so that I can be reminded that I'd better do "git push $remote
> maint" the next time.  In the meantime, even though it reports
> a failure, 'master' on the remote side is _not_ updated, so the
> behaviour is still _safe_.

You're right it is safe, but it may be confusing.


>> Another difference is the way changes are integrated. In
>> a workflow without shared repositories, only pull is used
>> for integration, while push in only used for publishing the
>> changes.
>
> Wrong.  push is a mirror of fetch and does not do _any_
> integration.  It is just a safe (because it insists on
> fast-forward) propagation mechanism.  Your integration still
> happens with pull (actually, shared repository people seem to
> prefer "fetch + rebase" over "pull" which is "fetch + merge").

Right; but you can't push without doing the integration. If you
have new changes on the remote side you _must_ pull before
you can push. You're forced to do the integration immediately.
Your main objective was to push, but the shared workflow forces
you to do the integration _now_ (by using pull). In a pull-only
workflow, you can just push and defere the integration for later.

Some people claim fetch + rebase is superior to fetch + merge.
The only point I can see is that fetch + rebase gives a linear
history without loops, which is nicer to visualize. I recently
asked on the list if there are any benefits of fetch + rebase
over fetch + merge, besides a nicer visualization. I didn't
receive many interesting comments. One comment explained
that rebase can shift the merge conflict resolution from
the maintainer (merge) to the original author (rebase). But
this is not very interesting in a shared workflow, because
the author must resolve conflicts in any case before he can
push. It doesn't matter much if he uses merge or rebase to
do so.

I evaluated if teaching people fetch + rebase before teaching
fetch + merge is a good idea. Therefore I tested some scenarios
with people who are new to git. The result is that there are
too many situations where fetch + rebase might be confusing.
I abandoned my idea.

I decided that fetch + merge is _easier_. It works in all
situations, it's easier to explain, it's better supported
(automerge), it can be used to work on shared topic branches.
Definitely fetch + merge is the first workflow you should
learn. At the moment I'm not anymore interested in the fetch +
rebase approach.


>> This is different if you work with a shared repository. Bob
>> checks out the shared branch foo to his local branch bar and
>> later he needs to push bar back to the shared branch foo. Bob
>> needs to push changes from his local branch bar to the branch
>> foo in the remote repository, a branch with a different name.
>> This need does not emerge when working with two publishing
>> repositories, as described above.
>
> So you do "git push $remote bar:foo".  If you do that regulary,
> there are configuration mechanisms to help you reduce your
> keyboard wear.  What's the problem?

Too complex and not flexible enough.

The configuration is in the remote section. Therefore I can
tell git what to do only on a per-branch basis. What do you
think about my recent proposal to add branch.$name.push?


And I want to avoid that people need to learn about the details
of the configuration mechanism on the first time they use git.

I am searching for a solution that just works for them. They
currently use CVS. I'll give them a detailed getting started
document for git. The workflow described should be as simple as
possible, but safe and reliable. No confusing error messages
should appear. Only a few commands should be needed to
contribute to a shared branch. The workflow described should
use git in a sane way that provides opportunities to use more
of its power later.

So here is what I'd like to have.

    git clone ssh://server/git/project.git project

    [ On Windows the hassel already starts because it actually is

	git clone -n ssh://sever/git/project.git project
	git config core.autocrlf true

      And here's the next point. git config doesn't validate the
      variable. It accepts _any_ variable. If you have a typo
      you go without autocrlf. ... but this is a different story. ]

    cd project
    git checkout -b devel origin/devel
    # work, commit, work, commit
    git push  # maybe git pull first, but git would tell you

The last command, git push, can already cause trouble. git
automatically created a local master and the remote master
may have advanced, so git push would complain with an error.
Currently the correct command would be
"git push origin devel".


An alternative scenario is that you want to start work that
will not be ready right away. So you start a topic branch

    git checkout -b topic origin/devel
    # work, commit, some time passes, work, commit
    git pull 	# integrate changes from devel
    # work, commit
    git pull
    git push 	# this one should push to origin/devel


In scenario three you planned to finish your work right away
but the problem turned out to be harder. Here, the following
would be nice

    git checkout -b devel origin/devel
    # work, commit, hmm... much harder ...
    git branch -m devel dolater

    # do something else

    git checkout dolater
    # finish work
    git pull    # integrate with other work on devel
    git push    # push back to shared branch


Another question is what to do with a local branch after
you finished work. We recently had the
"Re: best git practices, was Re: Git User's Survey 2007
unfinished summary continued" aka the 200-local-branches
discussion.

There were different suggestions what to do. A reasonable
suggestion was to delete the local branch after you're done.
This clearly distinguishes between remote branches (which are
mirrored as a remote tracking branch) and local branches. Local
branches are _your_ branches while the remote branches contain
the shared work. If you're done with your local work, delete
your local branch. So maybe you should do

    git checkout origin/devel
    git branch -d devel

Now you're on a detached branch that points to origin/work.
But how to do you get new changes from others? git pull would
not work and git fetch neither.

Independently of what the best practice is, leaving the local
work branch there shouldn't do any harm because I'm sure that
some devs will forget to clean up, independently of what I tell
them.

	Steffen
