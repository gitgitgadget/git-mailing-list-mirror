From: Russ Brown <pickscrape@gmail.com>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 14:42:11 -0500
Message-ID: <46F96493.8000607@gmail.com>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 21:42:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaGIg-00016N-Iv
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 21:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbXIYTmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 15:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754402AbXIYTmX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 15:42:23 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:24545 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668AbXIYTmW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 15:42:22 -0400
Received: by an-out-0708.google.com with SMTP id d31so303697and
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 12:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=c2hgDdUcnDNs+z0ytEo+Wot73RSm8Y7tKTolQboZNKM=;
        b=eYYhEZoHco18NCJcqvijD2e/LpW/zK/ddkLEyJkdK19tj7Ki0Ijun9z+JE/XVAMEYa6Gbsm42KYf1sGOSygQ7wU7nU4nWmNm/9xanZqSO83Q822xdwhhdhZCm7C6UpjHFO2UF826DJ3LQoEQR6zp+PfDn9vRauXUHS4yrvX8f7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fGxWPmoHO/znp84889gQ3WWvTR36xxGX1gjSbh8HZOjqczZ/Iutu2kbindjGXiFe4tkZgADpPHHEgsiMi7D8CRKi83IIyyp+IC4XG15C1CDG1QXMCooiS8TKOe0d6ejKKadJdC+snsO20Nh2IID0UubotFUCpeCFxoV+FsjB4wU=
Received: by 10.100.95.19 with SMTP id s19mr14520827anb.1190749341083;
        Tue, 25 Sep 2007 12:42:21 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.252.196.170])
        by mx.google.com with ESMTPS id d36sm7288827and.2007.09.25.12.42.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Sep 2007 12:42:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
In-Reply-To: <46F95CCC.4080209@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59160>

Andreas Ericsson wrote:
> Russ Brown wrote:
>> Hi,
>>
>> I've been trying to think of a git workflow that we could use to replace
>> our current svn/svk setup without simply using git in exactly the same
>> way that we use svn/svk.
>>
>> Basically, we develop, maintain and enhance a website. On the central
>> repo is trunk which represents live, and any number of project branches.
>> Developers don't use local branches: they check out the project branches
>> they're working on and commit to those. Developers merge from trunk to
>> project branch from time to time to keep them current, and when a
>> project rolls out the branch is merged to trunk.
>>
>> In addition to the obvious advantages that git would give us (such as
>> properly tracking that code author as opposed to the person who did the
>> merge), I'm wanting to gain the following benefits:
>>
>>  * The repository is very large (multiple gigabytes) and mirroring using
>> svk obviously takes a lot of time and space, so I'm keen to bring that
>> down, most likely by the developer not needing to mirror branches he
>> doesn't care about, or by being able to throw away branches he's done
>> with.
>>  * The repository is full of revisions that fail review (or break
>> things) and are fixed by subsequent revisions. We'd much rather be able
>> to have the developer fix his revisions before they get committed
>> 'upstream' (whatever that ends up meaning).
>>
>> I asked earlier about the email-based model that git itself uses, and
>> while it appears to work very well for a widely-dispersed open-source
>> project, I think it will be too cumbersome and slow for a fast-paced
>> internal development team who make a number of live releases every day.
>>
> 
> We came to the same conclusion at our workplace. Email works great, but
> it's faster and better to just walk over to your colleague and ask what
> he/she thinks about something.
> 

Very true, with the minor exception that at my place there are
developers working at different sites, so the walk-over method will only
work for specific subsets of the team. :)

>> So, I've been thinking and have come up with this, which I'd appreciate
>> comments about:
>>
>>  1. On a server we stick a git repository which contains the master
>> branch, which represents what trunk did (i.e. the live platform). This
>> branch contains the full history for the live platform.
> 
> A must-have for any more-than-two-developers setup, so so far so good ;-)
> 
>>  2. On the same server we clone that repo to create a second repository
>> which is the developer area. In this we track master from the live repo,
>> and also create project branches.
> 
> This isn't necessary. Branches in git are very nearly zero-cost, so having
> them in the same repo as the master branch won't hurt a bit. You can add
> an update-hook on the mothership repo to restrict access to the master
> branch if you like, but creating two separate repos will likely give
> more headache than it's worth.
> 

Ah, right. I'm just trying to remember why it was I came up with that
idea in the first place, but I'm struggling a bit. :)

