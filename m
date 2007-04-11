From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Wed, 11 Apr 2007 13:31:50 +0200
Message-ID: <20070411113150.GL21701@admingilde.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org> <20070411080641.GF21701@admingilde.org> <200704111047.01271.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:45:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbb3W-0004Wh-1h
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 13:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbXDKLby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 07:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbXDKLby
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 07:31:54 -0400
Received: from mail.admingilde.org ([213.95.32.147]:51801 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbXDKLbw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 07:31:52 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hbb3G-0000xv-GV; Wed, 11 Apr 2007 13:31:50 +0200
Content-Disposition: inline
In-Reply-To: <200704111047.01271.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44233>


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Apr 11, 2007 at 10:47:00AM +0100, Andy Parkins wrote:
> On Wednesday 2007 April 11 09:06, Martin Waitz wrote:
>=20
> > The only thing I disagree with you is in using HEAD of the submodule:
>=20
> I know we've had this discussion before, but I'm going to bring it up aga=
in -=20
> mainly because Linus's implementation exactly matches what I envisaged wh=
en=20
> we originally spoke of this.  I think in your "Updating the branch which =
HEAD=20
> points to is dangerous" section, the main thing you're not taking into=20
> account is that git can make detached checkouts.  Updating HEAD is not=20
> dangerous - updating refs is; and I don't think anyone is proposing that =
a=20
> submodule ref should ever be updated by a supermodule.

Then we already agree on the most important part.
My argument is mostly against updating the ref which is behind HEAD, not
HEAD per se.  And I haven't thought about using detached HEADs until I
wrote the mail.

> I think you're also too strongly focussed on the idea that the supermodul=
e=20
> tracks submodule branches - it cannot branches are not part of "the"=20
> repository they point at "a" repository.  References are outside the=20
> repository pointing in, and hence the supermodule cannot refer to them at=
 its=20
> core.

No, that may be an misunderstanding because my very first prototype
really did track branches.  In the meantime I changed my mind, my
current prototypes all track submodule commits directly.
But in doing so we create a branch of its own: remember, a branch in
git is just a moving reference into the history.  Such a reference
can be stored in .git/refs/heads or it can be stored in the index/tree of
the supermodule.  The difference is not really big.
So we do not track a branch, but we create a branch by tracking.

> Now, if you check out a revision in the supermodule, that's going to look=
 up=20
> the submodule revision stored in the DIRLINK tree entry which will recurs=
e=20
> into the submodule and checkout that revision - almost certainly as a=20
> detached HEAD.  There are three possibilities then:
>  - The submodule revision is in the past and no submodule branch points a=
t it
>  - The submodule revision is current and a submodule branch points at it
>  - The submodule revision is current and multiple submodule branches poin=
t at=20
>    it
> The supermodule checkout will have to make a decision whether to update t=
he=20
> submodule HEAD (in one case it's obvious: a revision in the past has to b=
e=20
> detached HEAD as there is no suitable branch).  It's also possible that t=
he=20
> single submodule branch case is easy - undetach HEAD; however I don't thi=
nk=20
> that is universally correct.

I don't like to guess which branches to update.
I'd prefer to just unconditionally update one specific one.

> I know you're very much in favour of making branches in the submodule=20
> correspond to branches in the supermodule, but I just don't see a way of=
=20
> making it work - the supermodule cannot know about submodule branches,=20
> branches are not part of the repository, they just point at the repositor=
y. =20
> My branches could be different from your branches.

That would not work, you are right.
Please see my above comment about tracking & branches.

> The way submodules should be treated is that the whole submodule is analo=
gous=20
> to a single repository-tracked file - that's essentially what a submodule=
 is=20
> in the end but the content of the "file" is the submodule revision.

Wholeheartedly agreed.

> Now, if you change branch in the submodule, the supermodule will see
> that as a change in the submodule (as it should).  If you changed
> back, it will be restored and the supermodule will again see it as
> unchanged.  If you commit on the submodule, the supermodule will see
> that as a change and you'll have to git-add the submodule and commit
> in the supermodule.  The submodule is on whatever branch it is on - at
> all times.

> The only time I can see this causing difficulties is when you want to
> checkout the tip of a submodule branch - how is the supermodule to
> know when it is correct to change HEAD from being detached to being
> attached?  I suppose it's got to be config-based; and out-of-tree
> config at that.

Again, doing things conditionally here just adds to confusion.
Just have one dedicated branch and be done with it.

--=20
Martin Waitz

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGHMcmj/Eaxd/oD7IRAm5kAJ4pfnvQ32X5qE7eg0LwT5TcgG81kQCfeM55
o04gvAU0PPfxHJS6DoyLFSo=
=RNUJ
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--
