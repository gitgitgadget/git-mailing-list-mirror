From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 17:48:33 +0200
Message-ID: <20070524154833.GL5412@admingilde.org>
References: <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src> <20070521211133.GD5412@admingilde.org> <20070522193706.GA4432@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="py13wRIzy9nU46ee"
Cc: Junio C Hamano <junkio@cox.net>, skimo@liacs.nl,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu May 24 17:48:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrFYN-0000zz-PV
	for gcvg-git@gmane.org; Thu, 24 May 2007 17:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbXEXPsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 11:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbXEXPsi
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 11:48:38 -0400
Received: from mail.admingilde.org ([213.95.32.147]:34363 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbXEXPsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 11:48:37 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HrFYH-0002iI-KJ; Thu, 24 May 2007 17:48:33 +0200
Content-Disposition: inline
In-Reply-To: <20070522193706.GA4432@efreet.light.src>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48272>


--py13wRIzy9nU46ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2007 at 09:37:06PM +0200, Jan Hudec wrote:
> > We don't have to move the entire subproject.git into the superproject,
> > but we need to have all _referenced_ objects in the .git dir of the
> > superproject.
> >=20
> > There are several possibilities to do so:
> >=20
> >  * move the entire .git dir
> >  * move .git/objects
> >  * explicitly copy all referenced objects
>=20
> I believe we really need entire .git dir. When the superporject checks out
> revision which does not reference that subproject, we still need to prese=
rve
> not only the objects of subproject, but also the refs and config.

but all the other refs do not belong to the superproject.
For those who are working on the subproject there are of course a lot
of refs which they have to work with, but that can be dealt with
outside of the superproject scope.  The subproject is still a normal
Git repository, after all.
That is, you can have remote entries, branches and what not.
But all that is not interesting in the superproject scope.

So I thing moving the entire subproject.git into the superproject.git is too
much.  The superproject is only interested in the objects and in one
ref -- the one stored inside its tree.

> > I have some experimental code to configure a per-subproject directory
> > in the superproject/.git as alternate object store for the submodule
> > to make the last two solutions possible.  Perhaps I should dig it out a=
gain
> > and adapt it to current git.
> >=20
> > If there is a 1:1 relationship between subproject and object store then
> > even efficient fsck and repack/prune are possible for the submodule wit=
hout
> > loosing objects.
> > But such a 1:1 relationship is bad when you move subprojects to another
> > location (or include the same subproject several times in different
> > locations of the tree).
> > Perhaps the user should be able to choose which one he wants.
>=20
> That's why there should be the extra level of indirection using .gitmodul=
es.
> It should map the directory name to the object store name, so you can
> relocate the subproject.
>=20
> Including the same project several times is indeed interesting. Maybe the
> subprojects should be "light checkouts" (I believe something like this was
> already discussed on the list sometime). Those would be .git dirs, that w=
ould
> only have HEAD and pointer to another .git dir with everything else.

Well, even if they might share a lot of objects they might be included
for completely different reasons and so might need to work with
different communities (remote entries, branches, etc.).

So sharing objects makes sense, sharing the rest of .git is not
neccessary.

> > I think it will be _very_ common to store super and subprojects in
> > related locations.  First to be independent from third-party servers
> > while working on the superproject.
> > Second (and I think more important) because many times there will
> > be superproject related adaptations in the subproject.  Yes they
> > are independent, and exactly for that reason the subproject upstream
> > maintainers may not take every change which is needed to satisfy the
> > superproject.  We _now_ see that in all Linux distributions already.
> > So when you use superprojects to integrate several independent projects,
> > then the superproject maintainer/administrator should really keep a
> > clone of all subprojects handy on his site.
>=20
> Yes, repositories with distribution-specific patches will add a large cla=
ss
> of cases requiring multiple sources support.

You don't really need multiple sources for it.
The subproject contains both upstream and local changes, but I think
it makes sense to keep the entire object store local (the same way
to keep all the entire history local even if you only want to add to it
in a normal repository).  Those people who work on the subproject and
communicate with its upstream developers of course need remote entries
and have to synchronize the subproject with upstream.  But that is
not related to the superproject at all.

So yes, you have different sources but you don't need extra support
in the subproject implementation for it.

--=20
Martin Waitz

--py13wRIzy9nU46ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGVbPRj/Eaxd/oD7IRAgxFAJ9MyoqsFDqKjyxEv8+4r39rjp2nGgCfbeLr
wvCaI+28Fu5HQIDKrCdeQsk=
=ueMG
-----END PGP SIGNATURE-----

--py13wRIzy9nU46ee--
