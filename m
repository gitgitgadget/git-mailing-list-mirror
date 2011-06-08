From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Tue, 7 Jun 2011 23:07:16 -0400
Message-ID: <BANLkTinT41oU=CVnGkmkeXk5u5=KnWjmDA@mail.gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net>
	<7vvcwh4ako.fsf@alter.siamese.dyndns.org>
	<20110607214532.GB7663@sigill.intra.peff.net>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 05:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU977-0006pj-6q
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 05:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646Ab1FHDHT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 23:07:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58067 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab1FHDHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 23:07:17 -0400
Received: by bwz15 with SMTP id 15so68279bwz.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 20:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sT85WUUAZ1kQwHNPSpN78gAIBSXRga73n4T5CqBt0H0=;
        b=pOewlXulouWs3fmYRD6Dj/+sF4f8Lq/rq3a9kRU81JbNyL3RhZLciHqRb4JuRnhcdr
         zvWufiONH44BAAdqYrwBogtbYdZzRVGpSUUn/vOyxdMX/2FIWTUnNq/yRliJQkvHRpjw
         AiaFVtOpTRhUTrJlbWHYR1bLKcEzZbOdZH3FQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=oeHzgaUt1SnnFNzuwIjel0z14P0Ca7K/cyjBwYhZd4Xp5GKARhKR1M2rxHg20zkN1X
         TL1vWrduq98oJNZMa4EPguEEtV5RCAqhhAD8i78MPVwbScW+74wHC2NP6bYjl+COzkyT
         WJAqCqNiSgONx8zoHg52WINIwiCPrjDl74wEI=
Received: by 10.204.14.144 with SMTP id g16mr322649bka.34.1307502436203; Tue,
 07 Jun 2011 20:07:16 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Tue, 7 Jun 2011 20:07:16 -0700 (PDT)
In-Reply-To: <20110607214532.GB7663@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175293>

Junio wrote:
>The only worry about confusion is if people incorrectly think these ma=
gic
>tokens are not mere syntax sugars available only in "put", especially,
>they look so similar to "HEAD" which is _not_ syntax sugar and can be =
used
>elsewhere. Other than that, I think this is a nice approach.

I don't think they are syntactic sugar.

The working tree is a tree.  HEAD is a tree.  HEAD is also a commit
and a file in .git/, so it is more than a tree, but it's a tree.  NEXT
is a tree.   There may be different code to read (or write) each of
them, but they are all trees.  So I don't see these labels as
syntactic sugar -- making a commonly used piece of code easier to use
(like ++) -- but as presenting a common interface to a concept that
may have different implementations.

I think this "git put" command let's people think in terms of trees.
Commits are read-only trees.  NEXT and WTREE are tree that can be
written to.  It's up for debate if stashes are read-only or writeable.

To me "git put" is just the UNIX "cp" command, just that files or
directories can be prefixed by tree names.  In fact, I'd make sure the
"-r" option was used when copying whole trees or subtrees. :)

git put -r HEAD WTREE
git put HEAD:foo.txt WTREE:foo.txt

I would keep it like "cp" and drop the support for copying to multiple
trees (like HEAD and INDEX) in a single command.  I would have a good
form for copying multiple files from one tree to another.  E.g., "git
put HEAD:{foo.txt,bar.txt} WTREE" or "git put HEAD WTREE foo.txt
bar.txt" or "git put HEAD:*.txt WTREE" even.

I do not think "COMMIT" or "AMEND" should be part of the command.

"git put" could replace "git add", "git checkout -- <file>", and "git
reset -- <file>".  It would not replace the other common file
manipulators: "git rm" and "git mv".

Damn, I'm tempted to say screw "git put" and call it "git cp".  Then
change "git rm" and "git mv" to support writeable trees and you've got
yourself a very easy to learn interface!


Jeff wrote:
> The issue is that
> you generally _don't_ put items straight from a commit to the
> worktree and vice versa. They go through the index.

Going through the index is only the right move if you're going backward=
s.

