From: Brian Foster <brian.foster@innova-card.com>
Subject: Re: [Q] `git fetch tag NAME' into mirror repo does not update HEAD, what to do?
Date: Fri, 13 Aug 2010 09:22:23 +0200
Message-ID: <201008130922.23717.brian.foster@innova-card.com>
References: <201008120954.27648.brian.foster@innova-card.com> <Xp6r8yG_6tK_gooNBRqAKdsGRTcXgRo-b1bJv3J7ckxs2iD_-UXlPw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 13 09:23:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjobX-0000TG-Fv
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 09:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202Ab0HMHWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 03:22:41 -0400
Received: from 6-61.252-81.static-ip.oleane.fr ([81.252.61.6]:49603 "EHLO
	zebulon.innova-card.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754508Ab0HMHWj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 03:22:39 -0400
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Fri, 13 Aug 2010 09:22:33 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.28-15-generic; KDE/4.3.2; x86_64; ; )
In-Reply-To: <Xp6r8yG_6tK_gooNBRqAKdsGRTcXgRo-b1bJv3J7ckxs2iD_-UXlPw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153464>

On Thursday 12 August 2010 19:02:49 Brandon Casey wrote:
> Brian Foster wrote:
> >  Bare repository ORIG's master looks like this [ I've updated
> >  all of the diagrams slightly to remove some confusion  -blf]:
> >=20
> >    o--o--o--o--v1--o--v2--o--o--o [master &] HEAD
> >=20
> >  where v1 and v2 are (annotated) tagged commits.
> >=20
> >  Repository SLAVE is a mirror clone of ORIG which
> >  (very deliberately!) lags behind (i.e., [SLAVE's master's head]
> >  is one of the earlier (and usually tagged) commits
> >  on ORIG).  SLAVE's master was like this:
> >=20
> >    o--o--o--o--v1 [master &] HEAD
> >=20
> >  We wanted to update [SLAVE's master's head] to v2, so did:
> >=20
> >    git fetch ORIG tag v2
> >=20
> >  This gave us:
> >=20
> >    o--o--o--o--v1 [master &] HEAD
> >                  \=20
> >                   o--v2
> >=20
> >  It did not update SLAVE's [master's head] to v2, which we wanted[:=
]

       o--o--o--o--v1--o--v2 [master &] HEAD

> Are you using --mirror only so that the branch pointer in
> the mirror repository will be updated when you fetch?

 Correct.

> If you are not really interested in having a "real" mirror,
> then maybe you should set your mirror up to track a
> specific branch (or branches) in the mirrored repository.

 Now that seems like an excellent idea!

 The embarrassing thing is, we actually do _do_ something
 similar elsewhere in the process.  So we haven't got any
 great excuse for not thinking of it ....  ;-\=20

> You could have a branch named for example "for_mirror/master",
> in the mirrored repository (ORIG) that you would prepare.
> You could update the for_mirror/master branch when you were
> ready using 'git branch' like this:
>=20
>    git branch -f for_mirror/master v2
>=20
> In the mirror repository (SLAVE), you would update the
> fetchspec so that the mirror mirrored the branches below
> the "for_mirror" namespace in the remote repository
> like this:
>=20
>    fetch =3D +refs/heads/for_mirror/*:refs/heads/*
>=20
> Then, a simple 'git fetch' would fetch the updates (including
> tags) and update the branch pointer in the mirror like you want
> it to do.  Tracking multiple branches this way is possible just
> by creating another branch in the ORIG repository with the proper
> name.

 Another nice point about the above is it could deal
 with another procedural issue we have, which is the
 lack of a =E2=80=9Cstaging area=E2=80=9D for final test (a =E2=80=9Cpr=
e-SLAVE=E2=80=9D).
 Whilst we haven't (yet) had any (known) screw-ups in
 the final released system (what =E2=80=9Cmirror=E2=80=9D SLAVE contain=
s),
 it can happen.  The known screw-ups were all detected
 before it went to SLAVE, but by accident (IM(H?)O).

 Thanks for the idea/observation.

cheers!
	-blf-
