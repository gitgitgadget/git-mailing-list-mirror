From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 10:59:12 +0100
Message-ID: <201102141059.12962.jnareb@gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <7vfwrrukzq.fsf@alter.siamese.dyndns.org> <201102141018.46527.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 14 10:59:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PovDN-0005nu-QG
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 10:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab1BNJ7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 04:59:25 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:58057 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1BNJ7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 04:59:24 -0500
Received: by yib18 with SMTP id 18so1969393yib.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 01:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=AdqdQzvfkDUw/iGblA669mzJZuPxzyGnNqo7at9dLug=;
        b=b5dGR6ffgZ8/lEdJ+zhjYYZQyeqA1Z7I4x7Z33bAURw+l8YFemGfKSy3YeBEE7TyYr
         bMi6v2qTS/gIE8XKFtU1BIdAsYQGDftIb/NifM/qIhGFjlet11uiYpMxLCLlS3kZkUL6
         u/udt72WkOtfeCy26jQeysslhL5flXoiVH7mE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XWsGzKB5JgG7iMuBXuPXvf7mQGYlA6gIVS/SHWavLuVuF22voXWJgbrOcTBZSYFIVa
         H3R03lO2zKhFz99yIbZJGX++RbKUusAjmutJTR0lDezX+pkXXyabdsBZT85l8RrYShhx
         7y9JNvX4okJem4UVrl/uNnrc15mNdYK6xRaz4=
Received: by 10.236.105.244 with SMTP id k80mr818962yhg.60.1297677563293;
        Mon, 14 Feb 2011 01:59:23 -0800 (PST)
Received: from [192.168.1.13] (abvr76.neoplus.adsl.tpnet.pl [83.8.215.76])
        by mx.google.com with ESMTPS id f31sm1445692yhc.13.2011.02.14.01.59.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 01:59:22 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201102141018.46527.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166701>

On Mon, 14 Feb 2011, Johan Herland wrote:
> On Monday 14 February 2011, Junio C Hamano wrote:
>> Johan Herland <johan@herland.net> writes:

>>> Yes, replicating existing behavior w/explicit refspecs would look like: 
>>>   [remote "origin"]
>>>   
>>>         url = git://git.example.com/repo.git
>>>         fetch = +HEAD:refs/remotes/origin/HEAD

Perhaps

              setHead = master

or something like that?

>>>         fetch = +refs/heads/*:refs/remotes/origin/*
>>>         fetch = ~refs/tags/*:refs/tags/*
>> 
>> While this is fine, I am not sure about the "HEAD" part.  Most of the
>> protocol do not convey which branch HEAD points at (instead "clone" has
>> to guess), which eventually needs to be fixed.

Right.

>> Incremental updates via 
>> "fetch" does not touch "HEAD" at all by design; unlike the real branch
>> heads "remotes/origin/$branch" that are used to keep copies of what are
>> at the remote, "remotes/origin/HEAD" is meant to be used by the local
>> repository to designate which of the remote branch is considered the
>> primary branch from local repository owner's point of view, primarily so
>> that you can say "origin" locally to mean "origin/next" by setting the
>> symref origin/HEAD to point at it.  In that sense, the guess made by
>> "clone" is only used to give an initial value.

Well, we have "git remote set-branch <remote> -a" to re-do this guessing
or checking, and update 'remotes/origin/HEAD'...

> 
> Ah, ok. I've misunderstood the purpose of "remotes/origin/HEAD" then. Feel 
> free to remove that refspec line from my proposal, and leave it as a 
> special-purpose thing set up by clone (and maintained by the user 
> thereafter).

See above for my `remote.<remote>.setHead` proposal.

> Still (as I think was recently discussed in another thread), the existence 
> of remotes/origin/HEAD _does_ cause problems if the origin remote also has a 
> branch called "refs/heads/HEAD" (which would collide when fetched into the 
> local repo).

True, though... can't we consider having branch named 'HEAD' as insane?

> 
>>> FTR, my new/proposed refspecs would look like this:
>>>   [remote "origin"]
>>>   
>>>         url = git://git.example.com/repo.git
>>>         fetch = +HEAD:refs/remotes/origin/HEAD
>>>         fetch = +refs/heads/*:refs/remotes/origin/heads*
>>>         fetch = ~+refs/tags/*:refs/remotes/origin/tags/*
>>>       
>>>       ( fetch = +refs/notes/*:refs/remotes/origin/notes/* )
>>>       ( fetch = +refs/replace/*:refs/remotes/origin/replace/* )
>> 
>> I think you meant "refs/remotes/origin/heads/*" (note the slash) on the
>> RHS of the branch refspecs.
> 
> Indeed. Thanks for pointing out the typo.
> 
>> How's that different from refs/*:refs/remotes/origin/* by the way?
> 
> It's not, except that "refs/*:refs/remotes/origin/*" would fetch a too-large 
> superset. E.g. it would fetch "refs/remotes/third-party/heads/foo" into 
> "refs/remotes/origin/remotes/third-party/heads/foo", which we probably don't 
> want.

Note that it is not given that notes and replaces should be per-remote
like remote-tracking branches, and not autofollowed like tags.

>> Also
>> if you give tags a totally separate namespace, I don't see much reason to
>> still give it the "auto-follow" semantics.  It is far simpler to explain
>> if you just fetch all of them and be done with it, no?
> 
> Agreed. Also, to quote Peff in http://thread.gmane.org/gmane.comp.version-
> control.git/160503/focus=160726 :
> 
> "Now you could argue that auto-follow is not worth the effort. It is
> somewhat confusing, and I can't think of a time when it ever actually
> reduced the set of objects I was fetching (as opposed to just fetching
> all tags). But maybe others have use cases where it matters."
> 
> So if nobody disagree, I would have no problem with dropping the leading "~" 
> from the refspec, thus disabling auto-following (tracking all tags 
> explicitly instead).

Well, to make use of somewhat contrived example: with current auto-follow
fetching of tags, when somebody tracks e.g. only 'maint' branch, he/she
wouldn't get "*-rcN" tags he/she is not interested in.

Worth preserving?

[...] 
> I don't doubt that the current behavior works well for you (otherwise I 
> expect you would have changed it). However, what I've seen at $dayjob is 
> that more inexperienced users will often push right after committing, and at 
> that time they're still very much in the "working-on-one-branch" state of 
> mind (as opposed to the "administering-multiple-branches" state of mind), so 
> when they follow up a "git commit" with a "git push" they're surprised (or 
> worse: oblivious) to the fact that "git push" can push multiple branches.
> 
> I guess it comes down to whether you fundamentally consider "git push" 
> something that pushes multiple _branches_, or something that pushes multiple 
> _commits_. And for the latter of those groups push.default == "matching" is 
> inherently more "dangerous" than for the former. (Granted, me telling 
> everyone to use push.default == "tracking" probably doesn't help them in 
> discovering "git push"'s ability to update multiple branches.)

Another solution is to tech them "topic branch" workflow, i.e. to do new
work on new feature branch, and only when it is ready merge it into one
of published branches (i.e. those that have matching branch in remote 
repository they push to).

-- 
Jakub Narebski
Poland
