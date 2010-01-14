From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Removal of post-upload-hook
Date: Thu, 14 Jan 2010 21:06:45 +0000
Message-ID: <20100114210645.GE16921@orbis-terrarum.net>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com>
 <20100114193607.GB25863@coredump.intra.peff.net>
 <20100114194107.GA20033@spearce.org>
 <20100114204305.GC26883@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZmZU9S7l/XJx5q9b"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:13:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVX0b-0003e3-0u
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 22:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501Ab0ANVNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 16:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997Ab0ANVNc
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 16:13:32 -0500
Received: from b01.ext.isohunt.com ([208.71.112.51]:53378 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753917Ab0ANVNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 16:13:32 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2010 16:13:32 EST
Received: (qmail 26083 invoked from network); 14 Jan 2010 21:06:47 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Thu, 14 Jan 2010 21:06:47 +0000
Received: (qmail 13857 invoked by uid 10000); 14 Jan 2010 21:06:45 -0000
Content-Disposition: inline
In-Reply-To: <20100114204305.GC26883@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137026>


--ZmZU9S7l/XJx5q9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2010 at 03:43:05PM -0500, Jeff King wrote:
> On Thu, Jan 14, 2010 at 11:41:07AM -0800, Shawn O. Pearce wrote:
>=20
> > > Because receive-pack runs as the user who is pushing, not as the
> > > repository owner. So by convincing you to push to my repository in a
> > > multi-user environment, I convince you to run some arbitrary code of
> > > mine.
> >=20
> > Uhhh, this was in fetch/upload-pack Peff, not push/receive-pack.
> >=20
> > Same issue though.
> Errr...yeah. Sorry for the confusion. But yes, it's the same mechanism,
> except that it is even easier to get people to pull from you (to get
> them to push, you first have to get them to write a worthwhile code
> contribution. ;) ).
post-update, post-receive, update, pre-receive would all be subject to
this problem as well if:
- the repo was group/world-writable
- the hook is untrusted

post-upload-pack just required group/world-readable and untrusted hook
code.

I'd like to lodge a complaint about the removal of the functionality. I
would have commented on the patch prior to this, but even searching I
didn't see it cross the list.

As a reasonable middle ground between the functionality and complete
removal, can we find a way just to only execute the potentially
dangerous hooks under known safe conditions or when explicitly requested
by the user.

Places where the hooks are safe:
- the hooks are known trusted AND not writable by the user/group.
  (e.g. "chown -R root:root hooks/").
- Systems where the users/groups do not have full shell access, just
  access to run Git itself. Eg gitosis, regular git+ssh:// w/ a
  restricted shell.

Upcoming use case:
For Gentoo's work on migrating to Git, we've been working on a
pre-upload-pack hook and script that can explicitly block the generation
of some packs.
Basically, unless you send a sufficiently recent 'have' line, you are
told to fetch a bundle via HTTP or rsync instead.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--ZmZU9S7l/XJx5q9b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAktPh2UACgkQPpIsIjIzwixijACg2KLBeUKrVa0FsUJnc8leQ53V
of4AoLUipRSyfS/MUSfx5F9+75/Sv4j/
=/p/g
-----END PGP SIGNATURE-----

--ZmZU9S7l/XJx5q9b--
