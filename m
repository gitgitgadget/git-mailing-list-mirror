From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the
 tracked branch
Date: Fri, 2 Oct 2009 16:54:44 +0200
Message-ID: <20091002145444.GA27904@atjola.homenet>
References: <20090904135414.GA3728@honk.padd.com>
 <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
 <4AA8CA88.9060802@drmicha.warpmail.net>
 <200909101218.06789.johan@herland.net>
 <20090910111156.GA2910@coredump.intra.peff.net>
 <7vzl92bql9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pete Wyckoff <pw@padd.com>, i.am@jimramsay.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 16:54:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtjX7-0003Ks-EY
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 16:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbZJBOys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbZJBOys
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 10:54:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:56354 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751719AbZJBOyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 10:54:47 -0400
Received: (qmail invoked by alias); 02 Oct 2009 14:54:49 -0000
Received: from i59F562B6.versanet.de (EHLO atjola.homenet) [89.245.98.182]
  by mail.gmx.net (mp006) with SMTP; 02 Oct 2009 16:54:49 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+/W2VZLFC/Wyei2FqkfkNmloWKu52tAhmWM38g/s
	Bjx6ILRtVO5VBY
Content-Disposition: inline
In-Reply-To: <7vzl92bql9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129446>

On 2009.09.10 11:29:54 -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Thu, Sep 10, 2009 at 12:18:06PM +0200, Johan Herland wrote:
> >
> >> > > A special shortcut '@{tracked}' refers to the branch tracked b=
y the
> >> > > current branch.
> >> >
> >> > Sorry, I didn't know the name of the long form was up for discus=
sion.
> >> > But it should certainly coincide with the key which for-each-ref
> >> > uses, shouldn't it? I don't care whether tracked or upstream, bu=
t
> >> > for-each-ref's "upstream" has set the precedent.
> >>=20
> >> ...and 'git branch --track' set an even earlier precedent...
> >
> > FWIW, that came about from this discussion:
> >
> >   http://article.gmane.org/gmane.comp.version-control.git/115765
>=20
> After re-reading the discussion in the thread that contains the quote=
d
> article, it sounds like we may want to fix "branch --track X Y".  X d=
oes
> not "track" Y in the same sense as origin/master "tracks" master at
> origin.  Rather, X builds on Y.

=46WIW, I just had a discussion on #git with Jim Ramsay (lack) about th=
at.
We agreed that "branch --track" is unfortunate and causes confusion,
when it comes to the term "tracking branch" (which the glossary
basically defines to be something in the refs/remotes/ namespace, at
least something you never commit to), as people also start to use that
for branch heads that have an "upstream branch" set in the
configuration.

Jim initially preferred the term "linked", while I argued for the optio=
n
to be called --upstream (potentially with the possibility to say
--upstream=3Drebase or --upstream=3Dmerge, the default being "merge", u=
nless
branch.autosetuprebase is set).

We could (I think) to some degree agree that "upstream" is quite good,
although we couldn't find a short and sweet term to describe the branch
head that has a configured upstream branch (some ideas were "upstreamed
branch", "uplinked branch", "downstream branch" and some more, which I
all dislike). After having read the glossary and finding "upstream
branch" in there, I'm even more in favor of using the "upstream" term i=
n
some form.

During the discussion, there were some requests (again) for a command
that allows to change branch.<name>.remote and branch.<name>.merge for
already existing branch heads. With that extra input, I'd now favor:

git branch --set-upstream X Y

because that's potentially reusable for the "change upstream for an
existing branch" case, though I'm totally clueless how to actually do
that, given that "git branch" uses flags to switch between "create new
branch" and "operate on existing branch". So reusing a flag won't
(easily) do the trick, at least not without special casing that could b=
e
dangerous. You could, for example, accidently change the upstream for a=
n
existing branch, while you meant to create a new one.

It's a bit sad that we don't have subcommands for "git branch" like we
do for "git remote", that would make the whole thing a lot easier, but
it's way too late to change that, I guess. At least having "git branch
<name>" default to be "git branch add <name>" would make some branch
names "invalid" for that shortform. So that looks like a no-go.

Bj=F6rn
