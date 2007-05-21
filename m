From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Mon, 21 May 2007 23:11:34 +0200
Message-ID: <20070521211133.GD5412@admingilde.org>
References: <11795163061588-git-send-email-skimo@liacs.nl> <20070518215312.GB10475@steel.home> <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net> <20070519130542.GR942MdfPADPa@greensroom.kotnet.org> <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net> <20070520155407.GC27087@efreet.light.src> <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net> <20070521165938.GA4118@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B7FF+pnjRCrp0ISR"
Cc: Junio C Hamano <junkio@cox.net>, skimo@liacs.nl,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 21 23:11:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqFAR-0002Mr-QR
	for gcvg-git@gmane.org; Mon, 21 May 2007 23:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755363AbXEUVLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 17:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756243AbXEUVLi
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 17:11:38 -0400
Received: from mail.admingilde.org ([213.95.32.147]:50936 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363AbXEUVLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 17:11:38 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HqFAE-0000AS-2E; Mon, 21 May 2007 23:11:34 +0200
Content-Disposition: inline
In-Reply-To: <20070521165938.GA4118@efreet.light.src>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48052>


--B7FF+pnjRCrp0ISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 06:59:38PM +0200, Jan Hudec wrote:
> Here is one possible idea:
>=20
> We could store the GIT_DIR of submodule within the GIT_DIR of the
> superproject instead of the submodule directory itself. So instead of:
>  /
>  /.git
>  /subdir
>  /subdir/.git
>=20
> There would be:
>  /
>  /.git
>  /subdir
>  /.git/submodules/submodule-name.git
>=20
> This would require changes to the logic how git finds GIT_DIR (which woul=
d be
> really deep change), but it would provide place to store the submodule da=
ta
> while the submodule is not being checked out.=20

I agree that we need something like that.

We don't have to move the entire subproject.git into the superproject,
but we need to have all _referenced_ objects in the .git dir of the
superproject.

There are several possibilities to do so:

 * move the entire .git dir
 * move .git/objects
 * explicitly copy all referenced objects

I have some experimental code to configure a per-subproject directory
in the superproject/.git as alternate object store for the submodule
to make the last two solutions possible.  Perhaps I should dig it out again
and adapt it to current git.

If there is a 1:1 relationship between subproject and object store then
even efficient fsck and repack/prune are possible for the submodule without
loosing objects.
But such a 1:1 relationship is bad when you move subprojects to another
location (or include the same subproject several times in different
locations of the tree).
Perhaps the user should be able to choose which one he wants.

> > Not at all.  There is no reason to believe that the case that
> > superproject and subproject come from related URLs is more
> > common.  One of the reasons to do a separated project
>=20
> I definitely don't think it's more common. But it's the harder case and it
> might happen. Generally it will happen if some people work on both the
> superproject and the subproject. Of course the argument is that than it
> should not be separate projects, but maybe the teams just partly overlap.

I think it will be _very_ common to store super and subprojects in
related locations.  First to be independent from third-party servers
while working on the superproject.
Second (and I think more important) because many times there will
be superproject related adaptations in the subproject.  Yes they
are independent, and exactly for that reason the subproject upstream
maintainers may not take every change which is needed to satisfy the
superproject.  We _now_ see that in all Linux distributions already.
So when you use superprojects to integrate several independent projects,
then the superproject maintainer/administrator should really keep a
clone of all subprojects handy on his site.

--=20
Martin Waitz

--B7FF+pnjRCrp0ISR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUgsFj/Eaxd/oD7IRAmfXAJ0Zs/bULL2SLdUaTbIqgFxS2F6gvwCfSke4
wTNyr0GVuv8RH2rLUuKVmlI=
=Tl1Z
-----END PGP SIGNATURE-----

--B7FF+pnjRCrp0ISR--
