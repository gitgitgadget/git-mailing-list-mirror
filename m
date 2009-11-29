From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 19:17:58 +0100
Message-ID: <20091129181758.GA9533@atjola.homenet>
References: <loom.20091129T164518-669@post.gmane.org>
 <20091129164748.GB7921@atjola.homenet>
 <4db3b0200911290941j42c5a0aaq2c6a9836b38066b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Weseloh <Peter.Weseloh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Peter Weseloh <peter.weseloh@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 19:18:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEoLl-0007GE-LL
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 19:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbZK2SSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 13:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbZK2SSF
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 13:18:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:40806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751622AbZK2SSD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 13:18:03 -0500
Received: (qmail invoked by alias); 29 Nov 2009 18:18:06 -0000
Received: from i59F55C61.versanet.de (EHLO atjola.homenet) [89.245.92.97]
  by mail.gmx.net (mp055) with SMTP; 29 Nov 2009 19:18:06 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/jwt0Z1U7juvY+PV1G8BSI2N9aT2SHpETDtWW8FS
	JHb0W82XpnP/Qi
Content-Disposition: inline
In-Reply-To: <4db3b0200911290941j42c5a0aaq2c6a9836b38066b2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134028>

On 2009.11.29 18:41:35 +0100, Peter Weseloh wrote:
> >  What's unusual there is that you merged from Mainline to Feature_A=
=2E
> > Usually, the history would look like this:
> >
> >   o--o--o                    Release_1.0
> >  /    \  \
> >  o-o-o--o--o-o-o-o-o-o---o--o Mainline
> >      \                 /
> >       F1-----F2------F3      Feature_A
> >
> > And then you could easily use rebase to get the job done.
>=20
> But on the other hand the intermediate merges from the Mainline make =
for
> much simpler merges, right?.
> If merging is done only when Feature_A is ready it might become a rea=
l pain.

That's usually more often true with CVS or SVN than with git, but ...

> It might take several month to complete it and the mainline might hav=
e
> changed a lot.

=2E.. over such a long timeframe, yes, things might become ugly. OTOH s=
uch
a long timeframe might also mean that the topic branch actually does to=
o
much. Splitting such a large thing into more manageable pieces would
help there, as you could merge completed topic branch to your mainline
branch earlier and more often.

> > Had you known beforehand that Feature_A is a candidate for backport=
ing,
> > you would have even branch from an older commit like this:
> >
> >   o--o--o                    Release_1.0
> >  /    \  \
> >  o-o-o--o--o-o-o-o-o-o---o--o Mainline
> >  \                     /
> >   F1--------F2-------F3      Feature_A
> >
> > Then you could easily merge Feature_A to Release_1.0 as well, witho=
ut
> > merging anything unrelated.
> >
> > But that's just for the future...
> >
> Yes, sure. If I would know the future already today I would not need =
to do
> any coding anymore :-)

I meant something like "I just said that, so you can avoid problems in
the future" ;-) But yeah, knowing beforehand that things should go into
a maintenance branch isn't common, unless it's about a bugfix.

> > Given you current history, you could use format-patch + am like thi=
s:
> >
> > git format-patch --stdout --first-parent Mainline..Feature_A > fa.m=
box
> > git checkout Release_1.0
> > git am -3 fa.mbox
> >
> > The --first-parent options make it follow the first parent of the m=
erge
> > commits only, so the whole stuff on the Mainline branch is ignored.=
 And
> > you just get F1, F2 and F3 in fa.mbox, which you then apply using a=
m.
> >
> >
> Ah, great! I played with format-patch + am but missed the '--first-pa=
rent'
> option. I will give it a try. Thanks a lot!

Well, it's a rev-list option, which might work by accident. Junio
recently said that the fact that format-patch accepts path limiting is
by accident, might be true for --first-parent as well... No clue. Junio=
?

Bj=F6rn
