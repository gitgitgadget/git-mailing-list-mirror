From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 17:33:23 -0700
Message-ID: <xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 02:33:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKFJN-0007zJ-37
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 02:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbbG2Ad3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 20:33:29 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33585 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbG2Ad1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 20:33:27 -0400
Received: by pdbnt7 with SMTP id nt7so78944830pdb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vTIXiI6RAbQCvF5oc2yVkuozmFu69NSzxpnBeDpkLz4=;
        b=t7wZfR+Z1eveRuV78X2q5e6szSVe/T9QSxkPoYTy+TVfLv4B75FGduwpTTlkFO3sMY
         zlujo79bOGqB6nrQRjmJi4GxO2z6qIkD0WKMzTWpPeAB0GeADfdv0pXUttof/xT5WbS4
         svdvkFu3kTk4KnIU2CP3rUSjUN6flTLAuD7HofU0UpY3DFPa4lg50/mdvqEpQXv6tUWp
         TmPUBavZjLujmwna4jLbfZjRKyW52TCr4Rg6Tmmdcn8G9ETYkiBiZJWnzGWxI77rPz6O
         uN03OnssRwYsw77PEFRmAr/kXEgwMzT9KsQkJqtck8cwh2ejde3V2WQuDa35mYa7ZgYU
         /P5g==
X-Received: by 10.70.33.67 with SMTP id p3mr87070265pdi.126.1438130006688;
        Tue, 28 Jul 2015 17:33:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id kk6sm37227101pdb.94.2015.07.28.17.33.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 17:33:24 -0700 (PDT)
In-Reply-To: <CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com>
	(Johan Herland's message of "Wed, 29 Jul 2015 01:43:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274868>

Johan Herland <johan@herland.net> writes:

> Here is where we start to differ. I would say that starting a notes
> merge is completely unrelated to your worktree. Consider this:
> ...
> This is not the case for notes merges. If I start a notes merge from
> worktree A, there is no "occupation" of that worktree. Before the
> notes merge is resolved, I can do whatever I want in worktree A
> (including checking out a different branch, performing a rebase,
> whatever...). Instead, the notes merge creates its own worktree (that
> is "occupied" until the notes merge is completed), which is completely
> unrelated to worktree A.

That does not mean the notes merge that you started when you were
sitting in worktree A has to be shared with worktree B, by say doing
"vi .git/NOTES_MERGE_WORKTREE/$commit && git notes merge --commit".

Also the above does not explain why it is sensible for you to forbid
worktree B from doing an unrelated notes merge of a different ref
under refs/notes/* while your worktree A is doing a notes merge.

> In principle, I agree that an ongoing notes-merge into
> refs/notes/someotherthing should be able to coexist with an ongoing
> notes-merge into refs/notes/commits. However, it does not make sense
> to bind those notes-merges to a specific worktree.

The thing is, the choice is between per worktree or per repository.
Taking the latter would mean you can only be doing one notes merge
at a time, even though you prepared multiple worktrees so that you
can work on different things at a time.  It is true that there is
nothing inherent that ties a note merge to a worktree (a worktree is
tied to a branch that is checed out, and there is no tie between a
branch and a notes tree), but "not inherantly tied to" does not
automatically mean "has to be one per repository".  You'd ideally
want to allow N workspaces for N refs/notes/* refs.

But people work in worktrees, and that is their unit of working
space.  From that point of view, unless you are proposing a
completely different design where the primary worktree can be used
only for manipulating notes (hence, you can have worktrees for
resolving refs/notes/A and refs/notes/B, in addition to the other
worktrees you use to advance branches), treating NOTES_MERGE_REF as
a per-worktree entity just like HEAD and the index is, would be the
most sensible comporise.

> Let's say I have two worktrees, A and B, and from worktree A, I have
> started a notes-merge into refs/notes/commits. Now:
>
>  - From worktree B I should NOT be able to start another notes-merge
> into refs/notes/commits.

Correct.

>  - From worktree B I SHOULD be able to start another notes-merge into
> refs/notes/someotherthing

Correct.

> But this doesn't really have anything to do with worktree B. 

Correct. There is nothing inherent that ties someotherthing to B and
commits to A.  The only reason why I think "per worktree" is vastly
superiour than "only one per repository" is because the end user did
set up two worktrees so that he can do two things at once
independently.

> I can
> just as easily say:
>
>  - From worktree A I should NOT be able to start another notes-merge
> into refs/notes/commits.

Correct.

>  - From worktree A I SHOULD be able to start another notes-merge into
> refs/notes/someotherthing

Irrelevant and moving the goalpost.  We are not talking about
extending capability of the system that does not use multi-worktree.
We do not do two regular merges in a single worktree at a time, and
I do not think it is sensible to claim "I SHOULD be able to".

> Now, we do not yet support simultaneous notes merges at all, but my
> follow-on point is that the addition of such support is wholly
> independent of the multi-worktree support.

Now we are getting somewhere.  So is there more that is needed than
separating NOTES_MERGE_REF per worktree to make this work (remember,
multiple notes-merge in a single worktree is a non-goal, just like
multiple merge in a single worktree is not supported today and will
not be)?  Is there some other state that is not captured by
NOTES_MERGE_REF and friends that you would end up recording a wrong
merge result, if two worktrees that have NOTES_MERGE_REF pointing at
a different ref in refs/notes/* try to do the notes-merge at the
same time?

> For now, it would make more
> sense to only allow a single notes-merge across all worktrees. I.e.
> when starting a notes-merge from ANY worktree, it should simply fail
> if there is an existing unresolved notes merge (no matter which
> worktree started that unresolved notes merge).

I do not understand why we need to have such a restriction.  It is
like saying you may have two worktrees but you cannot merge into
master in worktree A if you are doing a merge into next in worktree
B.  I'd need a clear answer to the question in the previous
paragraph to say something like "ah, ok, that limitation (either
imposed by the current code design, or perhaps reliance of the
filesystem, or whatever) I didn't think about, and now what you say
makes sense to me".

> Disagree. The private area used to resolve notes merges should be per
> _repo_, not per worktree.

I can buy "the private area for resolving refs/notes/common must be
a single place per repo that is differnet from the private area used
for refs/notes/somethingelse, which would also have its own single
place per repo".

But then what you are talkinng about is per _ref_, not per _repo_.

And I'd very much love to see this per _ref_; that is fantastic.

Because the suggestion is to allow a single notes ref refs/notes/*
to be "checked out" only in a single worktree at a time, that per
_ref_ thing falls out naturally from per _worktree_ arrangement.

And that is how people work, by creating a separate worktree, they
gain one additional workspace.
