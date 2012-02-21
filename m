From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] pre-rebase: Refuse to rewrite commits that are reachable
 from upstream
Date: Wed, 22 Feb 2012 00:23:20 +0100
Message-ID: <CALKQrgfLBKG5ssL8ua_EtfyQeOp0h9HPC7vdOM_Yc_AVaa39xw@mail.gmail.com>
References: <201202111445.33260.jnareb@gmail.com>
	<1329772071-11301-1-git-send-email-johan@herland.net>
	<7vobstjfcs.fsf@alter.siamese.dyndns.org>
	<CALKQrgcDDVH8rxn80ZTMyR3y3n3Vs1LSCtH=ZiwG7it_LE2wgQ@mail.gmail.com>
	<7vehtoiqae.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com, philipoakley@iee.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 00:23:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzz3V-0003UQ-2i
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 00:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756241Ab2BUXX1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 18:23:27 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:52042 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756286Ab2BUXX0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 18:23:26 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Rzz3M-0004Nf-9C
	for git@vger.kernel.org; Wed, 22 Feb 2012 00:23:24 +0100
Received: by iacb35 with SMTP id b35so9525493iac.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 15:23:20 -0800 (PST)
Received-SPF: pass (google.com: domain of johan@herland.net designates 10.50.236.34 as permitted sender) client-ip=10.50.236.34;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of johan@herland.net designates 10.50.236.34 as permitted sender) smtp.mail=johan@herland.net
Received: from mr.google.com ([10.50.236.34])
        by 10.50.236.34 with SMTP id ur2mr23290457igc.20.1329866600984 (num_hops = 1);
        Tue, 21 Feb 2012 15:23:20 -0800 (PST)
Received: by 10.50.236.34 with SMTP id ur2mr18807382igc.20.1329866600962; Tue,
 21 Feb 2012 15:23:20 -0800 (PST)
Received: by 10.42.170.3 with HTTP; Tue, 21 Feb 2012 15:23:20 -0800 (PST)
In-Reply-To: <7vehtoiqae.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191197>

On Tue, Feb 21, 2012 at 08:44, Junio C Hamano <gitster@pobox.com> wrote=
:
> Johan Herland <johan@herland.net> writes:
>
>> What =C2=A0you are describing here may be a common workflow, but
>> "rebase.bottomLimit" is still very specific to that kind of workflow=
=2E
>> What I'm after is a much more workflow-agnostic concept of:
>>
>> =C2=A0 "If I have pushed something, I should probably not rebase it"
>
> Your "this branch pushes directly to that remote branch, so I can che=
ck if
> it will result in rewrite of published commit" is even *less* generic=
 than
> having a single bottomLimit in my illustration.
>
> I may not push out my topic branches directly, only the aggregate of =
them
> in 'next', but once 'next' is pushed out, they are not eligible for
> rebasing. =C2=A0A per-branch bottom, e.g. rebase.$branch.bottomLimit,=
 might
> make it more flexible to cover such a case, though.

But you would have to maintain rebase.$branch.bottomLimit separately
for each topic branch, updating it whenever the topic branch is merged
to 'next'. Is that practical?

> On the other hand, without any such safety, a merge to 'next' would g=
ive
> many conflicts and "shortlog master..next" will show many duplicates =
after
> any topic that are already merged to it are accidentally rewritten, a=
nd it
> is just the matter of using reflog on topic branches to recover from =
such
> a mistake.

All true, but my experience is that novice users will not enjoy this
experience, and rather become frustrated with Git for "putting them in
this situation" (i.e. giving them more rope than they can handle).
Maybe I'm doing something wrong...

>>> I wonder if it would be a more direct solution to the issue you are
>>> raising to give them a good tool to help them to be more careful wi=
th less
>>> effort on their part before they publish (not before they rebase).
>>
>> ..., I'm not sure how we can help the user _not_ publish the
>> branch until it's ready.
>
> I think we are in agreement that we do not think of a good solution
> offhand to the real cause of the issue, except by encouraging the use=
 of
> throw-away review branches, perhaps.

Agreed. We should probably focus more on this when teaching novice user=
s.

>> I think the following decribes what often happens for many users:
>>
>> =C2=A01. User A pushes the branch to a public repo.
>> =C2=A02. User B points out a simple mistake in the branch.
>
> That's the CVS workflow, and it is not "a" public repo but "the" publ=
ic
> repo shared between A and B (and also with all the project participan=
ts).
>
>> =C2=A03. User A makes a fix
>> =C2=A04. User A squashes the fix into the (already-published) histor=
y.
>> =C2=A05. User A attempts to push the "fixed" history (but is rejecte=
d by
>> the public repo because of non-fast-forward).
>> At this point, the damage is already done,...
>
> Which is probably a sufficient safety which the user can learn from. =
=C2=A0If
> this happens too often, that probably means we are not helping them e=
nough
> to learn not to "commit --amend" or "rebase" if they are using Git as=
 a
> better CVS.
>
>> You could say that User A should be more careful and push to a "less
>> public" repo in step #1 (thus allowing the fix to be squashed before
>> pushing to a "more public" repo in step #5),...
>
> That is essentially a workflow that uses throw-away review branches i=
n a
> distributed environment, and at that point, we are not constrained by=
 the
