From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sat, 7 Apr 2012 22:36:04 +0800
Message-ID: <C4A7A206-76E6-4828-A05A-141889F7B527@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <EAF9D593-4E0C-4C95-A048-3F6AC8ADD866@gmail.com> <201202061445.13203.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 16:36:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGWke-0005vo-My
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 16:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab2DGOgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 10:36:23 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:64061 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab2DGOgV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 10:36:21 -0400
Received: by dake40 with SMTP id e40so3710463dak.11
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=ObHtkG5m02YPKWeBdkG1bwH1The88C7wVEPpVNzwDeU=;
        b=yfd8h5v5PpzueAkzCEXxWkSg6+Q3t/yM85e7jXplJTFQJFiVadIx96aOyn3pqS8y8U
         5DomH3M1spRfSsuYbUzoeildTtyAK+HfPkn11YrCiRVdwl6Uh0JLxr9woOTSdWWYDIRW
         s2N8g+PRPPoa7nHKWcJPqtfg/QoHZQXI0kK+Qw/WWyKBZ3nsZwR+6Vd6V3LuYWCNwcUR
         y0qo+YAd7qiPVk+78ZWU8e20muK/rx40/WWJsCi9lf4C7HzdHmby9eqCdqLNOMul8910
         B6HLaNM5twKtJK11a56fauMeBR9Z+oDOg4ba3eNywSJnewB5h1DMucTlvbUJAQa6j1c9
         LQ7g==
Received: by 10.68.241.8 with SMTP id we8mr1728848pbc.140.1333809381455;
        Sat, 07 Apr 2012 07:36:21 -0700 (PDT)
Received: from [10.0.1.2] ([222.66.106.162])
        by mx.google.com with ESMTPS id f4sm9353243pbg.56.2012.04.07.07.36.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 07:36:20 -0700 (PDT)
In-Reply-To: <201202061445.13203.jnareb@gmail.com>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194952>

Saw that this was put into GSOC and reread the thread.


On Feb 6, 2012, at 9:45 PM, Jakub Narebski wrote:

> On Mon, 6 Feb 2012, Steven Michalske wrote:
> 
>> See inlined responses below.
> 
> Is this comment necessary at all?

Oddly enough yes.
> 
>> On Feb 4, 2012, at 11:45 AM, Jakub Narebski wrote:
>> 
>>> So people would like for git to warn them about rewriting history before 
>>> they attempt a push and it turns out to not fast-forward.
>>> 
>> 
>> I like this idea and I encounter this issue with my co-workers new to git.
>> It scares them thinking they broke the repository.
> 
> It is true that while this feature would be useful also for "power
> users", it would be most helpful for newbies (users new to git).
> 
> So I am afraid that implementing it with example hooks that must be
> turned on explicitly might be not enough...
> 
>>> In Mercurial 2.1 there are three available phases: 'public' for
>>> published commits, 'draft' for local un-published commits and
>>> 'secret' for local un-published commits which are not meant to
>>> be published.
>>> 
>>> The phase of a changeset is always equal to or higher than the phase
>>> of it's descendants, according to the following order:
>>> 
>>>     public < draft < secret
>> 
>> Let's not limit ourselves to just three levels.  They are a great start
>> but I propose the following. 
> 
> As we don't have any implementation, I'd rather we don't multiply entities.
> I was even thinking about limiting to just 'public' and 'draft' "phases".
> 
>> published - The commits that are on a public repository that if are
>>      rewritten will invoke uprisings. general rule here would be
>>      to revert or patch, no rewrites. 
>> based - The commits that the core developers have work based upon.
>>      (not just the commits in their repo.) 
>> 	general rule is notify your fellow developers before a rewrite.
>> shared - The commits that are known to your fellow core developers.
>> 	These commits are known, but have not had work based off of them.
>> 	Minimal risk to rewrite. 
> 
> All these are very fairly nuanced, with minuscule differences between
> them.  I'd rather not multiply entities, especially not introduce such
> hard to guess what it about from their name.
> 
Fair enough, the intent was to get folks thinking about where they could go.

As for published, it carries a higher meaning than public.  For example I have a public repo, and all the commits are public.
but if I make a notice that 1 of the branches "in_progress" is often rebased.... (I know of one stacked git user that does this)
 and that the master and dev branches are never going to be rewritten.  So master and dev are Published and Public, where "in_progress" is not.

So it would be nice that git would warn me if I based a branch off of a non published branch.

> In Mercurial phases share hierarchy of traits:
> http://mercurial.selenic.com/wiki/Phases
> 
>           |        traits       |
>           .......................  
>           | immutable | shared  |
> ----------+-----------+---------+
> public    | x         | x       | ^
> draft     |           | x       | ^
> secret    |           |         | ^

Not sure I agree with shared name,  is shared the same as sharable?

