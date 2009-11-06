From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Preserving branches after merging on ancestor
Date: Fri, 6 Nov 2009 03:10:38 +0100
Message-ID: <20091106021038.GA27206@atjola.homenet>
References: <26217077.post@talk.nabble.com>
 <20091105223004.GA3224@progeny.tock>
 <20091105232848.GA1939@atjola.homenet>
 <20091106010947.GB4425@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Richard Lee <richard@webdezign.co.uk>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 03:10:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6EHt-0005N9-5F
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 03:10:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758986AbZKFCKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Nov 2009 21:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758061AbZKFCKk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 21:10:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:56949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752474AbZKFCKj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 21:10:39 -0500
Received: (qmail invoked by alias); 06 Nov 2009 02:10:43 -0000
Received: from i59F56212.versanet.de (EHLO atjola.homenet) [89.245.98.18]
  by mail.gmx.net (mp070) with SMTP; 06 Nov 2009 03:10:43 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/sH503HljsO20kKCHnC0rXTyuy35BydAN/WJJ9Nb
	reRrhyqnF89Gcy
Content-Disposition: inline
In-Reply-To: <20091106010947.GB4425@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132268>

On 2009.11.05 19:09:48 -0600, Jonathan Nieder wrote:
> Bj=C3=B6rn Steinbrink wrote:
>=20
> > I guess Richard took the "branch topic1, merge topic1, branch topic=
2,
> > merge topic2" thing just as an example because that ends up with tw=
o
> > fast-forwards.
>=20
> Hmm, I found Richard=E2=80=99s example pretty realistic.  I used to w=
ork like
> that, and I don=E2=80=99t think I am the only one.
>=20
> > And your example _still_ has such a fast-forward.
>=20
> Yep, if you really want to avoid fast-forwards, please use "--no-ff"!
>=20
> But what I was trying to make clear was that in some workflows, the
> fast-forwards are not so harmful.  They even make the history a littl=
e
> cleaner (easier to read and understand).
>=20
> > Instead of:
> >=20
> > A---B---C---D---E (topic2) (master)
> >      \
> >       F---G---H (topic1)
> >=20
> > He wants:
> >=20
> >       F---G---H (topic1)
> >      /
> > A---B-----------M (master)
> >      \         /
> >       C---D---E (topic2)
> >=20
> > So he can see at which point topic2 got merged. This allows to ask =
"which
> > commits got merged here" (and for a merge-once topic branch this me=
ans:
> > Which commits are related to that topic), by using for example:
> >=20
> > git log M^1..M^2 # Will show C, D and E
>=20
> You can get the same information locally even with a fast-forward:
>=20
> git log master@{1}..master

And after two weeks, you'll dig through the reflog to find the right
entries? Come on... And (as you said yourself below) everyone else
(including yourself in a different clone of that repo) doesn't have tha=
t
reflog entry anyway.

> But to someone reading the published history, it is not available.
> Depending on your way of working, this may or may not be reasonable.
>=20
> Perhaps your merge commit messages contain important information abou=
t
> the branch=E2=80=99s overall purpose and provenance, which would be i=
mpossible
> if there is no merge commit.

The actual commits that make up the topic should have descriptive enoug=
h
commit messages to make extra "why merge this" messages shouldn't be
required. But merge commits provide a way of giving a high-level
overview of the history of a project.

> On the other hand, if the goal is just to present the fact of a merge=
,
> to explain where a patch falls in the larger scheme of things, then
> how large a chunk of changes I decided to call a feature does not see=
m
> too important.

=46or example in git.git, I can do "git log --first-parent
=2E.origin/master" to get a high-level log of what happened. And then I
might see commit b7eb912b0, which is "Merge branch ja/fetch-doc". So I
know "OK, there were some doc updates", without having to crawl through
the individual commits.

And if I decide that for _this_ topic, I care to see what got merged, I
can do: git log b7eb912b0^1..b7eb912b0^2

Had this been a fast-forward, even the --first-parent history would
throw the individual commits at me, giving me less of a high-level
overview.

> Imagine a patch series, cleaning up some ugly code that has been
> bothering me for a while:
>=20
>  base [master] --- A --- B --- C [cleanup]
>=20
> It looks good, so I merge to master with --no-ff.
>=20
>  base --------- D [master]
>      \         /
>       A---B---C [cleanup]
>=20
> Looking at that code inspires me to build a new feature that is much
> easier with the cleaned up version.  So I fork a branch from cleanup
> (Or master?  Their content is the same, but somehow I choose one) and
> write some patches for the new feature.
>=20
>  base --------- D [master]
>      \         /
>       A---B---C [cleanup] --- E --- F --- G
>=20
> It looks good, so I merge.
>=20
>  base --------- D --------- H [master]
>      \         /           /
>       A---B---C---E---F---G
>=20
> Is this really any easier to read than base---A---B---C---E---F---G?
> In hindsight, was this logically really two series, or is the D commi=
t
> extra cruft?

Choosing "cleanup" as the starting point for an unrelated topic branch
(after all "cleanup" was already merged, so there's absolutely no reaso=
n
to base a new topic on it) is wrong. That history looks as if E,F,G was
a second part of the same topic branch.

I'd have done:

              E---F---G (topic2)
             /         \
0-----------D-----------H (master)
 \         /
  A---B---C (cleanup)

And then I could do "git log --first-parent master" to see H and D
(high-level view), and "git log H^1..H^2" or "git log D^1..D^2" to get =
a
low-level view at the merged topics.

Neither of which I could do with "0---A---B---C---E---F---G". With that=
,
I'd have to manually looking up the start/end points of each topic.

> Almost always, a fast-forward comes from a continuation of this kind,
> since that is what it means for a commit to be the logical commit to
> fork from.

Hm? I don't get that one. The "continuation" would be that you started
the second topic branch from the first topic branch, right? And that
caused the merge to "master" _not_ to be a fast-forward. So I'm somewha=
t
confused there.

> Of course, these things are a matter of taste.  I just wanted to
> explain why a fast-forward could at least sometimes be the right
> result from merging a topic branch (and why, in practice, some people
> never end up needing to use --no-ff).

Sure, fast-forwards can be the right thing, e.g. when you have a
(possibly useless) branch head "master" that you update by pulling. In
such a case merge commits would only lead to useless clutter. But
Richard wants to see where topic branches got merged (to be still able
to see what got merged in the future), and yeah, that's a matter of
taste. But you argued that using --no-ff would "[miss] some of the main
benefits of feature branches", which is simply not true.

Bj=C3=B6rn