HEAD is the most recent commit.  NEXT should be what you already know
will go in the next commit.  WTREE is stuff that may go into NEXT or
into another future commit or may never go in at all.   So, HEAD and
all previous commits are the past; NEXT is the near future; and WTREE
is the far future.

If you are reverting a mistake, you are copying from HEAD or some
other ancestor to NEXT and WTREE.  Especially if you're copying from
HEAD, you want to include the target NEXT, since you know that that
code will almost assuredly work and be part of the next commit.  In
fact, the opposite of "git add" (the awkward "git checkout -- <file>")
is to copy a file from HEAD to NEXT --- essentially pushing off the
change from NEXT to some future commit.

In every other case, you want new stuff to go into WTREE and skip the
NEXT.  The way I view merge is that the new files are copied from
another branch into WTREE.  All resolved changes are then moved into
NEXT.  If there are no unresolved changed, a new commit is made.
While this may not be the actual sequence of events that Git performs,
it's how I see the operation - new changes are introduced at WTREE,
correct changes are moved into NEXT, and the commit operation makes
them permanent.





On Tue, Jun 7, 2011 at 5:45 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 07, 2011 at 02:04:55PM -0700, Junio C Hamano wrote:
>
>> > As you can see, this handles only three typoes of locations: the
>> Is that a recursive typo, or a typo of type?
>
> It's art; the viewer is free to interpret based on their own
> experiences.
>
>> > Some other types I've thought of are:
>> >
>> > =A0 - stashes; you can already use stashes a source with "stash@{0=
}". They
>> > =A0 =A0 could also be a destination, chaining to "git stash".
>>
>> No opinion on this.
>
> My initial prototype was going to have stash as a fourth location. Bu=
t I
> backed out a little because it was complex, and the more I think abou=
t
> it, I'm not sure it's really appropriate. You can already pull _from_=
 a
> stash by naming its commit. And putting into a stash is a bit differe=
nt
> than a put, because it handles both the index and the worktree, and
> removes the changes from them afterwards.
>
> So I think a better match is the idea of "git put" to a new commit on=
 a
> named branch that I showed elsewhere. And then you can "git put" off =
of
> it later.
>
>> > =A0 - branches as destinations; obviously we can't change an exist=
ing
>> > =A0 =A0 commit, but what about something like:
>> >
>> > =A0 =A0 =A0 git put WORKTREE BRANCH:foo
>> >
>> > =A0 =A0 to optionally create a new branch "refs/heads/foo" based o=
n the
>> > =A0 =A0 current HEAD, push changes into a temporary index that mat=
ches its
>> > =A0 =A0 tip, and then making a new commit based on top.
>>
>> Should "git put WORKTREE HEAD" be equivalent to "git commit -A" then=
?
>
> I'm tempted to say yes, with two reservations:
>
> =A01. Making a new commit (or even a new branch) somehow seems more
> =A0 =A0 heavyweight to me than just picking changes. So I'm reluctant=
 to do
> =A0 =A0 it for just "git put $from HEAD"; maybe there should be a spe=
cial
> =A0 =A0 token that says "yeah, make a new commit". Like:
>
> =A0 =A0 =A0 git put WORKTREE COMMIT:HEAD
>
> =A0 =A0 to commit on top of HEAD, or even
>
> =A0 =A0 =A0 git put WORKTREE AMEND:HEAD
>
> =A0 =A0 to amend HEAD (this would be useful when building up a commit
> =A0 =A0 piece by piece using "git put").
>
> =A0 =A0 But that is getting very magical. I have a vague feeling you =
could
> =A0 =A0 actually reimplement a lot of the user-facing portions of git=
 in
