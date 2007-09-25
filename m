From: Andreas Ericsson <ae@op5.se>
Subject: Re: Workflow question
Date: Wed, 26 Sep 2007 00:38:50 +0200
Message-ID: <46F98DFA.7040705@op5.se>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se> <46F96493.8000607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 00:40:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJ4e-0000r6-Je
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 00:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbXIYWkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 18:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbXIYWkE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 18:40:04 -0400
Received: from mail.op5.se ([193.201.96.20]:49092 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbXIYWkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 18:40:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2094D194433;
	Wed, 26 Sep 2007 00:39:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.379
X-Spam-Level: 
X-Spam-Status: No, score=-4.379 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.020, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I0IN+Mer5bQT; Wed, 26 Sep 2007 00:38:51 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 145A91943F7;
	Wed, 26 Sep 2007 00:38:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <46F96493.8000607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59183>

Russ Brown wrote:
> Andreas Ericsson wrote:
>> Russ Brown wrote:
>>> Hi,
>>>
>>> I've been trying to think of a git workflow that we could use to replace
>>> our current svn/svk setup without simply using git in exactly the same
>>> way that we use svn/svk.
>>>
>>> Basically, we develop, maintain and enhance a website. On the central
>>> repo is trunk which represents live, and any number of project branches.
>>> Developers don't use local branches: they check out the project branches
>>> they're working on and commit to those. Developers merge from trunk to
>>> project branch from time to time to keep them current, and when a
>>> project rolls out the branch is merged to trunk.
>>>
>>> In addition to the obvious advantages that git would give us (such as
>>> properly tracking that code author as opposed to the person who did the
>>> merge), I'm wanting to gain the following benefits:
>>>
>>>  * The repository is very large (multiple gigabytes) and mirroring using
>>> svk obviously takes a lot of time and space, so I'm keen to bring that
>>> down, most likely by the developer not needing to mirror branches he
>>> doesn't care about, or by being able to throw away branches he's done
>>> with.
>>>  * The repository is full of revisions that fail review (or break
>>> things) and are fixed by subsequent revisions. We'd much rather be able
>>> to have the developer fix his revisions before they get committed
>>> 'upstream' (whatever that ends up meaning).
>>>
>>> I asked earlier about the email-based model that git itself uses, and
>>> while it appears to work very well for a widely-dispersed open-source
>>> project, I think it will be too cumbersome and slow for a fast-paced
>>> internal development team who make a number of live releases every day.
>>>
>> We came to the same conclusion at our workplace. Email works great, but
>> it's faster and better to just walk over to your colleague and ask what
>> he/she thinks about something.
>>
> 
> Very true, with the minor exception that at my place there are
> developers working at different sites, so the walk-over method will only
> work for specific subsets of the team. :)
> 

So do what Peff suggested and use emails for code-review and git-pull/push
for shoveling the code around. He's got some valid points. Where I work,
there's mostly three or at most four developers at any one team, so paired
programming or walking over works quite well. Otherwise we'd likely use the
patch-emails-for-review thing.


> Here's a question: is the creation and deletion of a branch also version
> controlled as it is in Subversion? In other words, if I create a branch,
> develop on it and delete it without merging it anywhere, will the
> revisions hang around and get pulled down by future people cloning the
> repository, or do they get thrown away?
> 

They don't get thrown away unless you garbage-collect them, using git-gc,
but they won't get propagated unless they can't be reached from a 'ref'
or a ref's log. The refs that can be propagated between repos are tags
and branches. There are others too, but they are less user-visible and
oftentimes more for housekeeping than anything else.

>>
>>>  4. Developers create a local branch of the project they
>>> are working on and commit to that.
>>>  5. Once they think they're done, they publish their branch to the
>>> development repo and request for comments.
>> Using topic-branches is a much better strategy, usually, since that
>> allows each feature to be evaluated and improved on on its own, rather
>> than having to merge *all* of a particular developers changes just to
>> get desirable feature X. Note that cherry-pick provides ways of doing
>> that anyways, but in a much less elegant way, and your integrator/
>> release engineer will likely tear his hair out on a daily basis without
>> topic branches.
>>
> 
> I've seen the term 'topic-branch' used here quite a bit but it's
> unfamiliar to me. It is basically synonymous with what we call a
> 'project branch'? i.e. Management decide that feature X is required so
> we create a branch to develop it on which all developers on the project
> commit to.
> 

Pretty much, yes. 'feature branch' and 'topic branch' are interchangeable.

> Note that in step 4 above I mean the developer takes a local branch of
> the topic branch. For example, we start projectX/main, and create branch
> projectX on the shared repo. Developer 'jeff' works on the project and
> so creates local branch projectX/jeff and begins work. In step 5 they
> push this local branch to the shared repo so everyone can see it
> (alternative to the 'walk-over' method or emailing). Note that all
> changes jeff making in projectX/jeff are specific to the project branch,
> so he can rebase against other changes that get committed to that
> project branch.
> 
> If colleagues don't like his changes he can create projectXjeff2 and try
> again.
> 
> Jeff can also have other local branches to keep separate changes he is
> making on the other projects he is involved in.
> 
> That's how I'd thought of it happening...
> 

Ye, that sounds about right.

>>>  6. If all is not well, the developer creates a new local branch and
>>> moves good revisions from his previous one to the new one, modifying
>>> things as he goes, and republishes his new branch.
>>>  7. If all is well, their works gets merged or rebased onto the main
>>> project branch, and once that's ready it gets pushed to the master and
>>> rolled to live. The developer's individual branches get deleted from the
>>> dev repo since they're no longer required.
>> Topic branches would work the same, basically, except they can be pushed up
>> for review a lot faster.
>>
>> If all the pushing gets cumbersome, it also makes it easy to send the
>> patches
>> out as emails for discussion. It's usually easier to let git handle the
>> actual code transmissions, but discussing patches in emails works quite
>> well if it's intended for a wider audience.
>>
> 
> Yes, I am going to experiment with this a little too to see just how
> much work it would involve for the developers (if it's too much they
> won't do it) :)
> 

It's a slightly steeper starting cost, but the maintenance costs go way
down, so the developers can spend more of their time doing fun and new
stuff rather than figuring out how to get their already-ancient fixes
merged to the master-branch.

>>>  8. From time to time the master branch gets merged to the project
>>> branches. Developer's local branches can be rebased against the project
>>> branch as they please.
>>>
>> criss-cross merging can turn kinda nasty though, as you may have a hard
>> time
>> finding *the* common point when you run into that rogue merge with conflict
>> markers everywhere (it happens for everyone sooner or later).
>>
>> I'd suggest you rebase the developer/topic branches onto master with
>> regular
>> intervals instead.
>>
> 
> Having been using git-svn for a while I really like the clean history
> result that rebase gives, however my understanding was that you should
> never rebase any published branch as it could screw up clones of that
> branch. In fact, this is what has me the most confused: how to rebase a
> project branch that is on a shared repository against master when
> everyone will have it cloned? Or is this something that I clearly don't
> understand properly?
> 

Well, afaiu you want every developer to have his own topic-branch, in
which case they can simply rebase those topic-branches onto master,
which will make sure they always know they're conflict-free with the
latest bugfixes and whatnot.

They don't really have to push their changes upstream until they're
ready for review.

> (Thanks for your answers BTW Andreas)
> 

np. Happy to help :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
