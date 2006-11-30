X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 18:06:25 +0100
Message-ID: <20061130170625.GH18810@admingilde.org>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
NNTP-Posting-Date: Thu, 30 Nov 2006 17:07:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611292000.23778.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32776>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GppMs-0003PR-On for gcvg-git@gmane.org; Thu, 30 Nov
 2006 18:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030742AbWK3RGa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 12:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030740AbWK3RGa
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 12:06:30 -0500
Received: from agent.admingilde.org ([213.95.21.5]:33410 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1030742AbWK3RG2
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 12:06:28 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GppMf-0004mD-Ed; Thu, 30 Nov 2006 18:06:25 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Nov 29, 2006 at 08:00:22PM +0000, Andy Parkins wrote:
> On Wednesday 2006, November 29 16:03, Martin Waitz wrote:
>=20
> > The way I wanted to address this is to show in the supermodule
> > git-status that the submodule is using another branch.
> > That way you are warned and can decide not to commit the supermodule.
>=20
> The problem I see with tracking a particular branch is that it makes it l=
ess=20
> convenient to use git's quick-branching features in the submodules.  Let'=
s=20
> say I want to try something out quickly in a submodule, I make a branch,=
=20
> commit, commit, "hmm, looks good, let's snapshot it in the supermodule", =
make=20
> a supermodule branch, "oh no, I've got to tell the supermodule to track t=
he=20
> new (but temporary) branch in the submodule do a commit, switch the submo=
dule=20
> branch back to master, delete the temporary branch, remember that the=20
> supermodule is tracking that branch and tell the supermodule to track=20
> something else instead...  It all seems too complicated to me.

What about:
You decide to try something out quickly and create a new branch in the
submodule. After you have verified that it works, you merge it to the
submodules master branch and commit that to the supermodule.
Not that complicated, isn't it?
In fact, my current implementation does not even allow to change the
branch name of the submodule which is tracked by the supermodule ;-).

> > Pro HEAD:
> >  - update-index on submodule really updates the supermodule index with
> >    a commit that resembles the working directory.
>=20
> Ouch.  Why does the submodule need to update the supermodule index?

Please excuse that I am not an native english speaker and I may have
caused some confusion here.

> That should be done by update-index in the supermodule.

That is exactly what I wanted to say. In the supermoduel you call
update-index (with the submodule path as argument) to update the index
of the supermodule. Just like normal files. Nothing new.

> Further, how is the supermodule index going to represent working
> directory changes in the submodule?  The only link between the two is
> a commit hash.  It has to be like that otherwise you haven't made a
> supermodule-submodule, you've just made one super-repository.  Also,
> if you don't store submodule commit hashes, then there is no way to
> guarantee that you're going to be able get back the state of the
> submodule again.

This is handled in the next paragraph.
The argument really is: HEAD always points to the checked out branch,
so it really has a relationship to the working directory.

> > Contra HEAD:
> >  - HEAD is not garanteed to be equal to the working directory anyway,
> >    you may have uncommitted changes.
>=20
> That's the case for every file in a repository, so isn't really a
> worry.  It's the equivalent of changing a file and not updating the
> index - who cares?  As long as update-index tells you that the
> submodule is dirty and what to do to clean it, everything is great.

Yes, it's not a real counter-argument, but it relativates the previous
pro-argument.

> >  - when updating the supermodule, you have to take care that your
> >    submodules are on the right branch.
> >    You might for example have some testing-throwawy branch in one
> >    submodule and don't want to merge it with other changes yet.
>=20
> What is the "right" branch though?  As I said above, if you're tracking o=
ne=20
> branch in the submodule then you've effectively locked that submodule to =
that=20
> branch for all supermodule uses.

yes, but luckily GIT branches are very flexible.

> Or you've made yourself a big rod to beat yourself with everytime you
> want to do some development on an "off" branch on the submodule.

I don't think it is that bad.

> > Pro refs/heads/master:
> >  - the supermodule really tracks one defined branch of development.
>=20
> Why is this a pro?

You always know which branch in the submodule is the "upstream" branch
which is managed by the supermodule.
You can easily have several topic-branches and merge updates from the
master branch.
otherwise you always have to remember which branch holds your current
contents from the supermodule.

When viewed from the supermodule, you are storing one branch per
submodule in your tree.

> >  - you can easily overwrite one submodule by changing to another branch,
> >    without fearing that changes in the supermodule change anything
> >    there.
>=20
> You can always do that anyway by simply not running update-index for the=
=20
> submodule in the supermodule.

Suppose you are working on a complicated feature in one submodule.
You create your own branch for that feature and work on it.
Now you want to update your project, so you pull a new supermodule
version. Now this pull also included one (for you unimportant) change
in the submodule.
I think it is more clear to update the master branch with the new
version coming from the supermodule, while leaving your work intact
(you haven't commited it to the supermodule yet, so the supermodule
should not care about your changes, it's just some dirty tree).
Then you can freely merge between your branch and master as you like and
are not forced to merge at once. And perhaps you even do not want to
merge at all, because you are on an experimental branch which really is
mutually exclusive with the current supermodule contents.

> > Contra refs/heads/master:
> >  - after updating the supermodule, you may not have the correct working
> >    directory checked out everywhere, because some submodules may be on a
> >    different branch.
>=20
> This seems like the biggest problem to me - doesn't this negate all the=
=20
> advantages of a submodule system?  After a check in, you have no idea if =
what=20
> you checked in was what was in your working tree.

Of course you know: git-status will tell it.
This is no different to today, where you can commit while still leaving
a part of the tree dirty.

--=20
Martin Waitz

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFbw+Rj/Eaxd/oD7IRAuE8AJ9ncxexcOFELvdIurMZylYp3t+TKACfTt0I
5wBAELa3NnvtHhByFBH2hd0=
=+vHM
-----END PGP SIGNATURE-----

