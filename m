From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear 
	history?
Date: Sat, 20 Feb 2010 13:25:11 +1100
Message-ID: <2cfc40321002191825i605e5045w6f52f9f044a5d369@mail.gmail.com>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com>
	 <20100218051129.GD10970@coredump.intra.peff.net>
	 <2cfc40321002181704i73eb87demd03faaddf9bb108@mail.gmail.com>
	 <32541b131002181913t24989addr84b612787a2f8c48@mail.gmail.com>
	 <2cfc40321002182329q7b8c5b90nbd77a4e0678cd9c8@mail.gmail.com>
	 <32541b131002191220q5a0eae6dk304173418f818ff3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 03:25:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nif21-0004qW-2P
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 03:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035Ab0BTCZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 21:25:14 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51264 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931Ab0BTCZM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 21:25:12 -0500
Received: by pwj8 with SMTP id 8so745286pwj.19
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 18:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uBl8igSMXJ8bY/0KqGX2l5XIJfqGqzNK+wSThNaguYQ=;
        b=swFVIACDHfU8CwjxgRQS6+7IjS/+4Q3XKxLUUP75T+oio6+yh7Dii2DgrWwTiqpNmN
         /QhmvLZEHgXu3e6oBStAtqhJ9luRSyU0O5ziiu7buxBiovi2AmUtVr76gBaEfNALYm4m
         w+t3z3tgcxeWx8uKdBsisjcyH5vXlzqu3c8t8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mdw73NY0hqFxza+ssi8b+ofJlI6wDk2KEAvEJzCCpNEGnKJrYZ/oODUkCW6pgKI5jg
         66i8LPxNLVU2C5cmRgCYsH+OHS2lMisRjl6oGGhEKXxZ08UOgSFul7IEmo9Wb+QBA0at
         i9rs+JKLKNbavX8EeMp3sMdGmXcf0M0WCMgfY=
Received: by 10.114.11.2 with SMTP id 2mr7921794wak.73.1266632711280; Fri, 19 
	Feb 2010 18:25:11 -0800 (PST)
In-Reply-To: <32541b131002191220q5a0eae6dk304173418f818ff3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140510>

On Sat, Feb 20, 2010 at 7:20 AM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> On Fri, Feb 19, 2010 at 2:29 AM, Jon Seymour <jon.seymour@gmail.com> =
wrote:
>> If there are no merge conflicts in the original history, then there
>> will be no merge conflicts in the rewritten history, and therefore n=
o
>> error deltas.
>
> I'm just worried that this is a bit misleading. =A0Just because there
> are no conflicts at the end doesn't mean these generated interim
> versions ever compiled or worked, does it?
>
> ... example elided
>
> Now I linearize it in the way you propose, removing the "unnecessary"
> merges but keeping the developer's conflict resolutions. =A0What I en=
d
> up with is the last code segment above - but I *don't* have the rest
> of the patch that added the extra parameter to g. =A0So my conflict
> resolution is wrong for the code that remains. =A0And the delta fixup
> doesn't show that there was anything weird.
>

The thing is, if I linearised in the way I proposed, there would be a
conflict during the rebase of one branch of the merge onto the other -
so the conflict would be still be there.

However, what happens is that rather than stopping to manually correct
the conflict, I compensate for the conflict by introducing a patch
that restores the file to state it was in when the conflicting commit
was originally committed. This guarantees that all future picks for
that file will apply correctly.

You are entirely correct that the compensated file is no longer
consistent with the rest of the tree at that point in the history.
However, once the rewritten history passes the original merge, the
consistency of the tree will be restored (reason: by design the
rewritten history always restores the state of the tree the point in
the rewritten history that matches a merge in the original history).
The inconsistencies are thus limited in scope [ and, as you will well
see, well delimited ]

> Unless I've misunderstood something, you've thrown away the
> *advantage* that was autodetection of conflicts, in favour of having
> to eyeball it. =A0I'm not sure there's an advantage there.
>

The conflicts are detected and clearly marked in the history. What I
have done is simply defer the resolution of the conflicts to a point
of my later choosing so that I can continue with the linearisation
process automatically.

One nice consequence of my linearisation is that (even in the presence
of compensations) any diff between two points in the linearized
history will only show files touched by the history - not files that
changed in the upstream branch. True, some of these diffs will produce
nonsensical results (in particular diffs within a pair of compensating
deltas are not necessarily useful, nor are diffs that include one
compensation but not the other). However, diffs across histories that
do include both compensations will be sensible.

An example:

A-B-C-D-E-F-G-H
 \       \      \
  \-M-N-P-Q-R-S-T

(Merge at Q between P and E, merge at T between S and H)

