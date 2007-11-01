From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict
 subset of remote ref
Date: Thu, 01 Nov 2007 10:11:49 +0100
Message-ID: <47299855.9010204@op5.se>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935812741-git-send-email-prohaska@zib.de> <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de> <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z
  ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 01 10:12:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InW6A-0004HL-9Q
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 10:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504AbXKAJME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 05:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755363AbXKAJMC
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 05:12:02 -0400
Received: from mail.op5.se ([193.201.96.20]:46197 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755303AbXKAJMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 05:12:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 68DB81730573;
	Thu,  1 Nov 2007 10:11:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uMx7Eh-8G2zl; Thu,  1 Nov 2007 10:11:47 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E2FEA1730563;
	Thu,  1 Nov 2007 10:11:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62931>

Steffen Prohaska wrote:
> 
> On Oct 31, 2007, at 10:31 PM, Junio C Hamano wrote:
> 
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>>>> You forgot a lot more important part.  Pushing into publishing
>>>> repositories.  And the discussion is about git-push command.
>>>
>>> Exactly, here are two examples:
>>>
>>> If you push only to publishing repositories that are read
>>> only by others, you'll never encounter the problem that
>>> 10/10 tried to solve. The publishing repository is never
>>> changed by others. You are the only one who pushes to this
>>> repository. Therefore the remote never advances unexpectedly.
>>
>> Wrong.
>>
>> People can and do work from more than one private repositories
>> (I do).  In a sense, that is sharing the repository with
>> oneself.
> 
> I do, too. But as long as I do not forget what I've done, the
> branches do not advance _unexpectedly_. I am in full control.
> 
> 
>> I may do an emergency patch to fix breakage on 'maint' (and
>> 'maint' only) from a location that is not my primary development
>> box and push the fix out.  I fully expect that the push will
>> push out 'maint' and expect the other branches such as 'master'
>> on the remote side to stay the same, as I haven't touched
>> 'master' on that box for quite a while and it is now stale.  In
>> that situation, I _want_ the "git push" itself to report failure
>> to notify me that it did not push what _I_ asked it to push out,
>> so that I can be reminded that I'd better do "git push $remote
>> maint" the next time.  In the meantime, even though it reports
>> a failure, 'master' on the remote side is _not_ updated, so the
>> behaviour is still _safe_.
> 
> You're right it is safe, but it may be confusing.
> 
> 
>>> Another difference is the way changes are integrated. In
>>> a workflow without shared repositories, only pull is used
>>> for integration, while push in only used for publishing the
>>> changes.
>>
>> Wrong.  push is a mirror of fetch and does not do _any_
>> integration.  It is just a safe (because it insists on
>> fast-forward) propagation mechanism.  Your integration still
>> happens with pull (actually, shared repository people seem to
>> prefer "fetch + rebase" over "pull" which is "fetch + merge").
> 
> Right; but you can't push without doing the integration. If you
> have new changes on the remote side you _must_ pull before
> you can push.

Yes, because otherwise you'd rewrite published history. That's not
a good thing.

> You're forced to do the integration immediately.

Yes, but you get to choose how. Perhaps git-push should list more
options than just git-pull, such as the three commands required to
rebase the currently checked out branch onto its remote counterpart.
That would support more workflows.

> Your main objective was to push, but the shared workflow forces
> you to do the integration _now_ (by using pull). In a pull-only
> workflow, you can just push and defere the integration for later.
> 

No, you can also fetch + rebase.

> Some people claim fetch + rebase is superior to fetch + merge.
> The only point I can see is that fetch + rebase gives a linear
> history without loops, which is nicer to visualize. I recently
> asked on the list if there are any benefits of fetch + rebase
> over fetch + merge, besides a nicer visualization.


It's easier to bisect. If git bisect lands you on a merge-commit,
you need to start a new bisect for each of the parents included
in the merge. Hopefully the nature of the merge gives a clue so
the user can make an educated guess as to which parent introduced
the bogus commit, but for an "evil octopus" (unusual) or if the
merge had conflicts which were resolved in a buggy way (not
exactly uncommon), it can be quite a hassle to get things right.
With a mostly linear history, this problem goes away.


> I didn't
> receive many interesting comments. One comment explained
> that rebase can shift the merge conflict resolution from
> the maintainer (merge) to the original author (rebase). But
> this is not very interesting in a shared workflow, because
> the author must resolve conflicts in any case before he can
> push. It doesn't matter much if he uses merge or rebase to
> do so.
> 

It depends. When commit ordering doesn't matter the original
author can use "git rebase --skip" and then continue with the
rebase to get as much as possible out as quickly as possible.
I'm in the unfortunate position of having a boss that likes
to fiddle with help-texts in code when it's in alpha-testing.
Sometimes that causes conflicts but it's often not important
enough to spend 30 minutes figuring out how to resolve it
properly. I tend to just skip those patches and send them as
emails to our tech-writer instead, asking him to rephrase the
text to incorporate both changes, and then manually applying
the text to the end result.

> 
> I am searching for a solution that just works for them. They
> currently use CVS. I'll give them a detailed getting started
> document for git. The workflow described should be as simple as
> possible, but safe and reliable.


If they're used to CVS and want to use more than one branch without
having to learn additional syntax, nothing can help, methinks.

> 
> Another question is what to do with a local branch after
> you finished work. We recently had the
> "Re: best git practices, was Re: Git User's Survey 2007
> unfinished summary continued" aka the 200-local-branches
> discussion.
> 

We're at 224 branches now, having added 7 new repos.

> There were different suggestions what to do. A reasonable
> suggestion was to delete the local branch after you're done.

Except that it doesn't work unless you either detach the HEAD
(which prints a big fat ugly message) or give it -D to force
it, which I really, really don't recommend. We use git because
I'm pretty confident in its capabilities of never ever losing
anything. Using the seemingly harmless -D switch to git-branch
puts us at risk of wiping history quite without noticing.

> This clearly distinguishes between remote branches (which are
> mirrored as a remote tracking branch) and local branches. Local
> branches are _your_ branches while the remote branches contain
> the shared work. If you're done with your local work, delete
> your local branch. So maybe you should do
> 
>    git checkout origin/devel

Except that this gives a warning-esque message:
Note: moving to "origin/devel" which isn't a local branch
If you want to create a new branch from this checkout, you may do so
(now or later) by using -b with the checkout command again. Example:
  git checkout -b <new_branch_name>
HEAD is now at deadbeef... Ma! Pa butchered all the cows!

To me, this indicates I've done something git thinks I shouldn't have.

> 
> Independently of what the best practice is, leaving the local
> work branch there shouldn't do any harm because I'm sure that
> some devs will forget to clean up, independently of what I tell
> them.
> 

I wholeheartedly agree with this one.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