> 	
> The names of those traits probably should be changed in Git.
> 
> Those traits are boolean in Mercurial, but I think we can implement
> what you would like to have to change them to tristate: 'deny' (unless
> forced, i.e. the same as true), 'warn', 'ignore' (i.e. the same as false).
> 
> I think that it would be nice to be able to tune "severity" of trait
> on per-remote and/or per-branch basis.  This way you would get warned
> before rewriting commits that were pushed to your group repository,
> and prevented from rewriting commits that are present in projects public
> repository.
> 
> Nevertheless I think it is something better left for later, and added
> only if it turns out to be really needed.

There was a good comment on this in the thread.
> 
>> local - The commits that are local only, no one else has a copy.
>> 	Commits your willing to share, but have not been yet shared,
>> 	either from actions of you, or a fetch from others. 
> 
> That's Mercurial's 'draft' phase.
> 
>> restricted or private - The commits that you do not want shared.
>> 	Manually added, think of a branch tip marked as restricted
>> 	automatically promotes commits to the branch as restricted. 
> 
> That's Mercurial 'secret' phase.


> 
> 
>> Maybe make these like nice levels, but as two components,
>> publicity 0-100 and rewritability 0-100 
>> 	Published is publicity 100 and rewritability 0
>> 	Restricted is publicity 0 and rewritability 100
>> 	Based publicity 75 and rewritability 25
>> 	Shared publicity 50 and rewritability 50
>> 	Local publicity 25 and rewritability 75
>> 	Restricted publicity 0 and rewritability 100
> 
> Continuous traits are IMHO a bad idea.  You would have to quantize them
> and turn them on into specific behavior: ignore, warn, deny.

Continuous vs enumerated vs boolean,  I'd like to see enumerated honestly.
I proposed continuous to get the idea out there.

> 
> For example WTF does 25 "publicity" (bad name) or "rewritability" actually
> means in term of git behavior, eh?

Yea, a set of flags is a better idea.

> 
>> Other option are flags stating if the commit is published, based,
>> shared, or restricted.  You could have a published and based commit
>> that is more opposed to rewrite than a public commit. 
>> 
>> Call security on a published restricted commit ;-)
> 
> Please note that while "phases" look like they are trait of individual
> commits, they are in fact artifact of revision walking.  The idea is
> that ancestors of 'private' commit can be 'private', 'draft' or 'public',
> that ancestors of 'draft' commit are 'draft' or 'public', and that _all_
> ancestors of 'public' commit are 'public'.
> 
>> Commits are by default local.
> 
> This 'by default' needs to be specified further, because for example
> all commits in freshly cloned repository should be in 'public' phase
> by default.  

New commits
> 
> Also, don't say 'commits are local', 'commits are published'; use "phases"
> nomenclature (at least until we invent something so much better that it
> is worth breaking consistency with Mercurial terminology).

Sorry, I didn't like their terminology for my expanded concept, that allowed co-devlopers to work on secret work together.

Pretend we are co-workers on super cool new feature.
If you and I are working on a project at work, I can share my secrets with you, but I can't push it to the public servers yet.

Another concept that is similar to secret is internal code.
Working on code that has public source and source that is for inside your company.
	Though this is more an attribute of a file.
	Warn about commits with internal files being pushed to an external repository. 

>> 
>> Commits are published when they are pushed or fetched and merged to
>> a publishing branch of a repository. 
> 
> BTW. I am not sure if pushing to remote repository updates (or can update)
> any remote-tracking branches...
> 
>> 	On fetch/merge a post merge hook should send back a note to
>> 	the remote repository that the commits were published. 
> 
> I think this is unnecessary in the "best practices" scenario, where each
> user has separate private repository where he/she does his/her work, and
> one's own public repository, where people fetch from.  He/she can push
> to some shared repository, and that has to be supported too.
> 
> Though there is mothership/ sattellite situation, where you can pull and
> push only from one direction.  There we might want for some way to notify
> that some commits were fetched and should now be considered 'public'.
> Though I am not sure if it is really necessary.

I don't work in the environment of the best practices.  I most often work with a central authoritative repo.

> 
>> Restricted commits/branches/tags should not be made public, error out and
>> require clearing of the attribute or a --force-restricted option that
>> automatically removes the restricted attribute.  They are at least promoted
>> to shared, if not published.   
> 
> Or just skip them (silently or not) if we push using globbing refspec, and
> glob matches some refs marked as 'private'.

Agreed,  explicit pushes were what I was referring to.
> 
>> Based is only used in situations where you have developers sharing amongst
>> their repositories, and you want a rule that is less restrictive than
>> no rewrites.  
> 
> Multiplying entities.
> 
>> Shared is what we have now when a commit is in a remote repository without
>> the no rewrite options. e.g. receive.denyNonFastForwards. 
> 
> Multiplying entities.
> 
> [...]
>>> Using the nomenclature from Mercurial 
>>>     public < draft < secret
>> 
>> public -> publicity 100, rewritability 0
>> draft -> publicity ?, rewritability 50
>> secret -> publicity 0, rewritability 100
> 
> That doesn't really help, at all.
> 
> -- 
> Jakub Narebski
> Poland
