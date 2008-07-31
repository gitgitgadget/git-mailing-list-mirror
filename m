From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Monotone workflow compared to Git workflow ( was RE: Git vs
 Monotone)
Date: Thu, 31 Jul 2008 14:13:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807311357430.3277@nehalem.linux-foundation.org>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <alpine.LFD.1.10.0807311211260.3277@nehalem.linux-foundation.org> <63BEA5E623E09F4D92233FB12A9F79430238A5EE@emailmn.mqsoftware.com> <alpine.LFD.1.10.0807311253140.3277@nehalem.linux-foundation.org>
 <20080731205400.GA7911@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Craig L. Ching" <cching@mqsoftware.com>, sverre@rabbelier.nl,
	Git Mailinglist <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 31 23:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOfWn-000058-BQ
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbYGaVQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jul 2008 17:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752527AbYGaVQk
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 17:16:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43303 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752087AbYGaVQj (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jul 2008 17:16:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VLG6i2026175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 14:16:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6VLG5ut012335;
	Thu, 31 Jul 2008 14:16:05 -0700
In-Reply-To: <20080731205400.GA7911@atjola.homenet>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.406 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90994>



On Thu, 31 Jul 2008, Bj=F6rn Steinbrink wrote:
> >=20
> > So literally, if you do
> >=20
> > 	git clone <cntral-repo-over-network> <local>
>=20
> Hum, I guess I'm just missing something and prepare to get flamed, bu=
t
> wouldn't you want that one to be bare? Otherwise, the other clones wo=
n't
> see all of the original repo's branches, right?

Making it bare might be a good idea for other reasons too (it makes it=20
much more obvious that it's a "local clone" and is somehow special). Bu=
t=20
it's really a matter of taste - and the project - exactly how you do it=
=2E=20

=46or example, the kernel only has a single master branch in the top re=
po,=20
so there it really doesn't matter, and yes, I'm more kernel-oriented th=
an=20
anything else, of course.

But I don't think it's exactly wrong to have the initial clone be a rea=
l=20
repository that you do work in. Quite often the history really is the=20
_bulk_ of the database by far (at least with projects that have big eno=
ugh=20
repositories for this to even matter in the first place!), and as long =
as=20
you just download that once and share that thing, you're already ahead =
of=20
the game and the rest is really just details.

> Maybe even better:
>=20
> mkdir local-mirror
> cd local-mirror
> git --bare init
> git remote add -f --mirror origin <central-repo-over-network>
>=20
> A cronjob (or whatever) could keep the local mirror up-to-date and th=
e
> other repos can fetch from there.

Heh. You can certainly do it many ways. I suspect the _easiest_ model i=
s=20
actually to do one single local repo that is special (and perhaps bare)=
,=20
and then you can clone all the other ones with

	git clone --reference <local-reference> <remote> <new-local>

because that will automatically set up the new local repo to have the=20
local reference as an alternates thing, and will avoid downloading=20
unnecessary stuff.

So my point about the eleven repos was not that it's the best way to do=
=20
one remote clone and then eleven local ones - my point was that even if=
=20
you do that _stupid_ thing, you'd have seen sharing without even knowin=
g=20
what you really did.

If you want to explicitly share, I think the local bare reference and=20
using "git clone --reference" is the best way. It sets up a special=20
link-file (it's just a text-file that git knows about, so it should wor=
k=20
fine under Windows too - no need for filesystem support) in=20
=2Egit/objects/info/alternates.

IOW, git-clone --reference works like "git clone -s", but does so with =
one=20
special local database, while allowing you to clone from anywhere. Very=
=20
convenient.

And no, I don't think we document all these "tricks" very well. Partly=20
because people are _already_ complaining about how git can do so many=20
things ;) But partly because if you don't know what you're doing, the=20
"tricks" are often things you really need to understand, and can be a b=
it=20
dangerous otherwise.

=46or example, the "git clone -s" (or --reference) thing is *very* usef=
ul,=20
but one result of other repositories then sharing a database with the=20
reference one is that suddenly the reference repo is very special. You=20
must not remove it (obviously!), but you also must not rebase it and pr=
une=20
it etc.

So all the normal git workflows are at least designed to be _safe_ even=
 in=20
the absense of people not knowing what they are doing. The duplication =
may=20
be using harddisk space, but

 - quite often the checkout is actually an even bigger issue, and the g=
it=20
   repo is small enough that lots of people don't really worry.

 - duplicating the repo also means that you cannot _possibly_ screw up=20
   other people/repos and does give you a kind of backup (even if=20
   same-disk backups are obviously of dubious use: they shouldn't be yo=
ur=20
   _primary_ backup, but having multiple copies on a single disk still=20
   protects against a _lot_ of problems)

so... It's a trade-off.

			Linus