Suppose a change made in C conflicts with a change made in N.

This was eventually resolved in the merge commit Q. There were no
conflicts in subsequent histories after E and Q (e.g. the merge at T
was clean)

My linearisation would first rebase on E.

    A B C D E M' e(^N) N' P' e(Q^) R' S' T'

e(^N) returns the state of conflicted files to the point they were
before N was applied.
q(Q^) returns the state of conflicted files to the point the were
after the merge at Q.

The conflict between C and N forced me to backtrack the conflicted
files to the state they were before N. This is done by the
compensation e(^N).
The commits N and P are then repicked and are guaranteed to succeed
(by definition - the conflicted files are now in the same state as
they originally were).
A reverse compensation e(Q^) is applied to ensure that R' sees the
tree as it was at Q.

The algorithm then rebases this history onto H.

    A B C D E F G H M'' e(^e(^N)) N'' P'' e(e(Q^)^) R'' S''

The following is true:

* the tree at e(e(Q^)^) is identical to the state of the tree at Q
* the tree at S'' is identical to the state of the tree at T
* the trees at M'' R'' S'' are consistent with the states that would
have been if rebases had been performed at Q and T with the same
conflict resolution outcomes.
* the trees at N'' P'' are internally inconsistent because some (but
not all) files have 'slipped backwards in time'
* the diff between M'' and R'' will be the equivalent to the diff
between M and R
* diffs between any points with M'' and S'' will only show files
touched by edits at M, N, P, R, S or the merge Q (the intermediate
rebasing on E and H dissolves the merge at T)
* the series e(^e(^N)) N'' P'' e(e(Q^)^) could be squashed into a
single commit that would correspond to the edits done in N and P and
the conflict resolution done in Q.
* the merge history ^A T  has been automatically rewritten as a rebase
history ^H S''

An interesting possibility would be to squash  e(^e(^N)) N'' e(e(Q^)^)
as N''' and then edit P'' to be consistent with a new base, N'''.  (In
fact, in this case P'' would simply be the diff between N''' and Q -
it gets more complicated if there is a series of intervening commits
between N and P).

If this worked (and there is no guarantee it would), then it would
have the effect of folding the conflict resolution with C performed at
Q into a re-edited commit N''' which is where it would have occurred
had ^A N been rebased on C in the first place.

>> In the no =A0conflict case, it is not clear to me that the history
>> resulting from your script is immediately rebaseable, precisely
>> because of the presence of the merge commits [ feel free to correct =
me
>> if I am wrong about that ] . With my approach, the merge commits
>> dissolve away - there is nothing to edit.
>
> I'm pretty sure that in the absence of conflicts, you could rebase -i
> my linearization and just remove the merge commits by hand, and thing=
s
> should go pretty smoothly. =A0Or in the simplest cases (ie. the merge=
d
> code is identical), rebase would notice that the merge patches have
> already been applied, and simply throw them away.
>
> In any case, I guess if what you're doing works for you, then go for
> it. =A0But in that case I'm not sure why you asked your original
> question; what about your current method *doesn't* do what you want?
>

Part of the reason I asked is that I was wondering whether someone had
hit upon this solution already, and if they had, I'd take advantage of
it. My discussions with you have certainly helped me think about and
articulate the nature of the inconsistencies that are introduced, so
that has helped too.

> If it's just a question of always auto-resolving conflicts using the
> local merge resolution, you might be interested in -Xours and
> -Xtheirs:
> http://n2.nabble.com/PATCH-0-8-The-return-of-Xours-Xtheirs-Xsubtree-d=
ir-td4069081.html
>
> If you're looking for more general suggestions about what to do when
> untangling a developer's horribly over-merged tree, you may want to
> consider a simple but inelegant solution that I've used myself
> sometimes: just squash the entire diff from upstream to developer's
> version into a single commit, then rip it apart again by hand. =A0In =
my
> experience, developers who make messes of merges also don't divide
> their commits into sensible fragments in the first place, so
> re-dividing them yourself afterward is actually the fastest route to
> sanity.

Yep, I agree that's not a bad option in many cases. It's pragmatic,
though rebuilding a history where the tree is internally consistent at
each point is a somewhat tedious. Linearisation at least holds out the
possibility of restoring consistency if you really want it for some
reason but allows you to defer the costs of doing so if you don't
really need it.

>
> Hope this helps.
>

It has.

> Have fun,

I will - I have created a github project called hammer where I will
make a realisation of these ideas available for evaluation at some
point.

git@github.com:jonseymour/hammer.git

(A hammer is, of course, a reasonably good tool for making things flat
although it does tend to break things along the way).

jon.
