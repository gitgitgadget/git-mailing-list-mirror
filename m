From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 22:54:29 +0200
Message-ID: <200809092254.30668.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Tue Sep 09 22:55:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdAFb-0005Y9-0s
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 22:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYIIUyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbYIIUyk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 16:54:40 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:50412 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbYIIUyj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 16:54:39 -0400
Received: by gxk9 with SMTP id 9so11815541gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=TqkeJMzL41oGzAXIMWcUhbYU+EZhT9hyxUwU6TaHFcY=;
        b=F/FHxh+TSwyni6cfpzGhDA4TY/mBTzjqbBTSjr1/CU1bJgJeTDV6VXOvrCPML26i97
         uei8N1sLOKNurZzBKuqGIAUbH53iJ/Bern7Jsg9EyPiD8EBF3SkpP8pBiGeSOlVyTX6I
         jmkIGtJSgvqstX/yO9NAFklA/qK2XYek3S/k4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fBACPrEg49J/tuVLHserT5BTyZz1GHxsnjiUkGKVtc5dz9PzHUFrPcJevPwBTOTPFd
         LycUcy8BkBUceUtIH3sIiY/+0hWwt07HondYVszar/ZFo8TmL+3z052vbA5qoSC0phyG
         LrNDpNAvN/ztomLezB4MMYOdVaPWaK3sy1t9o=
Received: by 10.86.65.11 with SMTP id n11mr259708fga.64.1220993674349;
        Tue, 09 Sep 2008 13:54:34 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.199.71])
        by mx.google.com with ESMTPS id 4sm7509851fge.8.2008.09.09.13.54.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 13:54:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080909194354.GA13634@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95430>

On Tue, 9 Sep 2008, Stephen R. van den Berg wrote:
> Jakub Narebski wrote:
>>"Stephen R. van den Berg" <srb@cuci.nl> writes:
>>>
>>> The definition of the origin field reads as follows:
[...] 
>>> - There can be an arbitrary number of origin fields per commit.
>>>   Typically there is going to be at most one origin field per commit.
>> 
>> I understand that multiple origin fields occur if you do a squash
>> merge, or if you cherry-pick multiple commits into single commit.
[...]
>> I'm not sure if you plan to automatically add 'origin' field for
>> rebase, and for interactive rebase...
> 
> That is not part of the plan so far.
> Can you explain what you would be expecting in the best case?

After thinking about this a bit, I don't think that (recording
origin(al) commits) for rebased commits would be good idea.  While one
can reasonably expect that cherry-picked changes should stay, and
reverted changes even more so (usually one reverts commit from
a history), usually the original commits being rebased are meant
to be pruned; the are rebased.

>>> - At the time of creation, the origin field contains a hash B which refers
>>>   to a reachable commit pair (B, B~1).  If B has multiple parents and the pair
>>>   being referred to needs to be e.g. (B, B~2), then the hash is followed by
>>>   a space and followed by an integer (base10, two in this case),
>>>   which designates the proper parentnr of B (see: mainline in git
>>>   cherry-pick/revert).
[...]
>> Besides I very much prefer using 'origin <sha1> <sha2>' (as proposed
>> in the neighbouring subthread), which would mean together with
>> 'parent <parent>' (assuming that there are no other parents; if they
>> are it gets even more complicated), that the following is true
>> 
>>  <current> ~= <parent> + (<sha2> - <sha1>),
> 
>> where '<rev1> ~= <rev2>' means that <rev1> is based on <rev2> (perhaps
>> with some fixups, corrections or the like).  Perhaps 'origin' should
>> be then called 'changeset'.
> 
> The simplicity sounds inviting.  I'd like to hear from others who have
> more experience (than I have) with the git vs. changeset paradigms about
> this.  This allows a bit more flexibility in specifying the origin, the
> question is if it's needed.

