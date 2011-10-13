From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 15:59:16 +0200
Message-ID: <1318514356.4646.16.camel@centaur.lab.cmartin.tk>
References: <loom.20111013T094053-111@post.gmane.org>
	 <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	 <20111013145924.2113c142@ashu.dyn.rarus.ru>
	 <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
	 <loom.20111013T144822-277@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-EHnuD7DBjmLffXRnrhBF"
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:59:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RELon-0000MG-VY
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755111Ab1JMN7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:59:24 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:35722 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab1JMN7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:59:24 -0400
Received: from [192.168.1.17] (brln-4dbc7ca2.pool.mediaWays.net [77.188.124.162])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 1F002460FE;
	Thu, 13 Oct 2011 15:58:56 +0200 (CEST)
In-Reply-To: <loom.20111013T144822-277@post.gmane.org>
X-Mailer: Evolution 3.0.3-2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183487>


--=-EHnuD7DBjmLffXRnrhBF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-10-13 at 13:09 +0000, arQon wrote:
> Andreas Ericsson <ae <at> op5.se> writes:
> [snip]
> > This means that if fileX on branchA is different from fileX on branchB =
and you
> > *also* have local modifications to fileX, git will refuse to switch bra=
nches.
> > If, on the other hand branchA:fileX =3D=3D branchB:fileX and you have m=
odifications
> > to fileX in your work tree, there's no reason to refuse the branch chan=
ge.
>=20
> There's an EXCELLENT reason to refuse the branch change: once it happens,=
 what
> git is then telling is branchA, is not.

When you changed branches, git told you that a file had been changed in
the working tree. When you run 'git diff', it tells you the differences
between what you have in your working tree and what's in the branch[0].
Git is trying hard not to loose your modifications (maybe it was a
one-liner, maybe it was three hours of work) to the file.

>=20
> > It's not a bug. You just read the manpage a bit wrong.
> [snip]
> > So yes, this is a feature, and it's a handy one.
>=20
> Thanks for the explanation. Unfortunately, I still can't see it as anythi=
ng but
> a critical bug. Consider this:
>=20
> You're working on branchA and you have a bunch of uncommitted changes.
> You can't remember some detail of the bug you're fixing, so you switch br=
anches
> to the master. You have to rebuild that branch, because your last build w=
as from
> your branch. git now builds the master with sources that were NEVER commi=
tted
> to it. How is that not a total failure to maintain branch integrity?

It sound like you've misunderstood what a branch is for git. A branch is
only ever changed when you commit. What checkout does is change what the
current branch is. For a case like what you describe, the developer
would either do a temporary commit that they'd change later or stash the
changes[1]. You could also use git-new-workdir (from contrib/) so you
have two different directories that share the object storage. That has a
few rough edges, but if you restrict it to a broken branch, you
shouldn't have any problems.

>=20
> If that's the way git is, then that's how it is; and if there isn't a set=
ting
> that can make it actually preserve branches properly, then there isn't. W=
hich
> sucks for me, because an SCCS that lies about what branch you're "really"=
 on
> is worse than useless, so I'm stuck with SVN.  :(

Don't think of it as being "in" a branch. A checkout in git changes the
active branch. If there are any files that are different between the two
branches, they are changed. By switching branches with uncommitted
changes, you're telling git that you would rather use the other branch
to do your changes in. But git isn't doing this silently. After the
checkout, it lists the files that have local modifications, so the
developer can switch branches again and commit or stash the changes.

   cmn

[0] Really it's between the working tree and the index, but since you
just switched branches, the index is the same, and using it in that
sentence would just cause confusion.

[1] 'git stash' is a command that saves your uncommitted changes on a
stack so you can recover them later.


--=-EHnuD7DBjmLffXRnrhBF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOlu60AAoJEHKRP1jG7ZzT35sIAJHoSRCC7/roi0XtCExxluX4
zPTuB4DC/regZt7hnbCVh5jFJ3ZLirUQ8Dg3cU0LHk18hEiUwDQf5mmwKdIFL+Zf
thRB4Ry2wB/kOPu83b0XBY8iCtSm+TOKDNajTZU/WVUsYyCJ3yKfczCZqSViN3ep
2LLtLQ1VDC7Yj2peRUwOdeMYlIM4lMWWu7HUUCKHLsQuFL+B+QVtnQPfsjkXKeEw
vsnXWXxebi5IGZQj8NtN81pMIgJXQUcBAcRm7GR6/ibAek/fL+xeV93LHBkAPpXp
yjNR/r2WF04z81FSA38n4rI8T5IWeOivM3rVVtaN5SStJUChNvpBdkBEWoy53fU=
=2o40
-----END PGP SIGNATURE-----

--=-EHnuD7DBjmLffXRnrhBF--