> limitation of the CVS workflow. While still in early review cycles (w=
hich
> corresponds to being in our 'pu'), "commit --amend" and "rebase" are =
fine
> tool to be used. =C2=A0And...
>
>> but how "public" is
>> "public" enough to have someone point out the bug, but still
>> "unpublic" enough to allow rebase?
>
> ... I can imagine that currently that is determined purely by project
> convention. Perhaps there needs a way to mark throw-away review branc=
hes
> like 'pu' (or saying the same thing from the different perspective, t=
o
> mark cast-in-stone integration branches like 'next') so that tools ca=
n
> mechanically decide what should and should not be rewritten.

Yes. Maybe it should be a tri-state thing:

  - "rebase-prone" will allow rewrites without asking.

  - unset will warn, but still allow rewrites. The warning should
explain the potential problem that may arise from rewriting, and
should also explain how to get rid of the warning by setting this
config to either of the above/below options. Ideally the warning
should also explain how the user may undo the rewrite. Obviously, most
of this warning should be controlled by a corresponding advice.*
config.

  - "cast-in-stone" will refuse rewrites.

I notice that this config is not really per-branch, but rather per
upstream branch. I wonder how to best encode that in the config...
Also, how a remote repo may best communicate which branches are
"rebase-prone"/"cast-in-stone".

> To extend the idea of promoting throw-away review branches further,
> perhaps it might help if there is an easy way to let the users publis=
h
> their "master" to a branch that is not the "master" of the central sh=
ared
> repository even in the CVS workflow (e.g. by default a push from user=
 A
> always goes to refs/review/A/master), and to have an option to "git p=
ush"
> that makes it go to the "master" when the user really means the branc=
h is
> ready (and it would move refs/review/A/master to attic to be later gc=
'ed).

This goes against many workflows, and many users' expectations.
Although it may be a Good(tm) practice, I don't think it's universal
enough to be worth "breaking" 'push'. What about adding a new 'git
review' command which defaults to this behavior (but can be overridden
by Gerrit and other code-review systems to do what's appropriate in
their cases)?

>> ... And I
>> think that refusing rewrites of commits that are already present in
>> the @{upstream} remote-tracking branch is good enough to help most
>> users avoid steps #4 through #6 (in a push-based workflow[1]).
>
> See above regarding branches that should not be rebased even if they =
are
> not directly pushed out.

True. Is it universally acceptable to assume that a topic branch that
has been merged to a "cast-in-stone" branch, should not be
rebased/rewritten (unless forced by the user)?

There are several aspects to this: First, any commits on the topic
branch that have been made _since_ the merge should obviously be
rewritable (since they have yet to be merged). And commits made
_before_ the merge should probably not be rewritable. I.e. in the
following figure, the 'y' commits should be rewritable, but the 'x'
commits (preceding the merge 'M') should probably not.

 --o---o---o---o---o---o---M  <- master (cast-in-stone)
    \                     /
     x---x---x---x---x---x---y---y <- topicA

But what if we have two topic branches with shared history, like this:

 --o---o---o---o---o---o---M  <- master (cast-in-stone)
    \                     /
     x---x---x---x---x---x---y---y <- topicA
                              \
                               z---z <- topicB

We cannot say whether the 'x' commits "belong" to topicA or topicB.
Also, we cannot determine whether the merge M happened with topicA or
topicB (unless the default merge message has been preserved). Now,
given that we try to rewrite the entire topicB branch (including the
'x' commits): Should we refuse rewriting the 'x' commits because they
are reachable from master (regardless of whether topicA or topicB was
merged), or should we allow rewriting the 'x' commits on the basis
that topicA may be the branch that was merged in 'M', and since topicB
are "unaware" that the 'x' commits have been merged, it should thus be
allowed to rewrite them?

Now, what if you want to backport 'topicA' from 'master' to 'maint'.
You could do so like this:

  git checkout -b topicA_maint topicA
  git rebase --onto maint master

(note that topicA_maint is a special case of topicB in the above
graph) In this case, we would expect the 'x' commits to be rewritable,
or we could not perform the backport.

The conclusion seems to be that we _cannot_ refuse rewriting commits
merely on the basis that they have been merged to a cast-in-stone
branch.

>> In
>> fact, from a pedagogical POV, I think step #4 is probably the best
>> spot for novice users to learn exactly the distinction between
>> acceptable and unacceptable history rewrites (instead of having it
>> explained to them as a consequence of the step #5).
>
> I doubt you have enough information at point #4, unless you restrict =
the
> workflow you allow your novice users to use fairly severely, to give
> appropriate advice. =C2=A0While I agree with you that it would be the=
 best if
> we could do so at step #4 without stopping the user from doing what s=
/he
> needs to do with false positive, I think it is not pedagogical POV bu=
t
> dreaming if the world were ideal without knowing what it would take t=
o
> make it ideal.
>
> At least I don't know offhand what kind of changes are needed to rest=
rict
> the user actions to an "approved" workflow so that step #4 can make a
> useful decision (that is, no false positives and small enough false
> negatives).

Ok, trying to make as few assumptions about user workflows as
possible: Assuming there were a (machine-parsable) way to mark
branches as either "rebase-prone" or "cast-in-stone". Could we then
assume that rebasing commits that exist on a cast-in-stone branch's
remote-tracking @{upstream} should be refused by default? I'm trying
(without much success, it seems) to find _something_ that will help
the 1525 users that want Git to "warn before/when rewriting published
history"[1], but won't cause any false positives (and small enough
false negatives). If there really is no way to implement this, then we
shouldn't give users false hopes by putting it in the survey...


Have fun! :)

=2E..Johan


[1]: Question 17 in https://www.survs.com/results/Q5CA9SKQ/P7DE07F0PL

--
Johan Herland, <johan@herland.net>
www.herland.net
