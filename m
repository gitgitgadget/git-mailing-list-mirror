From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 2 Nov 2007 12:40:00 +0100
Message-ID: <DEFB6632-9D04-4CDB-8FF0-DE2214826A5B@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <! 47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> <7vfxzpbtxv.fsf@gitste! 
 r.siamese.dyndns.org> <63FCD695-B952-4624-854C-0F1C662D94D1@zib.de> <7vk5p15bkv.fsf@gitster.s! iamese.dyndns.org> <417C801B-5DFF-4753-AB32-0FA1EB30C8E2@zib.de> <7v7il13p1g.fsf@gitster.siame!
 se.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 12:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inurs-0004ld-AP
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 12:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbXKBLi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 07:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXKBLi5
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 07:38:57 -0400
Received: from mailer.zib.de ([130.73.108.11]:62311 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbXKBLi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 07:38:56 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA2BcnMC022183;
	Fri, 2 Nov 2007 12:38:49 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA2Bcchr006407
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 2 Nov 2007 12:38:38 +0100 (MET)
In-Reply-To: <7v7il13p1g.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63106>


On Nov 2, 2007, at 11:44 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> - in a workflow that is base on shared branches (CVS-style),
>>   ...
>>   In addition push should push back to the remote branch a local
>>   topic was originally branched off.
>
> Why?  If it is shared, and if you are shooting for the simplest
> set of commands, wouldn't you work this way?

Yes. I would work exactly this way with current git.


> 	$ git clone $public my-work-dir
>         $ cd my-work-dir
>         $ git checkout -b --track foo origin/foo

So the implicit rule here is
"name a branch identical in all repositories you're dealing with"
right?

That is foo is named foo at the remote, named foo as a tracking
branch (git handles this automatically) and is named foo as your
local branch.

I believe it is reasonable. Though I have two questions:

1) If this is best practice, why doesn't save git me from typos?
    Why do I need to type "foo" correctly twice?

2) What shall I do if I am dealing with more than one shared
    repository?  Andreas' group should already run into problems
    here. They have several shared repos and if they want to
    checkout several local branches from different repos they
    need to somehow encode the name of the remote in the name
    of the local branch.


>         $ hack hack hack, commit, commit, commit *on* *foo*
>         $ git push $public foo
>
> I think the recent git defaults to --track anyway so the third
> step do not spell out --track.

It does.


> With your "remote.$public.push = HEAD", the last step would be
> "git push" without any parameter.

Indeed. Or with my "branch.$name.push" it would just be "git push"
as well. And I'd be probably happy then.


> If you do use private topics, then the story would change this
> way:
>
>         $ git checkout -b --track foo origin/foo
>         $ git checkout -b topic1 foo ;# or origin/foo

I'd be more happy without 'or'. I really want to give a single
recommendation.

So the question here is: Should I branch off the local branch or
should I branch off the remote branch? When should I do what?
What is best practice and what is used for 'exceptional'
situations?


>         $ hack hack hack, commit, commit, commit on topic1
>         $ git checkout -b topic2 foo ;# or origin/foo
>         $ hack hack hack, commit, commit, commit on topic2
>         $ git checkout foo
>         $ git merge topic1
>         $ test test test; # test _your_ changes
>         $ git merge topic2
>         $ test test test; # test _your_ changes
>         $ git push ;# again push 'foo' out

This focuses testing on the integration of topic1 with topic2.

You could as well do the following

	$ git checkout -b topic1 origin/foo
	$ hack ...
	$ git checkout -b topic2 origin/foo
	$ hack ..

	[ later ]
	$ git checkout topic1
	$ git pull # or git fetch; git rebase origin/foo
	$ test test test
	$ git push origin topic1:origin/foo

	[ later ]
	$ git checkout topic2
	$ git pull # or git fetch; git rebase origin/foo
	$ test test test
	$ git push origin topic2:origin/foo

With my "branch.$name.push" it would just be "git push" here.

This workflow focuses testing on the integration of each of your
topics with the new changes on the shared branch independently
of your other topic.

You're done at this point. No need to merge a second time,
no need to reset branches.

It's probably a good idea to delete your local branches
now. And there is one minor question related to that: Where
to park your HEAD if you want to clean up _all_ of your local
branches because you have nothing left to do? Everything is
on the shared remote branch. The only thing you're interested
now is to checkout new changes from the shared branch if
interesting work was done by others.


> This may fail to fast forward.  You may at this time want to
> "git fetch" first, rebase topic1 or topic2 that conflict with
> the other side on top of updated origin/foo, rebuild foo and
> push the result out, like this:

Or you could just pull

[ this continues Junio's example from above, you are on branch foo. ]

	$ git pull
	$ test test; # test of your integration of topic1, topic2
	             # with the new changes on the shared branch
	$ git push



> 	$ git fetch
>         $ git rebase origin/foo topic1
>         $ git branch -f foo origin/foo

Here is another interesting point.

Would you recommend "git branch -f foo origin/foo" over
"git checkout foo; git reset --hard origin/foo"? I think the
first command is safer because it doesn't throw away uncommitted
changes. However it fails if you are already on branch foo. Then it
says "fatal: Cannot force update the current branch.". It is not
very intuitive if I'd ask users to first leave the branch they
want to modify, only to be able to use "git branch". "git reset"
always lets you achieve your goal. (BTW, I don't recommend having
local changes while doing integration testing ... but who knows
maybe someone feels comfortable with it.)


>         $ git checkout foo
>         $ git merge topic1
>         $ git merge topic2
>         $ test test test
>         $ git push

Using rebase requires more commands than using pull, and more
intrusive  commands like "branch -f" or "reset --hard" are involved.

That doesn't mean that you should not use rebase. But it certainly
needs more explanation.

Another related question is the following: After some time the
user decides that some help on topic1 would be appreciated and
another developer promises to help. So they agree to work on
a shared branch name topic1. The first developer starts with

	$ git push origin topic1

 From now on he _MUST NOT_ use rebase any longer! So starting
to work on the topic with a second developer completely changed
the best practice. From now no rebase is forbidden, which was
best practice before.

So the question for me is: do I want to teach developer a pull
or a rebase workflow first? Currently I believe pull will be
safer for them, better supported by git, and there will be
situations they must use pull. If the only nuisance are loops
in the history when viewing them in gitk, I'm happy to accept
this.


>>   ... This makes the need for
>>   pushing to a branch named differently on the remote side more
>>   likely than in a pull-oriented workflow,
>
> So I do not understand this remark.

Yeah, I should have added some explanation here. I had Andreas'
200-local-branches and the topic1/topic2 example in mind that
does the integration against the shared branch.

	Steffen
