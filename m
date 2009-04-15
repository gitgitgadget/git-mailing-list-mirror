From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 14 Apr 2009 22:53:17 -0700
Message-ID: <20090415T044931Z@curie.orbis-terrarum.net>
References: <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904141542161.6741@xanadu.home> <20090414T202206Z@curie.orbis-terrarum.net> <fcaeb9bf0904142009w5a21e483v7e98f91e5e35b14a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIHsHaVgx5AQzhyz"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 07:55:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lty5L-0003Xu-KN
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 07:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbZDOFxY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 01:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbZDOFxY
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 01:53:24 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:53771 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752201AbZDOFxY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 01:53:24 -0400
Received: (qmail 31540 invoked from network); 15 Apr 2009 05:53:21 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 15 Apr 2009 05:53:21 +0000
Received: (qmail 22842 invoked by uid 10000); 14 Apr 2009 22:53:17 -0700
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0904142009w5a21e483v7e98f91e5e35b14a@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116588>


--jIHsHaVgx5AQzhyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2009 at 01:09:43PM +1000, Nguyen Thai Ngoc Duy wrote:
> On Wed, Apr 15, 2009 at 6:27 AM, Robin H. Johnson <robbat2@gentoo.org> wr=
ote:
> > So, from the Gentoo side right now, we're looking at this:
> > 1. Setup git-bundle for initial downloads.
> > 2. Disallow initial clones over git:// (allow updates ONLY)
> How can you do that? If I understand git protocol correctly, there is
> no difference between a fetch request and a clone one.
I'm planning on adding a new hook, in upload-pack.
Inputs: want_obj, have_obj

Not sure of the best way to pass them yet, probably stdin, 'want ....',
'have ....'.

Probably best to run right before git-rev-list.

For the Gentoo-specific content of the hook, I'm after this design:
- you don't send ANY have =3D> you get the error
- you have is too old =3D> you get the error
- you ask for something non-existent =3D> you get the error

The error will be a message instructing you to use the bundle, and
pointing to a URL with detailed instructions.

The 'too old' case is to able better DoS prevention, stopping somebody
malicious from finding the first commit in the bundle, and pretending
they have it, asking for a pack from that to the HEAD.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--jIHsHaVgx5AQzhyz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknldk0ACgkQPpIsIjIzwiweWACg7X90o0ghVJ0EQx3xFqM1nHCb
Cz4AnidYxHzA95IBwhV+Ewx5DN0eNN7z
=LQds
-----END PGP SIGNATURE-----

--jIHsHaVgx5AQzhyz--