>>  3. Developers clone this developer repo, but I'd like them to be able
>> to decide which branches they actually want to clone from that
>> repository rather than simply cloning them all. Is this possible?
> 
> Yes, although I'd actually recommend you to clone the full repo anyway.
> Since the various branches are likely to share quite a lot of history
> the added overhead of a few extra branches will most likely be negligible.
> git makes even very large codebases appear small and unobtrusive. The
> linux kernel history since 2.6.12 contains 554853 objects and compresses
> down to 178MiB.
> 

Makes sense. Thing is, with git-svn (which I've been using for a while
now) it's possible to 'bring in' an upstream branch at will by adding it
to your config file, and on next git-svn fetch revisions that affect
that branch are automatically fetched. I figured it would just be a
little more efficient, though I appreciate it involves more 'fiddling'
by the client users.

Here's a question: is the creation and deletion of a branch also version
controlled as it is in Subversion? In other words, if I create a branch,
develop on it and delete it without merging it anywhere, will the
revisions hang around and get pulled down by future people cloning the
repository, or do they get thrown away?

> I think KDE is the largest repo imported to git so far. I've forgotten
> the exact numbers, but everyone was very impressed, and quite surprised,
> at the vast difference between SVN and git storage requirements.
> 
> 
>>  4. Developers create a local branch of the project they
>> are working on and commit to that.
>>  5. Once they think they're done, they publish their branch to the
>> development repo and request for comments.
> 
> Using topic-branches is a much better strategy, usually, since that
> allows each feature to be evaluated and improved on on its own, rather
> than having to merge *all* of a particular developers changes just to
> get desirable feature X. Note that cherry-pick provides ways of doing
> that anyways, but in a much less elegant way, and your integrator/
> release engineer will likely tear his hair out on a daily basis without
> topic branches.
> 

I've seen the term 'topic-branch' used here quite a bit but it's
unfamiliar to me. It is basically synonymous with what we call a
'project branch'? i.e. Management decide that feature X is required so
we create a branch to develop it on which all developers on the project
commit to.

Note that in step 4 above I mean the developer takes a local branch of
the topic branch. For example, we start projectX/main, and create branch
projectX on the shared repo. Developer 'jeff' works on the project and
so creates local branch projectX/jeff and begins work. In step 5 they
push this local branch to the shared repo so everyone can see it
(alternative to the 'walk-over' method or emailing). Note that all
changes jeff making in projectX/jeff are specific to the project branch,
so he can rebase against other changes that get committed to that
project branch.

If colleagues don't like his changes he can create projectXjeff2 and try
again.

Jeff can also have other local branches to keep separate changes he is
making on the other projects he is involved in.

That's how I'd thought of it happening...

>>  6. If all is not well, the developer creates a new local branch and
>> moves good revisions from his previous one to the new one, modifying
>> things as he goes, and republishes his new branch.
>>  7. If all is well, their works gets merged or rebased onto the main
>> project branch, and once that's ready it gets pushed to the master and
>> rolled to live. The developer's individual branches get deleted from the
>> dev repo since they're no longer required.
> 
> Topic branches would work the same, basically, except they can be pushed up
> for review a lot faster.
> 
> If all the pushing gets cumbersome, it also makes it easy to send the
> patches
> out as emails for discussion. It's usually easier to let git handle the
> actual code transmissions, but discussing patches in emails works quite
> well if it's intended for a wider audience.
> 

Yes, I am going to experiment with this a little too to see just how
much work it would involve for the developers (if it's too much they
won't do it) :)

>>  8. From time to time the master branch gets merged to the project
>> branches. Developer's local branches can be rebased against the project
>> branch as they please.
>>
> 
> criss-cross merging can turn kinda nasty though, as you may have a hard
> time
> finding *the* common point when you run into that rogue merge with conflict
> markers everywhere (it happens for everyone sooner or later).
> 
> I'd suggest you rebase the developer/topic branches onto master with
> regular
> intervals instead.
> 

Having been using git-svn for a while I really like the clean history
result that rebase gives, however my understanding was that you should
never rebase any published branch as it could screw up clones of that
branch. In fact, this is what has me the most confused: how to rebase a
project branch that is on a shared repository against master when
everyone will have it cloned? Or is this something that I clearly don't
understand properly?

(Thanks for your answers BTW Andreas)

-- 

Russ
