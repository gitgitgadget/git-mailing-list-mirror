From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 25 May 2007 22:15:24 +0200
Message-ID: <20070525201524.GA4493@efreet.light.src>
References: <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src> <20070521211133.GD5412@admingilde.org> <20070522193706.GA4432@efreet.light.src> <20070524154833.GL5412@admingilde.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Cc: Junio C Hamano <junkio@cox.net>, skimo@liacs.nl,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri May 25 22:33:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrgT6-00012N-5M
	for gcvg-git@gmane.org; Fri, 25 May 2007 22:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbXEYUcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 16:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbXEYUcy
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 16:32:54 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:55696 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320AbXEYUcx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 16:32:53 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 61A52576DF;
	Fri, 25 May 2007 22:32:52 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HrgC4-0001ni-KC; Fri, 25 May 2007 22:15:24 +0200
Content-Disposition: inline
In-Reply-To: <20070524154833.GL5412@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48410>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 24, 2007 at 17:48:33 +0200, Martin Waitz wrote:
> On Tue, May 22, 2007 at 09:37:06PM +0200, Jan Hudec wrote:
> > > We don't have to move the entire subproject.git into the superproject,
> > > but we need to have all _referenced_ objects in the .git dir of the
> > > superproject.
> > >=20
> > > There are several possibilities to do so:
> > >=20
> > >  * move the entire .git dir
> > >  * move .git/objects
> > >  * explicitly copy all referenced objects
> >=20
> > I believe we really need entire .git dir. When the superporject checks =
out
> > revision which does not reference that subproject, we still need to pre=
serve
> > not only the objects of subproject, but also the refs and config.
>=20
> but all the other refs do not belong to the superproject.
> For those who are working on the subproject there are of course a lot
> of refs which they have to work with, but that can be dealt with
> outside of the superproject scope.  The subproject is still a normal
> Git repository, after all.
> That is, you can have remote entries, branches and what not.
> But all that is not interesting in the superproject scope.
>=20
> So I thing moving the entire subproject.git into the superproject.git is =
too
> much.  The superproject is only interested in the objects and in one
> ref -- the one stored inside its tree.

No, the way I mean it the subproject and superproject don't share a single
bit. The subproject.git dir is subdirectory of superproject.git, but has no
thing in common with it.

> > > I have some experimental code to configure a per-subproject directory
> > > in the superproject/.git as alternate object store for the submodule
> > > to make the last two solutions possible.  Perhaps I should dig it out=
 again
> > > and adapt it to current git.

Ah. My bad. Didn't notice this. I do NOT want to share any objects between
subproject and superproject. At least not unless the user explicitely asks
for that, which might make sense if the subproject was carved out of the
superproject.

> > > If there is a 1:1 relationship between subproject and object store th=
en
> > > even efficient fsck and repack/prune are possible for the submodule w=
ithout
> > > loosing objects.
> > > But such a 1:1 relationship is bad when you move subprojects to anoth=
er
> > > location (or include the same subproject several times in different
> > > locations of the tree).
> > > Perhaps the user should be able to choose which one he wants.
> >=20
> > That's why there should be the extra level of indirection using .gitmod=
ules.
> > It should map the directory name to the object store name, so you can
> > relocate the subproject.
> >=20
> > Including the same project several times is indeed interesting. Maybe t=
he
> > subprojects should be "light checkouts" (I believe something like this =
was
> > already discussed on the list sometime). Those would be .git dirs, that=
 would
> > only have HEAD and pointer to another .git dir with everything else.
>=20
> Well, even if they might share a lot of objects they might be included
> for completely different reasons and so might need to work with
> different communities (remote entries, branches, etc.).
>=20
> So sharing objects makes sense, sharing the rest of .git is not
> neccessary.

No, I didn't mean the subproject and superproject would share anything.
The case I talk about is if project foo has subdirs A and B and they both
contain (different revisions of) the same subproject. The .gitmodules
definition is:
    [submodule "A"]
    name=3Dbar
    [submodule "B"]
    name=3Dbar

In such case A/.git and B/.git can't both be symlinks to
=2Egit/subprojects/bar.git, because they have different HEAD, but everything
else should be defined by .git/subprojects/bar.git

> > > I think it will be _very_ common to store super and subprojects in
> > > related locations.  First to be independent from third-party servers
> > > while working on the superproject.
> > > Second (and I think more important) because many times there will
> > > be superproject related adaptations in the subproject.  Yes they
> > > are independent, and exactly for that reason the subproject upstream
> > > maintainers may not take every change which is needed to satisfy the
> > > superproject.  We _now_ see that in all Linux distributions already.
> > > So when you use superprojects to integrate several independent projec=
ts,
> > > then the superproject maintainer/administrator should really keep a
> > > clone of all subprojects handy on his site.
> >=20
> > Yes, repositories with distribution-specific patches will add a large c=
lass
> > of cases requiring multiple sources support.
>=20
> You don't really need multiple sources for it.
> The subproject contains both upstream and local changes, but I think

Upstream + local is not the interesting case. Multiple upstreams is.

> it makes sense to keep the entire object store local (the same way
> to keep all the entire history local even if you only want to add to it
> in a normal repository).  Those people who work on the subproject and
> communicate with its upstream developers of course need remote entries
> and have to synchronize the subproject with upstream.  But that is
> not related to the superproject at all.
>=20
> So yes, you have different sources but you don't need extra support
> in the subproject implementation for it.

Well, if the subproject is not auto-fetched, there's no need for extra
support. But if there is auto-fetch, it should be aware of possibility to
have multiple upstreams.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGV0PcRel1vVwhjGURAryOAJ418l6+OvvyuHfQfrVcdDy7ZrcSKgCgx9tN
kWiTOSWWhfRcYgz2yd3AM2I=
=my7/
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