It is the simplicity that it is the most compelling of this solution.
For revert we have "origin B B^", for cherry-pick we have "origin A^ A";
(or 'changeset') and always we have <rev> =~ <rev>^ + (<r2> - <r1>),
where '-' denote diff operation (<diff> = <tree1> - <tree2>), and '+'
denote patch application (<tree1> = <tree2> + <diff>).


[ADDED LATER]
Also it could be useful for patch management interfaces using Git
as engine, such as StGIT, Guilt (formerly gq), TopGit, or now defunct,
obsoleted and no longer maintained Patchy Git aka 'pg'.

The "weak" 'origin'/'changeset' header would allow some sort of
operating on patches instead of usual operating on tree states.

>> It would also be easier on implementation to check if
>> 'origin'/'changeset' weak links are not broken, and to get to know
>> which commits are to be protected against pruning than your proposal
>> of
>>
>>   origin <"cousin" id> [<mainline = parent number>]
>>
>> where <mainline> can be omitted if it is 1 (the default).
> 
> On the contrary, my current proposal only needs to verify the validity
> of a single commit, changing it like this will require the system to
> verify the validity of two commits.  Given the rareness of the origin
> links this will hardly present a problem, but it *does* increase
> the overhead in checking a bit.

Errr... wasn't you proposing to keep/protect against pruning <cousin>
AND <cousin>^<mainline>? You want to have _diff_ (changeset) protected,
not a single tree state.

And having "origin <r1> <r2>" makes it easier then to check validity; you
don't need to get <r1>, check if it has <mainline> parent and what it is,
and then check if <r1>^<mainline> exists (and is not for example behind
shallow clone barrier).

>>> - git cherry-pick/revert allow for the creation of origin links only if
>>>   the object they are referring to is presently reachable.
> 
>> Errr... shouldn't objects referenced by 'origin' links be reachable in
>> order for "cherry-pick" or "revert" to succeed?
> 
> True.  But sometimes it's necessary to emphasize the obvious; call it a
> preemptive strike against possible objections to the proposal.

I don't think that it is true in this case.  This sentence _looks_ like
it offers / requires additional protection, while this "protection" is
already ensured by the fact of cherry-picking or reverting a commit.

>> On the other hand this leads to the following question: what happens
>> if you cherry-pick or revert a commit which has its own 'origin'
>> links?
> 
> Nothing special.  cherry-pick/revert behave as if the existing origin links
> were not present in the first place.

O.K.

>>> - git rev-list --topo-order will take origin links into account to
>>>   ensure proper ordering.
>> 
>> What do you mean by that?
> 
> The order in which commits are listed is defined by the fact that
> descendent commits are shown before any of their parents.  The presence
> of an origin link will make sure that the current commit will always
> appear *before* the origin-commit it is referring to (if the
> origin-commit is in the displayed set, that is).

Hmmm... while I think it might be a good idea, I'm not sure about its
overhead. Should be much, I guess.
 
>>> - git log would show something like: [...]
>>> - git log --graph will show a dotted line of somesort just like gitk.
>> 
>> That is I guess the whole and main reason for 'origin' links to exist,
>> as having this information in free-form part, i.e. in the commit
>> message might lead to problems (with parsing and extracting, and
>> finding spurious links).
> 
> Quite.  Also, having them in a well-defined place will allow for easy
> fixups in case of rebase/filter-branch.

True.

>>> - git blame will follow and use the origin link if the object exists.
>> 
>> Hmmmm... I'm not sure about that.
> 
> Care to explain your doubts?
> The reason I want this behaviour, is because it's all about tracking
> content, and that part of the content happens to come from somewhere
> else, and therefore blame should look there to "dig deeper" into it.

But blame is all about what commit brought some line to currents version.
So the cherry-pick itself, or revert of a commit itself would be blamed,
and should be blamed, not its parents, nor commit which got cherry-picked,
or commit which got reversed.

It would be nice to be able to follow 'origin'/'changeset' lines in the
_graphical_ blame browser like blameview or "git gui blame".

-- 
Jakub Narebski
Poland