> =A0 =A0 terms of these "put" operations. For example, forget the inde=
x as a
> =A0 =A0 whole and have "NEXT", "BASE", "OURS", and "THEIRS" represent=
ing
> =A0 =A0 trees of the various stages.
>
> =A0 =A0 I'm not sure if that's just insane, though. That _isn't_ how =
the
> =A0 =A0 index actually works (e.g., resolved paths would have only a =
NEXT
> =A0 =A0 entry, so the other trees would actually be partial trees). S=
o
> =A0 =A0 we're making an abstraction over it, and when that abstractio=
n
> =A0 =A0 leaks, I fear things will get very confusing for the user.
>
> =A02. There is a slight incompatibility between the "git put" mental
> =A0 =A0 model and what really happens. I already ran into it once wit=
h "git
> =A0 =A0 put HEAD WORKTREE", and it appears here again. The issue is t=
hat
> =A0 =A0 you generally _don't_ put items straight from a commit to the
> =A0 =A0 worktree and vice versa. They go through the index.
>
> =A0 =A0 So I took care with "git put HEAD WORKTREE" that the index wa=
s not
> =A0 =A0 touched. That makes the command very obvious and keeps the so=
urces
> =A0 =A0 and destinations as orthogonal as possible. But is it really =
what
> =A0 =A0 the user wants? In the case of "checkout", I'm not sure. In t=
he
> =A0 =A0 case of "commit -A", you probably _do_ want to update the ind=
ex if
> =A0 =A0 the commit is HEAD, and _don't_ if it is another branch.
>
> =A0 =A0 But now we're getting magical again. So the question becomes:
> =A0 =A0 should git put just be a pure _wrapper_ around these other
> =A0 =A0 commands to aid in discoverability, and do sensible things fo=
r each
> =A0 =A0 combination, or should it be a purely orthogonal "pick conten=
t from
> =A0 =A0 source to destination" command?
>
>> > =A0 - allow multiple destinations, like
>> >
>> > =A0 =A0 =A0# equivalent to "git checkout --"
>> > =A0 =A0 =A0git put HEAD INDEX,WORKTREE
>>
>> This is close to going overboard, but OK.
>
> Yeah, I'm still kind of brainstorming, but I think you might be right=
=2E
> But see above for why "git put" should possibly just be doing it for
> you automatically.
>
>> > =A0 - subtrees as locations. This allows a form of renaming betwee=
n old
>> > =A0 =A0 versions.
>> >
>> > =A0 =A0 =A0 git put gitgui-0.10.0: WORKTREE:git-gui
>>
>> This is a natural extension of the above "we could rename" theme, ri=
ght?
>
> Yeah, I think so.
>
>> The only worry about confusion is if people incorrectly think these =
magic
>> tokens are not mere syntax sugars available only in "put", especiall=
y,
>> they look so similar to "HEAD" which is _not_ syntax sugar and can b=
e used
>> elsewhere. Other than that, I think this is a nice approach.
>
> I think it might be worth using the same tokens in "diff", but yeah,
> they definitely should not go elsewhere.
>
> I find the all-caps ugly, and it is part of what confuses them with
> HEAD. At the same time, we are using the same namespace that ref look=
up
> uses. So calling it "worktree" might be too ambiguous. I tried to avo=
id
> using "--worktree" because I wanted to make it clear that these were
> ordered arguments, not options.
>
> There's also one other complication with the whole idea, which is tha=
t
> there are two separate things you might want to move: content itself,=
 or
> _changes_ in content.
>
> That is, think about the way stashes work. We don't apply the differe=
nce
> between the stashed content and our working tree. We look at the
> difference between the stashed content and its parent, and then apply
> those changes to the working tree.
>
> When I do "checkout -p $commit $file", I am often not interested in
> seeing all of the differences between where I am now and where $commi=
t
> is, but rather in seeing the differences introduced by $commit, and
> pulling them selectively into my current version of $file. Sort of a
> "cherry-pick -p".
>
> Should "put" support that kind of usage? What would it look like?
>
> =A0git put commit:v1.7.5 WORKTREE Makefile
>
> ? Or even:
>
> =A0git put v1.7.4..v1.7.5 WORKTREE Makefile
>
> I dunno. Maybe this whole thing is too crazy. I'll think on it some
> more, and maybe some other people will comment.
>
> -Peff
>
